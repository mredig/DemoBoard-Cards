//
//  TileController.swift
//  Demo Board
//
//  Created by Michael Redig on 7/16/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

import SpriteKit

class TileController {
	private(set) var tiles: [SKSpriteNode] = []

	var unparentedTiles: [SKSpriteNode] {
		return tiles.filter { $0.parent == nil }
	}

	func layout(for size: CGSize) {
		let texture = SKTexture(imageNamed: "background")
		let xTiles = Int(size.width / texture.size().width) + 1
		let yTiles = Int(size.height / texture.size().height) + 1

		let tilesNeeded = xTiles * yTiles
		while tiles.count < tilesNeeded {
			let tile = SKSpriteNode(texture: texture)
			tile.anchorPoint = CGPoint.zero
			tile.zPosition = -1
			tiles.append(tile)
		}

		while tiles.count > tilesNeeded {
			tiles.last?.removeFromParent()
			tiles.removeLast()
		}


		for yTile in 0..<yTiles {
			for xTile in 0..<xTiles {
				let index = xTile + (yTile * xTiles)
				tiles[index].position = CGPoint(x: texture.size().width * CGFloat(xTile), y: texture.size().height * CGFloat(yTile))
			}
		}
	}
}
