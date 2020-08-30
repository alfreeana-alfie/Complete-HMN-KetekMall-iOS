//
//  MyProductsCollectionViewCell.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 29/08/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit

protocol MyProductDelegate: class {
    func btnRemove(cell: MyProductsCollectionViewCell)
    func btnEdit(cell: MyProductsCollectionViewCell)
}

class MyProductsCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: MyProductDelegate?
    
    @IBOutlet weak var ItemName: UILabel!
    @IBOutlet weak var ItemImage: UIImageView!
    @IBOutlet weak var ItemPrice: UILabel!
    @IBOutlet weak var ItemLocation: UILabel!
    
    @IBOutlet weak var Btn_Edit: UIButton!
    @IBOutlet weak var Btn_Cancel: UIButton!
    
    @IBAction func Edit(sender: Any){
        self.delegate?.btnEdit(cell: self)
    }
    
    @IBAction func Remove(sender:Any){
        self.delegate?.btnRemove(cell: self)
    }
    
}
