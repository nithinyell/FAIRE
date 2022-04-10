//
//  FaireUITests.swift
//  FaireUITests
//
//  Created by Nithin 3 on 09/04/22.
//

import XCTest

class FaireUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAppLaunch() {
        let app = XCUIApplication()
        app.launch()
    }
    
    func testTableView() {
        let app = XCUIApplication()
        app.launch()
        
        let table = app.tables.element(boundBy: 0)
        let lastCell = table.cells.element(boundBy: table.cells.count-1)
        table.scrollToElement(element: lastCell)
    }
}

extension XCUIElement {

    func scrollToElement(element: XCUIElement) {
        while !element.visible() {
            swipeUp()
        }
    }

    func visible() -> Bool {
        guard self.exists && !self.frame.isEmpty else { return false }
        return XCUIApplication().windows.element(boundBy: 0).frame.contains(self.frame)
    }
    
    func forceTap() {
           coordinate(withNormalizedOffset: CGVector(dx:0.5, dy:0.5)).tap()
       }
}
