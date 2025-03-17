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
    
    private var sortedSections: [String] {
        viewModel.holidaysByLetter.keys.sorted()
    }
    
    init() {
        @Inject var _viewModel: HolidaysViewModel
        self.viewModel = _viewModel
        viewModel.getHolidays()
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(sortedSections, id: \.self) { letter in
                    if let holidays = viewModel.holidaysByLetter[letter] {
                        Section(header: Text(letter).font(.headline)) {
                            HolidaysListView(holidays: holidays)
                        }
                        
                    }
                        
                }
            }
            .navigationTitle(NSLocalizedString("HolidaysVC_navigation_title", comment: "Title"))
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

struct HolidaysListView: View {
    let holidays: [Holiday]

    var body: some View {
        ForEach(holidays, id: \.name) { holiday in
            HolidayRow(holiday: holiday)
        }
    }
}

struct HolidayRow: View {
    let holiday: Holiday
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(holiday.name)
                .font(.headline)
                .fontWeight(.medium)
            Text(holiday.date)
                .font(.caption)
                .foregroundStyle(.gray)
        }
        .padding(.vertical)
    }
}
