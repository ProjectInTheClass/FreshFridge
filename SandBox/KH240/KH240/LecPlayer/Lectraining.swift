//
//  Lectraining.swift
//  KH240
//
//  Created by Park Youngeun on 2021/05/12.
//

import SwiftUI
import AVKit

struct SimpleT: View {
    @State var audioPlayer: AVAudioPlayer!
    
    var body: some View {
        HStack{
            Button(action: {
                self.audioPlayer.play()
            }) {Text("play")}
            .padding()
            Button(action: {
                self.audioPlayer.pause()
            }) {Text("stop")}
        }
        .onAppear {
            let sound = Bundle.main.path(forResource: "11", ofType: "mp3")
            self.audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound!))
        }
    }
}

struct SimpleT_Previews: PreviewProvider {
    static var previews: some View {
        SimpleT()
    }
}
