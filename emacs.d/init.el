;; 言語設定
(set-language-environment 'Japanese)
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
(add-to-list 'load-path "/usr/local/share/gtags")
(package-initialize)

(global-linum-mode t)

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
    erlang
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
    ;;github-theme
    go-mode
    google-c-style
    hlinum
    js3-mode
    json
    json-mode
    json-reformat
    json-snatcher
    lua-mode
    lfe-mode
    markdown-mode
    pkg-info
    protobuf-mode
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

(require 'auto-complete)
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/ac-dict")
(ac-config-default)
(setq ac-modes (append ac-modes '(objc-mode)))

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
;; Ctrl-x p で逆向きへのウィンドウ移動
(global-set-key "\C-xp" (lambda () (interactive) (other-window -1)))

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

;; emacs内部シェルのlsオプション設定
(setq dired-listing-switches "-lh")

;; 分割ウインドウをShift+カーソルキーで移動
(windmove-default-keybindings)
(setq windmove-wrap-around t)

;; template settings
(auto-insert-mode)
(setq auto-insert-directory "~/.emacs.d/insert/")
(define-auto-insert "\\.py$" "basic-template.py")
(define-auto-insert "\\.c$" "basic-template.c")
(define-auto-insert "\\.cc$" "basic-template.cc")
(define-auto-insert "\\.pcon.cc$" "programming-contest-template.cc")
(define-auto-insert "\\.erl$" "basic-template.erl")
(define-auto-insert "\\.html$" "basic-template.html")



;; 辞書保存
;(setq ac-comphist-file "~/.emacs.d/elisp/auto-complete-dics/auto-dics")
;(setq ac-dictionary-directories "~/.emacs.d/elisp/auto-complete-dics/")
;; 
;; anything --------------------------------------

(require 'anything)
(require 'anything-startup)
(require 'anything-config)
(require 'recentf)
(add-to-list 'anything-sources 'anything-c-source-emacs-commands)
(define-key global-map (kbd "C-^") 'anything) ;Ctrl-^で起動
;; 縦横切り替え
(defun my-anything-toggle-resplit-window ()
  (interactive)
  (when (anything-window)
    (save-selected-window
      (select-window (anything-window))
      (let ((before-height (window-height)))
        (delete-other-windows)
        (switch-to-buffer anything-current-buffer)
        (if (= (window-height) before-height)
            (split-window-vertically)
          (split-window-horizontally)))
      (select-window (next-window))
      (switch-to-buffer anything-buffer))))

(define-key anything-map "\C-j" 'my-anything-toggle-resplit-window)
;;バッファの一覧を取得
anything-c-source-buffers
;;バッファにマッチしなかった場合にバッファを作成
anything-c-source-buffer-not-found
;;カレントディレクトリにあるファイル一覧
anything-c-source-files-in-current-dir
;;最近開いたファイル一覧
anything-c-source-recentf
(setq recentf-max-saved-items 3000)
(recentf-mode 1)


;; Python-mode-hook
(require 'python-mode)

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
;;; Pythonにて1行80文字を超えるとハイライト
(add-hook 'python-mode-hook
  (lambda ()
    (font-lock-add-keywords nil
      '(("^[^\n]\\{80\\}\\(.*\\)$" 1 font-lock-warning-face t)))))

;; C, C++ Style
(defun my-c-namespace-indent (langelem)
    (save-excursion
        (if (or (looking-at "[ \t]*namespace[ \t{]")
                (looking-at "[ \t]*namespace[ \t]+[_a-zA-Z]")
                (looking-at "[ \t]*}")
             ) 0
            (if (or (looking-at "[ \t]*class[ \t{]")
                    (looking-at "[ \t]*class[ \t]+[_a-zA-Z]")
                ) 0
                (if (progn (goto-char (cdr langelem))
                           (skip-chars-backward " \t")
                           (bolp)) 2)
          )))) 
(defun my-c-c++-mode-init () 
    (require 'google-c-style) 
    (google-set-c-style)
    (google-make-newline-indent)
    (add-hook 'c-mode-common-hook 'google-set-c-style)
    (setq tab-width 4) 
    (setq c-basic-offset 4)
;;    (c-set-offset 'innamespace 'my-c-namespace-indent)
    (c-set-offset 'innamespace 0)
    (c-set-offset 'class-open 0)
    (c-set-offset 'class-close 0)
    (c-set-offset 'namespace-open 0)
    (c-set-offset 'namespace-close 0)
    (c-set-offset 'access-label '/)
    (auto-revert-mode)
)
(add-hook 'c++-mode-hook 'my-c-c++-mode-init)
(add-hook 'c++-mode-hook
  (lambda ()
    (font-lock-add-keywords nil
      '(("^[^\n]\\{80\\}\\(.*\\)$" 1 font-lock-warning-face t)))
   ))
(add-hook 'c-mode-hook 'my-c-c++-mode-init)
(add-hook 'c-mode-hook
  (lambda ()
    (font-lock-add-keywords nil
      '(("^[^\n]\\{80\\}\\(.*\\)$" 1 font-lock-warning-face t)))
   ))
(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode))
;;; C系統,Pythonにて1行80文字を超えるとハイライト
;;  (lambda ()
;;    (font-lock-add-keywords nil
;;      '(("^[^\n]\\{80\\}\\(.*\\)$" 1 font-lock-warning-face t)))
;;   ))
;;(add-hook 'c++-mode-hook
;;  (lambda ()
;;    (font-lock-add-keywords nil
;;      '(("^[^\n]\\{80\\}\\(.*\\)$" 1 font-lock-warning-face t)))
;;   ))
;;; Javaで1行100文字を超えるとハイライト
(add-hook 'java-mode-hook
  (lambda ()
    (font-lock-add-keywords nil
      '(("^[^\n]\\{100\\}\\(.*\\)$" 1 font-lock-warning-face t)))))

;; Erlang
(setq erlang-root-dir "/urr/local/Cellar/erlang/18.2.2")
(require 'erlang-start)
(require 'erlang-flymake)
;; append elrang-mode
(setq ac-modes
  (append ac-modes
      (list 'erlang-mode)))

(require 'helm-config)
(require 'helm-gtags)

(add-hook 'c-mode-hook 'helm-gtags-mode)
(add-hook 'c++-mode-hook 'helm-gtags-mode)
(add-hook 'go-mode-hook (lambda () (helm-gtags-mode)))
(add-hook 'python-mode-hook (lambda () (helm-gtags-mode)))  
(add-hook 'ruby-mode-hook (lambda () (helm-gtags-mode)))                         
(setq helm-gtags-path-style 'root)                       
(setq helm-gtags-auto-update t)
(add-hook 'helm-gtags-mode-hook
          '(lambda ()                                                                   
             (local-set-key (kbd "M-g") 'helm-gtags-dwim)
             (local-set-key (kbd "M-s") 'helm-gtags-show-stack)
             (local-set-key (kbd "M-p") 'helm-gtags-previous-history)
             (local-set-key (kbd "M-n") 'helm-gtags-next-history)))    

(load-theme 'wombat t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (protobuf-mode yaml-mode thrift smooth-scrolling smartparens python-mode markdown-mode lua-mode lfe-mode json-mode js3-mode hlinum helm-package helm-gtags google-c-style go-mode flymake-yaml flymake-shell flymake-python-pyflakes flymake-php flymake-json flymake-google-cpplint flymake-go flycheck-google-cpplint erlang auto-install auto-complete anything-replace-string))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
