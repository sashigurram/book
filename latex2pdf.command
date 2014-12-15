pdflatex ./main
bibtex ./main
makeglossaries ./main
pdflatex ./main
bibtex ./main
makeglossaries ./main
makeindex ./main
pdflatex ./main
pdflatex ./main

