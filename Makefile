#
# Makefile for Thesis
#
# Author: Yasunori Yusa
#

TEX    = platex
DVIPDF = dvipdfmx

TEXFLAGS    = -file-line-error -shell-escape -kanji=utf8
DVIPDFFLAGS =

SOURCE  = main.tex chapter1.tex chapter2.tex chapter3.tex chapter4.tex chapter5.tex chapter6.tex acknowledgments.tex references.tex blank.tex
JOBNAME = thesis
TARGET  = $(JOBNAME).pdf

########################################

.SUFFIXES: .pdf .dvi .tex

.PHONY: all clean

all: $(TARGET)

$(TARGET): $(JOBNAME).dvi
	$(DVIPDF) $(DVIPDFFLAGS) -o $@ $<

$(JOBNAME).dvi: $(SOURCE)
	$(TEX) $(TEXFLAGS) -jobname=$* $<
	while grep '^LaTeX Warning: Label(s) may have changed.' $*.log > /dev/null; \
	do \
		$(TEX) $(TEXFLAGS) -jobname=$* $<; \
	done

clean:
	rm -f $(TARGET) $(JOBNAME).dvi
	rm -f $(JOBNAME).aux $(JOBNAME).log $(JOBNAME).out
	rm -f $(JOBNAME).toc $(JOBNAME).lof $(JOBNAME).lot
	rm -f $(SOURCE:%.tex=%.aux)
