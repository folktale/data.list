data.list
=========

[![Build Status](https://secure.travis-ci.org/folktale/data.list.png?branch=master)](https://travis-ci.org/folktale/data.list)
[![NPM version](https://badge.fury.io/js/data.list.png)](http://badge.fury.io/js/data.list)
[![Dependencies Status](https://david-dm.org/folktale/data.list.png)](https://david-dm.org/folktale/data.list)
[![experimental](http://hughsk.github.io/stability-badges/dist/experimental.svg)](http://github.com/hughsk/stability-badges)


Immutable list


## Example

```js
( ... )
```


## Installing

The easiest way is to grab it from NPM. If you're running in a Browser
environment, you can use [Browserify][]

    $ npm install data.list


### Using with CommonJS

If you're not using NPM, [Download the latest release][release], and require
the `data.list.umd.js` file:

```js
var List = require('data.list')
```


### Using with AMD

[Download the latest release][release], and require the `data.list.umd.js`
file:

```js
require(['data.list'], function(List) {
  ( ... )
})
```


### Using without modules

[Download the latest release][release], and load the `data.list.umd.js`
file. The properties are exposed in the global `folktale.data.List` object:

```html
<script src="/path/to/data.list.umd.js"></script>
```


### Compiling from source

If you want to compile this library from the source, you'll need [Git][],
[Make][], [Node.js][], and run the following commands:

    $ git clone git://github.com/folktale/data.list.git
    $ cd data.list
    $ npm install
    $ make bundle
    
This will generate the `dist/data.list.umd.js` file, which you can load in
any JavaScript environment.

    
## Documentation

You can [read the documentation online][docs] or build it yourself:

    $ git clone git://github.com/folktale/data.list.git
    $ cd data.list
    $ npm install
    $ make documentation

Then open the file `docs/literate/index.html` in your browser.


## Platform support

This library assumes an ES5 environment, but can be easily supported in ES3
platforms by the use of shims. Just include [es5-shim][] :)


## Licence

Copyright (c) 2013 Quildreen Motta.

Released under the [MIT licence](https://github.com/folktale/data.list/blob/master/LICENCE).

<!-- links -->
[Fantasy Land]: https://github.com/fantasyland/fantasy-land
[Browserify]: http://browserify.org/
[Git]: http://git-scm.com/
[Make]: http://www.gnu.org/software/make/
[Node.js]: http://nodejs.org/
[es5-shim]: https://github.com/kriskowal/es5-shim
[docs]: http://folktale.github.io/data.list
<!-- [release: https://github.com/folktale/data.list/releases/download/v$VERSION/data.list-$VERSION.tar.gz] -->
[release]: https://github.com/folktale/data.list/releases/download/v0.0.0/data.list-0.0.0.tar.gz
<!-- [/release] -->
