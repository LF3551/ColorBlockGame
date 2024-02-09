//
//  ContentView.swift
//  colorgame
//
//  Created by Aleksei Aleinikov on 9/2/24.
//
import SwiftUI

struct ContentView: View {
    // Массив цветов для блоков
    let colors: [Color] = [.red, .blue, .green, .yellow]
    
    // Основное состояние игры
    @State private var score = 0
    @State private var blocks: [Block] = []
    
    var body: some View {
        VStack {
            Text("Score: \(score)")
                .font(.title)
                .padding()
            
            // Поле с блоками
            VStack(spacing: 10) {
                ForEach(blocks) { block in
                    block
                        .onTapGesture {
                            self.removeBlock(block)
                        }
                }
            }
            .padding()
            
            Spacer()
        }
        .onAppear {
            // Начинаем генерировать блоки при запуске
            self.generateBlocks()
        }
    }
    
    // Функция для генерации блоков
    private func generateBlocks() {
        // Создаем блоки с цветами из массива colors
        blocks = colors.map { color in
            Block(color: color)
        }
    }
    
    // Функция для удаления блока при нажатии
    private func removeBlock(_ block: Block) {
        // Удаляем блок из массива
        if let index = blocks.firstIndex(where: { $0.id == block.id }) {
            blocks.remove(at: index)
            
            // Увеличиваем счет
            score += 1
            
            // Генерируем новый блок
            let color = colors.randomElement() ?? .black
            let newBlock = Block(color: color)
            blocks.append(newBlock)
        }
    }
}

// Отдельный вид для блока
struct Block: View, Identifiable {
    let id = UUID()
    let color: Color
    
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(width: 100, height: 100)
            .cornerRadius(10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
