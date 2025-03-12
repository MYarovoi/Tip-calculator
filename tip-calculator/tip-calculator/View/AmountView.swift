//
//  AmountView.swift
//  tip-calculator
//
//  Created by Никита Яровой on 03.03.2025.
//

import UIKit

class AmountView: UIView {
    private let text: String
    private let alignment: NSTextAlignment
    private let amountLabelIdentifier: String
    
    private lazy var titleLabel: UILabel = {
        LabelFactory.build(
            text: text,
            font: ThemeFont.regular(ofSize: 18),
            textColor: ThemeColor.text,
            textAlignment: alignment)
    }()
    
    private lazy var amuntLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = alignment
        label.textColor = ThemeColor.primary
        let text = NSMutableAttributedString(string: "$0", attributes: [.font: ThemeFont.bold(ofSize: 24)])
        text.addAttributes([.font: ThemeFont.bold(ofSize: 16)], range: NSRange(location: 0, length: 1))
        label.attributedText = text
        label.accessibilityIdentifier = amountLabelIdentifier
        return label
    }()
    
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel, amuntLabel])
        stackView.axis = .vertical
        return stackView
    }()
    
    init(text: String, alignment: NSTextAlignment, amountLabelIdentifier: String) {
        self.text = text
        self.alignment = alignment
        self.amountLabelIdentifier = amountLabelIdentifier
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(amount: Double) {
        let text = NSMutableAttributedString(string: amount.currencyFormated,
                                             attributes: [.font: ThemeFont.bold(ofSize: 24)])
        text.addAttributes([.font: ThemeFont.bold(ofSize: 16)], range: NSMakeRange(0, 1))
        amuntLabel.attributedText = text
    }
    
    private func layout() {
        addSubview(stackView)
        
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

