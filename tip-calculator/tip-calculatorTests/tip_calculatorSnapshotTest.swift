//
//  tip_calculatorSnapshotTest.swift
//  tip-calculatorTests
//
//  Created by Никита Яровой on 11.03.2025.
//

import XCTest
import SnapshotTesting
@testable import tip_calculator

final class tip_calculatorSnapshotTest: XCTestCase {
    private var screenshotWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    func testLogoView() {
        //given
        let size = CGSize(width: screenshotWidth, height: 48)
        //when
        let view = LogoView()
        //then
        assertSnapshot(of: view, as: .image(size: size)
//                       record: true
        )
    }
    
    func testInitialResultView() {
        //given
        let size = CGSize(width: screenshotWidth, height: 224)
        //when
        let view = ResultView()
        //then
        assertSnapshot(of: view, as: .image(size: size)
//                       record: true
        )
    }
    
    func testInitialResultViewWithValues() {
        //given
        let size = CGSize(width: screenshotWidth, height: 224)
        let result = Result(amounPerPerson: 100, totalBill: 200, totalTip: 30)
        //when
        let view = ResultView()
        view.configure(result: result)
        //then
        assertSnapshot(of: view, as: .image(size: size)
//                       record: true
        )
    }
}
