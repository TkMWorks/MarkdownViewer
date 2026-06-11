const uploadScreen = document.getElementById('upload-screen');
const renderScreen = document.getElementById('render-screen');
const dropZone     = document.getElementById('drop-zone');
const fileInput    = document.getElementById('file-input');
const browseBtn    = document.getElementById('browse-btn');
const output       = document.getElementById('output');
const fileNameEl   = document.getElementById('file-name');

let lastHTML = '';

// Configure marked — GFM + line breaks
marked.use({ gfm: true, breaks: true });

function renderMarkdown(text, filename) {
  const html = marked.parse(text);
  output.innerHTML = html;

  // Syntax-highlight every code block
  output.querySelectorAll('pre code').forEach(block => {
    hljs.highlightElement(block);
  });

  // Activate task-list checkboxes (read-only)
  output.querySelectorAll('input[type="checkbox"]').forEach(cb => {
    cb.disabled = true;
  });

  fileNameEl.textContent = filename;
  lastHTML = html;

  uploadScreen.style.display = 'none';
  renderScreen.style.display = 'flex';
}

function processFile(file) {
  if (!file) return;
  const name = file.name.toLowerCase();
  if (!['.md', '.markdown', '.txt'].some(ext => name.endsWith(ext))) {
    alert('Please choose a .md or .markdown file.');
    return;
  }
  const reader = new FileReader();
  reader.onload = e => renderMarkdown(e.target.result, file.name);
  reader.readAsText(file);
}

function resetView() {
  renderScreen.style.display = 'none';
  uploadScreen.style.display = 'flex';
  fileInput.value = '';
  output.innerHTML = '';
}

function copyHTML() {
  if (!lastHTML) return;
  const btn = document.getElementById('copy-btn');
  navigator.clipboard.writeText(lastHTML).then(() => {
    btn.textContent = '✅ Copied!';
    setTimeout(() => { btn.innerHTML = '📋 Copy HTML'; }, 2200);
  }).catch(() => {
    btn.textContent = '❌ Failed';
    setTimeout(() => { btn.innerHTML = '📋 Copy HTML'; }, 2200);
  });
}

  // File input
fileInput.addEventListener('change', e => processFile(e.target.files[0]));
browseBtn.addEventListener('click', e => { e.stopPropagation(); fileInput.click(); });
dropZone.addEventListener('click', () => fileInput.click());

  // Drag & drop
dropZone.addEventListener('dragover', e => {
  e.preventDefault();
  dropZone.classList.add('drag-over');
});
dropZone.addEventListener('dragleave', e => {
  if (!dropZone.contains(e.relatedTarget)) dropZone.classList.remove('drag-over');
});
dropZone.addEventListener('drop', e => {
  e.preventDefault();
  dropZone.classList.remove('drag-over');
  processFile(e.dataTransfer.files[0]);
});

// Paste support — if someone pastes a file (e.g. from Finder)
document.addEventListener('paste', e => {
  const file = e.clipboardData?.files?.[0];
  if (file) processFile(file);
});