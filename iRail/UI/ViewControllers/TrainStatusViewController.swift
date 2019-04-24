//
//  TrainStatusViewController.swift
//  iRail
//
//  Created by Sri Anumala on 4/23/19.
//  Copyright © 2019 Sri Anumala. All rights reserved.
//

import UIKit

class TrainStatusViewController: UIViewController, UITabBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var tableView: UITableView!
    var currentTrainCode = ""
    var trainMovements = [TrainMovements]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getTrainMovementData()
        self.title = currentTrainCode
    }
    
    func getTrainMovementData(){
        self.showProgressView()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        let dateStr = formatter.string(from: Date())
        let params = [Params.trainId: currentTrainCode, Params.trainDate : dateStr]
        
        getCurrentTrainMovements(parameters: params, success: { (trainMovements) in
            DispatchQueue.main.async {
                self.hideProgressBar()
                self.trainMovements = trainMovements
                self.tableView.reloadData()
            }
        }) { (error) in
            self.hideProgressBar()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.trainMovements.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
        let trainMovement = trainMovements[indexPath.row]
        var trainStatusStr = (trainMovement.trainCode ?? "")
        trainStatusStr += " (" + self.getLocationTypeString(trainMovement.locationType ?? "") + ")"
        trainStatusStr += "\nLocation " + (trainMovement.locationFullName ?? "")
        trainStatusStr += "\nScheduled Arrival : \(trainMovement.scheduledArrival ?? "")"
        trainStatusStr += "\nScheduled Departure : \(trainMovement.scheduledDeparture ?? "")"
        trainStatusStr += "\nExpected Arrival : \(trainMovement.expectedArrival ?? "")"
        trainStatusStr += "\nExpected Departure : \(trainMovement.expectedDeparture ?? "")"
        if let arrival = trainMovement.arrival, let departure = trainMovement.departure{
            trainStatusStr += "\nActual Arrival : \(arrival)"
            trainStatusStr += "\nActual Departure : \(departure)"
            
        }
        cell.textLabel?.text = trainStatusStr
        cell.textLabel?.numberOfLines = 0
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if self.trainMovements.count > 0{
            let trainMovement = self.trainMovements.first
            var title = trainMovement?.trainOrigin ?? ""
            title += " -> "
            title += trainMovement?.trainDestination ?? ""
            return title
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func getLocationTypeString(_ type: String) -> String{
        switch type{
        case "O":
            return "Origin"
        case "S":
            return "Stop"
        case "T":
            return "TimingPoint"
        default:
            return "Destination"
        }
        
    }
}



