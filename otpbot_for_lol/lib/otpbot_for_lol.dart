import 'dart:math';

import 'package:logger/logger.dart';
import 'package:otpbot_for_lol/otpbot_for_lol.dart';
import 'package:teledart/model.dart';
import 'package:teledart/teledart.dart';
import 'package:teledart/telegram.dart';
import 'package:test/test.dart';

void main()async {
const token = '5575781544:AAE5QrKeVNRowZR1vSp7QMbpnx9Y7u55LS4';
final username = (await Telegram(token).getMe()).username;
  var teledart = TeleDart(token, Event(username!));
  teledart.start();
 
  // var telegram = Telegram(token); 2 варианат включения бота
  // var event = Event((await telegram.getMe()).username!);
  // final bot = TeleDart(token, event);
teledart
    .onCommand("start")
    .listen((message) => message.reply('Приветствую, Призыватель! Я создан , что бы помогат выбирать OTP персонажа для LOL, исходя из твоей роли, эло и персонажей, на которых ты играешь! Введи свой ник...'));
teledart 
  .onMessage()
  .listen((event){String? usermessage=(event.text ?? '');event.reply("Ну $usermessage и пидорас, конечно!!");})


  
;}