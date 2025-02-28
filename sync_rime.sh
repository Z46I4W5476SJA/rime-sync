#!/bin/bash

# 定义文件路径
IPHONE_ICLOUD_SRC="/Users/chouxiang99/Library/Mobile Documents/iCloud~dev~fuxiao~app~hamsterapp/Documents/sync/iPhone/custom_dict.userdb.txt"
IPHONE_ONEDRIVE_DEST="/Users/chouxiang99/Library/CloudStorage/OneDrive-个人/iCloud~dev~fuxiao~app~hamsterapp/sync/iPhone"
MACBOOK_ONEDRIVE_SRC="/Users/chouxiang99/Library/CloudStorage/OneDrive-个人/iCloud~dev~fuxiao~app~hamsterapp/sync/MacBook/custom_dict.userdb.txt"
MACBOOK_ICLOUD_DEST="/Users/chouxiang99/Library/Mobile Documents/iCloud~dev~fuxiao~app~hamsterapp/Documents/sync/MacBook"

# 检查源文件是否存在
if [ ! -f "$IPHONE_ICLOUD_SRC" ]; then
    echo "错误：iPhone iCloud 源文件 $IPHONE_ICLOUD_SRC 不存在！"
    exit 1
fi
if [ ! -f "$MACBOOK_ONEDRIVE_SRC" ]; then
    echo "错误：MacBook OneDrive 源文件 $MACBOOK_ONEDRIVE_SRC 不存在！"
    exit 1
fi

# 确保目标目录存在
mkdir -p "$IPHONE_ONEDRIVE_DEST"
mkdir -p "$MACBOOK_ICLOUD_DEST"

# 步骤 1：将 iPhone 的 iCloud 文件拷贝到 OneDrive 并替换旧文件
echo "正在将 iPhone 的 iCloud 文件同步到 OneDrive..."
cp -f "$IPHONE_ICLOUD_SRC" "$IPHONE_ONEDRIVE_DEST/custom_dict.userdb.txt"
if [ $? -eq 0 ]; then
    echo "步骤 1 完成：iPhone 文件已替换到 OneDrive。"
else
    echo "错误：步骤 1 失败，无法拷贝 iPhone 文件！"
    exit 1
fi

# 步骤 2：执行 Rime 同步命令
echo "正在执行 Rime 同步..."
/Library/Input\ Methods/Squirrel.app/Contents/MacOS/Squirrel --sync
if [ $? -eq 0 ]; then
    echo "等待 10 秒以确保 Rime 同步完成..."
else
    echo "警告：Rime 同步可能失败，请检查 Squirrel 是否正常运行。"
fi
sleep 10
echo "步骤 2 完成：Rime 同步成功."


# 步骤 3：将 MacBook 的 OneDrive 文件拷贝到 iCloud 并替换旧文件
echo "正在将 MacBook 的 OneDrive 文件同步到 iCloud..."
cp -f "$MACBOOK_ONEDRIVE_SRC" "$MACBOOK_ICLOUD_DEST/custom_dict.userdb.txt"
if [ $? -eq 0 ]; then
    echo "步骤 3 完成：MacBook 文件已替换到 iCloud。"
else
    echo "错误：步骤 3 失败，无法拷贝 MacBook 文件！"
    exit 1
fi

echo "所有步骤完成！"
