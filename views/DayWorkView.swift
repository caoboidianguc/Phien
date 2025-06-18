//
//  DayWorkView.swift
//  Phien
//
//  Created by Jubi on 3/7/24.
//


import SwiftUI

struct DayWorkView: View {
    @EnvironmentObject var shop: ShopStore
    @State private var ngay = Date.now
    @State private var themTechButton = false
    
    var isOff: Bool {
        self.shop.shop.techs.filter({!$0.isWork || !$0.today}).isEmpty
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                Section(content: {
                    WorkingView()
                        .padding(.horizontal, 5)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                })
                Section(content: {
                    OffWorkView()
                        .padding(.horizontal, 5)
                }, header: {
                    Text(isOff ? "" : "-- 😴 --")
                        .font(.title)
                        .padding(.top, 15)
                        .foregroundStyle(.secondary)
                })
                
            }.background(
                LinearGradient(
                    colors: [.cyan.opacity(0.05), .white],
                    startPoint: .top,
                    endPoint: .bottom
                )
            )
            .padding(.vertical, 5)
            .overlay(alignment: .center) {
                if shop.shop.techs.isEmpty {
                    VStack(spacing: 16) {
                        Image(systemName: "person.2.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.gray)
                        Text("No technicians yet")
                            .font(.title2)
                            .fontWeight(.semibold)
                        Text("Tap below to add your first technician.")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Button(action: {
                            themTechButton = true
                        }) {
                            Text("Add Technician")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(.blue.opacity(0.6))
                                .clipShape(Capsule())
                        }
                    }
                    .padding()
                    .background(.cyan.opacity(0.05))
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .shadow(radius: 4)
                }
            }
            .animation(.easeInOut(duration: 0.3), value: shop.shop.techs.isEmpty)
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
    
    
}

#Preview {
    DayWorkView()
        .environmentObject(ShopStore())
}
