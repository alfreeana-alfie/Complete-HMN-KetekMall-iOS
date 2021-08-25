

import UIKit
import Alamofire
import JGProgressHUD
import ImagePicker
import PhotosUI

class AddNewProductViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate, PHPickerViewControllerDelegate {
    
    @IBOutlet weak var CategoryLabel: UILabel!
    @IBOutlet weak var AdDetailLabel: UILabel!
    @IBOutlet weak var DistrictLabel: UILabel!
    @IBOutlet weak var PriceLabel: UILabel!
    @IBOutlet weak var MaxOrderLabel: UILabel!
    @IBOutlet weak var DivisionLabel: UILabel!
    @IBOutlet weak var UploadedPhotoLabel: UILabel!
    @IBOutlet weak var WeightLabel: UILabel!
    @IBOutlet weak var PostCodeLabel: UILabel!
    
    @IBOutlet weak var Category: UITextField!
    @IBOutlet weak var Price: UITextField!
    @IBOutlet weak var Division: UITextField!
    @IBOutlet weak var District: UITextField!
    @IBOutlet weak var MaxOrder: UITextField!
    @IBOutlet weak var Weight: UITextField!
    @IBOutlet weak var PostCode: UITextField!
    
    @IBOutlet weak var ItemImage: UIImageView!
    @IBOutlet weak var ItemImage2: UIImageView!
    @IBOutlet weak var ItemImage3: UIImageView!
    @IBOutlet weak var ItemImage4: UIImageView!
    @IBOutlet weak var ItemImage5: UIImageView!
    
    @IBOutlet weak var Delete_2: UIButton!
    @IBOutlet weak var Delete_3: UIButton!
    @IBOutlet weak var Delete_4: UIButton!
    @IBOutlet weak var Delete_5: UIButton!
    
    @IBOutlet weak var ImageView1: UIView!
    @IBOutlet weak var ImageView2: UIView!
    @IBOutlet weak var ImageView3: UIView!
    @IBOutlet weak var ImageView4: UIView!
    @IBOutlet weak var ImageView5: UIView!
    
//    @IBOutlet weak var UploadImage: UIButton!
    @IBOutlet weak var ButtonAccept: UIButton!
    @IBOutlet weak var ButtonCancel: UIButton!
    @IBOutlet weak var ButtonAdDetail: UIButton!
    
    let URL_ADD = "https://ketekmall.com/ketekmall/products/uploadimg_new.php";
    let URL_UPLOAD_EXTRA = "https://ketekmall.com/ketekmall/products_img/uploadimg03.php"
    let URL_DELETE_PHOTO = "https://ketekmall.com/ketekmall/products_img/delete_photo.php"
    
    // NEW SETUP FOR IMAGE UPLOADING
    let ADD_TEMP = "https://ketekmall.com/ketekmall/products/add_temp.php"
    let DELETE_TEMP = "https://ketekmall.com/ketekmall/products/delete_temp.php"
    let DELETE_DB_TEMP = "https://ketekmall.com/ketekmall/products/delete_db_temp.php"
    let ADD = "https://ketekmall.com/ketekmall/products/add.php"
    
    let category = ["Process food", "Handicraft","Health and Beauty", "Home and Living", "Fashion Accessories", "Sarawak Product"]
    let division = ["Kuching", "Kota Samarahan", "Serian", "Sri Aman", "Betong", "Sarikei", "Sibu", "Mukah", "Bintulu", "Kapit", "Miri", "Limbang"]
    let kuching = ["Kuching", "Bau", "Lundu"]
    let samarahan = ["Kota Samarahan", "Asajaya", "Simunjan"]
    let serian = ["Serian", "Tembedu"]
    let sri_aman = ["Sri Aman", "Lubok Antu"]
    let betong = ["Betong", "Saratok", "Pusa","Kabong"]
    let sarikei = ["Sarikei", "Meradong", "Julau", "Pakan"]
    let sibu = ["Sibu", "Kanowit", "Selangau"]
    let mukah = ["Mukah", "Dalat", "Matu", "Daro", "Tanjong"]
    let bintulu = ["Bintulu", "Sebauh", "Tatau"]
    let kapit = ["Kapit", "Song", "Belaga", "Bukit Mabong"]
    let miri = ["Miri", "Marudi", "Subis", "Beluru", "Telang Usan"]
    let limbang = ["Limbang", "Lawas"]
    
    var CategoryPicker = UIPickerView()
    var DivisionPicker = UIPickerView()
    var DistrictPicker = UIPickerView()
    var userID: String = ""
    var BrandMaterial: String = ""
    var InnerMaterial: String = ""
    var Stock: String = ""
    var Description: String = ""
    var Addetail: String = ""
    var CategoryText: String = ""
    var CategorySubText: String = ""
    var DivisionText: String = ""
    var DistrictText: String = ""
    var photoTempId: [String] = []
    
    var flag = 0
    
    let sharedPref = UserDefaults.standard
    var lang: String = ""

    override func viewDidAppear(_ animated: Bool) {
        ColorFunc()
    }
    
    @objc override func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        //Looks for single or multiple taps.
         let tap = UITapGestureRecognizer(target: self, action: #selector(CategoryViewController.dismissKeyboard))

        view.addGestureRecognizer(tap)

        Category.delegate = self
        Price.delegate = self
        Division.delegate = self
        District.delegate = self
        MaxOrder.delegate = self
        Weight.delegate = self
        PostCode.delegate = self
        
        lang = sharedPref.string(forKey: "LANG") ?? "0"
        if(lang == "ms"){
            changeLanguage(str: "ms")
            
        }else{
            changeLanguage(str: "en")
            
        }
        
        print("\(CategoryText)")
        
        if(!CategoryText.isEmpty){
            Category.text! = CategoryText
        }
        
        if(!DivisionText.isEmpty){
            Division.text! = DivisionText
        }
        
        if(!DistrictText.isEmpty){
            District.text! = DistrictText
        }
        
        CategoryPicker.dataSource = self
        CategoryPicker.delegate = self
        
        DivisionPicker.dataSource = self
        DivisionPicker.delegate = self
        
        DistrictPicker.dataSource = self
        DistrictPicker.delegate = self
        
        Category.inputView = CategoryPicker
        Division.inputView = DivisionPicker
        District.inputView = DistrictPicker
        
        CreateCategoryPicker()
        CreateDivisionPicker()
        CreateDistrictPicker()
        
        ButtonAccept.layer.cornerRadius = 15
        ButtonCancel.layer.cornerRadius = 15
//        UploadImage.layer.cornerRadius = 5
        ButtonAdDetail.layer.cornerRadius = 7
        
        Delete_2.isHidden = true
        Delete_3.isHidden = true
        Delete_4.isHidden = true
        Delete_5.isHidden = true
        
        ItemImage.layer.cornerRadius = 7
        ItemImage2.layer.cornerRadius = 7
        ItemImage3.layer.cornerRadius = 7
        ItemImage4.layer.cornerRadius = 7
        ItemImage5.layer.cornerRadius = 7
        
        Delete_2.layer.cornerRadius = 7
        Delete_3.layer.cornerRadius = 7
        Delete_4.layer.cornerRadius = 7
        Delete_5.layer.cornerRadius = 7
        
        ImageView1.isUserInteractionEnabled = true
        ImageView2.isUserInteractionEnabled = true
        ImageView3.isUserInteractionEnabled = true
        ImageView4.isUserInteractionEnabled = true
        ImageView5.isUserInteractionEnabled = true
        
        let Image1 = UITapGestureRecognizer(target: self, action: #selector(selectImage1(sender:)))
        let Image2 = UITapGestureRecognizer(target: self, action: #selector(selectImage2(sender:)))
        let Image3 = UITapGestureRecognizer(target: self, action: #selector(selectImage3(sender:)))
        let Image4 = UITapGestureRecognizer(target: self, action: #selector(selectImage4(sender:)))
        let Image5 = UITapGestureRecognizer(target: self, action: #selector(selectImage5(sender:)))
        
        ImageView1.addGestureRecognizer(Image1)
        ImageView2.addGestureRecognizer(Image2)
        ImageView3.addGestureRecognizer(Image3)
        ImageView4.addGestureRecognizer(Image4)
        ImageView5.addGestureRecognizer(Image5)
        
//        UploadImage.addTarget(self, action: #selector(selectImage1), for: .touchUpInside)
        
        navigationItem.title = "Add New Product"
        self.hideKeyboardWhenTappedAround()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name: UIResponder.keyboardWillHideNotification, object: nil);
        
        print(String(photoTempId.count))
        
        let link = "https://ketekmall.com/ketekmall/products/"
        let jpg = ".jpg"
        
        if(photoTempId.isEmpty){
            ItemImage.image = UIImage(named: "AddPhoto")
            ItemImage2.image = UIImage(named: "AddPhoto")
            ItemImage3.image = UIImage(named: "AddPhoto")
            ItemImage4.image = UIImage(named: "AddPhoto")
            ItemImage5.image = UIImage(named: "AddPhoto")
        }else if(photoTempId.count == 1){
            ItemImage.setImageWith(URL(string: link + photoTempId[0] + jpg)!)
            ItemImage.contentMode = UIView.ContentMode.scaleAspectFill;
        }else if(photoTempId.count == 2){
            ItemImage.setImageWith(URL(string: link + photoTempId[0] + jpg)!)
            ItemImage.contentMode = UIView.ContentMode.scaleAspectFill;

            ItemImage2.setImageWith(URL(string: link + photoTempId[1] + jpg)!)
            ItemImage2.contentMode = UIView.ContentMode.scaleAspectFill;

            Delete_2.isHidden = false
        }else if(photoTempId.count == 3){
            ItemImage.setImageWith(URL(string: link + photoTempId[0] + jpg)!)
            ItemImage.contentMode = UIView.ContentMode.scaleAspectFill;

            ItemImage2.setImageWith(URL(string: link + photoTempId[1] + jpg)!)
            ItemImage2.contentMode = UIView.ContentMode.scaleAspectFill;

            ItemImage3.setImageWith(URL(string: link + photoTempId[2] + jpg)!)
            ItemImage3.contentMode = UIView.ContentMode.scaleAspectFill;

            Delete_2.isHidden = false
            Delete_3.isHidden = false
        }else if(photoTempId.count == 4){
            ItemImage.setImageWith(URL(string: link + photoTempId[0] + jpg)!)
            ItemImage.contentMode = UIView.ContentMode.scaleAspectFill;

            ItemImage2.setImageWith(URL(string: link + photoTempId[1] + jpg)!)
            ItemImage2.contentMode = UIView.ContentMode.scaleAspectFill;

            ItemImage3.setImageWith(URL(string: link + photoTempId[2] + jpg)!)
            ItemImage3.contentMode = UIView.ContentMode.scaleAspectFill;

            ItemImage4.setImageWith(URL(string: link + photoTempId[3] + jpg)!)
            ItemImage4.contentMode = UIView.ContentMode.scaleAspectFill;

            Delete_2.isHidden = false
            Delete_3.isHidden = false
            Delete_4.isHidden = false
        }else if(photoTempId.count == 5){
            ItemImage.setImageWith(URL(string: link + photoTempId[0] + jpg)!)
            ItemImage.contentMode = UIView.ContentMode.scaleAspectFill;

            ItemImage2.setImageWith(URL(string: link + photoTempId[1] + jpg)!)
            ItemImage2.contentMode = UIView.ContentMode.scaleAspectFill;

            ItemImage3.setImageWith(URL(string: link + photoTempId[2] + jpg)!)
            ItemImage3.contentMode = UIView.ContentMode.scaleAspectFill;

            ItemImage4.setImageWith(URL(string: link + photoTempId[3] + jpg)!)
            ItemImage4.contentMode = UIView.ContentMode.scaleAspectFill;

            ItemImage5.setImageWith(URL(string: link + photoTempId[4] + jpg)!)
            ItemImage5.contentMode = UIView.ContentMode.scaleAspectFill;

            Delete_2.isHidden = false
            Delete_3.isHidden = false
            Delete_4.isHidden = false
            Delete_5.isHidden = false
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    func ColorFunc(){
        //Button Accept
        let colorImageOne1 = UIColor(hexString: "#FC4A1A").cgColor
        let colorImageOne2 = UIColor(hexString: "#F7B733").cgColor
        
        let ImageOneGradient = CAGradientLayer()
        ImageOneGradient.frame = ImageView1.bounds
        ImageOneGradient.colors = [colorImageOne1, colorImageOne2]
        ImageOneGradient.startPoint = CGPoint(x: 0, y: 0.5)
        ImageOneGradient.endPoint = CGPoint(x: 1, y: 0.5)
        ImageOneGradient.cornerRadius = 5
            ImageView1.layer.insertSublayer(ImageOneGradient, at: 0)
            ImageView2.layer.insertSublayer(ImageOneGradient, at: 0)
            ImageView3.layer.insertSublayer(ImageOneGradient, at: 0)
            ImageView4.layer.insertSublayer(ImageOneGradient, at: 0)
            ImageView5.layer.insertSublayer(ImageOneGradient, at: 0)
        
        //Button Accept
        let color1 = UIColor(hexString: "#AA076B").cgColor
        let color2 = UIColor(hexString: "#61045F").cgColor
        
        let ReceivedGradient = CAGradientLayer()
        ReceivedGradient.frame = ButtonAccept.bounds
        ReceivedGradient.colors = [color1, color2]
        ReceivedGradient.startPoint = CGPoint(x: 0, y: 0.5)
        ReceivedGradient.endPoint = CGPoint(x: 1, y: 0.5)
        ReceivedGradient.cornerRadius = 5
            ButtonAccept.layer.insertSublayer(ReceivedGradient, at: 0)
        
        //Button Cancel
        let color3 = UIColor(hexString: "#BC4E9C").cgColor
        let color4 = UIColor(hexString: "#F80759").cgColor
        
        let CancelGradient = CAGradientLayer()
        CancelGradient.frame = ButtonCancel.bounds
        CancelGradient.colors = [color3, color4]
        CancelGradient.startPoint = CGPoint(x: 0, y: 0.5)
        CancelGradient.endPoint = CGPoint(x: 1, y: 0.5)
        CancelGradient.cornerRadius = 5
        ButtonCancel.layer.insertSublayer(CancelGradient, at: 0)
    }
    
    func changeLanguage(str: String){
        CategoryLabel.text = "Category".localized(lang: str)
        AdDetailLabel.text = "Product Details".localized(lang: str)
        PriceLabel.text = "Price".localized(lang: str)
        DivisionLabel.text = "Division".localized(lang: str)
        DistrictLabel.text = "District".localized(lang: str)
        MaxOrderLabel.text = "Max Order".localized(lang: str)
        WeightLabel.text = "Weight (Kg)".localized(lang: str)
        PostCodeLabel.text = "Postcode".localized(lang: str)
        UploadedPhotoLabel.text = "Upload Image".localized(lang: str)
        Category.placeholder = "Category".localized(lang: str)
        ButtonAdDetail.setTitle("Edit Details".localized(lang: str), for: .normal)
//        UploadImage.setTitle("Upload Image".localized(lang: str), for: .normal)
        Price.placeholder = "Price".localized(lang: str)
        Division.placeholder = "Division".localized(lang: str)
        District.placeholder = "District".localized(lang: str)
        MaxOrder.placeholder = "Max Order".localized(lang: str)
        Weight.placeholder = "Weight".localized(lang: str)
        PostCode.placeholder = "Postcode".localized(lang: str)
        
        ButtonAccept.setTitle("NEXT".localized(lang: str), for: .normal)
        ButtonCancel.setTitle("CANCEL".localized(lang: str), for: .normal)
//        ButtonAccept.titleLabel?.text = "ACCEPT".localized(lang: str)
//        ButtonCancel.titleLabel?.text = "CANCEL".localized(lang: str)
    }
    
    @objc func keyboardWillShow(sender: NSNotification) {
         self.view.frame.origin.y = -150 // Move view 150 points upward
    }

    @objc func keyboardWillHide(sender: NSNotification) {
         self.view.frame.origin.y = 0 // Move view to original position
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == CategoryPicker {
            return category.count
            
        } else if pickerView == DivisionPicker{
            return division.count        }
        else if pickerView == DistrictPicker{
            if(Division.text == "Kuching"){
                return kuching.count
            } else if(Division.text == "Kota Samarahan"){
                return samarahan.count
            } else if(Division.text == "Serian"){
                return serian.count
            }  else if(Division.text == "Sri Aman"){
                return sri_aman.count
            } else if(Division.text == "Betong"){
                return betong.count
            } else if(Division.text == "Sarikei"){
                return sarikei.count
            }else if(Division.text == "Sibu"){
                return sibu.count
            }else if(Division.text == "Mukah"){
                return mukah.count
            }else if(Division.text == "Bintulu"){
                return bintulu.count
            }else if(Division.text == "Kapit"){
                return kapit.count
            }else if(Division.text == "Miri"){
                return miri.count
            }else if(Division.text == "Limbang"){
                return limbang.count
            }
        }
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerView == CategoryPicker {
            return category[row]
            
        } else if pickerView == DivisionPicker{
            return division[row]
        }else if pickerView == DistrictPicker{
            if(Division.text == "Kuching"){
                return kuching[row]
            } else if(Division.text == "Kota Samarahan"){
                return samarahan[row]
            }else if(Division.text == "Serian"){
                return serian[row]
            }  else if(Division.text == "Sri Aman"){
                return sri_aman[row]
            } else if(Division.text == "Betong"){
                return betong[row]
            } else if(Division.text == "Sarikei"){
                return sarikei[row]
            }else if(Division.text == "Sibu"){
                return sibu[row]
            }else if(Division.text == "Mukah"){
                return mukah[row]
            }else if(Division.text == "Bintulu"){
                return bintulu[row]
            }else if(Division.text == "Kapit"){
                return kapit[row]
            }else if(Division.text == "Miri"){
                return miri[row]
            }else if(Division.text == "Limbang"){
                return limbang[row]
            }
        }
        
        return ""
    }
    
    @IBAction func AdDetail(_ sender: Any) {
        let AdDetail = self.storyboard!.instantiateViewController(withIdentifier: "EditProductAdDetailViewController") as! EditProductAdDetailViewController
        AdDetail.USERID = userID
//        AdDetail.ITEMID = ""
        AdDetail.ADDETAIL = Addetail
        AdDetail.MAINCATE = Category.text!
        AdDetail.SUBCATE = Category.text!
//        AdDetail.PRICE = Price.text!
        AdDetail.BRAND = BrandMaterial
        AdDetail.INNER = InnerMaterial
        AdDetail.STOCK = Stock
        AdDetail.DESC = Description
        AdDetail.PhotoId = photoTempId
//        AdDetail.DIVISION = Division.text!
//        AdDetail.DISTRICT = District.text!
//        AdDetail.PHOTO = ""
//        AdDetail.MAXORDER = MaxOrder.text!
//        AdDetail.POSTCODE = PostCode.text!
//        AdDetail.WEIGHT = Weight.text!
        AdDetail.CheckView = true
        if let navigator = self.navigationController {
            navigator.pushViewController(AdDetail, animated: true)
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == CategoryPicker {
            Category.text = category[row]
            self.view.endEditing(false)
        } else if pickerView == DivisionPicker{
            Division.text = division[row]
            self.view.endEditing(false)
        }else if pickerView == DistrictPicker{
            if(Division.text == "Kuching"){
                District.text = kuching[row]
                self.view.endEditing(false)
            } else if(Division.text == "Kota Samarahan"){
                District.text = samarahan[row]
                self.view.endEditing(false)
            }else if(Division.text == "Serian"){
                District.text = serian[row]
            }  else if(Division.text == "Sri Aman"){
                District.text = sri_aman[row]
            } else if(Division.text == "Betong"){
                District.text = betong[row]
            } else if(Division.text == "Sarikei"){
                District.text = sarikei[row]
            }else if(Division.text == "Sibu"){
                District.text = sibu[row]
            }else if(Division.text == "Mukah"){
                District.text = mukah[row]
            }else if(Division.text == "Bintulu"){
                District.text = bintulu[row]
            }else if(Division.text == "Kapit"){
                District.text = kapit[row]
            }else if(Division.text == "Miri"){
                District.text = miri[row]
            }else if(Division.text == "Limbang"){
                District.text = limbang[row]
            }
            
        }
    }
    
    func CreateCategoryPicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        Category.inputAccessoryView = toolbar
        Category.inputView = CategoryPicker
    }
    
    func CreateDivisionPicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        Division.inputAccessoryView = toolbar
        Division.inputView = DivisionPicker
    }
    
    func CreateDistrictPicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        District.inputAccessoryView = toolbar
        District.inputView = DistrictPicker
    }
    
    @objc func donePressed(){
        self.view.endEditing(true)
    }
    
    func saveImage(number: String, addetail: String, Image: UIImageView){
        let imageData: Data = Image.image!.pngData()!
        let imageStr: String = imageData.base64EncodedString()
        
        let filename = addetail + number
        
        let parameters: Parameters=[
            "item_id": 0,
            "ad_detail": addetail,
            "filename": filename,
            "filepath": imageStr,
            
        ]
        
        //Sending http post request
        Alamofire.request(URL_UPLOAD_EXTRA, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value {
                    let jsonData = result as! NSDictionary
                    print(jsonData.value(forKey: "message")!)
                    print("Success upload: " + number)
                }else{
                    print("FAILED UPLOAD")
                }
        }
    }
    
    @IBAction func DeletePhoto2(_ sender: Any) {
        ItemImage2.contentMode = .center
        ItemImage2.image = UIImage(named: "AddPhoto")
        if(deleteTemp(count: 1)){
            Delete_2.isHidden = true
        }
    }
    
    @IBAction func DeletePhoto3(_ sender: Any) {
        ItemImage3.contentMode = .center
        ItemImage3.image = UIImage(named: "AddPhoto")
        if(deleteTemp(count: 2)){
            Delete_3.isHidden = true
        }
    }
    
    @IBAction func DeletePhoto4(_ sender: Any) {
        ItemImage4.contentMode = .center
        ItemImage4.image = UIImage(named: "AddPhoto")
        if(deleteTemp(count: 3)){
            Delete_4.isHidden = true
        }
    }
    
    @IBAction func DeletePhoto5(_ sender: Any) {
        ItemImage5.contentMode = .center
        ItemImage5.image = UIImage(named: "AddPhoto")
        if(deleteTemp(count: 4)){
            Delete_5.isHidden = true
        }
    }
    
    @objc private func selectImage1(sender: UITapGestureRecognizer) {
        flag = 1
        if #available(iOS 14, *) {
        // using PHPickerViewController
            var config = PHPickerConfiguration()
            config.selectionLimit = 1
            config.filter = .images
            config.preferredAssetRepresentationMode = .current
            let picker = PHPickerViewController(configuration: config)
            picker.delegate = self
                DispatchQueue.main.async {
                    self.present(picker, animated: true)
                }
        }else{
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true)
        }
    }
        
    @objc private func selectImage2(sender: UITapGestureRecognizer) {
        flag = 2
        if #available(iOS 14, *) {
        // using PHPickerViewController
            var config = PHPickerConfiguration()
            config.selectionLimit = 1
            config.filter = .images
            config.preferredAssetRepresentationMode = .current
            let picker = PHPickerViewController(configuration: config)
            picker.delegate = self
                DispatchQueue.main.async {
                    self.present(picker, animated: true)
                }
        }else{
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true)
        }
    }
        
    @objc private func selectImage3(sender: UITapGestureRecognizer) {
        flag = 3
        if #available(iOS 14, *) {
        // using PHPickerViewController
            var config = PHPickerConfiguration()
            config.selectionLimit = 1
            config.filter = .images
            config.preferredAssetRepresentationMode = .current
            let picker = PHPickerViewController(configuration: config)
            picker.delegate = self
                DispatchQueue.main.async {
                    self.present(picker, animated: true)
                }
        }else{
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true)
        }
    }
        
    @objc private func selectImage4(sender: UITapGestureRecognizer) {
        flag = 4
        if #available(iOS 14, *) {
        // using PHPickerViewController
            var config = PHPickerConfiguration()
            config.selectionLimit = 1
            config.filter = .images
            config.preferredAssetRepresentationMode = .current
            let picker = PHPickerViewController(configuration: config)
            picker.delegate = self
                DispatchQueue.main.async {
                    self.present(picker, animated: true)
                }
        }else{
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true)
        }
    }
        
    @objc private func selectImage5(sender: UITapGestureRecognizer) {
        flag = 5
        if #available(iOS 14, *) {
        // using PHPickerViewController
            var config = PHPickerConfiguration()
            config.selectionLimit = 1
            config.filter = .images
            config.preferredAssetRepresentationMode = .current
            let picker = PHPickerViewController(configuration: config)
            picker.delegate = self
                DispatchQueue.main.async {
                    self.present(picker, animated: true)
                }
        }else{
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .photoLibrary
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true)
        }
    }
    
    @available(iOS 14, *)
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
       for result in results {
        picker.dismiss(animated: true, completion: nil)
          result.itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { (object, error) in
             if let chosenImage = object as? UIImage {
                if(self.flag == 1){
                    if(self.photoTempId.isEmpty){
                        self.ItemImage.contentMode = UIView.ContentMode.scaleAspectFill
                        self.ItemImage.image = chosenImage
                        self.AddTemp(filename: chosenImage.toPngString()!, count: 0)

//                        self.dismiss(animated: true, completion: nil)
                    }else if(!self.photoTempId.isEmpty){
                        if(self.deleteTemp(count: 0)){
                            self.ItemImage.contentMode = UIView.ContentMode.scaleAspectFill
                            self.ItemImage.image = chosenImage
                            self.AddTemp(filename: chosenImage.toPngString()!, count: 0)
//                            self.dismiss(animated: true, completion: nil)
                        }
                    }
                    
                }else if(self.flag == 2){
                    if(self.photoTempId.count == 2){
                        if(self.deleteTemp(count: 1)){
                            self.ItemImage2.contentMode = UIView.ContentMode.scaleAspectFill
                            self.ItemImage2.image = chosenImage
                            
                            self.AddTemp(filename: chosenImage.toPngString()!, count: 1)
                            self.Delete_2.isHidden = false
                            
//                            dismiss(animated: true, completion: nil)
                        }
                    }else{
                        self.ItemImage2.contentMode = UIView.ContentMode.scaleAspectFill
                        self.ItemImage2.image = chosenImage
                        
                        self.AddTemp(filename: chosenImage.toPngString()!, count: 1)
                        self.Delete_2.isHidden = false
                        
//                        dismiss(animated: true, completion: nil)
                    }
                }else if(self.flag == 3){
                    if(self.photoTempId.count == 3){
                        if(self.deleteTemp(count: 2)){
                            self.ItemImage3.contentMode = UIView.ContentMode.scaleAspectFill
                            self.ItemImage3.image = chosenImage
                            
                            self.AddTemp(filename: chosenImage.toPngString()!, count: 2)
                            self.Delete_3.isHidden = false
                        }
                    }else{
                        self.ItemImage3.contentMode = UIView.ContentMode.scaleAspectFill
                        self.ItemImage3.image = chosenImage
                        
                        self.AddTemp(filename: chosenImage.toPngString()!, count: 2)
                        self.Delete_3.isHidden = false
                    }
//                    dismiss(animated: true, completion: nil)
                }else if(self.flag == 4){
                    if(self.photoTempId.count == 4){
                        if(self.deleteTemp(count: 3)){
                            self.ItemImage4.contentMode = UIView.ContentMode.scaleAspectFill
                            self.ItemImage4.image = chosenImage
                            
                            self.AddTemp(filename: chosenImage.toPngString()!, count: 3)
                            self.Delete_4.isHidden = false
                        }
                    }else{
                        self.ItemImage4.contentMode = UIView.ContentMode.scaleAspectFill
                        self.ItemImage4.image = chosenImage
                        
                        self.AddTemp(filename: chosenImage.toPngString()!, count: 3)
                        self.Delete_4.isHidden = false
                    }
//                    dismiss(animated: true, completion: nil)
                }else if(self.flag == 5){
                    if(self.photoTempId.count == 5){
                        if(self.deleteTemp(count: 4)){
                            self.ItemImage5.contentMode = UIView.ContentMode.scaleAspectFill
                            self.ItemImage5.image = chosenImage
                            self.AddTemp(filename: chosenImage.toPngString()!, count: 4)
                            self.Delete_5.isHidden = false
                        }
                    }else{
                        self.ItemImage5.contentMode = UIView.ContentMode.scaleAspectFill
                        self.ItemImage5.image = chosenImage
                        self.AddTemp(filename: chosenImage.toPngString()!, count: 4)
                        self.Delete_5.isHidden = false
                    }
//                    dismiss(animated: true, completion: nil)
                }
             }
          })
       }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let chosenImage = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.originalImage.rawValue)] as? UIImage{
            if(flag == 1){
                if(photoTempId.isEmpty){
                    ItemImage.contentMode = UIView.ContentMode.scaleAspectFill
                    ItemImage.image = chosenImage
                    AddTemp(filename: chosenImage.toPngString()!, count: 0)

                    dismiss(animated: true, completion: nil)
                }else if(!photoTempId.isEmpty){
                    if(deleteTemp(count: 0)){
                        ItemImage.contentMode = UIView.ContentMode.scaleAspectFill
                        ItemImage.image = chosenImage
                        AddTemp(filename: chosenImage.toPngString()!, count: 0)

                        dismiss(animated: true, completion: nil)
                    }
                }
                
            }else if(flag == 2){
                if(photoTempId.count == 2){
                    if(deleteTemp(count: 1)){
                        ItemImage2.contentMode = UIView.ContentMode.scaleAspectFill
                        ItemImage2.image = chosenImage
                        
                        AddTemp(filename: chosenImage.toPngString()!, count: 1)
                        self.Delete_2.isHidden = false
                        
                        dismiss(animated: true, completion: nil)
                    }
                }else{
                    ItemImage2.contentMode = UIView.ContentMode.scaleAspectFill
                    ItemImage2.image = chosenImage
                    
                    AddTemp(filename: chosenImage.toPngString()!, count: 1)
                    self.Delete_2.isHidden = false
                    
                    dismiss(animated: true, completion: nil)
                }
            }else if(flag == 3){
                if(photoTempId.count == 3){
                    if(deleteTemp(count: 2)){
                        ItemImage3.contentMode = UIView.ContentMode.scaleAspectFill
                        ItemImage3.image = chosenImage
                        
                        AddTemp(filename: chosenImage.toPngString()!, count: 2)
                        self.Delete_3.isHidden = false
                    }
                }else{
                    ItemImage3.contentMode = UIView.ContentMode.scaleAspectFill
                    ItemImage3.image = chosenImage
                    
                    AddTemp(filename: chosenImage.toPngString()!, count: 2)
                    self.Delete_3.isHidden = false
                }
//                if(self.ItemImage3.image == chosenImage){
//                    print("PRESENT")
//                    self.Delete_3.isHidden = false
//                }else{
//                    print("EMPTY")
//                }
                dismiss(animated: true, completion: nil)
            }else if(flag == 4){
                if(photoTempId.count == 4){
                    if(deleteTemp(count: 3)){
                        ItemImage4.contentMode = UIView.ContentMode.scaleAspectFill
                        ItemImage4.image = chosenImage
                        
                        AddTemp(filename: chosenImage.toPngString()!, count: 3)
                        self.Delete_4.isHidden = false
                    }
                }else{
                    ItemImage4.contentMode = UIView.ContentMode.scaleAspectFill
                    ItemImage4.image = chosenImage
                    
                    AddTemp(filename: chosenImage.toPngString()!, count: 3)
                    self.Delete_4.isHidden = false
                }
//                if(self.ItemImage4.image == chosenImage){
//                    print("PRESENT")
//
//                }else{
//                    print("EMPTY")
//                }
                dismiss(animated: true, completion: nil)
            }else if(flag == 5){
                if(photoTempId.count == 5){
                    if(deleteTemp(count: 4)){
                        ItemImage5.contentMode = UIView.ContentMode.scaleAspectFill
                        ItemImage5.image = chosenImage
                        AddTemp(filename: chosenImage.toPngString()!, count: 4)
                        self.Delete_5.isHidden = false
                    }
                }else{
                    ItemImage5.contentMode = UIView.ContentMode.scaleAspectFill
                    ItemImage5.image = chosenImage
                    AddTemp(filename: chosenImage.toPngString()!, count: 4)
                    self.Delete_5.isHidden = false
                }
//                if(self.ItemImage5.image == chosenImage){
//                    print("PRESENT")
//
//                }else{
//                    print("EMPTY")
//                }
                dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func Accept(_ sender: Any) {
        add()
    }
    
    @IBAction func Cancel(_ sender: Any) {
        for n in 0..<photoTempId.count {
            deleteAllTemp(count: n)
        }
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    func randomString() -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var s = ""
        for _ in 0 ..< 20 {
            s.append(letters.randomElement()!)
        }
        return s
    }
    
    func AddTemp(filename: String, count: Int) {
        let filename_temp = randomString()
        photoTempId.insert(filename_temp, at: count)
        
        let parameters: Parameters=[
            "filename_temp": filename_temp,
            "photo": filename
        ]
        
        //Sending http post request
        Alamofire.request(ADD_TEMP, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value {
                    let jsonData = result as! NSDictionary
                    print(jsonData.value(forKey: "message")!)
                }else{
                    print("FAILED UPLOAD")
                }
        }
        
        print(String(photoTempId.count))
        print(photoTempId[count])
    }
    
    func deleteTemp(count: Int) -> Bool{
        let photoId = photoTempId[count]
        
        let parameters: Parameters=[
            "id": photoId
        ]
        
        //Sending http post request
        Alamofire.request(DELETE_TEMP, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value {
                    let jsonData = result as! NSDictionary
                    print(jsonData.value(forKey: "message")!)
                }else{
                    print("FAILED UPLOAD")
                }
        }
        photoTempId.remove(at: count)
        return true
    }
    
    func deleteAllTemp(count: Int){
        let photoId = photoTempId[count]
        
        let parameters: Parameters=[
            "id": photoId
        ]
        
        //Sending http post request
        Alamofire.request(DELETE_TEMP, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value {
                    let jsonData = result as! NSDictionary
                    print(jsonData.value(forKey: "message")!)
                }else{
                    print("FAILED UPLOAD")
                }
        }
    }
    
    func deleteDbTemp(count: Int){
        let photoId = photoTempId[count]
        
        let parameters: Parameters=[
            "id": photoId
        ]
        
        //Sending http post request
        Alamofire.request(DELETE_DB_TEMP, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value {
                    let jsonData = result as! NSDictionary
                    print(jsonData.value(forKey: "message")!)
                }else{
                    print("FAILED UPLOAD")
                }
        }
//        photoTempId.remove(at: count)
    }
    
    func add(){
        let spinner = JGProgressHUD(style: .dark)

        spinner.show(in: self.view)
        
        if(photoTempId.count < 5){
            for _ in photoTempId.count...4 {
                photoTempId.append("null")
            }
        }
        
        let parameters: Parameters=[
            "user_id": userID,
            "main_category":CategoryText,
            "sub_category":CategoryText,
            "ad_detail":Addetail,
            "brand_material":BrandMaterial,
            "inner_material": BrandMaterial,
            "stock": Stock,
            "description": Description,
            "price": Price.text!,
            "max_order": MaxOrder.text!,
            "division": Division.text!,
            "postcode": PostCode.text!,
            "district": District.text!,
            "photo": photoTempId[0],
            "photo02": photoTempId[1],
            "photo03": photoTempId[2],
            "photo04": photoTempId[3],
            "photo05": photoTempId[4],
            "weight": Weight.text!
        ]
        
//        //Sending http post request
        Alamofire.request(ADD, method: .post, parameters: parameters).responseJSON
            {
                response in
            if let result = response.result.value {
                    spinner.dismiss(afterDelay: 3.0)
                    for n in 0..<self.photoTempId.count {
                        self.deleteDbTemp(count: n)
                    }
                    let accountsettings = self.storyboard!.instantiateViewController(withIdentifier: "MyProductsCollectionViewController") as! MyProductsCollectionViewController
                    accountsettings.userID = self.userID
                    if let navigator = self.navigationController {
                        navigator.pushViewController(accountsettings, animated: true)
                    }
                }else{
                    print("FAILED")
            }
        }
    }
}

extension UIImage {
    func toPngString() -> String? {
        let data = self.pngData()
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
  
    func toJpegString(compressionQuality cq: CGFloat) -> String? {
        let data = self.jpegData(compressionQuality: cq)
        return data?.base64EncodedString(options: .endLineWithLineFeed)
    }
}
