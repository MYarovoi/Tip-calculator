//
//  CalculatorVM.swift
//  tip-calculator
//
//  Created by Никита Яровой on 05.03.2025.
//

import Foundation
import Combine

class CalculatorVM {
    struct Input {
        let billPubliher: AnyPublisher<Double, Never>
        let tipPublisher: AnyPublisher<Tip, Never>
        let splitPublisher: AnyPublisher<Int, Never>
        let logoViewTapPublisher: AnyPublisher<Void, Never>
    }
    
    struct Output {
        let updateViewPublisher: AnyPublisher<Result, Never>
        let resetCalculatorPublisher: AnyPublisher<Void, Never>
    }
    
    private let audioPlayerService: AudioPlayerService
    
    init(audioPlayerService: AudioPlayerService = DefaultAudioPlayerService()) {
        self.audioPlayerService = audioPlayerService
    }
    
    func transofr(input: Input) -> Output{
        let updateViewPublisher = Publishers.CombineLatest3(input.billPubliher,
                                                            input.tipPublisher,
                                                            input.splitPublisher).flatMap { [unowned self] (bill, tip, split) in
            let totalTip = getTipAmount(billAmount: bill, tip: tip)
            let totalBill = bill + totalTip
            let amountPerPErson = totalBill / Double(split)
            let result = Result(amounPerPerson: amountPerPErson, totalBill: totalBill, totalTip: totalTip)
            return Just(result)
        }.eraseToAnyPublisher()
        
        let resetCalculatorPublisher = input.logoViewTapPublisher.handleEvents(receiveOutput: { [unowned self] in
            audioPlayerService.playSound()
        }).flatMap({
            return Just(())
        }).eraseToAnyPublisher()
        
        return Output(updateViewPublisher: updateViewPublisher, resetCalculatorPublisher: resetCalculatorPublisher)
    }
    
    private func getTipAmount(billAmount: Double, tip: Tip) -> Double {
        switch tip {
        case .none:
            return 0
        case .tenPercent:
            return billAmount * 0.1
        case .fifteenPercent:
            return billAmount * 0.15
        case .twentyPercent:
            return billAmount * 0.2
        case .custom(let value):
            return Double(value)
        }
    }
}
