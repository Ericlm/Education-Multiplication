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
    
    /// The corner radius applied to every corners of the cell.
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.masksToBounds = newValue > 0
            layer.cornerRadius = newValue
        }
    }
    
    /// The color used for the cell when selected
    private var selectedColor = UIColor.systemBlue
    /// The color used for the cell when not selected
    private var unselectedColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.9)
    
    override var isSelected: Bool {
        didSet {
            contentView.backgroundColor = isSelected ? selectedColor : unselectedColor
            layer.borderColor = isSelected ? UIColor.white.cgColor : UIColor.clear.cgColor
        }
    }
    
    /// The text displayed inside the cell.
    var text: String = "" {
        didSet {
            label.text = text
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = unselectedColor
        
        layer.borderWidth = 6
        layer.borderColor = UIColor.clear.cgColor
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        contentView.backgroundColor = unselectedColor
        
        layer.borderWidth = 6
        layer.borderColor = UIColor.clear.cgColor
    }
}
