;; init.el --- Emacs configuration                                           

;; INSTALL PACKAGES
;; --------------------------------------

(require 'package)

(add-to-list 'package-archives
       '("melpa-stable" . "http://stable.melpa.org/packages/"))

(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(defvar myPackages
  '(better-defaults
    atom-one-dark-theme
    elpy
    flycheck
    py-autopep8
    markdown-mode
    rainbow-mode
    auctex))

(mapc #'(lambda (package)
    (unless (package-installed-p package)
      (package-install package)))
      myPackages)

;; BASIC CUSTOMIZATION
;; --------------------------------------

;; Hide the annoying warning sign...
(setq visible-bell nil)

;; Tabs are 4 spaces
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; Hide startup messages
(setq inhibit-startup-message t)

;; Load theme only when in GUI
(when (display-graphic-p)
  (load-theme 'atom-one-dark t))


;; Enable line numbers globally
(global-linum-mode t)
(setq linum-format "%4d \u2502 ")

;; Show column numbers too
(setq column-number-mode t)

;; Set font
(set-face-attribute 'default nil :font "Ubuntu Mono-14")

;; Add 72 and 79 Col indicator (PEP8 standard)
(setq-default header-line-format
              (list "      +"
                    (make-string 72 ?-) "|" (make-string 5 ?-) "|"))

;; Use count-words on entire buffer when no region is highlighted
(global-set-key (kbd "M-=") 'count-words)

;; Function to figure out what face im looking at:
(defun what-face (pos)
  (interactive "d")
  (let ((face (or (get-char-property (pos) 'read-face-name)
                  (get-char-property (pos) 'face))))
    (if face (message "Face: %s" face) (message "No face at %d" pos))))

;; PYTHON CONFIGURATION
;; --------------------------------------

(elpy-enable)

;; use flycheck not flymake with elpy
(when (require 'flycheck nil t)
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  (add-hook 'elpy-mode-hook 'flycheck-mode))

;; flycheck was too slow by default
(setq flycheck-highlighting-mode 'lines)

;; Disable tab highlighting
(add-hook 'elpy-mode-hook (lambda () (highlight-indentation-mode -1)))

;; Enable python interpreter
(setq python-shell-interpreter "python"
      python-shell-interpreter-args "-i")

;; MARKDOWN CONFIGURATION
;; ------------------------------------
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

(autoload 'gfm-mode "markdown-mode"
   "Major mode for editing GitHub Flavored Markdown files" t)
(add-to-list 'auto-mode-alist '("README\\.md\\'" . gfm-mode))


;; CSS CONFIGURATION
;; ------------------------------------
(add-hook 'css-mode #'rainbow-mode)


;; LaTeX CONFIGURATION
;; ------------------------------------
(require 'tex-site)
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(add-hook 'LaTeX-mode-hook #'visual-line-mode)

;; init.el ends here

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (rainbow-mode py-autopep8 flycheck elpy atom-one-dark-theme better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(company-tooltip-selection ((t nil))))
