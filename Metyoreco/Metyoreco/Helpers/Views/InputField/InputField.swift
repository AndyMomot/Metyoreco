////
////  InputField.swift
////  Tradifundint
////
////  Created by Andrii Momot on 08.07.2024.
////
//
//import SwiftUI
//
//struct InputField: View {
//    var style: Style = .text
//    var title: String
//    var placeholder: String
//    @Binding var text: String
//    
//    @State private var showCalendarPicker = false
//    @State private var selectedDate: Date = .init()
//    
//    var body: some View {
//        VStack(alignment: .leading) {
//            Text(title)
//                .foregroundStyle(Colors.blackCustom.swiftUIColor)
//                .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
//            
//            HStack(spacing: 10) {
//                switch style {
//                case .text:
//                    TextField(text: $text) {
//                        Text(placeholder)
//                            .foregroundStyle(Colors.grayDark.swiftUIColor)
//                            .font(Fonts.SFProDisplay.lightItalic.swiftUIFont(size: 16))
//                    }
//                    .foregroundStyle(Colors.blackCustom.swiftUIColor)
//                    .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
//                    .padding(.vertical, 28)
//                    .padding(.horizontal, 12)
//                case .date:
//                    if text.isEmpty {
//                        Text(placeholder)
//                            .foregroundStyle(Colors.grayDark.swiftUIColor)
//                            .font(Fonts.SFProDisplay.lightItalic.swiftUIFont(size: 16))
//                            .padding(.vertical, 28)
//                            .padding(.horizontal, 12)
//                            .onTapGesture {
//                                withAnimation {
//                                    showCalendarPicker.toggle()
//                                }
//                            }
//                    } else {
//                        Text(text)
//                            .foregroundStyle(Colors.blackCustom.swiftUIColor)
//                            .font(Fonts.SFProDisplay.medium.swiftUIFont(size: 16))
//                            .padding(.vertical, 28)
//                            .padding(.horizontal, 12)
//                            .onTapGesture {
//                                withAnimation {
//                                    showCalendarPicker.toggle()
//                                }
//                            }
//                    }
//                    
//                    Spacer()
//                    
//                    Button {
//                        withAnimation {
//                            showCalendarPicker.toggle()
//                        }
//                    } label: {
//                        Asset.calendar.swiftUIImage
//                    }
//                    .padding()
//                }
//            }
//            .overlay {
//                DashedBorder(color: Colors.blackCustom.swiftUIColor)
//            }
//            
//            if showCalendarPicker {
//                DatePicker("Select Date",
//                           selection: $selectedDate,
//                           in: Date()...,
//                           displayedComponents: .date)
//                    .datePickerStyle(GraphicalDatePickerStyle())
//                    .labelsHidden()
//            }
//        }
//        .onChange(of: selectedDate) { value in
//            text = selectedDate.toString(format: .ddMMyy)
//            
//            withAnimation {
//                showCalendarPicker.toggle()
//            }
//        }
//    }
//}
//
//extension InputField {
//    enum Style {
//        case text
//        case date
//    }
//}
//
//#Preview {
//    InputField(
//        style: .date,
//        title: "Название проекта",
//        placeholder: "Введите данные...",
//        text: .constant("")
//    )
//}
