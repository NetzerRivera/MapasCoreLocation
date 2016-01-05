//
//  ViewController.swift
//  Mapas2
//
//  Created by Netzer Rivera on 05/01/16.
//  Copyright © 2016 Netzer Rivera. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation //Localiza usuario

class ViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var mapaVista: MKMapView!
    
    private let manejador = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        manejador.delegate = self
        manejador.desiredAccuracy = kCLLocationAccuracyBest
        manejador.requestWhenInUseAuthorization()
        manejador.distanceFilter = 50
        
        
        
        //  1.  Poner un pin
        
        var punto = CLLocationCoordinate2D()
        punto.latitude = 42.584743
        punto.longitude = -87.821185
        
        // 2.  Generando pin
        
        let pin = MKPointAnnotation()
        pin.title = "Kenosha" + " \(manejador.location!.coordinate.latitude)"
        pin.subtitle = "Distancia" + " \(manejador.location!.distanceFromLocation(manejador.location!))"
        
        // pin.subtitle = "Distancia" + "\(manejador.location!.coordinate.longitude)"
        
        
        pin.coordinate = punto
        
        // 3. Agregamos el pin al mapa
        
        mapaVista.addAnnotation(pin)
        
        
        
        
    }
    
    // 4 Método de la autorización para localizar al usuario
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus)
        {
        if status == .AuthorizedWhenInUse
        {
            manejador.startUpdatingLocation()
            mapaVista.showsUserLocation = true   // muestra el punto azul de donde se encuentra
        
            
            
        }else{
            
            manejador.stopUpdatingLocation()
            mapaVista.showsUserLocation = false  // no mostrar al punto azul
    
            }
    }
    
    
    // Método que recibe las lecturas
   
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if manejador.distanceFilter >= 50
        {
        
        let pinUno = MKPointAnnotation()
        pinUno.title = "\(manager.location!.coordinate.latitude)"
        pinUno.subtitle = "\(manager.location!.coordinate.longitude)"

         mapaVista.addAnnotation(pinUno)
        
        }
        
    }
    
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
        let alertaUno = UIAlertController(title: "Error", message: "error \(error.code)", preferredStyle: .Alert)
        
        
        let accionOK = UIAlertAction(title: "OK", style: .Default, handler:{accionOK in
          })
        alertaUno.addAction(accionOK)
        self.presentViewController(alertaUno, animated: true, completion: nil)
    }
    
    
    
    //  ///////
    
    
    
    
    @IBAction func CambiandoDeVistasAlMapa(sender: AnyObject) {
        
        let accion = UIAlertController(title: "Tipos de Mapas", message: "Selecciona la vista del Mapa", preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        let vistaNormal = UIAlertAction(title: "Normal", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            self.mapaVista.mapType = MKMapType.Standard
        }
        let vistaSatelital = UIAlertAction(title: "Satelite", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            self.mapaVista.mapType = MKMapType.Satellite
        }
        let vistaHibrido = UIAlertAction(title: "Híbrido", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
            self.mapaVista.mapType = MKMapType.Hybrid
        }
        let cancelar = UIAlertAction(title: "Cerrar", style: UIAlertActionStyle.Default) { (UIAlertAction) -> Void in
           // NADA
        }
        
        accion.addAction(vistaNormal)
        accion.addAction(vistaSatelital)
        accion.addAction(vistaHibrido)
        accion.addAction(cancelar)
        
        presentViewController(accion, animated: true, completion: nil)
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

