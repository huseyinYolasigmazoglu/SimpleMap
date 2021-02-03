//
//  MenuViewController.swift
//  SimpleMap
//
//  Created by Huseyin Yolasigmazoglu on 03/02/2021.
//

import UIKit
import GoogleSignIn


//MARK: -protocol
protocol MenuViewControllerDelegate : class  {
    
    func signOut()
}


//MARK: -MenuViewController
class MenuViewController: UIViewController {
    
    
    @IBOutlet private weak var name: UILabel!
    weak var delegate : MenuViewControllerDelegate?
    
    var authUser : User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.view.backgroundColor = UIColor.init(red: 0/255, green: 121/255, blue: 101/255, alpha: 1)
        
        if let authUser = authUser {
            name.text = authUser.fullName
        }
        
    }
    
    
    @IBAction func signOut(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signOut()
        
        self.dismiss(animated: true, completion: nil)
        delegate?.signOut()
    }
    
    
}
