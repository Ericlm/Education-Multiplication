//
//  SelectTableCollectionViewCell.swift
//  Education-Multiplication
//
//  Created by Eric Le Maître on 05/03/2021.
//

import UIKit

@IBDesignable
class SelectTableCollectionViewCell: UICollectionViewCell {
    @IBOutlet var label: UILabel!
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.masksToBounds = newValue > 0
            layer.cornerRadius = newValue
        }
    }
    
    private var selectedColor = UIColor.systemBlue
    private var unselectedColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.9)
    
    override var isSelected: Bool {
        didSet {
            contentView.backgroundColor = isSelected ? selectedColor : unselectedColor
        }
    }
    
    var text: String = "" {
        didSet {
            label.text = text
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = unselectedColor
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        contentView.backgroundColor = unselectedColor
    }
}
