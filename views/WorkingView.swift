//
//  WorkingView.swift
//  Phien
//
//  Created by Jubi on 3/7/24.
//

import SwiftUI

struct WorkingView: View {
    @EnvironmentObject var shop: ShopStore
    
    var body: some View {
        ScrollView {
            
            ForEach(shop.phien(chon: shop.shop.chon)){ tech in
                TechButtonTurnView(tech: binding(for: tech))
            }
           
        }
        .toolbar {
            ToolbarItem(placement: .principal, content: {
                Toggle(modeNut, isOn: $shop.shop.chon)
                    .tint(shop.shop.chon ? .green : .blue)
                    .padding(.horizontal, 8)
                    .background(
                        Capsule()
                            .fill(shop.shop.chon ? .green.opacity(0.1) : .blue.opacity(0.1))
                    )
                
            })
        }
        
    }
    var modeNut: String {
        shop.shop.chon ? "Turn" : "Time"
    }
    private func binding(for tech: Tech) -> Binding<Tech>{
        guard let techIndex = shop.shop.techs.firstIndex(where: {$0.id == tech.id}) else {
            return .constant(tech)
        }
        return $shop.shop.techs[techIndex]
    }
}

#Preview {
    WorkingView()
        .environmentObject(ShopStore())
}

