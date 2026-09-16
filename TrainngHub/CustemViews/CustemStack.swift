//
//  CustemStack.swift
//  TrainngHub
//
//  Created by LP Mackbook on 15/09/2026.
//

import Foundation
//
//  CustemView.swift
//  Inspecabel
//
//  Created by LP Mackbook on 10/09/2026.
//

import UIKit

@IBDesignable
class CustemStack: UIStackView {
    
    @IBInspectable var borderRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        get{ return layer.borderWidth}
        set{
            layer.borderWidth = newValue
        }
    }
    @IBInspectable var borderColor: UIColor {
        get {
                return UIColor(cgColor: layer.borderColor ?? UIColor.clear.cgColor)
            }
            set {
                layer.borderColor = newValue.cgColor
            }
    }


    func updateUI() {
        layer.cornerRadius = borderRadius
        layer.borderWidth = borderWidth
        layer.borderColor = borderColor.cgColor
        clipsToBounds = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateUI()
        
    }

}

