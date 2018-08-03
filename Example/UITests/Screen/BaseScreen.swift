//Pat

import XCTest

protocol BaseScreen {
    var mainViewIdentifier: String { get }
}

extension BaseScreen {
    var app: XCUIApplication {
        return XCUIApplication()
    }

    func waitToPresent() {
        let mainView = app.otherElements[mainViewIdentifier]
        XCTAssertTrue(mainView.waitForExistence(timeout: 10))
    }
}
