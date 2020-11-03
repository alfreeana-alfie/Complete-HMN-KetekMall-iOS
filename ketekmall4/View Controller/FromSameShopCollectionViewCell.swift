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
    func onAddToCart2(cell: FromSameShopCollectionViewCell)
}

class FromSameShopCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: FromSameShopDelegate?
    
    @IBOutlet weak var ItemImage: UIImageView!
    @IBOutlet weak var ItemName: UILabel!
    @IBOutlet weak var ItemPrice: UILabel!
    @IBOutlet weak var ButtonView: UIButton!
    @IBOutlet weak var Rating: AARatingBar!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let clickImage = UITapGestureRecognizer(target: self, action: #selector(ViewImage(sender:)))
        ItemImage.isUserInteractionEnabled = true
        ItemImage.addGestureRecognizer(clickImage)
    }
    
    @objc func ViewImage(sender: Any){
        self.delegate?.onViewClick(cell: self)
    }
    
    @IBAction func AddtoCart(_ sender: Any) {
        self.delegate?.onAddToCart2(cell: self)
    }

}
