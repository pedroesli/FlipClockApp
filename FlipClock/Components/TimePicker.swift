//
//  TestView.swift
//  FlipClock
//
//  Created by Pedro Ésli Vieira do Nascimento on 14/08/23.
//

import SwiftUI

struct TimePicker: View {
    
    @Binding var hour: Int
    @Binding var minute: Int
    @Binding var second: Int
    
    var body: some View {
        #if os(iOS)
            if UIDevice.current.userInterfaceIdiom == .pad {
                ZStack {
                    NeoRoundedRectangle(configuration: .dial)
                        .aspectRatio(1, contentMode: .fit)
                        .padding(-70)
                    UITimePickerRepresentable(hour: $hour, minute: $minute, second: $second)
                        .overlay {
                            TimePickerOverlay()
                        }
                }
                .fixedSize()
            } else {
                NeoRoundedRectangle(configuration: .dial)
                    .aspectRatio(1, contentMode: .fit)
                    .overlay {
                        UITimePickerRepresentable(hour: $hour, minute: $minute, second: $second)
                            .overlay {
                                TimePickerOverlay()
                            }
                    }
            }
        #else
            TextFieldTimePicker(hour: $hour, minute: $minute, second: $second)
        #endif
    }
    
    #if os(iOS)
    struct TimePickerOverlay: View {
        var body: some View {
            HStack(spacing: 0) {
                Group {
                    Text(Localization.TimePicker.hour)
                        .offset(x: 22)
                    Text(Localization.TimePicker.minute)
                        .offset(x: 14)
                    Text(Localization.TimePicker.second)
                }
                .frame(maxWidth: .infinity)
                .offset(x: 18)
            }
            .font(.body.bold())
            .foregroundColor(.primary)
        }
    }
    #endif
}

struct TimePicker_Previews: PreviewProvider {
    static var previews: some View {
        TimePicker(hour: .constant(0), minute: .constant(0), second: .constant(0))
            .environmentObject(SettingsManager())
    }
}

#if os(iOS)
struct UITimePickerRepresentable: UIViewRepresentable {
    
    @Binding var hour: Int
    @Binding var minute: Int
    @Binding var second: Int
    
    func makeUIView(context: Context) -> UIPickerView {
        let picker = UIPickerView()
        picker.dataSource = context.coordinator
        picker.delegate = context.coordinator
        picker.selectRow(hour, inComponent: 0, animated: false)
        picker.selectRow(minute, inComponent: 1, animated: false)
        picker.selectRow(second, inComponent: 2, animated: false)
        return picker
    }
    
    func updateUIView(_ picker: UIPickerView, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    internal class Coordinator: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
        
        var parent: UITimePickerRepresentable
        
        init(_ parent: UITimePickerRepresentable) {
            self.parent = parent
        }
        
        let time = [
            Array(0...23),
            Array(0...59),
            Array(0...59)
        ]
        
        func numberOfComponents(in pickerView: UIPickerView) -> Int {
            return time.count
        }
        
        func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return time[component].count
        }
        
        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
            return String(time[component][row])
        }
        
        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
            switch component {
            case 0: parent.hour = time[0][row]
            case 1: parent.minute = time[1][row]
            default: parent.second = time[2][row]
            }
        }
    }
}
#endif
#if os(macOS)
struct TextFieldTimePicker: View {
    
    enum DialOption: Int {
        case hour
        case minute
        case second
        case none
        
        mutating func next() {
            print("Next")
            let next = self.rawValue + 1
            if next < Self.none.rawValue {
                self = DialOption(rawValue: next)!
            }
            self = .hour
        }
    }
    
    @Binding var hour: Int
    @Binding var minute: Int
    @Binding var second: Int
    @State private var selectedDial: DialOption = .none
    @State private var hourText = "00"
    @State private var minuteText = "00"
    @State private var secondText = "00"
    
    var body: some View {
        ZStack {
            NeoRoundedRectangle(configuration: .dial)
            HStack(spacing: 0) {
                TimePickerDial(text: hourText, dial: .hour, selectedDial: $selectedDial)
                    .onTapGesture {
                        selectedDial = .hour
                    }
                Colon()
                TimePickerDial(text: minuteText, dial: .minute, selectedDial: $selectedDial)
                    .onTapGesture {
                        selectedDial = .minute
                    }
                Colon()
                TimePickerDial(text: secondText, dial: .second, selectedDial: $selectedDial)
                    .onTapGesture {
                        selectedDial = .second
                    }
            }
            .padding()
            .background {
                ZStack {
                    ForEach((0...9), id: \.self) { number in
                        let keyboardShortcut = KeyboardShortcut(
                            KeyEquivalent(Character("\(number)")),
                            modifiers: .numericPad
                        )
                        Button("") {
                            handleKeyPress(keyNumber: number)
                        }
                        .keyboardShortcut(keyboardShortcut)
                    }
                    Button("") {
                        print("Tab")
                        selectedDial.next()
                    }
                    .keyboardShortcut(.tab)
                }
                .opacity(0)
            }
        }
        .fixedSize()
        .onAppear {
            hourText = hour.formattedTime()
            minuteText = minute.formattedTime()
            secondText = second.formattedTime()
        }
    }
    
    func handleKeyPress(keyNumber: Int) {
        switch selectedDial {
        case .hour:
            let formated = formatKeyNumber(keyNumber, dialText: hourText, maxRange: 23)
            hourText = formated
            hour = Int(formated) ?? 0
        case .minute:
            let formated = formatKeyNumber(keyNumber, dialText: minuteText, maxRange: 59)
            minuteText = formated
            minute = Int(formated) ?? 0
        case .second:
            let formated = formatKeyNumber(keyNumber, dialText: secondText, maxRange: 59)
            secondText = formated
            second = Int(formated) ?? 0
        default: break
        }
    }
    
    func formatKeyNumber(_ keyNumber: Int, dialText: String, maxRange: Int) -> String {
        var formated = dialText.appending(String(keyNumber))
        formated.removeFirst()
        if Int(formated)! > maxRange {
            return "0".appending(String(keyNumber))
        }
        return formated
    }
    
    struct TimePickerDial: View {
        let text: String
        let dial: DialOption
        @Binding var selectedDial: DialOption
        @EnvironmentObject private var settingsManager: SettingsManager
        
        var body: some View {
            Text(text)
                .font(.system(size: 110).width(.compressed).monospacedDigit())
                .background {
                    if selectedDial == dial {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(settingsManager.appColor)
                    }
                }
        }
    }
    
    struct Colon: View {
        var body: some View {
            Text(":")
                .font(.system(size: 80).width(.compressed))
                .multilineTextAlignment(.center)
                .offset(y: -8)
        }
    }
}
#endif
