// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get homeTitle => '首页';

  @override
  String get profileTab => '个人资料';

  @override
  String get leaderboardTab => '排行榜';

  @override
  String get settingsTitle => '设置';

  @override
  String get ringtoneLabel => '默认铃声';

  @override
  String get snoozeLabel => '贪睡分钟';

  @override
  String get volumeLabel => '应用音量';

  @override
  String get languageLabel => '语言';

  @override
  String get profileLabel => '个人资料';

  @override
  String get alarmsLabel => '闹钟';

  @override
  String get rankingLabel => '排行榜';

  @override
  String get settingsLabel => '设置';

  @override
  String get aboutLabel => '关于';

  @override
  String get noAlarms => '没有闹钟';

  @override
  String get addAlarmHint => '点击 + 添加一个';

  @override
  String get cancel => '取消';

  @override
  String get delete => '删除';

  @override
  String get selectAll => '全选';

  @override
  String get deselectAll => '取消全选';

  @override
  String selectedCount(int count) {
    return '已选择 $count 个';
  }

  @override
  String get version => '版本 1.0.0';
}
