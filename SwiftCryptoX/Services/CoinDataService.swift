//
//  File.swift
//  SwiftCryptoX
//
//  Created by Jon Rosenblum on 8/22/23.
//

import Combine
import Foundation

// A class to manage the fetching and storage of coin data
class CoinDataService {
    
    // An array to hold all the fetched coin data models
    @Published var allCoins: [CoinModel] = []
    
    // A subscription to manage the network request
    var coinSubscription: AnyCancellable?
    
    // Initializer
    init() {
        // Fetch coins when the class is initialized
        getCoins()
    }
    
    // Private method to fetch coin data
    private func getCoins() {
        
        // API endpoint URL for fetching coin data
        guard let url = URL(string: "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else {
            return
        }
        
        // Initiate a data task publisher for the URL
        coinSubscription = NetworkingManager.download(url: url)
            .decode(type: [CoinModel].self, decoder: JSONDecoder()) // Decode the JSON data into an array of CoinModel objects
            .sink(receiveCompletion: NetworkingManager.handleCompletion, receiveValue: { [weak self] (returnedCoins) in
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            })

    }
}
