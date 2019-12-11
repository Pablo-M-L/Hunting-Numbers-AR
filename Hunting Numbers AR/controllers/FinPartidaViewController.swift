//
//  FinPartidaViewController.swift
//  Hunting Numbers AR
//
//  Created by admin on 25/11/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import AVFoundation
class FinPartidaViewController: UIViewController {

    var sonidoFinPartida: AVAudioPlayer!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if let soundURL = Bundle.main.url(forResource: "finPartida", withExtension: "wav"){
            
            do {
                sonidoFinPartida = try AVAudioPlayer(contentsOf: soundURL)
                
            } catch {
                print(error)
            }
            sonidoFinPartida.prepareToPlay()
            sonidoFinPartida.play()
            
            
        }
    }
    
    @IBAction func btnClose(_ sender: UIButton) {
        self.dismiss(animated: false, completion: nil)
        
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
