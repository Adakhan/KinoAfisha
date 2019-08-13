//
//  TableViewController.swift
//  KinoAfisha
//
//  Created by Adakhanau on 19/06/2019.
//  Copyright © 2019 Adakhan. All rights reserved.
//

import UIKit

class MainVC: UITableViewController {
    
    var afishas: [Result] = []
    var currentMovie = Result()
    var fetchingMore = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        let loadingNib = UINib(nibName: "LoadingCell", bundle: nil)
        tableView.register(loadingNib, forCellReuseIdentifier: "loadingCell")
    }
    
    func loadData() {
        ServerManager.shared.loadKinoAfishas(completion: updateUI)
    }
    
    func updateUI(information: KinoAfishaModel) {
        self.afishas = information.result!
        self.tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return afishas.count
        } else if section == 0 && fetchingMore {
            return 1
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "loadingCell", for: indexPath) as! LoadingCell
            cell.spinner.startAnimating()
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel!.text = afishas[indexPath.row].name
            
            return cell
        }

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        currentMovie = afishas[indexPath.row]
        performSegue(withIdentifier: "detailedSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailedSegue" {
            let movieViewController = segue.destination as! MovieVC
            movieViewController.movie = currentMovie
        }
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        let offsetY = scrollView.contentOffset.y
        if offsetY < -90.0 {
            if !fetchingMore {
                beginFetch()
            }
        }
        
    }
    
    func beginFetch() {
        fetchingMore = true
        tableView.reloadSections(IndexSet(integer: 0), with: .none)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.45, execute: {
            self.loadData()
            self.tableView.reloadData()
            self.fetchingMore = false
        })
        
    }

}
