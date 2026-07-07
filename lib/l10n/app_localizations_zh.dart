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
  String get snoozeLabel => '贪睡分钟数';

  @override
  String get volumeLabel => '应用音量';

  @override
  String get languageLabel => '语言';

  @override
  String get profileLabel => '个人资料';

  @override
  String get alarmsLabel => '闹钟';

  @override
  String get rankingLabel => '排名';

  @override
  String get settingsLabel => '设置';

  @override
  String get aboutLabel => '关于';

  @override
  String get noAlarms => '没有闹钟';

  @override
  String get addAlarmHint => '点击+添加一个';

  @override
  String get cancel => '取消';

  @override
  String get delete => '删除';

  @override
  String get selectAll => '全选';

  @override
  String get deselectAll => '取消全选';

  @override
  String selectedCount(Object count) {
    return '已选择 $count 个';
  }

  @override
  String get version => '版本 1.0.0';

  @override
  String get profileTitle => '个人资料';

  @override
  String get online => '在线';

  @override
  String get offline => '离线';

  @override
  String get noInternet => '无网络连接';

  @override
  String get guestName => '用户';

  @override
  String get scoreLabel => '分数';

  @override
  String pointsLabel(Object count) {
    return '$count 分';
  }

  @override
  String get accumulatedPoints => '累计分数';

  @override
  String get accountLabel => '账户';

  @override
  String get nameLabel => '姓名';

  @override
  String get emailLabel => '邮箱';

  @override
  String get signOut => '退出登录';

  @override
  String get loginToSync => '登录以同步数据，避免丢失';

  @override
  String get loginOrRegister => '登录 / 注册';

  @override
  String get noData => '无数据';

  @override
  String get noPlayersYet => '排行榜暂无玩家';

  @override
  String get createAccount => '创建账户';

  @override
  String get signIn => '登录';

  @override
  String get checkEmail => '检查您的邮箱';

  @override
  String emailVerificationSent(Object email) {
    return '我们已向 $email 发送验证链接';
  }

  @override
  String get backToHome => '返回首页';

  @override
  String get or => '或';

  @override
  String get yourName => '您的姓名';

  @override
  String get enterEmail => '输入您的邮箱';

  @override
  String get password => '密码';

  @override
  String get continueWithEmail => '使用邮箱继续';

  @override
  String get haveAccountSignIn => '已有账户？登录';

  @override
  String get noAccountRegister => '没有账户？注册';

  @override
  String get termsNotice => '继续即表示您同意服务条款和隐私政策。';

  @override
  String get continueWithGoogle => '使用 Google 继续';

  @override
  String get fillAllFields => '请填写所有字段';

  @override
  String get newAlarm => '新闹钟';

  @override
  String get editAlarm => '编辑闹钟';

  @override
  String get done => '完成';

  @override
  String get selectAtLeastOneDay => '请至少选择一天';

  @override
  String nextAlarmIn(Object time) {
    return '下次闹钟在 $time';
  }

  @override
  String get onceLabel => '仅一次';

  @override
  String get customizeLabel => '自定义';

  @override
  String get alarmName => '闹钟名称';

  @override
  String get ringtoneSetting => '铃声';

  @override
  String get defaultAlarmSound => '默认闹钟声音';

  @override
  String get vibrateLabel => '振动';

  @override
  String get amLabel => '上午';

  @override
  String get pmLabel => '下午';

  @override
  String get monShort => '一';

  @override
  String get tueShort => '二';

  @override
  String get wedShort => '三';

  @override
  String get thuShort => '四';

  @override
  String get friShort => '五';

  @override
  String get satShort => '六';

  @override
  String get sunShort => '日';

  @override
  String get monLong => '周一';

  @override
  String get tueLong => '周二';

  @override
  String get wedLong => '周三';

  @override
  String get thuLong => '周四';

  @override
  String get friLong => '周五';

  @override
  String get satLong => '周六';

  @override
  String get sunLong => '周日';

  @override
  String get ringOnce => '响一次';

  @override
  String get everyDay => '每天';

  @override
  String get weekdays => '周一至周五';

  @override
  String get noActiveAlarms => '没有活动闹钟';

  @override
  String get youWon => '你赢了';

  @override
  String get youLost => '你输了';

  @override
  String wordLabel(Object word) {
    return '单词: $word';
  }

  @override
  String scoreCapsLabel(Object count) {
    return '分数: $count 分';
  }

  @override
  String get aboutTitle => '关于 Alarmle';

  @override
  String get aboutDescription =>
      'Alarmle 是一款集成了 Wordle 的闹钟应用。每天早上通过解决每日谜题来唤醒自己，并测试你的思维。';

  @override
  String get featuresTitle => '功能特点';

  @override
  String get customAlarms => '自定义闹钟';

  @override
  String get customAlarmsDesc => '设置带有重复和自定义声音的闹钟';

  @override
  String get wordleGame => 'Wordle 小游戏';

  @override
  String get wordleGameDesc => '展示你的技能，通过解谜来关闭闹钟';

  @override
  String get cloudSync => '云同步';

  @override
  String get cloudSyncDesc => '与 Firebase 同步您的数据和分数';

  @override
  String get multiLanguage => '多语言';

  @override
  String get multiLanguageDesc => '提供西班牙语、英语、法语、葡萄牙语和中文版本';

  @override
  String get technologiesTitle => '技术栈';

  @override
  String get copyright => '© 2024 Alarmle. 保留所有权利。';

  @override
  String get solveWordleToStop => '解决 Wordle 以停止闹钟';

  @override
  String get dismissButton => '忽略';

  @override
  String get languageEnglish => '英语';

  @override
  String get languageSpanish => '西班牙语';

  @override
  String get languageFrench => '法语';

  @override
  String get languagePortuguese => '葡萄牙语';

  @override
  String get languageChinese => '中文';

  @override
  String get customLanguageLabel => '自定义语言';

  @override
  String get selectLanguageHint => '选择语言';

  @override
  String nextAlarmDays(Object days) {
    return '下次闹钟在 $days 天';
  }

  @override
  String nextAlarmHours(Object hours, Object mins) {
    return '$hours 小时 $mins 分钟';
  }

  @override
  String nextAlarmMinutes(Object mins) {
    return '$mins 分钟';
  }
}
