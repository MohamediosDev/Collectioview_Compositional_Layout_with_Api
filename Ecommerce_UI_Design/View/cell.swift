//
//  cell.swift
//  Ecommerce_UI_Design
//
//  Created by Soda on 6/1/21.
//

import UIKit
import Kingfisher

class cell: UICollectionViewCell {
    @IBOutlet weak var imageViewShow: UIImageView!
    
    func configureCell(image:String) {
        
        let url = URL(string:image)
        imageViewShow.kf.indicatorType = .activity
        imageViewShow.kf.setImage(with: url)
        
        
    }
   
    
}
