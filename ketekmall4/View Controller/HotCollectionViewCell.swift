//
//  HotCollectionViewCell.swift
//  ketekmall4
//
//  Created by HMN Nadhir on 31/08/2020.
//  Copyright © 2020 HMN Nadhir. All rights reserved.
//

import UIKit
import AARatingBar

protocol HotDelegate: class {
    func onViewClick(cell: HotCollectionViewCell)
    func onAddToCart(cell: HotCollectionViewCell)
    
}

class HotCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: HotDelegate?
    
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
    
    @IBAction func AddCart(sender: Any){
        self.delegate?.onAddToCart(cell: self)
    }
}
