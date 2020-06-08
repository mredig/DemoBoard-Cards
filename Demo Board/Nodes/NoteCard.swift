//
//  NoteCard.swift
//  Demo Board
//
//  Created by Michael Redig on 7/9/19.
//  Copyright © 2019 Red_Egg Productions. All rights reserved.
//

import SpriteKit

class NoteCard: SKNode {

	let background: SKSpriteNode
	let handle: SKSpriteNode
	var contents = [SKLabelNode]()
	weak var selectHandler: ItemSelectHandler?
	let labelController: LabelController
	let sizeHandle: SKSpriteNode

	var movingOffset: CGPoint?
	var sizingOffset: CGPoint?

	private(set) var isSelected = false {
		didSet {
			updateViews()
		}
	}

	var size: CGSize {
		get { background.size }
		set {
			background.size = newValue
			layoutChildren()
		}
	}

	init(size: CGSize, selectHandler: ItemSelectHandler?) {
		var size = size
		if size.height < 40 {
			size.height = 40
		}
		if size.width < 40 {
			size.width = 40
		}
		background = SKSpriteNode(color: .white, size: size)
		background.anchorPoint = CGPoint(x: 0, y: 1)
		handle = SKSpriteNode(color: .gray, size: CGSize(width: size.width, height: 20))
		handle.anchorPoint = CGPoint.zero
		handle.name = "handle"
		sizeHandle = SKSpriteNode(color: .lightGray, size: CGSize(width: 10, height: 10))
		sizeHandle.anchorPoint = CGPoint(x: 1, y: 0)
		sizeHandle.zPosition = 0.01
		sizeHandle.position = CGPoint(x: size.width, y: -size.height)
		sizeHandle.name = "SizeHandle"
		self.labelController = LabelController(maxHeight: background.size.height, startOffset: handle.size.height, baseFontSize: 16)
		super.init()
		addChild(background)
		background.addChild(handle)
		background.addChild(sizeHandle)

		zPosition = 10

		self.selectHandler = selectHandler
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func updateViews() {
		handle.color = isSelected ? .darkGray : .gray
		zPosition = isSelected ? 11 : 10
	}

	func layoutChildren() {
		handle.size = CGSize(width: size.width, height: 20)
		sizeHandle.position = CGPoint(x: size.width, y: -size.height)
	}

	// MARK: - input
	override var isUserInteractionEnabled: Bool {
		get {
			return true
		}
		set {
			// do nothing
		}
	}

	func select() {
		selectHandler?.deselectAll()
		isSelected = true
	}

	func deselect() {
		isSelected = false
	}

	override func mouseDown(with event: NSEvent) {
		select()
		let location = event.location(in: self)
		let child = atPoint(location)
		switch child.name {
		case "handle":
			movingOffset = CGPoint(x: -location.x, y: -location.y)
		case "Label":
			print("label tapped")
			if let label = child as? SKLabelNode {
				labelController.setCurrentLabel(label)
			}
		case "SizeHandle":
			sizingOffset = event.location(in: background)
		default:
			break
		}
	}

	override func mouseDragged(with event: NSEvent) {
		guard let parent = parent else { return }
		let location = event.location(in: parent)
		if let offset = movingOffset {
			position = CGPoint(x: location.x + offset.x, y: location.y + offset.y)
		} else if let offset = sizingOffset {
			let sizePoint = event.location(in: background)
			size = CGSize(width: sizePoint.x, height: -sizePoint.y)
		}
	}

	override func mouseUp(with event: NSEvent) {
		resetOffsets()
	}

	override func mouseExited(with event: NSEvent) {
		resetOffsets()
	}

	private func resetOffsets() {
		movingOffset = nil
		sizingOffset = nil
	}

	func appendCharacter(_ character: Character) {
		if let currentLabel = labelController.currentLabel {
			guard let currentText = currentLabel.text else { return }
			currentLabel.text = "\(currentText)\(character)"
		} else {
			let newLabel = labelController.createLabel()
			addChild(newLabel)
			newLabel.text = "\(character)"
		}
	}

	func deleteCharacter() {
		guard let currentLabel = labelController.currentLabel else { return }
		guard var currentText = currentLabel.text else { return }
		guard !currentText.isEmpty else {
			labelController.remove(label: currentLabel)
			return
		}
		currentText.removeLast()
		currentLabel.text = "\(currentText)"
	}

	func newline() {
		let newLabel = labelController.createLabel()
		addChild(newLabel)
	}

}
