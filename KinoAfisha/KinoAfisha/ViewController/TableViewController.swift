//
//  TableViewController.swift
//  KinoAfisha
//
//  Created by Adakhanau on 19/06/2019.
//  Copyright © 2019 Adakhan. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {

    
    var filteredList: [Result] = []
    var Afishas: [Result] = []
    var kinoAfishas = KinoAfishaModel()
    
    
    var currentKinoName = String()
    var currentCountry = String()
    
    var currentDate = String()
    var currentRating = String()
    
    var currentAgeLimit = String()
    var currentPoster = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    
    
    
    func loadData() {
        ServerManager.shared.loadKinoAfishas(completion: updateUI)
    }
    
    func updateUI(information: KinoAfishaModel) {
        
        kinoAfishas = information
        self.Afishas = kinoAfishas.result!
        self.tableView.reloadData()
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return Afishas.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel!.text = kinoAfishas.result![indexPath.row].name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var currentRow = kinoAfishas.result![indexPath.row]
        
        currentRating = currentRow.vote!
        currentKinoName = currentRow.name!
        
        currentDate = currentRow.premier_ua!
        currentCountry = currentRow.countries!
        
        if currentRow.age_limit == nil {
            currentRow.age_limit = "0"
        }
        
        currentAgeLimit = currentRow.age_limit!
        currentPoster = currentRow.image!
        
        performSegue(withIdentifier: "detailedSegue", sender: self)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailedSegue" {
            let KinoTableViewController = segue.destination as! KinoTableViewController
            
            KinoTableViewController.ageLimit = currentAgeLimit
            KinoTableViewController.country = currentCountry
            
            KinoTableViewController.date = currentDate
            KinoTableViewController.kinoName = currentKinoName
            
            KinoTableViewController.rating = currentRating
            KinoTableViewController.poster = currentPoster
        }
    }
    
    
}
