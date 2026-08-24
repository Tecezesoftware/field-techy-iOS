//
//  ClientDashboardVC.swift
//  FieldTechy
//
//  Created by Kowsalya on 24/08/26.
//

import UIKit
import CoreLocation
import MapLibre

class ClientDashboardVC: UIViewController {
    
    @IBOutlet weak var mapContainerView: UIView!
    @IBOutlet weak var onlineView: UIView!
    @IBOutlet weak var nearbyEngineerView: UIView!
    @IBOutlet weak var balanceView: GradientView!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var eucSupportView: UIView!
    @IBOutlet weak var softwareDevView: UIView!
    @IBOutlet weak var networkEngView: UIView!
    @IBOutlet weak var cybersecurityView: UIView!
    
    private let bottomNavigationView = BottomNavigationView()
    private var mapView: MLNMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBottomNavigation()
        ConfigureUI()
        setupMap()
    }
    
    func setupBottomNavigation() {
        bottomNavigationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bottomNavigationView)
        bottomNavigationView.updateViewConstraints(view: view, bottomNavigationView: bottomNavigationView)
        
        bottomNavigationView.selectedItem = .dashboard
        bottomNavigationView.onItemSelected = { item in

            switch item {
            case .dashboard:
                print("Dashboard")

            case .jobs:
                print("Jobs")

            case .wallet:
                print("Wallet")

            case .dispute:
                print("Dispute")
            }
        }
    }
    
    func ConfigureUI() {
        makeShadowAndRadius(view: mapContainerView, shadowRadius: 20.0)
        makeShadowAndRadius(view: onlineView, shadowRadius: 12.0)
        makeShadowAndRadius(view: nearbyEngineerView, shadowRadius: 12.0)
        makeShadowAndRadius(view: eucSupportView, shadowRadius: 10.0)
        makeShadowAndRadius(view: softwareDevView, shadowRadius: 10.0)
        makeShadowAndRadius(view: networkEngView, shadowRadius: 10.0)
        makeShadowAndRadius(view: cybersecurityView, shadowRadius: 10.0)
        
    }
    
    func makeShadowAndRadius(view:UIView, shadowRadius: CGFloat){
        view.layer.borderColor = AppTheme.borderColorOfViews.cgColor
        view.layer.borderWidth = 1.5
        view.layer.shadowColor = AppTheme.borderColorOfViews.cgColor
        view.layer.shadowOffset = .init(width: 1, height: 0)
        view.layer.shadowRadius = shadowRadius
    }
    
    private func setupMap() {

        mapView = MLNMapView(frame: .zero)

        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.delegate = self

        mapContainerView.addSubview(mapView)

        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: mapContainerView.topAnchor),
            mapView.leadingAnchor.constraint(equalTo: mapContainerView.leadingAnchor),
            mapView.trailingAnchor.constraint(equalTo: mapContainerView.trailingAnchor),
            mapView.bottomAnchor.constraint(equalTo: mapContainerView.bottomAnchor)
        ])

        let location = CLLocationCoordinate2D(
            latitude: 13.0827,
            longitude: 80.2707
        )

        mapView.setCenter(
            location,
            zoomLevel: 5,
            animated: false
        )
    }
    
    @IBAction func MenuAction(_ sender: Any) {
        
    }
    
    @IBAction func searchAction(_ sender: Any) {
        
    }
    
    @IBAction func notificationAction(_ sender: Any) {
        
    }
    
    @IBAction func postJobAction(_ sender: Any) {
        
    }
}

extension ClientDashboardVC: MLNMapViewDelegate {

    func mapView(_ mapView: MLNMapView, viewFor annotation: MLNAnnotation) -> MLNAnnotationView? {

        guard let pointAnnotation = annotation as? MLNPointAnnotation,
              let title = pointAnnotation.title else {
            return nil
        }

        let identifier = "customMarker"

        var annotationView = mapView.dequeueReusableAnnotationView(
            withIdentifier: identifier
        )

        if annotationView == nil {

            annotationView = MLNAnnotationView(
                reuseIdentifier: identifier
            )

            annotationView?.frame = CGRect(
                x: 0,
                y: 0,
                width: 70,
                height: 34
            )

            annotationView?.layer.cornerRadius = 17
            annotationView?.backgroundColor = .white

            let label = UILabel(
                frame: annotationView!.bounds
            )

            label.text = "● \(title)"
            label.font = .systemFont(
                ofSize: 13,
                weight: .semibold
            )

            label.textAlignment = .center
            label.tag = 100

            annotationView?.addSubview(label)
        }

        if let label = annotationView?.viewWithTag(100) as? UILabel {
            label.text = "● EUC"
        }

        return annotationView
    }
}
