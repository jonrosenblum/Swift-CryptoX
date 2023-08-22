//
//  HomeViewModel.swift
//  SwiftCryptoX
//
//  Created by Jon Rosenblum on 8/22/23.
//

import Foundation
import Combine

// ViewModel class responsible for managing data and behavior of the home view
class HomeViewModel: ObservableObject {
    
    // Published properties to hold coin data
    @Published var allCoins: [CoinModel] = [] // Holds all fetched coin data
    @Published var portfolioCoins: [CoinModel] = [] // Holds coin data for the user's portfolio
    
    // CoinDataService instance to handle data fetching
    private let dataService = CoinDataService()
    
    // Set to hold cancellables for Combine subscribers
    private var cancellables = Set<AnyCancellable>()
    
    // Initializer
    init() {
        addSubscribers() // Set up subscribers when the class is initialized
    }
    
    // Method to set up subscribers for data updates
    func addSubscribers() {
        
        // Subscribe to changes in allCoins property of dataService
        dataService.$allCoins
            .sink { [weak self] (returnedCoins) in
                // Update the allCoins property with fetched coin data
                self?.allCoins = returnedCoins
            }
            .store(in: &cancellables) // Store the cancellable in the set
    }
}
