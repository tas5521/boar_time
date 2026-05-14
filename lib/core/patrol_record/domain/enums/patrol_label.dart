enum PatrolLabel { none, trap, capture, emergency }

extension PatrolLabelExt on PatrolLabel {
  String get displayName {
    switch (this) {
      case PatrolLabel.none:
        return '未入力';
      case PatrolLabel.trap:
        return '罠管理';
      case PatrolLabel.capture:
        return '捕獲';
      case PatrolLabel.emergency:
        return '緊急出動等';
    }
  }
}
