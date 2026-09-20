//
//  EreloadCell.swift
//  TrainngHub
//
//  Created by LP Mackbook on 20/09/2026.
//

import UIKit

class EreloadCell: UITableViewCell {
    
    @IBOutlet var contentTypeimage: UIImageView!
    @IBOutlet var category: UILabel!
    @IBOutlet var mainStackView: UIStackView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        mainStackView.layer.cornerRadius = 12
        
        mainStackView.clipsToBounds = true
    }
    
    func configer(_ reload : Reload){
        self.category.text = reload.category
        self.contentTypeimage.image = UIImage(systemName: reload.imageName)
    }
}
