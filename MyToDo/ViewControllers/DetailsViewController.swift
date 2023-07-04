//
//  DetailsViewController.swift
//  MyToDo
//
//  Created by Nitin Kalokhe on 19/06/23.
//

import UIKit
import MapKit

class DetailsViewController : UIViewController {
 
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var item : ToDoItem?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let item = item else { return  }
        label.text = item.title
        
        if let location = item.location {
            locationLabel.text = location.name
            
            if let coordinate = location.coordinates {
                centerMapOnLocation(with: coordinate)
            }
        }
    }
    
    func centerMapOnLocation(with coorinates: CLLocationCoordinate2D) {
        let regionRadius : CLLocationDistance = 1000
        
        let regionLocation = MKCoordinateRegion(center: coorinates, latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        mapView.setRegion(regionLocation, animated: true)
    }
}
