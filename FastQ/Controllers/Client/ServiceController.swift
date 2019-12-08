//
//  ServiceController.swift
//  FastQ
//
//  Created by Mobark on 12/11/2019.
//  Copyright © 2019 emobark. All rights reserved.
//

import UIKit

class ServiceController: UIViewController , UITableViewDelegate , UITableViewDataSource{
    @IBOutlet weak var table: UITableView!
    var SPs:[SPModel] = []
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return SPs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let imgcell = tableView.dequeueReusableCell(withIdentifier: "servCell") as! ServiceCell
        imgcell.setImg(img: SPs[indexPath.row].logo)
        return imgcell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "SPHome") as! SPHomePageController
        viewController.SP = SPs[indexPath.row]
      
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        SPs = Database().getSPs()
        table.reloadData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
