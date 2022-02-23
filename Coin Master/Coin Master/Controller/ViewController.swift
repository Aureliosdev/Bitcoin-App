//
//  ViewController.swift
//  Coin Master
//
//  Created by Aurelio Le Clarke on 04.02.2022.
//

import UIKit

class ViewController: UIViewController {
  
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var BitcoinCurrencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    @IBOutlet weak var etheriumLabel: UILabel!
    @IBOutlet weak var etheriumCurrencyLabel: UILabel!
    
    
    var coinManager = CoinManager()
    var etheriumManager = EtheriumManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
        etheriumManager.delegate = self
       
        
    }


}

extension ViewController: EtheriumManagerDelegate {
    func didupdateprice(price: String, currency: String) {
        DispatchQueue.main.async {
            self.etheriumLabel.text = price
            self.etheriumCurrencyLabel.text = currency
}
    }

func didfailWithError(error: Error) {
    print(error)
}
}

extension ViewController: CoinManagerDelegate {
    func didupdatePrice(price: String, currency: String) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = price
            self.BitcoinCurrencyLabel.text = currency
           
        }
    }

    func didFailWithError(error: Error) {
        print(error)
    }
}


extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
        etheriumManager.getCoinPrice(for: selectedCurrency)
    }
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
   
}


