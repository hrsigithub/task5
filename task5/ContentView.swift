//
//  ContentView.swift
//  task5
//
//  Created by Hiroshi.Nakai on 2021/02/17.
//

import SwiftUI

struct AlertDetail: Identifiable {
    let id = UUID()
    let message: String
}

struct ContentView: View {
    @State private var textArray = Array(repeating: "", count: 2)
    @State private var result: Float?
    @State private var errorAlert: AlertDetail?

    var body: some View {
        VStack {
            HStack {
                InputView(text: $textArray[0])
                Text("÷")
                InputView(text: $textArray[1])
            }.padding()

            HStack {
                Button("計算") {
                    guard let num1 = Int(textArray[0]) else {
                        errorAlert = .init(message: "割られる数を入力してください。")
                        return
                    }

                    guard let num2 = Int(textArray[1]) else {
                        errorAlert = .init(message: "割る数を入力してください。")
                        return
                    }

                    if num2 == 0 {
                        errorAlert = .init(message: "割る数には0を入力しないでください。")
                        return
                    }
                    // errorAlert = .init(message: "OK")

                    result = Float(num1) / Float(num2)

                    //                }.alert(isPresented: $isAlert) {
                }.alert(item: $errorAlert) { error in
                    // $errorAlertがnil以外でアラート表示
                    Alert(title: Text("課題5"),
                          message: Text(error.message))
                }
            }.padding()

            HStack {
                // ここで NumberFormatter使用できないのでメソッド化した。
                Text(format(result ?? 0))
            }

            Spacer()
        }
    }

    private func format(_ value: Float) -> String {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 5

        return formatter.string(from: NSNumber(value: value)) ?? ""
    }

}

struct InputView: View {
    @Binding var text: String

    var body: some View {
        TextField("", text: $text)
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.black.opacity(0.5), lineWidth: 1)
            )
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
