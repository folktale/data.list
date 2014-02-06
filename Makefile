bin        = $(shell npm bin)
lsc        = $(bin)/lsc
browserify = $(bin)/browserify
doxx       = $(bin)/doxx
uglify     = $(bin)/uglifyjs
VERSION    = $(shell node -e 'console.log(require("./package.json").version)')


lib: src/*.ls
	$(lsc) -o lib -c src/*.ls

dist:
	mkdir -p dist

dist/data.list.umd.js: compile dist
	$(browserify) lib/index.js --standalone folktale.data.List > $@

dist/data.list.umd.min.js: dist/data.list.umd.js
	$(uglify) --mangle - < $^ > $@

# ----------------------------------------------------------------------
bundle: dist/data.list.umd.js

minify: dist/data.list.umd.min.js

compile: lib

documentation: compile
	$(doxx) --source lib  \
	        --target docs

clean:
	rm -rf dist build lib

test:
	$(lsc) test/tap.ls

package: compile documentation bundle minify
	mkdir -p dist/data.list-$(VERSION)
	cp -r docs/literate dist/data.list-$(VERSION)/docs
	cp -r lib dist/data.list-$(VERSION)
	cp dist/*.js dist/data.list-$(VERSION)
	cp package.json dist/data.list-$(VERSION)
	cp README.md dist/data.list-$(VERSION)
	cp LICENCE dist/data.list-$(VERSION)
	cd dist && tar -czf data.list-$(VERSION).tar.gz data.list-$(VERSION)

publish: clean
	npm install
	npm publish

bump:
	node tools/bump-version.js $$VERSION_BUMP

bump-feature:
	VERSION_BUMP=FEATURE $(MAKE) bump

bump-major:
	VERSION_BUMP=MAJOR $(MAKE) bump

.PHONY: test bump bump-feature bump-major publish package clean documentation
