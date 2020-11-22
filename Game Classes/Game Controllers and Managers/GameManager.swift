//
//  GameManager.swift
//  Jack The Giant
//
//  Created by Oscar Rodriguez Garrucho on 8/9/18.
//  Copyright © 2018 Main 3.0. All rights reserved.
//

import Foundation

class GameManager {
    
    static let instance = GameManager();
    private init() {}
    
    private var gameData: GameData?;
    
    var gameStartedFromMainMenu = false;
    var gameRestartedPlayerDied = false;
    
    func initializeGameData() {
        // if it´s the first time we play...
        if !FileManager.default.fileExists(atPath: getFilePath()) {
            // set up our game with initial values
            gameData = GameData();
            
            gameData?.setEasyDifficultScore(easyDifficultyScore: 0);
            gameData?.setEasyDifficultyCoinScore(easyDifficultyCoinScore: 0);
            
            gameData?.setMediumDifficultScore(mediumDifficultyScore: 0);
            gameData?.setMediumDifficultyCoinScore(mediumDifficultyCoinScore: 0);
            
            gameData?.setHardDifficultScore(hardDifficultyScore: 0);
            gameData?.setHardDifficultyCoinScore(hardDifficultyCoinScore: 0);
            
            gameData?.setEasyDifficult(easyDifficult: false);
            gameData?.setMediumDifficult(mediumDifficult: true);
            gameData?.setHardDifficult(hardDifficult: false);
            
            gameData?.setIsMusicOn(isMusicOn: false);
            
            saveData();
        }
        
        loadData();
    }
    
    func loadData() {
        gameData = NSKeyedUnarchiver.unarchiveObject(withFile: getFilePath()) as? GameData;
    }
    
    func saveData() {
        if let gameData = gameData {
            NSKeyedArchiver.archiveRootObject(gameData, toFile: getFilePath());
        }
    }
    
    func getFilePath() -> String {
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first;
        return url!.appendingPathComponent("Game Data").path;
    }
    
    // getters and setters
    func setEasyDifficultyScore(easyDifficultyScore: Int32) {
        gameData!.setEasyDifficultScore(easyDifficultyScore: easyDifficultyScore)
    }
    
    func getEasyDifficultyScore() -> Int32 {
        return self.gameData!.getEasyDifficultyScore()
    }
    
    func setMediumDifficultyScore(mediumDifficultyScore: Int32) {
        gameData!.setMediumDifficultScore(mediumDifficultyScore: mediumDifficultyScore)
    }
    
    func getMediumDifficultyScore() -> Int32 {
        return self.gameData!.getMediumDifficultyScore()
    }
    
    func setHardDifficultyScore(hardDifficultyScore: Int32) {
        gameData!.setHardDifficultScore(hardDifficultyScore: hardDifficultyScore)
    }
    
    func getHardDifficultyScore() -> Int32 {
        return self.gameData!.getHardDifficultyScore()
    }
    
    func setEasyDifficultyCoinScore(easyDifficultyCoinScore: Int32) {
        gameData!.setEasyDifficultyCoinScore(easyDifficultyCoinScore: easyDifficultyCoinScore)
    }
    
    func getEasyDifficultyCoinScore() -> Int32 {
        return self.gameData!.getEasyDifficultyCoinScore()
    }
    
    func setMediumDifficultyCoinScore(mediumDifficultyCoinScore: Int32) {
        gameData!.setMediumDifficultyCoinScore(mediumDifficultyCoinScore: mediumDifficultyCoinScore)
    }
    
    func getMediumDifficultyCoinScore() -> Int32 {
        return self.gameData!.getMediumDifficultyCoinScore()
    }
    
    func setHardDifficultyCoinScore(hardDifficultyCoinScore: Int32) {
        gameData!.setHardDifficultyCoinScore(hardDifficultyCoinScore: hardDifficultyCoinScore)
    }
    
    func getHardDifficultyCoinScore() -> Int32 {
        return self.gameData!.getHardDifficultyCoinScore()
    }
    
    func setEasyDifficult(easyDifficulty: Bool) {
        gameData!.setEasyDifficult(easyDifficult: easyDifficulty)
    }
    
    func getEasyDifficulty() -> Bool {
        return self.gameData!.getEasyDifficult()
    }
    
    func setMediumDifficulty(mediumDifficulty: Bool) {
        gameData!.setMediumDifficult(mediumDifficult: mediumDifficulty)
    }

    func getMediumDifficulty() -> Bool {
        return self.gameData!.getMediumDifficult()
    }
    
    func setHardDifficulty(hardDifficulty: Bool) {
        gameData!.setHardDifficult(hardDifficult: hardDifficulty)
    }
    
    func getHardDifficulty() -> Bool {
        return self.gameData!.getHardDifficult()
    }
    
    func setMusicOn(isMusicOn: Bool) {
        gameData!.setIsMusicOn(isMusicOn: isMusicOn);
    }
    
    func getIsMusicOn() -> Bool {
        return self.gameData!.getIsMusicOn()
    }
    
}











