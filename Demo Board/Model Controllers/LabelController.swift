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
//	private let iterationOffset: CGFloat
	private let baseFontSize: CGFloat

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

	init(maxHeight: CGFloat, startOffset: CGFloat, baseFontSize: CGFloat = 16) {
		self.maxHeight = maxHeight
		self.startOffset = startOffset
		self.baseFontSize = baseFontSize
	}

	private func layoutLabels() {
		for (index, label) in labels.enumerated() {
			if index == 0 {
				label.fontSize = baseFontSize * 2
			} else {
				label.fontSize = baseFontSize
			}
			label.position = CGPoint(x: 20, y: yOffset(at: index))
		}
	}

	private func yOffset(at index: Int) -> CGFloat {
		let lineHeight: CGFloat = 1.5
		let firstItem = -(baseFontSize * lineHeight * 2)
		let additionalOffset = CGFloat(index) * (baseFontSize * lineHeight)
		return firstItem - additionalOffset
	}

	func createLabel() -> SKLabelNode {

		let label = SKLabelNode(fontNamed: "Courier")
		label.fontColor = .black
		label.horizontalAlignmentMode = .left
		label.verticalAlignmentMode = .baseline
		label.text = ""
		label.name = "Label"


		labels.append(label)
		setCurrentLabel(label)
		layoutLabels()
		return label
	}

	func remove(label: SKLabelNode) {
		guard let index = labels.firstIndex(of: label) else { return }
		labels.remove(at: index)
		if currentLabel == label {
			currentLabel = labels.last
		}
		layoutLabels()
	}

	func setCurrentLabel(_ label: SKLabelNode) {
		if labels.contains(label) {
			currentLabel = label
		}
	}
}
