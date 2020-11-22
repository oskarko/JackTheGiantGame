//
//  GameplayScene.swift
//  Jack The Giant
//
//  Created by Oscar Rodriguez Garrucho on 26/1/18.
//  Copyright © 2018 Main 3.0. All rights reserved.
//

import SpriteKit


class GameplayScene : SKScene, SKPhysicsContactDelegate {
    
    var cloudsController = CloudsController()
    
    var mainCamera : SKCameraNode?
    
    var player : Player?
    
    var bg1 : BGClass?
    var bg2 : BGClass?
    var bg3 : BGClass?
    
    var canMove = false
    var moveLeft = false
    
    var center : CGFloat?
    
    private var acceleration = CGFloat()
    private var cameraSpeed = CGFloat()
    private var maxSpeed = CGFloat()
    
    private let playerMinX = CGFloat(-214)
    private let playerMaxX = CGFloat(214)
    
    private var cameraDistanceBeforeCreatingNewClouds = CGFloat()
    
    let distanceBetweenClouds = CGFloat(240)
    let minX = CGFloat(-155)
    let maxX = CGFloat(155)
    
    private var pausePanel: SKSpriteNode?
    
    
    override func didMove(to view: SKView) {
        initializeVariables()
        setCameraSpeed()
    }
    
    // In this method we're going to move the player
    override func update(_ currentTime: TimeInterval) {
        moveCamera()
        managePlayer()
        manageBackgrounds()
        createNewClouds()
        player?.setScore()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        var firstBody = physicsBody
        var secondBody = physicsBody
        
        if contact.bodyA.node?.name == "Player" {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if firstBody?.node?.name == "Player" && secondBody?.node?.name == "Life" {
            // play the sound for the life
            // increment the score
            self.run(SKAction.playSoundFileNamed("Life Sound.wav", waitForCompletion: false));
            GamePlayController.instance.incrementLife()
            secondBody?.node?.removeFromParent()
            
        }
        else if firstBody?.node?.name == "Player" && secondBody?.node?.name == "Coin" {
            // play the coin sound
            // increment the score
            self.run(SKAction.playSoundFileNamed("Coin Sound.wav", waitForCompletion: false));
            GamePlayController.instance.incrementCoin()
            secondBody?.node?.removeFromParent()
            
        }
        else if firstBody?.node?.name == "Player" && secondBody?.node?.name == "Dark Cloud" {
            // kill the player
            self.scene?.isPaused = true;
            GamePlayController.instance.life! -= 1;
            if GamePlayController.instance.life! >= 0 {
                GamePlayController.instance.lifeText?.text = "x\(GamePlayController.instance.life!)"
            }
            else {
                // show end score panel
                createEndScorePanel()
            }
            firstBody?.node?.removeFromParent();
            Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(playerDied), userInfo: nil, repeats: false)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch in touches {
            let location = touch.location(in: self)
            
            if atPoint(location).name != "Pause" && atPoint(location).name != "Resume" && atPoint(location).name != "Quit" {
                if self.scene?.isPaused == false {
                    if let center = center, location.x > center {
                        moveLeft = false
                        player?.animatePlayer(moveLeft: moveLeft)
                    } else {
                        moveLeft = true
                        player?.animatePlayer(moveLeft: moveLeft)
                    }
                    canMove = true
                }
            }
            else if atPoint(location).name == "Pause" && !(self.scene?.isPaused)! { // itsn´t paused and tap on pause
                self.run(SKAction.playSoundFileNamed("Click Sound.wav", waitForCompletion: false));
                self.scene?.isPaused = true
                createPausePanel()
            }
            else if atPoint(location).name == "Resume" {
                self.run(SKAction.playSoundFileNamed("Click Sound.wav", waitForCompletion: false));
                
                pausePanel?.removeFromParent()
                self.scene?.isPaused = false
            }
           else  if atPoint(location).name == "Quit" {
                self.run(SKAction.playSoundFileNamed("Click Sound.wav", waitForCompletion: false));
                
                let scene = MainMenuScene(fileNamed: "MainMenu")
                scene!.scaleMode = .aspectFill
                self.view?.presentScene(scene!, transition: SKTransition.doorsOpenVertical(withDuration: 0.9))
            }

        }
    }
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        canMove = false
        player?.stopPlayerAnimation()
    }
    
    func initializeVariables() {
        
        physicsWorld.contactDelegate = self;
        center = (self.scene?.size.width)! / (self.scene?.size.height)!
        
        player = self.childNode(withName: "Player") as? Player
        player?.initializePlayerAndAnimations()
        
        mainCamera = self.childNode(withName: "Main Camera") as? SKCameraNode
        
        getBackgrounds()
        getlabels()
        
        GamePlayController.instance.initializeVariables()
        
        cloudsController.arrangeCloudsInScene(scene: self.scene!,
                                              distanceBetweenClouds: self.distanceBetweenClouds,
                                              center: self.center!,
                                              minX: self.minX,
                                              maxX: self.maxX,
                                              player: player!,
                                              initialClouds: true)
        
        cameraDistanceBeforeCreatingNewClouds = (mainCamera?.position.y)! - 400
    }
    
    func getBackgrounds() {
        
        bg1 = self.childNode(withName: "BG 1") as? BGClass
        bg2 = self.childNode(withName: "BG 2") as? BGClass
        bg3 = self.childNode(withName: "BG 3") as? BGClass
    }
    
    func managePlayer() {
        
        if canMove {
            player?.movePlayer(moveLeft: moveLeft)
        }
        // left and right limits
        if (player?.position.x)! > playerMaxX {
            player?.position.x = playerMaxX
        }
        else if (player?.position.x)! < playerMinX {
            player?.position.x = playerMinX
        }
        
        // top and bottoms limits
        if ((player?.position.y)! - (player?.size.height)! * 3.7) > (mainCamera?.position.y)! {
            // kill the player
            self.scene?.isPaused = true;
            GamePlayController.instance.life! -= 1;
            if GamePlayController.instance.life! >= 0 {
                GamePlayController.instance.lifeText?.text = "x\(GamePlayController.instance.life!)"
            }
            else {
                // show end score panel
                createEndScorePanel()
            }
            Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(playerDied), userInfo: nil, repeats: false)
        }
        else if ((player?.position.y)! + (player?.size.height)! * 3.7) < (mainCamera?.position.y)! {
            // kill the player
            self.scene?.isPaused = true;
            GamePlayController.instance.life! -= 1;
            if GamePlayController.instance.life! >= 0 {
                GamePlayController.instance.lifeText?.text = "x\(GamePlayController.instance.life!)"
            }
            else {
                // show end score panel
                createEndScorePanel()
            }
            Timer.scheduledTimer(timeInterval: TimeInterval(1), target: self, selector: #selector(playerDied), userInfo: nil, repeats: false)
        }
    }
    
    func moveCamera() {
        
        cameraSpeed += acceleration
        if cameraSpeed > maxSpeed {
            cameraSpeed = maxSpeed
        }
        
        
        self.mainCamera?.position.y -= cameraSpeed;
    }
    
    func manageBackgrounds() {
        
        bg1?.moveBG(camera: mainCamera!)
        bg2?.moveBG(camera: mainCamera!)
        bg3?.moveBG(camera: mainCamera!)
    }
    
    func createNewClouds() {
        if cameraDistanceBeforeCreatingNewClouds > (mainCamera?.position.y)! {
            
            cameraDistanceBeforeCreatingNewClouds = (mainCamera?.position.y)! - 400
            cloudsController.arrangeCloudsInScene(scene: self.scene!, distanceBetweenClouds: self.distanceBetweenClouds, center: self.center!, minX: self.minX, maxX: self.maxX, player: player!, initialClouds: false)
            
            checkForChildsOutOffScreen()
        }
    }
    
    func checkForChildsOutOffScreen() {
        for child in children {
            if child.position.y > (mainCamera?.position.y)! + (self.scene?.size.height)! {
                let childName = child.name?.components(separatedBy:" ")
                
                if childName![0] != "BG" {
                    child.removeFromParent();
                }
            }
        }
    }
    
    func getlabels() {
        GamePlayController.instance.scoreText = self.mainCamera!.childNode(withName: "Score text") as? SKLabelNode;
        GamePlayController.instance.coinText = self.mainCamera!.childNode(withName: "Coin Score") as? SKLabelNode;
        GamePlayController.instance.lifeText = self.mainCamera!.childNode(withName: "Life Score") as? SKLabelNode;
    }
    
    func createPausePanel() {
        pausePanel = SKSpriteNode(imageNamed: "Pause Menu")
        let resumeBtn = SKSpriteNode(imageNamed: "Resume Button")
        let quitBtn = SKSpriteNode(imageNamed: "Quit Button 2")
        
        pausePanel?.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        pausePanel?.xScale = 1.6
        pausePanel?.yScale = 1.6
        pausePanel?.zPosition = 5
        
        pausePanel?.position = CGPoint(x: (self.mainCamera?.frame.size.width)! / 2, y: (self.mainCamera?.frame.height)! / 2)
        
        resumeBtn.name = "Resume"
        resumeBtn.zPosition = 6
        resumeBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        resumeBtn.position = CGPoint(x: (pausePanel?.position.x)!, y: (pausePanel?.position.y)! + 25)
        
        quitBtn.name = "Quit"
        quitBtn.zPosition = 6
        quitBtn.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        quitBtn.position = CGPoint(x: (pausePanel?.position.x)!, y: (pausePanel?.position.y)! - 45)
        
        pausePanel?.addChild(resumeBtn)
        pausePanel?.addChild(quitBtn)
        
        self.mainCamera?.addChild(pausePanel!)
    }
    
    func createEndScorePanel() {
        let endScorePanel = SKSpriteNode(imageNamed: "Show Score")
        let scoreLabel = SKLabelNode(fontNamed: "Blow")
        let coinLabel = SKLabelNode(fontNamed: "Blow")
        
        endScorePanel.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        endScorePanel.zPosition = 8
        endScorePanel.xScale = 1.5
        endScorePanel.yScale = 1.5
        
        scoreLabel.fontSize = 50
        scoreLabel.zPosition = 7
        
        coinLabel.fontSize = 50
        coinLabel.zPosition = 7
        
        scoreLabel.text = "\(GamePlayController.instance.score!)"
        coinLabel.text = "\(GamePlayController.instance.coin!)"
        
        endScorePanel.addChild(scoreLabel)
        endScorePanel.addChild(coinLabel)
        
        endScorePanel.position = CGPoint(x: (mainCamera?.frame.size.width)! / 2, y: (mainCamera?.frame.size.height)! / 2)
        
        scoreLabel.position = CGPoint(x: endScorePanel.position.x - 60, y: endScorePanel.position.y + 10)
        coinLabel.position = CGPoint(x: endScorePanel.position.x - 60, y: endScorePanel.position.y + -105)
        
        mainCamera?.addChild(endScorePanel)
    }
    
    private func setCameraSpeed() {
        if GameManager.instance.getEasyDifficulty() {
            acceleration = 0.001
            cameraSpeed = 1.5
            maxSpeed = 4
        }
        else if GameManager.instance.getMediumDifficulty() {
            acceleration = 0.002
            cameraSpeed = 2.0
            maxSpeed = 6
        }
        else if GameManager.instance.getHardDifficulty() {
            acceleration = 0.003
            cameraSpeed = 2.5
            maxSpeed = 8
        }
    }
    
    @objc func playerDied() {
        
        if GamePlayController.instance.life! >= 0 {
            
            GameManager.instance.gameRestartedPlayerDied = true;
            
            let scene = GameplayScene(fileNamed: "GameplayScene")
            scene!.scaleMode = .aspectFill
            self.view?.presentScene(scene!, transition: SKTransition.doorsCloseVertical(withDuration: 0.9))
        }
            // no more lifes!
        else {
            if GameManager.instance.getEasyDifficulty() {
                let highscore = GameManager.instance.getEasyDifficultyScore()
                let coinscore = GameManager.instance.getEasyDifficultyCoinScore()
                
                if highscore < GamePlayController.instance.score! {
                    GameManager.instance.setEasyDifficultyScore(easyDifficultyScore: GamePlayController.instance.score!);
                }
                if coinscore < GamePlayController.instance.coin! {
                    GameManager.instance.setEasyDifficultyCoinScore(easyDifficultyCoinScore: GamePlayController.instance.coin!);
                }
            }
            else if GameManager.instance.getMediumDifficulty() {
                let highscore = GameManager.instance.getMediumDifficultyScore()
                let coinscore = GameManager.instance.getMediumDifficultyCoinScore()
                
                if highscore < GamePlayController.instance.score! {
                    GameManager.instance.setMediumDifficultyScore(mediumDifficultyScore: GamePlayController.instance.score!);
                }
                if coinscore < GamePlayController.instance.coin! {
                    GameManager.instance.setMediumDifficultyCoinScore(mediumDifficultyCoinScore: GamePlayController.instance.coin!);
                }
            }
            else if GameManager.instance.getHardDifficulty() {
                let highscore = GameManager.instance.getHardDifficultyScore()
                let coinscore = GameManager.instance.getHardDifficultyCoinScore()
                
                if highscore < GamePlayController.instance.score! {
                    GameManager.instance.setHardDifficultyScore(hardDifficultyScore: GamePlayController.instance.score!);
                }
                if coinscore < GamePlayController.instance.coin! {
                    GameManager.instance.setHardDifficultyCoinScore(hardDifficultyCoinScore: GamePlayController.instance.coin!);
                }
            }
            // save & return to main menu
            GameManager.instance.saveData()
            
            let scene = MainMenuScene(fileNamed: "MainMenu")
            scene!.scaleMode = .aspectFill
            self.view?.presentScene(scene!, transition: SKTransition.doorsOpenVertical(withDuration: 0.9))
        }
    }
    
    
    
}

































































