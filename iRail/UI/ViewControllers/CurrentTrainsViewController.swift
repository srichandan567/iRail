//
//  CurrentTrainsViewController.swift
//  iRail
//
//  Created by Sri Anumala on 4/23/19.
//  Copyright © 2019 Sri Anumala. All rights reserved.
//

import UIKit

protocol CurrentTrainDelegate {
    func openMapsforTrain(indexPath: IndexPath?)
    func showTrainCurrentStatus(indexPath: IndexPath?)
}
//MARK:- Classes
class CurrentTrainsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, CurrentTrainDelegate, UISearchBarDelegate {
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    var resultSet = [CurrentTrain]()
    var currentTrains = [CurrentTrain]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getCurrentTrainsData()
        self.title = "Trains"
        self.searchBar.delegate = self
        self.searchBar.addDoneToolBar()
    }
    
    func getCurrentTrainsData(){
        self.showProgressView()
        getCurrentTrains(success: { (trains) in
            DispatchQueue.main.async {
                self.hideProgressBar()
                self.currentTrains = trains
                self.resultSet = trains
                self.tableView.reloadData()
            }
        }) { (error) in
            self.hideProgressBar()
            self.displayError(error: error)
        }
    }
    
    //MARK:- UITableView Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.currentTrains.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "trainCellIdentifier", for: indexPath) as? RunningTrainTableViewCell else{ return UITableViewCell()}
        let train = self.currentTrains[indexPath.row]
        cell.trainCodeLabel.text = train.trainCode
        cell.trainDirectionLabel.text = train.direction
        cell.messageLabel.text = train.publicMessage
        cell.indexPath = indexPath
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func openMapsforTrain(indexPath: IndexPath?) {
        if let row = indexPath?.row{
            let train = self.currentTrains[row]
            if let latitude = Float(train.trainLatitude ?? ""), let longitude = Float(train.trainLongitude ?? ""){
                self.openCoordiantesInMaps(latitude, longitude, name: train.trainCode)
            }
        }
    }
    
    func showTrainCurrentStatus(indexPath: IndexPath?) {
        if let index = indexPath?.row, let trainStatusVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TrainStatusViewController") as? TrainStatusViewController{
            let train = self.currentTrains[index]
            trainStatusVC.currentTrainCode = train.trainCode ?? ""
            self.navigationController?.show(trainStatusVC, sender: nil)
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if let text = searchBar.text, text.count > 0{
            self.currentTrains = resultSet.filter({$0.trainCode?.contains(text) ?? false})
        }else{
            self.currentTrains = resultSet
        }
        self.tableView.reloadData()
    }
}

//b

class RunningTrainTableViewCell: UITableViewCell{
    @IBOutlet var trainCodeLabel: UILabel!
    @IBOutlet var trainDirectionLabel: UILabel!
    @IBOutlet var messageLabel: UILabel!
    var indexPath: IndexPath?
    var delegate: CurrentTrainDelegate?
    @IBAction func onTappingFindInMap(_ sender: Any) {
        self.delegate?.openMapsforTrain(indexPath: indexPath)
    }
    @IBAction func viewCurrrentStatus(_ sender: Any) {
        self.delegate?.showTrainCurrentStatus(indexPath: indexPath)
    }
    
}
