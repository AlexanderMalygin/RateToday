//
//  NetworkService.swift
//  RateToday
//
//  Created by Alexader Malygin on 20.12.2019.
//  Copyright © 2019 Alexader Malygin. All rights reserved.
//

import Foundation

class NetworkService {
    
    func requestRateToday(completion: @escaping ([Exchange]) -> ()) {
        
        let today = getTodayDay()
        guard let url = URL(string: "https://api.privatbank.ua/p24api/exchange_rates?json&date=\(today)") else {return completion([])}
        
        let session = URLSession.shared
        session.dataTask(with: url) { (data, response, error) in

            do{
                let jsonDecoder = JSONDecoder()
                let initial = try jsonDecoder.decode(Initial.self, from: data!)
                
                DispatchQueue.main.async {
                    completion(initial.exchangeRate.compactMap { (exchangeRate) -> Exchange? in
                        if exchangeRate.currency == "USD" {
                            return exchangeRate
                        } else if exchangeRate.currency == "EUR" {
                            return exchangeRate
                        } else  if exchangeRate.currency == "RUB"{
                            return exchangeRate
                        } else {
                            return nil
                        }
                    }
                    )
                }
                
//
//             let usdRateToday = initial.exchangeRate.compactMap { (exchangeRate) -> Exchange? in
//                    if exchangeRate.currency == "USD" {
//                        return exchangeRate
//                    } else {
//                        return nil
//                    }
//                }
//             let euroRateToday = initial.exchangeRate.compactMap { (exchangeRate) -> Exchange? in
//                 if exchangeRate.currency == "EUR" {
//                     return exchangeRate
//                 } else {
//                     return nil
//                 }
//             }
//             let rubRateToday = initial.exchangeRate.compactMap { (exchangeRate) -> Exchange? in
//                 if exchangeRate.currency == "RUB" {
//                     return exchangeRate
//                 } else {
//                     return nil
//                 }
//             }
                
            }catch{
                print(error)
            }
        }.resume()
    }
    
    
    
    
    func requestRateYesterday(completion: @escaping ([Exchange]) -> ()) {
           let yesterday = getYesterdayDay()
           guard let url = URL(string: "https://api.privatbank.ua/p24api/exchange_rates?json&date=\(yesterday)") else {return}
           
           let session = URLSession.shared
           session.dataTask(with: url) { (data, response, error) in

               do{
                   let jsonDecoder = JSONDecoder()
                   let initial = try jsonDecoder.decode(Initial.self, from: data!)
                
                completion(initial.exchangeRate.compactMap { (exchangeRate) -> Exchange? in
                    if exchangeRate.currency == "EUR" {
                        return exchangeRate
                    } else {
                        return nil
                    }
                })
                   
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
    
}

