.PHONY: pdf newpdf clean quick veryclean kai kai.aux

NAME=main

newpdf:
	-xelatex  -interaction=nonstopmode ${NAME}
	makeglossaries ${NAME}
	makeindex ${NAME}
	bibtex -min-crossrefs=999 ${NAME}
	xelatex -interaction=nonstopmode ${NAME}
	xelatex -interaction=nonstopmode ${NAME}

pdf:
	-pdflatex  -interaction=nonstopmode ${NAME}
	makeglossaries ${NAME}
	makeindex ${NAME}
	bibtex -min-crossrefs=999 ${NAME}
	pdflatex -interaction=nonstopmode ${NAME}
	pdflatex -interaction=nonstopmode ${NAME}

quick:
	xelatex ${NAME}

kaimain:
	pdflatex "\def\user{kai}\input{main}"

kai: kai.aux

kai.aux: localbib
	pdflatex kai

#	pdflatex -interaction=nonstopmode kai


kaibib: kai.aux
	makeglossaries kai
	makeindex kai
	bibtex -min-crossrefs=999 kai
	pdflatex kai
	pdflatex kai

gregor:
	pdflatex gregor
	bibtex -min-crossrefs=999 gregor
	pdflatex gregor
	pdflatex gregor

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
	- sh ./bibexport.sh -a -o 0/tmp.bib ../../shared-svn/documents/inputs/bib/vsp ../../shared-svn/documents/inputs/bib/kai ../../shared-svn/documents/inputs/bib/ref
	../../shared-svn/documents/inputs/bib/repair_bib.rb 0/tmp.bib
	sed -f 0/tub-bib.sed 0/tmp.bib > 0/tub.bib
	git co -- 0/ivt_bibs.bib
	sed -f 0/ivt_bibs.sed 0/ivt_bibs.bib > 0/ivttmp.bib; rm 0/ivt_bibs.bib
	mv 0/ivttmp.bib 0/ivt_bibs.bib

	#sed 's/ Nagel/ \\hl\{Nagel\}/' 0/tmp2.bib > 0/tub.bib


spin:
	make pdf; while true; do inotifywait -r . $(shell find . -type l -xtype d -printf '%p/*\n') $(shell find . -type l -xtype f) -e CREATE,MODIFY,DELETE; make -j2 pdf; done


