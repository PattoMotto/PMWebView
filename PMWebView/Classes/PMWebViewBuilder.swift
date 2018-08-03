//Pat

public struct PMWebViewBuilder {

    public static func build(url: URL,
                             timeout: TimeInterval = 1,
                             duration: TimeInterval = 0.3,
                             output: PMWebViewOutput? = nil) -> PMWebViewController {
        let viewController = PMWebViewController()
        let router = PMWebViewRouter()
        let presenter = PMWebViewPresenter(url: url)
        let interactor = PMWebViewInteractor()

        presenter.output = output
        presenter.router = router
        presenter.view = viewController
        presenter.interactor = interactor
        router.viewController = viewController
        interactor.output = presenter
        viewController.output = presenter

        interactor.timeout = timeout
        router.duration = duration
        viewController.duration = duration

        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationStyle = .overCurrentContext
        return viewController
    }
}
