import SceneKit
import ARKit

extension ViewController: ARSCNViewDelegate {

    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        //TODO add model to anchor
        if !anchor.isKind(of: ARPlaneAnchor.self) {
            
//            let box = SCNBox()
//            box.height = 50
//            box.width = 50
//            let node = SCNNode(geometry: box)
            
            // using helper function by Berta
            guard let scene = SCNScene(named: "art.scnassets/new.scn"), let node2 = scene.rootNode.childNode(withName: "text", recursively: true) else {
                return
            }
            node.addChildNode(node2)
        }
    }
    
}
