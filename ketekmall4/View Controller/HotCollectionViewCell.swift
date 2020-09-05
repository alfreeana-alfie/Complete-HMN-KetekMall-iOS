//
//  HotCollectionViewCell.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 31/08/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import AARatingBar

protocol HotDelegate: class {
    func onViewClick(cell: HotCollectionViewCell)
    
}

class HotCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: HotDelegate?
    
    @IBOutlet weak var ItemImage: UIImageView!
    @IBOutlet weak var ItemName: UILabel!
    @IBOutlet weak var ItemPrice: UILabel!
    @IBOutlet weak var ButtonView: UIButton!
    @IBOutlet weak var Rating: AARatingBar!
    
    @IBAction func ViewClick(sender: Any){
        self.delegate?.onViewClick(cell: self)
    }
}
