class AssetUtils {
  ///如若不是png，iconName需要添加扩展名
  static getAssetImage(String iconName, {bool isPNG = true}) {
    return isPNG ? 'assets/images/$iconName.png' : 'assets/images/$iconName';
  }

  static getAssetImagePNG(String iconName) {
    return 'assets/images/$iconName.png';
  }
  static getAssetImageWebP(String iconName) {
    return 'assets/images/$iconName.webp';
  }
}