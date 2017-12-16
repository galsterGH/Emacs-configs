;;; -*- Mode: Emacs-Lisp -*-
;;; This is a sample .emacs file.
;;;
;;; The .emacs file, which should reside in your home directory, allows you to
;;; customize the behavior of Emacs.  In general, changes to your .emacs file
;;; will not take effect until the next time you start up Emacs.  You can load
;;; it explicitly with `M-x load-file RET ~/.emacs RET'.
;;;
;;; There is a great deal of documentation on customization in the Emacs
;;; manual.  You can read this manual with the online Info browser: type
;;; `C-h i' or select "Emacs Info" from the "Help" menu.


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;                      Basic Customization                         ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq inhibit-default-init t)
(setq gdb-command-name "/usr/local/bin/gdb")
(show-paren-mode 1)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(haskell-process-auto-import-loaded-modules t)
 '(haskell-process-log t)
 '(haskell-process-suggest-remove-import-lines t)
 '(haskell-process-type (quote stack-ghci))
 '(initial-frame-alist (quote ((fullscreen . maximized))))
 '(package-selected-packages
   (quote
    (window-number buffer-move smooth-scroll project-explorer json-mode markdown-mode go-eldoc quickrun haskell-mode go-dlv go-autocomplete exec-path-from-shell company-go company-c-headers))))

;; Don't show *Buffer list* when opening multiple files at the same time.
(setq inhibit-startup-buffer-menu t)
(add-hook 'emacs-startup-hook 'delete-other-windows)

;; Show only one active window when opening multiple files at the same time.
(add-hook 'window-setup-hook 'delete-other-windows)
(setq inhibit-splash-screen t)
(setq inhibit-startup-message t)

;; Add these to the PATH so that proper executables are found
(setenv "PATH" (concat (getenv "PATH") ":/usr/texbin"))
(setenv "PATH" (concat (getenv "PATH") ":/usr/bin"))
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin"))
(setq exec-path (append exec-path '("/usr/texbin")))
(setq exec-path (append exec-path '("/usr/bin")))
(setq exec-path (append exec-path '("/usr/local/bin")))

(add-to-list 'load-path "~/.emacs.d/lisp")

;; Enable The
;; command, but possibly confusing to a new user, so it's disabled by
;; default.
(put 'narrow-to-region 'disabled nil)

;;; Define a variable to indicate whether we're running XEmacs/Lucid Emacs.
;;; (You do not have to defvar a global variable before using it --
;;; you can just call `setq' directly like we do for `emacs-major-version'
;;; below.  It's clearer this way, though.)

(defvar running-xemacs (string-match "XEmacs\\|Lucid" emacs-version))

;; which prints the current line number in the echo area.
(global-set-key "\C-xw" 'what-line)

;; set up the function keys to do common tasks to reduce Emacs pinky
;; and such.

;; Make F1 invoke help
(global-set-key [f1] 'help-command)
;; Make F2 be `undo'
(global-set-key [f2] 'undo)
;; Make F3 be `find-file'
;; Note: it does not currently work to say
;;   (global-set-key 'f3 "\C-x\C-f")
;; The reason is that macros can't do interactive things properly.
;; This is an extremely longstanding bug in Emacs.  Eventually,
;; it will be fixed. (Hopefully ..)
(global-set-key [f3] 'find-file)

;; Make F4 be "mark", F5 be "copy", F6 be "paste"
;; Note that you can set a key sequence either to a command or to another
;; key sequence.
(global-set-key [f4] 'set-mark-command)
(global-set-key [f5] "\M-w")
(global-set-key [f6] "\C-y")

;; Shift-F4 is "pop mark off of stack"
(global-set-key [(shift f4)] (lambda () (interactive) (set-mark-command t)))

;; Make F7 be `save-buffer'
(global-set-key [f7] 'save-buffer)

;; Make F8 be "start macro", F9 be "end macro", F10 be "execute macro"
(global-set-key [f8] 'start-kbd-macro)
(global-set-key [f9] 'end-kbd-macro)
(global-set-key [f10] 'call-last-kbd-macro)

;; Here's an alternative binding if you don't use keyboard macros:
;; Make F8 be `save-buffer' followed by `delete-window'.
;;(global-set-key 'f8 "\C-x\C-s\C-x0")

;; If you prefer delete to actually delete forward then you want to
;; uncomment the next line (or use `Customize' to customize this).
;; (setq delete-key-deletes-forward t)

(require 'package)

(add-to-list 'package-archives '("melpa-stable" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
    '("marmalade" .
      "http://marmalade-repo.org/packages/"))
(package-initialize)

(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)
(defun my:ac-c-header-init()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers))



(add-hook 'haskell-mode-hook #'hindent-mode)
(eval-after-load 'haskell-mode
  '(define-key haskell-mode-map [f8] 'haskell-navigate-imports))


(eval-after-load 'haskell-mode '(progn
  (define-key haskell-mode-map (kbd "C-c C-l") 'haskell-process-load-or-reload)
  (define-key haskell-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
  (define-key haskell-mode-map (kbd "C-c C-n C-t") 'haskell-process-do-type)
  (define-key haskell-mode-map (kbd "C-c C-n C-i") 'haskell-process-do-info)
  (define-key haskell-mode-map (kbd "C-c C-n C-c") 'haskell-process-cabal-build)
  (define-key haskell-mode-map (kbd "C-c C-n c") 'haskell-process-cabal)))
(eval-after-load 'haskell-cabal '(progn
  (define-key haskell-cabal-mode-map (kbd "C-c C-z") 'haskell-interactive-switch)
  (define-key haskell-cabal-mode-map (kbd "C-c C-k") 'haskell-interactive-mode-clear)
  (define-key haskell-cabal-mode-map (kbd "C-c C-c") 'haskell-process-cabal-build)
  (define-key haskell-cabal-mode-map (kbd "C-c c") 'haskell-process-cabal)))



(load-file "~/.emacs.d/lisp/go-mode.el")
(require 'go-mode)
(load-file "~/.emacs.d/init2.el")
(load-file "~/.emacs.d/lisp/gud-lldb.el")
