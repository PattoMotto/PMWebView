//Pat

import XCTest
import WebKit
@testable import PMWebView

class PMWebViewControllerTests: XCTestCase {

    var viewController: PMWebViewController!
    var output: PMWebViewControllerOutputMock!

    typealias OutputInvocation = PMWebViewControllerOutputMock.Invocation

    override func setUp() {
        super.setUp()
        output = PMWebViewControllerOutputMock()
        viewController = PMWebViewController()
        viewController.output = output
    }
    
    override func tearDown() {
        output = nil
        viewController = nil
        super.tearDown()
    }

    func testWebViewDidFinish() {
        let mockWebView = MockWKWebView()
        viewController.webView(mockWebView, didFinish: nil)
        XCTAssertEqual(output.invocations.count, 1)
        XCTAssertEqual(output.invocations[0], OutputInvocation.renderCompleted)
    }

    func testParentViewDidTap() {
        viewController.parentViewDidTap()
        XCTAssertEqual(output.invocations.count, 1)
        XCTAssertEqual(output.invocations[0], OutputInvocation.parentViewDidTap)
    }

    func testPassthroughViewDidTap() {
        viewController.passthroughViewDidTap()
        XCTAssertEqual(output.invocations.count, 1)
        XCTAssertEqual(output.invocations[0], OutputInvocation.parentViewDidTap)
    }

    func testPointInsideWithEventShouldPassThrough() {
        viewController.view.point(inside: CGPoint.zero, with: UIEvent())
        XCTAssertEqual(output.invocations.count, 2)
        XCTAssertEqual(output.invocations[0], OutputInvocation.viewIsReady)
        XCTAssertEqual(output.invocations[1], OutputInvocation.parentViewDidTap)
    }

    func testPointInsideWithEventShouldNotPassThrough() {
        _ = viewController.view
        viewController.createWebView()
        viewController.attachWebView()
        viewController.view.point(inside: CGPoint.zero, with: UIEvent())
        XCTAssertEqual(output.invocations.count, 1)
        XCTAssertEqual(output.invocations[0], OutputInvocation.viewIsReady)
    }
}
