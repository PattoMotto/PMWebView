//Pat

import XCTest
@testable import PMWebView

final class PMWebViewRouterTests: XCTestCase {

    var viewController: MockViewController!
    override func setUp() {
        super.setUp()
        viewController = MockViewController()
    }
    
    override func tearDown() {
        viewController = nil
        super.tearDown()
    }
    
    func testDismissChildViewController() {
        viewController.mockParent = viewController
        let router = PMWebViewRouter()
        router.viewController = viewController
        router.dismiss()
        XCTAssertTrue(viewController.removeFromParentViewControllerCalled)
    }

    func testDismissModalViewController() {
        let router = PMWebViewRouter()
        router.viewController = viewController
        router.dismiss()
        XCTAssertTrue(viewController.dismissCalled)
    }

    class MockViewController: UIViewController {

        var mockParent: UIViewController?
        override var parent: UIViewController? {
            return mockParent
        }

        var removeFromParentViewControllerCalled = false
        override func removeFromParentViewController() {
            removeFromParentViewControllerCalled = true
        }

        var dismissCalled = false
        override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
            dismissCalled = true
        }
    }
}

