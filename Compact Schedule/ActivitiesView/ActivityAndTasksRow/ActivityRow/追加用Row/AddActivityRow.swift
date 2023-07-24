//
//  AddActivityRow.swift
//  Compact Schedule
//
//  Created by 木村友祐 on 2023/07/18.
//

import SwiftUI

struct AddActivityRow: View{
    @State var isActive = false
    var body: some View{
        if isActive{
            AddActivityRow_Active(isActive: $isActive)
        }
        else{
            AddActivityRow_Inactive(isActive: $isActive)
        }
    }
}
