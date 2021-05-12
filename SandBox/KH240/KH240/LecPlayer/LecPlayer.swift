//
//  LecPlayer.swift
//  KH240
//
//  Created by Park Youngeun on 2021/05/11.
//

import SwiftUI
import AVKit
class album_Data : ObservableObject{
   @Published var isPlaying = false
}
let url = Bundle.main.path(forResource: "11", ofType: "mp3")

struct Leca1: View {
    @State var audioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: url!))
    @State var timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    @StateObject var album = album_Data()
    @State var animatedValue : CGFloat = 55
    @State var maxWidth = UIScreen.main.bounds.width / 2.2
    @State var time : Float = 0
    
    var body: some View {
        VStack{
            Button(action: play){
                Image(systemName: album.isPlaying ? "pause.fill" : "play.fill")
                    .foregroundColor(.black)
                    .frame(width: 55, height: 55)
                    .background(Color.white)
                    .clipShape(Circle())
                
                Slider(value: Binding(get: {time}, set: {(newValue) in time = newValue
                    audioPlayer.currentTime = Double(time) * audioPlayer.duration
                    audioPlayer.play()
                }))
            }
            .padding()
            .onReceive(timer){ (_) in
                if audioPlayer.isPlaying{
            audioPlayer.updateMeters()
            album.isPlaying = true
            time = Float(audioPlayer.currentTime / audioPlayer.duration)
            startAnimation()
                } else{
                    album.isPlaying = false
                }
            }
            
            
        }
        
    }
    
    
    
    func startAnimation(){
        var power : Float = 0
        for i in 0..<audioPlayer.numberOfChannels{
            power += audioPlayer.averagePower(forChannel: i)
        }
        let value = max(0, power + 55)
        let animated = CGFloat(value) * (maxWidth / 55)
        withAnimation(Animation.linear(duration: 0.01)){
            self.animatedValue = animated + 55
        }
    }
    
    
    func play(){
        if audioPlayer.isPlaying{
            audioPlayer.pause()
        }else{
            audioPlayer.play()
        }
    }
}

struct LecPlayer_Previews: PreviewProvider {
    static var previews: some View {
        Leca1()
    }
}
