
import UIKit
import AARatingBar

protocol ShockingDelegate: class {
    func onViewClick1(cell: ShockingSaleCollectionViewCell)
    func onAddToCart1(cell: ShockingSaleCollectionViewCell)
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
        let clickImage = UITapGestureRecognizer(target: self, action: #selector(ViewImage1(sender:)))
        ItemImage.isUserInteractionEnabled = true
        ItemImage.addGestureRecognizer(clickImage)
    }
    
    @objc func ViewImage1(sender: Any){
        self.delegate?.onViewClick1(cell: self)
    }
    
    @IBAction func AddCart1(sender: Any) {
        self.delegate?.onAddToCart1(cell: self)
    }
}
