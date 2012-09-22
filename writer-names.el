;; Generate random names from the 1990 census lists.

;; For the moment, simply output one completely random male
;; name and one completely random female name. Write to
;; minibuffer and put at end of buffer *Random Names*".

;; Possible extensions are to output a group of names, have
;; male/female selection, have selection by frequency (e.g.,
;; common, rare, etc., or by cumulative percent).

;; EDIT BELOW to reflect the location of the census name files
;; on your system. These files can be obtained from:

;; http://www.census.gov/genealogy/names/names_files.html

;; Released into the public domain.
;; Bob Newell, Honolulu, Hawai`i, April 2012.
;; Suggestions and bug reports to randomnames at bobnewell dot net.
;; No warranty, no liabilities accepted.

(defvar writer-male-names "/home/bnewell/data/census/dist.male.first")
(defvar writer-female-names "/home/bnewell/data/census/dist.female.first")
(defvar writer-last-names "/home/bnewell/data/census/dist.all.last")

(defvar writer-male-name-count nil)
(defvar writer-female-name-count nil)
(defvar writer-last-name-count nil)
(defvar writer-random-male-name nil)
(defvar writer-random-female-name nil)
(defvar writer-saved-buffer nil)
(defvar writer-saved-point nil)

(defvar random-init nil)

(defun writer-random-name ()
"Generate random names from census data"
(interactive)
  (if (not random-init)
    (progn
      (random t)
      (setq random-init t)
    )
  )
;; save-excursion gets messed, so do this:
  (setq writer-saved-buffer (current-buffer))
  (setq writer-saved-point (point))

;; Check existence of name files.
    (if (and (file-exists-p writer-male-names)
           (file-exists-p writer-female-names)
           (file-exists-p writer-last-names))
        (progn
;; All the name files exist, proceed.
;; Why do we do this over each time? Because the name file might
;; have changed.
          (find-file writer-male-names)
          (goto-char (point-max))
          (setq writer-male-name-count (line-number-at-pos))
          (find-file writer-female-names)
          (goto-char (point-max))
          (setq writer-female-name-count (line-number-at-pos))
          (find-file writer-last-names)
          (goto-char (point-max))
          (setq writer-last-name-count (line-number-at-pos))
;; We know the length of the files. Pick something out from them.
;;  Get a random male name.
          (goto-line (+ 1 (random writer-male-name-count)) (find-file writer-male-names))
	  (setq writer-random-male-name (concat (writer-extract-name) " "))
          (goto-line (+ 1 (random writer-last-name-count)) (find-file writer-last-names))
	  (setq writer-random-male-name (concat writer-random-male-name (writer-extract-name)))
;;   Get a random female name.
          (goto-line (+ 1 (random writer-female-name-count)) (find-file writer-female-names))
	  (setq writer-random-female-name (concat (writer-extract-name) " "))
          (goto-line (+ 1 (random writer-last-name-count)) (find-file writer-last-names))
          (setq writer-random-female-name (concat writer-random-female-name (writer-extract-name)))
;; Output the results.   
	  (switch-to-buffer "*Random Names*")
	  (goto-char (point-max))
          (insert (concat writer-random-male-name "   " writer-random-female-name "\n"))
          (message (concat writer-random-male-name "   " writer-random-female-name "   (also copied to buffer *Random Names*)"))
       )
;; A name file is missing.
      (message "One or more name file is missing.")
  )

;; Restore position.
  (switch-to-buffer writer-saved-buffer)
  (goto-char writer-saved-point)
)

(defun writer-extract-name ()
"Extract and fix name in census file"
;; Assume we are already at the required line.
  (beginning-of-line)
  (capitalize (thing-at-point 'word))
)
;; ---- end writer-names.el
