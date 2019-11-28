//
//  Scene.swift
//  Hunting Numbers AR
//
//  Created by admin on 02/11/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import SpriteKit
import ARKit
import GameplayKit

class Scene: SKScene {
    var posicionZ: Float = -3.5
    var posicionX: Float = 0.0
    var posicionY: Float = 0.0
    var timer: Timer?
    var conteoReparto = 0
    let distanciaMinZ = 2
    let distanciaMaxZ = 4
    var arrayPosiblesDistancias = [2,2.5,3]
    var arrayPosicionesY: [Float] = []
    var arrayPosicionesX: [Float] = []
    var arrayPosicionesZ: [Float] = []
    
    //datos partida
    var partidaEmpezada = false
    var numerosCazados = 0
    var conteoGeneralPartida = 0
    var valorMinimo = 0
    var valorMaximo = 1
    var ordenAscendente = true
    var cantidadMaximaEnPantallaSeleccionada = 15
    var cantidadNumerosArepartir = 1
    var minRango = 1
    var maxRango = 5
    var ultimoCapturado = 0
    var rondaActual = 0
    var numeroDeRondas = 0
    var marcador = SKLabelNode()
    var marcadorTexto = SKLabelNode()
    var conteoNumerosEnelCentro = 0
    
    
    
    var arrayTextoNumeros = ["UNO","DOS","TRES","CUATRO","CINCO","SEIS","SIETE","OCHO","NUEVE","DIEZ","ONCE","DOCE","TRECE","CATORCE","QUINCE","DIECISEIS","DIECISITE","DIECIOCHO","DIECINUEVE","VEINTE","VEINTIUNO","VEINTIDOS","VEINTITRES","VEINTICUATRO","VEINTICINCO","VEINTISEIS","VEINTISIETE","VEINTIOCHO","VEINTINUEVE","TREINTA","TREINTA Y UNO","TREINTA Y DOS","TREINTA Y TRES","TREINTA Y CUATRO","TREINTA Y CINCO","TREINTA Y SEIS","TREINTA Y SIETE","TREINTA Y OCHO","TREINTA Y NUEVO","CUARENTA","CUARENTA Y UNO","CUARENTA Y DOS","CUARENTA Y TRES","CUARENTA Y CUATRO","CUARENTA Y CINCO","CUARENTA Y SEIS","CUARENTA Y SIETE","CUARENTA Y OCHO","CUARENTA Y NUEVE","CINCUENTA","CINCUENTA Y UNO","CINCUENTA Y DOS","CINCUENTA Y TRES","CINCUENTA Y CUATRO","CINCUENTA Y CINCO","CINCUENTA Y SEIS","CINCUENTA Y SIETE","CINCUENTA Y OCHO","CINCUENTA Y NUEVE","SESENTA","SESENTA Y UNO","SESENTA Y DOS","SESENTA Y TRES","SESENTA Y CUATRO","SESENTA Y CINCO","SESENTA Y SEIS","SESENTA Y SIETE","SESENTA Y OCHO","SESENTA Y NUEVE","SETENTA","SETENTA Y UNO","SETENTA Y DOS","SETENTA Y TRES","SETENTA Y CUATRO","SETENTA Y CINCO","SETENTA Y SEIS","SETENTA Y SIETE","SETENTA Y OCHO","SETENTA Y NUEVE","OCHENTA","OCHENTA Y UNO","OCHENTA Y DOS","OCHENTA Y TRES","OCHENTA Y CUATRO","OCHENTA Y CINCO","OCHENTA Y SEIS","OCHENTA Y SIETE","OCHENTA Y OCHO","OCHENTA Y NUEVE","NOVENTA","NOVENTA Y UNO","NOVENTA Y DOS","NOVENTA Y TRES","NOVENTA Y CUATRO","NOVENTA Y CINCO","NOVENTA Y SEIS","NOVENTA Y SIETE","NOVENTA Y OCHO","NOVENTA Y NUEVE","CIEN"]
    
    let arrayTextoNumerosIngles = ["ONE", "TWO", "THREE", "FOUR", "FIVE", "SIX", "SEVEN", "EIGHT", "NINE", "TEN", "ELEVEN", "TWELVE", "THIRTEEN", "FOURTEEN", "FIFTEEN", "SIXTEEN", "SEVENTTEN", "EIGHTEEN", "NINETEEN", "TWENTY", "TWENTY-ONE","TWENTY-TWO", "TWENTY-THREE", "TWENTY-FOUR", "TWENTY-FIVE", "TWENTY-SIX", "TWENTY-SEVEN", "TWENTY-EIGHT", "TWENTY-NINE", "THIRTY", "THIRTY-ONE", "THIRTY-TWO", "THIRTY-THREE", "THIRTY-FOUR","THIRTY-FIVE", "THIRTY-SIX", "THIRTY-SEVEN", "THIRTY-EIGHT", "THIRTY-NINE", "FORTY", "FORTY-ONE", "FORTY-TWO", "FORTY-THREE", "FORTY-FOUR", "FORTY-FIVE", "FORTY-SIX", "FORTY-SEVEN", "FORTY-EIGHT", "FORTY-NINE", "FIFTY", "FIFTY-ONE", "FIFTY-TWO", "FIFTY-THREE", "FIFTY-FOUR", "FIFTY-FIVE","FIFTY-SIX", "FIFTY-SEVEN", "FIFTY-EIGHT", "FIFTY-NINE", "SIXTY", "SIXTY-ONE", "SIXTY-TWO", "SIXTY-THREE", "SIXTY-FOUR", "SIXTY-FIVE", "SIXTY-SIX","SIXTY-SEVEN", "SIXTY-EIGHT", "SIXTY-NINE", "SEVENTY", "SEVENTY-ONE", "SEVENTY-TWO", "SEVENTY-THREE", "SEVENTY-FOUR", "SEVENTY-FIVE", "SEVENTY-SIX", "SEVENTY-SEVEN","SEVENTY-EIGHT", "SEVENTY-NINE", "EIGHTY", "EIGHTY-ONE", "EIGHTY-TWO", "EIGHTY-THREE", "EIGHTY-FOUR", "EIGHTY-FIVE", "EIGHTY-SIX", "EIGHTY-SEVEN", "EIGHTY-EIGHT","EIGHTY-NINE","NINETY", "NINETY-ONE", "NINETY-TWO", "NINETY-THREE", "NINETY-FOUR", "NINETY-FIVE", "NINETY-SIX", "NINETY-SEVEN", "NINETY-EIGHT", "NINETY-NINE", "ONE HUNDRED"]
    
    let arrayTextoNumerosPortugues = ["UM", "DOIS", "TRÊS", "QUATRO", "CINCO", "SEIS", "SETE", "OITO", "NOVE", "DEZ", "ONZE", "DOZE", "TREZE", "QUATORZE", "QUINZE", "DEZESSEIS", "DEZASSETE", "DEZOITO", "DEZENOVE", "VINTE","VINTE E UM","VINTE E DOIS", "VINTE E TRÊS", "VINTE E QUATRO", "VINTE E CINCO", "VINTE E SEIS", "VINTE E SETE", "VINTE E OITO", "VINTE E NOVE", "TRINTA", "TRINTA E UM", "TRINTA E DOIS", "TRINTA E TRÊS", "TRINTA E QUATRO","TRINTA E CINCO", "TRINTA E SEIS", "TRINTA E SETE", "TRINTA E OITO", "TRINTA E NOVE", "QUARENTA", "QUARENTA E UM", "QUARENTA E DOIS", "QUARENTA E TRÊS", "QUARENTA E QUATRO", "QUARENTA E CINCO", "QUARENTA E SEIS", "QUARENTA E SETE", "QUARENTA E OITO", "QUARENTA E NOVE", "CINQUENTA", "CINQUENTA E UM", "CINQUENTA E DOIS", "CINQUENTA E TRÊS","CINQUENTA E QUATRO", "CINQUENTA E CINCO", "CINQUENTA E SEIS", "CINQUENTA E SETE","CINQUENTA E OITO", "CINQUENTA E NOVE","SESSENTA", "SESSENTA E UM", "SESSENTA E DOIS", "SESSENTA E TRÊS", "SESSENTA E QUATRO", "SESSENTA E CINCO", "SESSENTA E SEIS","SESSENTA E SETE", "SESSENTA E OITO", "SESSENTA E NOVE","SETENTA", "SETENTA E UM", "SETENTA E DOIS", "SETENTA E TRÊS", "SETENTA E QUATRO", "SETENTA E CINCO", "SETENTA E SEIS", "SETENTA E SETE","SETENTA E OITO", "SETENTA E NOVE", "OITENTA", "OITENTA E UM", "OITENTA E DOIS", "OITENTA E TRÊS", "OITENTA E QUATRO", "OITENTA E CINCO", "OITENTA E SEIS", "OITENTA E SETE", "OITENTA E OITO","OITENTA E NOVE", "NOVENTA", "NOVENTA E UM", "NOVENTA E DOIS", "NOVENTA E TRÊS", "NOVENTA E QUATRO", "NOVENTA E CINCO", "NOVENTA E SEIS", "NOVENTA E SETE", "NOVENTA E OITO", "NOVENTA E NOVE", "CEM"]    

    
    let sonidocazado = SKAction.playSoundFileNamed("laser-sound", waitForCompletion: false)
    let sonidofallado = SKAction.playSoundFileNamed("slam", waitForCompletion: false)
    let sonidoFinPartida = SKAction.playSoundFileNamed("finPartida", waitForCompletion: false)
    let sonidoExplosion = SKAction.playSoundFileNamed("NFF-explode", waitForCompletion: false)
    var spriteCruceta = SKSpriteNode()
    var spriteBotonDerecho = SKSpriteNode()
    var spriteBotonIzquierdo = SKSpriteNode()
    var spriteBotonStart = SKSpriteNode()
    var spriteLaserVerde = SKSpriteNode()
    var spriteFondoBlanco = SKSpriteNode()
    let imgMirillaNegra = SKTexture(imageNamed: "mirillaNegra")
    let imgMirillaVerde = SKTexture(imageNamed: "mirillaVerde")
    let imgBoton = SKTexture(imageNamed: "botonDisparo")
    let imgBotonStart = SKTexture(imageNamed: "botonStart")
    let imgLaser = SKTexture(imageNamed: "laserVerde")
    let imgLaserRojo = SKTexture(imageNamed: "rayoLaserRojo")
    let imgMangoLaser = SKTexture(imageNamed: "mangoLaser")
    let fondoBlanco = SKTexture(imageNamed: "fondoBlanco")
    
    override func didMove(to view: SKView) {
        // Setup your scene here
        //self.perform(#selector(puntoCero), with: nil, afterDelay: 1)
        cantidadMaximaEnPantallaSeleccionada = UserDefaults.standard.integer(forKey: "cantidadNumeroEnPantalla")
        valorMinimo = UserDefaults.standard.integer(forKey: "valorMinimo")
        valorMaximo = UserDefaults.standard.integer(forKey: "valorMaximo")
        UserDefaults.standard.set(false,forKey:"ultimaRonda")
        
        numeroDeRondas = UserDefaults.standard.integer(forKey: "numeroDeRondas")
        print("total texto = \(arrayTextoNumeros.count)")
        
        if cantidadMaximaEnPantallaSeleccionada == 0{
            cantidadMaximaEnPantallaSeleccionada = 5
        }
        if valorMaximo == 0{
            valorMaximo = 5
        }
        
        ultimoCapturado = valorMinimo
        partidaEmpezada = false
        
        
        //si el rango de numeros elegido es menor que la cantidad maxima de numeros a mostrar en partida
        //se asigna como cantidad a repartir el rango.
        if (valorMaximo - valorMinimo) < cantidadMaximaEnPantallaSeleccionada{
            cantidadNumerosArepartir = (valorMaximo - valorMinimo)
        }
            //si el rango es mayor que la cantidad maxima de numeros a mostras, se asigna la cantidad maxima.
        else{
            cantidadNumerosArepartir = cantidadMaximaEnPantallaSeleccionada
        }
        
        switch UserDefaults.standard.integer(forKey: "perimetroJuego") {
        case 0:
            arrayPosiblesDistancias = [1.5,2,2.5]
        case 1:
            arrayPosiblesDistancias = [2,2.5,3]
        case 2:
            arrayPosiblesDistancias = [2.5,3,3.5]
        default:
            arrayPosiblesDistancias = [2,2.5,3]
        }
        
        print(arrayTextoNumeros.count)
        print(arrayTextoNumerosIngles.count)
        print(arrayTextoNumerosPortugues.count)
        calcularPosiciones()
        ponerMirilla()
        ponerBotonDerecho()
        ponerBotonIzquierdo()
        ponerBotonStart()
        //ponerLaserVerde()
        ponerMarcador()
        ponerFondoBlanco()
        marcador.isHidden = true
        spriteFondoBlanco.isHidden = true
        asignarIdioma()

    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        conteoNumerosEnelCentro = 0
        scene?.enumerateChildNodes(withName: "HN*", using: { node, _ in
            let numero = node as! SKSpriteNode
            
            let distanciaAlCentro: CGFloat = distanceBetweenPoints(p1: self.spriteCruceta.position, p2: numero.position)
            if distanciaAlCentro < 30.0{
                self.conteoNumerosEnelCentro += 1
            }
            else if distanciaAlCentro > 30{
                self.conteoNumerosEnelCentro += 0
            }
                
            })
        if conteoNumerosEnelCentro > 0 {
            self.spriteCruceta.texture = self.imgMirillaVerde
        }
        else{
            self.spriteCruceta.texture = self.imgMirillaNegra
        }
        }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //puntoCero()


        //localizar el primer toque del conjunto de toques
        guard let touch = touches.first else{return}
        let locaton = touch.location(in: self)
        
        //mirar si el toque cae dento de nuestra vista de AR
        let hit = nodes(at: locaton)
        
        //asignar botones y mitilla
        for i in hit{
            if i.name == "btnDerecho"{
                print("boton derecho")
                self.buscarNodos()
            }
            if i.name == "btnIzquierdo"{
                print("boton Izquierdo")
                self.buscarNodos()
            }
            if i.name == "btnStart"{
                print("boton start")
                if !partidaEmpezada{
                    spriteBotonStart.texture = imgMangoLaser
                    spriteBotonStart.scale(to: CGSize(width: ((self.view?.frame.width)! / 10), height: ((self.view?.frame.width)! / 4)))
                    timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { (timer) in
                        self.repartirNumero()
                    })
                }
            }
            
        }
            

    }
        
    func asignarIdioma(){
        let idioma = UserDefaults.standard.integer(forKey: "idiomaNumeros")
        print(idioma)
        switch idioma {
        case 0:
            arrayTextoNumeros = arrayTextoNumerosIngles
        case 1:
            return
        case 2:
            arrayTextoNumeros = arrayTextoNumerosPortugues
        default:
            return
        }
    }
    
    func finRonda(){
        print("funcion fin")
        if rondaActual <= numeroDeRondas{
            if rondaActual < numeroDeRondas{
                conteoReparto = 0
                calcularPosiciones()
                partidaEmpezada = false
                if !partidaEmpezada{
                    timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { (timer) in
                        self.repartirNumero()
                    })
                }
            }
            else if rondaActual == numeroDeRondas{
                print("ultima ronda")
                UserDefaults.standard.set(true,forKey:"ultimaRonda")
                conteoReparto = 0
                calcularPosiciones()
                partidaEmpezada = false
                if !partidaEmpezada{
                    timer = Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true, block: { (timer) in
                        self.repartirNumero()
                    })
                }
            }
        }
        else{
            print("fin partida")
        }
    }
    
    func buscarNodos(){
        scene?.enumerateChildNodes(withName: "HN*", using: { node, _ in
            let numero = node as! SKSpriteNode
            let distanciaAlCentro: CGFloat = distanceBetweenPoints(p1: self.spriteCruceta.position, p2: numero.position)
            if distanciaAlCentro < 30.0{
                print("cazado el numero \(numero.name)")
                print(distanciaAlCentro)
                let numeroCapturado = self.obtenerNumeroInt(spriteCapturado: numero)

                if numeroCapturado == (self.ultimoCapturado + 1) || numeroCapturado == self.valorMinimo{//|| numeroCapturado < 100
                    //self.destruirNumero(numero: numero)
                    self.marcador.isHidden = false
                    self.spriteFondoBlanco.isHidden = false
                    self.lanzarLaserDestruir(numero: numero)
                    self.ultimoCapturado = numeroCapturado
                    self.numerosCazados += 1
                    self.conteoGeneralPartida += 1
                    self.marcador.text = String(self.ultimoCapturado) + ", " + self.arrayTextoNumeros[(self.ultimoCapturado - 1)]
                    self.marcadorTexto.text = ", " + self.arrayTextoNumeros[(self.ultimoCapturado - 1)]
                    
                    if self.numerosCazados == (self.cantidadNumerosArepartir) && self.conteoGeneralPartida < ((self.valorMaximo - self.valorMinimo)){
                        self.rondaActual += 1
                        self.numerosCazados = 0
                        self.finRonda()
                    }
                    else if self.conteoGeneralPartida == ((self.valorMaximo - self.valorMinimo)){
                        print("fin partida y sonido")
                        let timer2 = Timer.scheduledTimer(withTimeInterval: 3.2, repeats: false) { (timer) in
                            //numero.run(self.sonidoFinPartida)
                            NotificationCenter.default.post(name: NSNotification.Name("irFinPartida"), object: nil)
                        }

                    }
                }
                else{
                    numero.run(self.sonidofallado)
                }
            }
            else{
                print("fallo")
            }
            
        })
    }
    
    func obtenerNumeroInt(spriteCapturado: SKNode) ->Int{
        let nombre = spriteCapturado.name
        let largoString = nombre?.count
        var numeroInt = 0
        switch largoString {
        case 3:
            guard let numeroSubString = nombre?.suffix(1) else{return 0}
            numeroInt = Int(String(numeroSubString))!
        case 4:
            guard let numeroSubString = nombre?.suffix(2) else{return 0}
            numeroInt = Int(String(numeroSubString))!
        case 5:
            guard let numeroSubString = nombre?.suffix(3) else{return 0}
            numeroInt = Int(String(numeroSubString))!
        default:
            numeroInt = 0
        }
        
        return numeroInt
    }
    
    func lanzarLaserDestruir(numero: SKNode){
        numero.run(sonidocazado)
        ponerLaserVerde()
        
        let timer = Timer.scheduledTimer(withTimeInterval: 1.72, repeats: false) { (timer) in
            self.spriteLaserVerde.removeFromParent()
            
            let numeroCazado = numero
            let animaFrame = [SKTexture(imageNamed: "exp1"),SKTexture(imageNamed: "exp2"),SKTexture(imageNamed: "exp3"),SKTexture(imageNamed: "exp4"),SKTexture(imageNamed: "exp5"),SKTexture(imageNamed: "exp6"),SKTexture(imageNamed: "exp7"),SKTexture(imageNamed: "exp8"),SKTexture(imageNamed: "exp9"),SKTexture(imageNamed: "exp10"),SKTexture(imageNamed: "exp11"),SKTexture(imageNamed: "exp12"),SKTexture(imageNamed: "exp13"),SKTexture(imageNamed: "exp14"),SKTexture(imageNamed: "exp15"),SKTexture(imageNamed: "exp16"),SKTexture(imageNamed: "exp17"),SKTexture(imageNamed: "exp18"),SKTexture(imageNamed: "exp19"),SKTexture(imageNamed: "exp20")]
            let animationFrames = SKAction.animate(with: animaFrame, timePerFrame: 0.06, resize: false, restore: true)
            let scaleOut = SKAction.scale(to: 10, duration: 1.2)
            let groupAction = SKAction.group([animationFrames,scaleOut, self.sonidoExplosion])
            let sequenceAction = SKAction.sequence([groupAction,SKAction.removeFromParent()])
            numeroCazado.run(sequenceAction)
            
        }
    }
    
    func ponerMirilla(){
        spriteCruceta = SKSpriteNode(texture: imgMirillaNegra)
        spriteCruceta.position = .zero

        spriteCruceta.zPosition = 3
        spriteCruceta.name = "cruceta"
        
        if UIDevice.current.userInterfaceIdiom == .phone{
        spriteCruceta.scale(to: CGSize(width: (self.view?.frame.midX)! * 1.3, height: (self.view?.frame.midY)! / 1.3))

        }
        else if UIDevice.current.userInterfaceIdiom == .pad{
        spriteCruceta.scale(to: CGSize(width: (self.view?.frame.midX)!, height: (self.view?.frame.midY)! / 1.3))

        }
        
        addChild(spriteCruceta)
    }
    
    func ponerFondoBlanco(){
        spriteFondoBlanco = SKSpriteNode(texture: fondoBlanco)
        spriteFondoBlanco.zPosition = 5
        spriteFondoBlanco.scale(to: CGSize(width: (self.view?.frame.size.width)!, height: self.marcador.frame.size.height * 2))
        spriteFondoBlanco.position = CGPoint(x: (self.view?.frame.minX)!, y: self.frame.maxY - (marcador.fontSize * 2.5))
        
        if UIDevice.current.userInterfaceIdiom == .phone{
            print(UIScreen.main.nativeBounds.width)
            print(UIScreen.main.nativeBounds.height)
            switch UIScreen.main.nativeBounds.width {
            case 0...641:
                print("640 iphone se")
            case 642...751:
                    print("750 iphone 8")
            case 752...1125:
                    print("1125 iphone 11 pro y 828 iphone 11 y iphone 7 plus (coge phisycal pixel 1080) ")
                    if UIScreen.main.nativeBounds.width == 1080{
                        spriteFondoBlanco.position = CGPoint(x: (self.view?.frame.minX)!, y: self.frame.maxY - (marcador.fontSize * 4))
                    }
                    else{
                        print("iphone 11 y 11 pro")
                }
            case 1160...1250:
                    if UIScreen.main.nativeBounds.height > 2300{
                        print("1242 * 2688 iphone 11 pro max")
                    }
                    else{
                        print("1242 * 2208 iphone 8 plus")
                    }

            default:
                print("default")

            }


        }
        else if UIDevice.current.userInterfaceIdiom == .pad{
            print("ipad fondo")
            spriteFondoBlanco.scale(to: CGSize(width: (self.view?.frame.size.width)!, height: self.marcador.frame.size.height * 2.5))
            spriteFondoBlanco.position = CGPoint(x: (self.view?.frame.minX)!, y: self.frame.maxY - (marcador.fontSize * 2.5))

        }
        addChild(spriteFondoBlanco)
    }
    
    func ponerMarcador(){
        marcador = SKLabelNode(fontNamed: "AvenirNext-HeavyItalic")
        marcador.fontColor = UIColor.red
        marcador.fontSize = 28
        marcador.text = String(valorMinimo) + ", " + arrayTextoNumeros[ultimoCapturado]
        marcador.verticalAlignmentMode = .bottom
        marcador.horizontalAlignmentMode = .right
        marcador.position = CGPoint(x: self.frame.maxX - (marcador.fontSize * 2), y: self.frame.maxY - (marcador.fontSize * 3))
        marcador.zPosition = 6
        
        if UIDevice.current.userInterfaceIdiom == .phone{
            print(UIScreen.main.nativeBounds.width)
            print(UIScreen.main.nativeBounds.height)
            switch UIScreen.main.nativeBounds.width {
            case 0...641:
                print("640 iphone se")
            case 642...751:
                    print("750 iphone 8")
            case 752...1125:
                    print("1125 iphone 11 pro y 828 iphone 11 y iphone 7 plus (coge phisycal pixel 1080) ")
                    if UIScreen.main.nativeBounds.width == 1080{
                        marcador.position = CGPoint(x: self.frame.maxX - (marcador.fontSize * 2), y: self.frame.maxY - (marcador.fontSize * 4.5))
                    }
            case 1160...1250:
                    if UIScreen.main.nativeBounds.height > 2300{
                        print("1242 * 2688 iphone 11 pro max")
                    }
                    else{
                        print("1242 * 2208 iphone 8 plus")
                    }
            default:
                print("default")
            }


        }
        else if UIDevice.current.userInterfaceIdiom == .pad{
            print("ipad marcador")
            marcador.fontSize = 36
            marcador.position = CGPoint(x: self.frame.maxX - (marcador.fontSize * 2), y: self.frame.maxY - (marcador.fontSize * 3))


        }
        addChild(marcador)
    }
    
    func ponerLaserVerde(){
        spriteLaserVerde = SKSpriteNode(texture: imgLaserRojo)

        spriteLaserVerde.zPosition = 2
        spriteLaserVerde.name = "laserVerde"
        
        if UIDevice.current.userInterfaceIdiom == .phone{
            print(UIScreen.main.nativeBounds.width)
            print(UIScreen.main.nativeBounds.height)
            switch UIScreen.main.nativeBounds.width {
            case 0...641:
                print("640 iphone se")
                spriteLaserVerde.position = CGPoint(x: self.frame.midX, y: self.frame.minY + (self.spriteBotonStart.frame.height * 1.9))
                spriteLaserVerde.scale(to: CGSize(width: ((self.view?.frame.width)! / 7 ), height: ((self.view?.frame.height)! ) / 2.1 ))
            case 642...751:
                    print("750 iphone 8")
                    spriteLaserVerde.position = CGPoint(x: self.frame.midX, y: self.frame.minY + (self.spriteBotonStart.frame.height * 1.9))
                    spriteLaserVerde.scale(to: CGSize(width: ((self.view?.frame.width)! / 7), height: ((self.view?.frame.height)! ) / 2.1 ))
            
            case 752...1125:
                        print("1125 iphone 11 pro y 828 iphone 11 y iphone 7 plus (coge phisycal pixel 1080) ")
                        if UIScreen.main.nativeBounds.width == 1080{
                            spriteLaserVerde.position = CGPoint(x: self.frame.midX, y: self.frame.minY + (self.spriteBotonStart.frame.height * 2))
                            spriteLaserVerde.scale(to: CGSize(width: ((self.view?.frame.width)! / 7), height: ((self.view?.frame.height)! ) / 2.3 ))
                        }
                        else{
                            spriteLaserVerde.position = CGPoint(x: self.frame.midX, y: self.frame.minY + (self.spriteBotonStart.frame.height * 2.4))
                            spriteLaserVerde.scale(to: CGSize(width: ((self.view?.frame.width)! / 7), height: ((self.view?.frame.height)! ) / 2.5 ))
                    }

                    

            case 1160...1250:
                    if UIScreen.main.nativeBounds.height > 2300{
                        print("1242 * 2688 iphone 11 pro max")
                        spriteLaserVerde.position = CGPoint(x: self.frame.midX, y: self.frame.minY + (self.spriteBotonStart.frame.height * 2.5))
                        spriteLaserVerde.scale(to: CGSize(width: ((self.view?.frame.width)! / 7 ), height: ((self.view?.frame.height)! ) / 2.5))
                    }
                    else{
                        print("1242 * 2208 iphone 8 plus")
                        spriteLaserVerde.position = CGPoint(x: self.frame.midX, y: self.frame.minY + (self.spriteBotonStart.frame.height * 2.2))
                        spriteLaserVerde.scale(to: CGSize(width: ((self.view?.frame.width)! / 7), height: ((self.view?.frame.height)! ) / 2.5 ))
                    }

            default:
                print("default")
                spriteLaserVerde.position = CGPoint(x: self.frame.midX, y: self.frame.minY + (self.spriteBotonStart.frame.height * 2))
                spriteLaserVerde.scale(to: CGSize(width: ((self.view?.frame.width)!  / 7), height: ((self.view?.frame.height)! ) / 2.5 ))
            }


        }
        else if UIDevice.current.userInterfaceIdiom == .pad{
            print("ipad laser")
            spriteLaserVerde.scale(to: CGSize(width: ((self.view?.frame.width)! / 7 ), height: ((self.view?.frame.height)! ) / 2.5 ))
            spriteLaserVerde.position = CGPoint(x: self.frame.midX, y: self.frame.minY + (self.spriteBotonStart.frame.height * 2.8))

        }
        
        addChild(spriteLaserVerde)
    }
    
    func ponerBotonDerecho(){
        print("ancho frame: \(self.view?.frame.size.width)")
        print("ancho maxX: \(self.frame.maxX)")
        print("alto minY \(self.frame.minY)")
        print("ancho frame ancho: \(self.view?.frame.width)")

    
        spriteBotonDerecho = SKSpriteNode(texture: imgBoton)
        spriteBotonDerecho.scale(to: CGSize(width: ((self.view?.frame.width)! / 4), height: ((self.view?.frame.width)! / 4)))
        spriteBotonDerecho.position = CGPoint(x: self.frame.maxX - (spriteBotonDerecho.size.width / 1.7), y: self.frame.minY + (self.spriteBotonDerecho.frame.height * 1.7))
        spriteBotonDerecho.zPosition = 1
        spriteBotonDerecho.name = "btnDerecho"
        
        if UIDevice.current.userInterfaceIdiom == .phone{
            switch UIScreen.main.nativeBounds.width {
            case 0...641:
                print("640 iphone se")
            case 642...751:
                    print("750 iphone 8")
            case 752...1125:
                print("1125 iphone 11 pro y 828 iphone 11 y iphone 7 plus (coge phisycal pixel 1080) ")
                if UIScreen.main.nativeBounds.width == 1080{
                    spriteBotonDerecho.position = CGPoint(x: self.frame.maxX - (spriteBotonDerecho.size.width / 1.2), y: self.frame.minY + (self.spriteBotonDerecho.frame.height * 1.7))
                }
            case 1160...1250:
                    if UIScreen.main.nativeBounds.height > 2300{
                        print("1242 * 2688 iphone 11 pro max")
                    }
                    else{
                        print("1242 * 2208 iphone 8 plus")
                    }

            default:
                print("default")

            }

        }
        else if UIDevice.current.userInterfaceIdiom == .pad{
            spriteBotonDerecho.scale(to: CGSize(width: ((self.view?.frame.width)! / 7), height: ((self.view?.frame.width)! / 7)))
            spriteBotonDerecho.position = CGPoint(x: self.frame.maxX - (spriteBotonDerecho.size.width / 1.2), y: self.frame.minY + (self.spriteBotonDerecho.frame.height * 1.7))

        }
        
        addChild(spriteBotonDerecho)
        
    }
    
    func ponerBotonIzquierdo(){
        spriteBotonIzquierdo = SKSpriteNode(texture: imgBoton)
        spriteBotonIzquierdo.scale(to: CGSize(width: ((self.view?.frame.width)! / 4), height: ((self.view?.frame.width)! / 4)))
        spriteBotonIzquierdo.position = CGPoint(x: self.frame.minX + (spriteBotonIzquierdo.size.width / 1.7), y: self.frame.minY +  (self.spriteBotonIzquierdo.frame.height * 1.7))
        spriteBotonIzquierdo.zPosition = 1
        spriteBotonIzquierdo.name = "btnIzquierdo"
        
        if UIDevice.current.userInterfaceIdiom == .phone{
            switch UIScreen.main.nativeBounds.width {
            case 0...641:
                print("640 iphone se")

            case 642...751:
                print("750 iphone 8")

            
            case 752...1125:
                print("1125 iphone 11 pro y 828 iphone 11 y iphone 7 plus (coge phisycal pixel 1080) ")
                if UIScreen.main.nativeBounds.width == 1080{
                    spriteBotonIzquierdo.position = CGPoint(x: self.frame.minX + (spriteBotonIzquierdo.size.width / 1.2), y: self.frame.minY +  (self.spriteBotonIzquierdo.frame.height * 1.7))
                }
            case 1160...1250:
                    
                    if UIScreen.main.nativeBounds.height > 2300{
                        print("1242 * 2688 iphone 11 pro max")
                    }
                    else{
                        print("1242 * 2208 iphone 8 plus")
                    }

            default:
                print("default")

            }



        }
        else if UIDevice.current.userInterfaceIdiom == .pad{
                    spriteBotonIzquierdo.scale(to: CGSize(width: ((self.view?.frame.width)! / 7), height: ((self.view?.frame.width)! / 7)))
            spriteBotonIzquierdo.position = CGPoint(x: self.frame.minX + (spriteBotonIzquierdo.size.width / 1.2), y: self.frame.minY +  (self.spriteBotonIzquierdo.frame.height * 1.7))


        }
        addChild(spriteBotonIzquierdo)
        
    }
    
    func ponerBotonStart(){
        spriteBotonStart = SKSpriteNode(texture: imgBotonStart)
        spriteBotonStart.scale(to: CGSize(width: ((self.view?.frame.width)! / 4), height: ((self.view?.frame.width)! / 4)))
        spriteBotonStart.position = CGPoint(x: self.frame.midX, y: self.frame.minY + (self.spriteBotonStart.frame.height / 1.9))
        spriteBotonStart.zPosition = 3
        spriteBotonStart.name = "btnStart"
        
        if UIDevice.current.userInterfaceIdiom == .phone{
            switch UIScreen.main.nativeBounds.width {
            case 0...641:
                print("640 iphone se")
            case 642...751:
                    print("750 iphone 8")
                    spriteBotonStart.position = CGPoint(x: self.frame.midX, y: self.frame.minY + (self.spriteBotonStart.frame.height / 2.1))

            
            case 752...1125:
                print("1125 iphone 11 pro y 828 iphone 11 y iphone 7 plus (coge phisycal pixel 1080) ")
                if UIScreen.main.nativeBounds.width == 1080{
                    spriteBotonStart.position = CGPoint(x: self.frame.midX, y: self.frame.minY + (self.spriteBotonStart.frame.height / 1.3))
                }
            case 1160...1250:
                    
                    if UIScreen.main.nativeBounds.height > 2300{
                        print("1242 * 2688 iphone 11 pro max")
                        spriteBotonStart.position = CGPoint(x: self.frame.midX, y: self.frame.minY + (self.spriteBotonStart.frame.height / 2))

                    }
                    else{
                        print("1242 * 2208 iphone 8 plus")
                        spriteBotonStart.position = CGPoint(x: self.frame.midX, y: self.frame.minY + (self.spriteBotonStart.frame.height / 2))
                    }

            default:
                print("default")

            }

        }
        else if UIDevice.current.userInterfaceIdiom == .pad{
                    spriteBotonStart.scale(to: CGSize(width: ((self.view?.frame.width)! / 7), height: ((self.view?.frame.width)! / 7)))
                    spriteBotonStart.position = CGPoint(x: self.frame.midX, y: self.frame.minY + (self.spriteBotonStart.frame.height / 1.8))


        }
        addChild(spriteBotonStart)
    }
    
    func calcularPosiciones(){
        var posicion: Float = 0.00
        //crear una matriz de rotacion aleatoria en y. es el eje de rotacion que va de arriba a abajo de la pantalla del iphone.
        for _ in 0...(cantidadMaximaEnPantallaSeleccionada){
            let intervaloFloat = 1.0 / Float(cantidadMaximaEnPantallaSeleccionada)
            let intervalo = redondearConDecimales(numeroDecimales: 2, numeroFloat: intervaloFloat)
            posicion += intervalo
            if posicion > 1{
                posicion -= 1
            }
            else if posicion == 1{
                posicion = 0.01
            }
            
            arrayPosicionesY.append(redondearConDecimales(numeroDecimales: 2, numeroFloat: posicion))
        }
        arrayPosicionesX = arrayPosicionesY.reversed()
        arrayPosicionesZ = arrayPosicionesY
    }
    
    func repartirNumero(){
        
        if conteoReparto >= cantidadNumerosArepartir{
            timer?.invalidate()
            timer = nil
            partidaEmpezada = true
        }
        else{
            //clase del generador de nuemeros aleatorios.
            let random = GKRandomSource.sharedRandom()
            
            if numeroDeRondas == 0{
                UserDefaults.standard.set(0,forKey: "rondaEnCurso")
            }
            else {
                UserDefaults.standard.set(rondaActual,forKey: "rondaEnCurso")
            }
            
            guard let sceneView = self.view as? ARSKView else{return}
            
            //Float.pi seria 180 grados.
            //2.0 * Float.pi es una vuelta entera.
            //el random es entre 0 y 1.
            //para indicar el eje en el que se quiere rotar se le indica poniendo un 0 o un 1 en los argumentos x,y,z
            //crear una matriz de rotacion aleatoria en x. es el eje de rotacion que va de izquierda a derecha de la pantalla.
            let multiplicador = arrayPosicionesX.randomElement()!
            let rotateX = simd_float4x4(SCNMatrix4MakeRotation(2 * Float.pi * multiplicador, 1, 0, 0))
            let indiceXABorrar = quitarPosicion(posicion: multiplicador, array: arrayPosicionesX)
            arrayPosicionesX.remove(at: indiceXABorrar)
            
            
            let multiplicadorY = arrayPosicionesY.randomElement()!
            let rotateY = simd_float4x4(SCNMatrix4MakeRotation(2.0 * Float.pi * multiplicadorY , 0, 1, 0))
            let indiceYABorrar = quitarPosicion(posicion: multiplicador, array: arrayPosicionesY)
            arrayPosicionesY.remove(at: indiceYABorrar)
            
            //el eje de rotacion z es el que atraviesa la pantalla.
            let multiplicadorZ = arrayPosicionesZ.randomElement()!
            let rotateZ = simd_float4x4(SCNMatrix4MakeRotation(2.0 * Float.pi * multiplicadorZ , 0, 1, 0))
            let indiceZABorrar = quitarPosicion(posicion: multiplicador, array: arrayPosicionesY)
            arrayPosicionesZ.remove(at: indiceZABorrar)

            // combinar las dos rotaciones con un producto de matrices.
            let rotation = simd_mul(rotateX, rotateY)
            let rotationTotal = simd_mul(rotation, rotateZ)
            
            //crear una translacion de 1.5 metros den la direccion de la pantalla.
            var translation = matrix_identity_float4x4
            
            
            let indiceArrayDistancia = random.nextInt(upperBound: arrayPosiblesDistancias.count)
            let distancia = arrayPosiblesDistancias[indiceArrayDistancia]
            translation.columns.3.z = Float(distancia) * -1
            
            //combinar la matriz de rotacion con la matriz de translacion. primero se rota y despues se translada.
            let finalTransform = simd_mul(rotationTotal, translation)

            //creamos el punto de anclaje.
            let anchor = ARAnchor(transform: finalTransform)
            
            //añadir esa ancla a la escena.
            sceneView.session.add(anchor: anchor)
            
            conteoReparto += 1
        }

    }
    
    func quitarPosicion(posicion: Float, array: Array<Float>) -> Int{
        var indice = 0
        for pos in array{
            if pos == posicion{
                return indice
            }
            else{
                indice += 1
            }
        }
        return indice
    }
    
    @objc func puntoCero(){
         
         guard let sceneView = self.view as? ARSKView else {
             return
         }
         
         // Create anchor using the camera's current position
         if let currentFrame = sceneView.session.currentFrame {
             // Create a transform with a translation of 0.2 meters in front of the camera
              var translation = matrix_identity_float4x4
              translation.columns.3.z = -2
              let transform = simd_mul(currentFrame.camera.transform, translation)
              // Add a new anchor to the session
              let anchor = ARAnchor(transform: transform)
              sceneView.session.add(anchor: anchor)
         }

     }
}
