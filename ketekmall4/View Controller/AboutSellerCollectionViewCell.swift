//
//  AboutSellerCollectionViewCell.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 01/09/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import AARatingBar

protocol AboutSellerDelegate: class{
    func onViewClick(cell: AboutSellerCollectionViewCell)
    func onAddToFav(cell: AboutSellerCollectionViewCell)
    func onAddToCart(cell: AboutSellerCollectionViewCell)
}

class AboutSellerCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: AboutSellerDelegate?
    
    @IBOutlet weak var ItemImage: UIImageView!
    @IBOutlet weak var ItemName: UILabel!
    @IBOutlet weak var ItemPrice: UILabel!
    @IBOutlet weak var ItemLocation: UILabel!
    @IBOutlet weak var AddToFav: UIButton!
    @IBOutlet weak var AddToCart: UIButton!
    @IBOutlet weak var ButtonView: UIButton!
    @IBOutlet weak var Rating: AARatingBar!
    
    @IBAction func ViewClick(_ sender: Any) {
        self.delegate?.onViewClick(cell: self)
    }
    
    @IBAction func AddToFav(_ sender: Any) {
        self.delegate?.onAddToFav(cell: self)
    }
    
    @IBAction func AddToCart(_ sender: Any) {
        self.delegate?.onAddToCart(cell: self)
    }
}
