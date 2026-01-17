#!/usr/bin/env python3
"""
.po ファイルの翻訳統計を取得するスクリプト

使用方法:
    python po_stats.py <po_file_path>
    python po_stats.py locale/en/LC_MESSAGES/django.po

出力:
    JSON 形式で統計情報を出力
"""

import sys
import json


def parse_po_file(filepath: str) -> dict:
    """
    .po ファイルを解析して統計を取得

    Returns:
        dict: {
            "total": int,
            "translated": int,
            "untranslated": int,
            "fuzzy": int,
            "entries": list  # 各エントリの詳細
        }
    """
    try:
        import polib
    except ImportError:
        print("Error: polib is required. Install with: pip install polib", file=sys.stderr)
        sys.exit(1)

    po = polib.pofile(filepath)

    total = len(po)
    translated = len(po.translated_entries())
    untranslated = len(po.untranslated_entries())
    fuzzy = len(po.fuzzy_entries())

    # 未翻訳エントリの詳細
    untranslated_entries = []
    for entry in po.untranslated_entries():
        untranslated_entries.append({
            "msgid": entry.msgid[:100],  # 長すぎる場合は切り詰め
            "occurrences": [f"{loc[0]}:{loc[1]}" for loc in entry.occurrences[:3]],
        })

    # Fuzzy エントリの詳細
    fuzzy_entries = []
    for entry in po.fuzzy_entries():
        fuzzy_entries.append({
            "msgid": entry.msgid[:100],
            "msgstr": entry.msgstr[:100] if entry.msgstr else "",
            "occurrences": [f"{loc[0]}:{loc[1]}" for loc in entry.occurrences[:3]],
        })

    return {
        "filepath": filepath,
        "total": total,
        "translated": translated,
        "untranslated": untranslated,
        "fuzzy": fuzzy,
        "translation_rate": round((translated - fuzzy) / total * 100, 1) if total > 0 else 0,
        "untranslated_entries": untranslated_entries[:20],  # 最初の20件
        "fuzzy_entries": fuzzy_entries[:10],  # 最初の10件
    }


def main():
    if len(sys.argv) < 2:
        print("Usage: python po_stats.py <po_file_path>", file=sys.stderr)
        sys.exit(1)

    filepath = sys.argv[1]
    stats = parse_po_file(filepath)
    print(json.dumps(stats, ensure_ascii=False, indent=2))


if __name__ == "__main__":
    main()
