//
//  IntruccionesViewController.swift
//  Hunting Numbers AR
//
//  Created by admin on 05/12/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class IntruccionesViewController: UIViewController {

    @IBOutlet weak var textViewIntrucciones: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textViewIntrucciones.text = NSLocalizedString("PWa-DL-661", comment: "texto traducido en los main.storyboard")
    
    }
    
    @IBAction func btnClose(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
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
