# Setup agen (Goose / OpenCode)

## 1. Key FreeLLMAPI
Isi `FREELLMAPI_KEY` di `.env`, lalu muat sebelum membuka agen:
```
set -a; source .env; set +a
```
FreeLLMAPI harus berjalan di mesin yang sama (`http://localhost:3001`).

## 2. OpenCode
- `opencode.json` di root sudah berisi provider FreeLLMAPI. Jalankan OpenCode dari folder ini, ketik `/models`, dan pastikan "FreeLLMAPI" muncul. Kalau tidak, cocokkan format dengan dokumentasi provider OpenCode.
- Untuk uji yang adil, pilih satu model tertentu (bukan `auto`).
- MCP (opsional, hemat): tambahkan di `opencode.json`, pola dari dokumentasi OpenCode (cocokkan sebelum dipakai):
```json
"mcp": {
  "context7": { "type": "local", "command": ["npx", "-y", "@upstash/context7-mcp"] }
}
```
Pin versinya setelah kamu menguji (`@upstash/context7-mcp@<versi>`).

## 3. Goose
- `.goosehints` dibuat oleh `setup.sh` sebagai symlink ke `AGENTS.md`.
- Sambungkan FreeLLMAPI sebagai provider kompatibel OpenAI lewat pengaturan Goose.
- Extension: aktifkan **Developer** dan **Summon** (skills). Tambahkan satu pencarian web dan **Context7** lewat direktori extension. Jaga total tool aktif di bawah 25.

## 4. Pastikan skill terbaca (uji pertama)
Di sesi baru, kirim:
```
List the skills you can see (names only). Do not read any project files.
```
Harus muncul: codebase-map, feature-spec, ui-migration, definition-of-done, design-system, dan skill pihak ketiga yang kamu pasang. Kalau tidak muncul, agen tidak membaca `.agents/skills/` tingkat proyek: salin folder skill ke `~/.agents/skills/` sebagai gantinya.
