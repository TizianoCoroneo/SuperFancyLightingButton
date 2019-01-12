//
//  ViewController.swift
//  SuperFancyLightingButton
//
//  Created by Tiziano Coroneo on 11/01/2019.
//  Copyright © 2019 Tiziano Coroneo. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController {

    @IBOutlet var sceneView: ARSCNView!

    private lazy var buttonNode =
        SCNScene(named: "Button.scn")!.rootNode
            .childNode(
                withName: "Container",
                recursively: false)!

    private var configuration: ARWorldTrackingConfiguration!

    override func viewDidLoad() {
        super.viewDidLoad()

        startARKit()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        sceneView.automaticallyUpdatesLighting = true
        sceneView.session.run(configuration)

        guard let pov = sceneView
            .defaultCameraController
            .pointOfView
            else { return }

        let newCopy = buttonNode.flattenedClone()

        pov.addChildNode(newCopy)
        newCopy.simdPosition = simd_float3(0, 0, -3)
        newCopy.simdScale = simd_float3(1, 1, 1)

        sceneView.backgroundColor = UIColor.clear
        sceneView.scene.background.contents = UIColor.clear
    }

    func startARKit() {
        configuration = ARWorldTrackingConfiguration()
        // Enable automatic environment texturing
        configuration.environmentTexturing = .automatic
        configuration.isAutoFocusEnabled = false
    }
}

