//
//  LoginController.swift
//  FastQ
//
//  Created by Mobark on 13/11/2019.
//  Copyright © 2019 emobark. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
var story: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBOutlet weak var email: UITextField!
    
    @IBOutlet weak var password: UITextField!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func checkUser(_ sender: Any) {
        let user = UserModel(email: email.text!, password: password.text!,name: "")
        
        if Database().checkUser(usermodel: user){
            let dash = story.instantiateViewController(withIdentifier: "SVC") as! ServiceController
            self.navigationController?.pushViewController(dash, animated: true)
        } else {
            Util.Alert(contex: self, title: "Sorry", body: "check the email and password and try agine")
        }
       
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
