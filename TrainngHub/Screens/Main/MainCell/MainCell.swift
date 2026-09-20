//
//  MainCell.swift
//  TrainngHub
//
//  Created by LP Mackbook on 16/09/2026.
//

import UIKit

class MainCell: UITableViewCell {
    
    @IBOutlet var eReloadView: CustemView!
    
    @IBOutlet var eReload: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        eReloadView.layer.cornerRadius = eReloadView.bounds.height / 2
        
                contentView.layer.cornerRadius = 16.0
                
                contentView.layer.maskedCorners = [
                    .layerMinXMinYCorner, // Top Left
                    .layerMaxXMaxYCorner  // Bottom Right
                ]
                contentView.layer.masksToBounds = true

    }
    }
    
  
