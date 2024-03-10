//
//  OffWorkView.swift
//  Phien
//
//  Created by Jubi on 3/7/24.
//


import SwiftUI

struct OffWorkView: View {
    @EnvironmentObject var shop: ShopStore
    let cot = [GridItem(spacing: 5, alignment: .center),
               GridItem(spacing: 5, alignment: .center),
               GridItem(spacing: 5, alignment: .center),
              GridItem(spacing: 5, alignment: .center),
               GridItem(spacing: 5, alignment: .center)]
    @State private var isEditing = false
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: cot, alignment: .center, spacing: 10, content: {
                ForEach($shop.shop.techs) {$tech in
                    if !tech.isWork || !tech.today {
                        BackWorkButtonTurn(tech: $tech)
                            .overlay(alignment: .topTrailing){
                                if isEditing {
                                    Button {
                                        shop.removeTech(tech: tech)
                                    } label: {
                                        Image(systemName: "xmark.square.fill")
                                            .font(Font.title)
                                            .symbolRenderingMode(.palette)
                                            .foregroundStyle(.white, .red)
                                    }.offset(x:-15,y:15)
                                }
                            }
                    }
                }
                
            })
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(isEditing ? "Done" : "Edit") {
                    withAnimation { isEditing.toggle() }
                }
            }
        }
    }//body
        
}

#Preview {
    OffWorkView()
        .environmentObject(ShopStore())
}




struct BackWorkButtonTurn: View {
    @Binding var tech: Tech
    
    var body: some View {
        Button(action: {
            tech.isWork.toggle()
            tech.date = Date.now
        }, label: {
            OffTech(tech: tech)
        })
    }
}

