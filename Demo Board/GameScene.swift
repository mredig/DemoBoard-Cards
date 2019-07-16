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

	var cards: [NoteCard] = []

    override func didMove(to view: SKView) {

    }
    
    
    func touchDown(atPoint pos : CGPoint) {
		let newCardSize = CGSize(width: 400, height: 300)
		let newCard = NoteCard(size: newCardSize, selectHandler: self)
		addChild(newCard)
		let newPos = CGPoint(x: pos.x - newCardSize.width / 2, y: pos.y - newCardSize.height / 2)
		newCard.position = newPos
		cards.append(newCard)
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
//        switch event.keyCode {
//
//        default:
//            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
//        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

protocol ItemSelectHandler: AnyObject {
	func deselectAll()
}


extension GameScene: ItemSelectHandler {
	func deselectAll() {
		for card in cards {
			card.selected = false
		}
	}
}


