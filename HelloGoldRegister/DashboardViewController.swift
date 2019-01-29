//
//  DashboardViewController.swift
//  HelloGoldRegister
//
//  Created by Teerawat on 26/1/2562 BE.
//  Copyright © 2562 Teerawat. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class DashboardViewController : UIViewController {
    @IBOutlet weak var userEmail: UILabel!
    
    var helloGoldRecord: [UserInfo.helloGoldToday] = []
    var userInfo: UserInfo = UserInfo()
    override func viewDidLoad() {
        super.viewDidLoad()
        userEmail.text = userInfo.email
        Alamofire.request("https://staging.hellogold.com/api/v2/spot_price.json", method: .get, encoding: JSONEncoding.default).responseJSON { response in
            switch response.result {
            case .success:
                guard let jsonArray = response.result.value as? [[String: Any]] else {
                    return
                }
//                do {
//                    //here dataResponse received from a network request
//                    let decoder = JSONDecoder()
//                    let helloGoldRecord = try decoder.decode([User].self, from:
//                        response.result.value) //Decode JSON Response Data
//                    print(model)
//                } catch let parsingError {
//                    print("Error", parsingError)
//                }
                if let getVal = response.result.value as? [String:Any] {
                    var conVertgetVal = getVal["data"] as? [String:Any]
                    print(conVertgetVal?["buy"] ?? 0)

                }
                print("Validation Successful")
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Do any additional setup after loading the view, typically from a nib.
    }
}
