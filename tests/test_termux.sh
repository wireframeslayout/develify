#!/bin/bash

# Termux 対応スクリプト群のテスト
# 実行: bash tests/test_termux.sh

REPO_ROOT="$(cd "$(dirname "$0")/.."; pwd)"

pass_count=0
fail_count=0
skip_count=0

assert_eq() {
    local expected="$1"
    local actual="$2"
    local message="$3"
    if [[ "$expected" == "$actual" ]]; then
        echo "  PASS: $message"
        ((pass_count++))
    else
        echo "  FAIL: $message"
        echo "    expected: '$expected'"
        echo "    actual:   '$actual'"
        ((fail_count++))
    fi
}

assert_contains() {
    local haystack="$1"
    local needle="$2"
    local message="$3"
    if [[ "$haystack" == *"$needle"* ]]; then
        echo "  PASS: $message"
        ((pass_count++))
    else
        echo "  FAIL: $message"
        echo "    '$needle' not found in output"
        ((fail_count++))
    fi
}

assert_not_contains() {
    local haystack="$1"
    local needle="$2"
    local message="$3"
    if [[ "$haystack" != *"$needle"* ]]; then
        echo "  PASS: $message"
        ((pass_count++))
    else
        echo "  FAIL: $message"
        echo "    '$needle' should not be present but was found"
        ((fail_count++))
    fi
}

assert_file_exists() {
    local filepath="$1"
    local message="$2"
    if [[ -f "$filepath" ]]; then
        echo "  PASS: $message"
        ((pass_count++))
        return 0
    else
        echo "  FAIL: $message"
        echo "    file not found: $filepath"
        ((fail_count++))
        return 1
    fi
}

assert_syntax_ok() {
    local filepath="$1"
    local message="$2"
    if bash -n "$filepath" 2>/dev/null; then
        echo "  PASS: $message"
        ((pass_count++))
    else
        echo "  FAIL: $message"
        echo "    syntax error in: $filepath"
        ((fail_count++))
    fi
}

skip_section() {
    local count="$1"
    local reason="$2"
    echo "  SKIP ($count tests): $reason"
    skip_count=$((skip_count + count))
}

# ==============================================================================
echo "=== startup/termux/init.sh ==="
# ==============================================================================

INIT_SH="$REPO_ROOT/startup/termux/init.sh"

echo "[existence and syntax]"
if assert_file_exists "$INIT_SH" "init.sh が存在する"; then
    assert_syntax_ok "$INIT_SH" "init.sh に構文エラーがない"

    echo "[shebang]"
    # Given: init.sh の先頭行
    # When: shebang を確認
    # Then: #!/bin/bash である
    shebang=$(head -1 "$INIT_SH")
    assert_eq "#!/bin/bash" "$shebang" "shebang が #!/bin/bash である"

    init_content=$(cat "$INIT_SH")

    echo "[package manager]"
    # Given: init.sh の内容
    # When: パッケージ管理コマンドを確認
    # Then: pkg を使用し、apt/sudo を使用していない
    assert_contains "$init_content" "pkg update" "pkg update を実行する"
    assert_contains "$init_content" "pkg upgrade" "pkg upgrade を実行する"
    assert_contains "$init_content" "pkg install" "pkg install でパッケージをインストールする"
    assert_not_contains "$init_content" "sudo" "sudo を使用しない"
    assert_not_contains "$init_content" "apt " "apt を使用しない"
    assert_not_contains "$init_content" "apt-get" "apt-get を使用しない"

    echo "[basic packages]"
    # Given: init.sh の内容
    # When: 基本パッケージのインストールを確認
    # Then: git, curl, tmux, vim, zsh, unzip が含まれる
    for pkg_name in git curl tmux vim zsh unzip; do
        assert_contains "$init_content" "$pkg_name" "基本パッケージ $pkg_name をインストールする"
    done

    echo "[symlink setup]"
    # Given: init.sh の内容
    # When: init_slink.sh の呼び出しを確認
    # Then: 引数 "termux" で呼び出している
    assert_contains "$init_content" "init_slink.sh termux" "init_slink.sh を引数 termux で呼び出す"

    echo "[starship]"
    # Given: init.sh の内容
    # When: Starship のインストール方法を確認
    # Then: pkg で直接インストールし、install_starship.sh を使わない
    assert_contains "$init_content" "pkg install -y starship" "Starship を pkg でインストールする"
    assert_not_contains "$init_content" "install_starship.sh" "install_starship.sh を使わない"

    echo "[starship config symlink]"
    # Given: init.sh の内容
    # When: Starship 設定のシンボリックリンクを確認
    # Then: ~/.starshipconf へのシンボリックリンクを作成する
    assert_contains "$init_content" "starshipconf" "Starship 設定のシンボリックリンクを作成する"

    echo "[exa]"
    # Given: init.sh の内容
    # When: exa のインストール方法を確認
    # Then: pkg で直接インストールし、install_exa.sh を使わない
    assert_contains "$init_content" "pkg install -y exa" "exa を pkg でインストールする"
    assert_not_contains "$init_content" "install_exa.sh" "install_exa.sh を使わない"

    echo "[common scripts]"
    # Given: init.sh の内容
    # When: 共通スクリプトの呼び出しを確認
    # Then: oh-my-posh, anyenv, TPM, NeoBundle の共通スクリプトを呼び出す
    assert_contains "$init_content" "install_ohmyposh.sh" "install_ohmyposh.sh を呼び出す"
    assert_contains "$init_content" "install_anyenv.sh" "install_anyenv.sh を呼び出す"
    assert_contains "$init_content" "install_tpm.sh" "install_tpm.sh を呼び出す"
    assert_contains "$init_content" "install_neobundle.sh" "install_neobundle.sh を呼び出す"

    echo "[source bashrc]"
    # Given: init.sh の内容
    # When: 最終行付近を確認
    # Then: source ~/.bashrc を実行する
    assert_contains "$init_content" "source ~/.bashrc" "最後に source ~/.bashrc を実行する"

    echo "[font script not auto-executed]"
    # Given: init.sh の内容
    # When: フォントスクリプトの呼び出しを確認
    # Then: install_starship_font_termux.sh を自動実行しない（オプション扱い）
    font_call_count=$(grep -c 'bash.*install_starship_font_termux' "$INIT_SH" 2>/dev/null || echo "0")
    comment_font_count=$(grep -c '^#.*install_starship_font_termux' "$INIT_SH" 2>/dev/null || echo "0")
    if [[ "$font_call_count" -eq 0 ]] || [[ "$font_call_count" -eq "$comment_font_count" ]]; then
        echo "  PASS: install_starship_font_termux.sh を自動実行しない"
        ((pass_count++))
    else
        echo "  FAIL: install_starship_font_termux.sh が自動実行されている（オプション扱いにすべき）"
        ((fail_count++))
    fi

    echo "[ubuntu pattern consistency]"
    # Given: startup/ubuntu/init.sh と startup/termux/init.sh
    # When: 構造パターンを比較
    # Then: 同じパターン（SCRIPT_DIR 取得、共通スクリプト呼び出し、source ~/.bashrc）に従う
    assert_contains "$init_content" 'SCRIPT_DIR=' "SCRIPT_DIR 変数を設定する"
    assert_contains "$init_content" 'dirname' "dirname でスクリプトディレクトリを取得する"
else
    skip_section 25 "startup/termux/init.sh が存在しないためスキップ"
fi

# ==============================================================================
echo ""
echo "=== startup/common/sh/init_slink.sh (termux case) ==="
# ==============================================================================

SLINK_SH="$REPO_ROOT/startup/common/sh/init_slink.sh"

echo "[syntax]"
assert_syntax_ok "$SLINK_SH" "init_slink.sh に構文エラーがない"

echo "[termux case]"
# Given: init_slink.sh の case 文
# When: 引数 "termux" を渡す
# Then: SCRIPTNAME が ".bashrc_termux" に設定される
slink_content=$(cat "$SLINK_SH")
assert_contains "$slink_content" '"termux"' "case 文に termux ケースが存在する"
assert_contains "$slink_content" '.bashrc_termux' ".bashrc_termux が SCRIPTNAME に設定される"

echo "[termux case sets correct scriptname]"
# Given: init_slink.sh の case 文
# When: 引数 "termux" で case 文だけを実行
# Then: SCRIPTNAME=".bashrc_termux" が設定される
SCRIPTNAME=""
eval "$(sed -n '/^case/,/^esac/p' "$SLINK_SH" | sed 's/\$1/termux/g')"
assert_eq ".bashrc_termux" "$SCRIPTNAME" "引数 termux で SCRIPTNAME=.bashrc_termux が設定される"

echo "[existing cases preserved]"
# Given: init_slink.sh の case 文
# When: 既存の引数 mac, wsl で case 文を実行
# Then: 既存の動作が変わらない
SCRIPTNAME=""
eval "$(sed -n '/^case/,/^esac/p' "$SLINK_SH" | sed 's/\$1/mac/g')"
assert_eq ".bashrc_mac" "$SCRIPTNAME" "引数 mac で SCRIPTNAME=.bashrc_mac が維持される"

SCRIPTNAME=""
eval "$(sed -n '/^case/,/^esac/p' "$SLINK_SH" | sed 's/\$1/wsl/g')"
assert_eq ".bashrc_wsl" "$SCRIPTNAME" "引数 wsl で SCRIPTNAME=.bashrc_wsl が維持される"

echo "[default case preserved]"
# Given: init_slink.sh の case 文
# When: 未知の引数で case 文を実行
# Then: デフォルトの .bashrc_ubuntu が設定される
SCRIPTNAME=""
eval "$(sed -n '/^case/,/^esac/p' "$SLINK_SH" | sed 's/\$1/unknown/g')"
assert_eq ".bashrc_ubuntu" "$SCRIPTNAME" "デフォルトケースで SCRIPTNAME=.bashrc_ubuntu が維持される"

# ==============================================================================
echo ""
echo "=== dotfiles/scripts/.bashrc_termux ==="
# ==============================================================================

BASHRC_TERMUX="$REPO_ROOT/dotfiles/scripts/.bashrc_termux"

echo "[existence]"
if assert_file_exists "$BASHRC_TERMUX" ".bashrc_termux が存在する"; then
    bashrc_content=$(cat "$BASHRC_TERMUX")

    echo "[content]"
    # Given: .bashrc_termux の内容
    # When: source 対象を確認
    # Then: init.bash と init_prompt.bash を source する
    assert_contains "$bashrc_content" "init.bash" "init.bash を source する"
    assert_contains "$bashrc_content" "init_prompt.bash" "init_prompt.bash を source する"

    echo "[no zsh reference]"
    # Given: .bashrc_termux の内容
    # When: zsh 関連の参照を確認
    # Then: zsh 関連の設定を含まない
    assert_not_contains "$bashrc_content" ".zsh" "zsh 関連の設定を含まない"
else
    skip_section 3 "dotfiles/scripts/.bashrc_termux が存在しないためスキップ"
fi

# ==============================================================================
echo ""
echo "=== startup/common/sh/install_starship_font_termux.sh ==="
# ==============================================================================

FONT_SH="$REPO_ROOT/startup/common/sh/install_starship_font_termux.sh"

echo "[existence]"
if assert_file_exists "$FONT_SH" "install_starship_font_termux.sh が存在する"; then
    assert_syntax_ok "$FONT_SH" "install_starship_font_termux.sh に構文エラーがない"

    echo "[shebang]"
    font_shebang=$(head -1 "$FONT_SH")
    assert_eq "#!/bin/bash" "$font_shebang" "shebang が #!/bin/bash である"

    font_content=$(cat "$FONT_SH")

    echo "[termux font directory]"
    # Given: install_starship_font_termux.sh の内容
    # When: フォント配置先を確認
    # Then: ~/.termux ディレクトリを使用する
    assert_contains "$font_content" "mkdir -p ~/.termux" "~/.termux ディレクトリを作成する"
    assert_contains "$font_content" "~/.termux/font.ttf" "~/.termux/font.ttf にフォントを配置する"

    echo "[font download]"
    # Given: install_starship_font_termux.sh の内容
    # When: ダウンロード方法を確認
    # Then: curl で JetBrainsMono Nerd Font をダウンロードする
    assert_contains "$font_content" "curl" "curl でフォントをダウンロードする"
    assert_contains "$font_content" "JetBrainsMono" "JetBrainsMono Nerd Font を使用する"

    echo "[termux reload]"
    # Given: install_starship_font_termux.sh の内容
    # When: 設定反映コマンドを確認
    # Then: termux-reload-settings を呼び出す
    assert_contains "$font_content" "termux-reload-settings" "termux-reload-settings で設定を反映する"

    echo "[no fc-cache]"
    # Given: install_starship_font_termux.sh の内容
    # When: Linux 固有コマンドの使用を確認
    # Then: fc-cache を使用しない（Termux では不要）
    assert_not_contains "$font_content" "fc-cache" "fc-cache を使用しない"

    echo "[no wget]"
    # Given: install_starship_font_termux.sh の内容
    # When: ダウンロードツールを確認
    # Then: wget ではなく curl を使用する（Linux 版との差異）
    assert_not_contains "$font_content" "wget" "wget ではなく curl を使用する"
else
    skip_section 9 "install_starship_font_termux.sh が存在しないためスキップ"
fi

# ==============================================================================
echo ""
echo "=== 結果 ==="
echo "PASS: $pass_count / FAIL: $fail_count / SKIP: $skip_count"
# ==============================================================================

if [[ "$fail_count" -gt 0 ]]; then
    exit 1
fi
