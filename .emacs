(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(blink-cursor-mode nil)
 '(cursor-type 'bar)
 '(custom-enabled-themes '(monokai-pro))
 '(custom-safe-themes
   '("b6269b0356ed8d9ed55b0dcea10b4e13227b89fd2af4452eee19ac88297b0f99" "b02eae4d22362a941751f690032ea30c7c78d8ca8a1212fdae9eecad28a3587f" "fb83a50c80de36f23aea5919e50e1bccd565ca5bb646af95729dc8c5f926cbf3" "24168c7e083ca0bbc87c68d3139ef39f072488703dcdd82343b8cab71c0f62a7" "c8b83e7692e77f3e2e46c08177b673da6e41b307805cd1982da9e2ea2e90e6d7" default))
 '(display-time-mode t)
 '(inhibit-startup-buffer-menu t)
 '(inhibit-startup-screen t)
 '(menu-bar-mode nil)
 '(package-selected-packages
   '(multiple-cursors emms emms-state company-web emmet-mode flycheck flycheck-css-colorguard yasnippet-classic-snippets react-snippets yasnippet yasnippet-snippets magit minimap monokai-pro-theme))
 '(scroll-bar-mode nil)
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Source Code Pro" :foundry "ADBO" :slant normal :weight normal :height 143 :width normal))))
 '(cursor ((t (:background "#ff0000")))))

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(put 'dired-find-alternate-file 'disabled nil)

(load-file "/home/aca/.emacs.d/web-mode.el")

(add-to-list 'load-path
             "~/.emacs.d/elpa/react-snippets-20210430.1510/")
(require 'yasnippet)
(yas-global-mode 1)

(global-flycheck-mode)
(add-hook 'after-init-hook 'global-company-mode)


;; EMMS config
(require 'emms-setup)
(emms-all)
(emms-default-players)

;; EMMS playlist
(setq emms-source-file-default-directory "~/Music/My")

(require 'company)                                   ; load company mode
(require 'company-web-html)                          ; load company mode html backend
;; and/or
(require 'company-web-jade)                          ; load company mode jade backend
(require 'company-web-slim)                          ; load company mode slim backend

;; Multiple cursors mode
(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)

;;
;;
;;

;; Web mode column highlight
(setq web-mode-enable-current-column-highlight t)
(setq web-mode-enable-current-element-highlight t)

;; Automatic loading of web-mode when opening files.
(add-to-list 'auto-mode-alist '("\\.ts\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))

;; Indentation for web-mode
(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
	(set (make-local-variable 'company-backends) '(company-css company-web-html company-yasnippet company-files))

	)
(add-hook 'web-mode-hook  'my-web-mode-hook)    
(setq tab-width 2)

;; When web-mode is loaded, load emmet.
(add-hook 'web-mode-hook  'emmet-mode)

;; Web-mode is able to switch modes into css (style tags) or js (script tags) in an html file. For Emmet to switch between html and css properly in the same document, this hook is added.

(add-hook 'web-mode-before-auto-complete-hooks
	  '(lambda ()
	     (let ((web-mode-cur-language
  		    (web-mode-language-at-pos)))
	       (if (string= web-mode-cur-language "php")
    		   (yas-activate-extra-mode 'php-mode)
      		 (yas-deactivate-extra-mode 'php-mode))
	       (if (string= web-mode-cur-language "css")
    		   (setq emmet-use-css-transform t)
      		 (setq emmet-use-css-transform nil)))))

