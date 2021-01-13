
import UIKit
import AARatingBar

protocol CategoryDelegate: class {
    func onViewClick(cell: CategoryCollectionViewCell)
    func onAddToFav(cell: CategoryCollectionViewCell)
    func onAddToCart(cell: CategoryCollectionViewCell)
}

class CategoryCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: CategoryDelegate?
    
    @IBOutlet weak var ItemImage: UIImageView!
    @IBOutlet weak var ItemName: UILabel!
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var District: UILabel!
    @IBOutlet weak var ButtonView: UIButton!
    @IBOutlet weak var ButtonAddToFav: UIButton!
    @IBOutlet weak var ButtonAddToCart: UIButton!
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
    
    @IBAction func AddToFav(_ sender: Any) {
        self.delegate?.onAddToFav(cell: self)
    }
    
    @IBAction func AddToCart(_ sender: Any) {
        self.delegate?.onAddToCart(cell: self)
    }
    
}
