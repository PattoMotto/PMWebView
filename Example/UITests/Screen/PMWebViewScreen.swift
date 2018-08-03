//Pat

import XCTest

final class PMWebViewScreen: BaseScreen {
    let mainViewIdentifier: String = PMWebViewIdentifier.webView
    lazy var closeButton = app.buttons[PMWebViewIdentifier.closeButton]
}
