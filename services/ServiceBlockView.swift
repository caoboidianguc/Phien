//
//  ServiceBlockView.swift
//  Phien
//
//  Created by Jubi on 3/7/24.
//


import SwiftUI

struct ServiceBlockView: View {
    var serv: Service
    @State private var runTime = false
    @State private var finished: Date = Date()
    
    
    var body: some View {
        Button(action: {
            self.runTime.toggle()
            self.finished = Date.now
        }, label: {
            RoundedRectangle(cornerRadius: 10)
                .fill(skip ? .red : .blue)
                .frame(width: 90, height: 90)
                .overlay{
                    VStack {
                        Text(serv.name)
                            .font(skip ? .title : .system(size: 24))
                        Text("$ \(serv.price)")
                            .opacity(skip ? 0 : 1)
                        timeSer()
                            .foregroundStyle(runTime ? .green : .white)
                    }.foregroundStyle(.background)
                }
        })
        
    }//body
    private func timeSer() -> some View {
        if runTime {
            Text("\(finished.formatted(.dateTime.hour().minute()))")
                .font(.title3)
        } else {
            Text(serv.startTime.formatted(.dateTime.hour().minute()))
        }
        
    }
    var skip: Bool {
        if serv.name == "Skip" || serv.name == "Pass" {
            return true
        } else {
            return false
        }
    }
}

#Preview {
    ServiceBlockView(serv: allServices[0])
}
