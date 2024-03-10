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
        ForEach(shop.phien()){ tech in
            if tech.today && tech.isWork {
                TechButtonTurnView(tech: binding(for: tech))
            }
        }
        .onMove(perform: move)
    }
    
    private func binding(for tech: Tech) -> Binding<Tech>{
        guard let techIndex = shop.shop.techs.firstIndex(where: {$0.id == tech.id}) else {
            fatalError("Can't get technician!")
        }
        return $shop.shop.techs[techIndex]
    }
    
    private func move(from: IndexSet, to: Int){
        withAnimation {
            shop.shop.techs.move(fromOffsets: from, toOffset: to)
        }
    }
}

#Preview {
    WorkingView()
        .environmentObject(ShopStore())
}
