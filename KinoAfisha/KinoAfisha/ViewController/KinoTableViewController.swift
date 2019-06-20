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
    
    
    var kinoName = String()
    var country = String()
    
    var date = String()
    var rating = String()
    
    var ageLimit = String()
    var poster = String()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kinoNameLabel.text = kinoName
        countryLabel.text = country
        
        dateLabel.text = dateLabel.text! + date
        ratingLabel.text = ratingLabel.text! + rating
        
        ageLimitLabel.text = ageLimitLabel.text! + ageLimit
        posterImageView.image = getImageFromURL()
    }
    
    func getImageFromURL() -> UIImage {
        let urlString = ServerManager.shared.mainUrl
        let imageUrlString = "\(urlString)\(poster)"
        
        let imageUrl = URL(string: imageUrlString)!
        let imageData = try! Data(contentsOf: imageUrl)
        
        let image = UIImage(data: imageData)!

        return image
    }
}
