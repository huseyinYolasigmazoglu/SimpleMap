//
//  MapViewController.swift
//  SimpleMap
//
//  Created by Huseyin Yolasigmazoglu on 02/02/2021.
//

import UIKit
import GoogleMaps
import SideMenu
import GoogleSignIn

class MapViewController: UIViewController {
    
    var authUser : User?
    private var scanButton = UIButton()
    private var sideMenu : SideMenuNavigationController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createSideMenu()
        appendGoogleMape()
        createButton()
    }
    
    func createSideMenu()  {
        
        let vc = storyboard?.instantiateViewController(identifier: "menuViewController") as! MenuViewController
        
        vc.authUser = authUser
        vc.delegate = self
        
        sideMenu = SideMenuNavigationController(rootViewController: vc)
        sideMenu!.leftSide = true
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        sideMenu.menuWidth = self.view.frame.width * 3/4
    }
    
    func appendGoogleMape() {
        
        GMSServices.provideAPIKey(Constants.googleMapApiKey)
        
        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
        let mapView = GMSMapView.map(withFrame: self.view.frame, camera: camera)
        self.view.addSubview(mapView)
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
        marker.title = "Sydney"
        marker.snippet = "Australia"
        marker.map = mapView
    }
    
    func createButton()  {
        
        scanButton.translatesAutoresizingMaskIntoConstraints = false
        scanButton.setTitle("   Scan to Unlock   ", for: .normal)
        scanButton.backgroundColor = UIColor.init(red: 0/255, green: 121/255, blue: 101/255, alpha: 1)
        
        scanButton.layer.borderWidth = 3
        scanButton.layer.borderColor = UIColor.init(red: 0/255, green: 121/255, blue: 101/255, alpha: 1).cgColor
        scanButton.layer.cornerRadius = 8.0
        
        self.view.addSubview(scanButton)
        
        scanButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        scanButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -30).isActive = true
        
        scanButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
    }
    
    
    @IBAction func menuButtonPressed(_ sender: UIBarButtonItem) {
        
        present(sideMenu, animated: true, completion: nil)
    }
    
    
}


extension MapViewController: MenuViewControllerDelegate {
    
    func signOut() {
        
        GIDSignIn.sharedInstance().signOut()
        navigationController?.popViewController(animated: true)
    }
    
    
}
