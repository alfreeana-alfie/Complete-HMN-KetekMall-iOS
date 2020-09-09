//
//  FromSameShopCollectionViewCell.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 01/09/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import AARatingBar

protocol FromSameShopDelegate: class {
    func onViewClick(cell: FromSameShopCollectionViewCell)
}

class FromSameShopCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: FromSameShopDelegate?
    
    @IBOutlet weak var ItemImage: UIImageView!
    @IBOutlet weak var ItemName: UILabel!
    @IBOutlet weak var ItemPrice: UILabel!
    @IBOutlet weak var ButtonView: UIButton!
    @IBOutlet weak var Rating: AARatingBar!
    
    @IBAction func ViewClick(_ sender: Any) {
        self.delegate?.onViewClick(cell: self)
    }

}
