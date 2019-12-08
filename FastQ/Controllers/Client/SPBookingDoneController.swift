//
//  SPBookingDoneController.swift
//  FastQ
//
//  Created by Mobark on 12/11/2019.
//  Copyright © 2019 emobark. All rights reserved.
//

import UIKit

class SPBookingDoneController: UIViewController {
    var SP:SPModel = SPModel()
    var sec = 60
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var ticket: UILabel!
    @IBOutlet weak var number: UILabel!
    @IBOutlet weak var time: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        let q = Database().getQueue()
        let fulltime = Database().getTotaleTime()
        logo.image = SP.logo
        ticket.text = "Queue is :\(Util().FlipToTicket(id: SP.id.description))\(q.id)"
        ticket.sizeToFit()
        number.text = "number is : \(Int(q.id)!+SP.id)"
        number.sizeToFit()
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
        sec -= 1
        time.text = "Waiting time : \(sec)"
        time.sizeToFit()
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
