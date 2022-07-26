//
//  ListTVC.swift
//  Yandex_weather
//
//  Created by cloud_vfx on 18/07/22.
//

import UIKit

class ListTVC: UIViewController , UISearchBarDelegate {

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.register(ListCell.self, forCellReuseIdentifier: "cell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    let emptyCity = Weather()
    var cityArray = [Weather]()
    var filterCityArray = [Weather]()
    
    var nameCityArray = ["Moscow", "Novosibirsk","Kazan", "Doha","Paris","Berlin","London","Tashkent","Seoul","Namangan", "Kosonsoy"]
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var searchBarIsEmpty : Bool {
        guard let text = searchController.searchBar.text else {return false}
        return text.isEmpty
    }
    
    var isFiltering: Bool {
        searchController.isActive && !searchBarIsEmpty
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if cityArray.isEmpty{
            cityArray = Array(repeating: emptyCity, count: nameCityArray.count)
        }
        
//        addCities()
//        tableView.delegate = self
//        tableView.dataSource = self
//
//        searchController.searchResultsUpdater = self
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.placeholder = "Search"
//        navigationItem.searchController = searchController
//        definesPresentationContext = true
//        navigationItem.hidesSearchBarWhenScrolling = false
        
        addCities()
        setupView()
        setConstraints()
        setupDelegate()
        setNavigationBar()
        
    }

   
    private func setupView(){
        view.backgroundColor = .white
        view.addSubview(tableView)
    }
    
    private func setupDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
        
        searchController.searchBar.delegate = self
    }
    
    private func setNavigationBar() {
        navigationItem.title = "Albums"
       
        navigationItem.searchController = searchController
        
        let userInfoButton = createCustomButton(selector: #selector(AddCityByALert))
        navigationItem.rightBarButtonItem = userInfoButton
    }
    
    @objc private func AddCityByALert(){
        alertCity(name: "City", placeHolder: "Add a new city ") { city in
            self.nameCityArray.append(city)
            self.cityArray.append(self.emptyCity)
            self.addCities()
          //  self.tableView.reloadData()
        }
    }
    
    
    
    func addCities(){

        getWeather(cityArray: self.nameCityArray) { index, weather in
            self.cityArray[index] = weather
            self.cityArray[index].name = self.nameCityArray[index]

            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
}
    
    // MARK: - Table view data source

extension ListTVC : UITableViewDataSource {
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filterCityArray.count
        }
        return cityArray.count
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListCell
        var weather = Weather()
        
        if isFiltering {
            weather = filterCityArray[indexPath.row]
        }else{
            weather = cityArray[indexPath.row]
        }
        
        cell.configure(weather: weather)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            guard let indexPath = tableView.indexPathForSelectedRow else {return}
            
            if isFiltering {
                let filter = filterCityArray[indexPath.row]
                let destination = segue.destination as! DetailView
                destination.weatherM = filter
            }
            else{
                let wData = cityArray[indexPath.row]
                let destination = segue.destination as! DetailView
                destination.weatherM = wData
            }
        }
    }
}

extension ListTVC: UITableViewDelegate {
    
internal func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
      
        let delete = UIContextualAction(style: .destructive, title: "Delete") { _ , _ , completion in
           
            let editingRow = self.nameCityArray[indexPath.row]
       
            if let index = self.nameCityArray.firstIndex(of: editingRow){
                if self.isFiltering {
                    self.filterCityArray.remove(at: index)
                }
                else{
                    self.cityArray.remove(at: index)
                }
            }
            tableView.reloadData()
        }
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        70
//    }
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailView()
        
        if isFiltering {
            let filter = filterCityArray[indexPath.row]
            detailVC.weatherM = filter
        }
        else{
            let wData = cityArray[indexPath.row]
            detailVC.weatherM = wData
        }
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
    
   //place


extension ListTVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredContextForSearch(searchController.searchBar.text!)
    }
    
    func filteredContextForSearch(_ searchText: String){
        
        filterCityArray = cityArray.filter({ filter in
            filter.name.contains(searchText)
        })
        
        tableView.reloadData()
    }
}

extension ListTVC {
    private func setConstraints() {
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
