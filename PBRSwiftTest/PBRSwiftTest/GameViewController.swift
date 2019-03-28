//
//  GameViewController.swift
//  PBRSwiftTest
//
//  Created by Wayne Dahlberg on 3/28/19.
//  Copyright © 2019 Floppy Hat, LLC. All rights reserved.
//

import UIKit
import QuartzCore
import SceneKit

class GameViewController: UIViewController {
  
  let materialPrefixes: [String] = ["bamboo-wood-semigloss",
                                    "oakfloor2",
                                    "scuffed-plastic",
                                    "rustediron-streaks",
                                    "hardwood-brown",
                                    "sandstone-blocks"]
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // create a new scene
    let scene = SCNScene(named: "sphere.obj")!
    
    // create a sphere object
    let sphereNode = scene.rootNode.childNodes[0]
    
    // create + position camera
    let cameraNode = SCNNode()
    cameraNode.camera = SCNCamera()
    scene.rootNode.addChildNode(cameraNode)
    cameraNode.position = SCNVector3(0, 0, 25)
    
    // add environment lighting
    let environment = UIImage(named: "theater.png")
    scene.lightingEnvironment.contents = environment
    scene.lightingEnvironment.intensity = 2.0
    
    // add spherical background
    let background = UIImage(named: "theater-blur.jpg")
    scene.background.contents = background
    
    // setup the material
    let material = sphereNode.geometry?.firstMaterial
    
    // setup PBR shading mode
    material?.lightingModel = SCNMaterial.LightingModel.physicallyBased
    
    // setup material maps for object
    let materialFilePrefix = materialPrefixes[1]
    material?.diffuse.contents = UIImage(named: "\(materialFilePrefix)-albedo.png")
    material?.roughness.contents = UIImage(named: "\(materialFilePrefix)-roughness.png")
    material?.metalness.contents = UIImage(named: "\(materialFilePrefix)-metal.png")
    material?.normal.contents = UIImage(named: "\(materialFilePrefix)-normal.png")
    
    // setup background (blurred image, added for aesthetics, does not influence rendering)
    let env = UIImage(named: "theater.png")
    scene.lightingEnvironment.contents = env
    scene.lightingEnvironment.intensity = 2.0
    
    // retrieve the SCNView
    let scnView = self.view as! SCNView
    
    // assign scene to view
    scnView.scene = scene
    
    // allow camera manipulation
    scnView.allowsCameraControl = true
    
    // add rotation animation
    sphereNode.runAction(SCNAction.repeatForever(SCNAction.rotateBy(x: 1, y: 1, z: 1, duration: 10)))
  }
  
  
  
  override var shouldAutorotate: Bool {
    return true
  }
  
  override var prefersStatusBarHidden: Bool {
    return true
  }
  
  override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
    if UIDevice.current.userInterfaceIdiom == .phone {
      return .allButUpsideDown
    } else {
      return .all
    }
  }
  
}
