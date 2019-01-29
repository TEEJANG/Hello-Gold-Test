//
//  ViewController.swift
//  HelloGoldRegister
//
//  Created by Teerawat on 26/1/2562 BE.
//  Copyright © 2562 Teerawat. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class ViewController: UIViewController {
    
    var allInfoValid: Bool = false
    var newUser: UserInfo = UserInfo()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    @IBAction func EmailField(_ sender: UITextField) {
        let valid : UIColor = UIColor( red: 0.0, green: 1.0, blue:0, alpha: 1.0 )
        let invalid : UIColor = UIColor( red: 1.0, green: 0.0, blue:0, alpha: 1.0 )
        if isValidEmail(testStr: sender.text!) {
            sender.layer.borderColor = valid.cgColor // valid
            allInfoValid = true
        } else {
            sender.layer.borderColor = invalid.cgColor // invalid
        }
        newUser.email = sender.text!
        sender.layer.borderWidth = 2.0
        sender.layer.cornerRadius = 5
    }
    
    @IBAction func CheckBoxBut(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        } else {
            sender.isSelected = true
        }
        newUser.tnc = sender.isSelected
    }
    
    @IBAction func AnyInfoField(_ sender: UITextField) {
        let valid : UIColor = UIColor( red: 0.0, green: 1.0, blue:0, alpha: 1.0 )
        sender.layer.borderWidth = 2.0
        sender.layer.borderColor = valid.cgColor
        newUser.data = sender.text!
    }
    
    @IBAction func RegisterBut(_ sender: UIButton) {//send request
        if allInfoValid {
            let user: Parameters = [
                "email": newUser.email,
                "uuid": newUser.uuid,
                "data": newUser.data,
                "tnc": newUser.tnc
            ]
            Alamofire.request("https://staging.hellogold.com/api/v3/users/register.json", method: .post, parameters: user, encoding: JSONEncoding.default).responseJSON { response in
                switch response.result {
                case .success:
                    print("Validation Successful")
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is DashboardViewController
        {
            let vc = segue.destination as? DashboardViewController
            vc?.userInfo = newUser
        }
    }
    
    func isValidEmail(testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    
}

