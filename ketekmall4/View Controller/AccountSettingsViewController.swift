//
//  AccountSettingsViewController.swift
//  ketekmall4
//
//  Created by Alfreeana Alfie on 28/08/2020.
//  Copyright © 2020 Alfreeana Alfie. All rights reserved.
//

import UIKit
import Alamofire
import AFNetworking
import JGProgressHUD

class AccountSettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate   {
    
    private let spinner = JGProgressHUD(style: .dark)
    
    let URL_READ = "https://ketekmall.com/ketekmall/read_detail.php";
    let URL_EDIT = "https://ketekmall.com/ketekmall/edit_detail.php";
    let URL_UPLOAD = "https://ketekmall.com/ketekmall/profile_image/upload.php"
    
    let sharedPref = UserDefaults.standard
    var lang: String = ""
    
    @IBOutlet weak var UploadPhoto: UIImageView!
    @IBOutlet weak var Name: UITextField!
    @IBOutlet weak var Email: UITextField!
    @IBOutlet weak var PhoneNo: UITextField!
    @IBOutlet weak var Address01: UITextField!
    @IBOutlet weak var Address02: UITextField!
    @IBOutlet weak var City: UITextField!
    @IBOutlet weak var PostCode: UITextField!
    @IBOutlet weak var Birthday: UITextField!
    @IBOutlet weak var ICNumber: UILabel!
    @IBOutlet weak var BankName: UITextField!
    @IBOutlet weak var BankAcc: UITextField!
    @IBOutlet weak var Gender: UITextField!
//    @IBOutlet weak var GenderLabel: UILabel!
    @IBOutlet weak var Btn_EditProfile: UIButton!
    @IBOutlet weak var Btn_Accept: UIButton!
    @IBOutlet weak var btnUpload: UIButton!
//    @IBOutlet weak var btnUploadServer: UIButton!
    @IBOutlet weak var EditProfileLabel: UILabel!
    @IBOutlet weak var ButtonImage: NSLayoutConstraint!
    
    @IBOutlet weak var Addr01View: UIView!
    @IBOutlet weak var Addr02View: UIView!
    @IBOutlet weak var Addr03View: UIView!
    @IBOutlet weak var NameView: UIView!
    @IBOutlet weak var EmailView: UIView!
    @IBOutlet weak var PhoneView: UIView!
    @IBOutlet weak var BirthView: UIView!
    @IBOutlet weak var GenderView: UIView!
    @IBOutlet weak var ICView: UIView!
    @IBOutlet weak var BankNameView: UIView!
    @IBOutlet weak var BankAccView: UIView!
    
    
    var userID = ""
    var testing = ""
    
    let gender = ["Female", "Male"]
    
    var pickerView = UIPickerView()
    var datePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        lang = sharedPref.string(forKey: "LANG") ?? "0"
        if(lang == "ms"){
            changeLanguage(str: "ms")
            
        }else{
            changeLanguage(str: "en")
            
        }
        
        pickerView.delegate = self
        pickerView.dataSource = self
        
        Btn_EditProfile.layer.cornerRadius = 15
        Btn_EditProfile.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        Btn_Accept.layer.cornerRadius = 15
        Btn_Accept.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        btnUpload.layer.cornerRadius = 7
        
        NameView.layer.cornerRadius = 5
        EmailView.layer.cornerRadius = 5
        PhoneView.layer.cornerRadius = 5
        Addr01View.layer.cornerRadius = 5
        Addr02View.layer.cornerRadius = 5
        BirthView.layer.cornerRadius = 5
        GenderView.layer.cornerRadius = 5
        ICView.layer.cornerRadius = 5
        BankNameView.layer.cornerRadius = 5
        BankAccView.layer.cornerRadius = 5
        
        Gender.inputView = pickerView
        CreateDatePicker()
        
        UploadPhoto.isUserInteractionEnabled = true
        
        let UploadClick = UITapGestureRecognizer(target: self, action: #selector(selectImage(sender:)))
        UploadPhoto.addGestureRecognizer(UploadClick)

        btnUpload.addTarget(self, action: #selector(uploadToServer), for: .touchUpInside)

        Btn_Accept.isHidden = true
        btnUpload.isHidden = true
        ButtonImage.constant = 0
    
        spinner.show(in: self.view)
        navigationItem.title = "Account Settings"
        let parameters: Parameters=[
            "id": userID,
        ]
        
        //Sending http post request
        Alamofire.request(URL_READ, method: .post, parameters: parameters).responseJSON
            {
                response in

                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        self.spinner.dismiss(afterDelay: 3.0)
                        let user = jsonData.value(forKey: "read") as! NSArray
                        let name = user.value(forKey: "name") as! [String]
                        let email = user.value(forKey: "email") as! [String]
                        let phone = user.value(forKey: "phone_no") as! [String]
                        let addr01 = user.value(forKey: "address_01") as! [String]
                        let addr02 = user.value(forKey: "address_02") as! [String]
                        let city = user.value(forKey: "division") as! [String]
                        let postcode = user.value(forKey: "postcode") as! [String]
                        let birthday = user.value(forKey: "birthday") as! [String]
                        let gender = user.value(forKey: "gender") as! [String]
                        let photo = user.value(forKey: "photo") as! [String]
                        let icno = user.value(forKey: "ic_no") as! [String]
                        let bankname = user.value(forKey: "bank_name") as! [String]
                        let bankacc = user.value(forKey: "bank_acc") as! [String]
                        
                        self.Name.text = name[0]
                        self.Email.text = email[0]
                        self.PhoneNo.text = phone[0]
                        self.Address01.text = addr01[0]
                        self.Address02.text = addr02[0]
                        self.City.text = city[0]
                        self.PostCode.text = postcode[0]
                        self.Birthday.text = birthday[0]
                        self.Gender.text = gender[0]
                        self.ICNumber.text = icno[0]
                        self.BankName.text = bankname[0]
                        self.BankAcc.text = bankacc[0]
                        
                        self.downloadImage(from: URL(string: photo[0])!)
                    }
                }
        }
        
        
    }
    
    func changeLanguage(str: String){
        EditProfileLabel.text = "Edit Profile".localized(lang: str)        
        Name.placeholder = "Name".localized(lang: str)
        Email.placeholder = "Email".localized(lang: str)
        PhoneNo.placeholder = "Phone Number".localized(lang: str)
        Address01.placeholder = "Address".localized(lang: str)
        Address02.placeholder = "Address".localized(lang: str)
        City.placeholder = "City".localized(lang: str)
        PostCode.placeholder = "PostCode".localized(lang: str)
        Birthday.placeholder = "Birthday".localized(lang: str)
        Gender.placeholder = "Gender".localized(lang: str)
        BankName.placeholder = "Bank Name".localized(lang: str)
        BankAcc.placeholder = "Bank Account".localized(lang: str)
//        btnUploadServer.setTitle("Upload to Server".localized(lang: str), for: .normal)
        btnUpload.setTitle("Upload Image".localized(lang: str), for: .normal)
        Btn_Accept.setTitle("ACCEPT".localized(lang: str), for: .normal)
        Btn_EditProfile.setTitle("Edit Profile".localized(lang: str), for: .normal)
    }

    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return gender.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return gender[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        Gender.text = gender[row]
    }
    
    @IBAction func EditProfile(_ sender: Any) {
        Btn_EditProfile.isHidden = true
        Btn_Accept.isHidden = false
    }
    
    @IBAction func Accept(_ sender: Any) {
        Btn_EditProfile.isHidden = true
        Btn_Accept.isHidden = false
        self.spinner.show(in: self.view)
        let parameters: Parameters=[
            "id": userID,
            "name":Name.text!,
            "email":Email.text!,
            "phone_no":PhoneNo.text!,
            "address_01":Address01.text!,
            "address_02": Address02.text!,
            "division": City.text!,
            "postcode": PostCode.text!,
            "birthday": Birthday.text!,
            "gender": Gender.text!,
            "bank_name": BankName.text!,
            "bank_acc": BankAcc.text!
        ]
        
        //Sending http post request
        Alamofire.request(URL_EDIT, method: .post, parameters: parameters).responseJSON
            {
                response in
                   if let result = response.result.value {
                    self.spinner.dismiss(afterDelay: 3.0)
                     let jsonData = result as! NSDictionary
                    print(jsonData.value(forKey: "message")!)
                    
                    let MeView = self.storyboard!.instantiateViewController(identifier: "ViewController") as! ViewController
                    MeView.userID = self.userID
                    if let navigator = self.navigationController {
                        navigator.pushViewController(MeView, animated: true)
                    }
                    
                   }else{
                    self.spinner.indicatorView = JGProgressHUDErrorIndicatorView()
                    self.spinner.textLabel.text = "Failed to Save"
                    self.spinner.show(in: self.view)
                    self.spinner.dismiss(afterDelay: 4.0)
                }
        }
    }
    
    func CreateDatePicker(){
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let doneBtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneBtn], animated: true)
        Birthday.inputAccessoryView = toolbar
        Birthday.inputView = datePicker
        
        datePicker.datePickerMode = .date
        
    }
    
    @objc private func uploadToServer(sender: UITapGestureRecognizer) {
        spinner.show(in: self.view)
        let imageData: Data = UploadPhoto.image!.pngData()!
        let imageStr: String = imageData.base64EncodedString()

        let parameters: Parameters=[
            "id": userID,
            "photo": imageStr,
        ]

        Alamofire.request(URL_UPLOAD, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value {
                    let jsonData = result as! NSDictionary
                    self.spinner.dismiss(afterDelay: 3.0)
                    print(jsonData.value(forKey: "message")!)
                }
        }
    }
    
    @objc private func selectImage(sender: UITapGestureRecognizer) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self as! UIImagePickerControllerDelegate & UINavigationControllerDelegate
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true, completion: nil)
        
        btnUpload.isHidden = false
        ButtonImage.constant = 40
    }
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerController.InfoKey.originalImage.rawValue] as! UIImage
        UploadPhoto.image = chosenImage
        dismiss(animated: true, completion: nil)
    }
    
    @objc func donePressed(){
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "dd/mm/YYYY"
        Birthday.text! = formatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    func downloadImage(from url: URL) {
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { [weak self] in
                self?.UploadPhoto.image = UIImage(data: data)
            }
        }
    }
}
