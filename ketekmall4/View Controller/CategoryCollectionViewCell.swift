//
//  CategoryCollectionViewCell.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 31/08/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit

protocol CategoryDelegate: class {
    func onViewClick(cell: CategoryCollectionViewCell)
}

class CategoryCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: CategoryDelegate?
    
    @IBOutlet weak var ItemImage: UIImageView!
    @IBOutlet weak var ItemName: UILabel!
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var District: UILabel!
    @IBOutlet weak var ButtonView: UIButton!
    
    @IBAction func ViewClick(_ sender: Any) {
        self.delegate?.onViewClick(cell: self)
    }
    
}
