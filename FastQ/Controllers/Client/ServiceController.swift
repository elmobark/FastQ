//
//  ServiceController.swift
//  FastQ
//
//  Created by Mobark on 12/11/2019.
//  Copyright © 2019 emobark. All rights reserved.
//

import UIKit

class ServiceController: UIViewController , UITableViewDelegate , UITableViewDataSource{
    var SPs:[SPModel] = [SPModel(name: "وزارة الخدمة المدنية", logo: #imageLiteral(resourceName: "8478551-862102101"), service: ["Internet","landline","Business"], about: "رؤيتنا لشركوزارة الخدمة المدنية السعودية هي الوزارة المسؤولة عن الإشراف على شؤون الخدمة المدنية في الوزارات والمصالح الحكومية العامة والأجهزة ذوات الشخصية المعنوية بالمملكة العربية السعودية", workTime: "8:00AM 7:00pm", phone: "8001161666", website: "https://www.mcs.gov.sa", Location: "الرياض", id: 0,lat:24.650777,lng:46.701125),
        SPModel(name: "مستشفي الامير محمد بن عبد العزيز", logo: #imageLiteral(resourceName: "DC7eKUnXgAA4cSJ"), service: ["Internet","landline","Business"], about: "مدينة الأمير محمد بن عبدالعزيز الطبية تقع في مدينة سكاكا في منطقة الجوف.", workTime: "8:00AM 7:00pm", phone: "966 -11- 2616666", website: "https://www.pmah.med.sa", Location: "حي الروابي تقاطع شارع الإمام أحمد بن حنبل مع شارع الواحة", id: 1,lat:24.710036,lng:46.792466),
        SPModel(name: "STC", logo: #imageLiteral(resourceName: "timthumb"), service: ["Internet","landline","Business"], about: "رؤيتنا لشركة STC دفعتنا لبناء استراتيجية التي تتكون من أربعة محاور استراتيجية تُمكِّن الشركة وترفع من كفاءاتها استعدأداً لمستقبل مشرق.", workTime: "8:00AM 7:00pm", phone: "900", website: "https://www.stc.com.sa", Location: "الإتصالات السعودية STC، جدة", id: 2,lat:24.782006,lng:46.662102),
        SPModel(name: "سامبا", logo: #imageLiteral(resourceName: "economy-200518-a"), service: ["Internet","landline","Business"], about: "رؤيتنا لشركة خدمات مصرفية مبتكرة تتميز بالجودة والتطوير المستمر. وكون سامبا البنك الأكثر شعبية في المملكة العربية السعودية يجعله حريصاً دوماً على الحفاظ على القيم المتأصلة في المجتمع السعودي، كما يسعى دوما لمواكبة و تقديم أحدث الخدمات البنكية", workTime: "8:00AM 7:00pm", phone: "800 124-2000", website: "https://www.samba.com", Location: "الرياض", id: 3,lat:24.659860,lng:46.718108)]
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
