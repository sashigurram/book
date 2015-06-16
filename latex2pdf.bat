xelatex main
bibtex main -min-crossrefs=99
makeglossaries main
xelatex main
bibtex main -min-crossrefs=99
makeglossaries main
makeindex main
xelatex main
xelatex main

