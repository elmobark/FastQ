//
//  ViewController.swift
//  FastQ
//
//  Created by Mobark on 23/10/2019.
//  Copyright © 2019 emobark. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UIPickerViewDelegate , UIPickerViewDataSource{
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var lab: UILabel!
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 43
    }
    @IBAction func stepper(_ sender: Any) {
       
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row)hello"
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        lab.text = "\(row)"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

