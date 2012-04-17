;;----------------------------------------------------------
;;一些常规设置
;;----------------------------------------------------------
;;设置备份及自动保存目录
(defvar backup-dir (expand-file-name "~/.ebackup/"))
(setq backup-directory-alist (list (cons ".*" backup-dir)))
(defvar autosave-dir (expand-file-name "~/.eautosave/"))
(setq auto-save-list-file-prefix autosave-dir)
(setq auto-save-file-name-transforms `((".*" ,autosave-dir t)))

(add-to-list 'load-path "~/.emacs.d/site-lisp")
(add-to-list 'load-path "~/.emacs.d/site-lisp/ibus")
(add-to-list 'load-path "~/.emacs.d/site-lisp/w3m")

(setq inhibit-startup-message t);;去掉启动界面
(global-linum-mode t);;显示行号
(global-hl-line-mode t);;高亮当前行
(column-number-mode t);;显示列号
(scroll-bar-mode nil);;隐藏滚动菜单
(show-paren-mode t);;显示匹配括号
(tool-bar-mode nil);;不显示工具栏
(setq visible-bell t);;关闭提示音
(setq initial-scratch-message nil);; *stratch* 缓冲区默认为空
(setq frame-title-format "%b@Emacs");;设置title为 文件名@Emacs
(mouse-avoidance-mode 'animate);;光标靠近鼠标时，鼠标自动让开
(fset 'yes-or-no-p 'y-or-n-p);;以y/n代替yes/no
(setq x-select-enable-clipboard t);;启用 复制内容到系统剪切板
(setq kill-ring-max 200)
;;(setq default-major-mode 'text-mode)
;;(transient-mark-mode t)
(iswitchb-mode t);;使用C-x b时显示所有buffer
(global-set-key (kbd "C-x C-b") 'ibuffer);;使用ibuffer管理缓冲区
(global-set-key (kbd "S-SPC") 'set-mark-command) 

;;选择矩形区域
(setq cua-enable-cua-keys nil)
(cua-mode t)

;;页面平滑滚动， scroll-margin 3 靠近屏幕边沿3行时开始滚动，可以很好的看到上下文。  
(setq scroll-margin 3  
      scroll-conservatively 10000) 

;;时间显示设置
(display-time-mode 1)
;;时间使用24小时制
(setq display-time-24hr-format t)
;;时间显示包括日期和具体时间
(setq display-time-day-and-date t)
;;时间栏旁边启用邮件设置
(setq display-time-use-mail-icon t)
;;时间的变化频率
(setq display-time-interval 10)

;;----------------------------------------------------------
;; 日历设置
;;----------------------------------------------------------
(load-file "~/.emacs.d/site-lisp/cal-china-x.el")
(require 'cal-china-x)
(setq mark-holidays-in-calendar t)
(setq cal-china-x-priority1-holidays cal-china-x-chinese-holidays)
(setq calendar-holidays cal-china-x-priority1-holidays)

;;自动识别文件编码
(load-file "~/.emacs.d/site-lisp/unicad.el")


;;----------------------------------------------------------
;;MarkDown Mode
;;----------------------------------------------------------
(autoload 'markdown-mode "~/.emacs.d/site-lisp/markdown-mode.el" "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.\\(text\\|markdown\\|md\\|mdown\\)$" . markdown-mode))
;;(setq auto-mode-alist (cons '("\\.\\(text\\|markdown\\|md\\)$" . markdown-mode) auto-mode-alist))

;;----------------------------------------------------------
;;Yasnippet
;;----------------------------------------------------------
(add-to-list 'load-path
	     "~/.emacs.d/site-lisp/yasnippet")
(require 'yasnippet)
(yas/global-mode 1)
(global-set-key [(control tab)] 'yas/expand)

;;----------------------------------------------------------
;shell,gdb退出后，自动关闭该buffer
;;----------------------------------------------------------
(add-hook 'shell-mode-hook 'mode-hook-func)
(add-hook 'gdb-mode-hook 'mode-hook-func)
(defun mode-hook-func  ()
  (set-process-sentinel (get-buffer-process (current-buffer))
			#'kill-buffer-on-exit))
(defun kill-buffer-on-exit (process state)
  (message "%s" state)
  (if (or
       (string-match "exited abnormally with code.*" state)
       (string-match "finished" state))
      (kill-buffer (current-buffer))))



;;----------------------------------------------------------
;;color theme
;;----------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/site-lisp/color-theme-6.6.0")
;;(add-to-list 'load-path "~/.emacs.d/site-lisp/color-theme-6.6.0/color-theme-solarized")
(require 'color-theme)
(color-theme-initialize)
;; (require 'color-theme-solarized)
(color-theme-tangotango)



;;----------------------------------------------------------
;;cedet
;;----------------------------------------------------------
(setq byte-compile-warnings nil)
(load-file "~/.emacs.d/site-lisp/cedet-1.1/common/cedet.elc")
(load-file "~/.emacs.d/site-lisp/cedet-1.1/semantic/bovine/semantic-gcc.elc")
;; Enabling various SEMANTIC minor modes.  See semantic/INSTALL for more ideas.
;; Select one of the following
(semantic-load-enable-code-helpers)
(semantic-load-enable-semantic-debugging-helpers)

;;代码跳转
(global-set-key [f12] 'semantic-ia-fast-jump)
;;调回原处
(global-set-key [S-f12]
                (lambda ()
                  (interactive)
                  (if (ring-empty-p (oref semantic-mru-bookmark-ring ring))
                      (error "Semantic Bookmark ring is currently empty"))
                  (let* ((ring (oref semantic-mru-bookmark-ring ring))
                         (alist (semantic-mrub-ring-to-assoc-list ring))
                         (first (cdr (car alist))))
                    (if (semantic-equivalent-tag-p (oref first tag)
                                                   (semantic-current-tag))
                        (setq first (cdr (car (cdr alist)))))
                    (semantic-mrub-switch-tags first))))

;;配置Sementic的检索范围
(setq semanticdb-project-roots 
      (list
        (expand-file-name "/")))

;;;自动补齐策略
(defun my-indent-or-complete ()
  (interactive)
  (if (looking-at "\\>")
      (hippie-expand nil)
    (indent-for-tab-command))
  )


(autoload 'senator-try-expand-semantic "senator")

(setq hippie-expand-try-functions-list
      '(
        senator-try-expand-semantic
        try-expand-dabbrev
        try-expand-dabbrev-visible
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-expand-list
        try-expand-list-all-buffers
        try-expand-line
        try-expand-line-all-buffers
        try-complete-file-name-partially
        try-complete-file-name
        try-expand-whole-kill
        )
      )


;;----------------------------------------------------------
;; 输入 inc , 可以自动提示输入文件名称,可以自动补全.
;; Provided by yangyingchao@gmail.com
;;----------------------------------------------------------
(mapc
 (lambda (mode)
   (define-abbrev-table mode '(
                               ("inc" "" skeleton-include 1)
                               )))
 '(c-mode-abbrev-table c++-mode-abbrev-table))
 
(defconst yc/inc-dir-list
  (append (semantic-gcc-get-include-paths "c++") '("./")) "nil")
(defvar inc-minibuffer-compl-list nil "nil")
 
(defun yc/update-minibuffer-complete-table ( )
  "Complete minibuffer"
  (interactive)
  (let ((prompt (minibuffer-prompt))
        (comp-part (minibuffer-contents-no-properties)))
    (when (and (string= "Include File:" prompt)
               (> (length comp-part) 0))
      (setq minibuffer-completion-table
            (append minibuffer-completion-table
                    (let ((inc-files nil)
                          (dirname nil)
                          (tmp-name nil))
                      (mapc
                       (lambda (d)
                         (setq dirname (format "%s/%s" d comp-part))
                         (when (file-exists-p dirname)
                           (mapc
                            (lambda (x)
                              (when (not (or (string= "." x)
                                             (string= ".." x)))
                                (setq tmp-name (format "%s/%s" comp-part x))
                                (add-to-list 'inc-files tmp-name)))
                            (directory-files dirname))))
                       yc/inc-dir-list)
                      inc-files)))))
  (insert "/"))
 
(let ((map minibuffer-local-completion-map))
  (define-key map "/" 'yc/update-minibuffer-complete-table))
 
(defun yc/update-inc-marks ( )
  "description"
    (let ((statement (buffer-substring-no-properties
                      (point-at-bol) (point-at-eol)))
          (inc-file nil)
          (to-begin nil)
          (to-end nil)
          (yc/re-include
           (rx "#include" (+ ascii) "|XXX|" (group (+ ascii)) "|XXX|")))
      (when (string-match yc/re-include statement)
        (setq inc-file (match-string 1 statement))
        (if (file-exists-p (format "./%s" inc-file))
            (setq to-begin "\"" to-end "\"")
          (setq to-begin "<" to-end ">")
          )
        (move-beginning-of-line 1)
        (kill-line)
        (insert (format "#include %s%s%s" to-begin inc-file to-end))
        (move-end-of-line 1))))
 
(define-skeleton skeleton-include
  "generate include<>" ""
  > "#include |XXX|"
  (completing-read
   "Include File:"
   (mapcar
    (lambda (f) (list f ))
    (apply
     'append
     (mapcar
      (lambda (dir)
        (directory-files
         dir nil
         "\\(\\.h\\)?"))
      yc/inc-dir-list))))
  "|XXX|"
  (yc/update-inc-marks))


;;----------------------------------------------------------
;; CC-mode配置  http://cc-mode.sourceforge.net/
;;----------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/site-lisp/cc-mode-5.32")
(require 'cc-mode)
(c-set-offset 'inline-open 0)
(c-set-offset 'friend '-)
(c-set-offset 'substatement-open 0)

;;;;根据后缀判断所用的mode
;;;;注意：我在这里把.h关联到了c++-mode
(setq auto-mode-alist
   (append '(("\\.h$" . c++-mode)) auto-mode-alist))

;;;;我的C/C++语言编辑策略
(defun my-c-mode-common-hook()
  (setq tab-width 4 indent-tabs-mode nil)
  ;;; hungry-delete and auto-newline
  (c-toggle-auto-hungry-state 1)
  ;;按键定义
  (define-key c-mode-base-map [(control \`)] 'hs-toggle-hiding)
  (define-key c-mode-base-map [(return)] 'newline-and-indent)
  (define-key c-mode-base-map [(f7)] 'compile)
  (define-key c-mode-base-map [(f8)] 'ff-get-other-file)
  (define-key c-mode-base-map [(meta \`)] 'c-indent-command)
  ;;(define-key c-mode-base-map [(tab)] 'hippie-expand)
  (define-key c-mode-base-map [(tab)] 'my-indent-or-complete)
  (define-key c-mode-base-map [(meta ?/)] 'semantic-ia-complete-symbol-menu)
  ;;预处理设置
  (setq c-macro-shrink-window-flag t)
  (setq c-macro-preprocessor "cpp")
  (setq c-macro-cppflags " ")
  (setq c-macro-prompt-flag t)
  (setq hs-minor-mode t)
  (setq abbrev-mode t)
  (setq tab-width 4 indent-tabs-mode nil)
  )
(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)

;;;;我的C++语言编辑策略
(defun my-c++-mode-hook()
  (setq tab-width 4 indent-tabs-mode nil)
  (c-set-style "stroustrup")
;;  (define-key c++-mode-map [f3] 'replace-regexp)
)

(add-hook 'c++-mode-hook 'my-c++-mode-hook)

;;C/C++语言启动时自动加载semantic对/usr/include的索引数据库
(setq semanticdb-search-system-databases t)
(add-hook 'c-mode-common-hook
          (lambda ()
            (setq semanticdb-project-system-databases
                  (list (semanticdb-create-database
			 semanticdb-new-database-class
			 "/usr/include")))))


;; (add-hook 'c-mode-common-hook
;;          '(lambda()
;;             ;; 插入对称的括号
;;             (make-variable-buffer-local 'skeleton-pair)
;;             (make-variable-buffer-local 'skeleton-pair-on-word)
;;             (setq skeleton-pair-on-word t)
;;             (setq skeleton-pair t)
;;             (make-variable-buffer-local 'skeleton-pair-alist)
;;             (local-set-key (kbd "(") 'skeleton-pair-insert-maybe)
;;             (local-set-key (kbd "[") 'skeleton-pair-insert-maybe)
;;             (local-set-key (kbd "{") 'skeleton-pair-insert-maybe)
;;             (local-set-key (kbd "`") 'skeleton-pair-insert-maybe)
;;             (local-set-key (kbd "\"") 'skeleton-pair-insert-maybe)
;;             ))

;; ;;ecb
;; (add-to-list 'load-path "~/.emacs.d/site-lisp/ecb-2.40")
;; (require 'ecb)
;; ;;(ecb-activate)
;; ;;(setq ecb-auto-activate t
;; ;;      ecb-tip-of-the-day nil)


;;----------------------------------------------------------
;;编译当前文件
;;----------------------------------------------------------

(global-set-key (kbd "<f9>") 'smart-compile)
(defun smart-compile()
  "比较智能的C/C++编译命令
如果当前目录有makefile则用make -k编译，否则，如果是
处于c-mode，就用gcc -Wall编译，如果是c++-mode就用
g++ -Wall编译"
  (interactive)
  ;; 查找 Makefile
  (let ((candidate-make-file-name '("makefile" "Makefile" "GNUmakefile"))
        (command nil))
    (if (not (null
              (find t candidate-make-file-name :key
                    '(lambda (f) (file-readable-p f)))))
        (setq command "make -k ")
        ;; 没有找到 Makefile ，查看当前 mode 是否是已知的可编译的模式
        (if (null (buffer-file-name (current-buffer)))
            (message "Buffer not attached to a file, won't compile!")
            (if (eq major-mode 'c-mode)
                (setq command
                      (concat "gcc -Wall -o "
                              (file-name-sans-extension
                               (file-name-nondirectory buffer-file-name))
                              " "
                              (file-name-nondirectory buffer-file-name)
                              " -g -lm "))
              (if (eq major-mode 'c++-mode)
                  (setq command
                        (concat "g++ -Wall -o "
                                (file-name-sans-extension
                                 (file-name-nondirectory buffer-file-name))
                                " "
                                (file-name-nondirectory buffer-file-name)
                                " -g -lm "))
                (message "Unknow mode, won't compile!")))))
    (if (not (null command))
        (let ((command (read-from-minibuffer "Compile command: " command)))
          (compile command)))))



;;----------------------------------------------------------
;;使用ibus输入法
;;----------------------------------------------------------

(setq ibus-python-shell-command-name "python2")

(require 'ibus)
;; Turn on ibus-mode automatically after loading .emacs
(add-hook 'after-init-hook 'ibus-mode-on)
;; Choose your key to toggle input status:
(global-set-key (kbd "C-\\") 'ibus-toggle)



;;----------------------------------------------------------
;; 音乐播放器设置
;;----------------------------------------------------------
;; (add-to-list 'load-path "/usr/share/emacs/site-lisp/emms");;; emms目录
;; (add-to-list 'exec-path "/usr/bin/mplayer/");;;mplayer目录
;; (require 'emms-setup)
;; (emms-devel)
;; ;; players
;; (setq emms-player-mpg321-command-name "mpg123"
;;       emms-player-mplayer-command-name "mplayer"
;;       emms-player-list '(emms-player-mplayer
;;                          emms-player-mplayer-playlist
;;                          emms-player-ogg123
;;                          emms-player-mpg321))
;; ;; Show the current track each time EMMS
;; ;; starts to play a track with "播放 : "
;; (add-hook 'emms-player-started-hook 'emms-show)
;; (setq emms-show-format "播放: %s")
;; ;; When asked for emms-play-directory,
;; ;; always start from this 默认的播放目录
;; ;;(setq emms-source-file-default-directory "/home/user/Music″)
;; (setq emms-playlist-buffer-name "音乐")

;; ;;;emms快捷键设置
;; (global-set-key (kbd "C-c e l") 'emms-playlist-mode-go)
;; (global-set-key (kbd "C-c e s") 'emms-start)
;; (global-set-key (kbd "C-c e e") 'emms-stop)
;; (global-set-key (kbd "C-c e n") 'emms-next)
;; (global-set-key (kbd "C-c e p") 'emms-pause)
;; (global-set-key (kbd "C-c e f") 'emms-play-playlist)
;; (global-set-key (kbd "C-c e o") 'emms-play-file)
;; (global-set-key (kbd "C-c e d") 'emms-play-directory-tree)
;; (global-set-key (kbd "C-c e a") 'emms-add-directory-tree)
;; (add-to-list 'load-path "/usr/share/emacs/site-lisp") ;;


;;----------------------------------------------------------
;;Org-mode
;;----------------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/site-lisp/org-7.8.03/lisp")
(add-to-list 'load-path "~/.emacs.d/site-lisp/org-7.8.03/contib/lisp")
(require 'org-install)
(require 'org-publish)

(add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
(add-hook 'org-mode-hook 'turn-on-font-lock)
(add-hook 'org-mode-hook 
  (lambda () (setq truncate-lines nil)))

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(setq org-log-done t)

;;日记
(setq org-publish-project-alist
      '(("note-org"
         :base-directory "~/.emacs.d/documents/notes/org"
         :publishing-directory "~/.emacs.d/documents/notes/publish_html"
      :base-extension "org"
         :recursive t
         :publishing-function org-publish-org-to-html
         :auto-index nil
         :index-filename "index.org"
         :index-title "index"
         :link-home "index.html"
         :section-numbers nil
         :style "<link rel=\"stylesheet\"
                href=\"./style/emacs.css\"
                type=\"text/css\"/>")
        ("note-static"
         :base-directory "~/.emacs.d/documents/notes/org"
         :publishing-directory "~/.emacs.d/documents/notes/publish_html"
         :recursive t
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|swf\\|zip\\|gz\\|txt\\|el"
         :publishing-function org-publish-attachment)
        ("note" 
         :components ("note-org" "note-static")
         :author "caole82@gmail.com"
         )))
;;C-c p p发布日志
(global-set-key (kbd "C-c p p") 'org-publish)


;;org-agenda
;; (setq org-agenda-files (list "~/.emacs.d/documents/todo/home.org"
;; 			     "~/.emacs.d/documents/todo/school.org"
;; 			     "~/.emacs.d/documents/todo/work.org"
;; 			     "~/.emacs.d/documents/todo/other.org"))
(setq org-agenda-files (file-expand-wildcards 
			"~/.emacs.d/documents/todo/*.org"))


;;----------------------------------------------------------
;;禁用鼠标功能
;;----------------------------------------------------------
;;from http://stackoverflow.com/a/4906698
(dolist (k '( [C-down-mouse-1]
	    ;;[mouse-1] [down-mouse-1] [drag-mouse-1] [double-mouse-1] [triple-mouse-1]  
            ;; [mouse-2] [down-mouse-2] [drag-mouse-2] [double-mouse-2] [triple-mouse-2] 
            ;; [mouse-3] [down-mouse-3] [drag-mouse-3] [double-mouse-3] [triple-mouse-3]
            ;; [mouse-4] [down-mouse-4] [drag-mouse-4] [double-mouse-4] [triple-mouse-4]
            ;; [mouse-5] [down-mouse-5] [drag-mouse-5] [double-mouse-5] [triple-mouse-5]
	     ))
  (global-unset-key k))


;;----------------------------------------------------------
;;w3m设置
;;----------------------------------------------------------
(require 'w3m-load)
(setq w3m-use-favicon nil)
(setq w3m-command-arguments '("-cookie" "-F"))
(setq w3m-use-cookies t)
(setq w3m-home-page "http://www.google.com/")
(setq w3m-display-inline-image t)

;;设置默认的浏览器
(setq browse-url-browser-function 'w3m-browse-url)
;; (setq browse-url-generic-program (executable-find "chromium" ) browse-url-browser-function 'browse-url-generic)	;;使用外部浏览器




;;----------------------------------------------------------
;; 全屏及最大化配置
;;----------------------------------------------------------
;; 参考：http://forum.ubuntu.org.cn/viewtopic.php?f=24&t=62416
;全屏
(defun my-fullscreen ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(2 "_NET_WM_STATE_FULLSCREEN" 0)))

;最大化
(defun my-maximized-horz ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(1 "_NET_WM_STATE_MAXIMIZED_HORZ" 0)))
(defun my-maximized-vert ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(1 "_NET_WM_STATE_MAXIMIZED_VERT" 0)))
(defun my-maximized ()
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(1 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
  (interactive)
  (x-send-client-message
   nil 0 nil "_NET_WM_STATE" 32
   '(1 "_NET_WM_STATE_MAXIMIZED_VERT" 0)))



;;----------------------------------------------------------
;; 等宽字体设置
;;----------------------------------------------------------

;; (create-fontset-from-fontset-spec 
;;  "-microsoft-YaHei Monaco-normal-normal-normal-*-14-*-*-*-*-*-fontset-monaco")
;; (set-default-font "fontset-monaco")
 
;; (setq default-frame-alist 
;;       (append 
;; '((font . "fontset-monaco")) default-frame-alist))

;; (set-fontset-font 
;;  "fontset-default" nil 
;;  "-unknown-WenQuanYi Micro Hei-normal-normal-normal-*-16-*-*-*-*-*-*-*" nil 'prepend) 

;; (set-fontset-font 
;; "fontset-monaco" 'han
;; "-unknown-WenQuanYi Micro Hei-normal-normal-normal-*-16-*-*-*-*-*-*-*" nil 'prepend) 

;; (set-fontset-font 
;; "fontset-monaco" 'cjk-misc
;; "-unknown-WenQuanYi Micro Hei-normal-normal-normal-*-16-*-*-*-*-*-*-*" nil 'prepend) 

;; (set-fontset-font 
;; "fontset-monaco" 'kana
;; "-unknown-WenQuanYi Micro Hei-normal-normal-normal-*-16-*-*-*-*-*-*-*" nil 'prepend) 

;; (set-fontset-font 
;; "fontset-monaco" 'bopomofo
;; "-unknown-WenQuanYi Micro Hei-normal-normal-normal-*-16-*-*-*-*-*-*-*" nil 'prepend) 
