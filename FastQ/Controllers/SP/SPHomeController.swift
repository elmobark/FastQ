//
//  SPHomeController.swift
//  FastQ
//
//  Created by Mobark on 07/12/2019.
//  Copyright © 2019 emobark. All rights reserved.
//

import UIKit

class SPHomeController: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource {
    var services:[ServiceModel] = []
    var selectedservice:ServiceModel = ServiceModel(id: 0, name: "", to: "", isopen: false)
    var admin:AdminModel = AdminModel()
    @IBOutlet weak var openqueueBT: UIButton!
    
    @IBOutlet weak var picker: UIPickerView!
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
        selectedservice.isopen = true
        if Database().updateService(service: selectedservice){
            Util.Alert(contex: self, title: "Service Open", body: "\(selectedservice.name) is open now")
        }
        getServices()
    }
    @IBAction func showreports(_ sender: Any) {
    }
    @IBAction func closequeue(_ sender: Any) {
        selectedservice.isopen = false
        if Database().updateService(service: selectedservice){
            Util.Alert(contex: self, title: "Service Closed", body: "\(selectedservice.name) is Closed")
        }
        getServices()
    }
    @IBAction func showclients(_ sender: Any) {
    }
    @IBAction func next(_ sender:Any){
        
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return services.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return services[row].name
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedservice = services[row]
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        getServices()
        if admin.type != "Admin"{
            addstaffBT.isHidden = true
            openqueueBT.isHidden = true
            showreportBT.isHidden = true
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    private func getServices(){
        
        
        if admin.type != "Admin" {
            services = Database().getService(id: admin.admin)
            var tempservices:[ServiceModel] = []
            for service in services {
                if service.isopen{
                    tempservices.append(service)
                }
            }
            services = tempservices
            
        }else{
            services = Database().getService(id: admin.admin)
        }
        picker.reloadAllComponents()
        
        
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
