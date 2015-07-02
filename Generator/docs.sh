#!/bin/bash
cd $(dirname "${BASH_SOURCE[0]}")
cd ..
jazzy -g https://github.com/tidwall/Safe --skip-undocumented -a "Josh Baker" -m "Safe" -u "http://github.com/tidwall"

echo ".nav-group-name a[href=\"Extensions.html\"] { display: none; }" >> docs/css/jazzy.css
echo ".nav-group-name a[href=\"Extensions.html\"] ~ ul { display: none; }" >> docs/css/jazzy.css
printf "%s(\".nav-group-name a[href='Extensions.html']\").parent().hide()\n" "$" >> docs/js/jazzy.js
printf "%s(\".nav-group-name a[href='../Extensions.html']\").parent().hide()\n" "$" >> docs/js/jazzy.js
printf "%s(\"header .content-wrapper a[href='index.html']\").parent().html(\"<a href='index.html'>Safe Docs</a>\")\n" "$" >> docs/js/jazzy.js
