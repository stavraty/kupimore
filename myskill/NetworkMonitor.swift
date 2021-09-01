//
//  NetworkMonitor.swift
//  myskill
//
//  Created by AS on 01.09.2021.
//  Copyright © 2021 PRIVATE CAPACITY LTD. All rights reserved.
//

import Foundation
import Network

final class NetworkMonitor: ObservableObject {
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Monitor")

    @Published var isConnected = true
    
    init() {
        monitor.pathUpdateHandler = {path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied ? true : false
            }
        }
        monitor.start(queue: queue)
    }
}
