//
//  ViewController.swift
//  Demo Board
//
//  Created by Michael Redig on 7/9/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

import Cocoa
import SpriteKit
import GameplayKit

class ViewController: NSViewController {

    @IBOutlet var skView: SKView!
	var scene: GameScene?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let view = self.skView {
            // Load the SKScene from 'GameScene.sks'
            let scene = GameScene(size: view.frame.size)
			self.scene = scene
			// Set the scale mode to scale to fit the window
			scene.scaleMode = .aspectFill

			// Present the scene
			view.presentScene(scene)

            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

//	func temp() {
//		let vc = storyboard?.instantiateController(withIdentifier: "id")
//	}

	override func viewDidLayout() {
		super.viewDidLayout()

		scene?.size = view.frame.size
	}
}

