//
//  TechButtonTurnView.swift
//  Phien
//
//  Created by Jubi on 3/7/24.
//


import SwiftUI

struct TechButtonTurnView: View {
    @Binding var tech: Tech
    @State private var showListservicesView = false
    @EnvironmentObject var shop: ShopStore
    var nutNghi: some Gesture {
        LongPressGesture()
            .onEnded { value in
                withAnimation {
                    tech.isWork = false
                }
            }
    }
    var dvHnay: [Service]{
        tech.servDone.filter{$0.today}
    }
    var body: some View {
        HStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(tech.today ? tech.maungauNhien : .gray).opacity(/*@START_MENU_TOKEN@*/0.8/*@END_MENU_TOKEN@*/)
                .gesture(nutNghi)
                .frame(width: 115, height: 100)
                .overlay{
                    VStack {
                        HStack(alignment: .top){
                            Text(String(tech.name.first!))
                                .font(.system(size: 42))
                            VStack {
                                Text("\(dvHnay.count)")
                                    .monospacedDigit()
                                    .font(.system(size: 30))
                                Text("\(tech.date.formatted(.dateTime.hour().minute()))")
                            }
                        }
                            
                        Text(tech.name).font(.system(size: 20))
                    }.foregroundStyle(.background)
                }
            dichVu
            Spacer()
            themDv
        }
        
            .sheet(isPresented: $showListservicesView) {
                NavigationStack {
                    ListServicesView(tech: $tech, services: $shop.shop.services)
                }
            }
    }//body
    var dichVu: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack {
                ForEach(dvHnay){ser in
                    ServiceBlockView(serv: ser)
                }
            }.frame(minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxHeight: .greatestFiniteMagnitude)
        }
//        .frame(height: 100)
//        .transition(.move(edge: .bottom))
    }
    
    var themDv: some View {
        Button(action: {
            showListservicesView = true
        }, label: {
            Label("", systemImage: "plus").font(.system(size: 30))
        })
        .frame(width: 50, height: 50, alignment: .center)
    }
}

#Preview {
    TechButtonTurnView(tech: .constant(Tech.techMau[0]))
        .environmentObject(ShopStore())
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
