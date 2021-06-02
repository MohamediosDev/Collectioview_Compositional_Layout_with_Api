//
//  HeaderView.swift
//  Ecommerce_UI_Design
//
//  Created by Soda on 6/1/21.
//

import UIKit

class HeaderView: UICollectionReusableView {
    
    @IBOutlet weak var titleLabel: UILabel!

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    
    var title : String? {
        didSet {
            titleLabel.text  = title
        }
    }
    
}
