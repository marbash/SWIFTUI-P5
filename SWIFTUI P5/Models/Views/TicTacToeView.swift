//
//  ContentView.swift
//  SWIFTUI P5
//
//  Created by MOHD ALARBASH on 5/9/20.
//  Copyright © 2020 MOHD ALARBASH. All rights reserved.
//

import SwiftUI
import AudioToolbox



struct TicTacToeView: View {
    @EnvironmentObject var env: Env
    
    @State var isPlaying: Bool = false
    var body: some View {
        
        ZStack {
            
            BG()
            
            
            VStack (spacing: 10){
                
                Button(action: {
                    //Code
                    self.isPlaying.toggle()
                    self.env.playMusic(play: self.isPlaying)
                    
                }) {
                    //                Text(isPlaying ? "Stop Music":"Play Music")
                    //                    .foregroundColor(.white)
                    Image(systemName: isPlaying ?"stop.circle":"play.circle")
                        .resizable()
                        .scaledToFit()
                        .frame(height:50)
                        .foregroundColor(.white)
                    //.background(Color.black)
                }
                
                Text(env.winner)
                    .font(.system(size: 50, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                Text("\(env.currentPlayer.text()) Turn")
                    .font(.system(size: 50, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                
                Grid()
                
                if env.winner != ""
                {
                    Button(action: {
                        //code
                        self.env.restartGame()
                    }) {
                        
                        Text("Restart Game")
                            .font(.system(size:30,weight:.bold,design:.rounded))
                    }
                }
            }
        }
    }
}

struct BG: View {
    var body: some View {
        VStack{
            Image("BG")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            //.frame(height: 50)
            Spacer()
        }.background(Color.black).edgesIgnoringSafeArea(.all)
    }
}


struct Grid: View {
    @EnvironmentObject var env: Env
    
    var body: some View {
        ForEach(0..<3) { r in
            HStack(spacing: 10){
                ForEach(0..<3) { c in
                    XOButton(r: r ,c: c)
                    
                }
            }
            
        }
    }
}

struct XOButton: View {
    @EnvironmentObject var env: Env
    var r: Int
    var c: Int
    var body: some View {
        Button(action: {
            // when tapping change the current button either to X or O
            self.env.tapButton(r: self.r, c: self.c)
        }) {
            //
            Text(self.env.fields[r][c].player.text())
                .foregroundColor(.white)
                .font(.system(size:50 , weight: .bold, design: .rounded))
                .frame(width: 100, height: 100,alignment: .center)
                .background(Color.blue)
            
        }
    }
}

struct TicTacToeView_Previews: PreviewProvider {
    static var previews: some View {
        TicTacToeView()
        .environmentObject(Env())
    }
}
