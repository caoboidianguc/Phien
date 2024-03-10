//
//  DayWorkView.swift
//  Phien
//
//  Created by Jubi on 3/7/24.
//


import SwiftUI

struct DayWorkView: View {
    @EnvironmentObject var shop: ShopStore
    
    @State private var themTechButton = false
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Section(content: {
                    WorkingView()
                }, header: {
                    Text("Working")
                        .font(.title)
                        .foregroundStyle(.green)
                })
                Section(content: {
                    OffWorkView()
                }, header: {
                    Text("-- Off --")
                        .font(.title3)
                })
                
            }
            .overlay(alignment: .center, content: {
                if shop.shop.techs.isEmpty {
                        VStack(alignment: .center){
                            Text("Let's add someone here")
                            Image(systemName: "person.badge.plus")
                        }
                        .font(.title)
                        .foregroundStyle(.gray)
                    }
            })
            .listStyle(.plain)
            .navigationTitle("Good day \(ngay.formatted(.dateTime.day().weekday()))")
            
            .toolbar {
                ToolbarItem(placement: .topBarTrailing){
                    Button(action: {
                        themTechButton = true
                    }, label: {
                        Label("", systemImage: "person.badge.plus")
                    })
                }
                
            }
            .sheet(isPresented: $themTechButton){
                NavigationStack {
                    AddTechView(isPresenting: $themTechButton)
                        
                }
            }
            
        }
    }//body
    var ngay: Date {
        get {
            return Date.now
        }
        set {
            if newValue < Date.now {
                self.ngay = newValue
            }
        }
    }
    
}

#Preview {
    DayWorkView()
        .environmentObject(ShopStore())
}
