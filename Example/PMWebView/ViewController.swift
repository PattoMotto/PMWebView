//Pat

import UIKit
import PMWebView

class ViewController: UIViewController {

    private lazy var url = URL(string: "https://www.duckduckgo.com")!
    private lazy var childButton = UIButton()
    private lazy var modalButton = UIButton()

    private weak var pmWebViewInput: PMWebViewInput?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.accessibilityIdentifier = MainScreenIdentifier.mainView
        view.backgroundColor = .white
        setupButtonChild()
        setupButtonModal()
        setupButtonInterrupt()
    }

    private func setupButtonInterrupt() {
        let interruptButton = UIButton()
        interruptButton.accessibilityIdentifier = MainScreenIdentifier.interruptButton
        interruptButton.translatesAutoresizingMaskIntoConstraints = false
        interruptButton.setTitle("Interrupt PMWebView", for: .normal)
        interruptButton.setTitleColor(.blue, for: .normal)
        interruptButton.addTarget(self, action: #selector(interruptDidTap), for: .touchUpInside)
        view.addSubview(interruptButton)
        interruptButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        interruptButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 50).isActive = true
    }

    private func setupButtonModal() {
        modalButton.accessibilityIdentifier = MainScreenIdentifier.modalButton
        modalButton.setTitle("Open PMWebView modal view", for: .normal)
        modalButton.setTitleColor(.orange, for: .normal)
        modalButton.setTitleColor(.lightGray, for: .disabled)
        modalButton.addTarget(self, action: #selector(buttonModalDidTap), for: .touchUpInside)
        modalButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(modalButton)
        modalButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        modalButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }

    private func setupButtonChild() {
        childButton.accessibilityIdentifier = MainScreenIdentifier.childButton
        childButton.setTitle("Open PMWebView child view", for: .normal)
        childButton.setTitleColor(.red, for: .normal)
        childButton.setTitleColor(.lightGray, for: .disabled)
        childButton.addTarget(self, action: #selector(buttonChildDidTap), for: .touchUpInside)
        childButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(childButton)
        childButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        childButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50).isActive = true
    }

    @objc func interruptDidTap() {
        print("interruptDidTap")
        pmWebViewInput?.parentViewDidTap()
    }

    @objc func buttonChildDidTap() {
        childButton.fadeOut(duration: 0.3)
        childButton.isEnabled = false
        presentPMWevViewAsChild()
    }

    @objc func buttonModalDidTap() {
        modalButton.fadeOut(duration: 0.3)
        modalButton.isEnabled = false
        presentPMWevViewAsModal()
    }

    private func presentPMWevViewAsChild() {
        let vc = PMWebViewBuilder.build(
            url: url,
            output: self
        )
        pmWebViewInput = vc
        addChildViewController(vc)
        vc.didMove(toParentViewController: self)
    }

    private func presentPMWevViewAsModal() {
        let vc = PMWebViewBuilder.build(
            url: url,
            output: self
        )
        pmWebViewInput = vc
        present(vc, animated: true)
    }
}

extension ViewController: PMWebViewOutput {
    func webViewWillAppear() {
        print("webViewWillAppear")
    }

    func webViewWillDisappear() {
        print("webViewWillDisappear")

        childButton.isEnabled = true
        childButton.fadeIn(duration: 0.3)

        modalButton.isEnabled = true
        modalButton.fadeIn(duration: 0.3)
    }
}

private extension UIView {
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
