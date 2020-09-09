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

class AccountSettingsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate   {
    
    let URL_READ = "https://ketekmall.com/ketekmall/read_detail.php";
    let URL_EDIT = "https://ketekmall.com/ketekmall/edit_detail.php";
    let URL_UPLOAD = "https://ketekmall.com/ketekmall/profile_image/upload.php"
    
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
    @IBOutlet weak var GenderLabel: UILabel!
    @IBOutlet weak var Btn_EditProfile: UIButton!
    @IBOutlet weak var Btn_Accept: UIButton!
    @IBOutlet weak var btnUpload: UIButton!
    @IBOutlet weak var btnUploadServer: UIButton!
    
    var userID = ""
    var testing = ""
    
    let gender = ["Female", "Male"]
    
    var pickerView = UIPickerView()
    var datePicker = UIDatePicker()

    override func viewDidLoad() {
        super.viewDidLoad()
        pickerView.delegate = self
        pickerView.dataSource = self
        
        Btn_EditProfile.layer.cornerRadius = 5
        Btn_Accept.layer.cornerRadius = 5
        btnUploadServer.layer.cornerRadius = 5
        btnUpload.layer.cornerRadius = 5
        
        Gender.inputView = pickerView
        CreateDatePicker()
        
        btnUpload.addTarget(self, action: #selector(uploadToServer), for: .touchUpInside)
        btnUploadServer.addTarget(self, action: #selector(selectImage), for: .touchUpInside)
        
        Btn_Accept.isHidden = true
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
                     let jsonData = result as! NSDictionary
                    print(jsonData.value(forKey: "message")!)
                    
                    let MeView = self.storyboard!.instantiateViewController(identifier: "MeViewController") as! MeViewController
                    MeView.userID = self.userID
                    if let navigator = self.navigationController {
                        navigator.pushViewController(MeView, animated: true)
                    }
                    
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
        let imageData: Data = UploadPhoto.image!.pngData()!
        let imageStr: String = imageData.base64EncodedString()

        let parameters: Parameters=[
            "id": userID,
            "photo": imageStr,
        ]
        
        //Sending http post request
        Alamofire.request(URL_UPLOAD, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value {
                    let jsonData = result as! NSDictionary
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
