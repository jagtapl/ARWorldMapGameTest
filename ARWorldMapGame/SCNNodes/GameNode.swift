//
//  GameNode.swift
//  ARWorldMapGame
//
//  Created by Berta Devant on 02/09/2018.
//  Copyright © 2018 Berta Devant. All rights reserved.
//

import ARKit
import SceneKit

class GameNode: SCNNode {

    private var nodeStatus: NodeStatus?
    let configuration: NodeConfiguration

    init(nodeConfiguration: NodeConfiguration) {
        self.configuration = nodeConfiguration
        super.init()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
