(setq user-full-name "Arthur Fücher"
      user-mail-address "arthurfucher@gmail.com")

(setq org-directory "~/org/")

(let ((nudev-emacs-path "~/dev/nu/nudev/ides/emacs/"))
  (when (file-directory-p nudev-emacs-path)
    (add-to-list 'load-path nudev-emacs-path)
    (require 'nu nil t)
    (require 'nu-datomic-query nil t)))

(setq read-process-output-max (* 1024 1024)
      doom-localleader-key "," ;; easier than <SPC m>
      ;;doom-font (font-spec :family "JetBrains Mono" :size 14)
      ;;doom-theme 'doom-monokai-pr
      confirm-kill-emacs nil)

(use-package! projectile
  :config
  (setq projectile-project-search-path '("~/dev/"
                                         "~/dev/moonshots/"
                                         "~/dev/nu/"
                                         "~/dev/nu/mini-meta-repo/packages/"
                                         "-node_modules")

        ;; Disable caching so I don't have to remember to update the known projects list from time to time
        projectile-enable-caching nil

        ;; Using a custom order for root-functions so that bottom-up comes last. This way, projects that have
        ;; subprojects will include the subprojects first, including them in the known project list.
        projectile-project-root-functions '(projectile-root-local
                                            projectile-root-top-down
                                            projectile-root-top-down-recurring
                                            projectile-root-bottom-up))

  (projectile-register-project-type 'flutter '("pubspec.yaml" ".metadata")
                                    :project-file "pubspec.yaml"
                                    :src-dir "lib/"
                                    :test-dir "test/"
                                    :test-suffix "_test"
                                    :test "flutter test"
                                    :configure "flutter pub get"
                                    :compile "flutter pub run build_runner build --delete-conflicting-outputs"))

(add-to-list 'default-frame-alist '(fullscreen . maximized))

(use-package! clojure-mode
  :config
  (setq cider-show-error-buffer t ;'only-in-repl
        clojure-indent-style 'align-arguments ;'always-align
        clojure-thread-all-but-last t
        clojure-align-forms-automatically t
        cider-font-lock-dynamically nil ; use lsp semantic tokens
        cider-eldoc-display-for-symbol-at-point nil ; use lsp
        clj-refactor-mode 1
        yas-minor-mode 1)) ; for adding require/use/import statements

(use-package! lsp-mode
  :commands lsp
  :config
  (setq lsp-semantic-tokens-enable t)
  (add-hook 'lsp-after-apply-edits-hook (lambda (&rest _) (save-buffer)))) ;; save buffers after renaming

(let ((nudev-emacs-path "~/dev/nu/nudev/ides/emacs/"))
  (when (file-directory-p nudev-emacs-path)
    (add-to-list 'load-path nudev-emacs-path)
    (require 'nu nil t)))

(use-package! cider
  :after clojure-mode
  :config
  (setq cider-font-lock-dynamically nil ; use lsp semantic tokens
        cider-eldoc-display-for-symbol-at-point nil ; use lsp
        cider-prompt-for-symbol nil
        cider-use-xref nil) ; use lsp
  (set-lookup-handlers! '(cider-mode cider-repl-mode) nil) ; use lsp
  ;; use lsp completion
  (add-hook 'cider-mode-hook (lambda () (remove-hook 'completion-at-point-functions #'cider-complete-at-point))))

(use-package! paredit
  :hook ((clojure-mode . paredit-mode)
         (emacs-lisp-mode . paredit-mode)))

(global-set-key (kbd "C-x g") 'magit-status )

(setq mac-command-key-is-meta nil)
