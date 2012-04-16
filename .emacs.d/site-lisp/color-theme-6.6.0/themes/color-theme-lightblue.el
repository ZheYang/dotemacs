(eval-when-compile
  (require 'color-theme))
	

(defun color-theme-lightblue ()
  (interactive)
  (color-theme-install
   '(color-theme-lightblue
      ((background-color . "#2f4f4f")
      (background-mode . light)
      (border-color . "#666060")
      (cursor-color . "#86857e")
      (foreground-color . "#f3f3f1")
      (mouse-color . "black"))
     (fringe ((t (:background "#666060"))))
     (mode-line ((t (:foreground "#eeeeec" :background "#000000"))))
     (region ((t (:background "#5c5c5c"))))
     (font-lock-builtin-face ((t (:foreground "#2b82de"))))
     (font-lock-comment-face ((t (:foreground "#888a85"))))
     (font-lock-function-name-face ((t (:foreground "#ffe71a"))))
     (font-lock-keyword-face ((t (:foreground "#2589f4"))))
     (font-lock-string-face ((t (:foreground "#41c200"))))
     (font-lock-type-face ((t (:foreground"#f16575"))))
     (font-lock-variable-name-face ((t (:foreground "#eeeeec"))))
     (minibuffer-prompt ((t (:foreground "#00c70f" :bold t))))
     (font-lock-warning-face ((t (:foreground "Red" :bold t))))
     )))
(provide 'color-theme-lightblue)
;;; color-theme-lightblue.el ends here
