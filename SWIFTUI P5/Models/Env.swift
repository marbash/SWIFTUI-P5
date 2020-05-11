//
//  Env.swift
//  SWIFTUI P5
//
//  Created by MOHD ALARBASH on 5/11/20.
//  Copyright © 2020 MOHD ALARBASH. All rights reserved.
//

import Foundation
import AVFoundation

var music: AVAudioPlayer!

class Env: ObservableObject {
    @Published var fields: [[Fields]] = .init(repeating: .init(repeating: Fields(player: .none,enabled: true), count: 3), count: 3)
    @Published var currentPlayer: Player = .x
    @Published var winner: String = ""
    @Published var counter = 0
    
    func restartGame()
    {
        
        fields = .init(repeating: .init(repeating: Fields(player: .none,enabled: true), count: 3), count: 3)
        currentPlayer = .x
        winner = ""
        counter = 0
        
    }
    
    func tapButton(r: Int,c: Int) {
        if fields[r][c].enabled
        {
            fields[r][c].player = currentPlayer
            currentPlayer.toggle()
            fields[r][c].enabled = false
            counter += 1
            checkWinners()
            AudioServicesPlayAlertSoundWithCompletion(SystemSoundID(kSystemSoundID_Vibrate)) { }
        }
        
    }
    
    func checkWinners() {
        func checkWinner(p: Player)
        {
            let c = (p ,p ,p)
            let r1 = (fields[0][0].player ,fields[0][1].player ,fields[0][2].player) == c
            let r2 = (fields[1][0].player ,fields[1][1].player ,fields[1][2].player) == c
            let r3 = (fields[2][0].player ,fields[2][1].player ,fields[2][2].player) == c
            let c1 = (fields[0][0].player ,fields[1][0].player ,fields[2][0].player) == c
            let c2 = (fields[0][1].player ,fields[1][1].player ,fields[2][1].player) == c
            let c3 = (fields[0][2].player ,fields[1][2].player ,fields[2][2].player) == c
            let d1 = (fields[0][0].player ,fields[1][1].player ,fields[2][2].player) == c
            let d2 = (fields[0][2].player ,fields[1][1].player ,fields[2][0].player) == c
            
            if r1 || r2 || r3 || c1 || c2 || c3 || d1 || d2
            {
                winner = "\(p.text()) Wins!!"
                
                for i in 0..<3 {
                    for y in 0..<3 {
                        fields[i][y].enabled = false
                    }
                }
                //                ForEach(0..<3) { r in
                //                    ForEach(0..<3) { c in
                //
                //                        self.fields[r][c].enabled = false
                //
                //                    }
                //
                //                }
                
            }
            else if counter == 9
            {
                winner = "DRAW !!"
            }
            
            
            
        }
        
        checkWinner(p: .x)
        checkWinner(p: .o)
    }
    
    
    func playMusic(play: Bool) {
        if let musicURL = Bundle.main.url(forResource: "PhantomFromSpace", withExtension: "mp3") {
            if let audioPlayer = try? AVAudioPlayer(contentsOf: musicURL) {
                music = audioPlayer
                music.numberOfLoops = 0
                if play == true{
                    
                    music.play()
                    //
                } else {
                    music.stop()
                }
                
            }
        }
    }
}
