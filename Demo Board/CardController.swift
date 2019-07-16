//
//  CardController.swift
//  Demo Board
//
//  Created by Michael Redig on 7/16/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

import SpriteKit

class CardController {
	private(set) var cards: [NoteCard] = []

	func create(at location: CGPoint) -> NoteCard {
		let newCardSize = CGSize(width: 400, height: 300)
		let newCard = NoteCard(size: newCardSize, selectHandler: self)
		let newPos = CGPoint(x: location.x - newCardSize.width / 2, y: location.y - newCardSize.height / 2)
		newCard.position = newPos
		cards.append(newCard)
		return newCard
	}

	func selectedCard() -> NoteCard? {
		guard let index = cards.firstIndex(where: { return $0.selected }) else { return nil }
		return cards[index]
	}

	func delete(card: NoteCard) {
		guard let index = cards.firstIndex(of: card) else { return }
		cards.remove(at: index)
	}
}


protocol ItemSelectHandler: AnyObject {
	func deselectAll()
}


extension CardController: ItemSelectHandler {
	func deselectAll() {
		for card in cards {
			card.selected = false
		}
	}
}

