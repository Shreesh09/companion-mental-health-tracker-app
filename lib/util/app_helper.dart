import '../resources/app_assets.dart';

enum ChartType { line, bar, pie, scatter, radar }

extension ChartTypeExtension on ChartType {
  String getDisplayName() => '${getSimpleName()} Chart';

  String getSimpleName() {
    switch (this) {
      case ChartType.line:
        return 'Line';
      case ChartType.bar:
        return 'Bar';
      case ChartType.pie:
        return 'Pie';
      case ChartType.scatter:
        return 'Scatter';
      case ChartType.radar:
        return 'Radar';
    }
  }

  String get assetIcon => AppAssets.getChartIcon(this);
}
