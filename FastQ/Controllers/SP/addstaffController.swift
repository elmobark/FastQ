//
//  addstaffController.swift
//  FastQ
//
//  Created by Mobark on 07/12/2019.
//  Copyright © 2019 emobark. All rights reserved.
//

import UIKit

class addstaffController: UIViewController {
var admin:AdminModel = AdminModel()
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func add(_ sender: Any) {
        if Database().saveAdmin(admin: AdminModel(cardname: "null", cardnumber: "null", cardtype: "null", cvv: "null", expirydate: "null", password: password.text!, email: email.text!, type: "staff", name: name.text!)) {
            self.dismiss(animated: true, completion: nil)
            Util.Alert(contex: self, title: "Staff added", body: "\(name.text!) was added")
        }else{
             Util.Alert(contex: self, title: "Error", body: "\(name.text!) was not added we think this account is already exist")
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
