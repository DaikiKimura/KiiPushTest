//
//  ViewController.swift
//  KiiPushTest
//
//  Created by 木村大輝 on 2017/02/21.
//  Copyright © 2017年 木村大輝. All rights reserved.
//

import UIKit
import Contacts
import ContactsUI
import CoreLocation

class ViewController: UIViewController, CNContactPickerDelegate, CLLocationManagerDelegate{
    
    // 現在地の位置情報の取得にはCLLocationManagerを使用
    var lm: CLLocationManager!
    // 取得した緯度を保持するインスタンス
    var latitude: CLLocationDegrees!
    // 取得した経度を保持するインスタンス
    var longitude: CLLocationDegrees!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // フィールドの初期化
        lm = CLLocationManager()
        longitude = CLLocationDegrees()
        latitude = CLLocationDegrees()
        
        // CLLocationManagerをDelegateに指定
        lm.delegate = self
        
        // 位置情報取得の許可を求めるメッセージの表示．必須．
        lm.requestAlwaysAuthorization()
        
        // GPSの使用を開始する
        lm.startUpdatingLocation()
        
        lm.allowsBackgroundLocationUpdates = true
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* 位置情報取得成功時に実行される関数 */
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let appDelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        print("appdelegate.test:  \(appDelegate.test)")
        
        if(appDelegate.test! == "kakikukeko"){
            let addressBookController = AddressBookController()
            addressBookController.addToAddressBook()
            
            appDelegate.test = "aiueo"
        }
        

    }
//    func locationManager(manager: CLLocationManager, didUpdateToLocation newLocation: CLLocation, fromLocation oldLocation: CLLocation){
//        // 取得した緯度がnewLocation.coordinate.longitudeに格納されている
//        latitude = newLocation.coordinate.latitude
//        // 取得した経度がnewLocation.coordinate.longitudeに格納されている
//        longitude = newLocation.coordinate.longitude
//        // 取得した緯度・経度をLogに表示
//        NSLog("latiitude: \(latitude) , longitude: \(longitude)")
//    }
    
    /* 位置情報取得失敗時に実行される関数 */
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        // この例ではLogにErrorと表示するだけ．
        NSLog("Error")
    }
    
    
    
//    @IBAction func showContactPickerController() {
//        print("連絡先許可呼ばれてますか〜？")
//        let pickerViewController = CNContactPickerViewController()
//        pickerViewController.delegate = self
//        
//        // Display only a person's phone, email, and postal address
//        let displayedItems = [CNContactPhoneNumbersKey, CNContactEmailAddressesKey, CNContactPostalAddressesKey]
//        pickerViewController.displayedPropertyKeys = displayedItems
//        
//        // Show the picker
//        self.present(pickerViewController, animated: true, completion: nil)
//    }
    
    // Called when a property of the contact has been selected by the user.
//    func contactPicker(picker: CNContactPickerViewController, didSelectContactProperty contactProperty: CNContactProperty) {
//        let contact = contactProperty.contact
//        let contactName = CNContactFormatter.string(from: contact, style: .fullName) ?? ""
//        let propertyName = CNContact.localizedString(forKey: contactProperty.key)
//        let title = "\(contactName)'s \(propertyName)"
//        
//        DispatchQueue.main.async{
//            let alert = UIAlertController(title: title,
//                                          message: (contactProperty.value as AnyObject).description,
//                                          preferredStyle: .alert)
//            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//            self.present(alert, animated: true, completion: nil)
//        }
//    }
    
    // Called when the user taps Cancel.
//    func contactPickerDidCancel(picker: CNContactPickerViewController) {
//    }
//    
//    func debugTest(){
//        print("テストメソッド呼び出し")
//    }


}

