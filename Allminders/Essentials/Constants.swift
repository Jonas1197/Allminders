//
//  Constants.swift
//  Allminders
//
//  Created by Jonas Gamburg on 05/02/2021.
//

import UIKit

struct Cell {
    static let cellID = "cell"
}

struct Test {
    static var reminders: [Reminder] = [
        .init(body: "Clean my room", dateCreated: Date()),
        .init(body: "Paint the floors", dateCreated: Date()),
        .init(body: "Call my mother in law", dateCreated: Date()),
        .init(body: "Extract that sweet Aether", dateCreated: Date()),
        .init(body: "Sell time tunic in Sanctum", dateCreated: Date()),
        .init(body: "Travel to Australia", dateCreated: Date()),
        .init(body: "Make some cash on the side", dateCreated: Date()),
        .init(body: "Conquer Africa", dateCreated: Date()),
        .init(body: "Create a stunning new pell", dateCreated: Date()),
    ]
}

struct ElementConstant {
    static let SFRemindersIcon    = "list.bullet"
    static let SFNotesIcon        = "note.text"
    static let SFGearIcon         = "gearshape.fill"
    static let iconScale: CGFloat = 26
}

struct Font {
    static let regular  = "SFCompactRounded-Regular"
    static let semibold = "SFCompactRounded-Semibold"
}

struct Colors {
    static let deepBlue    = UIColor(red: 73/255, green: 100/255, blue: 248/255, alpha: 1.0)
    static let greenDragon = UIColor(red: 92/255, green: 190/255, blue: 115/255, alpha: 1.0)
    static let goldStone   = UIColor(red: 198/255, green: 139/255, blue: 60/255, alpha: 1.0)
    static let stoneGrey   = UIColor(red: 105/255, green: 105/255, blue: 105/255, alpha: 1.0)
}

struct AnimationConstants {
    static let animationDuration = 0.5
}


enum CornerRadiusStyle {
    case rounded
    case custom(CGFloat)
    case other(UIView)
}
