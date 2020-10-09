//
//  ChatCollectionViewCell.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 09/10/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit

protocol ChatInbox: class{
    func onViewClick(cell: AboutSellerCollectionViewCell)
}

class ChatCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var UserImage: UIImageView!
    @IBOutlet weak var UserName: UILabel!
}


