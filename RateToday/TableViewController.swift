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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        requestRateToday()
        requestRateYesterday()
        
    }
    
    
    
    func requestRateToday() {
           let today = getTodayDay()
           guard let url = URL(string: "https://api.privatbank.ua/p24api/exchange_rates?json&date=\(today)") else {return}
           
           let session = URLSession.shared
           session.dataTask(with: url) { (data, response, error) in

               do{
                   let jsonDecoder = JSONDecoder()
                   let initial = try jsonDecoder.decode(Initial.self, from: data!)
                   
                let usdRateToday = initial.exchangeRate.compactMap { (exchangeRate) -> Exchange? in
                       if exchangeRate.currency == "USD" {
                           return exchangeRate
                       } else {
                           return nil
                       }
                   }
                let euroRateToday = initial.exchangeRate.compactMap { (exchangeRate) -> Exchange? in
                    if exchangeRate.currency == "EUR" {
                        return exchangeRate
                    } else {
                        return nil
                    }
                }
                let rubRateToday = initial.exchangeRate.compactMap { (exchangeRate) -> Exchange? in
                    if exchangeRate.currency == "RUB" {
                        return exchangeRate
                    } else {
                        return nil
                    }
                }

                self.exchange.append(contentsOf: usdRateToday)
                self.exchange.append(contentsOf: euroRateToday)
                self.exchange.append(contentsOf: rubRateToday)

                print(usdRateToday)
                print(euroRateToday)
                print(rubRateToday)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                   
               }catch{
                   print(error)
               }
           }.resume()
       }
       
       func requestRateYesterday() {
           let yesterday = getYesterdayDay()
           guard let url = URL(string: "https://api.privatbank.ua/p24api/exchange_rates?json&date=\(yesterday)") else {return}
           
           let session = URLSession.shared
           session.dataTask(with: url) { (data, response, error) in

               do{
                   let jsonDecoder = JSONDecoder()
                   let initial = try jsonDecoder.decode(Initial.self, from: data!)
                   
                let usdRate = initial.exchangeRate.compactMap { (exchangeRate) -> Exchange? in
                       if exchangeRate.currency == "USD" {
                           return exchangeRate
                       } else {
                           return nil
                       }
                   }
                let euroRate = initial.exchangeRate.compactMap { (exchangeRate) -> Exchange? in
                    if exchangeRate.currency == "EUR" {
                        return exchangeRate
                    } else {
                        return nil
                    }
                }
                let rubRate = initial.exchangeRate.compactMap { (exchangeRate) -> Exchange? in
                    if exchangeRate.currency == "RUB" {
                        return exchangeRate
                    } else {
                        return nil
                    }
                    
                  
                 }
                
               }catch{
                   print(error)
               }
           }.resume()
        
       }
    
       //    MARK: - Function get yesterday
           private func getYesterdayDay() -> String {
               let date = Date()
               let format = DateFormatter()
               format.dateFormat = "dd.MM.yyyy"
            _ = format.string(from: date)
            
               let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: date)!
            _ = format.string(from: yesterday)
               
               return format.string(from: yesterday)
           }
           
           //    MARK: - Function get today
           private func getTodayDay() -> String {
                let date = Date()
                let format = DateFormatter()
                format.dateFormat = "dd.MM.yyyy"
                return format.string(from: date)
               
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
