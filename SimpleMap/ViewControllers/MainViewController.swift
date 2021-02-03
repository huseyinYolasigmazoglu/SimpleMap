//
//  ViewController.swift
//  SimpleMap
//
//  Created by Huseyin Yolasigmazoglu on 02/02/2021.
//

import UIKit
import GoogleSignIn

class MainViewController: UIViewController{
    
    @IBOutlet weak var signInButton: GIDSignInButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        
        if GIDSignIn.sharedInstance()?.currentUser != nil {
            
        }
        else{
            GIDSignIn.sharedInstance()?.restorePreviousSignIn()
        }
        
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(userDidSignInGoogle(_:)),
                                               name: .signInGoogleCompleted,
                                               object: nil)
        
    }
    
    
    @objc private func userDidSignInGoogle(_ notification: Notification) {
        // Update screen after user successfully signed in
        
        if let user : User = notification.object as? User {
            
            performSegue(withIdentifier: Constants.goToMapViewSegue, sender: user)
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let identifier = segue.identifier {
            
            if identifier == Constants.goToMapViewSegue {
                
                if let destinationViewController = segue.destination as? MapViewController {
                    
                    if let user = sender as? User {
                        
                        destinationViewController.authUser = user
                    }
                }
                
            }
        }
        
    }
    
}
