//
//  ChatInboxCollectionViewCell.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 09/09/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit

protocol ChatInboxDelegate: class{
    func onClick(cell: ChatInboxCollectionViewCell)
}

class ChatInboxCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: ChatInboxDelegate?
    @IBOutlet weak var UserImage: UIImageView!
    @IBOutlet weak var Username: UILabel!
    @IBOutlet weak var ButtonClick: UIButton!
    
    @IBAction func ChatClick(_ sender: Any) {
        self.delegate?.onClick(cell: self)
    }
    
    
}
