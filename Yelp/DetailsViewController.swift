//
//  DetailsViewController.swift
//  Yelp
//
//  Created by Sang Saephan on 2/11/17.
//  Copyright © 2017 Timothy Lee. All rights reserved.
//

import UIKit
import MapKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var ratingsImageView: UIImageView!
    @IBOutlet weak var reviewLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var mapView: MKMapView!
    
    var business: Business?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        posterImageView.setImageWith((business?.imageURL)!)
        ratingsImageView.setImageWith((business?.ratingImageURL)!)
        nameLabel.text = business?.name!
        reviewLabel.text = "\(business!.reviewCount!) Reviews"
        categoryLabel.text = business?.categories!
        addressLabel.text = business?.address!
        if let phone = business?.phoneNumber {
            phoneNumberLabel.text = phone
        } else {
            phoneNumberLabel.text = "Phone number not available"
        }
        
        let centerLocation = CLLocation(latitude: business?.latitude! as! CLLocationDegrees, longitude: business?.longitude! as! CLLocationDegrees)
        goToLocation(location: centerLocation)
        
        addAnnotationAtAddress(address: (business?.address!)!, title: (business?.name!)!)
    }
    
    func goToLocation(location: CLLocation) {
        let span = MKCoordinateSpanMake(0.1, 0.1)
        let region = MKCoordinateRegionMake(location.coordinate, span)
        mapView.setRegion(region, animated: false)
    }
    
    func addAnnotationAtAddress(address: String, title: String) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if let placemarks = placemarks {
                if placemarks.count != 0 {
                    let coordinate = placemarks.first!.location!
                    let annotation = MKPointAnnotation()
                    annotation.coordinate = coordinate.coordinate
                    annotation.title = title
                    annotation.subtitle = address
                    self.mapView.addAnnotation(annotation)
                    self.mapView.selectAnnotation(annotation, animated: true)
                }
            }
        }
    }

}
