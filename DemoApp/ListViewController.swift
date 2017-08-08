//
//  ViewController.swift
//  DemoApp
//
//  Created by Ammad on 03/08/2017.
//  Copyright © 2017 Ammad. All rights reserved.
//

import UIKit
import Alamofire
import BRYXBanner

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var carDetail : [CarDetails]? = []
    var refresher : UIRefreshControl!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        refresher = UIRefreshControl()
        refresher.attributedTitle = NSAttributedString(string: "Pull To Refresh")
        refresher.addTarget(self, action: #selector(ListViewController.pullrefrsher), for: UIControlEvents.valueChanged)
        tableView.addSubview(refresher)
        DownlaodJson(){}
    }
    
    
    
    func DownlaodJson(completed : @escaping DownloadComplete) {
        carDetail?.removeAll()
        var request = URLRequest(url: NSURL.init(string: BASE_URL)! as URL)
        request.timeoutInterval = 10 // 10 secs
        Alamofire.request(request).responseJSON { response in
            if let jsondata = response.result.value as? Dictionary <String , AnyObject> {
                if let placemarkers = jsondata["placemarks"] as? [Dictionary <String, AnyObject>] {
                    
                    for placemarker in placemarkers {
                        let carDetails = CarDetails()
                        if let addressDesc = placemarker["address"] as? String {
                            carDetails.addressStr = addressDesc
                        }
                        if let name = placemarker["name"] as? String {
                            carDetails.name = name
                        }
                        if let vinNum = placemarker["vin"] as? String {
                            carDetails.vin = vinNum
                        }
                        if let coordinates = placemarker["coordinates"] as? [Double] {
                            carDetails.longitude = coordinates[0]
                            carDetails.latitude = coordinates [1]
                            
                        }
                        self.carDetail?.append(carDetails)
                    }
                    self.tableView.reloadData()
                    self.refresher.endRefreshing()
                }
            }
            completed()
        }
        
    }
    
    func pullrefrsher () {
        self.DownlaodJson() {
            defer { let banner = Banner(title: "You are upto date!", image: UIImage(named: "check"), backgroundColor: UIColor(red:48.00/255.0, green:174.0/255.0, blue:51.5/255.0, alpha:1.000))
                banner.dismissesOnTap = true
                banner.show(duration: 0.2)
            }
        }
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "car", for: indexPath) as! CarCell
        cell.vehicleName.text = self.carDetail?[indexPath.item].name
        cell.vehiceVin.text = self.carDetail?[indexPath.item].vin
        cell.vehicleAddress.text = self.carDetail?[indexPath.item].addressStr
        cell.vechileImg.image = UIImage(named: "taxi")
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carDetail?.count ?? 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "mapView" {
            
            if let destinaton = segue.destination as? MapViewController {
                //destinaton.maps = sender as? [SkiMap]
                
                destinaton.annotations = self.carDetail!
            }
        }
    }
    
    @IBAction func MapBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "mapView", sender: self.carDetail!)
    }
    
    
    
}

