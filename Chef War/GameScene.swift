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
    
    internal var scoreController: ScoreController!
    
    override func sceneDidLoad() {
        setupScene()
    }
    
    private func setupScene() {
        physicsWorld.contactDelegate = self
        
        SoundController.shared.setup(scene: self)
        SoundController.shared.playBackgroundMusic()
        
        let camera = SKCameraNode()
        self.addChild(camera)
        self.camera = camera
        self.camera?.setScale(0.65)
        
        self.backgroundColor = UIColor(red: 0.12, green: 0.44, blue: 0.31, alpha: 1.00)
        
        let scoreNode = ScoreNode()
        scoreNode.position.y = (self.size.width/2) * 0.35
        scoreNode.position.x += 10
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
        let travelTime = distance / speed
        
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
        
        let cleaverSpeed: CGFloat = 200
        let distance = newCleaver.position.distance(point: location)
        let travelTime = distance / cleaverSpeed
        
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
        
        SoundController.shared.playGameOverMusic()
        
        isGameOver = true
        
        let titleNode = SKSpriteNode(imageNamed: "game over")
        titleNode.zPosition = 99
        titleNode.texture?.filteringMode = .nearest
        titleNode.setScale(0)
        titleNode.position.y += 35
        self.addChild(titleNode)
        
        let textLabel = SKLabelNode(text: "Click to restart!")
        textLabel.fontName = "PPMori-Regular"
        textLabel.alpha = 0
        textLabel.fontSize = 18
        self.addChild(textLabel)
        textLabel.position.y -= titleNode.size.height / 2 + 50
        
        titleNode.run(.sequence([
            .scale(to: 3, duration: 0.3),
            .scale(to: 0.8, duration: 0.2),
            .scale(to: 1, duration: 0.1),
            .repeatForever(.sequence([
                .move(by: .init(dx: 0, dy: 5), duration: 0.3),
                .move(by: .init(dx: 0, dy: -10), duration: 0.6),
                .move(by: .init(dx: 0, dy: 5), duration: 0.3),
            ]))        
        ]))
        
        titleNode.run(.sequence([
            .wait(forDuration: 2),
            .run {
                textLabel.run(.fadeIn(withDuration: 1))
                self.canResetGame = true
            }
        ]))
    }
    
    private func resetGame() {
        self.removeAllChildren()
        isGameOver = false
        canResetGame = false
        setupScene()
    }
    
}
