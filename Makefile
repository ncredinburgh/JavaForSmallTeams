IMGDIR = generated/images

# svgs to be converted to png 
SVGS := $(patsubst %.svg,$(IMGDIR)/%.png,$(wildcard svg/*.svg))


# one rule to make them all
all : main

main : $(SVGS) tocs cover back
	gitbook pdf

# convert svg to png not using -D so exports the page
$(IMGDIR)/%.png : %.svg
	inkscape --export-png $@ $<

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

clean :
	rm $(SVGS)
	rm generated/toc/*.md
	rm back.png
	rm cover.png
	rm book.pdf

rebuild : clean all
