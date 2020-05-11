//
//  CalculatorView.swift
//  SWIFTUI P5
//
//  Created by MOHD ALARBASH on 5/11/20.
//  Copyright © 2020 MOHD ALARBASH. All rights reserved.
//

import SwiftUI

enum CalculatorButton: String {
    case zero, one, two, three, four, five, six, seven, eight, nine
    case equal, plus, minus, multiply, divide
    case decimal
    case ac, plusMinus, percent
    
    var title: String {
        switch self {
        case .zero: return "0"
        case .one: return "1"
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        case .plus: return "+"
        case .minus: return "-"
        case .multiply: return "×"
        case .divide: return "÷"
        case .equal: return "="
        case .plusMinus: return "±"
        case .percent: return "%"
        case .decimal: return "."
            
        default:
            return "AC"
            
        }
        
    }
    
    var backgroundColor: Color {
        switch self {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine, .decimal:
            return Color(.darkGray)
        case .ac, .plusMinus, .percent:
            return Color(.lightGray)
        default :
            return .orange
        }
    }
}

//Env Object
class CalcEnv: ObservableObject {
    
    @Published var display = ""
    
    func receiveInput(calculatorButton: CalculatorButton)
    {
        self.display = calculatorButton.title
    }
    
}



struct CalculatorView: View {
    
    @EnvironmentObject var env: CalcEnv
    
    let buttons: [[CalculatorButton]] = [
        [.ac, .plusMinus, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .decimal, .equal]
    ]
    
    var body: some View {
        ZStack (alignment: .bottom){
            Color.black.edgesIgnoringSafeArea(.all)
            
            VStack (spacing: 12){
                
                HStack{
                    Spacer()
                    Text(env.display).foregroundColor(.white)
                        .font(.system(size: 64))
                }.padding()
                
                ForEach(buttons, id: \.self) { row in
                    HStack {
                        ForEach(row, id: \.self) { button in
                            
                            CalculatorButtonView(button: button)
                            
                        }
                    }
                    
                }
            }.padding()
        }
    }
    
}



struct CalculatorButtonView: View {
    @EnvironmentObject var env: CalcEnv
    var button: CalculatorButton
    var body: some View {
        Button(action: {
            
            // Code Click
            self.env.receiveInput(calculatorButton: self.button)
            
        }) {
            Text(button.title)
                .font(.system(size:32 ))
                .frame(width: self.buttonwidth(button: button), height: (UIScreen.main.bounds.width - 5 * 12 ) / 4)
                .foregroundColor(.white)
                .background(button.backgroundColor)
                .cornerRadius(self.buttonwidth(button: button))
        }
    }
    func buttonwidth(button: CalculatorButton) -> CGFloat {
        if button == .zero {
            return (UIScreen.main.bounds.width - 4 * 12 ) / 4 * 2
        }
        return (UIScreen.main.bounds.width - 5 * 12 ) / 4
    }
}


struct HWCalc_Previews: PreviewProvider {
    static var previews: some View {
        CalculatorView()
        .environmentObject(CalcEnv())
    }
}
