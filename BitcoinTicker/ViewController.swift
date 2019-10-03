//
//  ViewController.swift
//  BitcoinTicker
//


import UIKit

class ViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    
    let baseURL = "https://apiv2.bitcoinaverage.com/indices/global/ticker/BTC"
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    var finalURL = ""

    //Pre-setup IBOutlets
    @IBOutlet weak var bitcoinPriceLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
       self.currencyPicker.delegate = self
        self.currencyPicker.dataSource = self
    }

    
    //TODO: Place your 3 UIPickerView delegate methods here
    
    //Number of columns of data
    func numberOfComponents(in pickView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currencyArray.count
    }

    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        getBitcoinData(url: baseURL + currencyArray[row])
    }

    
//    
//    //MARK: - Networking URLSesion
//    /***************************************************************/
//    
//    func getWeatherData(url: String, parameters: [String : String]) {
//
//
//    }
//
  
    func getBitcoinData(url: String) {
        if let url = URL(string: url) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                do {
                    guard let data2 = try JSONSerialization.jsonObject(with: data!, options: []) as? [String:Any] else{
                        print("error")
                        return
                    }
                    let price = data2["bid"] as? Double
                    DispatchQueue.main.async {
                        self.updateUI(price: price ?? 0.0)
                    }
                }catch{
                    print("error")
                    return
                }
            }.resume()
        }
    }
    
    func updateUI(price: Double) {
        bitcoinPriceLabel.text = price.description
    }
    
//    
//    //MARK: - JSON Parsing without SwiftyJSON
//    /***************************************************************/
//    
//    func updateWeatherData(json : JSON) {
//
//
//        updateUIWithWeatherData()
//    }
//
    
//
//    //MARK: - Update UI
//    /***************************************************************/
//
//    func updateUIWithWeatherData() {
//
//    }
}

