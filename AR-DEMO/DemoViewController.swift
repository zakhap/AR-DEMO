//
//  DemoViewController.swift
//  AR-DEMO
//
//  Created by _hap on 12/12/18.
//  Copyright © 2018 Zak Hap. All rights reserved.
//

import ARKit

class DemoViewController: UIViewController, ARSCNViewDelegate {
    
    
    let arView: ARSCNView = {
       let view = ARSCNView()
        view.translatesAutoresizingMaskIntoConstraints = false //makes phone load properly...
        return view
    }() // Instantiate an AR SceneKit View
    
    //button to add object!
    var addButton: UIButton = {
        var button = UIButton(type: .system)

        //button.setImage(UIimage(named: "PlusButton"), for: .normal)
        button.setImage(UIImage(named: "PlusButton.png")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.tintColor = UIColor(white: 1.0, alpha: 0.7)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleAddButtonTapped), for: .touchUpInside)
        return button
    }()
    
    @objc func handleAddButtonTapped() {
        print("Tapped!")
        addAsset()
    }
    
    
    //AR Tracking Configuration
    let configuration = ARWorldTrackingConfiguration()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        
        
        configuration.planeDetection = .horizontal
        arView.session.run(configuration, options: []) // add options at later point if desired.
        
        //debug options
        arView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        
        //lighting
        arView.autoenablesDefaultLighting = true
        
        //delegation
        arView.delegate = self
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func setupViews() {
        // contrain SceneKit View to Device Height+Width
        view.addSubview(arView)
        arView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        arView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        arView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        arView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        
        // plus button
        view.addSubview(addButton)
        addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        addButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        addButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        addButton.heightAnchor.constraint(equalToConstant: 80).isActive = true

    }
    
    
    func addAsset() {

        //planeVector3 =
        for i in 1...10 {
            let boxNode = SCNNode()
            //var a = (Double(i)*0.1)
            boxNode.geometry = SCNBox(width: 0.02, height: CGFloat(0.1*Double(i)), length: 0.02, chamferRadius: 0.5)
            boxNode.geometry?.firstMaterial?.diffuse.contents = UIColor.red
            boxNode.position = SCNVector3(Double((0-i))*0.2, 0.0, 0.0)
            arView.scene.rootNode.addChildNode(boxNode)
        }

    }
    
   
    
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let anchorPlane = anchor as? ARPlaneAnchor else { return }
        print("new plane anchor found at ", anchorPlane.extent )
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        //var planeVector3: SCNVector3?

        guard let anchorPlane = anchor as? ARPlaneAnchor else { return }
        print("new plane anchor updated at ", anchorPlane.extent )
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didRemove node: SCNNode, for anchor: ARAnchor) {
        guard let anchorPlane = anchor as? ARPlaneAnchor else { return }
        print("new plane anchor removed at ", anchorPlane.extent )
    }
}
