//
//  AudioManager.swift
//  Who is the spy
//
//  Created by Motlaq Alnassafi on 27/02/2025.
//

import AVFoundation

class AudioManager: ObservableObject {
    var audioPlayer: AVAudioPlayer?

    func playSound(_ fileName: String, fileType: String = "mp3") {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: fileType) else {
            print("Sound file not found: \(fileName).\(fileType)")
            return
        }
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
}
