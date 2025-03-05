//
//  TipInputView.swift
//  tip-calculator
//
//  Created by Mykyta Yarovoi on 20.02.2025.
//

import UIKit
import Combine
import CombineCocoa

class TipInputView: UIView {
    private let headerView: HeaderView = {
        let view = HeaderView()
        view.configure(topText: "Choose", bottomText: "your tip")
        return view
    }()
    
    private lazy var tenPercentButton: UIButton = {
        let button = buildTipButton(tip: .tenPercent)
        button.tapPublisher.flatMap({
            Just(Tip.tenPercent)
        }).assign(to: \.value, on: tipSubject)
            .store(in: &cancellables)
        return button
    }()
    
    private lazy var fifteenPercentButton: UIButton = {
        let button = buildTipButton(tip: .fifteenPercent)
        button.tapPublisher.flatMap({
            Just(Tip.fifteenPercent)
        }).assign(to: \.value, on: tipSubject)
            .store(in: &cancellables)
        return button
    }()
    
    private lazy var twentyPercentButton: UIButton = {
        let button = buildTipButton(tip: .twentyPercent)
        button.tapPublisher.flatMap({
            Just(Tip.twentyPercent)
        }).assign(to: \.value, on: tipSubject)
            .store(in: &cancellables)
        return button
    }()
    
    private lazy var customTipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Custom tip", for: .normal)
        button.titleLabel?.font = ThemeFont.bold(ofSize: 20)
        button.backgroundColor = ThemeColor.primary
        button.tintColor = .white
        button.addCornerRadius(radius: 8.0)
        button.tapPublisher.sink { [weak self] _ in
            self?.handleCustomTipButton()
        }.store(in: &cancellables)
        return button
    }()
    
    private lazy var buttonHStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [tenPercentButton, fifteenPercentButton, twentyPercentButton])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var buttonsVStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [buttonHStackView, customTipButton])
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private var cancellables = Set<AnyCancellable>()
    private let tipSubject = CurrentValueSubject<Tip, Never>(.none)
    var valuePublisher: AnyPublisher<Tip, Never> {
        return tipSubject.eraseToAnyPublisher()
    }
    
    init() {
        super.init(frame: .zero)
        layout()
        observe()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        [headerView, buttonsVStackView].forEach(addSubview(_:))
        
        buttonsVStackView.snp.makeConstraints { make in
            make.top.trailing.bottom.equalToSuperview()
        }
        
        headerView.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.trailing.equalTo(buttonsVStackView.snp.leading).offset(-24).priority(750)
            make.width.equalTo(68)
            make.centerY.equalTo(buttonHStackView.snp.centerY)
        }
    }
    
    private func handleCustomTipButton() {
        let alertController: UIAlertController = {
            let controller = UIAlertController(title: "Enter custom tip", message: nil, preferredStyle: .alert)
            controller.addTextField { textField in
                textField.placeholder = "Make it generous!"
                textField.keyboardType = .numberPad
                textField.autocorrectionType = .no
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            let okACtion = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                guard let text = controller.textFields?.first?.text, let value = Int(text) else { return }
                self?.tipSubject.send(.custom(value: value))
            }
            [okACtion, cancelAction].forEach(controller.addAction(_:))
            return controller
        }()
        
        parentViewController?.present(alertController, animated: true)
    }
    
    private func observe() {
        tipSubject.sink { [weak self] tip in
            self?.resetView()
            
            switch tip {
            case .none:
                break
            case .tenPercent:
                self?.tenPercentButton.backgroundColor = ThemeColor.secondary
            case .fifteenPercent:
                self?.fifteenPercentButton.backgroundColor = ThemeColor.secondary
            case .twentyPercent:
                self?.twentyPercentButton.backgroundColor = ThemeColor.secondary
            case .custom(value: let value):
                self?.customTipButton.backgroundColor = ThemeColor.secondary
                let text = NSMutableAttributedString(string: "$\(value)", attributes: [.font: ThemeFont.bold(ofSize: 20)])
                text.addAttributes([.font: ThemeFont.bold(ofSize: 14)], range: NSMakeRange(0, 1))
                self?.customTipButton.setAttributedTitle(text, for: .normal)
            }
        }.store(in: &cancellables)
    }
    
    private func resetView() {
        [tenPercentButton, fifteenPercentButton, twentyPercentButton, customTipButton].forEach {
            $0.backgroundColor = ThemeColor.primary
        }
        let text = NSMutableAttributedString(string: "Custop tip", attributes: [.font: ThemeFont.bold(ofSize: 20),
                                                                                .foregroundColor: UIColor.white])
        customTipButton.setAttributedTitle(text, for: .normal)
        
    }
    
    private func buildTipButton(tip: Tip) -> UIButton {
        let button = UIButton(type: .custom)
        button.backgroundColor = ThemeColor.primary
        button.addCornerRadius(radius: 8.0)
        let text = NSMutableAttributedString(string: tip.stringValue,
                                             attributes: [.font: ThemeFont.bold(ofSize: 20),
                                                          .foregroundColor: UIColor.white])
        text.addAttributes([.font: ThemeFont.demiBold(ofSize: 14)], range: NSMakeRange(2, 1))
        button.setAttributedTitle(text, for: .normal)
        return button
    }
}
