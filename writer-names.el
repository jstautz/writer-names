;;; writer-names.el --- Generate random names for fiction writing

;; Filename: writer-names.el
;; Description: Generate random names for fiction writing
;; Author: Bob Newell
;; Maintainer: 
;; Copyright (C) 2012, Bob Newell
;; Created: April 2012
;; Version: 0.1
;; URL: https://github.com/jstautz/writer-names
;; Keywords: wp

;; This library is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License as
;; published by the Free Software Foundation; either version 3, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary: 

;; Writer-names.el generates random character names intended for use in
;; fiction writing.

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

;;; Code:

(setq writer-male-names nil)
(setq writer-female-names nil)
(setq writer-last-names nil)

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

;; set file locations
(setq writer-male-names (concat (file-name-directory (buffer-file-name)) "dist.male.first"))
(setq writer-female-names (concat (file-name-directory (buffer-file-name)) "dist.female.first"))
(setq writer-last-names (concat (file-name-directory (buffer-file-name)) "dist.all.last"))

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

(provide 'writer-names)

;;; writer-names.el ends here
