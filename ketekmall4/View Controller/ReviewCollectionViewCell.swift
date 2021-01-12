//
//  ReviewCollectionViewCell.swift
//  ketekmall4
//
//  Created by HMN Nadhir on 01/09/2020.
//  Copyright © 2020 HMN Nadhir. All rights reserved.
//

import UIKit
import AARatingBar

class ReviewCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var UserImage: UIImageView!
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var Review: UILabel!
    @IBOutlet weak var Rating: AARatingBar!
    
}
