IMGDIR = generated/images

# svgs to be converted to png
SVGS := $(patsubst %.svg,$(IMGDIR)/%.png,$(wildcard svg/*.svg))

hash := $(shell git rev-parse HEAD)

# one rule to make them all
all : main

main : $(SVGS) cover back
	gitbook pdf

# convert svg to png not using -D so exports the page
$(IMGDIR)/%.png : %.svg
	inkscape --export-dpi=300 --export-png $@ $<

# no longer performed as part of build, but can be used to create toc markdown
tocs :
	./toc.sh style
	./toc.sh process
	./toc.sh specifics
	./toc.sh tests
	./toc.sh badadvice

cover :
	inkscape --export-png cover.png cover.svg
	convert cover.png  -background white -flatten cover.jpg

back :
	inkscape --export-png back.png back.svg
	convert back.png -background white -flatten back.jpg

inner :
	inkscape inner.svg --export-pdf=inner.pdf

publish : inner
	mkdir -p printing
	curl https://www.gitbook.com/download/pdf/book/ncrcoe/java-for-small-teams/v/${hash} > printing/rendered.pdf
	pdftk A=printing/rendered.pdf B=inner.pdf C=blank.pdf cat A1 B1 C1 A2-end output printing/epubli_version.pdf
	pdfjam --outfile printing/resized.pdf --papersize '{6.0in,9.0in}'  printing/rendered.pdf
	pdfjam --outfile printing/inner_resized.pdf --papersize '{6.0in,9.0in}'  inner.pdf
	pdfjam --outfile printing/blank_resized.pdf --papersize '{6.0in,9.0in}'  blank.pdf
	pdftk A=printing/resized.pdf B=printing/inner_resized.pdf C=printing/blank_resized.pdf cat B1 C1 A2-end output printing/create_space_version.pdf

clean :
	rm $(SVGS)
	rm back.png
	rm cover.png
	rm book.pdf

rebuild : clean all
