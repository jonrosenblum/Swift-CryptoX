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
        coinSubscription = URLSession.shared.dataTaskPublisher(for: url)
            .subscribe(on: DispatchQueue.global(qos: .default)) // Perform the task on a background queue
            .tryMap { (output) -> Data in
                // Check the HTTP response for errors
                guard let response = output.response as? HTTPURLResponse,
                      response.statusCode >= 200 && response.statusCode < 300 else {
                    throw URLError(.badServerResponse)
                }
                // If no errors, return the data
                return output.data
            }
            .receive(on: DispatchQueue.main) // Switch back to the main queue for further processing
            .decode(type: [CoinModel].self, decoder: JSONDecoder()) // Decode the JSON data into an array of CoinModel objects
            .sink { (completion) in
                switch completion {
                case .finished:
                    break // Subscription completed successfully
                case .failure(let error):
                    print(error.localizedDescription) // Print any error that occurred
                }
            } receiveValue: { [weak self] (returnedCoins) in
                // Update the allCoins array with the fetched data and cancel the subscription
                self?.allCoins = returnedCoins
                self?.coinSubscription?.cancel()
            }
    }
}
