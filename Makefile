.PHONY: all clean pdf html docx lint install

all: pdf html

pdf: bylaws.md
	pandoc bylaws.md --to=latex -o bylaws.pdf -N --table-of-contents \
		--template=templates/template.latex \
		--include-in-header=templates/header.tex \
		--include-before-body=templates/before.tex \
		--include-after-body=templates/after.tex

html: bylaws.md
	pandoc bylaws.md --to=html -o bylaws.html --table-of-contents \
		--template=templates/template.html

docx: bylaws.md
	pandoc bylaws.md --to=docx -o bylaws.docx --table-of-contents

compile:
	echo "Not implemented yet"

lint:
#	echo 'Potential Misspellings:'
#	for f in bylaws.md ; do
#		echo $f ; aspell --add-extra-dicts=./templates/dictionary.en.pws list < $f | sort | uniq -c
#	done
#	echo ''

	echo 'Non-ASCII characters:'
	pcregrep --color='auto' -n "[\x80-\xFF]" bylaws.md
	echo ''

	echo 'Trailing whitespace:'
	grep -Hn '[[:blank:]]$' bylaws.md

#clean:
#	rm bylaws.pdf bylaws.html bylaws.docx

install:
	apt-get install make aspell pcregrep pandoc texlive-latex-base texlive-latex-recommended texlive-latex-extra
