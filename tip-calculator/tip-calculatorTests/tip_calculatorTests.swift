//
//  tip_calculatorTests.swift
//  tip-calculatorTests
//
//  Created by Mykyta Yarovoi on 19.02.2025.
//

import XCTest
@testable import tip_calculator
import Combine

final class tip_calculatorTests: XCTestCase {
    private var sut: CalculatorVM!
    private var cancellables: Set<AnyCancellable>!
    private var logoViewTapSubject: PassthroughSubject<Void, Never>!
    private var audioPlayerService: MockAudioPlayerService!
    
    override func setUp() {
        audioPlayerService = .init()
        sut = .init(audioPlayerService: audioPlayerService)
        logoViewTapSubject = .init()
        cancellables = .init()
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        cancellables = nil
        audioPlayerService = nil
        logoViewTapSubject = nil
    }
    
    func testResultWithoutTipFor1Person() {
        //given
        let bill: Double = 100.0
        let tip: Tip = .none
        let split: Int = 1
        let input = billInput(bill: bill, tip: tip, split: split)
        //when
        let output = sut.transofr(input: input)
        //then
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amounPerPerson, 100)
            XCTAssertEqual(result.totalBill, 100)
            XCTAssertEqual(result.totalTip, 0)
        }.store(in: &cancellables)
    }
    
    func testResultWithoutTipFor2Person() {
        //given
        let bill: Double = 100.0
        let tip: Tip = .none
        let split: Int = 2
        let input = billInput(bill: bill, tip: tip, split: split)
        //when
        let output = sut.transofr(input: input)
        //then
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amounPerPerson, 50)
            XCTAssertEqual(result.totalBill, 100)
            XCTAssertEqual(result.totalTip, 0)
        }.store(in: &cancellables)
    }
    
    func testResultWith10PercentTipFor2Person() {
        //given
        let bill: Double = 100.0
        let tip: Tip = .custom(value: 20)
        let split: Int = 4
        let input = billInput(bill: bill, tip: tip, split: split)
        //when
        let output = sut.transofr(input: input)
        //then
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amounPerPerson, 30)
            XCTAssertEqual(result.totalBill, 120)
            XCTAssertEqual(result.totalTip, 20)
        }.store(in: &cancellables)
    }
    
    func testResultWithCustomTipFor4Person() {
        //given
        let bill: Double = 100.0
        let tip: Tip = .tenPercent
        let split: Int = 2
        let input = billInput(bill: bill, tip: tip, split: split)
        //when
        let output = sut.transofr(input: input)
        //then
        output.updateViewPublisher.sink { result in
            XCTAssertEqual(result.amounPerPerson, 55)
            XCTAssertEqual(result.totalBill, 110)
            XCTAssertEqual(result.totalTip, 10)
        }.store(in: &cancellables)
    }
    
    func testPlayedAndCalculatorResetInLogoViewTap() {
        //given
        let input = billInput(bill: 100, tip: .tenPercent, split: 2)
        let output = sut.transofr(input: input)
        let expectation1 = XCTestExpectation(description: "reset calculator called")
        let expectation2 = audioPlayerService.expectation
        //when
        logoViewTapSubject.send()
        wait(for: [expectation1, expectation2], timeout: 1.0)
        //then
        output.resetCalculatorPublisher.sink { _ in
            
        }.store(in: &cancellables)
    }
    
    private func billInput(bill: Double, tip: Tip, split: Int) -> CalculatorVM.Input {
        return .init(billPubliher: Just(bill).eraseToAnyPublisher(),
                     tipPublisher: Just(tip).eraseToAnyPublisher(),
                     splitPublisher: Just(split).eraseToAnyPublisher(),
                     logoViewTapPublisher: logoViewTapSubject.eraseToAnyPublisher())
    }
}

class MockAudioPlayerService: AudioPlayerService {
    let expectation = XCTestExpectation(description: "AudioService played sound")
    func playSound() {
        expectation.fulfill()
    }
}
