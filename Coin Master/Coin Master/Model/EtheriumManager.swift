//
//  EtheriumManager.swift
//  Coin Master
//
//  Created by Aurelio Le Clarke on 23.02.2022.
//

import Foundation
protocol EtheriumManagerDelegate {
    func didupdateprice(price: String, currency: String)
    func didfailWithError(error: Error)
}

struct EtheriumManager {

    
    var delegate: EtheriumManagerDelegate?
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate"
    let apiKey = "BB773C7A-F306-46A9-B4D7-9BF0825C78FD"
    let etherium = "ETH"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
func getCoinPrice(for currency: String) {
    let urlString = "\(baseURL)/\(etherium)/\(currency)?apikey=\(apiKey)"
    if let url = URL(string: urlString) {
        let session = URLSession(configuration: .default)
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            if let safeData = data {
                if let etheriumPrice =  self.parseJSON(safeData) {
                    let priceString = String(format:"%.2f", etheriumPrice)
                    self.delegate?.didupdateprice(price: priceString, currency: currency)
                }
            }
        }
        task.resume()
    }
}
func parseJSON(_ data: Data) -> Double? {
    let decoder = JSONDecoder()
    do {
        let decodedData = try decoder.decode(CoinDataEtherium.self, from: data)
        let lastPrice = decodedData.rate
        print(lastPrice)
        return lastPrice
        
    } catch {
    print(error)
        return nil
        
    }
}
}
