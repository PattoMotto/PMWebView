//Pat

extension UIView {

    func spin(duration: TimeInterval,
              completion: ((Bool) -> Void)? = nil) {
        guard  duration > 0 else {
            alpha = 1
            completion?(true)
            return
        }

        let initialTransform = CGAffineTransform(rotationAngle: 0)
        let targetTransform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        let animation = {
            if self.transform  == initialTransform {
                self.transform = targetTransform
            } else {
                self.transform = initialTransform
            }
        }

        UIView.animate(
            withDuration: duration,
            animations: animation,
            completion: completion
        )
    }

    func fadeIn(duration: TimeInterval,
                completion: ((Bool) -> Void)? = nil) {
        guard  duration > 0 else {
            alpha = 1
            completion?(true)
            return
        }
        let animation = {
            self.alpha = 1
        }

        UIView.animate(
            withDuration: duration,
            animations: animation,
            completion: completion
        )
    }

    func fadeOut(duration: TimeInterval,
                 completion: ((Bool) -> Void)? = nil) {
        guard  duration > 0 else {
            alpha = 0
            completion?(true)
            return
        }
        let animation = {
            self.alpha = 0
        }

        UIView.animate(
            withDuration: duration,
            animations: animation,
            completion: completion
        )
    }
}
