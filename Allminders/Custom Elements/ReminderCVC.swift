//
//  ReminderCVC.swift
//  Allminders
//
//  Created by Jonas Gamburg on 09/02/2021.
//

import UIKit

class ReminderCVC: UICollectionViewCell {
    
    var tapped: Bool = false
    
    let reminderView: UIView = {
        let view = UIView()
        view.backgroundColor = Colors.deepBlue
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let reminderTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "[Some reminder]"
        label.font = UIFont(name: Font.regular, size: 20)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let checkView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let checkTapperView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        backgroundColor = Colors.deepBlue
        configureConstraints()
    }
    
    fileprivate func setUpLayer() {
        reminderView.layer.cornerRadius = frame.height / 4
        reminderView.layer.shadowColor = UIColor.black.cgColor
        reminderView.layer.shadowRadius = 3
        reminderView.layer.shadowOpacity = 0.2
        reminderView.layer.shadowOffset = .init(width: 0, height: 2)
        reminderView.layer.masksToBounds = false
        
        checkView.layer.cornerRadius = checkView.frame.height / 2
        checkView.layer.shadowColor = UIColor.black.cgColor
        checkView.layer.shadowOpacity = 0.2
        checkView.layer.shadowRadius = 3
        checkView.layer.shadowOffset = .init(width: 0, height: 2)
//        checkView.layer.borderWidth = 0.3
//        checkView.layer.borderColor = Colors.stoneGrey.cgColor
        checkView.layer.masksToBounds = false
        
        checkTapperView.layer.cornerRadius = checkTapperView.frame.height / 2
        checkTapperView.layer.shadowColor = UIColor.black.cgColor
        checkTapperView.layer.shadowOpacity = 0.2
        checkTapperView.layer.shadowRadius = 3
        checkTapperView.layer.shadowOffset = .init(width: 0, height: 2)
        checkTapperView.layer.borderWidth = 0.2
        checkTapperView.layer.borderColor = Colors.stoneGrey.cgColor
        checkTapperView.layer.masksToBounds = false
    }
    
    fileprivate func configureConstraints() {
        reminderView.fix(in: contentView, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 60))
        reminderTitleLabel.fix(in: reminderView, padding: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        
        addSubview(checkView)
        NSLayoutConstraint.activate([
            checkView.centerYAnchor.constraint(equalTo: reminderView.centerYAnchor),
            checkView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10),
            checkView.widthAnchor.constraint(equalToConstant: reminderView.frame.height - 10),
            checkView.heightAnchor.constraint(equalToConstant: reminderView.frame.height - 10)
        ])
        
        addSubview(checkTapperView)
        NSLayoutConstraint.activate([
            checkTapperView.centerYAnchor.constraint(equalTo: checkView.centerYAnchor),
            checkTapperView.centerXAnchor.constraint(equalTo: checkView.centerXAnchor, constant: 0),
            checkTapperView.widthAnchor.constraint(equalToConstant: reminderView.frame.height - 15),
            checkTapperView.heightAnchor.constraint(equalToConstant: reminderView.frame.height - 15)
        ])
        let viewTapGesture = UITapGestureRecognizer(target: self, action: #selector(checkTapped))
        checkTapperView.addGestureRecognizer(viewTapGesture)
    }
    
    @objc fileprivate func checkTapped() {
        UINotificationFeedbackGenerator().notificationOccurred(.success)
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.allowUserInteraction, .curveEaseInOut], animations: {
            if !self.tapped {
                self.checkTapperView.layer.borderWidth = 0.0
                self.checkTapperView.backgroundColor = Colors.greenDragon
                self.checkTapperView.layer.shadowOpacity = 0.0
                self.checkView.backgroundColor = Colors.greenDragon
                self.checkView.layer.shadowOpacity = 0.0
                
                self.tapped.toggle()
            } else {
                self.checkTapperView.layer.borderWidth = 0.2
                self.checkTapperView.backgroundColor = .white
                self.checkTapperView.layer.shadowOpacity = 0.2
                self.checkView.backgroundColor = .white
                self.checkView.layer.shadowOpacity = 0.2
                
                self.tapped.toggle()
            }
            
        }, completion: nil)
    }
}
