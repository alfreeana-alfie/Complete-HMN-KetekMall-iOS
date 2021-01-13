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
