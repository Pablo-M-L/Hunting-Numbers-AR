//
//  AjustesNumerosViewController.swift
//  Hunting Numbers AR
//
//  Created by admin on 14/11/2019.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class AjustesNumerosViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var valorMinimo = 0
    var valorMaximo = 10
    var valorInicialMinimo = 0
    var valorInicialMaximo = 10
    let arrayIdiomas = ["English", "Spanish", "Portuguese","French","Italian"]
    
    @IBOutlet weak var segmentPerimetroJuego: UISegmentedControl!
    
    @IBOutlet weak var sliderMinimo: UISlider!
    
    @IBOutlet weak var sliderMaximo: UISlider!
    
    @IBOutlet weak var labelMinimo: UILabel!
    
    @IBOutlet weak var labelMaximo: UILabel!
    
    @IBOutlet weak var pickerIdiomas: UIPickerView!
        
    @IBAction func btnBack(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerIdiomas.delegate = self
        pickerIdiomas.dataSource = self
        
        segmentPerimetroJuego.selectedSegmentIndex =  UserDefaults.standard.integer(forKey: "perimetroSeleccionado")
        
        valorMinimo = UserDefaults.standard.integer(forKey: "valorMinimo")

        sliderMinimo.value = Float(valorMinimo)
        labelMinimo.text = String(valorMinimo)
        
        valorMaximo = UserDefaults.standard.integer(forKey: "valorMaximo")
        if valorMaximo == 0{
            valorMaximo = 5
        }
        sliderMaximo.value = Float(valorMaximo)
        labelMaximo.text = String(valorMaximo)

    }

    override func viewDidAppear(_ animated: Bool) {
        let idioma = UserDefaults.standard.integer(forKey: "idiomaNumeros")
        pickerIdiomas.selectRow(idioma, inComponent: 0, animated: true)
    }
    
    
    @IBAction func btnPerimetroJuego(_ sender: UISegmentedControl) {
        UserDefaults.standard.set(segmentPerimetroJuego.selectedSegmentIndex, forKey: "perimetroSeleccionado")
        UserDefaults.standard.set(segmentPerimetroJuego.selectedSegmentIndex, forKey: "perimetroJuego")
        UserDefaults.standard.synchronize()

    }
    
    
    @IBAction func BtnSliderMinimo(_ sender: UISlider) {
        valorInicialMinimo = UserDefaults.standard.integer(forKey: "valorMinimo")
        valorMinimo = Int(sliderMinimo.value) * 5
        labelMinimo.text = String(valorMinimo)
        
    }
    
    //actua al soltar el slider
    @IBAction func btnUpSliderMinimo(_ sender: UISlider) {
        comprobarDiferencia(sliderCambiado: 1)
    }
    
    @IBAction func BtnSliderMaximo(_ sender: UISlider) {
        valorInicialMaximo = UserDefaults.standard.integer(forKey: "valorMaximo")
        valorMaximo = Int(sliderMaximo.value) * 5
        labelMaximo.text = String(valorMaximo)
        
    }
    
    //actua al soltar el slider
    @IBAction func btnUpSliderMaximo(_ sender: UISlider) {
        comprobarDiferencia(sliderCambiado: 2)
    }
    
    
    
    func comprobarDiferencia(sliderCambiado: Int){
        let diferencia = valorMaximo - valorMinimo
        print("diferencia = \(diferencia)")
        print("minimo = \(valorMinimo)")
        print("maximo = \(valorMaximo)")
        
        if valorMaximo <= valorMinimo{
           //avisar de que el valor maximo tiene que ser como minimo 4 numeros mayor que el minimo.
            mostrarAlertMenorQue(tipoError: "menorQue", sliderCambiado: sliderCambiado)
            
        }
        else if diferencia < 4{
            //avisar que tiene que ser mayor que el minimo, una diferencia de 4 numeros.
            mostrarAlertMenorQue(tipoError: "diferencia",sliderCambiado: sliderCambiado)
        }
        else{
            if sliderCambiado == 1{
                labelMinimo.text = String(valorMinimo)
                UserDefaults.standard.set(valorMinimo, forKey: "valorMinimo")
                UserDefaults.standard.synchronize()

            }
            else if sliderCambiado == 2{
                labelMaximo.text = String(valorMaximo)
                UserDefaults.standard.set(valorMaximo, forKey: "valorMaximo")
                UserDefaults.standard.synchronize()

            }
        }
    }
    
    func mostrarAlertMenorQue(tipoError: String, sliderCambiado: Int){
        var mensaje = ""
        if tipoError == "menorQue" && sliderCambiado == 1{
            mensaje = "The minimum value must be less than the maximum value."
        }
        else if tipoError == "menorQue" && sliderCambiado == 2{
            mensaje = "The maximum value must be greater than the minimum value."

        }
        else if tipoError == "diferencia"{
            mensaje = "Between the minimum and maximum value must have a minimum difference of 4 numbers."

        }
        let alert = UIAlertController(title: "CAUTION", message: mensaje, preferredStyle: .alert)
        let btnOK = UIAlertAction(title: "OK", style: .default) { (action) in
            if sliderCambiado == 1{
                print(self.valorMinimo)
                print(self.valorInicialMinimo)
                self.valorMinimo = self.valorInicialMinimo
                self.sliderMinimo.value = Float(self.valorInicialMinimo)
                self.labelMinimo.text = String(self.valorInicialMinimo)
                return
                
            }
            else if sliderCambiado == 2{
                print(self.valorMaximo)
                print(self.valorInicialMaximo)
                self.valorMaximo = self.valorInicialMaximo
                self.sliderMaximo.value = Float(self.valorInicialMaximo)
                self.labelMaximo.text = String(self.valorInicialMaximo)
                return
            }
            
        }
        alert.addAction(btnOK)
        present(alert,animated: true)
    }
    
    
    //MARK: Delegados de UIPickerView
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return arrayIdiomas.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return arrayIdiomas[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let seleccion = pickerView.selectedRow(inComponent: 0)
        UserDefaults.standard.set(seleccion,forKey: "idiomaNumeros")
        UserDefaults.standard.synchronize()
        
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
