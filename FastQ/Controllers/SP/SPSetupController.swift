//
//  SPSetupController.swift
//  FastQ
//
//  Created by Mobark on 07/12/2019.
//  Copyright © 2019 emobark. All rights reserved.
//

import UIKit

class SPSetupController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITableViewDelegate,UITableViewDataSource {
    var admin:AdminModel = AdminModel()
    @IBOutlet weak var imagepreview: UIImageView!
    @IBOutlet weak var phonenumber: UITextField!
    @IBOutlet weak var about: UITextField!
    @IBOutlet weak var website:UITextField!
    @IBOutlet weak var table : UITableView!
    @IBOutlet weak var SPname: UITextField!
    @IBOutlet weak var lat: UITextField!
    @IBOutlet weak var long: UITextField!
    @IBOutlet weak var woktime: UITextField!
    @IBOutlet weak var theScrollView: UIScrollView!
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
        let alert = UIAlertController(title: "Pick Image", message: "Pick a method", preferredStyle: .actionSheet)
       
        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "Local", style: .default, handler: {
            handler in
            
            let imagePicker =  UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .photoLibrary
            //imagePicker.sourceType = .PhotoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "By URL", style: .default, handler: {
            handler in
            let URLalert = UIAlertController(title: "Picker", message: "Image By URL", preferredStyle: .alert)
            //2. Add the text field. You can configure it however you need.
            URLalert.addTextField { (textField) in
                textField.placeholder = "Image URL"
            }
            
            // 3. Grab the value from the text field, and print it when the user clicks OK.
            URLalert.addAction(UIAlertAction(title: "Done", style: .default, handler: { [weak URLalert] (_) in
                let textField = URLalert?.textFields![0] // Force unwrapping because we know it exists.
                self.imagepreview.downloaded(from: (textField?.text!)!)
            }))
            
            // 4. Present the alert.
            self.present(URLalert, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {
            handler in
            alert.dismiss(animated: true, completion: nil)
        }))
         self.present(alert, animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        closeKeyboardOnOutsideTap()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        // Do any additional setup after loading the view.
    }
    @IBAction func done(_ sender: UIButton) {
        let getLastSPId = Database().genID(.sps)
      
        let sp = SPModel(name: SPname.text!, logo: imagepreview.image!, about: about.text!, workTime: woktime.text!, phone: phonenumber.text!, website: website.text!, lat: Double(lat.text!)!, lng: Double(long.text!)!, id: getLastSPId,admin:admin.admin)
        if Database().saveSP(sp: sp){
            for sm in services{
                var service = sm
                service.to = "\(admin.admin)"
                service.isopen = false
                print("FAQ Service \(service.to) - \(service.name)")
                if Database().saveService(service: service){
                    Util.Alert(contex: self, title: "Done", body: "added")
                    navigationController?.popToRootViewController(animated: true)
                    self.dismiss(animated: true, completion: nil)
                    
                    
                }
            }
        }
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
   

}
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIViewContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIViewContentMode = .scaleAspectFit) {  // for swift 4.2 syntax just use ===> mode: UIView.ContentMode
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
