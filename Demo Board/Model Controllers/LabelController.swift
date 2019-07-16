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

	private var _currentLabel: SKLabelNode?
	var currentLabel: SKLabelNode? {
		get {
			return _currentLabel ?? labels.last
		}

		set {
			labels.forEach { $0.fontColor = .black }
			_currentLabel = newValue
			_currentLabel?.fontColor = .gray
		}
	}

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
		setCurrentLabel(label)
		return label
	}

	func remove(label: SKLabelNode) {
		guard let index = labels.firstIndex(of: label) else { return }
		labels.remove(at: index)
		if currentLabel == label {
			currentLabel = labels.last
		}
	}

	func setCurrentLabel(_ label: SKLabelNode) {
		if labels.contains(label) {
			currentLabel = label
		}
	}
}
