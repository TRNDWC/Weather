//
//  ContentCell.swift
//  Weather
//
//  Created by Trần Đức on 13/8/24.
//

import UIKit

class ContentCell: UICollectionViewCell {
    
    static let identifier = "ContentCell"
    
    static func nib() -> UINib {
        return UINib(nibName: "ContentCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
