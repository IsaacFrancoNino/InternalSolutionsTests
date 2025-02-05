//
//  HolidaysViewController.swift
//  InternalSolutions
//
//  Created by Trainee on 2/3/25.
//

import Foundation
import SwiftUI

struct HolidaysViewController: View {
    
    @ObservedObject var viewModel: HolidaysViewModel
    
    init(viewModel: HolidaysViewModel) {
        self.viewModel = viewModel
        viewModel.getHolidays()
    }
    
    var body: some View {
        NavigationStack {
            List(viewModel.holidays, id: \.name) { holiday in
                HStack {
                    VStack (alignment: .leading) {
                        Text (holiday.name)
                            .font(.headline)
                        Text (holiday.date)
                            .font(.subheadline)
                            .foregroundStyle(Color.gray)
                    }
                }
                .padding()
            }
            .navigationTitle("Fake Holidays")
        }
    }
}

