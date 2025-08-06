# 📄 SwiftUI + PDFKit: Crie e Compartilhe PDFs em Minutos

Este projeto demonstra como criar, visualizar e compartilhar **arquivos PDF** usando **SwiftUI** e **PDFKit**.  
Ideal para apps que precisam exportar **treinos, relatórios financeiros ou qualquer documento personalizado**.

---

##  Funcionalidades

- Gerar arquivos PDF diretamente no app
- Visualizar PDFs em uma `SwiftUI View`
- Compartilhar PDFs com outros apps usando `ShareLink`
- Exportar arquivos temporários e salvar no **Files**

---

##  Requisitos

- iOS 15+
- SwiftUI
- PDFKit

---

##  Como Funciona

### 1️ Função para Gerar o PDF

```swift
@MainActor
func generatePDF() -> Data {
    let pdfRenderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: 595, height: 842)) // A4
    let data = pdfRenderer.pdfData { context in
        context.beginPage()
        let attributes: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 28)]
        let text = "Aprendendo a criar um PDF"
        text.draw(at: CGPoint(x: 100, y: 100), withAttributes: attributes)
    }
    return data
}
