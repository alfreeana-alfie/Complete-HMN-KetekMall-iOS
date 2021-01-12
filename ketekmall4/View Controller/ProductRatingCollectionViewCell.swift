//
//  ProductRatingCollectionViewCell.swift
//  ketekmall4
//
//  Created by HMN Nadhir on 29/08/2020.
//  Copyright © 2020 HMN Nadhir. All rights reserved.
//

import UIKit
import AARatingBar

class ProductRatingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ItemImage: UIImageView!
    @IBOutlet weak var AdDetail: UILabel!
    @IBOutlet weak var UserImage: UIImageView!
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var Description: UILabel!
    @IBOutlet weak var Rating: AARatingBar!
    
}
