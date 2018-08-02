.PHONY: all clean

LATEX    :=$(wildcard *.tex)
PDF      :=$(patsubst %.tex,%.pdf, $(LATEX))
DAT      :=$(patsubst %.tex,%.dat, $(LATEX))
MARKDOWN :=$(patsubst %.tex,%.markdown,  $(LATEX))
PNG      :=$(patsubst %.pdf,%.png, $(PDF))
ZIP      :=simple.zip

all : final-question.md $(PNG) $(MOREPNG) $(PDF) $(MARKDOWN)
	xsel -b < final-question.md

%.pdf : %.tex
	latexmk -pdf -pdflatex="pdflatex -interaction=nonstopmode" -use-make $<

%.markdown : %.tex
	sed 's/^/    /' $< > $@

lcc_indented.txt : lcc.txt
	sed 's/^/    /' $< > $@

%.png : %.pdf Makefile
	convert -trim -background white -alpha remove -density 300 $< -quality 90 $@
	mogrify -bordercolor white -border 10x10 -background white $@

final-question.md : question.md $(MARKDOWN) lcc_indented.txt
	m4 $< > $@

$(ZIP) : Makefile $(LATEX) .gitignore
	zip $@ $^

clean :
	latexmk -C
	rm -f -- $(ZIP) $(PNG) $(MARKDOWN) $(DAT) final-question.md
