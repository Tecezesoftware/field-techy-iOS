//
//  LocationView.swift
//  FieldTechy
//
//  Created by Kowsalya on 08/09/26.
//

import UIKit
import MapLibre
import MapKit

class LocationView: UIView {

    @IBOutlet weak var jobModeView: UIView!
    @IBOutlet weak var jobModeLabel: UILabel!
    
    @IBOutlet weak var checkInLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var expectedFinishLabel: UILabel!
    
    @IBOutlet weak var mapContainerView: UIView!
    @IBOutlet weak var locationLabel: UILabel!
    
    @IBOutlet weak var directionBtnOuterView: UIView!
    
    private var mapView: MLNMapView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupMap()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        directionBtnOuterView.layer.cornerRadius = 10
        directionBtnOuterView.layer.borderWidth = 1
        directionBtnOuterView.layer.borderColor = AppTheme.primaryButtonBGColor.cgColor
        
        mapContainerView.layer.borderColor = AppTheme.borderColorOfViews.cgColor
        mapContainerView.layer.borderWidth = 1
    }
    
    
    private func setupMap() {

        mapView = MLNMapView(frame: .zero)

        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.showsLogoView = false
        mapView.showsAttributionButton = false
        mapView.layer.cornerRadius = 20.0
        mapView.layer.borderColor = AppTheme.borderColorOfViews.cgColor
        mapView.layer.borderWidth = 1.5

        mapContainerView.addSubview(mapView)
        
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: mapContainerView.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: mapContainerView.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: mapContainerView.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: mapContainerView.bottomAnchor),
        ])

        let location = CLLocationCoordinate2D(
            latitude: 13.0827,
            longitude: 80.2707
        )
        mapView.allowsScrolling = true
        
        let styleURLString = "https://api.maptiler.com/maps/streets/style.json?key=geDBuqxjyGVxZPMQbj1x#1.0/3.51342/35.50781"
        guard let url = URL(string: styleURLString) else { return }
        mapView.styleURL = url
        
        mapView.setCenter(
            location,
            zoomLevel: 14,
            animated: false
        )
    }
    
    @IBAction func ViewDirection(_ sender: Any) {
        openMaps(address: "105, Anna Salai, Little Mount, Guindy, Chennai, Tamil Nadu 600032, India")
       print("View Direction")
    }
    
    func openMaps(address: String) {

        let geocoder = CLGeocoder()

        geocoder.geocodeAddressString(address) { placemarks, error in

            guard
                error == nil,
                let coordinate = placemarks?.first?.location?.coordinate
            else {
                print("Unable to find location")
                return
            }

            let placemark = MKPlacemark(coordinate: coordinate)
            let mapItem = MKMapItem(placemark: placemark)

            mapItem.name = address

            mapItem.openInMaps(
                launchOptions: [
                    MKLaunchOptionsDirectionsModeKey:
                        MKLaunchOptionsDirectionsModeDriving
                ]
            )
        }
    }
}

extension LocationView {
    static func loadFromXIB() -> LocationView? {
        let nib = UINib(
            nibName: "LocationView",
            bundle: nil
        )

        return nib.instantiate(
            withOwner: nil,
            options: nil
        ).first as? LocationView
    }
}
