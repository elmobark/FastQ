//
//  SPRegistryController.swift
//  FastQ
//
//  Created by Mobark on 19/11/2019.
//  Copyright © 2019 emobark. All rights reserved.
//

import UIKit
class SPRegistryController: UIViewController {
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var cardtype: UITextField!
    @IBOutlet weak var cardnumber: UITextField!
    @IBOutlet weak var cardname: UITextField!
    @IBOutlet weak var cvv: UITextField!
    @IBOutlet weak var expirydate: UITextField!
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var theScrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
        closeKeyboardOnOutsideTap()
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        // Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func keyboardWillShow(notification:NSNotification){
        //give room at the bottom of the scroll view, so it doesn't cover up anything the user needs to tap
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        
        var contentInset:UIEdgeInsets = self.theScrollView.contentInset
        contentInset.bottom = keyboardFrame.size.height
        theScrollView.contentInset = contentInset
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        let contentInset:UIEdgeInsets = UIEdgeInsets.zero
        theScrollView.contentInset = contentInset
    }
    /// add user to database function
    ///
    /// - Parameter sender: sender data type by defualt is UIButton
    @IBAction func sumbit(_ sender: UIButton) {
        let admin  = AdminModel(cardname: cardname.text!, cardnumber: cardnumber.text!, cardtype: cardtype.text!, cvv: cvv.text!, expirydate: expirydate.text!, password: password.text!, email: email.text!, type: "Admin",name:name.text!,admin:Database().genID(.admins))
        
        if Database().saveAdmin(admin: admin) {
            let setup = getController(id: "SPSetup") as! SPSetupController
            setup.admin = Database().getAdmin(adminmodel: UserModel(id: 0,email: admin.email, password: admin.password, name: admin.name))
            goTo(controller: setup)
        }else{
            Util.Alert(contex: self, title: "Sorry", body: "admin is already having account")
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
extension UIViewController{
    func getController(id:String) -> UIViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: id)
    }
    func goTo(controller:UIViewController) {
        self.navigationController?.pushViewController(controller, animated: true)
    }
  
    func closeKeyboardOnOutsideTap() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }

}
