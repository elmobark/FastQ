//
//  SPInfoController.swift
//  FastQ
//
//  Created by Mobark on 12/11/2019.
//  Copyright © 2019 emobark. All rights reserved.
//

import UIKit

class SPInfoController: UIViewController {
    var SP:SPModel = SPModel()
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var about: UILabel!
    @IBOutlet weak var workHours: UILabel!
    @IBOutlet weak var phoneNumber: UILabel!
    @IBOutlet weak var website: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        logo.image = SP.logo
        about.text = SP.about
        
        workHours.text = SP.workTime
        phoneNumber.text = SP.phone
        website.text = SP.website
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
