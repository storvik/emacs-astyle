# astyle.el

[![MELPA](https://melpa.org/packages/astyle-badge.svg)](https://melpa.org/#/astyle)
[![CI](https://github.com/storvik/emacs-astyle/workflows/CI/badge.svg)](https://github.com/storvik/emacs-astyle/actions)

Emacs library that provides functions to easily reformat C code using [astyle](http://astyle.sourceforge.net/astyle.html).
This library leverages [reformatter.el](https://github.com/purcell/reformatter.el) which makes working with formatters a breeze.

## Installation

Typical installation using [use-package](https://github.com/jwiegley/use-package) looks like this:

``` emacs-lisp
(use-package astyle
  :ensure t
  :when (executable-find "astyle")
  :hook (c-mode-common . astyle-on-save-mode))
```

`c-mode-common-hook` is used to enable format on save functionality.

## Usage

Formatting can be invoked by running either `astyle-buffer` or `astyle-region`.
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
