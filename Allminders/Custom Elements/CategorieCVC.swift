//
//  CategorieCVC.swift
//  Allminders
//
//  Created by Jonas Gamburg on 06/02/2021.
//

import UIKit

class CategorieCVC: UICollectionViewCell {
    
    var categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "[CAT]"
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont(name: Font.semibold, size: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func layoutSubviews() {
        setUpLayer()
    }
    
    fileprivate func setUp() {
        configureConstraints()
    }
    
    fileprivate func setUpLayer() {
        layer.cornerRadius = frame.height / 2
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowRadius = 3
        layer.shadowOpacity = 0.2
        layer.shadowOffset = .init(width: 0, height: 2)
        layer.masksToBounds = false
    }
    
    fileprivate func configureConstraints() {
        categoryLabel.fix(in: contentView)
    }
    
    
}