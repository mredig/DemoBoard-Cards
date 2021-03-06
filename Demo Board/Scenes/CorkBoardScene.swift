//
//  CorkBoardScene.swift
//  Demo Board
//
//  Created by Michael Redig on 7/9/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

import SpriteKit
import GameplayKit

class CorkBoardScene: SKScene {

	let cardController = CardController()
	let tileController = TileController()

    override func didMove(to view: SKView) {
		tileController.layout(for: view.frame.size)
		tileController.unparentedTiles.forEach { addChild($0) }
    }

	override func didChangeSize(_ oldSize: CGSize) {
		super.didChangeSize(oldSize)
		guard let view = view else { return }
		tileController.layout(for: view.frame.size)
		tileController.unparentedTiles.forEach { addChild($0) }
	}
    
    
	func createNewCard() {
		let midPoint = CGPoint(x: frame.midX, y: frame.midY)
		let newCard = cardController.create(at: midPoint)
		newCard.select()
		addChild(newCard)
	}

	func deleteSelectedCard() {
		guard let selectedCard = cardController.selectedCard() else { return }
		removeChildren(in: [selectedCard])
		cardController.delete(card: selectedCard)
	}
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}

// MARK: - Input
extension CorkBoardScene {
	func touchDown(atPoint pos : CGPoint) {

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
			cardController.selectedCard()?.deleteCharacter()
			return
		case 36:
			// return pressed
			cardController.selectedCard()?.newline()
			return
		default:
			break
		}

		guard let character = event.characters?.first else { return }
		cardController.selectedCard()?.appendCharacter(character)
	}
}
