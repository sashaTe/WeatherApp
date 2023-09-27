//
//  CityModel.swift
//  Weather
//
//  Created by Alexander Zarutskiy on 09.08.2023.
//

import Foundation

//"city","city_ascii","lat","lng","country","iso2","iso3","admin_name","capital","population","id"
//"Tokyo","Tokyo","35.6897","139.6922","Japan","JP","JPN","Tōkyō","primary","37732000","1392685764"


//struct City {
//    var city: String
//    var lat: String
//    var lng: String
//    var id: String
//    
//
//    
//    init(raw: [String]) {
//        city = raw[0]
//        lat = raw[2]
//        lng = raw[3]
//        id = raw[10]
//    }
//}

//class CitySearchViewModel: ObservableObject {
//    
//    func loadCSV(from csvName: String) -> [City] {
//        var csvToStruct = [City]()
//        
//        //locate the csv file
//        guard let filePath = Bundle.main.path(forResource: csvName, ofType: "csv") else {
//            return []
//        }
//        
//        //convert the contents of the file into one very long string
//        
//        var data = ""
//        do {
//            data = try String(contentsOfFile: filePath)
//        } catch {
//            print(error)
//        }
//        
//        //split the long string into an array of rows of data. Each row is a string
//        //detect "/n" carriage return, the split
//        var rows = data.components(separatedBy: "\n")
//        
//        //remove header rows
//        rows.removeFirst()
//        
//        for row in rows {
//            let csvColumns = row.components(separatedBy: ",")
//            let cityStruct = City.init(raw: csvColumns)
//            csvToStruct.append(cityStruct)
//        }
//        
//        return csvToStruct
//    }
//    
//}
