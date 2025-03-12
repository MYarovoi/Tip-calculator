//
//  tip_calculatorUITests.swift
//  tip-calculatorUITests
//
//  Created by Mykyta Yarovoi on 19.02.2025.
//

import XCTest

final class tip_calculatorUITests: XCTestCase {
    private var app: XCUIApplication!
    private var screen: CalculatorScreen {
        CalculatorScreen(app: app)
    }
    
    override func setUp() {
        super.setUp()
        app = .init()
        app.launch()
    }
    
    override func tearDown() {
        super.tearDown()
        app = nil
    }
    
    func testResultViewDefaultValue() {
        XCTAssertEqual(screen.totalAmontPerPErsonLabel.label, "$0")
        XCTAssertEqual(screen.totalTiplValueLabel.label, "$0")
        XCTAssertEqual(screen.totalBillValueLabel.label, "$0")
    }
    
    func testRegularTip() {
        screen.enterBill(amont: 100)
        XCTAssertEqual(screen.totalAmontPerPErsonLabel.label, "100")
        XCTAssertEqual(screen.totalBillValueLabel.label, "100")
        XCTAssertEqual(screen.totalTiplValueLabel.label, "0")
                
        screen.selectTip(tip: .tenPercent)
        XCTAssertEqual(screen.totalAmontPerPErsonLabel.label, "110")
        XCTAssertEqual(screen.totalBillValueLabel.label, "110")
        XCTAssertEqual(screen.totalTiplValueLabel.label, "10")
        
        screen.selectIncrementButton(numberOfTaps: 3)
        XCTAssertEqual(screen.totalAmontPerPErsonLabel.label, "30")
        XCTAssertEqual(screen.totalBillValueLabel.label, "120")
        XCTAssertEqual(screen.totalTiplValueLabel.label, "20")
    }
    
    func testCustomTipAndSplitBillByTwo() {
        screen.enterBill(amont: 300)
        screen.selectTip(tip: .custom(value: 200))
        screen.selectIncrementButton(numberOfTaps: 1)
        XCTAssertEqual(screen.totalAmontPerPErsonLabel.label, "250")
        XCTAssertEqual(screen.totalBillValueLabel.label, "500")
        XCTAssertEqual(screen.totalTiplValueLabel.label, "200")
    }
    
    func testResetButton() {
        screen.enterBill(amont: 300)
        screen.selectTip(tip: .custom(value: 200))
        screen.selectIncrementButton(numberOfTaps: 1)
        screen.doubleTapLogoView()
        XCTAssertEqual(screen.totalAmontPerPErsonLabel.label, "0")
        XCTAssertEqual(screen.totalBillValueLabel.label, "0")
        XCTAssertEqual(screen.totalTiplValueLabel.label, "0")
        XCTAssertEqual(screen.totalBillValueLabel.label, "")
        XCTAssertEqual(screen.splitValueLabel.label, "1")
        XCTAssertEqual(screen.totalTiplValueLabel.label, "0")
        XCTAssertEqual(screen.customTipButton.label, "Custom tip")
    }
}
