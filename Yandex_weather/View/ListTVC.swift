//
//  ListTVC.swift
//  Yandex_weather
//
//  Created by cloud_vfx on 18/07/22.
//

import UIKit

class ListTVC: UIViewController {
    
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
    
    var nameCityArray = ["Moscow", "Novosibirsk","Kazan", "Doha","Paris","Berlin","London","Tashkent","Seoul","Namangan"]
    var searchController = UISearchController(searchResultsController: nil)
   
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
        addCities()
        setupView()
        setConstraints()
        setupDelegate()
        setNavigationBar()
        setupSearchController()
    }
    
    private func setupView(){
        view.addSubview(tableView)
    }
    
    private func setupDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setNavigationBar() {
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.title = "List of Citis"
        navigationItem.searchController = searchController
  
        let userInfoButton = createCustomButton(selector: #selector(AddCityByALert))
        navigationItem.rightBarButtonItem = userInfoButton
    }
    
    private func setupSearchController() {
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search"
        searchController.obscuresBackgroundDuringPresentation = false
    }
    
    @objc private func AddCityByALert(){
        alertCity(name: "City", placeHolder: "Add a new city ") { city in
            self.nameCityArray.append(city)
            self.cityArray.append(self.emptyCity)
            self.addCities()
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
        } else{
            return cityArray.count
        }
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
}

//MARK: - TableView Delegate

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
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailView()
        
        if isFiltering {
            let filterCity = filterCityArray[indexPath.row]
            detailVC.weatherM = filterCity
        }
        else{
            let city = cityArray[indexPath.row]
            detailVC.weatherM = city
        }
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

//MARK: - Searching by Filter

extension ListTVC: UISearchResultsUpdating  {
    
    func updateSearchResults(for searchController: UISearchController) {
        filteredContextForSearch(searchController.searchBar.text!)
    }
    
    func filteredContextForSearch(_ searchText: String){
        
        filterCityArray = searchText.isEmpty ? cityArray : cityArray.filter {
            $0.name.contains(searchText)
        }
        tableView.reloadData()
    }
}

//MARK: - Set Constraints

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

























//class ListTVC:  UITableViewController,UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
//
//    internal var tableView : UITableView = {
//        let tableView = UITableView()
//        tableView.backgroundColor = .white
//        tableView.register(ListCell.self, forCellReuseIdentifier: "cell")
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        return tableView
//    }()
//
//
//    let emptyCity = Weather()
//    var cityArray = [Weather]()
//    var filterCityArray = [Weather]()
//
//    var nameCityArray = ["Moscow", "Novosibirsk","Kazan", "Doha","Paris","Berlin","London","Tashkent","Seoul","Namangan", "Kosonsoy"]
//
//    let searchController = UISearchController(searchResultsController: nil)
//
//    var searchBarIsEmpty : Bool {
//        guard let text = searchController.searchBar.text else {return false}
//        return text.isEmpty
//    }
//
//    var isFiltering: Bool {
//        searchController.isActive && !searchBarIsEmpty
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        if cityArray.isEmpty{
//            cityArray = Array(repeating: emptyCity, count: nameCityArray.count)
//        }
//
//        addCities()
//        setupView()
//        setConstraints()
//        setupDelegate()
//        setNavigationBar()
//
//    }
//
//
//    private func setupView(){
//
//        view.addSubview(tableView)
//    }
//
//    private func setupDelegate() {
//        tableView.delegate = self
//        tableView.dataSource = self
//
//        searchController.searchBar.delegate = self
//    }
//
//    private func setNavigationBar() {
//        navigationItem.title = "Albums"
//
//        navigationItem.searchController = searchController
//
//        let userInfoButton = createCustomButton(selector: #selector(AddCityByALert))
//        navigationItem.rightBarButtonItem = userInfoButton
//    }
//
//    @objc private func AddCityByALert(){
//        alertCity(name: "City", placeHolder: "Add a new city ") { city in
//            self.nameCityArray.append(city)
//            self.cityArray.append(self.emptyCity)
//            self.addCities()
//          //  self.tableView.reloadData()
//        }
//    }
//
//
//
//    func addCities(){
//
//        getWeather(cityArray: self.nameCityArray) { index, weather in
//            self.cityArray[index] = weather
//            self.cityArray[index].name = self.nameCityArray[index]
//
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
//        }
//    }
//
//
//
//    // MARK: - Table view data source
//
////extension ListTVC : UITableViewDataSource {
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if isFiltering {
//            return filterCityArray.count
//        }
//        return cityArray.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! ListCell
//        var weather = Weather()
//
//        if isFiltering {
//            weather = filterCityArray[indexPath.row]
//        }else{
//            weather = cityArray[indexPath.row]
//        }
//        print(weather)
//        cell.configure(weather: weather)
//
//        return cell
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "showDetail" {
//            guard let indexPath = tableView.indexPathForSelectedRow else {return}
//
//            if isFiltering {
//                let filter = filterCityArray[indexPath.row]
//                let destination = segue.destination as! DetailView
//                destination.weatherM = filter
//            }
//            else{
//                let wData = cityArray[indexPath.row]
//                let destination = segue.destination as! DetailView
//                destination.weatherM = wData
//            }
//        }
//    }
////}
//
////extension ListTVC: UITableViewDelegate {
//
//    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//
//        let delete = UIContextualAction(style: .destructive, title: "Delete") { _ , _ , completion in
//
//            let editingRow = self.nameCityArray[indexPath.row]
//
//            if let index = self.nameCityArray.firstIndex(of: editingRow){
//                if self.isFiltering {
//                    self.filterCityArray.remove(at: index)
//                }
//                else{
//                    self.cityArray.remove(at: index)
//                }
//            }
//            tableView.reloadData()
//        }
//        return UISwipeActionsConfiguration(actions: [delete])
//    }
//
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        70
//    }
//
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let detailVC = DetailView()
//
//        if isFiltering {
//            let filter = filterCityArray[indexPath.row]
//            detailVC.weatherM = filter
//        }
//        else{
//            let wData = cityArray[indexPath.row]
//            detailVC.weatherM = wData
//        }
//
//        navigationController?.pushViewController(detailVC, animated: true)
//    }
//}
////}
//
////place
//
//
//extension ListTVC: UISearchResultsUpdating {
//
//    func updateSearchResults(for searchController: UISearchController) {
//        filteredContextForSearch(searchController.searchBar.text!)
//    }
//
//    func filteredContextForSearch(_ searchText: String){
//
//        filterCityArray = cityArray.filter({ filter in
//            filter.name.contains(searchText)
//        })
//
//        tableView.reloadData()
//    }
//}
//
//extension ListTVC {
//    private func setConstraints() {
//
//        NSLayoutConstraint.activate([
//            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
//            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
//            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
//            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
//        ])
//    }
//}

//
//
//class ListTVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
//
//    private let myArray: NSArray = ["First","Second","Third"]
//    private var myTableView: UITableView!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
//        let displayWidth: CGFloat = self.view.frame.width
//        let displayHeight: CGFloat = self.view.frame.height
//
//        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - barHeight))
//        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
//        myTableView.dataSource = self
//        myTableView.delegate = self
//        self.view.addSubview(myTableView)
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("Num: \(indexPath.row)")
//        print("Value: \(myArray[indexPath.row])")
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return myArray.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
//        cell.textLabel!.text = "\(myArray[indexPath.row])"
//        return cell
//    }
//}
