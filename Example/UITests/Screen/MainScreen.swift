//Pat

import XCTest

final class MainScreen: BaseScreen {
    
    let mainViewIdentifier = MainScreenIdentifier.mainView
    lazy var modalButton = app.buttons[MainScreenIdentifier.modalButton]
    lazy var childButton = app.buttons[MainScreenIdentifier.childButton]
    lazy var interruptButton = app.buttons[MainScreenIdentifier.interruptButton]
}
