//
//  DataStructures.swift
//  ARWorldMapGame
//
//  Created by Berta Devant on 02/09/2018.
//  Copyright © 2018 Berta Devant. All rights reserved.
//

import Foundation
import MultipeerConnectivity

enum NodeStatus {
    case added
    case deleted
}

struct NodeConfiguration {
    let name: String
    let color: UIColor
    let owner: MCPeerID
}
