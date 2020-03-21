# astyle.el

[![CI](https://github.com/storvik/emacs-astyle/workflows/CI/badge.svg)](https://github.com/storvik/emacs-astyle/actions)

Emacs library that provides functions to easily reformat C code using [astyle](http://astyle.sourceforge.net/astyle.html).
This library leverages [reformatter.el](https://github.com/purcell/reformatter.el) which makes working with formatters a breeze.

## Installation

Todo

## Usage

Formatting can be invoked by running either `astyle-format-buffer` or `astyle-format-region`.
If astyle configuration file is found (customize file name bu editing variable `astyle-default-rc-name`) it will be prefered.
If no configuration file is found either `astyle-custom-args` or `astyle-default-args` is used

There are two ways of enabling format on save functionality.
Either enable `astyle-format-on-save` in mode hook or place the following in your project `.dir-locals.el`:

``` emacs-lisp
((c-mode
   (mode . astyle-format-on-save)))
```

## Features

- Easily customizable with sane defaults.
- Uses `c-basic-offset` for indent.
- Will prefere `.astylerc` configuration file if present in parent dirs.
