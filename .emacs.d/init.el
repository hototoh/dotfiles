;; 言語設定
;;(set-language-environment 'Japanese)
;; 文字コード設定
(prefer-coding-system 'utf-8)
;; パスの設定
;;(setq load-path (cons "~/.emacs.d/elisp" load-path))
;; フレーム透過設定
(set-frame-parameter (selected-frame) 'alpha '(70 50))

;; Package Manegement
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;auto install
(require 'cl)
(defvar installing-package-list
  '(
    ;; package list
    anything
    anything-replace-string
    auto-complete
    auto-install
    dash
    epl
    flycheck
    flycheck-google-cpplint
    flymake
    flymake-easy
    flymake-go
    flymake-google-cpplint
    flymake-json
    flymake-php
    flymake-python-pyflakes
    flymake-shell
    flymake-yaml
    github-theme
    go-mode
    google-c-style
    hlinum
    js3-mode
    json
    json-mode
    json-reformat
    json-snatcher
    markdown-mode
    pkg-info
    python
    python-mode
    smartparens
    smooth-scrolling
    thrift
    yaml-mode
    ))
(let ((not-installed (loop for x in installing-package-list
                        when (not (package-installed-p x))
                        collect x)))
(when not-installed
(package-refresh-contents)
(dolist (pkg not-installed)
    (package-install pkg))))

;; 対応する括弧の強調
(show-paren-mode t)
; 外部デバイスとクリップボードを共有
(setq x-select-enable-clipboard t)
;; 改行でオートインデント
(global-set-key "\C-m" 'newline-and-indent)
;; BSやDel、文字入力でリージョン内の文字を削除
(delete-selection-mode 1)
;; C-k １回で行全体を削除する
(setq kill-whole-line t)
;;(global-hl-line-mode)
(setq require-final-newline t)

;; M-jを入力すると対応するカッコに飛ぶ
(global-set-key (kbd "M-j") 'match-paren)
;; Ctrl + :でgoto line
(define-key global-map (kbd "C-:") 'goto-line)
;; Ctrl + Shift + 7でaddrev静的展開
(define-key global-map (kbd "C-'") 'expand-addrev)
;; Ctrl + hでdelete backward char
(define-key global-map (kbd "C-h") 'delete-backward-char)

;; ウインドウ間移動のキーバインドにC-\を追加
(define-key global-map "\C-\\" 'other-window)

(defun match-paren (arg)
"Go to the matching paren if on a paren; otherwise insert %."
(interactive "p")
(cond ((looking-at "\\s\(") (forward-list 1) (backward-char 1))
    ((looking-at "\\s\)") (forward-char 1) (backward-list 1))
    (t (self-insert-command (or arg 1)))))
;indent幅をtab=space4つに
;;通常インデントをspace4つに
(setq tab-width 4)
(setq indent-tabs-mode nil)

(defun my-c-mode-hook ()
    (c-set-style "linux")
    (setq c-basic-offset 4)
    (setq tab-width c-basic-offset)
    (setq indent-tabs-mode nil)
    )
(add-hook 'c-mode-hook 'my-c-mode-hook)
(add-hook 'c++-mode-hook 'my-c-mode-hook)

;; emacs内部シェルのlsオプション設定
(setq dired-listing-switches "-lh")

;; 分割ウインドウをShift+カーソルキーで移動
(windmove-default-keybindings)
(setq windmove-wrap-around t)

;; template settings
(auto-insert-mode)
(setq auto-insert-directory "~/.emacs.d/insert/")
(define-auto-insert "\\.py$" "python-template")
(define-auto-insert "\\.c$" "C-template")

;; auto-install
;;(require 'auto-install)
;;(setq auto-install-directory "~/.emacs.d/elisp/")
;;(auto-install-update-emacswiki-package-name t)
;;(auto-install-compatibility-setup)
;;
;;;auto-completeの設定
;;(setq load-path (cons "~/.emacs.d/elisp/auto-complete" load-path))
;;(require 'auto-complete)
;;(global-auto-complete-mode t)


;; 辞書保存
;(setq ac-comphist-file "~/.emacs.d/elisp/auto-complete-dics/auto-dics")
;(setq ac-dictionary-directories "~/.emacs.d/elisp/auto-complete-dics/")
;; 
;; anything --------------------------------------
;; 
;; (require 'anything)
;; (require 'anything-startup)
;; (require 'anything-config)
;; (require 'recentf)
;; (add-to-list 'anything-sources 'anything-c-source-emacs-commands)
;; (define-key global-map (kbd "C-^") 'anything) ;Ctrl-^で起動
;; ;; 縦横切り替え
;; (defun my-anything-toggle-resplit-window ()
;;   (interactive)
;;   (when (anything-window)
;;     (save-selected-window
;;       (select-window (anything-window))
;;       (let ((before-height (window-height)))
;;         (delete-other-windows)
;;         (switch-to-buffer anything-current-buffer)
;;         (if (= (window-height) before-height)
;;             (split-window-vertically)
;;           (split-window-horizontally)))
;;       (select-window (next-window))
;;       (switch-to-buffer anything-buffer))))

;; (define-key anything-map "\C-j" 'my-anything-toggle-resplit-window)
;; ;;バッファの一覧を取得
;; ;;anything-c-source-buffers
;; ;;バッファにマッチしなかった場合にバッファを作成
;; ;;anything-c-source-buffer-not-found
;; ;;カレントディレクトリにあるファイル一覧
;; ;;anything-c-source-files-in-current-dir
;; ;;最近開いたファイル一覧
;; ;;anything-c-source-recentf
;; (setq recentf-max-saved-items 3000)
;; (recentf-mode 1)



;====================================
;;全角スペースとかに色を付ける
;====================================
;(defface my-face-b-1 '((t (:background "medium aquamarine"))) nil)
;(defface my-face-b-1 '((t (:background "dark turquoise"))) nil)
;(defface my-face-b-2 '((t (:background "cyan"))) nil)
;(defface my-face-b-2 '((t (:background "SeaGreen"))) nil)
;(defface my-face-u-1 '((t (:foreground "SteelBlue" :underline t))) nil)
;(defvar my-face-b-1 'my-face-b-1)
;(defvar my-face-b-2 'my-face-b-2)
;(defvar my-face-u-1 'my-face-u-1)
;(defadvice font-lock-mode (before my-font-lock-mode ())
;              (font-lock-add-keywords
;	       major-mode
;	       '(
;		 ("　" 0 my-face-b-1 append)
;		 ("\t" 0 my-face-b-2 append)
;		 ("[ ]+$" 0 my-face-u-1 append)
;		 )))
;(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
;(ad-activate 'font-lock-mode)
;(add-hook 'find-file-hooks '(lambda ()
;			      (if font-lock-mode
;				  nil
;				(font-lock-mode t))))

;; Go lang
;;(add-to-list 'exec-path (expand-file-name "~/.gopath/bin"))
;;(require 'go-mode-load)
;;(require 'go-mode)

;; Python-mode-hook
;;(require 'python-mode)
;;
;; (add-hook 'python-mode-hook
;; 	  (lambda ()
;; 	    (define-key python-mode-map "\"" 'electric-pair)
;; 	    (define-key python-mode-map "\'" 'electric-pair)
;; 	    (define-key python-mode-map "(" 'electric-pair)
;; 	    (define-key python-mode-map "[" 'electric-pair)
;; 	    (define-key python-mode-map "{" 'electric-pair)))
;;
;; (defun electric-pair ()
;;   "Insert character pair without sournding spaces"
;;   (interactive)
;;   (let (parens-require-spaces)
;;     (insert-pair)))
;; (add-hook 'python-mode-hook '(lambda ()
;; 			       (define-key python-mode-map "\C-m" 'newline-and-indent)))

;; R-mode-hook
;;(require 'ess-mode)
;;(setq auto-mode-alist
;;      (cons (cons "\\.r$" 'R-mode) auto-mode-alist))
;;(autoload 'R-mode "ess-site" "Emacs Speaks Statistics mode" t)
;;(setq load-path (cons (expand-file-name "/usr/share/emacs-21.3/site-lisp/ess")   load-path))
;;(setq ess-pre-run-hook
;;  '((lambda () (setq S-directory default-directory)
;;          (setq default-process-coding-ssyntstem '(euc-japan-unix .   euc-japan-unix))
;;       )))
;;(autoload 'R "ess-site" nil 'interactive)
;;(eval-after-load "R"
;; '(progn
;;      (set-language-environment "Japanese")
;;      (set-default-coding-systems 'euc-japan-unix)
;;      (set-terminal-coding-system 'euc-japan-unix)
;;      (set-keyboard-coding-system 'euc-japan-unix)
;;      (set-buffer-file-coding-system 'euc-japan-unix)
;;      (define-key ess-mode-map "\177"   'delete-char)
;;      (setq ess-ask-for-ess-directory nil)
;;     ))
;;
