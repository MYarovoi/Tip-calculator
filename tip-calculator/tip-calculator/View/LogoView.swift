//
//  LogoView.swift
//  tip-calculator
//
//  Created by Mykyta Yarovoi on 20.02.2025.
//

import UIKit

class LogoView: UIView {
    private let imageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "icCalculatorBW"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let topLabel: UILabel = {
        let label = UILabel()
        let text = NSMutableAttributedString(string: "Mr TIP", attributes: [.font: ThemeFont.demiBold(ofSize: 16)])
        text.addAttributes([.font: ThemeFont.bold(ofSize: 25)], range: NSRange(location: 3, length: 3))
        label.attributedText = text
        return label
    }()
    
    private let bottomLabel: UILabel = {
        LabelFactory.build(text: "Calculator", font: ThemeFont.demiBold(ofSize: 20), textAlignment: .left)
    }()
    
    private lazy var vStackView : UIStackView = {
        let view = UIStackView(arrangedSubviews: [topLabel, bottomLabel])
        view.axis = .vertical
        view.spacing = -4
        return view
    }()
    
    private lazy var hStackView : UIStackView = {
        let view = UIStackView(arrangedSubviews: [imageView, vStackView])
        view.axis = .horizontal
        view.spacing = 8
        view.alignment = .center
        return view
    }()
    
    init() {
        super.init(frame: .zero)
        accessibilityIdentifier = ScreenIdentifier.LogoView.logoView.rawValue
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(hStackView)
        hStackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        imageView.snp.makeConstraints { make in
            make.height.equalTo(imageView.snp.width)
        }
    }
}
