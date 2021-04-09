

import UIKit
import Alamofire
import JGProgressHUD

class MyRatingViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var MyRatingView: UICollectionView!
    
    
    private let spinner = JGProgressHUD(style: .dark)
    
    var userID: String = ""

    var ItemID: String = ""
    var AdDetailSIngle: String = ""
    var CustomerImage: String = ""
    var CustomerName: String = ""
    var CustomerReview: String = ""
    var CustomerRating: String = ""
    
    let URL_READ_PRODUCT = "https://ketekmall.com/ketekmall/read_products_review.php"
    let URL_READ_REVIEW = "https://ketekmall.com/ketekmall/read_review_user.php"
    
    var item_id: [String] = []
    var ad_detail: [String] = []
    var ad_detail1: [String] = []
    var item_image: [String] = []
    var customer_name: [String] = []
    var customer_review: [String] = []
    var customer_rating: [String] = []
    
    let Customer_Image = "https://ketekmall.com/ketekmall/profile_image/main_photo.png"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MyRatingView.delegate = self
        MyRatingView.dataSource = self
        
        navigationItem.title = "My Rating"
        spinner.show(in: self.view)
                let parameters: Parameters=[
                    "customer_id": userID,
                ]

                Alamofire.request(URL_READ_REVIEW, method: .post, parameters: parameters).responseJSON
                    {
                        response in

                        if let result = response.result.value as? Dictionary<String,Any>{
                            if let list = result["read"] as? [Dictionary<String,Any>]{
                                self.spinner.dismiss(afterDelay: 3.0)
                                for i in list{
                                    self.ItemID = i["item_id"] as! String
                                    self.CustomerName = i["customer_name"] as! String
                                    self.CustomerReview = i["review"] as! String
                                    self.CustomerRating = i["rating"] as! String
                                    
                                    self.item_id.append(self.ItemID)
                                    self.customer_name.append(self.CustomerName)
                                    self.customer_review.append(self.CustomerReview)
                                    self.customer_rating.append(self.CustomerRating)
                                    
                                    let parameters1: Parameters=[
                                        "id": self.ItemID,
                                    ]

                                    Alamofire.request(self.URL_READ_PRODUCT, method: .post, parameters: parameters1).responseJSON
                                        {
                                            response in
                                            if let result = response.result.value as? Dictionary<String,Any>{
                                                if let list = result["read"] as? [Dictionary<String,Any>]{
                                                    for i in list{
                                                        self.AdDetailSIngle = i["ad_detail"] as! String
                                                        self.CustomerImage = i["photo"] as! String

                                                        self.item_image.append(self.CustomerImage)
                                                        self.ad_detail.append(self.AdDetailSIngle)
        //                                                print(self.item_image)

                                                        self.MyRatingView.reloadData()
                                                    }
                                                }

                                            }

                                    }


                                }

                            }

                        }


                }
        self.hideKeyboardWhenTappedAround()
    }

    @objc override func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ad_detail.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let screenSize = collectionView.bounds
            let screenWidth = screenSize.width
    //        let screenHeight = screenSize.height
            let cellSquareSize: CGFloat = screenWidth
            let cellSquareHeight: CGFloat = 172
            return CGSize(width: cellSquareSize, height: cellSquareHeight);
        }
           
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0.0, right: 0.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyRatingCollectionViewCell", for: indexPath) as! MyRatingCollectionViewCell
        
        if !self.item_image[indexPath.row].contains("%20"){
            print("contain whitespace \(self.item_image[indexPath.row].trimmingCharacters(in: .whitespaces))")
            let NEWIm = self.item_image[indexPath.row].addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            
            cell.ItemImage.setImageWith(URL(string: NEWIm!)!)
        }else{
            print("contain whitespace")
            
            cell.ItemImage.setImageWith(URL(string: self.item_image[indexPath.row])!)
        }
        
        if let n = NumberFormatter().number(from: self.customer_rating[indexPath.row]) {
            let f = CGFloat(truncating: n)
            cell.Rating.value = f
        }
        cell.AdDetail.text! = self.ad_detail[indexPath.row]
        cell.UserName.text! = self.customer_name[indexPath.row]
        cell.UserImage.setImageWith(URL(string: Customer_Image)!)
        cell.UserReview.text! = self.customer_review[indexPath.row]
        return cell
    }
    

}
