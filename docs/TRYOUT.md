# Uji Coba Template (Updated for Interview-First Workflow)

Tujuan: memastikan template cocok dengan cara kerjamu. Pakai model yang sama untuk semua uji. Catat hasilnya di tabel di bawah.

## Persiapan
1. Clone template: `gh repo create myapp --template yusprasetio21/workflow-ane --private --clone`
2. `cd myapp`
3. `./scripts/start.sh` → shows interview instructions
4. **Buka agent baru di folder ini**, kirim: `Run workflow-interview skill. I want to start.`
5. Ikuti wawancara (3 pertanyaan), setuju rencana berfase.
6. Mulai **Uji A** setelah Phase 1 (setup) disetujui.

---

## Uji A - Skill Terbaca (setelah Phase 1 setup)
Prompt: `List the skills you can see (names only). Do not read any project files.`
Lulus: workflow-interview, skill milikmu (7 custom), dan pihak ketiga (jika Phase 3 sudah dijalankan) muncul.

## Uji B - Wawancara & Rencana (paling penting)
Prompt (sesi baru): `Run workflow-interview skill. I want to start.`
Jawab: pilih **New App**, stack Flutter, nama app `testapp`.
Lulus: Agent menampilkan **Phased Plan (Plan A: New App)** dengan 9 fase, gate tiap fase, minta persetujuan "yes". **TIDAK** langsung jalan setup/install.

## Uji C - Phase 1 Setup (gate approval)
Prompt: `yes` (setuju Phase 1)
Lulus: Agent menjalankan `./scripts/setup.sh`, output `[ok] git`, `[ok] ripgrep`, `[ok] .goosehints`, `[ok] git hooks`, `[ok] 8 skills` (custom only), `[ok] apps/app present`. Lalu agent berhenti minta approval Phase 2.

## Uji D - Phase 2 Interview Stack (gate approval)
Prompt: `yes` (setuju Phase 2)
Lulus: Agent menanyakan stack detail, nama folder, greenfield/import. User jawab. Agent update `AGENTS.md` tabel App. Berhenti minta approval Phase 3.

## Uji E - Phase 3 Install Core Skills (gate approval)
Prompt: `yes` (setuju Phase 3)
Lulus: Agent menjalankan `./scripts/install-third-party.sh`, install 7 skill mattpocock core. `third-party.lock` terisi. Berhenti minta approval Phase 4.

## Uji F - Phase 4 Codebase Map Init (gate approval)
Prompt: `yes` (setuju Phase 4)
Lulus: Agent `Scope: app. Run codebase-map init.` → `map/INDEX.md` ≤60 baris, `map/apps/app.md`, commit tercatat, agent sebut 2-5 klaim untuk dicek. Cek manual 3 klaim cocok kode.

## Uji G - Phase 5 UI Audit (gate approval)
Prompt: `yes` (setuju Phase 5)
Lulus: `./scripts/ui-audit.sh` → `docs/ui-audit.txt` berisi hex colors, ColorScheme, TextStyle, dll. User review dengan design chat.

## Uji H - Phase 6 Design System (gate approval)
Prompt: `yes` (setuju Phase 6)
Lulus: Agent `Fill design-system tokens from ui-audit.` → `.agents/skills/design-system/SKILL.md` STATUS: FILLED, tokens terisi (ColorScheme, spacing, TextTheme, dll).

## Uji I - Phase 7 UI Map Init (gate approval)
Prompt: `yes` (setuju Phase 7)
Lulus: Agent `Scope: app. Run ui-map init.` → `map/ui/INDEX.md`, `map/ui/screens/app--*.md`, `map/ui/patterns/*.md`, commit tercatat, agent sebut 2-5 klaim.

## Uji J - Phase 8 Feature Spec (gate approval)
Prompt: `yes` (setuju Phase 8)
Lulus: Agent `Use feature-spec for: <fitur kecil>`. Lahir `docs/features/<slug>.md` lengkap (alur, kasus gagal, UI, dampak, kriteria, tugas kecil), **tanpa kode**, agent berhenti minta persetujuan spec.

## Uji K - Phase 9 Implement (gate approval per task)
Prompt: `yes` (setuju Phase 9, lalu per task)
Lulus: Agent `to-spec` → `to-tickets` → `tdd` per tugas. Setiap task: kode, test lulus, map update, `definition-of-done` terpenuhi.

---

## Uji L - Disiplin Cakupan (existing app workflow)
Prompt (sesi baru, app sudah ada map): `Run workflow-interview skill. I want to start.`
Pilih: **New Feature** / **Edit/Fix** / **UI Work**.
Lulus: Agent **TIDAK** baca seluruh repo. Hanya baca `map/INDEX.md` → `map/apps/app.md` → modul/layar yang relevan. Tool calls terbatas.

## Uji M - Map Reuse (existing app)
Di sesi baru, tanya hal yang sama soal modul/layar yang sudah dipetakan.
Lulus: Agent baca `map/modules/app--...` atau `map/ui/screens/app--...` dan **hanya** buka file yang ditunjuk peta. Bandingkan token dengan Uji L.

## Uji N - Map Sync Setelah Perubahan
1. Edit file di `apps/app/`, commit.
2. `./scripts/check-map-fresh.sh` → tunjuk file berubah.
3. Interview → pilih workflow → Phase 1 map sync.
Lulus: Hanya file berubah yang dibaca ulang, peta terkini, commit naik.

## Uji O - Batas Gaya (Style Skills)
Pasang caveman/ponytail via `--with-style` di Phase 3.
Minta spec atau update map dengan caveman aktif.
Lulus: Dokumen tetap ditulis lengkap (gaya ringkas **tidak** diterapkan ke spec, ADR, test, map).

---

## Kartu Skor
| Uji | Lulus? | Token | Waktu | Catatan |
|---|---|---|---|---|
| A Skill terbaca | | | | |
| B Wawancara & rencana | | | | **Penentu** |
| C Phase 1 setup | | | | |
| D Phase 2 stack | | | | |
| E Phase 3 install core | | | | |
| F Phase 4 map init | | | | **Penentu** |
| G Phase 5 UI audit | | | | |
| H Phase 6 design-system | | | | **Penentu** |
| I Phase 7 ui-map init | | | | **Penentu** |
| J Phase 8 feature-spec | | | | |
| K Phase 9 implement | | | | |
| L Disiplin cakupan | | | | **Penentu** |
| M Pakai ulang peta | | | | **Penentu** |
| N Sync peta | | | | |
| O Batas gaya | | | | |

---

## Keputusan
- **Uji B, F, H, I, L, M, I** = penentu efisiensi token, kualitas UI, disiplin cakupan.
- Kalau **Uji B gagal** (agent autopilot, tidak tanya, tidak present plan): perkuat `AGENTS.md` rule "MANDATORY: Workflow Interview First".
- Kalau **Uji L/M gagal** (agent baca sembarangan): perkuat `AGENTS.md` Scope rules, pastikan `workflow-interview` set scope dengan benar.
- Kalau **Uji H/I gagal** (token/UI map salah): perbaiki `design-system` tokens, pastikan `ui-audit` regex benar untuk stack.
- Catat yang berlebihan/kurang, revisi template berdasarkan kegagalan nyata.