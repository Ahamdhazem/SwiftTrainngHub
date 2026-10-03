//
//  CustemView.swift
//  Inspecabel
//
//  Created by LP Mackbook on 10/09/2026.
//

import UIKit

@IBDesignable
class CustemView: UIView {
    
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
            updateStyle(_style)
        }}

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

    func updateStyle(_ style : String){
        switch(style){
        case "primary":    primaryStyle()
        case "secondary":  secondaryStyle()
        case "clear":      clearStyle()
        case "rounded":    roundedStyle()
        case "circular":   circularStyle()
        case "disable":    disableStyle()
        default:           defaultStyle()
        }
    }
    
    func primaryStyle() {
        self.layer.cornerRadius =  bounds.height/2
        self.clipsToBounds = true
 
    
        
        
    }
    
    func secondaryStyle() {
        self.backgroundColor = .systemGray
        self.layer.cornerRadius = 8
        self.alpha = 1.0
        self.tintColor = .white
        
    }
    
    func clearStyle() {
        self.backgroundColor = .clear
        self.tintColor = .black
      //  self.setTitleColor(.black, for: .normal)
    }
    
    func roundedStyle() {
       // self.backgroundColor = .systemBlue
        self.layer.cornerRadius =  bounds.height/2
        self.layer.borderWidth = 0
        self.clipsToBounds = true
        self.tintColor = .white
        
    }
    
    func circularStyle() {
        self.backgroundColor = .systemBlue
        
        heightAnchor.constraint(equalTo: widthAnchor).isActive = true
        self.layer.cornerRadius =  bounds.height/2
        self.layer.borderWidth = 0
        self.clipsToBounds = true
        self.tintColor = .white
        
    }
    func disableStyle() {
        self.backgroundColor = .systemGray4
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 0
        self.alpha = 0.6
        
        
    }
    
    func defaultStyle() {
        self.backgroundColor = .systemBlue
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 0
        self.tintColor = .white
        
    }
}

