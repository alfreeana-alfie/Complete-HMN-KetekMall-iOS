//
//  ViewProductViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 30/08/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire
import AFNetworking
import SDWebImage

class ViewProductViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, FromSameShopDelegate {
    
    @IBOutlet weak var ItemImage: UIImageView!
    @IBOutlet weak var ItemName: UILabel!
    @IBOutlet weak var ItemPrice: UILabel!
    @IBOutlet weak var Sold: UILabel!
    @IBOutlet weak var ShippingInfo: UILabel!
    @IBOutlet weak var MoreDetails: UILabel!
    
    @IBOutlet weak var SellerImage: UIImageView!
    @IBOutlet weak var SellerName: UILabel!
    @IBOutlet weak var SellerDivision: UILabel!
    @IBOutlet weak var WhatsappButton: UIImageView!
    @IBOutlet weak var ViewButton: UIButton!
    
    @IBOutlet weak var ReviewImage: UIImageView!
    @IBOutlet weak var ReviewName: UILabel!
    @IBOutlet weak var Review: UILabel!
    @IBOutlet weak var ViewReview: UILabel!
    
    @IBOutlet weak var ViewSameShop: UILabel!
    @IBOutlet weak var SameShopView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ITEMNAME.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FromSameShopCollectionViewCell", for: indexPath) as! FromSameShopCollectionViewCell
        
        cell.ItemName.text! = self.ITEMNAME[indexPath.row]
        cell.ItemPrice.text! = self.ITEMPRICE[indexPath.row]
        
        return cell
    }
    
    func onViewClick(cell: FromSameShopCollectionViewCell) {
        guard let indexPath = self.SameShopView.indexPath(for: cell) else{
            return
        }
        
        let viewProduct = self.storyboard!.instantiateViewController(identifier: "ViewProductViewController") as! ViewProductViewController
        viewProduct.USERID = USERID
        viewProduct.ItemID = self.ITEMID_SAMESHOP[indexPath.row]
        viewProduct.SELLERID = self.SELLERID
        viewProduct.MAINCATE = self.MAINCATE_SAMESHOP[indexPath.row]
        viewProduct.SUBCATE = self.SUBCATE_SAMESHOP[indexPath.row]
        viewProduct.ADDETAIL = self.ADDETAIL_SAMESHOP[indexPath.row]
        viewProduct.BRAND = self.BRAND_SAMESHOP[indexPath.row]
        viewProduct.INNER = self.INNER_SAMESHOP[indexPath.row]
        viewProduct.STOCK = self.STOCK_SAMESHOP[indexPath.row]
        viewProduct.DESC = self.DESC_SAMESHOP[indexPath.row]
        viewProduct.PRICE = self.PRICE_SAMESHOP[indexPath.row]
        viewProduct.PHOTO = self.PHOTO_SAMESHOP[indexPath.row]
        viewProduct.DIVISION = self.DIVISION_SAMESHOP[indexPath.row]
        viewProduct.DISTRICT = self.DISTRICT_SAMESHOP[indexPath.row]
        if let navigator = self.navigationController {
            navigator.pushViewController(viewProduct, animated: true)
        }
    }
    
    @IBAction func AddToCart(_ sender: Any) {
        
        let parameters: Parameters=[
            "seller_id": SELLERID,
            "item_id": ItemID,
            "customer_id": USERID,
            "main_category": MAINCATE,
            "sub_category": SUBCATE,
            "ad_detail": ADDETAIL,
            "price": PRICE,
            "quantity": "1",
            "division": DIVISION,
            "district": DISTRICT,
            "photo": PHOTO
        ]
        
        //Sending http post request
        Alamofire.request(URL_ADD_CART, method: .post, parameters: parameters).responseJSON
            {
                response in
                //printing response
                //                print(response)
                
                //getting the json value from the server
                if let result = response.result.value {
                    
                    //converting it as NSDictionary
                    let jsonData = result as! NSDictionary
                    print(jsonData.value(forKey: "message")!)
                    
                }
        }
    }
    
    let URL_ADD_CART = "https://ketekmall.com/ketekmall/add_to_cart.php"
    let URL_READ_SELLER = "https://ketekmall.com/ketekmall/read_order_done_seller.php"
    let URL_READ_REVIEW = "https://ketekmall.com/ketekmall/read_review.php"
    let URL_READ_DELIVERY = "https://ketekmall.com/ketekmall/read_delivery_single.php"
    let URL_READ = "https://ketekmall.com/ketekmall/read_detail.php"
    let URL_EDIT_RATING = "https://ketekmall.com/ketekmall/edit_detail_rating.php"
    let URL_EDIT_SOLD = "https://ketekmall.com/ketekmall/edit_detail_sold.php"
    let URL_READALL_SELLER = "https://ketekmall.com/ketekmall/readall_seller.php"
    let MAIN_PHOTO = "https://ketekmall.com/ketekmall/profile_image/main_photo.png"
    
    var ItemID: String = ""
    var SELLERID: String = ""
    var MAINCATE: String = ""
    var SUBCATE: String = ""
    var ADDETAIL: String = ""
    var BRAND: String = ""
    var INNER: String = ""
    var STOCK: String = ""
    var DESC: String = ""
    var PRICE: String = ""
    var DIVISION: String = ""
    var DISTRICT: String = ""
    var PHOTO: String = ""
    var USERID: String = ""
    var SOLD: String = ""
    
    var ITEMIMAGE: [String] = []
    var ITEMNAME: [String] = []
    var ITEMPLACE: [String] = []
    var ITEMPRICE: [String] = []
    var SELLERID_SAMESHOP: [String] = []
    var MAINCATE_SAMESHOP: [String] = []
    var SUBCATE_SAMESHOP: [String] = []
    var BRAND_SAMESHOP: [String] = []
    var INNER_SAMESHOP: [String] = []
    var STOCK_SAMESHOP: [String] = []
    var DESC_SAMESHOP: [String] = []
    var MAXORDER_SAMESHOP: [String] = []
    var DIVISION_SAMESHOP: [String] = []
    var RATING_SAMESHOP: [String] = []
    var ITEMID_SAMESHOP: [String] = []
    var ADDETAIL_SAMESHOP: [String] = []
    var PRICE_SAMESHOP: [String] = []
    var PHOTO_SAMESHOP: [String] = []
    var DISTRICT_SAMESHOP: [String] = []
    
    var ITEMID_DEL: [String] = []
    var USERID_DEL: [String] = []
    var DIVISION_DEL: [String] = []
    var DAYS_DEL: [String] = []
    var PRICE_DEL: [String] = []
    var DEL_ID: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SameShopView.delegate = self
        SameShopView.dataSource = self
        
        let NEWIm = PHOTO.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        ItemImage.setImageWith(URL(string: NEWIm!)!)
        ItemName.text! = ADDETAIL
        ItemPrice.text! = "MYR" + PRICE
        
        
        ShippingInfo.isUserInteractionEnabled = true
        MoreDetails.isUserInteractionEnabled = true
        ViewReview.isUserInteractionEnabled = true
        ViewSameShop.isUserInteractionEnabled = true
        
        let ShippingInfo_Click = UITapGestureRecognizer(target: self, action: #selector(onShippingInfoClick(sender:)))
        let MoreDetails_Click = UITapGestureRecognizer(target: self, action: #selector(onMoreDetailsClick(sender:)))
        let ViewReview_Click = UITapGestureRecognizer(target: self, action: #selector(onViewReview(sender:)))
        let ViewSameShop_Click = UITapGestureRecognizer(target: self, action: #selector(onFromSameShopClick(sender:)))
        
        ShippingInfo.addGestureRecognizer(ShippingInfo_Click)
        MoreDetails.addGestureRecognizer(MoreDetails_Click)
        ViewReview.addGestureRecognizer(ViewReview_Click)
        ViewSameShop.addGestureRecognizer(ViewSameShop_Click)
        
        getSellerDetails()
        getReview()
        getSold()
        SameShopList()
    }
    
    func getSellerDetails(){
        let parameters: Parameters=[
            "id": SELLERID
        ]
        
        Alamofire.request(URL_READ, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        let user = jsonData.value(forKey: "read") as! NSArray
                        
                        let name = user.value(forKey: "name") as! [String]
                        let district = user.value(forKey: "division") as! [String]
                        let Photo = user.value(forKey: "photo") as! [String]
                        
                        self.SellerName.text = name[0]
                        self.SellerDivision.text! = district[0]
                        self.SellerImage.setImageWith(URL(string: Photo[0])!)
                    }
                }else{
                    print("FAILED")
                }
                
        }
    }
    
    func getReview(){
        let parameters: Parameters=[
            "item_id": ItemID
        ]
        
        Alamofire.request(URL_READ_REVIEW, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        let user = jsonData.value(forKey: "read") as! NSArray
                        
                        let name = user.value(forKey: "customer_name") as! [String]
                        let review = user.value(forKey: "review") as! [String]
                        //                        let rating = user.value(forKey: "rating") as! [String]
                        
                        self.ReviewName.text = name[0]
                        self.Review.text! = review[0]
                        self.ReviewImage.setImageWith(URL(string: self.MAIN_PHOTO)!)
                    }
                }else{
                    print("REVIEW FAILED")
                }
                
        }
    }
    
    func getSold(){
        let parameters: Parameters=[
            "seller_id": SELLERID,
            "ad_detail": ADDETAIL,
        ]
        
        Alamofire.request(URL_READ_SELLER, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        let user = jsonData.value(forKey: "read") as! NSArray
                        
                        let ID = user.value(forKey: "id") as! [String]
                        
                        
                        self.SOLD = String(ID.count)
                        self.EditSold(ItemID: self.ItemID, SoldCount: self.SOLD)
                        
                        self.Sold.text! = self.SOLD
                    }
                }else{
                    print("FAILED")
                }
                
        }
    }
    
    func EditSold(ItemID: String, SoldCount: String){
        let parameters: Parameters=[
            "item_id": ItemID,
            "sold": SoldCount,
        ]
        
        Alamofire.request(URL_EDIT_SOLD, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    print("SUCCESS")
                }else{
                    print("FAILED")
                }
                
        }
    }
    
    func SameShopList(){
        let parameters: Parameters=[
            "user_id": SELLERID
        ]
        
        Alamofire.request(URL_READALL_SELLER, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        let user = jsonData.value(forKey: "read") as! NSArray
                        
                        let ItemID = user.value(forKey: "id") as! [String]
                        //                                        let Seller_ID = user.value(forKey: "user_id") as! [String]
                        let Main_Cate = user.value(forKey: "main_category") as! [String]
                        let Sub_Cate = user.value(forKey: "sub_category") as! [String]
                        let Ad_Detail = user.value(forKey: "ad_detail") as! [String]
                        let brand_mat = user.value(forKey: "brand_material") as! [String]
                        let inner_mat = user.value(forKey: "inner_material") as! [String]
                        let stock = user.value(forKey: "stock") as! [String]
                        let description = user.value(forKey: "description") as! [String]
                        //                        let max_order = user.value(forKey: "max_order") as! [String]
                        let rating = user.value(forKey: "rating") as! [String]
                        let Price = user.value(forKey: "price") as! [String]
                        let Photo = user.value(forKey: "photo") as! [String]
                        let Division = user.value(forKey: "division") as! [String]
                        let District = user.value(forKey: "district") as! [String]
                        
                        self.ITEMID_SAMESHOP = ItemID
                        //                                        self.SELLERID_SAMESHOP = Seller_ID
                        self.MAINCATE_SAMESHOP = Main_Cate
                        self.SUBCATE_SAMESHOP = Sub_Cate
                        self.ADDETAIL_SAMESHOP = Ad_Detail
                        self.BRAND_SAMESHOP = brand_mat
                        self.INNER_SAMESHOP = inner_mat
                        self.STOCK_SAMESHOP = stock
                        self.DESC_SAMESHOP = description
                        self.PRICE_SAMESHOP = Price
                        //                        self.MAXORDER = max_order
                        self.PHOTO_SAMESHOP = Photo
                        self.RATING_SAMESHOP = rating
                        self.DIVISION_SAMESHOP = Division
                        self.DISTRICT_SAMESHOP = District
                        
                        self.SameShopView.reloadData()
                        
                    }
                }
        }
    }
    
    @objc func onShippingInfoClick(sender: Any){
        
        let click = self.storyboard!.instantiateViewController(identifier: "ShippingInfoViewController") as! ShippingInfoViewController
        click.ITEMID = ItemID
        if let navigator = self.navigationController {
            navigator.pushViewController(click, animated: true)
        }
    }
    
    @objc func onMoreDetailsClick(sender: Any){
        
        let click = self.storyboard!.instantiateViewController(identifier: "MoreDetailsViewController") as! MoreDetailsViewController
        click.BRAND = BRAND
        click.INNER = INNER
        click.STOCK = STOCK
        click.DISTRICT = DISTRICT
        click.DIVISION = DIVISION
        click.DESC = DESC
        if let navigator = self.navigationController {
            navigator.pushViewController(click, animated: true)
        }
    }
    
    @IBAction func onAboutSellerClick(_ sender: Any){
        
        let click = self.storyboard!.instantiateViewController(identifier: "AboutSellerViewController") as! AboutSellerViewController
        if let navigator = self.navigationController {
            navigator.pushViewController(click, animated: true)
        }
    }
    
    @objc func onViewReview(sender: Any){
        let click = self.storyboard!.instantiateViewController(identifier: "ViewReviewViewController") as! ViewReviewViewController
        click.ITEMID = ItemID
        if let navigator = self.navigationController {
            navigator.pushViewController(click, animated: true)
        }
    }
    
    @objc func onFromSameShopClick(sender: Any){
        let click = self.storyboard!.instantiateViewController(identifier: "AboutSellerViewController") as! AboutSellerViewController
        if let navigator = self.navigationController {
            navigator.pushViewController(click, animated: true)
        }
    }
    
}
