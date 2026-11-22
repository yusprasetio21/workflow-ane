# Uji coba template

Tujuan: memastikan template cocok dengan cara kerjamu. Pakai model yang sama untuk semua uji. Catat hasilnya di tabel di bawah. Untuk token, pakai dashboard FreeLLMAPI.

## Persiapan
1. `./scripts/setup.sh` -> `./scripts/install-third-party.sh` -> letakkan source code di `apps/app/`.
2. Perbarui tabel di `AGENTS.md` (stack app).
3. Buka agen di folder ini dengan sesi baru. Mulai dengan **uji A**.

## Uji A - skill terbaca
Prompt: `List the skills you can see (names only). Do not read any project files.`
Lulus: skill milikmu dan pihak ketiga muncul. Gagal: lihat `docs/AGENT-SETUP.md` bagian 4.

## Uji B - peta awal (init)
Prompt: `Scope: app. Initialize the map for this app (codebase-map, init).`
Lulus: `map/INDEX.md` terisi (<= 60 baris), ada `map/apps/app.md`, baris commit terisi, ada bagian "Not read", dan agen menyebut 2-5 klaim untuk kamu periksa.
Cek sendiri: cocokkan 3-5 klaim dengan kode (path dan nama fungsi benar?).

## Uji C - disiplin cakupan (paling penting)
Prompt (sesi baru): `Scope: app. Explain how the <modul/layar> works.`
Lulus: agen menulis baris `Scope:`, membaca INDEX -> peta app -> (membuat peta modul), dan **hanya membaca source code yang relevan**. Lihat daftar tool call di UI Goose/OpenCode.
Gagal: agen menjelajah seluruh repo atau membaca file yang tidak relevan.

## Uji D - peta modul dipakai ulang
Di sesi baru, ajukan pertanyaan lain tentang modul yang sama.
Lulus: agen membaca `map/modules/app--...` dan hanya membuka file yang ditunjuk peta. Bandingkan token dengan Uji C.

## Uji E - spesifikasi fitur
Prompt: `Scope: app. Use feature-spec for: <fitur kecil, 2-3 kalimat>.`
Lulus: lahir `docs/features/<slug>.md` lengkap (alur, kasus gagal, UI, dampak, kriteria, tugas kecil), **tanpa kode**, lalu agen berhenti meminta persetujuan.

## Uji F - sinkronisasi setelah perubahan
1. Di `apps/app/`, buat commit kecil (atau `git pull`).
2. Jalankan `./scripts/check-map-fresh.sh` -> harus menunjukkan file yang berubah.
3. Prompt: `Scope: app. Run codebase-map sync.`
Lulus: hanya file yang berubah yang dibaca ulang, bagian peta terkait diperbarui, commit di INDEX naik.

## Uji G - batas gaya (jika caveman/ponytail dipasang)
Minta spesifikasi atau pembaruan peta dengan caveman aktif.
Lulus: dokumen tetap ditulis lengkap (gaya ringkas tidak diterapkan ke dokumen).

## Uji H - audit gaya (tanpa AI)
`./scripts/style-audit.sh` (butuh `sudo apt install ripgrep`). Hasilnya di `docs/style-audit.txt`. Tempel ke chat desain untuk menentukan token.

## Uji I - audit UI (tanpa AI)
`./scripts/ui-audit.sh`. Hasilnya di `docs/ui-audit.txt`. Tempel ke chat desain untuk menentukan token skala, komponen shared, motion signature. Lalu isi `design-system` skill.

## Uji J - peta UI (init)
Prompt: `Scope: app. Run ui-map init.`
Lulus: `map/ui/INDEX.md` terisi (token, komponen, layar, pola), ada `map/ui/screens/app--*.md`, `map/ui/patterns/*.md`, commit tercatat, agen menyebut 2-5 klaim untuk dicek.
Cek: cocokkan 3-5 klaim dengan kode (path, token, komponen benar?).

## Uji K - migrasi 1 layar
Prompt: `Scope: app. Run ui-migration <screen>.`
Lulus: Hanya file layar itu yang berubah, pakai token/komponen shared, screenshot before/after, visual test lulus, peta UI diperbarui, `definition-of-done` terpenuhi.

## Kartu skor
| Uji | Lulus? | Token | Waktu | Catatan |
|---|---|---|---|---|
| A skill terbaca | | | | |
| B init peta kode | | | | |
| C disiplin cakupan | | | | |
| D pakai ulang peta kode | | | | |
| E spesifikasi fitur | | | | |
| F sinkronisasi peta kode | | | | |
| G batas gaya | | | | |
| H audit gaya (SCSS) | | | | |
| I audit UI | | | | |
| J init peta UI | | | | |
| K migrasi 1 layar | | | | |

## Keputusan
- Uji C, D, J, K adalah penentu untuk efisiensi token & kualitas UI.
- Kalau Uji C/D gagal: perkuat `AGENTS.md` atau buka agen langsung di `apps/app/`.
- Kalau Uji J/K gagal: perbaiki `design-system` tokens/komponen, pastikan `ui-map` akurat.
- Catat apa yang terasa berlebihan/kurang, revisi template berdasarkan kegagalan nyata.
