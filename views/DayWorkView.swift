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
    var isSomeOne: Bool {
        self.shop.shop.techs.filter({$0.isWork}).isEmpty
    }
    var isOff: Bool {
        self.shop.shop.techs.filter({!$0.isWork || !$0.today}).isEmpty
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Section(content: {
                    WorkingView()
                })
                Section(content: {
                    OffWorkView()
                }, header: {
                    Text(isOff ? "" : "-- 😴 --")
                        .font(.title)
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
            .navigationTitle("Welcome \(ngay.formatted(.dateTime.day().weekday()))")
            
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
    }
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
