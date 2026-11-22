# Workflow Template v0.1.0

Template cara kerja untuk bekerja dengan agen coding (Goose / OpenCode) pada **satu source code** (default), dengan **satu peta** (`map/`) sebagai memori bersama, supaya agen tidak membaca ulang kode yang sama di setiap sesi. Multi-source hanya kalau user minta eksplisit.

## Ide utama
1. **Satu folder induk** (repo privat milikmu) berisi `apps/app` (source code utama) dan **satu peta** `map/`. Bisa tambah source lain nanti kalau user minta.
2. **Cakupan ditentukan kamu** di awal sesi ("app, tugas Y"). Kalau tidak jelas, agen bertanya, bukan membaca semuanya.
3. **Baca bertahap**: `map/INDEX.md` -> `map/apps/app.md` -> `map/modules/app--<module>.md` -> baru kode. Berhenti begitu cukup untuk bertindak.
4. **Setiap bacaan meninggalkan catatan**: peta dibuat bertahap (lazy), dan diperbarui hanya di bagian yang tersentuh (`sync`, berdasarkan commit).
5. **Gaya tidak boleh memangkas dokumen**: caveman/ponytail hanya untuk balasan dan kode, bukan spesifikasi, tes, atau peta.

## Isi
```
AGENTS.md              aturan ringkas (router, cakupan, prioritas)
GLOSSARY.md            bahasa bersama
map/                   SATU peta kode: INDEX, apps/app.md, modules/app--*.md, CROSS-APP.md
map/ui/                SATU peta UI: INDEX, screens/app--*.md, patterns/*.md
docs/                  features/ (spesifikasi), adr/ (keputusan), TRYOUT.md, AGENT-SETUP.md
.agents/skills/        skill milikmu:
  - codebase-map, feature-spec, ui-migration, definition-of-done, design-system
  - ui-audit, ui-map  (UI workflow: audit → tokens → ui-map → migrate)
  - pihak ketiga setelah dipasang (mattpocock core process)
third-party.manifest   daftar skill pihak ketiga (aktif/nonaktif)
scripts/               setup, install-third-party, check-map-fresh, style-audit, ui-audit
.githooks/pre-commit   blokir secret, peringatkan peta yang basi
apps/app/              source code utama (diabaikan git)
```

## Mulai cepat
1. Jadikan repo privat (atau unzip ke folder kerja lalu `git init`).
2. `./scripts/setup.sh`  (cek lingkungan, buat `.env`, aktifkan hook)
3. `./scripts/install-third-party.sh`  (butuh internet; memasang dan **mem-pin** skill pihak ketiga. Baca tiap `SKILL.md` setelahnya)
4. Letakkan source code di `apps/app/` (lihat `apps/README.md`) dan sesuaikan tabel di `AGENTS.md`.
5. Isi key di `.env`, muat (`set -a; source .env; set +a`), lalu buka Goose/OpenCode **di folder ini**.
6. Ikuti **`docs/TRYOUT.md`** untuk menguji apakah template cocok dengan cara kerjamu.

## Yang belum terverifikasi (uji dulu)
- Apakah Goose dan OpenCode versimu membaca skill di `.agents/skills/` tingkat proyek.
- Apakah `.goosehints` (symlink ke AGENTS.md) terbaca oleh Goose.
- Format `opencode.json` provider (pola umum; cocokkan dengan dokumen OpenCode).
- Jalur skill di repo pihak ketiga: skrip mencari folder berdasarkan nama dan berhenti dengan pesan jelas kalau ketemu nol atau lebih dari satu.
- `style-audit.sh` belum dijalankan di lingkungan pembuatnya (butuh `ripgrep`).

## Catatan
- Template ini hanya berisi profil **Vue + SCSS** (lewat skill `design-system`). Profil Rust dan lainnya ditambahkan nanti.
- Isi `design-system` masih kerangka (STATUS: SKELETON). Isi setelah menjalankan `scripts/style-audit.sh`.
- Privasi: kode yang dibaca agen terkirim ke penyedia model. Pastikan kamu berhak mengirim kode aplikasi.
