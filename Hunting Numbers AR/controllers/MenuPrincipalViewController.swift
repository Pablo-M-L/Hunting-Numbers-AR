//
//  MenuPrincipalViewController.swift
//  Hunting Numbers AR
//
//  Created by admin on 14/11/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class MenuPrincipalViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UserDefaults.standard.set(false,forKey: "vuelveDefinPartida")
        // Do any additional setup after loading the view.
        

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let delegate = UIApplication.shared.delegate as? AppDelegate {
             delegate.orientationLock = .all
         }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
