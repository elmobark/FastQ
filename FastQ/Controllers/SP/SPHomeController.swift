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
        let reports = getController(id: "SPShowStaff") as! showstaffController
        reports.admin = admin
        goTo(controller: reports)
        
    }
    @IBAction func closequeue(_ sender: Any) {
        selectedservice.isopen = false
        if Database().updateService(service: selectedservice){
            Util.Alert(contex: self, title: "Service Closed", body: "\(selectedservice.name) is Closed")
        }
        getServices()
    }
    @IBAction func showclients(_ sender: Any) {
        let clientlists = getController(id: "SPCL") as! cleintlistController
       clientlists.service = selectedservice
        goTo(controller: clientlists)
    }
    @IBAction func next(_ sender:Any){
        print("next s1")
        let queues = Database().getQueues().filter({$0.service == selectedservice.id})
        print("next s2 \(queues.count)")
        if !queues.isEmpty{
            print("next s3")
            var lastqueue = queues.first
            lastqueue?.servedBy = admin.id
            print("next s3")
            if Database().updateQueue(queue: lastqueue!){
                Util.Alert(contex: self, title: "Done", body: "Next Queue is Served")
            }
        }else{
            Util.Alert(contex: self, title: "sorry", body: "there is no customer pick a queue yet")
        }
        
        
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
        let q = Database().getQueues().filter({return Int($0.sp) == selectedservice.id})
        if q.count == 0{
            print("free")
        }else{
            currentQueue.text = "\(q[q.count-1].id)"
        }
        getServices()
        if admin.type != "Admin"{
            addstaffBT.isHidden = true
            openqueueBT.isHidden = true
            showreportBT.isHidden = true
        }
        
        
        
        // Do any additional setup after loading the view.
    }
    private func getServices(){
        print("FAQ \(admin.email) - \(admin.admin)")
        services = admin.type == "Admin" ? Database().getService(id: admin.admin) : Database().getService(id: admin.admin).filter({return $0.isopen == true})
      
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
