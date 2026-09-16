    //
//  CustemTestFealed                                    .swift
//  PostsApp
//
//  Created by LP Mackbook on 15/09/2026.
//

import Foundation
import UIKit

class CustemTextFealed : UITextField {
    
    
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
    

    private var _style : String = "default"
    @IBInspectable var style: String {
        get{ return _style}
        
        set{ _style = newValue
           
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
        configerStyle(_style)
        
    }

}
extension UITextField {
    func configerStyle(_ style : String){
        switch(style){
        case "primary":    primaryStyle()
        case "secondary":  secondaryStyle()
        case "clear":      clearStyle()
        case "rounded":    roundedStyle()
        case "disable":    disableStyle()
        default:           defaultStyle()
        }
    }
    
    func primaryStyle() {
            self.backgroundColor = .systemCyan
            self.layer.cornerRadius = 8
            self.layer.borderWidth = 0
            self.alpha = 1.0
            self.tintColor = .white
        }
        
        func secondaryStyle() {
            self.backgroundColor = .systemGray
            self.layer.cornerRadius = 8
            self.alpha = 1.0
            self.tintColor = .white
        
        }
        
        func clearStyle() {
            self.backgroundColor = .clear
            self.layer.cornerRadius = 0
            self.layer.borderWidth = 0
        }
        
        func roundedStyle() {
          
            self.layer.cornerRadius =  bounds.height/2
            self.layer.borderWidth = 1
            self.clipsToBounds = true
     
   
        }
    
        func disableStyle() {
            self.backgroundColor = .systemGray4
            self.layer.cornerRadius = 8
            self.layer.borderWidth = 0
            self.alpha = 0.6

            
        }
        
        func defaultStyle() {
//            self.backgroundColor = .systemBlue
//            self.layer.cornerRadius = 8
//            self.layer.borderWidth = 0
//            self.tintColor = .white
            
        }
}

