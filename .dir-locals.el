((c++-mode . ((eval .
                    (let ((project-dir (expand-file-name (locate-dominating-file buffer-file-name ".dir-locals.el")))
                          include-dirs
                          clang-args)
                      (cond ((eq system-type 'darwin)
                             (setq include-dirs
                                   `(,(concat project-dir "")
                                     ,(concat project-dir "../../build_isolated/cartographer/install")
                                     "/usr/local/include/eigen3"
                                     "/scratch/personal/Dropbox/programming/cv/gtest/googlemock/include"
                                     "/usr/local/include"))
                             (setq clang-args '("-std=c++11" "-stdlib=libc++" "-DBOOST_NO_EXCEPTIONS" "-DNDEBUG" "-DROS_PACKAGE_NAME=\"cartographer\"" "-isysroot" "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX.sdk" "-iframework" "/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX10.12.sdk/System/Library/Frameworks")))
                            ((eq system-type 'gnu/linux)
                             (setq include-dirs
                                   `(,(concat project-dir "")
                                     ,(concat project-dir "../../build_isolated/cartographer/install")
                                     "/usr/include"
                                     "/usr/include/lua5.2"
                                     "/usr/include/eigen3"
                                     "/usr/local/include"
                                     "/usr/include/x86_64-linux-gnu"
                                     "/usr/include/clang/4.0/include"
                                     "/usr/include/c++/4.9"                            
                                     "/usr/include/x86_64-linux-gnu/c++/4.9"
                                     "/usr/lib/gcc/x86_64-linux-gnu/4.9/include-fixed"))
                             (setq clang-args '("-std=c++11" "-DBOOST_NO_EXCEPTIONS" "-DNDEBUG" "-DROS_PACKAGE_NAME=\"cartographer\""))))
                      (setq flycheck-clang-include-path include-dirs)
                      (setq flycheck-clang-warnings '("all" "extra" "no-sign-compare" "no-deprecated" "no-unused-parameter" "no-return-type"))
                      (add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))
                      (setq ac-clang-flags (append (append clang-args (mapcar (lambda (x) (concat "-I" x)) include-dirs)) '("-target-cpu" "core-avx2")))
                      (setq c-eldoc-includes (concat (mapconcat #'identity clang-args " ")
                                                     " " (mapconcat (lambda (x) (concat "-I" x)) include-dirs " ")))
                      (setq flycheck-clang-args (append clang-args '("-march=core-avx2"))))))))
