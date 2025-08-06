
import SwiftUI

//Framework que fornece ferramentar para trabalhar com PDF's
import PDFKit

struct ContentView: View {
    @State var showPDF: Bool = false
    var body: some View {
        VStack {
            Button(
                action:{
                    showPDF = true
                }
            ){
                ZStack{
                    RoundedRectangle(cornerRadius: 15)
                        .foregroundStyle(Color.cyan)
                    Text("Exportar para PDF")
                        .foregroundStyle(Color.black)
                }
                .frame(width: 100, height: 100)
                .sheet(isPresented: $showPDF){
                    if let document = PDFDocument(data: generatePDF()){
                        PDFKitView(pdfData: document)
                    }
                    let tempURL = preparePDF()
                    ShareLink(item: tempURL){
                        Label("Share", systemImage: "square.and.arrow.down")
                    }
                }
            }
        }
        .padding()
    }
}

@MainActor
func generatePDF() -> Data{
    
    //criarmos o pdf, definindo a localização e as dimensões
    let pdfRenderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: 595, height: 842))//Tamanho de uma A4
    
    //Permite desenhar no pdf
    let data = pdfRenderer.pdfData { context in
        
        context.beginPage()
        
        let attributes:[NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 28)]
        
        let text = "Aprendendo a criar um PDF"
        text.draw(at: CGPoint(x: 100, y: 100), withAttributes: attributes)
    }
    
    return data
}


@MainActor
private func preparePDF() -> URL {
    let pdfData = generatePDF()
    let tempURL = FileManager.default.temporaryDirectory.appendingPathComponent("MeuTreino.pdf")
    try? pdfData.write(to: tempURL)
    return tempURL
}


//View do pdf
struct PDFKitView: UIViewRepresentable {
    
    let pdfDocument: PDFDocument
    
    init(pdfData pdfDoc: PDFDocument) {
        self.pdfDocument = pdfDoc
    }
    
    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = pdfDocument
        pdfView.autoScales = true
        return pdfView
    }
    
    func updateUIView(_ pdfView: PDFView, context: Context) {
        pdfView.document = pdfDocument
    }
}





#Preview {
    ContentView()
}
