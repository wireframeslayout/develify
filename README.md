# Develify

dotfiles 管理 & ワンライナーセットアップシステム。
macOS / Ubuntu / WSL に対応し、一つのコマンドで開発環境を構築します。

## Features

- **develify CLI** — 統一コマンドラインツール (`develify prompt-switch`, `develify tmux-cs` 等)
- **ワンライナーセットアップ** — プラットフォーム別の `init.sh` 1つで全環境を構築
- **プロンプトエンジン切り替え** — starship ⇔ oh-my-posh をコマンド一つで切り替え ([詳細](docs/prompt-switch.md))
- **tmux 環境** — TPM + tmux-powerline によるモダンな tmux 環境 ([詳細](docs/tmux.md))
- **anyenv** — 言語バージョン管理 (nodenv, rbenv, pyenv 等)
- **eza** — `ls` の拡張版 (アイコン・ツリー表示)。旧 `exa` の後継 (上流アーカイブ済みのため移行)
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
```

これだけで以下が自動的にセットアップされます：

1. シンボリックリンクの作成 (`.bashrc`, `.tmux.conf` 等)
2. Starship プロンプトのインストール
3. oh-my-posh のインストール
4. anyenv のインストール
5. eza のインストール
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
│   │   ├── develify.sh           # develify CLI メインディスパッチャー
│   │   ├── tmux-cs.sh            # tmux チートシート表示
│   │   ├── prompt-switch.sh      # プロンプトエンジン切り替え
│   │   ├── .bashrc_mac           # macOS 用 bashrc
│   │   ├── .bashrc_ubuntu        # Ubuntu 用 bashrc
│   │   ├── .bashrc_wsl           # WSL 用 bashrc
│   │   ├── .zshrc_mac            # macOS 用 zshrc
│   │   ├── .zshrc_ubuntu         # Ubuntu 用 zshrc
│   │   └── .zshrc_wsl            # WSL 用 zshrc
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
│   │   │   ├── install_eza.sh          # eza (exa 後継) インストール
│   │   │   ├── install_ohmyposh.sh     # oh-my-posh インストール
│   │   │   ├── install_starship.sh     # Starship インストール
│   │   │   ├── install_starship_font_linux.sh  # Nerd Font (Linux)
│   │   │   ├── install_starship_font_mac.sh    # Nerd Font (macOS)
│   │   │   └── install_tpm.sh          # TPM インストール
│   │   ├── vim/
│   │   │   └── install_neobundle.sh    # NeoBundle インストール
│   │   └── zsh/
│   │       └── init_slink.zsh          # zsh 用シンボリックリンク作成
│   ├── mac/
│   │   ├── init.sh               # macOS セットアップエントリーポイント
│   │   ├── init.zsh              # macOS zsh セットアップ
│   │   └── install_homebrew.sh   # Homebrew インストール
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
| `~/bin/develify` | `dotfiles/scripts/develify.sh` |

なお `~/.bash_profile` だけはリンクではなく**追記**で扱います。bash はログインシェルとして
起動されると `~/.bashrc` を読まず `~/.bash_profile` (無ければ `~/.bash_login` → `~/.profile`)
だけを読むため、`~/.bashrc` へのリンクを張っただけでは macOS のターミナル
(Terminal.app / iTerm2 / Ghostty) で設定が適用されません。`~/.bash_profile` に `~/.bashrc` を
読み込むブロックを追記して解決しています (Homebrew 等のインストーラが書き込んだ内容は保持されます)。

Ubuntu / WSL は既定で `~/.profile` が `~/.bashrc` を読むため、
`~/.bash_profile` が既に存在する場合のみ追記対象になります。

## Shell Initialization Flow

```
シェル起動
  │
  ├─ [ログインシェルの場合]
  │    └─ ~/.bash_profile             ← bash はここしか読まない
  │         └─ source ~/.bashrc       ← init_slink.sh が追記する橋渡し
  │
  ├─ ~/.bashrc (or ~/.zshrc)          ← platform別 RC ファイル
  │    │
  │    ├─ source ~/conf.d/init.bash   ← 共通設定 (PATH, alias, anyenv, eza)
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

## develify CLI

セットアップ後、`develify` コマンドが `~/bin/develify` にインストールされます。

```bash
develify                        # ヘルプ表示
develify prompt-switch starship # プロンプトエンジンを Starship に切り替え
develify prompt-switch ohmyposh -t night-owl  # oh-my-posh + テーマ指定
develify tmux-cs                # tmux キーバインド チートシート表示
develify version                # バージョン表示
```

| サブコマンド | 説明 |
|---|---|
| `prompt-switch` | プロンプトエンジンの切り替え (starship / oh-my-posh) |
| `tmux-cs` | tmux キーバインド チートシート表示 (カラー対応) |
| `help` | ヘルプ表示 |
| `version` | バージョン表示 |

## Prompt Engine

Starship (デフォルト) と oh-my-posh をコマンドで切り替えられます。

```bash
develify prompt-switch starship                  # Starship に切り替え
develify prompt-switch ohmyposh                  # oh-my-posh に切り替え
develify prompt-switch ohmyposh -t night-owl     # oh-my-posh + テーマ指定

source ~/.bashrc                                 # 反映
```

> **注意 (macOS + bash)**
> oh-my-posh の bash 用 init は bash 4.2 以降の機能を使いますが、macOS に標準で入っている
> bash は 3.2 です。そのままでは起動のたびに警告が出て starship にフォールバックします。
> oh-my-posh を実際に使うには [ログインシェルの変更](#ログインシェルの変更-chsh) を参照してください。
> starship のみ使う場合はこの対応は不要です。

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
- Bash >= 3.2 (oh-my-posh を使う場合のみ >= 4.2 — [ログインシェルの変更](#ログインシェルの変更-chsh) 参照)
- curl
- [Nerd Font](https://www.nerdfonts.com/font-downloads) (JetBrainsMono 推奨)

## ログインシェルの変更 (chsh)

macOS 標準の bash は **3.2** です (GPLv3 を避けるため Apple が更新していない)。
oh-my-posh は bash 4.2 以降を要求するため、使うには Homebrew の bash に切り替えます。
starship のみを使う場合、この作業は不要です。

### 1. 新しい bash をインストール

```bash
brew install bash
```

インストール先は Apple Silicon なら `/opt/homebrew/bin/bash`、Intel なら `/usr/local/bin/bash` です。
以下は `$(brew --prefix)/bin/bash` で書いているので、どちらの環境でもそのまま使えます。

### 2. `/etc/shells` に登録

`chsh` は `/etc/shells` に登録されていないシェルを拒否するため、先に追記します。

```bash
echo "$(brew --prefix)/bin/bash" | sudo tee -a /etc/shells
```

同じ行を二重に追加しないよう、先に `grep bash /etc/shells` で確認してください。

### 3. ログインシェルを変更

```bash
chsh -s "$(brew --prefix)/bin/bash"
```

パスワードを求められます。`sudo` は不要です (自分のアカウントを変更するため)。

### 4. 反映を確認

**変更はすでに開いているターミナルには反映されません。** 新しいターミナルを開いてから確認します。

```bash
echo "$BASH_VERSION"          # 5.x.x になっていれば成功
dscl . -read ~/ UserShell     # ログインシェルの登録内容
```

`$BASH_VERSION` が 5 系になれば、`develify prompt-switch ohmyposh` で oh-my-posh が実際に使われます。

### 元に戻す / 他のシェルにする

```bash
chsh -s /bin/bash             # macOS 標準の bash 3.2 に戻す
chsh -s /bin/zsh              # zsh にする (macOS のデフォルト)
```

利用可能なシェルの一覧は `cat /etc/shells` で確認できます。

> **補足**
> ターミナルアプリ側で起動コマンドを明示している場合 (iTerm2 の *Command* 設定、
> Ghostty の `command` 設定など)、`chsh` よりそちらが優先されます。
> 変更が反映されない場合はターミナル側の設定も確認してください。

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
- [eza](https://github.com/eza-community/eza)
- [Nerd Fonts](https://www.nerdfonts.com/)