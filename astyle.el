;;; astyle.el --- Astyle formatter functions -*- lexical-binding: t -*-

;; Copyright © 2020

;; Author: Petter Storvik
;; URL: https://github.com/storvik/emacs-astyle
;; Version: 0.1.0
;; Created: 2019-03-16
;; Package-Requires: ((emacs "24.4") (reformatter "0.3"))
;; Keywords: astyle c c++ cpp reformatter
;; URL: https://github.com/storvik/emacs-astyle

;; This file is NOT part of GNU Emacs.

;;; License:

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; For a full copy of the GNU General Public License
;; see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; This package contains functions and hooks for running artistic style
;; formatter on C / C++ source code.
;;
;; To format buffer using astyle run `astyle-buffer'.  If astyle
;; configuration file is found (file name `astyle-default-rc-name') it
;; will be prefered.  If no configuration file is found either
;; `astyle-custom-args' or `astyle-default-args' is used.
;;
;; There are two ways of enabling format on save functionality.  Either
;; enable `astyle-on-save-mode` in mode hook or place the following
;; in your project `.dir-locals.el`:
;; ((c-mode (mode . astyle-format-on-save)))

;;; Code:

(require 'reformatter)

(defgroup astyle nil
  "Astyle functions and settings."
  :group 'languages
  :tag "astyle"
  :prefix "astyle-"
  :link '(url-link :tag "Site" "https://github.com/storvik/emacs-astyle")
  :link '(url-link :tag "Repository" "https://github.com/storvik/emacs-astyle"))

(defcustom astyle-style "google"
  "Astyle style option, for alternatives see `http://astyle.sourceforge.net/astyle.html'."
  :type 'string
  :group 'astyle)

(defcustom astyle-indent nil
  "Astyle indent width, if nil set to `c-basic-offset'."
  :type 'integer
  :group 'astyle)

(defcustom astyle-default-rc-name ".astylerc"
  "Default astyle config file name, usually .astylerc."
  :type 'string
  :group 'astyle)

(defcustom astyle-custom-args nil
  "Custom astyle arguments, if nil `astyle-default-args' is used instead."
  :type '(repeat string)
  :group 'astyle)

(defconst astyle-default-args
  '("--pad-oper"
    "--pad-header"
    "--break-blocks"
    "--delete-empty-lines"
    "--align-pointer=type"
    "--align-reference=name")
  "Default astyle arguments.")

(defvar c-basic-offset)

(defun astyle--format-args ()
  "Will return astyle arguments depending whether .astylerc was found or not."
  (let ((astyle-file (locate-dominating-file (buffer-file-name) astyle-default-rc-name)))
    (if astyle-file
        (progn
          (message "Using %s" astyle-file)
          (list (concat "--options=" (file-truename astyle-file) astyle-default-rc-name)))
      (append (list (concat "--style=" astyle-style)
                    (concat "--indent=spaces="
                            (number-to-string (if astyle-indent
                                                  astyle-indent
                                                c-basic-offset))))
              (if astyle-custom-args
                  astyle-custom-args
                astyle-default-args)))))

;;;###autoload (autoload 'astyle-buffer "astyle" nil t)
;;;###autoload (autoload 'astyle-region "astyle" nil t)
;;;###autoload (autoload 'astyle-on-save-mode "astyle" nil t)
(reformatter-define astyle
  :program "astyle"
  :args (astyle--format-args)
  :lighter " astyle")

(provide 'astyle)

;;; astyle.el ends here
