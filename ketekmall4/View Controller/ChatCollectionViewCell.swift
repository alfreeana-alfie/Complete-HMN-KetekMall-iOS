//
//  ChatCollectionViewCell.swift
//  ketekmall4
//
//  Created by HMN Nadhir on 09/10/2020.
//  Copyright © 2020 HMN Nadhir. All rights reserved.
//

import UIKit

protocol ChatInbox: class{
    func onViewClick(cell: AboutSellerCollectionViewCell)
}

class ChatCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var UserImage: UIImageView!
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var ChatCount: UILabel!
    @IBOutlet weak var ChatBadgeView: UIView!
}


