//
//  MyLikesCollectionViewCell.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 30/08/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import AARatingBar

protocol MyLikesDelegate: class {
    func btnRemove(cell: MyLikesCollectionViewCell)
    func btnVIEW(cell: MyLikesCollectionViewCell)
   }

class MyLikesCollectionViewCell: UICollectionViewCell {
    
    
    weak var delegate: MyLikesDelegate?
    
    @IBOutlet weak var ItemImage: UIImageView!
    @IBOutlet weak var ItemName: UILabel!
    @IBOutlet weak var ItemPrice: UILabel!
    @IBOutlet weak var ItemLocation: UILabel!
    @IBOutlet weak var BtnRemove: UIButton!
    @IBOutlet weak var BtnView: UIButton!
    @IBOutlet weak var RatingBar: AARatingBar!
    
    @IBAction func someButton(sender: Any){
        self.delegate?.btnRemove(cell: self)
    }
    
    @IBAction func buttonView(sender: Any){
        self.delegate?.btnVIEW(cell: self)
    }
}
