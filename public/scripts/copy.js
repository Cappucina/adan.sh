(() => {
    const ICON = `<svg xmlns="http://www.w3.org/2000/svg" width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="1.75" stroke-linecap="round" stroke-linejoin="round">
        <path d="M16 4h2a2 2 0 0 1 2 2v14a2 2 0 0 1-2 2H6a2 2 0 0 1-2-2V6a2 2 0 0 1 2-2h2"/>
        <rect x="8" y="2" width="8" height="4" rx="1" ry="1"/>
    </svg>`;

    const attachCopyButtons = () => {
        document.querySelectorAll('pre[class*="language-"]').forEach((pre) => {
            if (pre.querySelector('.copy-btn')) return;

            const btn = document.createElement('button');
            btn.className = 'copy-btn';
            btn.setAttribute('aria-label', 'Copy code');
            btn.innerHTML = ICON;

            btn.addEventListener('click', () => {
                const code = pre.querySelector('code');
                const text = code ? code.innerText : pre.innerText;
                navigator.clipboard.writeText(text).catch(() => {});
            });

            pre.style.position = 'relative';
            pre.appendChild(btn);
        });
    };

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', attachCopyButtons);
    } else {
        attachCopyButtons();
    }

    window.addEventListener('load', attachCopyButtons);
})();

