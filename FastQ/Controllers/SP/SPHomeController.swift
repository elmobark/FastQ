//
//  SPHomeController.swift
//  FastQ
//
//  Created by Mobark on 07/12/2019.
//  Copyright © 2019 emobark. All rights reserved.
//

import UIKit

class SPHomeController: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource{
    
    var admin:AdminModel = AdminModel()
    @IBOutlet weak var openqueueBT: UIButton!
    
    @IBOutlet weak var addstaffBT: UIButton!
    @IBOutlet weak var showreportBT: UIButton!
    @IBOutlet weak var closequeueBT: UIButton!
    
    @IBOutlet weak var currentQueue: UILabel!
    @IBAction func addstaff(_ sender: Any) {
        let staffController = getController(id: "SPAddStaff") as! addstaffController
        staffController.admin = admin
        goTo(controller: staffController)
    }
    @IBAction func openQueue(_ sender: Any) {
    }
    @IBAction func showreports(_ sender: Any) {
    }
    @IBAction func closequeue(_ sender: Any) {
    }
    @IBAction func showclients(_ sender: Any) {
    }
    @IBAction func next(_ sender:Any){
        
    }
    @IBOutlet weak var table: UIPickerView!
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if admin.type != "Admin"{
            addstaffBT.isHidden = true
            openqueueBT.isHidden = true
            showreportBT.isHidden = true
            closequeueBT.isHidden = true
        }
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
