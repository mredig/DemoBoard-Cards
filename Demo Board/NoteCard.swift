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

	var selected = false {
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
		super.init()
		addChild(background)
		background.addChild(handle)

		self.selectHandler = selectHandler
	}

	required init?(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func updateViews() {
		handle.color = selected ? .darkGray : .gray
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

	var movingOffset: CGPoint?
	override func mouseDown(with event: NSEvent) {
		selectHandler?.deselectAll()
		selected = true
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


}
