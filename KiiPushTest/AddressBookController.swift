//
//  AddressBookController.swift
//  KiiPushTest
//
//  Created by 木村大輝 on 2017/02/22.
//
//

import Foundation
import AddressBook

class AddressBookController{
    
    func addToAddressBook() {
        let stat = ABAddressBookGetAuthorizationStatus()
        switch stat {
        case .denied, .restricted:
            print("no access")
        case .authorized, .notDetermined:
            var err : Unmanaged<CFError>? = nil
            //Address Bookを取得
            var adbk : ABAddressBook? = ABAddressBookCreateWithOptions(nil, &err).takeRetainedValue()
            if adbk == nil {
                print(err)
                return
            }
            //ユーザーに連絡先の使用許可を求める
            ABAddressBookRequestAccessWithCompletion(adbk) {
                (granted:Bool, err:CFError?) in
                if granted {
                    
                    var newContact:ABRecord! = ABPersonCreate().takeRetainedValue() //新しく登録するデータを作成
                    var success:Bool = false //成否判定用変数
                    var error: Unmanaged<CFError>? = nil
                    
                    /* 名前の設定 */
                    success = ABRecordSetValue(newContact, kABPersonLastNameProperty, "Kimura" as CFTypeRef!, &error)
                    print("Setting last name was successful? \(success)")
                    success = ABRecordSetValue(newContact, kABPersonFirstNameProperty, "Daiki" as CFTypeRef!, &error)
                    print("Setting first name was successful? \(success)")
                    success = ABRecordSetValue(newContact, kABPersonLastNamePhoneticProperty, "キムラ" as CFTypeRef!, &error)
                    print("Setting last furigana was successful? \(success)")
                    success = ABRecordSetValue(newContact, kABPersonFirstNamePhoneticProperty, "名（フリガナ）" as CFTypeRef!, &error)
                    print("Setting first furigana was successful? \(success)")
                    
                    
                    /* 電話番号の設定 */
                    var multi:ABMutableMultiValue = ABMultiValueCreateMutable(ABPropertyType(kABStringPropertyType)).takeRetainedValue();
                    ABMultiValueAddValueAndLabel(multi, "080-6733-8138" as CFTypeRef!, kABPersonPhoneMobileLabel, nil) //任意の数登録
                    success = ABRecordSetValue(newContact, kABPersonPhoneProperty, multi, &error)
                    print("setting phone number was successful? \(success)")
                    
                    /* メールアドレスの設定 */
                    multi = ABMultiValueCreateMutable(ABPropertyType(kABStringPropertyType)).takeRetainedValue();
                    ABMultiValueAddValueAndLabel(multi, "test@test.com" as CFTypeRef!, kABPersonPhoneMobileLabel, nil) //任意の数登録
                    success = ABRecordSetValue(newContact, kABPersonEmailProperty, multi, &error)
                    print("setting email was successful? \(success)")
                    
                    
                    //Address Bookに登録
                    success = ABAddressBookAddRecord(adbk, newContact, &error)
                    print("Adbk addRecord successful? \(success)")
                    //Address Bookを保存
                    success = ABAddressBookSave(adbk, &error)
                    print("Adbk Save successful? \(success)")
                    
                } else {
                    print(err)
                }//if
            }//ABAddressBookReqeustAccessWithCompletion
        }//case
    }
    
}
