//
//  FilterCell.swift
//  TrainngHub
//
//  Created by LP Mackbook on 22/09/2026.
//

import UIKit

class FilterCell: UICollectionViewCell {
    
    @IBOutlet var cellLabel: UILabel!
    @IBOutlet var labelView: UIView!
    static let identifier = "FilterCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        labelView.layer.cornerRadius = labelView.bounds.height / 2
        labelView.clipsToBounds = true
        cellLabel.layer.cornerRadius = cellLabel.bounds.height / 2
        cellLabel.clipsToBounds = true
    }
    
    func configer(_ latbelText : String){
        cellLabel.text = latbelText
        if (latbelText.lowercased() == "all"){
            self.isSelected = true
            updateStyle()
        }
    }

    
    override var isSelected: Bool {
        didSet {
            updateStyle()
        }
    }

    private func updateStyle() {
        if isSelected {
            labelView.backgroundColor = .systemBlue
        } else {
            labelView.backgroundColor = .systemGray6
        }
    }
}


