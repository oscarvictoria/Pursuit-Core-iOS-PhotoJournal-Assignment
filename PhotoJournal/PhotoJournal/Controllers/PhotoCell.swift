//
//  PhotoCell.swift
//  PhotoJournal
//
//  Created by Oscar Victoria Gonzalez  on 1/22/20.
//  Copyright © 2020 Oscar Victoria Gonzalez . All rights reserved.
//

import UIKit

class PhotoCell: UITableViewCell {
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //layer.cornerRadius = 20.0
    }
    
    
    func configuredCell(imageObject: ImageObject) {
        guard let image = UIImage(data: imageObject.imageData) else {
            return
        }
        imageView?.image = image
    }
}
