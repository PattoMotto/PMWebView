//Pat

import WebKit
@testable import PMWebView

final class MockWKWebView: WKWebView {
    var mockIsLoading = false
    override var isLoading: Bool {
        return mockIsLoading
    }
}

final class PMWebViewInteractorInputMock: PMWebViewInteractorInput {

    var fetchDataCalledWithUrl: URL?
    func fetchData(url: URL) {
        fetchDataCalledWithUrl = url
    }
}

final class PMWebViewRouterInputMock: PMWebViewRouterInput {

    var dismissCalled = false
    func dismiss() {
        dismissCalled = true
    }
}

final class PMWebViewOutputMock: PMWebViewOutput {

    enum Invocation: MockInvocation {
        case webViewWillAppear
        case webViewWillDisappear
    }
    var invocations = [Invocation]()

    func webViewWillAppear() {
        invocations.append(.webViewWillAppear)
    }

    func webViewWillDisappear() {
        invocations.append(.webViewWillDisappear)
    }
}

final class PMWebViewControllerOutputMock: PMWebViewControllerOutput {

    enum Invocation: MockInvocation {
        case viewIsReady
        case renderCompleted
        case closeButtonDidTap
        case parentViewDidTap
    }
    var invocations = [Invocation]()

    func viewIsReady() {
        invocations.append(.viewIsReady)
    }

    func renderCompleted() {
        invocations.append(.renderCompleted)
    }

    func closeButtonDidTap() {
        invocations.append(.closeButtonDidTap)
    }

    func parentViewDidTap() {
        invocations.append(.parentViewDidTap)
    }
}

final class PMWebViewControllerInputMock: PMWebViewControllerInput {

    enum Invocation: MockInvocation {
        case createWebView
        case render(Data, URL)
        case attachWebView
    }
    var invocations = [Invocation]()

    func createWebView() {
        invocations.append(.createWebView)
    }

    func render(data: Data, url: URL) {
        invocations.append(.render(data, url))
    }

    func attachWebView() {
        invocations.append(.attachWebView)
    }
}

protocol MockInvocation : RawRepresentable, Hashable { }
extension MockInvocation {

    init?(rawValue: String) {
        return nil
    }

    var rawValue: String {
        return "\(self)"
    }
    var hashValue: Int {
        return rawValue.hashValue
    }
}

