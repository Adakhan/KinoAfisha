//
//  KinoTableViewController.swift
//  KinoAfisha
//
//  Created by Adakhanau on 19/06/2019.
//  Copyright © 2019 Adakhan. All rights reserved.
//

import UIKit

class KinoTableViewController: UITableViewController {

    @IBOutlet weak var kinoNameLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var ageLimitLabel: UILabel!
    @IBOutlet weak var posterImageView: UIImageView!
    
    
    var movie = Result()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kinoNameLabel.text = movie.name
        countryLabel.text = movie.countries
        
        dateLabel.text = dateLabel.text! + (movie.premier_ua ?? "")
        ratingLabel.text = ratingLabel.text! + (movie.vote ?? "")
        
        ageLimitLabel.text = ageLimitLabel.text! + (movie.age_limit ?? "0")
        posterImageView.image = getImageFromURL()
    }
    
    func getImageFromURL() -> UIImage {
        let urlString = ServerManager.shared.mainUrl
        let imageUrlString = "\(urlString)\(movie.image ?? "")"
        
        let imageUrl = URL(string: imageUrlString)!
        let imageData = try! Data(contentsOf: imageUrl)
        
        let image = UIImage(data: imageData)!

        return image
    }
}
