PDF_CC := pdflatex
GLOSS_CC := makeglossaries

FILE := poster_PGAS_SC11

PDF:= pdf
MAKEGLOSS = makegloss

$(PDF): 
	$(PDF_CC) $(FILE).tex

$(MAKEGLOSS): 
	$(GLOSS_CC) $(FILE)

all:
	$(PDF_CC) $(FILE).tex
	$(GLOSS_CC) $(FILE)
	$(PDF_CC) $(FILE).tex
	$(GLOSS_CC) $(FILE)
	$(PDF_CC) $(FILE).tex
#glossary references it's self
clean: 
	find $(FILE)* ! -name $(FILE).tex -delete
