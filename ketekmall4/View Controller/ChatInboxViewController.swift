

import UIKit
import Alamofire


class ChatInboxViewController: UIViewController, UITabBarDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var ChatView: UICollectionView!
    @IBOutlet weak var Tabbar: UITabBar!
    var viewController1: UIViewController?
    
    let sharedPref = UserDefaults.standard
    var UserID: String = ""
    var name: String = ""
    var email: String = ""
    
    
    
    let URL_USER = "https://click-1595830894120.firebaseio.com/users.json"
    let URL_MESSAGE = "https://click-1595830894120.firebaseio.com/messages.json"
    let URL_READ_USER_DETAIL = "https://ketekmall.com/ketekmall/getNotificationDetail.php"
    
    let URL_GETCHAT = "https://ketekmall.com/ketekmall/getChat.php"
    let URL_GETCHATISREAD = "https://ketekmall.com/ketekmall/getChatIsRead.php"
    let URL_READUSER = "https://ketekmall.com/ketekmall/read_detail.php"
    
    var UserPhoto: [String] = []
    var ChatWith: [String] = []
    var ChatWithID: [String] = []
    var ChatWithPhoto: [String] = []
    var ChatCount: [String] = []
    var ChatMember: [String] = []
    
    var USERNAME: [String] = []
    var USERIMAGE: [String] = []
    var USERTOKEN: [String] = []
    var ChatID: [String] = []
    var ChatName: [String] = []
    
    var user_messages: [String] = []
    var strings: [String] = []
    
    var NAME: String = ""
    var EMAILUSER: String = ""
    var CHATWITH: [String] = []
    
    var BarHidden: Bool = false
    @IBOutlet weak var BarHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Tabbar.delegate = self
        ChatView.delegate = self
        ChatView.dataSource = self
        
        if(BarHidden == true){
            Tabbar.isHidden = true
            BarHeight.constant = 0
        }else{
            Tabbar.isHidden = false
        }
        
        UserID = sharedPref.string(forKey: "USERID") ?? "0"
        name = sharedPref.string(forKey: "NAME") ?? "0"
        email = sharedPref.string(forKey: "EMAIL") ?? "0"
                
        NAME = name
        
        getChat()
        getUserDetails()
    }
    // Start Here
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
    
    func getChat(){
        let parameters: Parameters=[
            "UserID": UserID
        ]
        
        //Sending http post request
        Alamofire.request(URL_GETCHAT, method: .post, parameters: parameters).responseJSON
            {
                response in

                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        let user = jsonData.value(forKey: "read") as! NSArray
//                        let Name = user.value(forKey: "Name") as! [String]
//                        let UserPhoto = user.value(forKey: "UserPhoto") as! [String]
                        let ChatWith = user.value(forKey: "ChatWith") as! [String]
                        let ChatWithID = user.value(forKey: "ChatWithID") as! [String]
                        let ChatWithPhoto = user.value(forKey: "ChatWithPhoto") as! [String]
                        
                        self.ChatWith = ChatWith
                        self.ChatWithID = ChatWithID
                        self.ChatWithPhoto = ChatWithPhoto
                        
                        for i in 0..<self.ChatWithID.count{
                            let parametersInner: Parameters=[
                                "UserID": self.UserID,
                                "ChatWithID": ChatWithID[i]
                            ]
                            
                            Alamofire.request(self.URL_GETCHATISREAD, method: .post, parameters: parametersInner).responseJSON
                            {
                                responseInner in
                                
                                if let resultInner = responseInner.result.value{
                                    let jsonDataInner = resultInner as! NSDictionary
                                    let Success = jsonDataInner.value(forKey: "success") as! NSString
                                    
                                    if(Success.boolValue){
                                        let DataInner = jsonDataInner.value(forKey: "read") as! NSArray
                                        let ChatCount = DataInner.count
                                        let ChatCountString = String(ChatCount)
                                        
                                        self.ChatCount.append(ChatCountString)
                                        
//                                        print("CharCount: \(self.ChatWithID[i])")
//                                        print("ChatCount: \(self.ChatCount)")
                                        self.ChatView.reloadData()
                                    }else{
                                        print("Failed to retrieve!")
                                    }
                                }
                            }
                            
                        }
                        
                    }
                }
        }
    }
    
    func getUserDetails(){
        let parameters: Parameters=[
            "id": UserID
        ]
        
        //Sending http post request
        Alamofire.request(URL_READUSER, method: .post, parameters: parameters).responseJSON
            {
                response in

                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        let user = jsonData.value(forKey: "read") as! NSArray
//                        let Name = user.value(forKey: "Name") as! [String]
//                        let UserPhoto = user.value(forKey: "UserPhoto") as! [String]
                        let UserPhoto = user.value(forKey: "photo") as! [String]
                        
                        self.UserPhoto = UserPhoto
                    }
                }
        }
    }
    
    // Stop Here
    func ChatList3(){
        Alamofire.request(URL_MESSAGE, method: .get).responseJSON
            {
                response in
                if let result = response.result.value{
                    let json = result as! [String: Any]
                    let Message = json.keys
                    for i in Message{
                        if(i.contains(self.EMAILUSER + "_")){
                            self.user_messages.append(i)
                        }
                    }
                    
                }
        }
    }
    
    func UserList(){
        Alamofire.request(URL_USER, method: .get).responseJSON{
            response in
            if let result = response.result.value{
                let json = result as! [String: Any]
                let Users = json.keys
                for i in Users{
                    let user1 = json[i] as! [String: String]
                    
                    if(!i.elementsEqual(self.NAME)){
                        for j in user1{
                            if(j.key == "email"){
                                let valueEmail = j.value
                                
                                let index2 = valueEmail.firstIndex(of: "@") ?? valueEmail.endIndex
                                let newEmail2 = valueEmail[..<index2]
                                
                                for k in self.user_messages{
                                    if(k.contains(String(newEmail2))){
                                        print("\(String(newEmail2))")
                                        self.USERNAME.append(i)
                                        self.USERNAME.removeDuplicates()
                                        self.CHATWITH.append(String(newEmail2))
                                        self.CHATWITH.removeDuplicates()
                                    }
                                }
                            }
                            
                            
                        }
                    }
                }
                
            }
        }
    }
    
    func getChatData(NameFirebase: String){
        let parameters: Parameters=[
            "name": NameFirebase
        ]
        
        Alamofire.request(URL_READ_USER_DETAIL, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        let user = jsonData.value(forKey: "read") as! NSArray
                        
                        let id = user.value(forKey: "id") as! [String]
                        let name = user.value(forKey: "name") as! [String]
                    }
                }else{
                    print("FAILED")
                }
                
        }
    }
    
    func TokenList(){
        Alamofire.request(URL_USER, method: .get).responseJSON{
            response in
            if let result = response.result.value{
                let json = result as! [String: Any]
                let Users = json.keys
                for i in Users{
                    let user1 = json[i] as! [String: String]
                    
                    if(!i.elementsEqual(self.NAME)){
                        for k in self.USERNAME{
                            if(i.elementsEqual(k)){
                                for j in user1{
                                    if(j.key == "token"){
                                        let valueToken = j.value
                                        print("\(valueToken)")
                                        
                                        self.USERTOKEN.append(valueToken)
                                    }
                                }
                            }
                        }
                    }
                }
                
            }
        }
    }
    
    func ImageList(){
           Alamofire.request(URL_USER, method: .get).responseJSON{
               response in
               if let result = response.result.value{
                   let json = result as! [String: Any]
                   let Users = json.keys
                   for i in Users{
                       let user1 = json[i] as! [String: String]
                       
                       if(!i.elementsEqual(self.NAME)){
                           for k in self.USERNAME{
                               if(i.elementsEqual(k)){
                                   for j in user1{
                                       if(j.key == "photo"){
                                           let valueToken = j.value
                                           print("\(valueToken)")
                                           
                                            self.USERIMAGE.append(valueToken)
                                        
                                            self.ChatView.reloadData()
                                       }
                                   }
                               }
                               
                           }
                       }
                   }
                   
               }
           }
       }
    
    // Start Here
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.ChatCount.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ChatCollectionViewCell", for: indexPath) as! ChatCollectionViewCell
        let NEWIm = self.ChatWithPhoto[indexPath.row].addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        cell.UserImage.setImageWith(URL(string: NEWIm!)!)
        cell.UserName.text = self.ChatWith[indexPath.row]
        cell.ChatCount.text = self.ChatCount[indexPath.row]
        
//        print("ChatCount: \(self.ChatCount[indexPath.row])")
        
        cell.ChatCount.layer.cornerRadius = 7
        
        if(cell.ChatCount.text == "0"){
            cell.ChatCount.isHidden = true
        }else{
            cell.ChatCount.isHidden = false
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let screenSize = collectionView.bounds
        let screenWidth = screenSize.width
        let cellSquareSize: CGFloat = screenWidth
        return CGSize(width: cellSquareSize, height: 60);
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5.0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let vc = ChatViewController()
        vc.title = self.ChatWith[indexPath.row]
        vc.navigationItem.largeTitleDisplayMode = .never
//        vc.chatWith = self.ChatWith[indexPath.row]
//        vc.chatName = self.USERNAME[indexPath.row]
//        vc.chatToken = self.USERTOKEN[indexPath.row]
//        vc.emailUser = self.EMAILUSER
        
        vc.UserPhoto = self.UserPhoto[0]
        vc.chatWithV  = self.ChatWith[indexPath.row]
        vc.chatWithID = self.ChatWithID[indexPath.row]
        vc.chatWithPhoto = self.ChatWithPhoto[indexPath.row]
        
        let parameters: Parameters=[
            "Name": self.ChatWith[indexPath.row]
        ]
        
        Alamofire.request(URL_READ_USER_DETAIL, method: .post, parameters: parameters).responseJSON
            {
                response in
                if let result = response.result.value{
                    let jsonData = result as! NSDictionary
                    
                    if((jsonData.value(forKey: "success") as! NSString).boolValue){
                        let user = jsonData.value(forKey: "read") as! NSArray
                        
                        let PlayerID = user.value(forKey: "PlayerID") as! [String]
                        let Name = user.value(forKey: "Name") as! [String]
                        
                        vc.ChatID = PlayerID[0]
                        vc.ChatUserName = Name[0]
                    }
                    print("CHAT SUCCESS")
                }else{
                    print("FAILED")
                }
        }
        navigationController?.pushViewController(vc, animated: true)
        
    }
}

