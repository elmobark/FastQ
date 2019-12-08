//
//  SPLoginController.swift
//  FastQ
//
//  Created by Mobark on 06/12/2019.
//  Copyright © 2019 emobark. All rights reserved.
//

import UIKit

class SPLoginController: UIViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBAction func login(_ sender: UIButton) {
        let admin = UserModel(email: email.text!, password: password.text!,name: "")
        if Database().checkAdmin(adminmodel: admin) {
            let sphome = getController(id: "SPDash") as! SPHomeController
            sphome.admin = Database().getAdmin(adminmodel: admin)
            goTo(controller: sphome)
        }else{
            Util.Alert(contex: self, title: "Sorry", body: "Account not found")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
