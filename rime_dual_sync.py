import filecmp
import os
import shutil
from pathlib import Path

A = Path("/Users/chouxiang99/Library/CloudStorage/OneDrive-个人/Rime/wanxiang/Sync")
B = Path("/Users/chouxiang99/Library/Mobile Documents/iCloud~com~ihsiao~apps~Hamster3/Documents/Sync")

def sync_file(src, dst):
    dst.parent.mkdir(parents=True, exist_ok=True)
    shutil.copy2(src, dst)

def walk(path):
    return {p.relative_to(path) for p in path.rglob("*") if p.is_file()}

def main():
    files_a = walk(A)
    files_b = walk(B)
    all_files = files_a | files_b

    for rel_path in all_files:
        file_a = A / rel_path
        file_b = B / rel_path

        exists_a = file_a.exists()
        exists_b = file_b.exists()

        # 情况 1：仅 A 有 → 复制到 B
        if exists_a and not exists_b:
            sync_file(file_a, file_b)

        # 情况 2：仅 B 有 → 复制到 A
        elif exists_b and not exists_a:
            sync_file(file_b, file_a)

        # 情况 3：AB 都有 → 比较修改时间
        elif exists_a and exists_b:
            if file_a.stat().st_mtime > file_b.stat().st_mtime:
                sync_file(file_a, file_b)
            elif file_b.stat().st_mtime > file_a.stat().st_mtime:
                sync_file(file_b, file_a)

if __name__ == "__main__":
    main()
