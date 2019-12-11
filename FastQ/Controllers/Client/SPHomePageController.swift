//
//  SPHomePageController.swift
//  FastQ
//
//  Created by Mobark on 12/11/2019.
//  Copyright © 2019 emobark. All rights reserved.
//

import UIKit

class SPHomePageController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    var services:[ServiceModel] = []
    var SP:SPModel = SPModel()
    var user:UserModel = UserModel()
    var service:ServiceModel = ServiceModel()
    @IBOutlet weak var picker:UIPickerView!
    @IBOutlet weak var ServNumber: UILabel!
    
    @IBOutlet weak var SPimgView: UIImageView!
     var story: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
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
        service = services[row]
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let q = Database().getQueues().filter({return Int($0.sp) == SP.id})
        if q.count == 0{
            print("free")
        }else{
            ServNumber.text = "\(q[q.count-1].id)"
        }
        
        SPimgView.image = SP.logo
        services = Database().getService(id: SP.id).filter({return $0.isopen})
        picker.reloadAllComponents()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
    
    @IBAction func SPinfo(_ sender: Any) {
        
        let viewController = story.instantiateViewController(withIdentifier: "SPInfo") as! SPInfoController
        viewController.SP = SP
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @IBAction func Booking(_ sender: Any) {
    print("User From home \(user.name)")
        let viewController = story.instantiateViewController(withIdentifier: "SPBooking") as! SPBookingController
        viewController.SP = SP
        viewController.User = user
    self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    @IBAction func AdvanceBooking(_ sender: Any) {
        let viewController = story.instantiateViewController(withIdentifier: "SPBookingAD") as! SPBookingADController
        viewController.SP = SP
        viewController.User = user
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @IBAction func WaithingTime(_ sender: Any) {
        let viewController = story.instantiateViewController(withIdentifier: "SPTime") as! TimeController
        viewController.SP = SP
        viewController.Service = service
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @IBAction func SPLocation(_ sender: Any) {
        let viewController = story.instantiateViewController(withIdentifier: "SPMap") as! MapController
        viewController.SP = SP
        self.navigationController?.pushViewController(viewController, animated: true)
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
