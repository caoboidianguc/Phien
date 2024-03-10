//
//  ServicesListView.swift
//  Phien
//
//  Created by Jubi on 3/7/24.
//


import SwiftUI

struct ServicesListView: View {
    @EnvironmentObject var shop: ShopStore
//    @State private var themDVButton = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(shop.shop.services){dv in
                    HStack {
                        Text(dv.name)
                        Spacer()
                        Text("$ \(dv.price)")
                    }.padding([.trailing,.leading])
                }
                .onMove(perform: { indices, newOffset in
                    shop.shop.services.move(fromOffsets: indices, toOffset: newOffset)
                })
                .onDelete(perform: { indexSet in
                    shop.shop.services.remove(atOffsets: indexSet)
                })
                AddServiceView()
            }
            .overlay(alignment: .center, content: {
                if shop.shop.services.isEmpty {
                        VStack(alignment: .center){
                            Text("All Services will appearl here ")
                            Text("You might add with +")
                        }
                        .font(.title)
                        .foregroundStyle(.gray)
                    }
            })
            .navigationTitle("Services")
            .navigationBarTitleDisplayMode(.automatic)
            .listStyle(.plain)
//            .toolbar {
//                ToolbarItem(placement: .topBarTrailing){
//                    Button(action: {
//                        themDVButton = true
//                    }, label: {
//                        Label("", systemImage: "plus")
//                    })
//                }
//                
//            }
//            .sheet(isPresented: $themDVButton){
//                NavigationStack {
//                    AddServiceView(shop: $shop, isPresenting: $themDVButton)
//                }
//            }
        }
    }//body
    
}

#Preview {
    ServicesListView()
        .environmentObject(ShopStore())
}
