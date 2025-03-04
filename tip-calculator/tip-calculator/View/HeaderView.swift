//
//  HeaderView.swift
//  tip-calculator
//
//  Created by Никита Яровой on 04.03.2025.
//

import UIKit

class HeaderView: UIView {
    private let topLabel: UILabel = {
        LabelFactory.build(text: nil, font: ThemeFont.bold(ofSize: 18))
    }()
    
    private let bottomLabel: UILabel = {
        LabelFactory.build(text: nil, font: ThemeFont.regular(ofSize: 16))
    }()
    
    private let topSpacerView = UIView()
    private let bottomSpacerView = UIView()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [topSpacerView, topLabel, bottomLabel, bottomSpacerView])
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = -4
        return stackView
    }()
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        topSpacerView.backgroundColor = .red
        bottomSpacerView.backgroundColor = .red
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        topSpacerView.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(20)
        }
        bottomSpacerView.snp.makeConstraints { make in
            make.height.greaterThanOrEqualTo(20)
        }
        
        topLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        bottomLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
    }
    
    func configure(topText: String, bottomText: String) {
        topLabel.text = topText
        bottomLabel.text = bottomText
    }
}
