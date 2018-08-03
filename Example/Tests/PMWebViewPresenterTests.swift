//Pat

import XCTest
@testable import PMWebView

class PMWebViewPresenterTests: XCTestCase {

    var presenter: PMWebViewPresenter!
    var interactor: PMWebViewInteractorInputMock!
    var view: PMWebViewControllerInputMock!
    var router: PMWebViewRouterInputMock!
    var output: PMWebViewOutputMock!
    private lazy var url = URL(string: "https://www.duckduckgo.com")!

    typealias ViewInvocation = PMWebViewControllerInputMock.Invocation
    typealias OutputInvocation = PMWebViewOutputMock.Invocation

    override func setUp() {
        super.setUp()
        interactor = PMWebViewInteractorInputMock()
        view = PMWebViewControllerInputMock()
        router = PMWebViewRouterInputMock()
        output = PMWebViewOutputMock()
        presenter = PMWebViewPresenter(url: url)
        presenter.interactor = interactor
        presenter.view = view
        presenter.router = router
        presenter.output = output
    }
    
    override func tearDown() {
        interactor = nil
        view = nil
        router = nil
        output = nil
        presenter = nil

        super.tearDown()
    }
    
    func testViewIsReady() {
        presenter.viewIsReady()
        XCTAssertEqual(output.invocations.count, 0)
        XCTAssertEqual(view.invocations.count, 1)
        XCTAssertEqual(view.invocations[0], ViewInvocation.createWebView)
        XCTAssertEqual(interactor.fetchDataCalledWithUrl, url)
    }

    func testRenderCompleted() {
        presenter.renderCompleted()
        XCTAssertEqual(view.invocations.count, 1)
        XCTAssertEqual(view.invocations[0], ViewInvocation.attachWebView)
        XCTAssertEqual(output.invocations.count, 1)
        XCTAssertEqual(output.invocations[0], OutputInvocation.webViewWillAppear)
    }

    func testCloseButtonDidTap() {
        presenter.closeButtonDidTap()
        XCTAssertTrue(router.dismissCalled)
        XCTAssertEqual(view.invocations.count, 0)
        XCTAssertEqual(output.invocations.count, 1)
        XCTAssertEqual(output.invocations[0], OutputInvocation.webViewWillDisappear)
    }

    func testParentViewDidTap() {
        presenter.parentViewDidTap()
        XCTAssertTrue(router.dismissCalled)
        XCTAssertEqual(view.invocations.count, 0)
        XCTAssertEqual(output.invocations.count, 1)
        XCTAssertEqual(output.invocations[0], OutputInvocation.webViewWillDisappear)
    }

    func testLoadSuccess() {
        let expectData = Data()
        presenter.loadSuccess(data: expectData)
        XCTAssertEqual(view.invocations.count, 1)
        XCTAssertEqual(output.invocations.count, 0)
        XCTAssertEqual(view.invocations[0], ViewInvocation.render(expectData, url))
    }

    func testLoadFailure() {
        presenter.loadFailure()
        XCTAssertTrue(router.dismissCalled)
        XCTAssertEqual(view.invocations.count, 0)
        XCTAssertEqual(output.invocations.count, 1)
        XCTAssertEqual(output.invocations[0], OutputInvocation.webViewWillDisappear)
    }
}
