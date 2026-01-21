# 🚀 Claude Code Launcher for Beginners

**CLIが怖い？Gitが分からない？大丈夫！ダブルクリックするだけでOK！**

Claude Code CLIを初心者でも簡単に使えるようにするランチャーツールです。

![License](https://img.shields.io/badge/license-MIT-blue.svg)
![Platform](https://img.shields.io/badge/platform-Windows_Only-blue.svg)

> ⚠️ **Windows専用です！** Mac/Linuxには対応していません。（対応版のPull Request歓迎！）

---

## ✨ 特徴

- 🎮 **統合ランチャー** - 全ツールにここからアクセス
- 🖱️ **ダブルクリックで起動** - コマンド入力不要
- 📁 **フォルダ選択ダイアログ** - GUIで直感的に選択
- 🔄 **Git自動設定** - 無ければ自動で初期化
- 💾 **自動バックアップ** - 作業前・作業後に自動保存
- 📋 **チートシート付き** - コマンド一覧が常に手元に
- 🔄 **モード切替** - Claude(Anthropic) / GLM(Z.AI) をワンクリック切替
- 🎨 **おしゃれなUI** - ダークモードで目に優しい

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

### `Claudeランチャー.bat` をダブルクリック！

メニューが開きます。そこから好きなツールを選んでください：

1. **🚀 Claude 起動** - Setup & Start
2. **✅ 作業終了** - Commit & Save
3. **📁 新規プロジェクト** - init & CLAUDE.md
4. **💾 自動バックアップ** - Backup all projects
5. **🔄 モード切替** - Switch API

### チートシート

ランチャーの上部タブ「📋 チートシート」をクリックすると表示されます。

---

## 📁 ファイル構成

```
claude-code-launcher/
├── Claudeランチャー.bat       # ← メインメニューにはこれ！
├── launcher.html             # UI本体（ブラウザ表示）
├── Claude起動.bat            # 直接起動用
├── 作業終了.bat              # 終了用ツール
├── 新規プロジェクト.bat       # 新規作成ツール
├── 自動バックアップ.bat      # バックアップツール
├── モード切替.bat            # API切替ツール
├── start_claude_with_dialog.ps1
├── global_claude_config/     # 設定テンプレート
├── mode_configs/             # モード定義
└── README.md                 # このファイル
```

---

## ⚙️ よくある質問

### Q. GLMモードを使うには？
1. ランチャーから「モード切替」を選択
2. 初回は「GLM」を押すとAPIキーの設定方法が表示されます
3. `mode_configs\settings_glm.json` にAPIキーを入力してください

### Q. 自動バックアップを定期実行したい
Windowsのタスクスケジューラに `auto_backup.ps1` を登録すると、毎日自動でバックアップできます。

---

## 🤝 Contributing

Issue や Pull Request 歓迎です！

特に以下の改善を募集中：
- [ ] Mac/Linux対応（シェルスクリプト版）
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
