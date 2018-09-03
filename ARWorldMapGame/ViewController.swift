//
//  ViewController.swift
//  ARWorldMapGame
//
//  Created by Berta Devant on 02/09/2018.
//  Copyright © 2018 Berta Devant. All rights reserved.
//

import UIKit
import SceneKit
import ARKit
import MultipeerConnectivity

class ViewController: UIViewController {

    @IBOutlet weak var sessionInfoView: UIView!
    @IBOutlet weak var sessionInfoLabel: UILabel!
    @IBOutlet weak var sceneView: ARSCNView!
    @IBOutlet weak var sendMapButton: UIButton!
    @IBOutlet weak var mappingStatusLabel: UILabel!

    // MARK: - View Life Cycle
    var multipeerSession: MultipeerSession!
    //to remember who provided the map (device) and show it to the UI
    var mapProvider: MCPeerID?

    //Configuration for the Nodes created
    var nodeConfiguration: NodeConfiguration!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //
        //
        // multipeerSession = MultipeerSession(receivedDataHandler: receivedData)
        nodeConfiguration = NodeConfiguration(name: "star",
                                              color: UIColor.random(),
                                              owner: MCPeerID(displayName: UIDevice.current.name))
        sceneView.delegate = self
        sceneView.debugOptions = [.showFeaturePoints, .showWorldOrigin]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        configuration.planeDetection = .horizontal
        
        // Run the view's session
        sceneView.session.run(configuration)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneView.session.pause()
    }

    // Code added during workshops
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let location = touches.first?.location(in: sceneView) else {
            return
        }
        
        let hitResultsFeaturePoints: [ARHitTestResult] = sceneView.hitTest(location, types: [.estimatedHorizontalPlane])
        
        guard let firstPoint = hitResultsFeaturePoints.first else {
            return
        }
        
//        guard let anchor = firstPoint.anchor else {
//            return
//        }
        
        let anchor = firstPoint.anchor ?? ARAnchor(transform: firstPoint.worldTransform)
        
        sceneView.session.add(anchor: anchor)
    }
    
    
    // MARK: - Multiuser shared session

    /// - Tag: ReceiveData
    func receivedData(_ data: Data, from peer: MCPeerID) {
        //TODO process data

    }

    /// - Tag: PlaceCharacter
    @IBAction func handleSceneTap(_ sender: UITapGestureRecognizer) {
        //Add new node to scene and send the new node to the other peers
    }

    // MARK: - ARSession

    /// - Tag: CheckMappingStatus
//    func session(_ session: ARSession, didUpdate frame: ARFrame) {
//        //TODO update labels and button when map is provided
//    }

    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        switch frame.worldMappingStatus {
        case .notAvailable, .limited:
            sendMapButton.isEnabled = false
        case .extending:
            sendMapButton.isEnabled = !multipeerSession.connectedPeers.isEmpty
        case .mapped:
            sendMapButton.isEnabled = !multipeerSession.connectedPeers.isEmpty
        }
        mappingStatusLabel.text = frame.worldMappingStatus.description
        updateSessionInfoLabel(for: frame, trackingState: frame.camera.trackingState)
    }
    
    /// - Tag: GetWorldMap
    @IBAction func shareSession(_ button: UIButton) {

    }
}
