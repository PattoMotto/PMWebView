//Pat

import Foundation

class PMWebViewPresenter {

    weak var view: PMWebViewControllerInput?
    var router: PMWebViewRouterInput?
    var interactor: PMWebViewInteractorInput?
    weak var output: PMWebViewOutput?
    var isDismiss = false

    private var url: URL

    init(url: URL) {
        self.url = url
    }

    private func dismiss() {
        guard !isDismiss else { return }
        output?.webViewWillDisappear()
        router?.dismiss()
        isDismiss = true
    }

    private func runOnMainThread(closure: @escaping () -> Void ) {
        if Thread.isMainThread {
            closure()
        } else {
            DispatchQueue.main.async(execute: closure)
        }
    }
}

extension PMWebViewPresenter: PMWebViewControllerOutput {

    func viewIsReady() {
        view?.createWebView()
        interactor?.fetchData(url: url)
    }

    func renderCompleted() {
        guard !isDismiss else { return }
        view?.attachWebView()
        output?.webViewWillAppear()
    }

    func closeButtonDidTap() {
        dismiss()
    }

    func parentViewDidTap() {
        dismiss()
    }
}

extension PMWebViewPresenter: PMWebViewInteractorOutput {
    
    func loadSuccess(data: Data) {
        runOnMainThread { [weak self] in
            guard let strongSelf = self,
                !strongSelf.isDismiss else { return }
            strongSelf.view?.render(
                data: data,
                url: strongSelf.url
            )
        }
    }

    func loadFailure() {
        runOnMainThread { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.dismiss()
        }
    }
}
