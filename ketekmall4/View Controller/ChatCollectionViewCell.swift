
import UIKit

protocol ChatInbox: class{
    func onViewClick(cell: AboutSellerCollectionViewCell)
}

class ChatCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var UserImage: UIImageView!
    @IBOutlet weak var UserName: UILabel!
    @IBOutlet weak var ChatCount: UILabel!
    @IBOutlet weak var ChatBadgeView: UIView!
}


