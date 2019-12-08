//
//  SPSetupController.swift
//  FastQ
//
//  Created by Mobark on 07/12/2019.
//  Copyright © 2019 emobark. All rights reserved.
//

import UIKit

class SPSetupController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var imagepreview: UIImageView!
    @IBOutlet weak var phonenumber: UITextField!
    @IBOutlet weak var about: UITextField!
    @IBOutlet weak var website:UITextField!
    @IBOutlet weak var table : UITableView!
    @IBOutlet weak var SPname: UITextField!
    @IBOutlet weak var lat: UITextField!
    @IBOutlet weak var long: UITextField!
    @IBOutlet weak var woktime: UITextField!
    @IBOutlet weak var addService: UIButton!
    var services:[ServiceModel] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return services.count
    }
    func imagePickerController(_ picker: UIImagePickerController,
                                       didFinishPickingMediaWithInfo info: [String : Any]) {
        picker.dismiss(animated: true, completion: nil)
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagepreview.image = pickedImage
        }else{
            print("Something went wrong!!")
        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = services[indexPath.row].name
        return cell
    }
   
    @IBAction func addService(_ sender: UIButton) {
        let alert = UIAlertController(title: "Service", message: "Enter a name", preferredStyle: .alert)
        //2. Add the text field. You can configure it however you need.
        alert.addTextField { (textField) in
            textField.placeholder = "Service name"
        }
        
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "add", style: .default, handler: { [weak alert] (_) in
            let textField = alert?.textFields![0] // Force unwrapping because we know it exists.
            self.services.append(ServiceModel(id: Database().genID(.services)+self.services.count, name: (textField?.text)!, to: "\(Database().genID(.sps))", isopen: false))
            self.table.reloadData()
        }))
        
        // 4. Present the alert.
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func selectImg(_ sender: UIButton) {
        let imagePicker =  UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        //imagePicker.sourceType = .PhotoLibrary
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func done(_ sender: UIButton) {
        let getLastSPId = Database().genID(.sps)
      
        let sp = SPModel(name: SPname.text!, logo: imagepreview.image!, about: about.text!, workTime: woktime.text!, phone: phonenumber.text!, website: website.text!, lat: Double(lat.text!)!, lng: Double(long.text!)!, id: getLastSPId,admin:0)
        if Database().saveSP(sp: sp){
            for sm in services{
                print(sm.to)
                var service = sm
                service.to = "\(sp.id)"
                service.isopen = false
                if Database().saveService(service: service){
                    Util.Alert(contex: self, title: "Done", body: "added")
                }
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
