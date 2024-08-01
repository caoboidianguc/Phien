//
//  NutChonDV.swift
//  Phien
//
//  Created by Jubi on 4/13/24.
//

import SwiftUI

struct NutChonDV: View {
    @Binding var dv: Service
    @Binding var danhMuc: [Service]
    @State private var chon = false
    
    var body: some View {
        Button(action: {
            withAnimation(.bouncy(duration: 1.0)){
                danhMuc.append(dv)
                dv.startTime = Date.now
                chon.toggle()
            }
        }, label: {
            VStack {
                Text(dv.name)
                Text("\(dv.price)")
            }
            .transition(.move(edge: .top))
            .opacity(chon ? 0.1 : 1)
            .scaleEffect(chon ? 0.2 : 1.2)
            .rotationEffect(.degrees(chon ? 90 : 0))
        })
    }
}

