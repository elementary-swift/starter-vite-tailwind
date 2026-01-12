import ElementaryUI

@View
struct ContentView {
    @State var model = Model()

    var body: some View {
        main(.class("min-h-screen bg-slate-50 flex flex-col items-center p-6 sm:p-10")) {
            div(.class("w-full max-w-lg space-y-4")) {
                h1(.class("text-2xl font-bold")) { "My Tailwind List" }

                NewItemView { newItem in
                    withAnimation {
                        model.addItem(newItem)
                    }
                }

                div(
                    .class("rounded-2xl bg-white shadow-md overflow-hidden")
                ) {
                    ForEach(model.items, key: { $0.id }) { item in
                        div(
                            .class(
                                "flex items-center gap-3 px-4 py-3 border-b border-slate-100 last:border-b-0"
                            )
                        ) {
                            div(.class("min-w-0 flex-1")) {
                                p(.class("text-sm font-medium text-slate-900")) { item.title }
                                p(.class("mt-1 text-xs text-slate-500")) { item.detail }
                            }

                            button(
                                .class(
                                    "size-8 flex items-center justify-center rounded-full text-slate-400 hover:bg-red-50 hover:text-red-600"
                                )
                            ) {
                                "×"
                            }
                            .onClick {
                                withAnimation {
                                    model.removeItem(item.id)
                                }
                            }
                        }.transition(.fade)
                    }

                    if model.items.isEmpty {
                        p(.class("text-center text-slate-400 py-2")) { "No items" }
                            .transition(.fade)
                    }
                }
                .animateContainerLayout()
            }
        }
    }
}

@View
private struct NewItemView {
    @State var text: String = ""
    var onAdd: (String) -> Void

    var body: some View {
        div(
            .class(
                "flex overflow-hidden rounded-xl bg-white shadow-sm ring-1 ring-slate-200 focus-within:ring-slate-400"
            )
        ) {
            input(
                .type(.text),
                .placeholder("Add an item…"),
                .class(
                    "flex-1 bg-transparent px-3 py-2 text-sm text-slate-900 outline-none"
                )
            )
            .bindValue($text)
            .onKeyDown { event in
                guard event.isEnterKey else { return }
                submit()
            }

            button(
                .class(
                    "bg-slate-900 px-4 py-2 text-sm font-medium text-white hover:bg-slate-800 disabled:bg-slate-400"
                )
            ) {
                "Add"
            }
            .attributes(.disabled, when: text.isEmpty)
            .onClick {
                submit()
            }
        }
    }

    private func submit() {
        guard !text.isEmpty else { return }
        onAdd(text)
        text = ""
    }
}

extension KeyboardEvent {
    var isEnterKey: Bool {
        key.utf8.elementsEqual("Enter".utf8)
    }
}
