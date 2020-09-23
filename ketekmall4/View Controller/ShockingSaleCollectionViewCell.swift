//
//  ShockingSaleCollectionViewCell.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 31/08/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import AARatingBar

protocol ShockingDelegate: class {
    func onViewClick3(cell: ShockingSaleCollectionViewCell)
}

class ShockingSaleCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: ShockingDelegate?
    
    @IBOutlet weak var ItemImage: UIImageView!
    @IBOutlet weak var ItemName: UILabel!
    @IBOutlet weak var ItemPrice: UILabel!
    @IBOutlet weak var ButtonView: UIButton!
    @IBOutlet weak var Rating: AARatingBar!
    
    @IBAction func ViewClick3(_ sender: Any) {
        self.delegate?.onViewClick3(cell: self)
    }
}
