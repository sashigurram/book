@ECHO OFF
REM Creates PDFs out of all eps files in the current directory.
REM Crops white borders off from the created PDFs.
REM uses epstopdf and pdfcrop that are part of miktex

for /f %%a IN ('dir /b *.eps') do call epstopdf %%a

for /f %%a IN ('dir /b *.pdf') do call pdfcrop %%a %%a