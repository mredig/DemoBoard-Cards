//
//  GameScene.swift
//  Demo Board
//
//  Created by Michael Redig on 7/9/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {

	let cardController = CardController()

    override func didMove(to view: SKView) {

    }
    
    
    func touchDown(atPoint pos : CGPoint) {
		let newCard = cardController.create(at: pos)
		addChild(newCard)
    }
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
    
    override func mouseDown(with event: NSEvent) {
        self.touchDown(atPoint: event.location(in: self))
    }
    
    override func mouseDragged(with event: NSEvent) {
        self.touchMoved(toPoint: event.location(in: self))
    }
    
    override func mouseUp(with event: NSEvent) {
        self.touchUp(atPoint: event.location(in: self))
    }
    
	override func keyDown(with event: NSEvent) {
		// keycode 51 is backspace, 36 is return
		switch event.keyCode {
		case 51:
			//backspace pressed
			return
		case 36:
			// return pressed
			return
		default:
			break
		}

		guard let character = event.characters?.first else { return }
		print(character)

//		cardController.selectedCard().
	}
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

