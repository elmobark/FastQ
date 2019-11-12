//
//  ServiceController.swift
//  FastQ
//
//  Created by Mobark on 12/11/2019.
//  Copyright © 2019 emobark. All rights reserved.
//

import UIKit

class ServiceController: UIViewController , UITableViewDelegate , UITableViewDataSource{
    var SPs:[SPModel] = [SPModel(name: "STC", logo: #imageLiteral(resourceName: "timthumb"), service: ["Internet"], about: "رؤيتنا لشركة STC دفعتنا لبناء استراتيجية التي تتكون من أربعة محاور استراتيجية تُمكِّن الشركة وترفع من كفاءاتها استعدأداً لمستقبل مشرق.", workTime: "8:00AM 7:00pm", phone: "900", website: "https://www.stc.com.sa", Location: "الإتصالات السعودية STC، جدة", id: 0)]
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
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
