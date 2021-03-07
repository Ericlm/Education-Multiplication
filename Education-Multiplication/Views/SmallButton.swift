//
//  SmallButton.swift
//  Education-Multiplication
//
//  Created by Eric Le Maître on 05/03/2021.
//

import UIKit

class SmallButton: BigButton {
    override func commonInit() {
        super.commonInit()
        let fontSize: CGFloat = traitCollection.horizontalSizeClass == .compact ? 20 : 30
        titleLabel?.font = UIFont(name: "MarkerFelt-Wide", size: fontSize)
    }
}
