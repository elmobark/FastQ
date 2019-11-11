//
//  pageController.swift
//  FastQ
//
//  Created by Mobark on 25/10/2019.
//  Copyright © 2019 emobark. All rights reserved.
//

import UIKit

class pageController: UIPageViewController {
    fileprivate lazy var pages:[UIViewController] = {
        return[
            self.getViewController(whitId: "page1"),
            self.getViewController(whitId: "page2")
        ]
    }()
    fileprivate func getViewController(whitId identifier:String) ->UIViewController{
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier:identifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
        
        if let firsVC = pages.first
        {
            setViewControllers([firsVC], direction: .forward, animated: true, completion: nil)
        }

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
extension pageController: UIPageViewControllerDataSource{
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let viewcontrollerIndex = pages.index(of: viewController) else {
            return nil
        }
        let prevIndex = viewcontrollerIndex-1
        guard prevIndex>=0 else {
            return pages.last
        }
        guard pages.count>prevIndex else {
            return nil
        }
        print("prev  \(prevIndex) / \(pages.count)")
        return pages[prevIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let viewcontrollerIndex = pages.index(of: viewController) else {
            return nil
        }
        let nextIndex = viewcontrollerIndex+1
        guard nextIndex<pages.count else {
            return pages.first
        }
        guard pages.count>nextIndex else {
            return nil
        }
        print("next  \(nextIndex) / \(pages.count)")
        return pages[nextIndex]
    }
    
    
}
extension pageController: UIPageViewControllerDelegate{
    
}
