package main

import (
	"bytes"
	"io/ioutil"
	"log"
	"strings"
)

func main() {
	process("atomic-template.swift", "../Source/atomic.swift")
	process("atomic-test-template.swift", "../Tests/atomic-test.swift")
}

func contains(arr []string, str string) bool {
	for _, v := range arr {
		if v == str {
			return true
		}
	}
	return false
}

var boolTypes = []string{"Bool"}
var stringTypes = []string{"String"}
var signedTypes = []string{"Int", "Int64", "Int32", "Int16", "Int8"}
var unsignedTypes = []string{"UInt", "UInt64", "UInt32", "UInt16", "UInt8"}
var floatTypes = []string{"Double", "Float"}
var numberTypes = append(append(signedTypes, unsignedTypes...), floatTypes...)
var allTypes = append(append(numberTypes, boolTypes...), stringTypes...)

func isBool(t string) bool     { return contains(boolTypes, t) }
func isString(t string) bool   { return contains(stringTypes, t) }
func isSigned(t string) bool   { return contains(signedTypes, t) }
func isUnsigned(t string) bool { return contains(unsignedTypes, t) }
func isFloat(t string) bool    { return contains(floatTypes, t) }
func isNumber(t string) bool   { return contains(numberTypes, t) }

func repl(s string, k string, v string) string {
	return strings.Replace(s, "{{"+k+"}}", v, -1)
}
func repls(s string, m map[string]string) string {
	for k, v := range m {
		s = repl(s, k, v)
	}
	return s
}

func supwarns(source string) string {

	replblock := func(key string) {
		var idx int
		for {
			idx = strings.Index(source, key)
			if idx == -1 {
				break
			}
			sidx := strings.LastIndex(source[:idx], "do {")
			if sidx == -1 {
				break
			}
			eidx := strings.IndexAny(source[sidx:], "}")
			if eidx == -1 {
				break
			}
			source = source[:sidx] + source[sidx+eidx+1:]
		}
	}

	source = strings.Replace(source, `let result = ++x.value;`, `let result = x.value; x.value += 1;`, -1)
	source = strings.Replace(source, `let result = --x.value;`, `let result = x.value; x.value -= 1;`, -1)
	source = strings.Replace(source, `let result = x.value++;`, `x.value += 1; let result = x.value;`, -1)
	source = strings.Replace(source, `let result = x.value--;`, `x.value -= 1; let result = x.value;`, -1)
	replblock(`++n`)
	replblock(`n++`)
	replblock(`--n`)
	replblock(`n--`)

	return source
}

func process(templatePath string, destinationPath string) {
	b, err := ioutil.ReadFile(templatePath)
	if err != nil {
		log.Fatal(err.Error())
	}

	// parse
	templates := make(map[string]string)
	tparts := strings.Split(string(b), "// TEMPLATE:")
	templates["base"] = strings.TrimSpace(tparts[0])
	tparts = tparts[1:]
	for _, tpart := range tparts {
		var idx = strings.Index(tpart, "\n")
		var title = strings.TrimSpace(tpart[:idx])
		templates[title] = strings.Trim(tpart[idx+1:], "\n")
	}
	replt := func(key string, m map[string]string) string {
		s := repls(templates[key], m)
		op := m["O"]
		t := m["T"]
		if op != t+"A" {
			for {
				idx := strings.Index(s, "Atomic<")
				if idx == -1 {
					break
				}
				idxe := strings.Index(s[idx:], ">") + idx
				s = s[:idx] + s[idx+7:idxe] + "A" + s[idxe+1:]
			}
		}
		if s != "" {
			s += "\n"
		}
		return s
	}

	source := templates["base"] + "\n\n"

	// typealias
	for _, t := range allTypes {
		source += replt("typealias", map[string]string{"O": t + "A", "T": t})
	}
	source += "\n"

	// initialize
	for _, t := range allTypes {
		source += replt("initialize-head", map[string]string{"O": "", "T": t})
		source += "\t" + replt("initialize-body", map[string]string{"O": t, "T": t})
		for _, it := range numberTypes {
			if t == it {
				for _, ot := range numberTypes {
					if ot != t {
						source += "\t" + replt("initialize-body", map[string]string{"O": ot, "T": t})
					}
				}
				break
			}
		}
		source += replt("initialize-foot", map[string]string{"O": "", "T": t})
	}
	source += "\n"

	// arithmetic
	for _, op := range []string{"+", "-", "*", "/", "%"} {
		for _, t := range append(append(signedTypes, unsignedTypes...), floatTypes...) {
			source += replt("arithmetic", map[string]string{"O": op, "T": t})
		}
	}
	for _, op := range []string{"<<", ">>", "^", "&", "&+", "&-", "&*"} {
		for _, t := range append(signedTypes, unsignedTypes...) {
			source += replt("arithmetic", map[string]string{"O": op, "T": t})
		}
	}
	for _, op := range []string{"+"} {
		for _, t := range stringTypes {
			source += replt("arithmetic", map[string]string{"O": op, "T": t})
		}
	}

	// prefix
	for _, op := range []string{"++", "--"} {
		for _, t := range append(append(signedTypes, unsignedTypes...), floatTypes...) {
			source += replt("prefix", map[string]string{"O": op, "T": t})
		}
	}
	for _, op := range []string{"+", "-"} {
		for _, t := range append(signedTypes, floatTypes...) {
			source += replt("prefix", map[string]string{"O": op, "T": t})
		}
	}
	for _, op := range []string{"~"} {
		for _, t := range signedTypes {
			source += replt("prefix", map[string]string{"O": op, "T": t})
		}
	}

	// postfix
	for _, op := range []string{"++", "--"} {
		for _, t := range append(append(signedTypes, unsignedTypes...), floatTypes...) {
			source += replt("postfix", map[string]string{"O": op, "T": t})
		}
	}

	// modify
	for _, op := range []string{"+=", "-=", "*=", "/=", "%="} {
		for _, t := range append(append(signedTypes, unsignedTypes...), floatTypes...) {
			source += replt("modify", map[string]string{"O": op, "T": t})
		}
	}
	for _, op := range []string{"+="} {
		for _, t := range stringTypes {
			source += replt("modify", map[string]string{"O": op, "T": t})
		}
	}
	for _, op := range []string{"<<=", ">>=", "^=", "&="} {
		for _, t := range append(signedTypes, unsignedTypes...) {
			source += replt("modify", map[string]string{"O": op, "T": t})
		}
	}

	////////////////////////////////////////////////////
	// test
	for _, t := range allTypes {

		var def = ""
		var del = ""
		if isNumber(t) {
			def = "0"
		} else if isString(t) {
			def = "\"\""
			del = "\""
		} else if isBool(t) {
			def = "false"
		}
		template := templates["Test"]

		content := ""

		// arithmetic
		if isNumber(t) {
			for _, op := range []string{"+", "-", "*", "/", "%"} {
				content += repl(templates["Operator['join']"], ".Op", op) + "\n"
			}
		}
		if isSigned(t) || isUnsigned(t) {
			for _, op := range []string{"<<", ">>", "^", "&", "&+", "&-", "&*"} {
				content += repl(templates["Operator['join']"], ".Op", op) + "\n"
			}
		}
		if isString(t) {
			for _, op := range []string{"+"} {
				content += repl(templates["Operator['join']"], ".Op", op) + "\n"
			}
		}

		// prefix
		if isNumber(t) {
			for _, op := range []string{"++", "--"} {
				content += repl(templates["Operator['prefix']"], ".Op", op) + "\n"
			}
		}
		if isSigned(t) || isFloat(t) {
			for _, op := range []string{"+", "-"} {
				content += repl(templates["Operator['prefix-assign']"], ".Op", op) + "\n"
			}
		}
		if isSigned(t) {
			for _, op := range []string{"~"} {
				content += repl(templates["Operator['prefix-assign']"], ".Op", op) + "\n"
			}
		}

		// postfix
		if isNumber(t) {
			for _, op := range []string{"++", "--"} {
				content += repl(templates["Operator['postfix']"], ".Op", op) + "\n"
			}
		}

		//modify
		if isNumber(t) {
			for _, op := range []string{"+=", "-=", "*=", "/=", "%="} {
				content += repl(templates["Operator['modify']"], ".Op", op) + "\n"
			}
		}
		if isString(t) {
			for _, op := range []string{"+="} {
				content += repl(templates["Operator['modify']"], ".Op", op) + "\n"
			}
		}
		if isSigned(t) || isUnsigned(t) {
			for _, op := range []string{"<<=", ">>=", "^=", "&="} {
				content += repl(templates["Operator['modify']"], ".Op", op) + "\n"
			}
		}
		template = repl(template, ".Content", content)
		for strings.Contains(template, "{{") {
			template = repl(template, ".Assert", templates["Assert"])
			template = repl(template, ".InitVars", templates["InitVars"])
			template = repl(template, ".Type", t)
			template = repl(template, ".Default", def)
			template = repl(template, ".Del", del)
		}
		source += template + "\n"
	}

	// `--` and `++` postfix and prefix are deprecated. make minor update to contents to suppress the
	// warnings that Swift raises.

	source = supwarns(source)

	////////////////////////////////////////////////////
	match := false
	sourceb := []byte(source)
	destb, err := ioutil.ReadFile(destinationPath)
	if err == nil {
		match = bytes.Compare(destb, sourceb) == 0
	}
	if !match {
		err = ioutil.WriteFile(destinationPath, sourceb, 0666)
		if err != nil {
			log.Fatal(err.Error())
		}
	}

}
