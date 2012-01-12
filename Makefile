DIRS= `find -maxdepth 1  -type d ! -wholename \*.svn\* | grep /`
PDF = $(addsuffix .pdf, $(basename $(wildcard *.eps)))

show: all

all: $(PDF) $(GNUPLOT) $(INKSCAPE) 
	pdflatex --halt-on-error --output-directory=./tmp ./reader.tex
	pdflatex --halt-on-error --output-directory=./tmp ./reader.tex
	mv ./tmp/reader.pdf .

evince:
	pdflatex --halt-on-error --output-directory=./tmp ./reader.tex
	pdflatex --halt-on-error --output-directory=./tmp ./reader.tex
	mv ./tmp/reader.pdf .
	evince reader.pdf &> /dev/null

okular:
	pdflatex --halt-on-error --output-directory=./tmp ./reader.tex
	pdflatex --halt-on-error --output-directory=./tmp ./reader.tex
	mv ./tmp/reader.pdf .
	okular ./reader.pdf 2> /dev/null

prepare:
	mkdir tmp

%.pdf: %.eps
	epstopdf $(basename $@).eps

clean:
	-rm -f ./tmp/*~ ./tmp/*.bak ./tmp/*.aux ./tmp/*.log ./tmp/*.toc ./tmp/*.out ./tmp/*.nav ./tmp/*.snm ./tmp/*.bbl ./tmp/*.blg
	-rm -f ./tmp/*.pdf
	-rm -f *.pdf

all-evince: show
