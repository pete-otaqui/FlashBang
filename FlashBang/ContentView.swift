//
//  ContentView.swift
//  FlashBang
//
//  Created by Pete Otaqui on 27/11/2020.
//

import SwiftUI
import AVFoundation

struct ContentView: View {
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
            Button(action: {
                self.toggleTorch(on: true)
                self.delayOff()
            }) {
                Text("Flash Bang")
                    .font(.title)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundColor(Color.white)
            }
            .border(Color.black)
        }
    }
    
    func toggleTorch(on: Bool) {
        guard let device = AVCaptureDevice.default(for: .video) else { return }

        if device.hasTorch {
            do {
                try device.lockForConfiguration()

                if on == true {
                    device.torchMode = .on
                } else {
                    device.torchMode = .off
                }

                device.unlockForConfiguration()
            } catch {
                print("Torch could not be used")
            }
        } else {
            print("Torch is not available")
        }
    }
    
    private func delayOff() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) {
            toggleTorch(on: false)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
