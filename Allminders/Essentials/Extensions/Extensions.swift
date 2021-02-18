//
//  Extensions.swift
//  Allminders
//
//  Created by Jonas Gamburg on 05/02/2021.
//

import UIKit

//MARK: - Date

extension Date {
    static var yesterday: Date { return Date().dayBefore }
    static var tomorrow:  Date { return Date().dayAfter }
    var dayBefore: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var dayAfter: Date {
        return Calendar.current.date(byAdding: .day, value: 1, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var month: Int {
        return Calendar.current.component(.month,  from: self)
    }
    var isLastDayOfMonth: Bool {
        return dayAfter.month != month
    }
}


//MARK: - UIView

extension CALayer {
    func roundCorners(to radius: CornerRadiusStyle, smoothCorners: Bool = true) {
        switch radius {
        case .rounded:
            cornerRadius = min(bounds.height/2, bounds.width/2)
        case .custom(let rad):
            cornerRadius = rad
        case .other(let view):
            cornerRadius = view.layer.cornerRadius
        }
        
        guard bounds.width != bounds.height else { return }
        if smoothCorners, #available(iOS 13.0, *) {
            cornerCurve = .continuous
        }
    }
}

extension UIView {
    
    func addShadow(withOpactiy opacity: Float, color color: UIColor, radius radius: CGFloat, andOffset offset: CGSize) {
        layer.shadowOpacity = opacity
        layer.shadowColor   = color.cgColor
        layer.shadowRadius  = radius
        layer.shadowOffset  = offset
    }
    
    func removeShadow() {
        layer.shadowOpacity = 0.0
        layer.shadowColor   = UIColor.clear.cgColor
        layer.shadowRadius  = 0.0
        layer.shadowOffset  = .init(width: 0, height: 0)
    }
    
    func fix(in container: UIView, padding: UIEdgeInsets = .zero) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.frame = container.frame
        container.addSubview(self)
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: container.topAnchor, constant: padding.top),
            bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -padding.bottom),
            leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: padding.left),
            trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -padding.right)
        ])
    }
    
    func fix(verticallyAndHorizontallyIn container: UIView, withPadding padding: UIEdgeInsets = .zero) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.frame = container.frame
        container.addSubview(self)
        NSLayoutConstraint.activate([
            centerYAnchor.constraint(equalTo: container.centerYAnchor),
            centerXAnchor.constraint(equalTo: container.centerXAnchor),
            leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: padding.left),
            leadingAnchor.constraint(equalTo: container.trailingAnchor, constant: -padding.right),
            topAnchor.constraint(equalTo: container.topAnchor, constant: padding.top),
            bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -padding.bottom)
        ])
    }
    
    func fix(inCenterOf container: UIView, witWidth width: CGFloat, andHeight height: CGFloat) {
        container.addSubview(self)
        NSLayoutConstraint.activate([
            centerYAnchor.constraint(equalTo: container.centerYAnchor),
            centerXAnchor.constraint(equalTo: container.centerXAnchor),
            widthAnchor.constraint(equalToConstant: width),
            heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    func fix(in container: UIView, toTopWithPadding padding: CGFloat = 0, andHeight height: CGFloat) {
        container.addSubview(self)
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: container.topAnchor, constant: padding),
            leadingAnchor.constraint(equalTo: container.leadingAnchor),
            trailingAnchor.constraint(equalTo: container.trailingAnchor),
            heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    func fix(horizontallyIn container: UIView, belowView view: UIView, withTopPadding padding: CGFloat = 0, andHeight height: CGFloat) {
        translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(self)
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.bottomAnchor, constant: padding),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    func fix(horizontallyIn container: UIView, belowView view: UIView, withTopPadding padding: CGFloat = 0) {
        container.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.bottomAnchor, constant: padding),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    func fix(in container: UIView, below view: UIView, withTopPading padding: CGFloat, andHeight height: CGFloat) {
        container.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.bottomAnchor, constant: padding),
            leadingAnchor.constraint(equalTo: container.leadingAnchor),
            trailingAnchor.constraint(equalTo: container.trailingAnchor),
            heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    func fix(in container: UIView, belowView view: UIView?, withHorizontalPadding padding: CGFloat = 0, withHeight height: CGFloat) {
        container.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        if let view = view {
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: view.bottomAnchor),
                leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: padding),
                trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -padding),
                heightAnchor.constraint(equalToConstant: height)
            ])
        } else {
            NSLayoutConstraint.activate([
                topAnchor.constraint(equalTo: container.topAnchor),
                leadingAnchor.constraint(equalTo: container.leadingAnchor, constant: padding),
                trailingAnchor.constraint(equalTo: container.trailingAnchor, constant: -padding),
                heightAnchor.constraint(equalToConstant: height)
            ])
        }
    }
    
    func fix(in container: UIView, inHorizontalBoundsOf view: UIView, withHeight height: CGFloat) {
        container.addSubview(self)
        translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.bottomAnchor),
            leadingAnchor.constraint(equalTo: view.leadingAnchor),
            trailingAnchor.constraint(equalTo: view.trailingAnchor),
            heightAnchor.constraint(equalToConstant: height)
        ])
    }
    
    func fix(in container: UIView, below view: UIView, withBottomPadding padding: CGFloat = 0) {
        container.addSubview(self)
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: view.bottomAnchor, constant: padding),
            leadingAnchor.constraint(equalTo: container.leadingAnchor),
            trailingAnchor.constraint(equalTo: container.trailingAnchor),
            bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
    }
    
    func hfix(in container: UIView, padding: CGFloat = .zero) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.frame = container.frame
        leftAnchor.constraint(equalTo: container.leftAnchor, constant: padding).isActive = true
        rightAnchor.constraint(equalTo: container.rightAnchor, constant: -padding).isActive = true
    }
    
    func vfix(in container: UIView, padding: CGFloat = .zero) {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.frame = container.frame
        topAnchor.constraint(equalTo: container.topAnchor, constant: padding).isActive = true
        bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -padding).isActive = true
    }
    
    func constraintAspectRatio(_ ar: CGFloat, width: CGFloat? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        if let w = width {
            self.widthAnchor.constraint(equalToConstant: w).isActive = true
        }
        
        self.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: ar).isActive = true
    }
    
    func equalLeadingTrailing(to view: UIView, margin: CGFloat = 0.0) {
        translatesAutoresizingMaskIntoConstraints = false
        leftAnchor.constraint(equalTo: view.leftAnchor, constant: margin).isActive = true
        rightAnchor.constraint(equalTo: view.rightAnchor, constant: -margin).isActive = true
    }
    
    func center(in view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    @discardableResult
    func findConstraint(layoutAttribute: NSLayoutConstraint.Attribute) -> NSLayoutConstraint? {
        if let constraints = superview?.constraints {
            for constraint in constraints where itemMatch(constraint: constraint, layoutAttribute: layoutAttribute) {
                return constraint
            }
        }
        return nil
    }
    
    func itemMatch(constraint: NSLayoutConstraint, layoutAttribute: NSLayoutConstraint.Attribute) -> Bool {
        let firstItemMatch = constraint.firstItem as? UIView == self && constraint.firstAttribute == layoutAttribute
        let secondItemMatch = constraint.secondItem as? UIView == self && constraint.secondAttribute == layoutAttribute
        return firstItemMatch || secondItemMatch
    }
}


//MARK: - UIColor

extension UIColor {
    public convenience init?(hex: String) {
        let r, g, b, a: CGFloat
        
        if hex.hasPrefix("#") {
            let start = hex.index(hex.startIndex, offsetBy: 1)
            let hexColor = String(hex[start...])
            
            if hexColor.count == 8 {
                let scanner = Scanner(string: hexColor)
                var hexNumber: UInt64 = 0
                
                if scanner.scanHexInt64(&hexNumber) {
                    r = CGFloat((hexNumber & 0xff000000) >> 24) / 255
                    g = CGFloat((hexNumber & 0x00ff0000) >> 16) / 255
                    b = CGFloat((hexNumber & 0x0000ff00) >> 8) / 255
                    a = CGFloat(hexNumber & 0x000000ff) / 255
                    
                    self.init(red: r, green: g, blue: b, alpha: a)
                    return
                }
            }
        }
        
        return nil
    }
    
    
    func inverseColor() -> UIColor {
        var alpha: CGFloat = 1.0
        
        var red: CGFloat = 0.0, green: CGFloat = 0.0, blue: CGFloat = 0.0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            return UIColor(red: 1.0 - red, green: 1.0 - green, blue: 1.0 - blue, alpha: alpha)
        }
        
        var hue: CGFloat = 0.0, saturation: CGFloat = 0.0, brightness: CGFloat = 0.0
        if self.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            return UIColor(hue: 1.0 - hue, saturation: 1.0 - saturation, brightness: 1.0 - brightness, alpha: alpha)
        }
        
        var white: CGFloat = 0.0
        if self.getWhite(&white, alpha: &alpha) {
            return UIColor(white: 1.0 - white, alpha: alpha)
        }
        
        return self
    }
}


//MARK: - UIStackView

extension UIStackView {
    convenience init(views: [UIView], axis: NSLayoutConstraint.Axis, spacing: CGFloat = 0, distribution: UIStackView.Distribution = .fill) {
        self.init(arrangedSubviews: views)
        self.axis = axis
        self.spacing = spacing
        self.distribution = distribution
    }
    
    func addArrangedViews(views: UIView...) {
        views.forEach {
            addArrangedSubview($0)
        }
    }
}
