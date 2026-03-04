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

        // Register the ADAN language grammar for Prism
        if (window.Prism) {
            Prism.languages.adan = {
                'comment': /\/\/.*/,
                'string': {
                    pattern: /`(?:[^`\\]|\\.)*`|"(?:[^"\\]|\\.)*"|'(?:[^'\\]|\\.)*'/,
                    greedy: true
                },
                'keyword': /\b(?:import|export|set|fun|return|if|else|while|for|in|match|break|continue|use)\b/,
                'type': /\b(?:i8|i16|i32|i64|u8|u16|u32|u64|f32|f64|string|bool|void|char)\b/,
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