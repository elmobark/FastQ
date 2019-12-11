//
//  SPBookingController.swift
//  FastQ
//
//  Created by Mobark on 12/11/2019.
//  Copyright © 2019 emobark. All rights reserved.
//

import UIKit

class SPBookingController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var picker: UIPickerView!
    var SP:SPModel = SPModel()
    var User:UserModel = UserModel()
    var services:[ServiceModel] = []
    var story: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    var service:ServiceModel = ServiceModel()
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
        services = Database().getService(id: SP.id).filter({return $0.isopen == true})
        picker.reloadAllComponents()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func Book(_ sender: Any) {
        print("User From Booking \(User.name)")
        let queue = QueueModel(id:0 , sp: SP.id.description, time: "1800", type: Util().FlipToTicket(id: SP.id.description),serveTo:User.id,servedBy:-1,service:service.id)
        if Database().addQueue(queue: queue) {
            let viewController = story.instantiateViewController(withIdentifier: "SPBookingDone") as! SPBookingDoneController
            viewController.SP = SP
            viewController.Service = service
            self.navigationController?.pushViewController(viewController, animated: true)
        }else{
            print("Error")
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
