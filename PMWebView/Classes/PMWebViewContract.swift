//Pat

public protocol PMWebViewInput: class {
    func parentViewDidTap()
}

public protocol PMWebViewOutput: class {
    func webViewWillAppear()
    func webViewWillDisappear()
}

protocol PMWebViewControllerInput: class {
    func createWebView()
    func render(data: Data, url: URL)
    func attachWebView()
}

protocol PMWebViewControllerOutput {
    func viewIsReady()
    func renderCompleted()
    func closeButtonDidTap()
    func parentViewDidTap()
}

protocol PMWebViewInteractorInput {
    func fetchData(url: URL)
}

protocol PMWebViewInteractorOutput: class {
    func loadSuccess(data: Data)
    func loadFailure()
}

protocol PMWebViewRouterInput {
    func dismiss()
}
