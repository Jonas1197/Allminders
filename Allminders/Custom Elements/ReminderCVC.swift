//
//  ReminderCVC.swift
//  Allminders
//
//  Created by Jonas Gamburg on 09/02/2021.
//

import UIKit

class ReminderCVC: UICollectionViewCell {
    
    var didCheck: Bool = false
    
    var reminder: Reminder! {
        didSet {
            reminderTextField.text = reminder.body
        }
    }
    
    let reminderView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let reminderTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "[Some reminder]"
        label.font = UIFont(name: Font.regular, size: 20)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let reminderTextField: UITextField = {
        let tf = UITextField()
        tf.font = UIFont(name: Font.regular, size: 20)
        tf.borderStyle = .none
        tf.textColor   = .black
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
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
        configureConstraints()
    }
    
    fileprivate func setUpLayer() {
        reminderView.layer.roundCorners(to: .custom(frame.height / 4))
        //reminderView.addShadow(withOpactiy: 0.1, color: .black, radius: 4, andOffset: .init(width: 0, height: 3))
        reminderView.layer.borderWidth   = 0.4
        reminderView.layer.borderColor   = Colors.stoneGrey.cgColor
        reminderView.layer.masksToBounds = false
        
        checkView.layer.roundCorners(to: .rounded)
        //checkView.addShadow(withOpactiy: 0.1, color: .black, radius: 4, andOffset: .init(width: 0, height: 3))
        checkView.layer.borderWidth   = 0.1
        checkView.layer.borderColor   = Colors.stoneGrey.cgColor
        checkView.layer.masksToBounds = false
        
        checkTapperView.layer.roundCorners(to: .rounded)
        checkTapperView.addShadow(withOpactiy: 0.1, color: .black, radius: 4, andOffset: .init(width: 0, height: 3))
        checkTapperView.layer.borderWidth   = 0.6
        checkTapperView.layer.borderColor   = Colors.stoneGrey.cgColor
        checkTapperView.layer.masksToBounds = false
    }
    
    fileprivate func configureConstraints() {
        reminderView.fix(in: contentView, padding: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 60))
        //reminderTitleLabel.fix(in: reminderView, padding: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        reminderTextField.fix(in: reminderView, padding: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10))
        
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
            checkTapperView.widthAnchor.constraint(equalToConstant: reminderView.frame.height - 25),
            checkTapperView.heightAnchor.constraint(equalToConstant: reminderView.frame.height - 25)
        ])
        
        let viewTapGesture = UITapGestureRecognizer(target: self, action: #selector(checkTapped))
        checkTapperView.addGestureRecognizer(viewTapGesture)
    }
    
    @objc fileprivate func checkTapped() {
        UIView.animate(withDuration: 0.2, delay: 0.0, options: [.allowUserInteraction, .curveEaseInOut], animations: {
            self.checked()
        }, completion: nil)
    }
    
    func initCellColor() {
        reminder.isChecked ? colorInGreen() : colorInOriginal()
    }
    
    private func checked() {
        if !didCheck {
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            colorInGreen()
            didCheck.toggle()
            didCheck ? reminder.check() : reminder.uncheck()
            
        } else {
            UIImpactFeedbackGenerator().impactOccurred(intensity: .greatestFiniteMagnitude)
            colorInOriginal()
            didCheck.toggle()
            didCheck ? reminder.check() : reminder.uncheck()
        }
    }
    
    private func colorInGreen() {
       reminderView.removeShadow()
       reminderView.layer.borderWidth    = 0.0
       reminderView.backgroundColor      = Colors.greenDragon
        //self.reminderTitleLabel.textColor    = .white
        reminderTextField.textColor       = .white
        
        //self.checkView.removeShadow()
        checkView.backgroundColor         = Colors.greenDragon
        checkView.layer.borderWidth       = 0
        
        //self.checkTapperView.removeShadow()
        checkTapperView.layer.borderWidth = 0
        checkTapperView.backgroundColor   = Colors.greenDragon
    }
    
    private func colorInOriginal() {
        //reminderView.addShadow(withOpactiy: 0.1, color: .black, radius: 4, andOffset: .init(width: 0, height: 3))
        reminderView.backgroundColor      = .white
        reminderView.layer.borderWidth    = 0.4
        reminderView.layer.borderColor    = Colors.stoneGrey.cgColor
        //self.reminderTitleLabel.textColor    = .black
        reminderTextField.textColor       = .black
        
        //checkView.addShadow(withOpactiy: 0.1, color: .black, radius: 4, andOffset: .init(width: 0, height: 3))
        checkView.layer.borderWidth       = 0.1
        checkView.backgroundColor         = .white
        
        //checkTapperView.addShadow(withOpactiy: 0.1, color: .black, radius: 4, andOffset: .init(width: 0, height: 3))
        checkTapperView.layer.borderWidth = 0.6
        checkTapperView.backgroundColor   = .white
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        reminderTextField.resignFirstResponder()
    }
}
