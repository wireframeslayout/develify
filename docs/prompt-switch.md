# Prompt Engine 切り替え

Starship と oh-my-posh をワンコマンドで切り替え可能です。
デフォルトは Starship が有効になっています。

## コマンド

```bash
prompt-switch {starship|ohmyposh} [-t|--theme <theme_name>]
```

| 引数 | 必須 | 説明 |
|---|---|---|
| `starship` / `ohmyposh` | Yes | 使用するプロンプトエンジン |
| `-t`, `--theme` | No | テーマ名。省略時はデフォルトテーマ |

## 使用例

```bash
# Starship (デフォルトテーマ)
prompt-switch starship

# Starship + カスタムテーマ
prompt-switch starship -t tokyo-night

# oh-my-posh (develify テーマ)
prompt-switch ohmyposh

# oh-my-posh + ビルトインテーマ
prompt-switch ohmyposh -t night-owl

# 切り替え後にシェルに反映
source ~/.bashrc    # bash の場合
source ~/.zshrc     # zsh の場合
```

## 仕組み

### 状態ファイル

`~/.prompt_engine` に現在のエンジンとテーマが保存されます。

```bash
PROMPT_ENGINE="starship"
PROMPT_THEME=""
```

このファイルはシェル起動時に `init_prompt.bash` (または `.zsh`) から読み込まれ、
適切なプロンプトエンジンが初期化されます。
ファイルが存在しない場合は、Starship + デフォルトテーマで動作します (後方互換)。

### 処理フロー

```
prompt-switch 実行
  │
  ├─ エンジンのインストール確認
  ├─ テーマの存在確認
  └─ ~/.prompt_engine を更新
        │
        ▼
source ~/.bashrc (ユーザーが実行)
  │
  └─ init_prompt.bash
       │
       ├─ ~/.prompt_engine を読み込み
       ├─ PROMPT_ENGINE で分岐
       │
       ├─ [starship]
       │    ├─ STARSHIP_CONFIG を設定
       │    └─ eval "$(starship init bash)"
       │
       └─ [ohmyposh]
            ├─ テーマパスを解決
            └─ eval "$(oh-my-posh init bash --config <path>)"
```

## テーマ

### Starship テーマ

| テーマ指定 | 解決先 |
|---|---|
| (空 = デフォルト) | `~/.starshipconf/starship.toml` |
| `tokyo-night` | `~/.starshipconf/tokyo-night.toml` |

カスタムテーマの追加：

```bash
# Starship プリセットから生成
starship preset tokyo-night -o ~/.starshipconf/tokyo-night.toml

# または手動で TOML ファイルを作成
vi ~/.starshipconf/my-theme.toml

# 切り替え
prompt-switch starship -t my-theme
```

`~/.starshipconf/` は `starship/` ディレクトリへのシンボリックリンクです。
リポジトリに TOML ファイルを追加すれば、全環境で利用できます。

### oh-my-posh テーマ

| テーマ指定 | 解決先 |
|---|---|
| (空 = デフォルト) | `~/.ohmyposhconf/develify.omp.json` |
| `night-owl` | oh-my-posh ビルトインテーマ (テーマ名を直接渡す) |
| `my-custom` | `~/.ohmyposhconf/my-custom.omp.json` (ローカルファイル優先) |

カスタムテーマの追加：

```bash
# ビルトインテーマをエクスポートしてカスタマイズ
oh-my-posh config export --config night-owl --output ~/.ohmyposhconf/my-theme.omp.json
vi ~/.ohmyposhconf/my-theme.omp.json

# 切り替え
prompt-switch ohmyposh -t my-theme
```

ビルトインテーマの一覧は `~/.cache/oh-my-posh/themes/` で確認できます。

`~/.ohmyposhconf/` は `dotfiles/ohmyposh/` ディレクトリへのシンボリックリンクです。
リポジトリに JSON ファイルを追加すれば、全環境で利用できます。

### develify テーマ (oh-my-posh デフォルト)

`dotfiles/ohmyposh/develify.omp.json` は以下のセグメントで構成されています：

**左プロンプト (1行目):**
- OS アイコン (WSL 表示対応)
- ユーザー名@ホスト名
- カレントパス (短縮表示)
- Git ステータス (ブランチ、変更、stash)

**右プロンプト:**
- Node.js バージョン
- Python バージョン (venv 対応)
- 時刻

**2行目:**
- 入力プロンプト (`❯`) — エラー時は赤色

## 関連ファイル

| ファイル | 役割 |
|---|---|
| `dotfiles/scripts/prompt-switch.sh` | CLI 切り替えコマンド本体 |
| `dotfiles/conf/init_prompt.bash` | bash 用プロンプト初期化スクリプト |
| `dotfiles/conf/init_prompt.zsh` | zsh 用プロンプト初期化スクリプト |
| `starship/starship.toml` | Starship デフォルトテーマ |
| `dotfiles/ohmyposh/develify.omp.json` | oh-my-posh デフォルトテーマ |
| `startup/common/sh/install_starship.sh` | Starship インストーラ |
| `startup/common/sh/install_ohmyposh.sh` | oh-my-posh インストーラ |
