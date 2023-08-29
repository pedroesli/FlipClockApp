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
            // TODO: Make a TimePicker for Mac
            Text("Hey")
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
