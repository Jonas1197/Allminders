//
//  ActionBar.swift
//  Allminders
//
//  Created by Jonas Gamburg on 05/02/2021.
//

import UIKit

protocol ActionBarDelegate {
    func remindersTapped() -> Void
    func notesTapped()     -> Void
    func settingsTapped()  -> Void
}

class ActionBar: UIView {
    
    //MARK: - Variables
    var delegate: ActionBarDelegate?
    
    let sideSpacing: CGFloat = 10
    
    var spacing:     CGFloat = 40 {
        didSet {
            configureLayout()
        }
    }
    
    let distance:      CGFloat = 35
    
    let bottomSpacing: CGFloat = 5
    
    let buttonHeight:  CGFloat = 40
    
    let buttonWidth:   CGFloat = 40
    
    var sbCenterY:     NSLayoutConstraint!
    
    var sbCenterX:     NSLayoutConstraint!
    

    //MARK: - Selector Bubble
    fileprivate let selectorBubble: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    //MARK: - Button Labels
    fileprivate let remindersButtonLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.semibold, size: 12)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Reminders"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    fileprivate let notesButtonLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.semibold, size: 12)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Notes"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    fileprivate let settingsButtonLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: Font.semibold, size: 12)
        label.textColor = .white
        label.textAlignment = .center
        label.text = "Settings"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    //MARK: - Buttons
    fileprivate let remindersButton: UIButton = {
        let button       = UIButton()
        let config       = UIImage.SymbolConfiguration(pointSize: ElementConstant.iconScale, weight: .regular, scale: .medium)
        button.tag       = 0
        button.tintColor = .white
        button.setImage(UIImage(systemName: ElementConstant.SFRemindersIcon, withConfiguration: config), for: .normal)
        button.setImage(UIImage(systemName: ElementConstant.SFRemindersIcon, withConfiguration: config), for: .selected)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate let notesButton: UIButton = {
        let button       = UIButton()
        let config       = UIImage.SymbolConfiguration(pointSize: ElementConstant.iconScale, weight: .regular, scale: .medium)
        button.tag       = 1
        button.tintColor = .white
        button.setImage(UIImage(systemName: ElementConstant.SFNotesIcon, withConfiguration: config), for: .normal)
        button.setImage(UIImage(systemName: ElementConstant.SFNotesIcon, withConfiguration: config), for: .selected)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate let settingsButton: UIButton = {
        let button       = UIButton()
        let config       = UIImage.SymbolConfiguration(pointSize: ElementConstant.iconScale, weight: .regular, scale: .medium)
        button.tag       = 2
        button.tintColor = .white
        button.setImage(UIImage(systemName: ElementConstant.SFGearIcon, withConfiguration: config), for: .normal)
        button.setImage(UIImage(systemName: ElementConstant.SFGearIcon, withConfiguration: config), for: .selected)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    fileprivate let buttonHStack: UIStackView = {
        let stackView          = UIStackView()
        stackView.axis         = .horizontal
        stackView.alignment    = .fill
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    fileprivate let titleHStack: UIStackView = {
        let stackView          = UIStackView()
        stackView.axis         = .horizontal
        stackView.alignment    = .fill
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    
    //MARK: - Body
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setUp()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //selectorBubble.layer.cornerRadius = 10
        selectorBubble.layer.roundCorners(to: .rounded)
    }
    
    fileprivate func setUp() {
        translatesAutoresizingMaskIntoConstraints = false
        configureLayout()
        setUpActions()
    }
}



extension ActionBar {
    
    private func setUpActions() {
        remindersButton.addTarget(self, action: #selector(remindersTapped), for: .touchUpInside)
        notesButton.addTarget(self, action: #selector(notesTapped), for: .touchUpInside)
        settingsButton.addTarget(self, action: #selector(settingsTapped), for: .touchUpInside)
    }
    
    @objc func remindersTapped() {
        animateSelector(toButton: remindersButton)
        delegate?.remindersTapped()
    }
    
    @objc func notesTapped() {
        animateSelector(toButton: notesButton)
        delegate?.notesTapped()
    }
    
    @objc func settingsTapped() {
        animateSelector(toButton: settingsButton)
        delegate?.settingsTapped()
    }
    
    private func animateSelector(toButton button: UIButton) {
        let buttons = [remindersButton, notesButton, settingsButton]
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.2, options: .curveEaseInOut, animations: {
            
            buttons.forEach {
                if $0.tintColor != .white {
                    $0.tintColor = .white
                }
            }
            
            self.sbCenterY = button.centerYAnchor.constraint(equalTo: button.centerYAnchor)
            self.sbCenterX = button.centerXAnchor.constraint(equalTo: button.centerXAnchor)
            self.selectorBubble.center = button.center
            self.selectorBubble.center.x += self.distance

            button.tintColor = button.tintColor.inverseColor()
        }, completion: nil)
    }
    
    fileprivate func configureLayout() {
        self.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = Colors.deepBlue
        addSubview(selectorBubble)
        
        buttonHStack.addArrangedViews(views: remindersButton, notesButton, settingsButton)
        buttonHStack.fix(verticallyAndHorizontallyIn: self, withPadding: UIEdgeInsets(top: 0, left: 35, bottom: 15, right: 35))
        
        titleHStack.addArrangedViews(views: remindersButtonLabel, notesButtonLabel, settingsButtonLabel)
        titleHStack.fix(in: self, padding: UIEdgeInsets(top: 40, left: 27, bottom: 0, right: 27))
        
        selectorBubble.frame   = remindersButton.frame
        remindersButton.center = remindersButton.center
        
        remindersButton.tintColor = UIColor.white.inverseColor()
        configureSelectorBubble()
        
        self.layoutSubviews()
    }
    
    fileprivate func configureSelectorBubble() {
        sbCenterX = selectorBubble.centerXAnchor.constraint(equalTo: remindersButton.centerXAnchor)
        sbCenterY = selectorBubble.centerYAnchor.constraint(equalTo: remindersButton.centerYAnchor)
        NSLayoutConstraint.activate([
            sbCenterX, sbCenterY,
            selectorBubble.widthAnchor.constraint(equalToConstant: buttonWidth + 5),
            selectorBubble.heightAnchor.constraint(equalToConstant: buttonHeight + 5)
        ])
    }
}
