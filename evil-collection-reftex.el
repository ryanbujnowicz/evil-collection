;;; evil-collection-reftex.el --- Bindings for `reftex'. -*- lexical-binding: t -*-

;; Author: Maximiliano Sandoval <msandova@protonmail.com>
;; Maintainer: James Nguyen <james@jojojames.com>
;; Pierre Neidhardt <ambrevar@gmail.com>
;; URL: https://github.com/jojojames/evil-collection
;; Version: 0.0.1
;; Package-Requires: ((emacs "25.1"))
;; Keywords: evil, reftex, tools

;;; Commentary:
;; Evil bindings for `reftex-mode'.

;;; Code:
(eval-when-compile (require 'cl))
(require 'evil)
(require 'reftex-ref nil t)
(require 'reftex-ref nil t)
(require 'reftex-cite nil t)

(defun evil-collection-reftex-setup ()
  "Set up `evil' bindings for `reftex'."

  (evil-set-initial-state 'reftex-select-label-mode 'normal)
  (evil-set-initial-state 'reftex-toc-mode 'normal)
  (evil-set-initial-state 'reftex-select-bib-mode 'normal)
  
  ;; original code can be found in reftex-ref.el
  (defconst reftex-select-label-prompt
  "Select: [RET]select [j]next [k]previous [gr]escan [.]context [q]uit [?]help"
  )

  ;; original code can be found in reftex-cite.el
  (defconst reftex-citation-prompt
        "Select: [RET]select [j]next [k]previous [q]uit [?]help"
        )
  
  ;; original at reftex-ref.el
  (defconst reftex-select-label-help
  " j / k      Go to next/previous label (Cursor motion works as well)
 C-j C-k  Go to next/previous section heading.	
 g          Start over with new regexp. 
 b / l      Jump back to previous selection / Reuse last referenced label.	
 z          Jump to a specific section, e.g. '3 z' jumps to section 3.
 s          Switch label type.	
 gr         Reparse document.	
 . / go     Show context / Show insertion point.
 x          Switch to label menu of external document (with LaTeX package `xr').
 v   / V    Toggle \\ref <-> \\vref / Rotate \\ref <=> \\fref <=> \\Fref.
 TAB        Enter a label with completion.
 m / #      Mark entry. Unmark entry.
 a / A      Put all marked entries into one/many \\ref commands.
 q / RET    Quit without referencing / Accept current label.")

  ;; code can be found in reftex-cite.el
  (defconst reftex-citation-help
  " j / k      Go to next/previous entry (Cursor motion works as well).
 . /go      Show citation / Show insertion point.
 q          Quit without inserting \\cite macro into buffer.
 TAB        Enter citation key with completion.
 RET        Accept current entry and create \\cite macro.
 m / #      Mark/Unmark the entry.
 e / E      Create BibTeX file with all (marked/unmarked) entries
 a / A      Put all (marked) entries into one/many \\cite commands.")
  
  (evil-define-key 'normal reftex-select-shared-map
    "j" 'reftex-select-next
    "k" 'reftex-select-previous
    (kbd "C-j") 'reftex-select-next-heading
    (kbd "C-k") 'reftex-select-previous-heading
    "." 'reftex-select-callback ;shows the point where the label is
    "gr" (lambda nil "Press `?' during selection to find out
    about this key" (interactive) (throw (quote myexit) 114)) ;reftex binds keys in a very arcane way
    "q" 'reftex-select-quit
    "?" 'reftex-select-help
    "b" 'reftex-select-jump-to-previous
    "l" (lambda nil "Press `?' during selection to find out
    about this key." (interactive) (throw (quote myexit) 108))
    "z" 'reftex-select-jump
    (kbd "<tab>") 'reftex-select-read-label
    "s" (lambda nil "Press `?' during selection to find out
    about this key." (interactive) (throw (quote myexit) 115))
    "m" 'reftex-select-mark
    "#" 'reftex-select-unmark
    "a" (lambda nil "Press `?' during selection to find out
    about this key." (interactive) (throw (quote myexit) 97))
    "A" (lambda nil "Press `?' during selection to find out
    about this key." (interactive) (throw (quote myexit) 65))
    "x" (lambda nil "Press `?' during selection to find out
    about this key." (interactive) (throw (quote myexit) 120))
    "v" 'reftex-select-cycle-ref-style-forward
    "V" 'reftex-select-cycle-ref-style-backward
    "go" 'reftex-select-show-insertion-point 
    "e" (lambda nil "Press `?' during selection to find out
    about this key." (interactive) (throw (quote myexit) 101))
    "E" (lambda nil "Press `?' during selection to find out
    about this key." (interactive) (throw (quote myexit) 69))
    )

  ;; This one is more involved, in reftex-toc.el, line 282 it shows the prompt
  ;; string with the keybinds and I don't see any way of changing it to show evil-like binds.
  (evil-define-key 'normal reftex-toc-mode-map
    "j" 'reftex-toc-next
    "k" 'reftex-toc-previous
    (kbd "RET") 'reftex-toc-goto-line-and-hide
    (kbd "<tab>") 'reftex-toc-goto-line
    "q" 'reftex-toc-quit
    "?" 'reftex-toc-show-help
    "gr" 'reftex-toc-rescan
    "r" 'reftex-toc-rescan
    "l" 'reftex-toc-toggle-labels
    "?" 'reftex-toc-show-help
    "x" 'reftex-toc-external
    "f" 'reftex-toc-toggle-follow
    ;; (kbd "SPC") 'reftex-toc-view-line
    )
  )

(provide 'evil-collection-reftex)
;;; evil-collection-reftex.el ends here