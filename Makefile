.DELETE_ON_ERROR:
.SECONDARY:

all: assembly-slides.html

clean:
	rm -f assembly-slides.html

# Render Markdown to HTML
%.html: %.md
	pandoc -sSt revealjs -Vtheme:sky -o $@ $<

# Download reveal.js
revealjs-3.3.0.tar.gz:
	curl -L -o $@ https://github.com/hakimel/reveal.js/archive/3.3.0.tar.gz

# Extract reveal.js
reveal.js-3.3.0/js/reveal.js: revealjs-3.3.0.tar.gz
	tar xf $<
	touch $@

# Patch reveal.js
# Use normal case rather than upper case for slide titles.
reveal.js/js/reveal.js: reveal.js-3.3.0/js/reveal.js
	mkdir -p reveal.js
	cp -a reveal.js-3.3.0/* reveal.js/
	sed -i '' -e 's/text-transform: uppercase;//;s/3.77em/2.11em/' reveal.js/css/theme/sky.css

# Dependencies
assembly-slides.html: reveal.js/js/reveal.js
