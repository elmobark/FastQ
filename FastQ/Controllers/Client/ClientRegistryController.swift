//
//  ClientRegistryController.swift
//  FastQ
//
//  Created by Mobark on 13/11/2019.
//  Copyright © 2019 emobark. All rights reserved.
//

import UIKit

class ClientRegistryController: UIViewController {

    @IBOutlet weak var checkpassword: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var name : UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func Registry(_ sender: Any) {
        print("create user button clicked")
        if password.text == checkpassword.text{
        
            let user:UserModel = UserModel(email: email.text!, password: password.text!,name:name.text!)
            if  Database().saveUser(user: user){
                let dash = getController(id: "SVC") as! ServiceController
                goTo(controller: dash)
                Util.Alert(contex: self, title: "Done", body: "User Regisrted")
            }else{
                Util.Alert(contex: self, title: "Sorry", body: "User Already Exist!")
            }
            
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
