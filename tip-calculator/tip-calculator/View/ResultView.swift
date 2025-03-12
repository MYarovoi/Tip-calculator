//
//  ResultView.swift
//  tip-calculator
//
//  Created by Mykyta Yarovoi on 20.02.2025.
//

import UIKit

class ResultView: UIView {
    private let headerLabel: UILabel = {
        let label = LabelFactory.build(text: "Total p/person", font: ThemeFont.demiBold(ofSize: 18))
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        return label
    }()
    
    private let amountPerPersonLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        let text = NSMutableAttributedString(string: "$0", attributes: [.font: ThemeFont.bold(ofSize: 48)])
        text.addAttributes([.font: ThemeFont.bold(ofSize: 24)], range: NSMakeRange(0, 1))
        label.attributedText = text
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.8
        label.accessibilityIdentifier = ScreenIdentifier.ResultView.totalAmountPerPersonValueLabel.rawValue
        return label
    }()
    
    private let horizonalLineView: UIView = {
        let view = UIView()
        view.backgroundColor = ThemeColor.separator
        return view
    }()
    
    private lazy var vStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [headerLabel,
                                                       amountPerPersonLabel,
                                                       horizonalLineView,
                                                       buildSpacerView(height: 0),
                                                       hStackView])
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private let totalBillView: AmountView = {
        let view = AmountView(text: "Total bill", alignment: .left, amountLabelIdentifier: ScreenIdentifier.ResultView.totalBillValueLabel.rawValue)
        return view
    }()
    
    private let totalTipView: AmountView = {
        let view = AmountView(text: "Total tip", alignment: .right, amountLabelIdentifier: ScreenIdentifier.ResultView.totalTipValueLabel.rawValue)
        return view
    }()
    
    private lazy var hStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [totalBillView,
                                                       UIView(),
                                                       totalTipView])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(result: Result) {
        let text = NSMutableAttributedString(string: result.amounPerPerson.currencyFormated,
                                             attributes: [.font: ThemeFont.bold(ofSize: 48)])
        text.addAttributes([.font: ThemeFont.bold(ofSize: 24)], range: NSRange(location: 0, length: 1))
        amountPerPersonLabel.attributedText = text
        totalBillView.configure(amount: result.totalBill)
        totalTipView.configure(amount: result.totalTip)
    }
    
    private func layout() {
        backgroundColor = .white
        addSubview(vStackView)
        vStackView.snp.makeConstraints { make in
            make.top.equalTo(snp.top).offset(24).priority(750)
            make.leading.equalTo(snp.leading).offset(24)
            make.trailing.equalTo(snp.trailing).offset(-24)
            make.bottom.equalTo(snp.bottom).offset(-24)
        }
        
        horizonalLineView.snp.makeConstraints { make in
            make.height.equalTo(2)
        }
        
        addShadow(offset: CGSize(width: 0, height: 3), color: .black, radius: 12.0, opacity: 0.1)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let screenWidth = self.bounds.width
        
        if screenWidth < 375 {
            vStackView.spacing = 4
            
            headerLabel.font = ThemeFont.demiBold(ofSize: 16)
            if let currentText = amountPerPersonLabel.attributedText?.string {
                let newText = NSMutableAttributedString(string: currentText,
                                                        attributes: [.font: ThemeFont.bold(ofSize: 42)])
                newText.addAttributes([.font: ThemeFont.bold(ofSize: 20)], range: NSRange(location: 0, length: 1))
                amountPerPersonLabel.attributedText = newText
            }
        } else {
            vStackView.spacing = 8
            headerLabel.font = ThemeFont.demiBold(ofSize: 18)
            if let currentText = amountPerPersonLabel.attributedText?.string {
                let newText = NSMutableAttributedString(string: currentText,
                                                        attributes: [.font: ThemeFont.bold(ofSize: 48)])
                newText.addAttributes([.font: ThemeFont.bold(ofSize: 24)], range: NSRange(location: 0, length: 1))
                amountPerPersonLabel.attributedText = newText
            }
        }
    }
    
    private func buildSpacerView(height: CGFloat) -> UIView {
        let view = UIView()
        view.heightAnchor.constraint(equalToConstant: height).isActive = true
        return view
    }
}
