//
//  DateFormatter.swift
//  RateToday
//
//  Created by Alexader Malygin on 25.12.2019.
//  Copyright © 2019 Alexader Malygin. All rights reserved.
//

import Foundation

//    MARK: - Function get yesterday
       func getYesterdayDay() -> String {
           let date = Date()
           let format = DateFormatter()
           format.dateFormat = "dd.MM.yyyy"
        _ = format.string(from: date)
        
           let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: date)!
        _ = format.string(from: yesterday)
           
           return format.string(from: yesterday)
       }
       
       //    MARK: - Function get today
       func getTodayDay() -> String {
            let date = Date()
            let format = DateFormatter()
            format.dateFormat = "dd.MM.yyyy"
            return format.string(from: date)
           
       }


   
