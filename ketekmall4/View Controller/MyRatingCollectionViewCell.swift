//
//  MyRatingCollectionViewCell.swift
//  ketekmall4
//
//  Created by HMN Nadhir on 30/08/2020.
//  Copyright © 2020 HMN Nadhir. All rights reserved.
//

import UIKit
import AARatingBar

class MyRatingCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ItemImage: UIImageView!
    @IBOutlet weak var AdDetail: UILabel!
    @IBOutlet weak var UserImage: UIImageView!
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var UserReview: UILabel!
    @IBOutlet weak var Rating: AARatingBar!
    
}
