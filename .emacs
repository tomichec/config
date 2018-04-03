;; -*- mode: elisp -*-

;; Enable transient mark mode

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(transient-mark-mode 1)

;;;;org-mode configuration
;; Enable org-mode
(require 'org)
(global-set-key "\C-ca" 'org-agenda)

(setq org-default-notes-file (concat org-directory "/notes.org"))
;; Make org-mode work with files ending in .org
;; (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; The above is the default in recent emacsen

;; ------------------------------------------------------------
;; (add-to-list 'load-path "~/.emacs.d/matlab-emacs")
;; (require 'matlab-load)
;; (auto-fill-mode 0)     ; do not automatic brake of long lines -- 'hard-wrap'

;; (autoload 'dot-mode "dot-mode" nil t) ; vi `.' command emulation
;; (global-set-key [(control ?.)] (lambda () (interactive) (dot-mode 1)
;; 				 (message "Dot mode activated.")))

;; (add-to-list 'load-path "~/.emacs.d/dot-mode")
;; (require 'dot-mode)
;; (add-hook 'find-file-hooks 'dot-mode-on)

(defun reduce-number-at-point ()
  (interactive)
  (skip-chars-backward "0123456789")
  (or (looking-at "[0123456789]+")
      (error "No number at point"))
  (replace-match (number-to-string ( 1- (string-to-number (match-string 0))))))

(defun increase-number-at-point ()
  (interactive)
  (skip-chars-backward "0123456789")
  (or (looking-at "[0123456789]+")
      (error "No number at point"))
  (replace-match (number-to-string ( 1+ (string-to-number (match-string 0))))))

;; for Scons

;; (setq auto-mode-alist
;;             (cons '("SConstruct" . python-mode) auto-mode-alist))
;; (setq auto-mode-alist
;;             (cons '("SConscript" . python-mode) auto-mode-alist))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files (quote ("~/PD/log.org")))
 '(package-archives
   (quote
    (("gnu" . "http://elpa.gnu.org/packages/")
     ("melpa" . "http://melpa.milkbox.net/packages/"))))
 '(package-selected-packages
   (quote
    (smartparens flycheck company-php company-web auctex multiple-cursors markdown-mode langtool chess)))
 '(safe-local-variable-values (quote ((sh-indent-comment . t)))))
;; activate RefTeX
(add-hook 'latex-mode-hook 'turn-on-reftex)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-auctex t)
;; 
;
;--------------------------------------------------
; unbind close emacs key binding
;; (global-unset-key (kbd "C-x C-c"))

;--------------------------------------------------
; easy moves through frames
(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-x <left>") 'windmove-left)

;; ;;--------------------------------------------------
;; ;; multiple-cursors
;; ;; Start out with:
(add-to-list 'load-path "~/.emacs.d/elpa/multiple-cursors-20170908.1452")
(require 'multiple-cursors)

;; Then you have to set up your keybindings - multiple-cursors doesn't presume to
;; know how you'd like them laid out. Here are some examples:

;; When you have an active region that spans multiple lines, the following will
;; add a cursor to each line:

(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

;; When you want to add multiple cursors not based on continuous lines, but based on
;; keywords in the buffer, use:

(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

;; First mark the word, then add more cursors.

;; To get out of multiple-cursors-mode, press `<return>` or `C-g`. The latter will
;; first disable multiple regions before disabling multiple cursors. If you want to
;; insert a newline in multiple-cursors-mode, use `C-j`.

;; end of multiple-cursors
;;--------------------------------------------------

;; ------------------------------------------------------------
;; emacs shell key binding
(global-set-key [f1] 'shell)


;------------------------------------------------------------
; run emacs server -- conect using emacsclient
(server-start)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


;; ignore syntax highlighting in listings
(setq LaTeX-verbatim-environments-local '("lstlisting"))

;; language tool
;; (require 'langtool)
;; (setq langtool-language-tool-jar "/home/tom/bin/LanguageTool-3.3/languagetool-commandline.jar")
;; (setq langtool-mother-tongue "en")
;; (setq langtool-default-language "en-GB")
;; (setq langtool-disabled-rules '("WHITESPACE_RULE"
;;                                 "EN_UNPAIRED_BRACKETS"
;;                                 "COMMA_PARENTHESIS_WHITESPACE"
;;                                 "EN_QUOTES"))

;; latex preview mode
;; (setq TeX-auto-save t)
;; (setq TeX-parse-self t)
;; (setq-default TeX-master nil)
;; (load "auctex.el" nil t t)
;; (load "preview-latex.el" nil t t)


;; --------------------------------------------------
;; set default dictionary
(setq ispell-dictionary "british")    ;set the default dictionary


;; --------------------------------------------------
;; el-get setup Mon Dec  4 21:08:21 CET 2017
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.githubusercontent.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(add-to-list 'el-get-recipe-path "~/.emacs.d/el-get-user/recipes")
(el-get 'sync)

(require 'solidity-mode)


;; php-mode https://www.emacswiki.org/emacs/PhpMode
(add-to-list 'load-path "~/.emacs.d/php-mode-1.13.1")
(autoload 'php-mode "php-mode" "Major mode for editing PHP code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))
(add-hook 'php-mode-hook 'smartparens-mode)

;; use company-mode in all buffers https://company-mode.github.io/
(add-hook 'after-init-hook 'global-company-mode)
;; set a shorter delay
(setq company-idle-delay 0.1)

;; use flycheck-mode
(add-hook 'after-init-hook #'global-flycheck-mode)
;; (add-hook 'after-init-hook 'global-flycheck-mode)


(provide '.emacs)
;;; .emacs ends here
