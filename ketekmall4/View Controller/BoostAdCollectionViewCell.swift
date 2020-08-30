//
//  BoostAdCollectionViewCell.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 29/08/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit

protocol BoostAdDelegate: class {
    func btnCANCEL(cell: BoostAdCollectionViewCell)
}

class BoostAdCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: BoostAdDelegate?
    
    @IBOutlet weak var ItemImage: UIImageView!
    @IBOutlet weak var AdDetail: UILabel!
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var ShockingSale: UILabel!
    @IBOutlet weak var ButtonCancel: UIButton!
    
    @IBAction func Cancel(sender: Any){
        self.delegate?.btnCANCEL(cell: self)
    }
    
}
