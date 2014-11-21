.PHONY: pdf clean quick

NAME=main

pdf:
	-pdflatex  -interaction=nonstopmode ${NAME}
	makeglossaries ${NAME}
	makeindex ${NAME}
	bibtex ${NAME}
	pdflatex -interaction=nonstopmode ${NAME}
	pdflatex -interaction=nonstopmode ${NAME}

quick:
	pdflatex ${NAME}

kaimain:
	pdflatex "\def\user{kai}\input{main}"

kai:
	pdflatex kai

gregor:
	pdflatex gregor
	bibtex gregor
	pdflatex gregor
	pdflatex gregor

clean:
	-rm *.aux *.log *.bbl *.blg *.lof *.lot *.out *.toc *.glg *.glo *.gls *.idx *.ilg *.ind *.ist 

.PHONY: pdf bib clean veryclean tags wc

tags:
	-etags *.tex */*.tex */*/*.tex

wc:
	pdftotext ${NAME}.pdf
	wc ${NAME}.txt

localbib:
	bibexport.sh -a -o 0/tub.bib ../../shared-svn/documents/inputs/bib/vsp ../../shared-svn/documents/inputs/bib/kai ../../shared-svn/documents/inputs/bib/ref
	../../shared-svn/documents/inputs/bib/repair_bib.rb 0/tub.bib
