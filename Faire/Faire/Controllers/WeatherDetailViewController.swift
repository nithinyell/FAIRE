//
//  CityDetailViewController.swift
//  Faire
//
//  Created by Nithin 3 on 09/04/22.
//

import Foundation
import UIKit
import Combine

class WeatherDetailViewController: UIViewController {
    
    var city: City?
    var detailTableViewContent = [String]()
    
    var weatherInfo: WeatherInfo? {
        didSet {
            buildUI()
        }
    }
    var subscribers = Set<AnyCancellable>()
    
    lazy var temperature: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var detailTableView: UITableView = {
        let tableView = UITableView()
        tableView.allowsSelection = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    lazy var noteLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12.5)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    lazy var loader: UIActivityIndicatorView = {
        var loader = UIActivityIndicatorView()
        loader = UIActivityIndicatorView(style: .large)
        loader.translatesAutoresizingMaskIntoConstraints = false
        return loader
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = city?.title
        
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
        self.view.backgroundColor = .systemGroupedBackground
        
        self.view.addSubview(temperature)
        self.view.addSubview(detailTableView)
        self.view.addSubview(noteLabel)
        self.view.addSubview(loader)
        
        self.loader.center = self.view.center
        loader.startAnimating()
        
        detailTableView.backgroundColor = .systemGroupedBackground
        detailTableView.delegate = self
        detailTableView.dataSource = self
        detailTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        loadDetails()
    }
    
    private func loadDetails() {
        
        let model = CityDetailsViewModel()
        model.cityWeatherDetailsDelegate = CityWeatherDetails()
        model.weatherDetails("\(city?.id ?? 0)")?.sink(receiveCompletion: {[weak self] completion in
            switch completion {
            case .finished:
                print("")
            case .failure(_):
                self?.fetchDetailsFailed()
            }
            
            DispatchQueue.main.async {
                self?.loader.stopAnimating()
                self?.loader.hidesWhenStopped = true
            }
        }, receiveValue: { [weak self] weatherInfo in
            self?.weatherInfo = weatherInfo
        }).store(in: &subscribers)
    }
    
    private func buildUI() {
        guard let info = self.weatherInfo, let consolidatedWeather = info.consolidatedWeather.first else {return}
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else {return}
            
            
            NSLayoutConstraint.activate([
                self.temperature.topAnchor.constraint(equalTo: self.view.topAnchor, constant: self.navigationController?.navigationBar.frame.height ?? 0 + 10),
                self.temperature.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10),
                self.temperature.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10),
                self.temperature.heightAnchor.constraint(equalToConstant: self.view.frame.height * 0.20),
                
                self.detailTableView.topAnchor.constraint(equalTo: self.temperature.bottomAnchor, constant: 10),
                self.detailTableView.leadingAnchor.constraint(equalTo: self.temperature.leadingAnchor),
                self.detailTableView.trailingAnchor.constraint(equalTo: self.temperature.trailingAnchor),
                self.detailTableView.heightAnchor.constraint(equalToConstant: self.view.frame.height * 0.70),

                self.noteLabel.leadingAnchor.constraint(equalTo: self.temperature.leadingAnchor),
                self.noteLabel.trailingAnchor.constraint(equalTo: self.temperature.trailingAnchor),
                self.noteLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -10),
                self.noteLabel.heightAnchor.constraint(equalToConstant: self.view.frame.height * 0.10),
            ])
            
            var weatherDetails  = consolidatedWeather.weatherStateName + " with " + Constants.getTemperature(from: consolidatedWeather.theTemp)
            weatherDetails += "\nLow: \(Constants.getTemperature(from: consolidatedWeather.minTemp)) High: \(Constants.getTemperature(from: consolidatedWeather.maxTemp))"
            self.noteLabel.text = "*Note: Temperature in Celcius \nTimeZone: \(info.timezone)"
            
            self.temperature.text = weatherDetails
            self.detailTableViewContent.append("Wind Derection: \(consolidatedWeather.windDirectionCompass)")
            self.detailTableViewContent.append("Wind Speed: \(Int(consolidatedWeather.windSpeed))")
            self.detailTableViewContent.append("Air Pressure: \(Int(consolidatedWeather.airPressure))")
            self.detailTableViewContent.append("Predictability: \(Int(consolidatedWeather.predictability))")
            
            self.detailTableView.reloadData()
        }
    }
    
    func fetchDetailsFailed() {
        DispatchQueue.main.async { [weak self] in
            
            let alert = UIAlertController(title: "Retry", message: "Failed to Load Details", preferredStyle: UIAlertController.Style.alert)
            
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { [weak self] (action: UIAlertAction!) in
                self?.loadDetails()
            }))
            
            self?.present(alert, animated: true, completion: nil)
        }
    }
}

extension WeatherDetailViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailTableViewContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = detailTableViewContent[indexPath.row]
        return cell
    }
}

extension WeatherDetailViewController: UITableViewDelegate {
    
}
