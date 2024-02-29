//
//  SoundController.swift
//  Chef War
//
//  Created by Victor Vasconcelos on 29/02/24.
//

import Foundation
import SpriteKit
import AVFoundation

class SoundController {
    
    public static let shared: SoundController = .init()
    private weak var scene: SKScene?
    private var soundFXNode: SKAudioNode
    
    var backgroundMusicPlayer: AVAudioPlayer?
    
    
    private init() {
        soundFXNode = SKAudioNode()
        
    }
    
    public func setup(scene: SKScene) {
        self.scene = scene
        scene.addChild(soundFXNode)
    }
    
    public func playBackgroundMusic() {
    
        backgroundMusicPlayer?.setVolume(0, fadeDuration: 1)
        
        if let musicURL = Bundle.main.url(forResource: "background", withExtension: "wav") {
            do {
                backgroundMusicPlayer = try AVAudioPlayer(contentsOf: musicURL)
                backgroundMusicPlayer?.numberOfLoops = -1 // Reproduzir indefinidamente
                backgroundMusicPlayer?.volume = 0.1
                backgroundMusicPlayer?.play()
            } catch {
                print("Erro ao carregar o arquivo de música de fundo: \(error)")
            }
        } else {
            print("Arquivo de música de fundo não encontrado.")
        }
    }
    
    public func playGameOverMusic() {
    
        backgroundMusicPlayer?.setVolume(0, fadeDuration: 1)
        
        if let musicURL = Bundle.main.url(forResource: "gameover", withExtension: "WAV") {
            do {
                backgroundMusicPlayer = try AVAudioPlayer(contentsOf: musicURL)
                backgroundMusicPlayer?.numberOfLoops = -1 // Reproduzir indefinidamente
                backgroundMusicPlayer?.volume = 0.2
                backgroundMusicPlayer?.play()
            } catch {
                print("Erro ao carregar o arquivo de música de fundo: \(error)")
            }
        } else {
            print("Arquivo de música de fundo não encontrado.")
        }
    }
    
    public func playSoundFX(named: String) {
        soundFXNode.run(.playSoundFileNamed(named, waitForCompletion: false))
    }
    
}
