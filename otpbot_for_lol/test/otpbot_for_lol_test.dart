import 'package:logger/logger.dart';
import 'package:otpbot_for_lol/otpbot_for_lol.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';
import 'package:test/test.dart';
// ().then((me) => print('${me.username} is initaialised'));
// teledart.onCommand('hello');
// .listen((message)=> teledart.replyMessage(message,'world'));
void main() {
const token = '5575781544:AAE5QrKeVNRowZR1vSp7QMbpnx9Y7u55LS4';
group("otpBot",(){
setUp(() async{
  final username = (await Telegram(token).getMe()).username;
  var teledart = TeleDart(token, Event(username!));
  teledart.start();
  test("UnitTest",() async{
    teledart
    .onCommand("start")
    .listen((message) => message.reply('Приветствую, Призыватель! Я создан , что бы помогат выбирать OTP персонажа для LOL, исходя из твоей роли, эло и персонажей, на которых ты играешь!'));
    teledart.sendMessage(teledart, ('Введи свой ник'));
    await Future.delayed(Duration(seconds: 7));
    
  });
});
});
}