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
    func onViewClick1(cell: ShockingSaleCollectionViewCell)
}

class ShockingSaleCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: ShockingDelegate?
    
    @IBOutlet weak var ItemImage: UIImageView!
    @IBOutlet weak var ItemName: UILabel!
    @IBOutlet weak var ItemPrice: UILabel!
    @IBOutlet weak var ButtonView: UIButton!
    @IBOutlet weak var Rating: AARatingBar!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let clickImage = UITapGestureRecognizer(target: self, action: #selector(ViewClick1(sender:)))
        ItemImage.isUserInteractionEnabled = true
        ItemImage.addGestureRecognizer(clickImage)
    }
    
    @IBAction func ViewClick1(sender: Any) {
        self.delegate?.onViewClick1(cell: self)
    }
}
