//
//  ContentView.swift
//  FeedReader
//
//  Created by Norbu Sonam on 2/28/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationSplitView {
            List(model.employees, selection: $employeeIds) { employee in
                Text(employee.name)
            }
        } detail: {
            EmployeeDetails(for: employeeIds)
        }
    }
}

#Preview {
    ContentView()
}
