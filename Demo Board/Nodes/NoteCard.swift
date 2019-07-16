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

	private(set) var isSelected = false {
		didSet {
			updateViews()
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
		background.anchorPoint = CGPoint.zero
		handle = SKSpriteNode(color: .gray, size: CGSize(width: size.width, height: 20))
		handle.anchorPoint = CGPoint.zero
		handle.position.y = size.height - 20
		handle.name = "handle"
		self.labelController = LabelController(maxHeight: background.size.height, startOffset: handle.size.height, iterationOffset: 20)
		super.init()
		addChild(background)
		background.addChild(handle)

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

	var movingOffset: CGPoint?
	override func mouseDown(with event: NSEvent) {
		let location = event.location(in: self)
		let child = atPoint(location)
		if child.name == "handle" {
			movingOffset = CGPoint(x: -location.x, y: -location.y)
		}
	}

	override func mouseDragged(with event: NSEvent) {
		guard let parent = parent else { return }
		let location = event.location(in: parent)
		if let offset = movingOffset {
			position = CGPoint(x: location.x + offset.x, y: location.y + offset.y)
		}
	}

	override func mouseUp(with event: NSEvent) {
		movingOffset = nil
	}

	override func mouseExited(with event: NSEvent) {
		movingOffset = nil
	}

	func appendCharacter(_ character: Character) {
		if let currentLabel = labelController.currentLabel() {
			guard let currentText = currentLabel.text else { return }
			currentLabel.text = "\(currentText)\(character)"
		} else {
			let newLabel = labelController.create()
			addChild(newLabel)
			newLabel.text = "\(character)"
		}
	}

	func deleteCharacter() {
		guard let currentLabel = labelController.currentLabel() else { return }
		guard var currentText = currentLabel.text else { return }
		guard !currentText.isEmpty else {
			labelController.remove(label: currentLabel)
			return
		}
		currentText.removeLast()
		currentLabel.text = "\(currentText)"
	}

	func newline() {
		let newLabel = labelController.create()
		addChild(newLabel)
	}

}
