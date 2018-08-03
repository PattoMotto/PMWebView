//Pat

class PMWebViewRouter: PMWebViewRouterInput {

    weak var viewController: UIViewController?
    var duration: TimeInterval = 0

    func dismiss() {
        guard duration > 0 else {
            if viewController?.parent != nil {
                viewController?.removeFromParentViewController()
            } else {
                viewController?.dismiss(animated: false)
            }
            return
        }
        DispatchQueue.main.async { [weak self] in
            if self?.viewController?.parent != nil {
                self?.fadeOutAndRemoveFromParentView()
            } else {
                self?.viewController?.dismiss(animated: true)
            }
        }
    }

    private func fadeOutAndRemoveFromParentView() {
        viewController?.view.fadeOut(duration: duration) { [weak self] _ in
            self?.viewController?.removeFromParentViewController()
        }
    }
}
