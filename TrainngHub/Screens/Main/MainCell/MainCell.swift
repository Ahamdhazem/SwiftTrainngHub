//
//  MainCell.swift
//  TrainngHub
//
//  Created by LP Mackbook on 16/09/2026.
//

import UIKit

class MainCell: UITableViewCell {
    
    @IBOutlet var eReloadView: CustemView!
    
    @IBOutlet var materialType: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        eReloadView.layer.cornerRadius = eReloadView.bounds.height / 2
        
        contentView.layer.cornerRadius = 20
        
        contentView.clipsToBounds = true
        
        contentView.layer.maskedCorners = [
            .layerMinXMinYCorner, // Top Left
            .layerMaxXMaxYCorner  // Bottom Right
        ]
        contentView.layer.masksToBounds = true
        
    }
    
    func configer(_ data : MainData){
        materialType.text = data.MaterialType
        
    }
    }
    
  
