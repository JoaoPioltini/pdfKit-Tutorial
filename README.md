#  SwiftUI + PDFKit: Create and Share PDFs in Minutes

This project shows how to create, display, and share **PDF files** using **SwiftUI** and **PDFKit**.  
Perfect for apps that need to export **workout sheets, financial reports, or any custom document**.

---

##  Features

- Generate PDF files directly within the app  
- Display PDFs inside a `SwiftUI View`  
- Share PDFs with other apps using `ShareLink`  
- Export temporary files and save to **Files app**

---

##  Requirements

- iOS 15+  
- SwiftUI  
- PDFKit  

---

##  How It Works

### Generate a PDF

```swift
@MainActor
func generatePDF() -> Data {
    let pdfRenderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: 595, height: 842)) // A4
    let data = pdfRenderer.pdfData { context in
        context.beginPage()
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 28)]
        let text = "Learning how to create a PDF"
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
