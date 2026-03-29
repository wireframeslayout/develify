# Develify

dotfiles 管理 & ワンライナーセットアップシステム。
macOS / Ubuntu / WSL / Termux (Android) に対応し、一つのコマンドで開発環境を構築します。

## Features

- **ワンライナーセットアップ** — プラットフォーム別の `init.sh` 1つで全環境を構築
- **プロンプトエンジン切り替え** — starship ⇔ oh-my-posh をコマンド一つで切り替え ([詳細](docs/prompt-switch.md))
- **tmux 環境** — TPM + tmux-powerline によるモダンな tmux 環境 ([詳細](docs/tmux.md))
- **anyenv** — 言語バージョン管理 (nodenv, rbenv, pyenv 等)
- **exa** — `ls` の拡張版 (アイコン・ツリー表示)
- **Solarized dircolors** — ターミナルカラーの統一
- **Nerd Font** — JetBrainsMono Nerd Font によるアイコン対応
- **WSL 拡張コマンド** — wstorm / pstorm / rmine / stree (Windows アプリ連携)

## Quick Start

```bash
# リポジトリをクローン
git clone https://github.com/wireframeslayout/develify.git ~/develify

# プラットフォームに合った init.sh を実行
bash ~/develify/startup/ubuntu/init.sh   # Ubuntu
bash ~/develify/startup/wsl/init.sh      # WSL
bash ~/develify/startup/mac/init.sh      # macOS
bash ~/develify/startup/termux/init.sh   # Termux (Android)
```

これだけで以下が自動的にセットアップされます：

1. シンボリックリンクの作成 (`.bashrc`, `.tmux.conf` 等)
2. Starship プロンプトのインストール
3. oh-my-posh のインストール
4. anyenv のインストール
5. exa のインストール
6. TPM (Tmux Plugin Manager) のインストール
7. NeoBundle (Vim プラグインマネージャ) のインストール

### tmux プラグインの初回セットアップ

```bash
tmux                  # tmux を起動
# Prefix + I          # TPM がプラグインを一括インストール
```

## Project Structure

```
develify/
├── README.md
├── docs/
│   ├── prompt-switch.md          # プロンプト切り替え詳細ドキュメント
│   └── tmux.md                   # tmux 設定詳細ドキュメント
├── dotfiles/
│   ├── .tmux.conf                # tmux 設定 (TPM + tmux-powerline)
│   ├── .vimrc                    # Vim 設定 (NeoBundle)
│   ├── .ideavimrc                # JetBrains IDE Vim キーバインド
│   ├── .dircolors-solarized/     # Solarized カラー定義
│   ├── conf/
│   │   ├── init.bash             # bash 共通設定 (PATH, alias, anyenv)
│   │   ├── init.zsh              # zsh 共通設定
│   │   ├── init_prompt.bash      # bash プロンプト初期化 (starship/oh-my-posh 分岐)
│   │   └── init_prompt.zsh       # zsh プロンプト初期化
│   ├── scripts/
│   │   ├── .bashrc_mac           # macOS 用 bashrc
│   │   ├── .bashrc_ubuntu        # Ubuntu 用 bashrc
│   │   ├── .bashrc_termux        # Termux 用 bashrc
│   │   ├── .bashrc_wsl           # WSL 用 bashrc
│   │   ├── .zshrc_mac            # macOS 用 zshrc
│   │   ├── .zshrc_ubuntu         # Ubuntu 用 zshrc
│   │   ├── .zshrc_wsl            # WSL 用 zshrc
│   │   └── prompt-switch.sh      # プロンプトエンジン切り替えコマンド
│   ├── ohmyposh/
│   │   └── develify.omp.json     # oh-my-posh デフォルトテーマ
│   └── tmux-powerline/
│       ├── config.sh             # tmux-powerline 設定
│       └── themes/
│           └── develify.sh       # tmux-powerline カスタムテーマ
├── starship/
│   └── starship.toml             # Starship デフォルトテーマ
├── startup/
│   ├── common/
│   │   ├── sh/
│   │   │   ├── init_slink.sh           # シンボリックリンク作成
│   │   │   ├── install_anyenv.sh       # anyenv インストール
│   │   │   ├── install_exa.sh          # exa インストール
│   │   │   ├── install_ohmyposh.sh     # oh-my-posh インストール
│   │   │   ├── install_starship.sh     # Starship インストール
│   │   │   ├── install_starship_font_linux.sh  # Nerd Font (Linux)
│   │   │   ├── install_starship_font_mac.sh    # Nerd Font (macOS)
│   │   │   ├── install_starship_font_termux.sh # Nerd Font (Termux)
│   │   │   └── install_tpm.sh          # TPM インストール
│   │   ├── vim/
│   │   │   └── install_neobundle.sh    # NeoBundle インストール
│   │   └── zsh/
│   │       └── init_slink.zsh          # zsh 用シンボリックリンク作成
│   ├── mac/
│   │   ├── init.sh               # macOS セットアップエントリーポイント
│   │   ├── init.zsh              # macOS zsh セットアップ
│   │   └── install_homebrew.sh   # Homebrew インストール
│   ├── termux/
│   │   └── init.sh               # Termux セットアップエントリーポイント
│   ├── ubuntu/
│   │   └── init.sh               # Ubuntu セットアップエントリーポイント
│   └── wsl/
│       └── init.sh               # WSL セットアップエントリーポイント
├── commands/
│   └── stree.cmd                 # Windows 用 SourceTree コマンド
└── powershell/
    └── wsl_port.ps1              # WSL ポートフォワーディング
```

## Symlink Map

`init_slink.sh` が作成するシンボリックリンクの一覧：

| リンク元 (ホーム) | リンク先 (develify) |
|---|---|
| `~/conf.d/` | `dotfiles/conf/` |
| `~/.bashrc` | `dotfiles/scripts/.bashrc_{platform}` |
| `~/.dircolors-solarized/` | `dotfiles/.dircolors-solarized/` |
| `~/.vimrc` | `dotfiles/.vimrc` |
| `~/.tmux.conf` | `dotfiles/.tmux.conf` |
| `~/.tmux-powerline/` | `dotfiles/tmux-powerline/` |
| `~/.ohmyposhconf/` | `dotfiles/ohmyposh/` |
| `~/.starshipconf/` | `starship/` |
| `~/bin/prompt-switch` | `dotfiles/scripts/prompt-switch.sh` |

## Shell Initialization Flow

```
シェル起動
  │
  ├─ ~/.bashrc (or ~/.zshrc)          ← platform別 RC ファイル
  │    │
  │    ├─ source ~/conf.d/init.bash   ← 共通設定 (PATH, alias, anyenv, exa)
  │    │
  │    └─ source ~/conf.d/init_prompt.bash  ← プロンプトエンジン初期化
  │         │
  │         ├─ ~/.prompt_engine を読み込み
  │         │
  │         ├─ [starship]  → eval "$(starship init bash)"
  │         └─ [ohmyposh]  → eval "$(oh-my-posh init bash --config ...)"
  │
  └─ プロンプト表示
```

## Prompt Engine

Starship (デフォルト) と oh-my-posh をコマンドで切り替えられます。

```bash
prompt-switch starship                  # Starship に切り替え
prompt-switch ohmyposh                  # oh-my-posh に切り替え
prompt-switch ohmyposh -t night-owl     # oh-my-posh + テーマ指定

source ~/.bashrc                        # 反映
```

詳細は [docs/prompt-switch.md](docs/prompt-switch.md) を参照。

## tmux

TPM + tmux-powerline でモダンな tmux 環境を構築しています。

```
┌─ [session] [hostname] [mode] [git branch] ──── [pwd] [load] [date] [time] ─┐
│                                                                             │
│  ターミナル                                                                  │
│                                                                             │
└─────────────────────────────────────────────────────────────────────────────┘
```

詳細は [docs/tmux.md](docs/tmux.md) を参照。

## Requirements

- Git
- Bash >= 3.2
- curl
- [Nerd Font](https://www.nerdfonts.com/font-downloads) (JetBrainsMono 推奨)

## Nerd Font のインストール

Starship・oh-my-posh・tmux-powerline のアイコン表示には **Nerd Font** が必要です。
**JetBrainsMono Nerd Font** を推奨しています。

### ダウンロード

[Nerd Fonts ダウンロードページ](https://www.nerdfonts.com/font-downloads) から **JetBrainsMono** をダウンロードしてください。

または、develify のインストールスクリプトで自動インストールできます：

```bash
# Linux
bash startup/common/sh/install_starship_font_linux.sh

# macOS
bash startup/common/sh/install_starship_font_mac.sh

# Termux (Android)
bash startup/common/sh/install_starship_font_termux.sh
```

### ターミナルへの適用

#### Windows Terminal

1. `設定` → 使用中のプロファイル → `外観`
2. `フォント フェイス` で `JetBrainsMono Nerd Font` を選択
3. 保存

> 参考: [oh-my-posh - Windows Terminal](https://ohmyposh.dev/docs/installation/fonts)

#### VS Code 統合ターミナル

`settings.json` に以下を追加：

```json
{
  "terminal.integrated.fontFamily": "JetBrainsMono Nerd Font"
}
```

#### iTerm2 (macOS)

1. `Preferences` → `Profiles` → `Text`
2. `Font` で `JetBrainsMono Nerd Font` を選択

> 参考: [Starship - Font Installation](https://starship.rs/guide/#step-2-setup-your-shell-to-use-starship)

#### GNOME Terminal (Ubuntu)

1. `設定` → 使用中のプロファイル → `テキスト`
2. `カスタムフォント` にチェックを入れ、`JetBrainsMono Nerd Font` を選択

#### Alacritty

`alacritty.toml` に以下を追加：

```toml
[font.normal]
family = "JetBrainsMono Nerd Font"
```

> 詳細: [oh-my-posh Fonts ドキュメント](https://ohmyposh.dev/docs/installation/fonts) | [Nerd Fonts 公式](https://www.nerdfonts.com/)

## References

- [Starship](https://starship.rs/)
- [oh-my-posh](https://ohmyposh.dev/)
- [tmux-powerline](https://github.com/erikw/tmux-powerline)
- [TPM](https://github.com/tmux-plugins/tpm)
- [anyenv](https://github.com/anyenv/anyenv)
- [exa](https://the.exa.website/)
- [Nerd Fonts](https://www.nerdfonts.com/)