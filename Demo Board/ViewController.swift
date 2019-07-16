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

	@IBOutlet var toolsBackground: NSView!
	@IBOutlet var newCardButton: NSButton!
	@IBOutlet var deleteCardButton: NSButton!

    @IBOutlet var skView: SKView!
	var scene: CorkBoardScene?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let view = self.skView {
            // Load the SKScene from 'GameScene.sks'
            let scene = CorkBoardScene(size: view.frame.size)
			self.scene = scene
			// Set the scale mode to scale to fit the window
			scene.scaleMode = .aspectFill

			// Present the scene
			view.presentScene(scene)

            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }

		toolsBackground.layer = CALayer()
		toolsBackground.layer?.backgroundColor = .init(gray: 0.3, alpha: 0.8)
    }

	override func viewDidLayout() {
		super.viewDidLayout()

		scene?.size = view.frame.size
	}

	@IBAction func newCardButtonPressed(_ sender: NSButton) {
		scene?.createNewCard()
	}

	@IBAction func deleteCardButtonPressed(_ sender: NSButton) {

		let alert = NSAlert()
		alert.messageText = "Are you sure you wish to delete this card?"
		alert.messageText = "There is no undoing this operation! Be certain you wish to proceed!"
		alert.addButton(withTitle: "Yes, Delete")
		alert.addButton(withTitle: "Nvm... Don't delete it!")

		guard let window = NSApp.windows.first else { return }
		alert.beginSheetModal(for: window) { (response) in
			if response == .alertFirstButtonReturn {
				self.scene?.deleteSelectedCard()
			}
		}
	}
	
}

