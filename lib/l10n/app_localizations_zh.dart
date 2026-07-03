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

  @override
  String get profileTitle => '个人资料';

  @override
  String get online => '在线';

  @override
  String get offline => '离线';

  @override
  String get noInternet => '没有网络连接';

  @override
  String get guestName => '用户';

  @override
  String get scoreLabel => '分数';

  @override
  String pointsLabel(int count) {
    return '$count 分';
  }

  @override
  String get accumulatedPoints => '累计分数';

  @override
  String get accountLabel => '账户';

  @override
  String get nameLabel => '姓名';

  @override
  String get emailLabel => '电子邮件';

  @override
  String get signOut => '退出登录';

  @override
  String get loginToSync => '登录以同步您的数据';

  @override
  String get loginOrRegister => '登录 / 注册';

  @override
  String get noData => '无数据';

  @override
  String get noPlayersYet => '排行榜中还没有玩家';

  @override
  String get createAccount => '创建账户';

  @override
  String get signIn => '登录';

  @override
  String get checkEmail => '检查您的电子邮件';

  @override
  String emailVerificationSent(String email) {
    return '我们向 $email 发送了验证链接';
  }

  @override
  String get backToHome => '返回首页';

  @override
  String get or => '或';

  @override
  String get yourName => '您的姓名';

  @override
  String get enterEmail => '输入您的电子邮件';

  @override
  String get password => '密码';

  @override
  String get continueWithEmail => '继续使用电子邮件';

  @override
  String get haveAccountSignIn => '已有账户？登录';

  @override
  String get noAccountRegister => '没有账户？注册';

  @override
  String get termsNotice => '继续即表示您同意服务条款和隐私政策。';

  @override
  String get continueWithGoogle => '继续使用 Google';

  @override
  String get fillAllFields => '填写所有字段';

  @override
  String get newAlarm => '新闹钟';

  @override
  String get editAlarm => '编辑闹钟';

  @override
  String get done => '完成';

  @override
  String get selectAtLeastOneDay => '至少选择一天';

  @override
  String nextAlarmIn(String time) {
    return '下一个闹钟在 $time';
  }

  @override
  String get onceLabel => '一次';

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
  String get youWon => '赢了';

  @override
  String get youLost => '输了';

  @override
  String wordLabel(String word) {
    return '单词: $word';
  }

  @override
  String scoreCapsLabel(int count) {
    return '分数: $count PTS';
  }
}
