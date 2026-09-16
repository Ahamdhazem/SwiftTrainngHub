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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        eReloadView.layer.cornerRadius = eReloadView.bounds.height / 2
    }
    
}
