//
//  TableViewController.swift
//  RateToday
//
//  Created by Alexader Malygin on 06.12.2019.
//  Copyright © 2019 Alexader Malygin. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    var exchange: [Exchange] = []
    let networkService = NetworkService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        requestRateToday()
        requestRateYesterday()
        
    }
    
    func requestRateToday() {
        networkService.requestRateToday { [weak self] exchange in
            self?.exchange = exchange
            self?.tableView.reloadData()
        }
        
       }
    func requestRateYesterday() {
        networkService.requestRateYesterday { [weak self] exchange in
        self?.exchange = exchange
        }
    }
       
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return exchange.count
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell

        let model = exchange[indexPath.row]
        
        cell.currency.text = model.currency
        cell.saleRate.text = "\(model.saleRate ?? 0)"
        cell.purchaseRate.text = "\(model.purchaseRate ?? 0)"
                
        
        return cell
    }


}
