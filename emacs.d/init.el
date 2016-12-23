(prefer-coding-system 'utf-8)
(keyboard-translate ?\C-h ?\C-?)

(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)

(package-initialize)

(require 'cl-lib)
(defvar installing-package-list
  '(
    ;; package list
    auto-install
    company-irony
    company-irony-c-headers
    ;dash
    ;epl
    ;erlang
    flycheck
    flycheck-irony
    flycheck-google-cpplint
    ;go-mode
    ;google-c-style
    irony
    ;js3-mode
    ;json
    ;json-mode
    ;json-reformat
    ;json-snatcher
    ;lua-mode
    ;lfe-mode
    ;markdown-mode
    ;pkg-info
    ;protobuf-mode
    ;python
    ;python-mode
    rtags
    ;smartparens
    ;smooth-scrolling
    ;thrift
    ;yaml-mode
    yasnippet
    ))
(let ((not-installed (cl-loop for x in installing-package-list
                        when (not (package-installed-p x))
                        collect x)))
(when not-installed
(package-refresh-contents)
(dolist (pkg not-installed)
    (package-install pkg))))


(eval-after-load "yasnippet"
  '(progn
     ;; only enable "C-i" because it conflicts with company
     (define-key yas-keymap (kbd "<tab>") nil)
          (yas-global-mode 1)))

(when (locate-library "company")
  (global-company-mode t)
  (global-set-key (kbd "C-M-i") 'company-complete)
  ;; (setq company-idle-delay nil) ;;No completion
  (define-key company-active-map (kbd "C-n") 'company-select-next)
  (define-key company-active-map (kbd "C-p") 'company-select-previous)
  (define-key company-search-map (kbd "C-n") 'company-select-next)
  (define-key company-search-map (kbd "C-p") 'company-select-previous)
  (define-key company-active-map (kbd "<tab>") 'company-complete-selection))

(eval-after-load "irony"
  '(progn
     (custom-set-variables '(irony-additional-clang-options '("-std=c++11")))
     (add-to-list 'company-backends 'company-irony)
     (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
          (add-hook 'c-mode-common-hook 'irony-mode)))

(when (require 'flycheck nil 'noerror)
  (custom-set-variables
   ;; show error with pop-up
   '(flycheck-display-errors-function
     (lambda (errors)
       (let ((messages (mapcar #'flycheck-error-message errors)))
         (popup-tip (mapconcat 'identity messages "\n")))))
   '(flycheck-display-errors-delay 0.5))
  (define-key flycheck-mode-map (kbd "C-M-n") 'flycheck-next-error)
  (define-key flycheck-mode-map (kbd "C-M-p") 'flycheck-previous-error)
  (add-hook 'c-mode-common-hook 'flycheck-mode))

(eval-after-load "flycheck"
  '(progn
     (when (locate-library "flycheck-irony")
       (flycheck-irony-setup))))
(require 'flycheck-google-cpplint)
(flycheck-add-next-checker 'irony '(warning . c/c++-googlelint))

(when (require 'rtags nil 'noerror)
  (add-hook 'c-mode-common-hook
            (lambda ()
              (when (rtags-is-indexed)
                (local-set-key (kbd "M-.") 'rtags-find-symbol-at-point)
                (local-set-key (kbd "M-;") 'rtags-find-symbol)
                (local-set-key (kbd "M-@") 'rtags-find-references)
                (local-set-key (kbd "M-,") 'rtags-location-stack-back)))))


(setq tab-width 4)
(setq indent-tabs-mode nil)
(show-paren-mode t)
(global-linum-mode t)
(delete-selection-mode t)
(defun match-paren (arg)
"Go to the matching paren if on a paren; otherwise insert %."
(interactive "p")
(cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
    ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
    (t (self-insert-command (or arg 1)))))
(global-set-key (kbd "M-j") 'match-paren)

;; template settings
(auto-insert-mode)
(setq auto-insert-directory "~/.emacs.d/insert/")
(define-auto-insert "\\.py$" "basic-template.py")
(define-auto-insert "\\.c$" "basic-template.c")
(define-auto-insert "\\.cc$" "basic-template.cc")
(define-auto-insert "\\.pcon.cc$" "programming-contest-template.cc")
(define-auto-insert "\\.erl$" "basic-template.erl")
(define-auto-insert "\\.html$" "basic-template.html")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-display-errors-delay 0.5)
 '(flycheck-display-errors-function
   (lambda
     (errors)
     (let
	 ((messages
	   (mapcar
	    (function flycheck-error-message)
	    errors)))
       (popup-tip
	(mapconcat
	 (quote identity)
	 messages "
")))))
 '(irony-additional-clang-options (quote ("-std=c++11")))
 '(package-selected-packages
   (quote
    (yasnippet rtags irony flycheck-irony company-irony-c-headers company-irony yaml-mode thrift smooth-scrolling smartparens python-mode protobuf-mode markdown-mode lua-mode lfe-mode json-mode js3-mode hlinum google-c-style go-mode flymake-yaml flymake-shell flymake-python-pyflakes flymake-php flymake-json flymake-google-cpplint flymake-go flycheck-google-cpplint erlang))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
