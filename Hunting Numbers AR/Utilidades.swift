//
//  Utilidades.swift
//  Hunting Numbers AR
//
//  Created by admin on 08/11/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import Foundation


func redondearConDecimales(numeroDecimales: Int, numeroFloat: Float) -> Float{
    var multiplicarPor: Float = 10.0
    if numeroDecimales < 1{
        return numeroFloat
    }
    else if numeroDecimales == 1{
        let numeroInt = Int(numeroFloat * multiplicarPor)
        let numeroRedondeado = Float(numeroInt) / multiplicarPor
        
        return numeroRedondeado
    }
    else{
        
        for _ in 1...(numeroDecimales - 1){
            multiplicarPor *= 10.0
        }
        
        let numeroInt = Int(numeroFloat * multiplicarPor)
        let numeroRedondeado = Float(numeroInt) / multiplicarPor
        
        return numeroRedondeado
    }
}

