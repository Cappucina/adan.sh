document.addEventListener('DOMContentLoaded', async () => {
    const codeEl = document.querySelector('pre code');
    try {
        const res = `import "adan/io";

const language: string = "ADAN";

function main(): i32 {
    set features: string[] = ["safe", "fast", "readable"];

    print("Hello from %s!", language);
    print("Built to run close to the metal.");
    print("Top feature: %s", features[0]);

    return 0; // Success
}`;

        if (window.Prism) {
            Prism.languages.adan = {
                'comment': /\/\/.*|\/\*[\s\S]*?\*\//,
                'string': {
                    pattern: /`(?:[^`\\]|\\.)*`|"(?:[^"\\]|\\.)*"|'(?:[^'\\]|\\.)*'/,
                    greedy: true
                },
                'keyword': /\b(?:function|import|set|const|return|if|else|while|for|break|continue|type|and|or|not)\b/,
                'type': /\b(?:i8|i32|i64|u8|u32|u64|f32|f64|string|void|bool|any)\b/,
                'boolean': /\b(?:true|false)\b/,
                'number': /\b\d+(?:\.\d+)?\b/,
                'operator': /\.\.\.|[+\-*\/=<>!&|^~%]+/,
                'punctuation': /[{}[\];(),.]/
            };
        }

        codeEl.textContent = res;

        if (window.Prism && Prism.highlightElement) {
            Prism.highlightElement(codeEl);
        }
    } catch (err) {
        codeEl.textContent = `// Could not load ../../assets/hello.adn: ${err.message}`;
    }
});