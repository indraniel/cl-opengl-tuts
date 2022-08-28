(ql:quickload :cl-nextstep)
(ql:quickload :cl-glut)
(ql:quickload :cl-glu)

(defclass gl-view (ns:opengl-view)
  ())

(defmethod ns:draw ((view gl-view))
  (let* ((w (ns:width view))
         (h (ns:height view)))
    (gl:viewport 0 0 w h)
    (gl:clear-color .0 .0 .3 1.0)
    (gl:clear :color-buffer-bit)
    (gl:matrix-mode :projection)
    (gl:load-identity)
    (glu:perspective 45.0 (/ w h) .1 100.0)
    (gl:matrix-mode :modelview)
    (gl:load-identity)
    (glu:look-at .0 .0 10.0 .0 .0 .0 .0 1.0 .0)
      (gl:rotate (* .0001 (get-internal-real-time)) .0 1.0 .0)
    (glut:wire-cube 1.0))) 

(defun make-complex-window ()
  (ns:with-event-loop nil
    (let* ((win (make-instance 'ns:window 
                               :x 0
                               :y 800
                               :w 800
                               :h 600
                               :title "SBCL Window"))
           (view (make-instance 'gl-view :animate t)))
      (setf (ns:content-view win) view)
      (ns:window-show win))))

(defun make-simple-window ()
  (ns:with-event-loop nil
    (let* ((win (make-instance 'ns:window 
                               :x 0
                               :y 800
                               :w 800
                               :h 600
                               :title "SBCL Window")))
      (ns:window-show win))))


(ns:start-event-loop)

;(make-simple-window)
(make-complex-window)

;(ns:window-close)
(ns:quit)
