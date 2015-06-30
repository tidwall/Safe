package main

import (
	"bytes"
	"io/ioutil"
	"log"
	"strings"
)

const templatePath = "atomic-template.swift"
const destinationPath = "../Source/atomic.swift"

func main() {
	b, err := ioutil.ReadFile(templatePath)
	if err != nil {
		log.Fatal(err.Error())
	}

	boolTypes := []string{"Bool"}
	stringTypes := []string{"String"}
	signedTypes := []string{"Int", "Int64", "Int32", "Int16", "Int8"}
	unsignedTypes := []string{"UInt", "UInt64", "UInt32", "UInt16", "UInt8"}
	floatTypes := []string{"Double", "Float", "Float80"}
	numberTypes := append(append(signedTypes, unsignedTypes...), floatTypes...)
	allTypes := append(append(numberTypes, boolTypes...), stringTypes...)

	// parse
	templates := make(map[string]string)
	tparts := strings.Split(string(b), "// TEMPLATE:")
	templates["base"] = strings.TrimSpace(tparts[0])
	tparts = tparts[1:]
	for _, tpart := range tparts {
		var idx = strings.Index(tpart, "\n")
		var title = strings.TrimSpace(tpart[:idx])
		templates[title] = strings.TrimSpace(tpart[idx+1:])
	}

	repl := func(key string, op string, t string) string {
		s := templates[key]
		s = strings.Replace(s, "{{O}}", op, -1)
		s = strings.Replace(s, "{{T}}", t, -1)

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
		return s
	}

	source := templates["base"] + "\n\n"

	// typealias
	for _, t := range allTypes {
		source += repl("typealias", t+"A", t) + "\n"
	}
	source += "\n"

	// initialize
	for _, t := range allTypes {
		source += repl("initialize-head", "", t) + "\n"
		source += "\t" + repl("initialize-body", t, t) + "\n"
		for _, it := range numberTypes {
			if t == it {
				for _, ot := range numberTypes {
					if ot != t {
						source += "\t" + repl("initialize-body", ot, t) + "\n"
					}
				}
				break
			}
		}
		source += repl("initialize-foot", "", t) + "\n"
	}
	source += "\n"

	// arithmetic
	for _, op := range []string{"+", "-", "*", "/", "%"} {
		for _, t := range append(append(signedTypes, unsignedTypes...), floatTypes...) {
			source += repl("arithmetic", op, t) + "\n"
		}
	}
	for _, op := range []string{"<<", ">>", "^", "&", "&+", "&-", "&*"} {
		for _, t := range append(signedTypes, unsignedTypes...) {
			source += repl("arithmetic", op, t) + "\n"
		}
	}
	for _, op := range []string{"+"} {
		for _, t := range stringTypes {
			source += repl("arithmetic", op, t) + "\n"
		}
	}

	// prefix
	for _, op := range []string{"++", "--"} {
		for _, t := range append(append(signedTypes, unsignedTypes...), floatTypes...) {
			source += repl("prefix", op, t) + "\n"
		}
	}
	for _, op := range []string{"+", "-"} {
		for _, t := range append(signedTypes, floatTypes...) {
			source += repl("prefix", op, t) + "\n"
		}
	}
	for _, op := range []string{"~"} {
		for _, t := range signedTypes {
			source += repl("prefix", op, t) + "\n"
		}
	}

	// postfix
	for _, op := range []string{"++", "--"} {
		for _, t := range append(append(signedTypes, unsignedTypes...), floatTypes...) {
			source += repl("postfix", op, t) + "\n"
		}
	}

	// modify
	for _, op := range []string{"+=", "-=", "*=", "/=", "%="} {
		for _, t := range append(append(signedTypes, unsignedTypes...), floatTypes...) {
			source += repl("modify", op, t) + "\n"
		}
	}
	for _, op := range []string{"+="} {
		for _, t := range stringTypes {
			source += repl("modify", op, t) + "\n"
		}
	}
	for _, op := range []string{"<<=", ">>=", "^=", "&="} {
		for _, t := range append(signedTypes, unsignedTypes...) {
			source += repl("modify", op, t) + "\n"
		}
	}

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
