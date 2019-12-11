//
//  ViewController.swift
//  Hunting Numbers AR
//
//  Created by admin on 28/09/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit
import SpriteKit
import ARKit
import GameplayKit //se usa para numeros aleatorios.

class ViewController: UIViewController, ARSKViewDelegate {
    
    @IBOutlet var sceneView: ARSKView!
    
    var numeros = [Int]()
    var rondaNumeros = [[Int]]()
    var valorMinimo = UserDefaults.standard.integer(forKey: "valorMinimo")
    var valorMaximo = UserDefaults.standard.integer(forKey: "valorMaximo")
    var numeroDeNumerosEnPantalla = 5//UserDefaults.standard.integer(forKey: "cantidadNumeroEnPantalla")
    var ultimaRonda = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        crearRondasNumeros()
        // Set the view's delegate
        sceneView.delegate = self
        
        // Show statistics such as fps and node count
        sceneView.showsFPS = false
        sceneView.showsNodeCount = false
 
        // Load the SKScene from 'Scene.sks'

            if let scene = SKScene(fileNamed: "Scene") {
                sceneView.presentScene(scene)
        }
        
        //notificacion que se llama desde el scene.swift para ir a la pantalla fin partida.
        NotificationCenter.default.addObserver(self, selector: #selector(irFinPartida), name: NSNotification.Name(rawValue: "irFinPartida"), object: nil)
        
    }
    
    @IBAction func btnBack(_ sender: UIBarButtonItem) {
      print("back")
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @objc func irFinPartida(){
        UserDefaults.standard.set(true,forKey: "vuelveDefinPartida")
        self.performSegue(withIdentifier: "segueIrFinPartida", sender: self)
    }
    
    func crearRondasNumeros(){
        //obtener rango de numeros a mostrar
        if numeroDeNumerosEnPantalla == 0{
            numeroDeNumerosEnPantalla = 5
        }
        if valorMaximo == 0{
            valorMaximo = 5
        }
    
        let diferencia = valorMaximo - valorMinimo
        
        let numeroDeRondas = (diferencia / numeroDeNumerosEnPantalla)
        UserDefaults.standard.set(numeroDeRondas,forKey: "numeroDeRondas")
        rondaNumeros = [[Int]](repeating: [Int](repeating: 0, count: (numeroDeNumerosEnPantalla)), count: numeroDeRondas + 1)
        
        if diferencia > numeroDeNumerosEnPantalla{
            //cargar array con los numeros por ronda
            var rangoNumeros = [Int]()
            //recorre las rondas necesarias.
            for r in 0...numeroDeRondas{
                
                //crear array con los numeros que toca en esa ronda.
                rangoNumeros = []
                for _ in 1...numeroDeNumerosEnPantalla{
                    rangoNumeros += [valorMinimo + 1]
                    valorMinimo += 1
                }
                //cargar los numeros en la ronda correspondiente
                for i in 0...(numeroDeNumerosEnPantalla - 1){
                    if rangoNumeros[i] <= valorMaximo{
                        rondaNumeros[r][i] = rangoNumeros[i]
                    }

                }
            }
        }
        else{
            valorMinimo = UserDefaults.standard.integer(forKey: "valorMinimo")

            var indice = 0
            for i in valorMinimo...(valorMaximo - 1) {
                rondaNumeros[0][indice] = (i + 1)
                indice += 1
            }
        }
    }
    
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        // Load the SKScene from 'Scene.sks'
        self.loadView()
        
        if let scene = SKScene(fileNamed: "Scene") {
            sceneView.presentScene(scene)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "vuelveDefinPartida"){
            UserDefaults.standard.set(false,forKey: "vuelveDefinPartida")
            self.dismiss(animated: true, completion: nil)
        }
        
        super.viewWillAppear(animated)
        var arrayRondaEnCurso = [Int]()
        arrayRondaEnCurso = []
        UserDefaults.standard.set(arrayRondaEnCurso, forKey: "array")
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()

        if sceneView.isPaused {
            sceneView.session.run(sceneView.session.configuration!)
        } else {
            // Run the view's session
            sceneView.session.run(configuration)
        }

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        var arrayRondaEnCurso = [Int]()
        arrayRondaEnCurso = []
        UserDefaults.standard.set(arrayRondaEnCurso, forKey: "array")
        // Pause the view's session
        print("will disappear")
        sceneView.session.pause()
        
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("did disapp")
    }
    
    // MARK: - ARSKViewDelegate
    
    func view(_ view: ARSKView, nodeFor anchor: ARAnchor) -> SKNode? {
        // Create and configure a node for the anchor added to the view's session.
        let rondaEnCurso = UserDefaults.standard.integer(forKey: "rondaEnCurso")
        var arrayRondaEnCurso = [Int]()
        let arrayAleatorio = UserDefaults.standard.array(forKey: "array")
        
        //si no hay array almacenado se toma la ronda entera
        if (arrayAleatorio?.count)! == 0{
            arrayRondaEnCurso = rondaNumeros[rondaEnCurso]
        }
            //si tiene el mismo numero de elementos se toma la ronda entera
        else if (arrayAleatorio?.count)! == rondaNumeros[rondaEnCurso].count{
            arrayRondaEnCurso = rondaNumeros[rondaEnCurso]
        }
            //si tiene menos que la ronda entera, se le pasa el array guardado en el userdefault.
        else if (arrayAleatorio?.count)! != arrayRondaEnCurso.count{
            arrayRondaEnCurso = arrayAleatorio as! Array<Int>
        }
        var numero = 0
        let random = GKRandomSource.sharedRandom()
        let indiceAleatorio = random.nextInt(upperBound: (arrayRondaEnCurso.count))
        
        numero = arrayRondaEnCurso[indiceAleatorio]
        
        ultimaRonda = UserDefaults.standard.bool(forKey: "ultimaRonda")
        
        let nombreTextura = "HN\(String(numero))"
        arrayRondaEnCurso.remove(at: indiceAleatorio)
        
        UserDefaults.standard.set(arrayRondaEnCurso, forKey: "array")
        
        let textura = SKTexture(imageNamed: nombreTextura)
        let spriteNumero = SKSpriteNode(texture: textura)
        spriteNumero.name = nombreTextura
        
        return spriteNumero
        
    }
    
    func session(_ session: ARSession, didFailWithError error: Error) {
        // Present an error message to the user
        
    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    

}
