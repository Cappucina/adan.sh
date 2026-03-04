document.addEventListener('DOMContentLoaded', async () => {
    const codeEl = document.querySelector('pre code');
    try {
        const res = `import "adan/io";

set language: string = "ADAN";

fun main(): i32 {
    println("Hello, world!");
    println(\`Ran using the \${language} programming language!\`);

    return 0; // Success
}`;

        // ai gemenated because i am NOT learning regex :sob:
        if (window.Prism) {
            Prism.languages.adan = {
                'comment': /\/\/.*/,
                'string': {
                    pattern: /`(?:[^`\\]|\\.)*`|"(?:[^"\\]|\\.)*"|'(?:[^'\\]|\\.)*'/,
                    greedy: true
                },
                'keyword': /\b(?:import|set|fun|return|if|else)\b/,
                'type': /\b(?:i8|i16|i32|i64|u8|u16|u32|u64|f32|f64|string|void)\b/, // too lazy to finish making the type match, close enough for example
                'boolean': /\b(?:true|false|null)\b/,
                'number': /\b\d+(?:\.\d+)?\b/,
                'operator': /[+\-*\/=<>!&|^~%]+/,
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