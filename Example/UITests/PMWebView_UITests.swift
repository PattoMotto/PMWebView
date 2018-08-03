//Pat

import XCTest

class PMWebView_UITests: XCTestCase {

    private var app: XCUIApplication!
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    override func tearDown() {
        app.terminate()
        app = nil

        super.tearDown()
    }
    
    func testOpenModal() {
        mainScreen.waitToPresent()
        mainScreen.modalButton.tap()
        pmWebViewScreen.waitToPresent()
        pmWebViewScreen.closeButton.tap()
    }

    func testOpenChild() {
        mainScreen.waitToPresent()
        mainScreen.childButton.tap()
        pmWebViewScreen.waitToPresent()
        pmWebViewScreen.closeButton.tap()
    }

    func testOpenModalInterrupt() {
        mainScreen.waitToPresent()
        mainScreen.modalButton.tap()
        app.swipeUp()
        app.swipeDown()
        mainScreen.waitToPresent()
    }

    func testOpenChildInterrupt() {
        mainScreen.waitToPresent()
        mainScreen.childButton.tap()
        mainScreen.interruptButton.tap()
        mainScreen.waitToPresent()
    }
}
