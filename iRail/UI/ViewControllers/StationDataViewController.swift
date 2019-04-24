//
//  StationDataViewController.swift
//  iRail
//
//  Created by Sri Anumala on 4/23/19.
//  Copyright © 2019 Sri Anumala. All rights reserved.
//

import UIKit

protocol StationDataCellDelegate {
    func showTrainRunningInfo(_ trainCode: String)
}

class StationDataViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, StationDataCellDelegate {
    var currentStation: Station?
    @IBOutlet var tableView: UITableView!
    @IBOutlet var stationCodeLabel: UILabel!
    var stationData = [StationData]()
    
    @IBOutlet var noResultsView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = currentStation?.stationDesc
        self.stationCodeLabel.text = currentStation?.stationCode
        self.getStationData()
    }
    
    
    func getStationData(){
        self.showProgressView()
        let params = [Params.numMins:"90", Params.stationCode: currentStation?.stationCode ?? ""]
        getStationTrainsData(parameters: params, success: { (stationData) in
            DispatchQueue.main.async {
                self.hideProgressBar()
                self.stationData = stationData
                if stationData.count == 0{
                    self.tableView.tableFooterView = self.noResultsView
                }else{
                    self.tableView.tableFooterView = nil
                }
                self.tableView.reloadData()
            }
            
        }) { (error) in
            self.hideProgressBar()
            self.displayError(error: error)
        }
        
    }
    
    @IBAction func onTappingGetDirections(_ sender: Any) {
        if let latitude = Float(currentStation?.stationLatitude ?? ""), let longitude = Float(currentStation?.stationLongitude ?? ""){
            self.openCoordiantesInMaps(latitude, longitude, name: currentStation?.stationDesc)
        }else{
            let alertController = UIAlertController(title: "oops!", message: "Coordinates unavilable!", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stationData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath) as? StationDataCell else{return UITableViewCell()}
        let data = stationData[indexPath.row]
        cell.trainCode = data.traincode ?? ""
        var trainStatusStr = (data.origin ?? "") + " -> " + (data.destination ?? "")
        trainStatusStr += "\nTrain Code: " + (data.traincode ?? "")
        trainStatusStr += "\nOrigin Time: " + (data.originTime ?? "")
        trainStatusStr += "\nDestination Time: " + (data.destinationTime ?? "")
        trainStatusStr += "\nStatus: " + (data.status ?? "")
        trainStatusStr += "\nExpected Arrival : \(data.expArrival ?? "")"
        trainStatusStr += "\nExpected Departure : \(data.expArrival ?? "")"
        trainStatusStr += "\nScheduled Arrival : \(data.schArrival ?? "")"
        trainStatusStr += "\nScheduled Departure : \(data.schDepart ?? "")"
        cell.stationDataLabel?.text = trainStatusStr
        cell.delegate = self
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func showTrainRunningInfo(_ trainCode: String) {
        if let trainStatusVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TrainStatusViewController") as? TrainStatusViewController{
            trainStatusVC.currentTrainCode = trainCode
            self.navigationController?.show(trainStatusVC, sender: nil)
        }
        
    }
    
    
    
}


class StationDataCell: UITableViewCell{
    
    var delegate: StationDataCellDelegate?
    @IBOutlet var stationDataLabel: UILabel!
    var trainCode = ""
    @IBAction func onTappingMoreInfo(_ sender: Any) {
        self.delegate?.showTrainRunningInfo(trainCode)
    }
}
