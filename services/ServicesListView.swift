//
//  ServicesListView.swift
//  Phien
//
//  Created by Jubi on 3/7/24.
//


import SwiftUI

struct ServicesListView: View {
    @EnvironmentObject var shop: ShopStore
    
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
        }
    }
    
}

#Preview {
    ServicesListView()
        .environmentObject(ShopStore())
}
