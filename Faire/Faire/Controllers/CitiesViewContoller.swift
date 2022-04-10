//
//  ViewController.swift
//  Faire
//
//  Created by Nithin 3 on 09/04/22.
//

import UIKit

class CitiesViewContoller: UIViewController {

    @IBOutlet weak var citiesTableView: UITableView!
    var citiesList: [City]?
    var cities = Cities()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cities.citiesDelegate = self
        cities.fetchCitiesList()
        citiesTableView.delegate = self
        citiesTableView.dataSource = self
        citiesTableView.backgroundColor = .systemGroupedBackground
        self.title = "Cities ☀️"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpNavigationBar()
    }
    
    private func setUpNavigationBar() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
}

extension CitiesViewContoller: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return citiesList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CityCell {
            
            cell.city = self.citiesList?[indexPath.row]
            
            return cell
        }
        
        return UITableViewCell()
    }
}

extension CitiesViewContoller: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let detailsViewController = self.storyboard?.instantiateViewController(withIdentifier: "WeatherDetailViewController") as? WeatherDetailViewController {
            DispatchQueue.main.async { [weak self] in
                detailsViewController.city = self?.citiesList?[indexPath.row]
                self?.navigationController?.pushViewController(detailsViewController, animated: true)
            }
        }
    }
}

extension CitiesViewContoller: CitiesDelegate {
    func fetchCities(cities: [City]?) {
        DispatchQueue.main.async { [weak self] in
            self?.citiesList = cities
            self?.citiesTableView.reloadData()
        }
    }
}
