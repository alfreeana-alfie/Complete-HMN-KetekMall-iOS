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
    
    let ReceivedGradient = CAGradientLayer()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        let clickImage = UITapGestureRecognizer(target: self, action: #selector(ViewImage(sender:)))
        ItemImage.isUserInteractionEnabled = true
        ItemImage.addGestureRecognizer(clickImage)

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //Button Accept
        let color1 = UIColor(hexString: "#FC4A1A").cgColor
        let color2 = UIColor(hexString: "#F7B733").cgColor
        
        ReceivedGradient.frame = ButtonView.bounds
        ReceivedGradient.colors = [color1, color2]
        ReceivedGradient.locations = [0.0, 1.0]
        ReceivedGradient.startPoint = CGPoint(x: 0, y: 0.5)
        ReceivedGradient.endPoint = CGPoint(x: 1, y: 0.5)
        ReceivedGradient.cornerRadius = 7
        ButtonView.layer.insertSublayer(ReceivedGradient, at: 0)
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
