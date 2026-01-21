# 🚀 Claude Code Launcher for Beginners

**CLIが怖い？Gitが分からない？大丈夫！ダブルクリックするだけでOK！**

Claude Code CLIを初心者でも簡単に使えるようにするランチャーツールです。

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Platform](https://img.shields.io/badge/platform-Windows_Only-blue.svg)

> ⚠️ **Windows専用です！** Mac/Linuxには対応していません。（対応版のPull Request歓迎！）

---

## ✨ 特徴

- 🖱️ **ダブルクリックで起動** - コマンド入力不要
- 📁 **フォルダ選択ダイアログ** - GUIで直感的に選択
- 🔄 **Git自動設定** - 無ければ自動で初期化
- 💾 **自動バックアップ** - 作業前に自動コミット
- 📋 **チートシート付き** - コマンド一覧がブラウザで開く
- 🎨 **おしゃれなUI** - クリックでコマンドをコピー

---

## 📦 必要なもの

- Windows 10/11
- [Claude Code CLI](https://claude.ai/code) がインストール済み
- [Git](https://git-scm.com/) がインストール済み

---

## 🔧 インストール方法

### 1. ダウンロード

```
[Code] → [Download ZIP] からダウンロード
```

または

```bash
git clone https://github.com/Hachibei0321/claude-code-launcher.git
```

### 2. 好きな場所に解凍

例: `C:\Tools\claude-code-launcher\`

### 3. （オプション）グローバル設定を適用

```powershell
# PowerShellで実行
Copy-Item ".\global_claude_config\*" "$env:USERPROFILE\.claude\" -Force
```

---

## 🚀 使い方

### `Claude起動.bat` をダブルクリック！

それだけです。

1. 📋 チートシートがブラウザで開く
2. 📁 フォルダ選択ダイアログが表示
3. 🔄 Gitが無ければ自動初期化
4. 💾 現在の状態を自動コミット
5. 🤖 Claude Code (Sonnet) が起動！

---

## 📁 ファイル構成

```
claude-code-launcher/
├── Claude起動.bat              # ← これをダブルクリック！
├── start_claude_with_dialog.ps1  # メインスクリプト
├── cheatsheet.html              # ショートカット一覧（ブラウザ表示）
├── global_claude_config/        # グローバル設定テンプレート
│   ├── CLAUDE.md               # Claude Codeへの共通指示
│   └── settings.json           # 権限設定
└── README.md                    # このファイル
```

---

## 📋 チートシート機能

起動と同時にブラウザでチートシートが開きます。

- **キーボードショートカット** - 見るだけ
- **スラッシュコマンド** - クリックでコピー → Ctrl+Vで貼り付け
- **Gitコマンド** - クリックでコピー
- **よく使うプロンプト** - 日本語でそのままコピー

---

## ⚙️ カスタマイズ

### モデルを変更したい場合

`start_claude_with_dialog.ps1` の最後の行を編集：

```powershell
# Sonnet (デフォルト・バランス型)
claude --model sonnet

# Opus (高精度・枠消費大)
claude --model opus
```

### デフォルトフォルダを変更したい場合

`start_claude_with_dialog.ps1` の `SelectedPath` を編集：

```powershell
$folderBrowser.SelectedPath = "C:\Your\Default\Path"
```

---

## 🤝 Contributing

Issue や Pull Request 歓迎です！

特に以下の改善を募集中：
- [ ] Mac/Linux対応
- [ ] 多言語対応
- [ ] より多くのプロンプトテンプレート

---

## 📄 License

MIT License - 自由に使ってください！

---

## 🙏 謝辞

- [Anthropic](https://anthropic.com/) - Claude Code の開発
- このツールを使ってくれる初心者の皆さん

---

**Made with ❤️ for beginners**
