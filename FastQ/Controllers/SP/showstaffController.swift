//
//  showstaffController.swift
//  FastQ
//
//  Created by Mobark on 09/12/2019.
//  Copyright © 2019 emobark. All rights reserved.
//

import UIKit

class showstaffController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var staff:[AdminModel] = []
    var admin:AdminModel = AdminModel()
    var totleDispose = 0
    @IBOutlet weak var table: UITableView!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return staff.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "staffcell") as! staffCell
        cell.name.text = staff[indexPath.row].name
        let servedQueue = getQueuebyadmin(id: staff[indexPath.row].id)
        cell.slide.maximumValue = Float(totleDispose)
        cell.slide.minimumValue = 0
        cell.slide.value = Float(servedQueue)
        cell.numbers.text = "\(servedQueue) of \(totleDispose)"
        return cell
    }
    func gettotle(){
        let dat  = Database().getQueues()
        for item in staff{
            for que in dat{
                if que.servedBy == item.id{
                    totleDispose+=1
                }
            }
        }
    }
    func getQueuebyadmin(id userid:Int)->Int{
        let Queues = Database().getQueues()
        var served = 0
        for queue in Queues{
            if queue.servedBy == userid{
                served+=1
            }
        }
        return served
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        staff = Database().getStaff(admin: admin)
        gettotle()
        table.reloadData()
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

