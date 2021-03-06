

import UIKit

class FilterViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITabBarDelegate {
    
    var DivisionFilter: String = ""
    var DistricFilter: String = ""
    
    var UserID: String = ""
    var URL_READ: String = ""
    var URL_SEARCH: String = ""
    var URL_FILTER_DISTRICT: String = ""
    var URL_FILTER_DIVISION: String = ""
    var URL_FILTER_SEARCH_DIVISION: String = ""
    
    let division = ["All", "Kuching", "Kota Samarahan", "Serian", "Sri Aman", "Betong", "Sarikei", "Sibu", "Mukah", "Bintulu", "Kapit", "Miri", "Limbang"]
    
    let kuching = ["All","Kuching", "Bau", "Lundu"]
    let samarahan = ["All","Kota Samarahan", "Asajaya", "Simunjan"]
    let serian = ["All","Serian", "Tembedu"]
    let sri_aman = ["All","Sri Aman", "Lubok Antu"]
    let betong = ["All","Betong", "Saratok", "Pusa","Kabong"]
    let sarikei = ["All","Sarikei", "Meradong", "Julau", "Pakan"]
    let sibu = ["All","Sibu", "Kanowit", "Selangau"]
    let mukah = ["All","Mukah", "Dalat", "Matu", "Daro", "Tanjong"]
    let bintulu = ["All","Bintulu", "Sebauh", "Tatau"]
    let kapit = ["All","Kapit", "Song", "Belaga", "Bukit Mabong"]
    let miri = ["All","Miri", "Marudi", "Subis", "Beluru", "Telang Usan"]
    let limbang = ["All","Limbang", "Lawas"]
    
    @IBOutlet weak var Division: UITextField!
    @IBOutlet weak var District: UITextField!
    @IBOutlet weak var ButtonApply: UIButton!
    @IBOutlet weak var ButtonCancel: UIButton!
    @IBOutlet weak var Tabbar: UITabBar!
    @IBOutlet weak var DivisionLabel: UILabel!
    @IBOutlet weak var DistrictLabel: UILabel!
    
    var viewController1: UIViewController?
    var DivisionPicker = UIPickerView()
    var DistrictPicker = UIPickerView()
    
    let sharedPref = UserDefaults.standard
    var lang: String = ""
    
    override func viewDidAppear(_ animated: Bool) {
        ColorFunc()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Tabbar.delegate = self
        
        DivisionPicker.dataSource = self
        DivisionPicker.delegate = self
        
        DistrictPicker.dataSource = self
        DistrictPicker.delegate = self
        
        CreateDivisionPicker()
        CreateDistrictPicker()
        
        Division.text! = DivisionFilter
        Division.layer.cornerRadius = 5
        District.text! = DistricFilter
        District.layer.cornerRadius = 5
        ButtonApply.layer.cornerRadius = 5
        ButtonCancel.layer.cornerRadius = 5
        
        lang = sharedPref.string(forKey: "LANG") ?? "0"
        if(lang == "ms"){
            changeLanguage(str: "ms")
            navigationItem.title = "Filter".localized(lang: "ms")
        }else{
            changeLanguage(str: "en")
            navigationItem.title = "Filter".localized(lang: "en")
        }
        
    }
    
    func ColorFunc(){
//        let colorViewOne = UIColor(hexString: "#FC4A1A").cgColor
//        let colorViewTwo = UIColor(hexString: "#F7B733").cgColor
//        
//        let ViewGradient = CAGradientLayer()
//        ViewGradient.frame = self.view.bounds
//        ViewGradient.colors = [colorViewOne, colorViewTwo]
//        ViewGradient.startPoint = CGPoint(x: 0, y: 0.5)
//        ViewGradient.endPoint = CGPoint(x: 1, y: 0.5)
//        ViewGradient.cornerRadius = 16
//        self.view.layer.insertSublayer(ViewGradient, at: 0)
        
        let colorApplyOne = UIColor(hexString: "#FC4A1A").cgColor
        let colorApplyTwo = UIColor(hexString: "#F7B733").cgColor
        
        let ApplyGradient = CAGradientLayer()
        ApplyGradient.frame = ButtonApply.bounds
        ApplyGradient.colors = [colorApplyOne, colorApplyTwo]
        ApplyGradient.startPoint = CGPoint(x: 0, y: 0.5)
        ApplyGradient.endPoint = CGPoint(x: 1, y: 0.5)
        ApplyGradient.cornerRadius = 7
        ButtonApply.layer.insertSublayer(ApplyGradient, at: 0)
        
        let colorCancelOne = UIColor(hexString: "#FC4A1A").cgColor
        let colorCancelTwo = UIColor(hexString: "#F7B733").cgColor
        
        let CancelGradient = CAGradientLayer()
        CancelGradient.frame = ButtonCancel.bounds
        CancelGradient.colors = [colorCancelOne, colorCancelTwo]
        CancelGradient.startPoint = CGPoint(x: 0, y: 0.5)
        CancelGradient.endPoint = CGPoint(x: 1, y: 0.5)
        CancelGradient.cornerRadius = 7
        ButtonCancel.layer.insertSublayer(CancelGradient, at: 0)
        
    }
    
    func changeLanguage(str: String){
        Division.placeholder = "Division".localized1(lang: str)
        District.placeholder = "District".localized1(lang: str)
        DivisionLabel.text = "Division".localized1(lang: str)
        DistrictLabel.text = "District".localized1(lang: str)

        ButtonApply.setTitle("Apply".localized(lang: str), for: .normal)
        ButtonCancel.setTitle("Cancel".localized(lang: str), for: .normal)
        
        Tabbar.items?[0].title = "Home".localized(lang: str)
        Tabbar.items?[1].title = "Notification".localized(lang: str)
        Tabbar.items?[2].title = "Me".localized(lang: str)
    }

    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem){
        switch item.tag {
        case 1:
            navigationController?.setNavigationBarHidden(true, animated: false)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            viewController1 = storyboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
            if let navigator = self.navigationController {
                navigator.pushViewController(viewController1!, animated: true)
            }
            break
            
        case 2:
            navigationController?.setNavigationBarHidden(true, animated: false)
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            viewController1 = storyboard.instantiateViewController(withIdentifier: "NotificationViewController") as! NotificationViewController
            if let navigator = self.navigationController {
                navigator.pushViewController(viewController1!, animated: true)
            }
            break
            
        case 3:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            viewController1 = storyboard.instantiateViewController(withIdentifier: "ViewController") as! ViewController
            if let navigator = self.navigationController {
                navigator.pushViewController(viewController1!, animated: true)
            }
            break
            
        default:
            break
        }
    }
    
    func presentMethod(storyBoardName: String, storyBoardID: String) {
        let storyBoard: UIStoryboard = UIStoryboard(name: storyBoardName, bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: storyBoardID)
        self.definesPresentationContext = true
        self.present(newViewController, animated: true, completion: nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == DivisionPicker{
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
        if pickerView == DivisionPicker{
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
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == DivisionPicker{
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
    
    @IBAction func Apply(_ sender: Any) {
        let filter = self.storyboard!.instantiateViewController(withIdentifier: "CategoryViewController") as! CategoryViewController
        filter.UserID = UserID
        filter.DivisionFilter = Division.text!
        filter.DistricFilter = District.text!
        
        filter.URL_READ = URL_READ
        filter.URL_SEARCH = URL_SEARCH
        filter.URL_FILTER_DISTRICT = URL_FILTER_DISTRICT
        filter.URL_FILTER_DIVISION = URL_FILTER_DIVISION
        filter.URL_FILTER_SEARCH_DIVISION = URL_FILTER_SEARCH_DIVISION
        if let navigator = self.navigationController {
            navigator.pushViewController(filter, animated: true)
        }
    }
    
    @IBAction func Cancel(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
}

extension String {
func localized1(lang:String) ->String {

    let path = Bundle.main.path(forResource: lang, ofType: "lproj")
    let bundle = Bundle(path: path!)

    return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
}}
