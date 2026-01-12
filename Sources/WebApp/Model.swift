import Reactivity

@Reactive
final class Model {
    struct Item {
        let id: String
        var title: String
        var detail: String

        fileprivate init(id: String, title: String, detail: String) {
            self.id = id
            self.title = title
            self.detail = detail
        }
    }

    private var nextId: Int = 0
    private(set) var items: [Item] = []

    init() {
        addItem("Swift in the Browser", detail: "Runs as WebAssembly and mounts to the DOM.")
        addItem("Tailwind CSS", detail: "Utility-first styling for clean, modern UI.")
        addItem("Animations", detail: "Powered by ElementaryUI's built-in animation system.")
    }

    func addItem(_ title: String, detail: String) {
        let id = String(nextId)
        nextId += 1
        let item = Item(id: id, title: title, detail: detail)
        items.append(item)
    }

    func addItem(_ title: String) {
        addItem(title, detail: "I was added later.")
    }

    func removeItem(_ id: String) {
        items.removeAll { $0.id.utf8.elementsEqual(id.utf8) }
    }
}
