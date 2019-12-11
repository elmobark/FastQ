//
//  TimeController.swift
//  FastQ
//
//  Created by Mobark on 13/11/2019.
//  Copyright © 2019 emobark. All rights reserved.
//

import UIKit

class TimeController: UIViewController {
var SP:SPModel = SPModel()
    var Service:ServiceModel = ServiceModel()
    var sec = 60
    @IBOutlet weak var time: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let fulltime = Database().getTotaleTime(sp: Service)
        timer(timeinmil: fulltime)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func timer(timeinmil:Int)  {
        sec = timeinmil
        Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(updateTimer)), userInfo: nil, repeats: true)
    }
    @objc func updateTimer() {
        if sec <= 0 {
            time.text = "Waiting time : -"
            time.sizeToFit()
        }else{
            sec -= 1
            time.text = "Waiting time : \(sec)"
            time.sizeToFit()
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
