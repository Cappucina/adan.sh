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

        codeEl.textContent = res;
        
        if (window.Prism && Prism.highlightElement) {
            Prism.highlightElement(codeEl);
        }
    } catch (err) {
        codeEl.textContent = `// Could not load ../../assets/hello.adn: ${err.message}`;
    }
});