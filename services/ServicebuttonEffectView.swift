//
//  ServicebuttonEffectView.swift
//  Phien
//
//  Created by Jubi on 4/11/24.
//

import SwiftUI

struct ServicebuttonEffectView: View {
    var ser: Service
    @State private var hieuUng = false
//    @Binding var danhMuc: [Service]
    var action: ()->Void
   
    var body: some View {
        Button(action: { 
            withAnimation(.bouncy(duration: 1.0)){
                hieuUng.toggle()
//                danhMuc.append(ser)
//                ser.startTime = Date.now
                
            }
        }, label: {
            VStack {
                Text(ser.name)
                Text("\(ser.price)")
            }.transition(.move(edge: .leading))
            .opacity(hieuUng ? 0.1 : 1)
            .scaleEffect(hieuUng ? 0.2 : 1.2)
            .rotationEffect(.degrees(hieuUng ? 90 : 0))
        })
    }
}

//#Preview {
//    ServicebuttonEffectView(ser: allServices[0])
//}

