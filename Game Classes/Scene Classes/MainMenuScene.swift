//
//  MainMenuScene.swift
//  Jack The Giant
//
//  Created by Oscar Rodriguez Garrucho on 1/2/18.
//  Copyright © 2018 Main 3.0. All rights reserved.
//

import SpriteKit


class MainMenuScene : SKScene {
    
    var highscoreBtn : SKSpriteNode?
    var optionsBtn : SKSpriteNode?
    var musicBtn : SKSpriteNode?
    private let musicOn = SKTexture(imageNamed: "Music On Button");
     private let musicOff = SKTexture(imageNamed: "Music Off Button");
    
    override func didMove(to view: SKView) {
        
        highscoreBtn = self.childNode(withName: "Highscore") as? SKSpriteNode
        optionsBtn = self.childNode(withName: "Options") as? SKSpriteNode
        musicBtn = self.childNode(withName: "Music") as? SKSpriteNode
        
        GameManager.instance.initializeGameData();
        setMusic();
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            
            let location = touch.location(in: self)
            
            if atPoint(location).name == "Start Game" { // other way:  if atPoint(location).name == "Highscore" {
                self.run(SKAction.playSoundFileNamed("Click Sound.wav", waitForCompletion: false));
                GameManager.instance.gameStartedFromMainMenu = true
                
                let scene = GameplayScene(fileNamed: "GameplayScene")
                scene!.scaleMode = .aspectFill
                self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVertical(withDuration: 0.9))
                
            }
            else if atPoint(location) == highscoreBtn { // other way:  if atPoint(location).name == "Highscore" {
                self.run(SKAction.playSoundFileNamed("Click Sound.wav", waitForCompletion: false));
                let scene = HighscoreScene(fileNamed: "HighscoreScene")
                scene!.scaleMode = .aspectFill
                self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVertical(withDuration: 0.9))
                
            }
            else if atPoint(location) == optionsBtn { // other way:  if atPoint(location).name == "Highscore" {
                self.run(SKAction.playSoundFileNamed("Click Sound.wav", waitForCompletion: false));
                let scene = OptionsScene(fileNamed: "OptionsScene")
                scene!.scaleMode = .aspectFill
                self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVertical(withDuration: 0.9))
                
            }
            else if atPoint(location) == musicBtn {
                handleMusicButton()
            }
        }
    }
    
    private func setMusic() {
    
        if GameManager.instance.getIsMusicOn() {
            if AudioManager.instance.isAudioPlayerInitialized() {
                AudioManager.instance.playBGmusic()
            }
            musicBtn?.texture = musicOff
        } 
    }
    
    private func handleMusicButton() {
        
        if GameManager.instance.getIsMusicOn() {
            // the music is playing, turn it off
            AudioManager.instance.stopBGMusic()
            GameManager.instance.setMusicOn(isMusicOn: false)
            musicBtn?.texture = musicOn
        } else {
            AudioManager.instance.playBGmusic()
            GameManager.instance.setMusicOn(isMusicOn: true)
            musicBtn?.texture = musicOff
        }
        GameManager.instance.saveData()
    }
    
    
}

































































