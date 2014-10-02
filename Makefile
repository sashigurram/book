.PHONY: pdf clean

NAME=main

pdf:
	pdflatex -interaction=nonstopmode ${NAME}
	makeglossaries ${NAME}
	makeindex ${NAME}
	-bibtex ${NAME}
	pdflatex -interaction=nonstopmode ${NAME}
	pdflatex -interaction=nonstopmode ${NAME}

clean:
	-rm *.aux *.log *.bbl *.blg *.lof *.lot *.out *.toc *.glg *.glo *.gls *.idx *.ilg *.ind *.ist 
