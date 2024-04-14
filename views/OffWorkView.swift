//
//  OffWorkView.swift
//  Phien
//
//  Created by Jubi on 3/7/24.
//


import SwiftUI

struct OffWorkView: View {
    @EnvironmentObject var shop: ShopStore
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    var cot: [GridItem] {
        if horizontalSizeClass == .compact {
            return [GridItem(spacing: 5, alignment: .center),
                       GridItem(spacing: 5, alignment: .center),
                       GridItem(spacing: 5, alignment: .center),]
        } else {
            return [GridItem(spacing: 5, alignment: .center),
                    GridItem(spacing: 5, alignment: .center),
                    GridItem(spacing: 5, alignment: .center),
                   GridItem(spacing: 5, alignment: .center),
                    GridItem(spacing: 5, alignment: .center)]
        }
    }
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
            tech.isWork = true
            tech.date = Date.now
        }, label: {
            OffTech(tech: tech)
        })
    }
}


struct OffTech: View {
    var tech: Tech
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 10)
                .fill()//randomColor here
                .frame(width: 130, height: 100)
                .overlay{
                    VStack {
                        Text(String(tech.name.first!))
                            .font(.system(size: 45))
                            
                        Text(tech.name).font(.system(size: 30))
                    }.foregroundStyle(.background)
                }
        }.padding()
            .foregroundStyle(.gray)
    }
}
