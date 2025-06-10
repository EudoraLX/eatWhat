# 今天吃什么

一个帮助用户决定"今天吃什么"的 Flutter 应用。

## 功能特点

- 随机推荐菜品
- 展示菜品详细信息
- 支持收藏喜欢的菜品
- 支持分享菜品信息
- 查看菜品制作方法

## 开发环境要求

- Flutter 3.0.0 或更高版本
- Dart 2.19.0 或更高版本
- Windows 10 或更高版本
- Android Studio / VS Code（推荐）

## 安装步骤

1. 安装 Flutter SDK
   - 访问 [Flutter 官网](https://flutter.dev/docs/get-started/install)
   - 下载并安装 Flutter SDK
   - 将 Flutter 的 bin 目录添加到系统环境变量

2. 安装开发工具
   - 安装 [Android Studio](https://developer.android.com/studio) 或 [VS Code](https://code.visualstudio.com/)
   - 安装 Flutter 和 Dart 插件

3. 克隆项目
```bash
git clone [项目地址]
cd a_eatwhat
```

4. 安装依赖
```bash
flutter pub get
```

5. 准备资源文件
   - 确保 `assets/images` 目录包含所有必要的图片：
     - braised_pork.png（红烧肉）
     - kungpao_chicken.png（宫保鸡丁）
     - lanzhou_noodles.png（兰州拉面）
     - shaanxi_food.png（沙县小吃）
     - sandwich.png（三明治）
     - bento.png（便当）
     - home_cooking.png（家常炒菜）
     - steamed_fish.png（清蒸鱼）
     - chicken_salad.png（鸡胸肉沙拉）
     - brown_rice.png（糙米饭套餐）
     - vegetable_soup.png（蔬菜汤）
     - nutrition_set.png（营养套餐）
     - mixed_grains.png（五谷杂粮饭）

6. 运行项目
```bash
# Windows
flutter run -d windows

# Android
flutter run -d android

# iOS
flutter run -d ios
```

## 打包说明

### Windows 打包

1. 确保已安装 Windows 开发环境
```bash
flutter config --enable-windows-desktop
```

2. 构建发布版本
```bash
flutter build windows --release
```

3. 打包位置
```
build/windows/runner/Release/
```

### Android 打包

1. 生成签名密钥
```bash
keytool -genkey -v -keystore android/app/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

2. 配置签名信息
在 `android/key.properties` 文件中添加：
```properties
storePassword=<密码>
keyPassword=<密码>
keyAlias=upload
storeFile=upload-keystore.jks
```

3. 修改 `android/app/build.gradle`：
```gradle
def keystoreProperties = new Properties()
def keystorePropertiesFile = rootProject.file('key.properties')
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
}

android {
    ...
    signingConfigs {
        release {
            keyAlias keystoreProperties['keyAlias']
            keyPassword keystoreProperties['keyPassword']
            storeFile file(keystoreProperties['storeFile'])
            storePassword keystoreProperties['storePassword']
        }
    }
    buildTypes {
        release {
            signingConfig signingConfigs.release
        }
    }
}
```

4. 构建 APK
```bash
flutter build apk --release
```

5. 构建 App Bundle（推荐）
```bash
flutter build appbundle --release
```

6. 打包位置
```
build/app/outputs/flutter-apk/app-release.apk
build/app/outputs/bundle/release/app-release.aab
```

### iOS 打包

1. 确保已安装 Xcode 和 Apple 开发者账号

2. 配置签名证书
   - 打开 Xcode
   - 选择 Runner 项目
   - 在 Signing & Capabilities 中配置证书

3. 构建发布版本
```bash
flutter build ios --release
```

4. 使用 Xcode 打包
   - 打开 `ios/Runner.xcworkspace`
   - 选择 Product > Archive
   - 在 Organizer 中导出 IPA 文件

### 打包注意事项

1. 版本号管理
   - 在 `pubspec.yaml` 中更新版本号
   - 遵循语义化版本规范

2. 资源文件
   - 确保所有图片资源都已包含
   - 检查资源文件大小，必要时进行优化

3. 性能优化
   - 使用 `flutter build` 时添加 `--release` 参数
   - 考虑使用 `--split-per-abi` 参数（Android）

4. 测试
   - 在打包前进行充分测试
   - 测试不同设备和系统版本

5. 发布准备
   - 准备应用图标
   - 准备应用截图
   - 准备应用描述
   - 准备隐私政策

## 项目结构

```
lib/
  ├── models/      # 数据模型
  ├── screens/     # 页面
  ├── services/    # 服务
  ├── widgets/     # 组件
  └── main.dart    # 入口文件

assets/
  ├── images/      # 图片资源
  └── icons/       # 图标资源
```

## 常见问题

1. 图片资源缺失
   - 确保所有图片都已放置在 `assets/images` 目录下
   - 检查 `pubspec.yaml` 中的资源配置是否正确

2. 依赖安装失败
   - 检查网络连接
   - 尝试运行 `flutter pub cache repair`
   - 删除 `pubspec.lock` 文件后重新运行 `flutter pub get`

3. 运行错误
   - 确保已安装所有必要的开发工具
   - 检查 Flutter 环境是否正确配置
   - 运行 `flutter doctor` 检查环境问题

4. 打包错误
   - 检查签名配置是否正确
   - 确保所有资源文件都存在
   - 检查版本号配置

## 贡献指南

1. Fork 项目
2. 创建特性分支 (`git checkout -b feature/AmazingFeature`)
3. 提交更改 (`git commit -m 'Add some AmazingFeature'`)
4. 推送到分支 (`git push origin feature/AmazingFeature`)
5. 创建 Pull Request

## 许可证

MIT License
