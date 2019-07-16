//
//  LabelController.swift
//  Demo Board
//
//  Created by Michael Redig on 7/16/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

import SpriteKit

class LabelController {
	private(set) var labels = [SKLabelNode]()

	private let maxHeight: CGFloat
	private let startOffset: CGFloat
	private let iterationOffset: CGFloat

	init(maxHeight: CGFloat, startOffset: CGFloat, iterationOffset: CGFloat) {
		self.maxHeight = maxHeight
		self.startOffset = startOffset
		self.iterationOffset = iterationOffset
	}

	func create(at location: CGPoint? = nil) -> SKLabelNode {

		let yOffset = maxHeight - startOffset - iterationOffset * CGFloat(labels.count + 1)

		let label = SKLabelNode(fontNamed: "Courier")
		label.fontSize = 16
		label.fontColor = .black
		label.horizontalAlignmentMode = .left
		label.verticalAlignmentMode = .baseline
		label.text = ""
		if let location = location {
			label.position = location
		} else {
			label.position = CGPoint(x: 20, y: yOffset)
		}

		labels.append(label)
		return label
	}

	func currentLabel() -> SKLabelNode? {
		return labels.last
	}
}
