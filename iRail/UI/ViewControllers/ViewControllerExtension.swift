//
//  ViewControllerExtension.swift
//  iRail
//
//  Created by Sri Anumala on 4/23/19.
//  Copyright © 2019 Sri Anumala. All rights reserved.
//

import Foundation
import MBProgressHUD
import MapKit

extension UIViewController{
    func showProgressView(titleText: String? = "Loading...", descriptionText: String? = nil){
        let hud = MBProgressHUD.showAdded(to: self.view, animated: true)
        hud.label.text = titleText
        hud.detailsLabel.text = descriptionText
    }
    
    func hideProgressBar(){
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    func displayError(error: Error){
        let alertController = UIAlertController(title: "oops!", message: error.localizedDescription, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    func openCoordiantesInMaps(_ lats: Float, _ longs: Float, name: String? = nil){
        let coordinates = CLLocationCoordinate2DMake(CLLocationDegrees(exactly: lats)!, CLLocationDegrees(exactly: longs)!)
        
        let regionSpan =   MKCoordinateRegion(center: coordinates, latitudinalMeters: 1000, longitudinalMeters: 1000)
        
        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = name ?? ""
        mapItem.openInMaps(launchOptions:[
            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center)
            ] as [String : Any])
    }
}


extension UITextField{
    
    func addDoneToolBar() {
        let doneToolBar = UIToolbar()
        doneToolBar.sizeToFit()
        let barButtonDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTouchDone))
        doneToolBar.tintColor = UIColor.blue
        doneToolBar.items = [barButtonDone]
        inputAccessoryView = doneToolBar
        
    }
    
    @objc func didTouchDone() {
        resignFirstResponder()
    }
}

extension UISearchBar{
    
    func addDoneToolBar() {
        let doneToolBar = UIToolbar()
        doneToolBar.sizeToFit()
        let barButtonDone = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didTouchDone))
        doneToolBar.tintColor = UIColor.blue
        doneToolBar.items = [barButtonDone]
        inputAccessoryView = doneToolBar
        
    }
    
    @objc func didTouchDone() {
        resignFirstResponder()
    }
}
