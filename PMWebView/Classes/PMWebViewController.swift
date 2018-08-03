//Pat

import Foundation
import WebKit

open class PMWebViewController: UIViewController {

    var output: PMWebViewControllerOutput?
    var duration: TimeInterval = 0

    private let closeButtonSize = CGFloat(25)
    private let margin = CGFloat(8)
    private var isAttachView = false

    private var webView: WKWebView?
    lazy var closeButton: UIButton = {
        let button = UIButton()
        button.accessibilityIdentifier = PMWebViewIdentifier.closeButton
        button.setTitle("✕", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .black
        button.layer.cornerRadius = 0.5 * closeButtonSize
        button.clipsToBounds = true
        return button
    }()

    deinit {
        webView?.stopLoading()
        webView?.navigationDelegate = nil
        webView = nil
    }

    open override func loadView() {
        let passthroughView = PassthroughView()
        passthroughView.output = self
        view = passthroughView
    }

    open override func viewDidLoad() {
        super.viewDidLoad()
        view.alpha = 0
        output?.viewIsReady()
    }

    override open func removeFromParentViewController() {
        view.removeFromSuperview()
        super.removeFromParentViewController()
    }

    open override func didMove(toParentViewController parent: UIViewController?) {
        if parent != nil {
            view.removeFromSuperview()
        }
        super.didMove(toParentViewController: parent)
    }
}

extension PMWebViewController {

    private func attachView() {
        guard !isAttachView,
            let parentView = parent?.view else { return }
        parentView.addSubview(view)
        setupConstraint()
        isAttachView = true
    }

    private func setupConstraint() {
        guard let parentView = parent?.view else { return }
        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height).isActive = true
        view.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width).isActive = true
        view.topAnchor.constraint(equalTo: parentView.topAnchor).isActive = true
        view.leadingAnchor.constraint(equalTo: parentView.leadingAnchor).isActive = true
    }

    private func disableDoubleTapGestureRecognizer(_ webView: WKWebView) {
        webView.scrollView.subviews.forEach { view in
            view.gestureRecognizers?.forEach { gestureRecognizer in
                if let tapGestureRecognizer = gestureRecognizer as? UITapGestureRecognizer,
                    tapGestureRecognizer.numberOfTapsRequired == 2,
                    tapGestureRecognizer.numberOfTouchesRequired == 1 {
                    tapGestureRecognizer.isEnabled = false
                }
            }
        }
    }

    private func disableZoom(_ webView: WKWebView) {
        webView.scrollView.minimumZoomScale = 1.0
        webView.scrollView.maximumZoomScale = 1.0
    }

    private func disablePassthroughView() {
        if let passthroughView = view as? PassthroughView {
            passthroughView.shouldPassthrough = false
        }
    }

    @objc func closeDidTap() {
        closeButton.spin(duration: duration)
        output?.closeButtonDidTap()
    }
}

extension PMWebViewController: PMWebViewControllerInput {

    func createWebView() {
        if let curWebView = webView {
            curWebView.navigationDelegate = nil
            curWebView.removeFromSuperview()
        }
        let newWebView = WKWebView(frame: UIScreen.main.bounds)
        newWebView.accessibilityIdentifier = PMWebViewIdentifier.webView
        newWebView.alpha = 0
        newWebView.scrollView.isScrollEnabled = false;
        newWebView.scrollView.bounces = false;
        newWebView.navigationDelegate = self;
        disableDoubleTapGestureRecognizer(newWebView)
        disableZoom(newWebView)
        webView = newWebView
    }

    func render(data: Data, url: URL) {
        guard let webView = webView else { return }
        webView.load(
            data,
            mimeType: "text/html",
            characterEncodingName: "utf-8",
            baseURL: url
        )
    }

    func attachWebView() {
        guard let webView = webView else { return }
        disablePassthroughView()
        attachView()
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        webView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        view.addSubview(closeButton)
        if #available(iOS 11.0, *) {
            closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: margin).isActive = true
        } else {
            closeButton.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: margin).isActive = true
        }
        closeButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -margin).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: closeButtonSize).isActive = true
        closeButton.heightAnchor.constraint(equalToConstant: closeButtonSize).isActive = true
        closeButton.addTarget(self, action: #selector(closeDidTap), for: .touchUpInside)
        closeButton.spin(duration: duration)
        webView.fadeIn(duration: duration)
        view.fadeIn(duration: duration)
    }
}

extension PMWebViewController: WKNavigationDelegate {

    public func webView(_ webView: WKWebView,
                 didFinish navigation: WKNavigation!) {
        guard !webView.isLoading,
            webView.superview == nil else { return }
        output?.renderCompleted()
    }
}

extension PMWebViewController: PMWebViewInput {

    public func parentViewDidTap() {
        output?.parentViewDidTap()
    }
}

extension PMWebViewController: PassthroughViewOutput {
    func passthroughViewDidTap() {
        output?.parentViewDidTap()
    }
}

class PassthroughView: UIView {

    var shouldPassthrough = true
    var output: PassthroughViewOutput?

    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        guard shouldPassthrough else { return true }
        output?.passthroughViewDidTap()
        return subviews.map{
            !$0.isHidden && $0.isUserInteractionEnabled && $0.point(inside: point, with: event)
            }.reduce(false) { $0 || $1 }
    }
}

protocol PassthroughViewOutput {
    func passthroughViewDidTap()
}
