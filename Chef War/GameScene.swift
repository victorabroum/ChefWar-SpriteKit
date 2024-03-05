//
//  GameScene.swift
//  Chef War
//
//  Created by Victor Vasconcelos on 28/02/24.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var player: ChefNode?
    
    private var lastUpdatedTime: TimeInterval = 0
    private var elapsedTime: TimeInterval = 0
    private var delayToSpawn: TimeInterval = 2
    
    private var isGameOver: Bool = false
    private var canResetGame: Bool = false
    
    private var circleTransition: SKShapeNode?
    
    internal var scoreController: ScoreController!
    
    override func sceneDidLoad() {
        setupScene()
    }
    
    private func setupScene() {
        physicsWorld.contactDelegate = self
        
        SoundController.shared.setup(scene: self)
        SoundController.shared.playBackgroundMusic()
        
        circleTransition = .init(circleOfRadius: self.size.width)
        circleTransition?.fillColor = .black
        circleTransition?.strokeColor = .clear
        circleTransition?.zPosition = 500
        self.addChild(circleTransition!)
        circleTransition()
        
        let camera = SKCameraNode()
        self.addChild(camera)
        self.camera = camera
        self.camera?.setScale(0.65)
        
        self.backgroundColor = UIColor(red: 0.12, green: 0.44, blue: 0.31, alpha: 1.00)
        
        generateGrass(amount: 50)
        
        let scoreNode = ScoreNode()
        scoreNode.position.y = (self.size.width/2) * 0.35
        scoreNode.position.x += 30
        scoreNode.zPosition = 99
        self.camera?.addChild(scoreNode)
        
        scoreController = ScoreController(scoreNode: scoreNode)
        
        let towelNode = TowelNode()
        towelNode.position.y -= 8
        self.addChild(towelNode)
        
        player = ChefNode()
        self.addChild(player!)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard !isGameOver else {
            if (canResetGame) { resetGame() }
            return
        }
        guard let location = touches.first?.location(in: self) else { return }
        shootCleaver(to: location)
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        guard !isGameOver else { return }
        
        if (lastUpdatedTime == 0) {
            lastUpdatedTime = currentTime
        }
        
        let deltaTime = currentTime - lastUpdatedTime
        
        elapsedTime += deltaTime
        
        if (elapsedTime >= delayToSpawn) {
            spawnAnt()
            elapsedTime = 0
        }
        
        lastUpdatedTime = currentTime
    }
    
    private func spawnAnt() {
        
        let antNode = AntNode()
        antNode.position = .randomPositionByAngle(distance: 500)
        
        self.addChild(antNode)
        
        let speed: CGFloat = .random(in: 35...75)
        let distance = antNode.position.distance(point: .zero)
        let travelTime = TimeInterval.calculateTravelTime(speed: speed, distance: distance)
        
        antNode.xScale = antNode.position.x < 0 ? -1 : 1
        
        antNode.run(.sequence([
            .move(to: .zero, duration: travelTime),
            .fadeOut(withDuration: 0.3),
            .run(gameOver),
            .removeFromParent()
        ]))
        
    }
    
    private func shootCleaver(to location: CGPoint) {
        let newCleaver = CleaverNode()
        self.addChild(newCleaver)
        
        let distance = newCleaver.position.distance(point: location)
        let travelTime = TimeInterval.calculateTravelTime(speed: 200, distance: distance)
        
        newCleaver.run(.sequence([
            .group([
                .move(to: location, duration: travelTime),
                .repeat(.rotate(byAngle: 1, duration: travelTime / 20), count: 20)
            ]),
            .run(newCleaver.spiked),
            .wait(forDuration: 0.5),
            .fadeOut(withDuration: 0.4),
            .removeFromParent()
        ]))
    }
    
    private func gameOver() {
        guard !isGameOver else {
            return
        }
        
        circleTransition(out: false)
        SoundController.shared.playGameOverMusic()
        
        isGameOver = true
        
        let titleNode = SKSpriteNode(imageNamed: "game over")
        titleNode.zPosition = 600
        titleNode.texture?.filteringMode = .nearest
        titleNode.setScale(0)
        titleNode.position.y += 15
        self.addChild(titleNode)
        
        let textLabel = SKLabelNode(text: "Click to restart!")
        textLabel.fontName = "PPMori-Regular"
        textLabel.alpha = 0
        textLabel.fontSize = 24
        self.addChild(textLabel)
        textLabel.setScale(0.5)
        textLabel.position.y -= titleNode.size.height / 2 + 75
        textLabel.isHidden = true
        textLabel.zPosition = titleNode.zPosition
        
        titleNode.run(.sequence([
            .wait(forDuration: 0.5),
            .scale(to: 3, duration: 0.3),
            .scale(to: 0.5, duration: 0.2),
            .scale(to: 0.6, duration: 0.1),
            .repeatForever(.sequence([
                .move(by: .init(dx: 0, dy: 5), duration: 0.3),
                .move(by: .init(dx: 0, dy: -10), duration: 0.6),
                .move(by: .init(dx: 0, dy: 5), duration: 0.3),
            ]))        
        ]))
        
        titleNode.run(.sequence([
            .wait(forDuration: 2),
            .run {
                textLabel.isHidden = false
                self.canResetGame = true
            }
        ]))
        
        textLabel.run(.repeatForever(.sequence([
            .fadeAlpha(to: 0.4, duration: 0.3),
            .fadeAlpha(to: 1, duration: 0.3),
        ])))
    }
    
    private func resetGame() {
        self.removeAllChildren()
        isGameOver = false
        canResetGame = false
        setupScene()
    }
    
    private func circleTransition(out value: Bool = true) {
        
        let action = SKAction.scale(to: 1, duration: 1.3)
        action.timingMode = .easeInEaseOut
        
        if value {
            circleTransition?.run(.scale(to: 0, duration: 1.3))
        } else {
            circleTransition?.run(action)
        }
        
    }
    
    internal func cameraShake() {
        self.camera?.run(.shake(duration: 0.2))
    }
    
    private func generateGrass(amount: Int) {
        for _ in 0...amount {
            let randomIndex = Int.random(in: 1...5)
            let grassNode = SKSpriteNode(imageNamed: "grass_\(randomIndex)")
            
            grassNode.texture?.filteringMode = .nearest
            grassNode.zPosition = -100
            grassNode.position = .randomPosition(in: -300...300)
            
            self.addChild(grassNode)
        }
    }
}
