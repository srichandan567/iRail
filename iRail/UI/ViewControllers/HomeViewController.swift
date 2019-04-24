//
//  HomeViewController.swift
//  iRail
//
//  Created by Sri Anumala on 4/23/19.
//  Copyright © 2019 Sri Anumala. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet weak var filterView: UIView!
    var stations = [Station]()
    var allStations = [Station]()
    @IBOutlet weak var tableView: UITableView!
    var currentFilter = StationType.all
    @IBOutlet weak var filterLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Stations"
        self.getStationsData()
        self.searchBar.delegate = self
        self.searchBar.addDoneToolBar()
    }
    
    
    func getStationsData(params: [String: String]? = nil){
        self.showProgressView()
        if let _ = params{
            getStationsByType(parameters: params, success: { (stations) in
                DispatchQueue.main.async {
                    self.updateWithStations(stations)                }
            }) { (error) in
                self.hideProgressBar()
                self.displayError(error: error)
            }
        }else{
            getAllStations(success: { (stations) in
                DispatchQueue.main.async {
                    self.updateWithStations(stations)
                }
            }) { (error) in
                self.hideProgressBar()
                self.displayError(error: error)
            }
        }
    }
    
    func updateWithStations(_ stations: [Station]){
        self.hideProgressBar()
        self.stations = stations
        self.stations.sort(by: { (station1, station2) -> Bool in
            return (station1.stationDesc ?? "") < (station2.stationDesc ?? "")
        })
        self.tableView.reloadData()
    }
    
    func showFilterActionSheet(){
        let actionSheet = UIAlertController(title: "Show", message: nil, preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: StationType.all.rawValue, style: .default, handler: { (action) in
            self.filterStations(forStationType: StationType.all)
        }))
        actionSheet.addAction(UIAlertAction(title: StationType.mainline.rawValue, style: .default, handler: { (action) in
            self.filterStations(forStationType: StationType.mainline)
        }))
        actionSheet.addAction(UIAlertAction(title: StationType.suburban.rawValue, style: .default, handler: { (action) in
            self.filterStations(forStationType: StationType.suburban)
        }))
        actionSheet.addAction(UIAlertAction(title: StationType.dart.rawValue, style: .default, handler: { (action) in
            self.filterStations(forStationType: StationType.dart)
        }))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func filterStations(forStationType: StationType){
        self.searchBar.text = ""
        self.searchBar.resignFirstResponder()
        self.currentFilter = forStationType
        if forStationType != .all{
            self.filterView.isHidden = false
            self.filterLabel.text = "Showing \(forStationType.rawValue) Stations"
        }else{
            self.filterView.isHidden = true
        }
        let params = [Params.stationType: forStationType.getParam()]
        getStationsData(params: params)
    }
    
    @IBAction func onTappingFilter(_ sender: Any) {
        self.showFilterActionSheet()
    }
    
    @IBAction func onTappingClearBtn(_ sender: Any) {
        self.filterStations(forStationType: StationType.all)
    }
}

extension HomeViewController: UITableViewDataSource, UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellIdentifier", for: indexPath)
        let station = self.stations[indexPath.row]
        cell.textLabel?.text = station.stationDesc
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let station = self.stations[indexPath.row]
        if let stationDataVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "StationDataViewController") as? StationDataViewController{
            stationDataVC.currentStation = station
            self.navigationController?.show(stationDataVC, sender: nil)
        }
    }
    
}

extension HomeViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.updateResults(searchText: searchText)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text{
            self.updateResults(searchText: text)
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.getStationsData()
    }
    
    func updateResults(searchText: String){
        let params = [Params.stationText: searchText]
        searchStationByText(parameters: params, success: { (stations) in
            DispatchQueue.main.async {
                self.updateWithStations(stations)
            }
        }) { (error) in
            self.displayError(error: error)
        }
    }
}
