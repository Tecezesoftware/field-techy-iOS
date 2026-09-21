//
//  ClientDashboardVC.swift
//  FieldTechy
//
//  Created by Kowsalya on 24/08/26.
//

import UIKit
import CoreLocation
import MapLibre

class ClientDashboardVC: BaseViewController {
    
    @IBOutlet weak var mapContainerView: UIView!
    @IBOutlet weak var onlineView: UIView!
    @IBOutlet weak var nearbyEngineerView: UIView!
    @IBOutlet weak var balanceView: GradientView!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var eucSupportView: UIView!
    @IBOutlet weak var softwareDevView: UIView!
    @IBOutlet weak var networkEngView: UIView!
    @IBOutlet weak var cybersecurityView: UIView!
    
    private var mapView: MLNMapView!
    private var sideMenu: SideMenuView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fromScreen = .dashboard
        setupBottomNavigation(selectedItem: .dashboard)
        ConfigureUI()
        setupMap()
    }
    
    
    func ConfigureUI() {
        makeShadowAndRadius(view: mapContainerView, shadowRadius: 10.0)
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
        mapView.showsLogoView = false
        mapView.showsAttributionButton = false
        mapView.layer.cornerRadius = 20.0
        mapView.layer.borderColor = AppTheme.borderColorOfViews.cgColor
        mapView.layer.borderWidth = 1.5
        mapView.delegate = self

        mapContainerView.addSubview(mapView)
        mapView.addSubview(nearbyEngineerView)
        mapView.addSubview(onlineView)
        
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

    
    @IBAction func searchAction(_ sender: Any) {
        
    }
    
    @IBAction func notificationAction(_ sender: Any) {
        let vc = Singleton.shared.storyBoard(storyboard: "Notification", identifier: "NotificationVC")
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func postJobAction(_ sender: Any) {
        let vc = Singleton.shared.storyBoard(storyboard: "PostJobs", identifier: "PostJobsVC")
        self.navigationController?.pushViewController(vc, animated: true)
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
