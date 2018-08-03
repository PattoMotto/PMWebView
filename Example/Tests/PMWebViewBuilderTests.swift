import XCTest
@testable import PMWebView

final class PMWebViewBuilderTests: XCTestCase {

    func testBuilderCustom() {
        let url = URL(string: "https://www.duckduckgo.com")!
        let vc: PMWebViewController = PMWebViewBuilder.build(
            url: url,
            timeout: 5,
            duration: 1,
            output: self
        )
        let presenter = vc.output as? PMWebViewPresenter
        let router = presenter?.router as? PMWebViewRouter
        let interactor = presenter?.interactor as? PMWebViewInteractor
        let output = presenter?.output

        XCTAssertNotNil(vc)
        XCTAssertNotNil(presenter)
        XCTAssertNotNil(interactor)
        XCTAssertNotNil(router)
        XCTAssertNotNil(output)
        XCTAssertEqual(vc.duration, 1)
        XCTAssertEqual(router?.duration, 1)
        XCTAssertEqual(interactor?.timeout, 5)
    }

    func testBuilderDefault() {
        let url = URL(string: "https://www.duckduckgo.com")!
        let vc: PMWebViewController = PMWebViewBuilder.build(
            url: url,
            output: self
        )
        let presenter = vc.output as? PMWebViewPresenter
        let router = presenter?.router as? PMWebViewRouter
        let interactor = presenter?.interactor as? PMWebViewInteractor
        let output = presenter?.output

        XCTAssertNotNil(vc)
        XCTAssertNotNil(presenter)
        XCTAssertNotNil(interactor)
        XCTAssertNotNil(router)
        XCTAssertNotNil(output)
        XCTAssertEqual(vc.duration, 0.3)
        XCTAssertEqual(router?.duration, 0.3)
        XCTAssertEqual(interactor?.timeout, 1)
    }
}

extension PMWebViewBuilderTests: PMWebViewOutput {
    func webViewWillAppear() { }

    func webViewWillDisappear() { }
}
