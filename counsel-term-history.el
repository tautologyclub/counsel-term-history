;;; counsel-term-history.el --- Grep your terminal history with ivy

;; Copyright 2018 Benjamin Lindqvist

;; Author: Benjamin Lindqvist <benjamin.lindqvist@gmail.com>
;; Maintainer: Benjamin Lindqvist <benjamin.lindqvist@gmail.com>
;; URL: https://github.com/tautologyclub/counsel-term-history
;; Version: 0.01

;; This file is part of GNU Emacs.

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; For a full copy of the GNU General Public License
;; see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; Some hacky but extremely convenient functions for making life inside
;; term-mode easier.  All of them make use of two things: first, the excellent
;; 'ivy-read' API and second, the fact that you can send raw control characters
;; such representing C-k, C-u, etc to your terminal using
;; 'term-send-raw-string'.
;;
;; A summary:
;;
;; counsel-term-history -- A simple utility that completing-reads your
;; ~/.bash_history (or whatever other file you want, really) and sends the
;; selected candidate to the terminal.  To get going, bind 'counsel-term-history
;; to some nice stroke in your term-mode-map, C-r comes quite naturally to
;; mind.
;;
;; Note: This package has no association with counsel or ivy apart from using
;; the ivy api and kinda feeling lika a counsel package.  The author admits to
;; a slighy fanboy-ism towards their creator however -- support him on Patreon!
;; More instructions on his site, oremacs.com.

;;; Code:
(require 'ivy)
(require 'term)
(require 'cl)

(defcustom counsel-th-history-file "~/.bash_history"
  "The location of your history file (tildes are fine)."
  :type 'string)

(defcustom counsel-th-filter "^\\(cd\\|ll\\|ls\\|\\\.\\\.\\|pushd\\|popd\\)"
  "Regex filter for the uninteresting lines in the history file.")

(defun counsel-th--read-lines (file)
  "Make a reversed list of lines in FILE, applying regex counsel-th-filter."
  (with-temp-buffer
    (insert-file-contents file)
    (remove-if (lambda (x) (string-match counsel-th-filter x))
               (reverse (split-string (buffer-string) "\n" t)))))

(defun counsel-th--action (cand)
  "Send CAND to term prompt, without executing."
  (term-send-raw-string (concat "" cand)))

(defun counsel-term-history ()
  "You know, do stuff."
  (interactive)
  (ivy-read "History: "
            (counsel-th--read-lines
             (expand-file-name counsel-th-history-file))
            :initial-input "^"
            :action 'counsel-th--action
            ))

(provide 'counsel-term-history)
;;; counsel-term-history.el ends here
