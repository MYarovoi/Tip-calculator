//
//  ViewController.swift
//  tip-calculator
//
//  Created by Mykyta Yarovoi on 19.02.2025.
//

import UIKit
import SwiftUI
import SnapKit
import Combine

class CalculatorVC: UIViewController {
    private let logoView = LogoView()
    private let resultView = ResultView()
    private let billInputView = BillInputView()
    private let tipInmputView = TipInputView()
    private let splitInputView = SplitInputView()
    private lazy var vStackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [logoView,
                                                        resultView,
                                                        billInputView,
                                                        tipInmputView,
                                                        splitInputView,
                                                        UIView()])
        stackView.axis = .vertical
        stackView.spacing = 36
        return stackView
    }()
    private var cancellables = Set<AnyCancellable>()
    let vm = CalculatorVM()

    override func viewDidLoad() {
        super.viewDidLoad()
        layout()
        bind()
    }
    
    private func bind() {
        let input = CalculatorVM.Input(billPubliher: billInputView.valuePublisher,
                                       tipPublisher: tipInmputView.valuePublisher,
                                       splitPublisher: splitInputView.valuePublisher)
        
        let output = vm.transofr(input: input)
        
        output.updateViewPublisher.sink { result in
            
        }.store(in: &cancellables)
    }
    
    private func layout() {
        view.backgroundColor = ThemeColor.bg
        view.addSubview(vStackView)
        
        vStackView.snp.makeConstraints { make in
            make.leading.equalTo(view.snp.leadingMargin).offset(16)
            make.trailing.equalTo(view.snp.trailingMargin).offset(-16)
            make.bottom.equalTo(view.snp.bottomMargin).offset(-16)
            make.top.equalTo(view.snp.topMargin).offset(16)
        }
        
        logoView.snp.makeConstraints { make in
            make.height.equalTo(48)
        }
        
        resultView.snp.makeConstraints { make in
            make.height.equalTo(224)
        }
        
        billInputView.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
        
        tipInmputView.snp.makeConstraints { make in
            make.height.equalTo(56+56+16)
        }
        
        splitInputView.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
    }
}


//MARK: - Preview

#Preview {
    CalculatorVCPreview()
}

struct CalculatorVCPreview: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> CalculatorVC {
        return CalculatorVC()
    }
    
    func updateUIViewController(_ uiViewController: CalculatorVC, context: Context) {}
}
