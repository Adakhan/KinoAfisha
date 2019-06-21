//
//  ServerManager.swift
//  KinoAfisha
//
//  Created by Adakhanau on 19/06/2019.
//  Copyright © 2019 Adakhan. All rights reserved.
//

import Foundation
import Alamofire

class ServerManager {

    static let shared = ServerManager()

    let mainUrl = "https://kinoafisha.ua"
    private let jsonUrl = "/ajax/kinoafisha_load"

    func loadKinoAfishas(completion: @escaping (KinoAfishaModel) -> Void ) {

        let jsonUrlString = "\(mainUrl)\(jsonUrl)"
        guard let url = URL(string: jsonUrlString) else { return }

        Alamofire.request(url).validate().responseJSON { (response) in
            let result = response.data

            do {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .secondsSince1970
                let informaion = try decoder.decode(KinoAfishaModel.self, from: result!)

                DispatchQueue.main.async {
                    completion(informaion)
                }
            } catch let jsonErr {
                print("Error serializing json:", jsonErr)
            }
        }

    }
}
