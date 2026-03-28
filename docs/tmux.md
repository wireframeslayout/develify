# tmux 設定

TPM (Tmux Plugin Manager) と tmux-powerline によるモダンな tmux 環境です。

## セットアップ

`init.sh` を実行すると TPM が自動インストールされます。
tmux 起動後に `Prefix + I` でプラグインを一括インストールしてください。

```bash
tmux              # tmux を起動
# Prefix + I      # プラグインインストール (初回のみ)
```

## ステータスバー

tmux-powerline による Powerline スタイルのステータスバーが上部に表示されます。

```
┌─[session][hostname][mode][git branch]──────[pwd][load][date_day][date][time]─┐
│                                                                              │
│  ターミナル                                                                   │
│                                                                              │
└──────────────────────────────────────────────────────────────────────────────┘
```

### 左ステータスバー

| セグメント | 説明 |
|---|---|
| `tmux_session_info` | tmux セッション名 |
| `hostname` | ホスト名 |
| `mode_indicator` | モード表示 (normal / prefix / copy) |
| `vcs_branch` | Git ブランチ名 (リポジトリ外では非表示) |

### 右ステータスバー

| セグメント | 説明 |
|---|---|
| `pwd` | カレントディレクトリ |
| `load` | CPU 負荷 |
| `date_day` | 曜日 |
| `date` | 日付 |
| `time` | 時刻 |

### ステータスバーのミュート

```
Prefix + a    左ステータスのミュート/アンミュート
Prefix + b    右ステータスのミュート/アンミュート
```

## キーバインド

### 基本操作

| キー | 動作 |
|---|---|
| `Prefix + r` | 設定ファイルのリロード |

### ペイン操作

| キー | 動作 |
|---|---|
| `Prefix + \|` | 縦分割 (カレントパス引き継ぎ) |
| `Prefix + -` | 横分割 (カレントパス引き継ぎ) |
| `Prefix + h` | 左ペインに移動 |
| `Prefix + j` | 下ペインに移動 |
| `Prefix + k` | 上ペインに移動 |
| `Prefix + l` | 右ペインに移動 |
| `Prefix + H` | ペインを左にリサイズ (連打可) |
| `Prefix + J` | ペインを下にリサイズ (連打可) |
| `Prefix + K` | ペインを上にリサイズ (連打可) |
| `Prefix + L` | ペインを右にリサイズ (連打可) |
| `Ctrl + o` | ペインをローテーション (Prefix 不要) |

### ウィンドウ操作

| キー | 動作 |
|---|---|
| `Prefix + Ctrl-h` | 前のウィンドウに移動 (連打可) |
| `Prefix + Ctrl-l` | 次のウィンドウに移動 (連打可) |

### セッション管理 (tmux-resurrect)

| キー | 動作 |
|---|---|
| `Prefix + Ctrl-s` | セッションを保存 |
| `Prefix + Ctrl-r` | セッションを復元 |

tmux-continuum によりセッションは自動保存され、tmux 起動時に自動復元されます。

### クリップボード (tmux-yank)

tmux-yank により、コピーモードで選択したテキストがシステムクリップボードに自動コピーされます。

## プラグイン一覧

| プラグイン | 用途 |
|---|---|
| [tpm](https://github.com/tmux-plugins/tpm) | プラグインマネージャ |
| [tmux-sensible](https://github.com/tmux-plugins/tmux-sensible) | 万人向けデフォルト設定 |
| [tmux-resurrect](https://github.com/tmux-plugins/tmux-resurrect) | セッション保存・復元 |
| [tmux-continuum](https://github.com/tmux-plugins/tmux-continuum) | セッション自動保存・復元 |
| [tmux-yank](https://github.com/tmux-plugins/tmux-yank) | クリップボード連携 |
| [tmux-powerline](https://github.com/erikw/tmux-powerline) | Powerline ステータスバー |

## プラグインの更新

```
Prefix + U    プラグインを一括アップデート
```

## 基本設定

| 設定 | 値 |
|---|---|
| ターミナル | `tmux-256color` + True Color |
| マウス操作 | 有効 |
| ウィンドウ番号開始 | 1 |
| ペイン番号開始 | 1 |
| ウィンドウ自動リナンバー | 有効 |
| ステータスバー位置 | 上部 |
| ESC キー遅延 | なし |
| スクロールバック | 50,000 行 |

## カスタマイズ

### テーマの変更

`dotfiles/tmux-powerline/themes/develify.sh` を編集してセグメントの追加・削除・色変更ができます。

利用可能なセグメントの一覧は [tmux-powerline segments](https://github.com/erikw/tmux-powerline/tree/main/segments) を参照してください。

### 設定の変更

`dotfiles/tmux-powerline/config.sh` で tmux-powerline の全般設定を変更できます。

## 関連ファイル

| ファイル | 役割 |
|---|---|
| `dotfiles/.tmux.conf` | tmux メイン設定ファイル |
| `dotfiles/tmux-powerline/config.sh` | tmux-powerline 設定 |
| `dotfiles/tmux-powerline/themes/develify.sh` | カスタムテーマ定義 |
| `startup/common/sh/install_tpm.sh` | TPM インストールスクリプト |
