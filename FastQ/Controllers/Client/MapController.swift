//
//  MapController.swift
//  FastQ
//
//  Created by Mobark on 13/11/2019.
//  Copyright © 2019 emobark. All rights reserved.
//

import UIKit
import MapKit
class MapController: UIViewController {
var SP:SPModel = SPModel()
    @IBOutlet weak var mapView: MKMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        let initialLocation = CLLocation(latitude: SP.lat ,longitude: SP.lng)
        
        let regionRadius: CLLocationDistance = 1000
        func centerMapOnLocation(location: CLLocation) {
            let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                      regionRadius, regionRadius)
            mapView.setRegion(coordinateRegion, animated: true)
        }
        centerMapOnLocation(location: initialLocation)
        let artwork = Artwork(title: SP.name,
                             locationName: SP.Location,
                             discipline: SP.about,
                             coordinate: CLLocationCoordinate2D(latitude: SP.lat, longitude: SP.lng))
        mapView.addAnnotation(artwork)
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
