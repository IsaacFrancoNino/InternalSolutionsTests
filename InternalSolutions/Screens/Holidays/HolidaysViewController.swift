//
//  HolidaysViewController.swift
//  InternalSolutions
//
//  Created by Trainee on 2/3/25.
//

import Foundation
import SwiftUI

struct HolidaysViewController: View {
    
    let holidays = [
            Holiday(name: "National Pizza Day", date: "February 9"),
            Holiday(name: "International Nap Day", date: "March 15"),
            Holiday(name: "World Donut Appreciation Day", date: "April 7"),
            Holiday(name: "Lazy Sunday", date: "May 22"),
            Holiday(name: "Cat Cuddle Day", date: "June 10"),
            Holiday(name: "Bubble Wrap Popping Day", date: "July 3"),
            Holiday(name: "Ice Cream for Breakfast Day", date: "August 12"),
            Holiday(name: "No Email Day", date: "September 18"),
            Holiday(name: "Pumpkin Spice Celebration", date: "October 5"),
            Holiday(name: "Stay in Pajamas Day", date: "November 20"),
            Holiday(name: "Hot Chocolate & Movie Night", date: "December 8")
        ]
    
    var body: some View {
        NavigationStack {
            List(holidays, id: \.name) { holiday in
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

struct Holiday {
    let name: String
    let date: String
}

