//
//  TableViewController.swift
//  KinoAfisha
//
//  Created by Adakhanau on 19/06/2019.
//  Copyright © 2019 Adakhan. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    
    var Afishas: [Result] = []
    var kinoAfishas = KinoAfishaModel()
    var currentMovie = Result()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    
    
    func loadData() {
        ServerManager.shared.loadKinoAfishas(completion: updateUI)
    }
    
    func updateUI(information: KinoAfishaModel) {
        kinoAfishas = information
        self.Afishas = information.result!
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
        currentMovie = kinoAfishas.result![indexPath.row]
        
        performSegue(withIdentifier: "detailedSegue", sender: self)
    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detailedSegue" {
            let KinoTableViewController = segue.destination as! KinoTableViewController
            KinoTableViewController.movie = currentMovie
            
        }
    }
    
    
}
