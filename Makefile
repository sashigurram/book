.PHONY: pdf clean quick veryclean kai kai.aux

NAME=main

pdf:
	-xelatex  -interaction=nonstopmode ${NAME}
	makeglossaries ${NAME}
	makeindex ${NAME}
	bibtex ${NAME}
	xelatex -interaction=nonstopmode ${NAME}
	xelatex -interaction=nonstopmode ${NAME}

quick:
	xelatex ${NAME}

kaimain:
	xelatex "\def\user{kai}\input{main}"

kai: kai.aux

kai.aux:
	xelatex kai
	xelatex kai

kaibib:
	xelatex kai
	makeindex kai
	bibtex kai
	xelatex kai
	xelatex kai

gregor:
	xelatex gregor
	bibtex gregor
	xelatex gregor
	xelatex gregor

clean:
	-rm *.aux *.log 

veryclean: clean
	-rm *.bbl *.blg *.lof *.lot *.out *.toc *.glg *.glo *.gls *.idx *.ilg *.ind *.ist 

.PHONY: pdf bib clean veryclean tags wc

tags:
	-etags *.tex */*.tex */*/*.tex

wc:
	pdftotext ${NAME}.pdf
	wc ${NAME}.txt

localbib:
	- bibexport.sh -a -o 0/tub.bib ../../shared-svn/documents/inputs/bib/vsp ../../shared-svn/documents/inputs/bib/kai ../../shared-svn/documents/inputs/bib/ref
	../../shared-svn/documents/inputs/bib/repair_bib.rb 0/tub.bib

spin:
	make pdf; while true; do inotifywait -r . $(shell find . -type l -xtype d -printf '%p/*\n') $(shell find . -type l -xtype f) -e CREATE,MODIFY,DELETE; make -j2 pdf; done


