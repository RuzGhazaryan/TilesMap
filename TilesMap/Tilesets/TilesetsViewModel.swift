//
//  TilesetsViewModel.swift
//  TilesMap
//
//  Created by Ruzanna Ghazaryan on 2/6/21.
//

import Foundation
import NetworkLayer

class TilesetsViewModel: NSObject  {
    var bind : ((_ success: Bool) -> ()) = { _ in }

    private(set) var farmData : Farm!
    
    override init() {
        super.init()
        self.fetchFarmData()
    }
    
    private func fetchFarmData() {
        let request = GetTilesetsRequest()
        ApiClient.shared.execute(request: request) { [weak self] (request, response) in
            switch response {
            case .found(let farm):
                self?.farmData = farm
                self?.bind(true)
            default:
                self?.bind(false)
            }
        }
    }
}
