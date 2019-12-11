//
//  cleintlistController.swift
//  FastQ
//
//  Created by Mobark on 09/12/2019.
//  Copyright © 2019 emobark. All rights reserved.
//

import UIKit

class cleintlistController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var service:ServiceModel = ServiceModel()
    var tickets:[ticketmodel] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tickets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "usercell") as! userQueueCell
        cell.ticket.text = tickets[indexPath.row].queue
        cell.username.text = tickets[indexPath.row].name
        return cell
    }
    

    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let queues = Database().getQueues().filter({return $0.service == service.id})
        for item in queues{
            print("found item \(item.toDic())")
            tickets.append(ticketmodel(name: Database().getUserById(id: item.serveTo).name, queue: "\(item.id)"))
        }
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
