(defun color-theme-gruber-darker ()
  "Gruber Darker color theme for Emacs by Jason Blevins.
A darker variant of the Gruber Dark theme for BBEdit
by John Gruber."
  (interactive)
  (color-theme-install
   '(color-theme-gruber-darker
     ((foreground-color . "#e4e4ef")
      (background-color . "#2d2d2d") ;#181818
      (background-mode . dark)
      ;; (cursor-color . "#ffdd33") ; by Pocoyo
      (cursor-color . "#1f75c0")
      (mouse-color . "#ffdd33"))
     
     ;; Standard font lock faces
     (default ((t (nil))))
     (font-lock-comment-face ((t (:foreground "#cc8c3c"))))
     (font-lock-comment-delimiter-face ((t (:foreground "#cc8c3c"))))
     (font-lock-doc-face ((t (:foreground "#73c936"))))
     (font-lock-doc-string-face ((t (:foreground "#73c936"))))
     (font-lock-string-face ((t (:foreground "#73c936"))))
     (font-lock-keyword-face ((t (:foreground "#ffdd33"))))
     (font-lock-builtin-face ((t (:foreground "#ffdd33"))))
     (font-lock-function-name-face ((t (:foreground "#96a6c8"))))
     (font-lock-variable-name-face ((t (:foreground "#f4f4ff"))))
     (font-lock-preprocessor-face ((t (:foreground "#95a99f"))))
     (font-lock-constant-face ((t (:foreground "#95a99f"))))
     (font-lock-type-face ((t (:foreground "#95a99f"))))
     (font-lock-warning-face ((t (:foreground "#f43841"))))
     (font-lock-reference-face ((t (:foreground "#95a99f"))))
     (trailing-whitespace ((t (:foreground "#000" :background "#f43841"))))
     (link ((t (:foreground "#96A6C8" :underline t))))
     
     (erc-action-face ((t (:bold t :foreground "magenta"))))
     (erc-direct-msg-face ((t (:bold t))))
     (erc-private-msg-face ((t (:bold t))))
     ;; (erc-bold-face ((t (:bold t))))
     ;; (erc-default-face ((t (nil))))
     ;; (erc-direct-msg-face ((t (:foreground "sandybrown"))))
     ;; (erc-error-face ((t (:bold t :foreground "IndianRed"))))
     (erc-default-face ((t (:foreground "#cc8c3c"))))
     (erc-timestamp-face ((t (:bold t :underline nil :foreground "#73c936"))))
     (erc-input-face ((t (:bold t  :foreground "#00e093"))))
     (erc-my-nick-face ((t (:foreground "#f4f4ff" :background "#802080"))))
     (erc-prompt-face ((t (:bold t :foreground "#00e093" :background nil))))
     ;;; (erc-pal-face ((t (:foreground "Magenta" :box nil :underline t :weight bold))))

     ;; diredplus faces
     (diredp-date-time ((t (:foreground "#bd9c5f"))))
     ;; (diredp-file-suffix-time ((t (:foreground "tomato"))))
     ;; (diredp-display-msg ((t (:foreground "tomato"))))
     (diredp-file-name ((t (:foreground "#98fb98"))))
     (diredp-file-suffix ((t (:foreground "#00e093"))))
     (diredp-ignored-file-name ((t (:foreground "#00006DE06DE0"))))
     (diredp-number ((t (:foreground "#9acd32"))))

     ;; (diredp-exec-priv ((t (:background "#000000"))))
     ;; (diredp-read-priv ((t (:background "#000000"))))
     ;; (diredp-write-priv ((t (:background "#000000"))))
     ;; (diredp-no-priv ((t (:background "#000000"))))
     ;; (diredp-rar-priv ((t (:foreground "Magenta" :background "#000000"))))
     ;; (diredp-dir-heading ((t (:foreground "Blue" :background "#0f1829"))))
     ;; (diredp-ignored-file-name ((t (:foreground "tomato"))))
     (diredp-dir-priv ((t (:foreground "#729fcf"))))
     (diredp-flag-mark-line ((t (:foreground "#00BFFF" :background "black"))))

     ;;      `diredp-compressed-file-suffix', `diredp-date-time',
     ;; `diredp-deletion', `diredp-deletion-file-name',
     ;; `diredp-dir-heading', `diredp-dir-priv', `diredp-display-msg',
     ;; `diredp-exec-priv', `diredp-executable-tag', `diredp-file-name',
     ;; `diredp-file-suffix', `diredp-flag-mark',
     ;; `diredp-flag-mark-line', `diredp-get-file-or-dir-name',
     ;; `diredp-ignored-file-name', `diredp-link-priv',
     ;; `diredp-no-priv', `diredp-number', `diredp-other-priv',
     ;; `diredp-rare-priv', `diredp-read-priv', `diredp-symlink',
     ;; `diredp-write-priv'.

     ;; Search
     (isearch ((t (:foreground "darkblue" :background "yellow"))))
     (isearch-lazy-highlight-face ((t (:foreground "#f4f4ff" :background "#5f627f"))))
     (isearch-fail ((t (:foreground "#000" :background "#f43841"))))
     
     ;; User interface
     (fringe ((t (:background "#111" :foreground "#444"))))
     (border ((t (:background "#111" :foreground "#444"))))
     (mode-line ((t (:background "#453d41" :foreground "#fff"))))
     (mode-line-buffer-id ((t (:background "#453d41" :foreground "#fff"))))
     (mode-line-inactive ((t (:background "#453d41" :foreground "#999"))))
     (minibuffer-prompt ((t (:foreground "#96A6C8"))))
     (region ((t (:background "#484848"))))
     (secondary-selection ((t (:background "#484951" :foreground "#F4F4FF"))))
     (tooltip ((t (:background "#52494e" :foreground "#fff"))))
     
     ;; Parenthesis matching
     (show-paren-match-face ((t (:background "#52494e" :foreground "#f4f4ff"))))
     (show-paren-mismatch-face ((t (:foreground "#f4f4ff" :background "#c73c3f"))))
     ;; Line highlighting
     (highlight ((t (:background "#282828" :foreground nil))))
     (highlight-current-line-face ((t (:background "#282828" :foreground nil))))
     
     ;; Calendar
     (holiday-face ((t (:foreground "#f43841"))))
     
     ;; Info
     (info-xref ((t (:foreground "#96a6c8"))))
     (info-visited ((t (:foreground "#9e95c7"))))
     
     ;; AUCTeX
     (font-latex-sectioning-5-face ((t (:foreground "#96a6c8" :bold t))))
     (font-latex-bold-face ((t (:foreground "#95a99f" :bold t))))
     (font-latex-italic-face ((t (:foreground "#95a99f" :italic t))))
     (font-latex-math-face ((t (:foreground "#73c936"))))
     (font-latex-string-face ((t (:foreground "#73c936"))))
     (font-latex-warning-face ((t (:foreground "#f43841"))))
     (font-latex-slide-title-face ((t (:foreground "#96a6c8"))))
     )))

