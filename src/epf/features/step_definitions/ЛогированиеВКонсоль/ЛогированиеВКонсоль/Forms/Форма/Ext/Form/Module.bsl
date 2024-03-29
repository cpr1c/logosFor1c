﻿
#Область Служебные_функции_и_процедуры

&НаКлиенте
// контекст фреймворка Vanessa-Automation
Перем Ванесса;
 
&НаКлиенте
// Структура, в которой хранится состояние сценария между выполнением шагов. Очищается перед выполнением каждого сценария.
Перем Контекст Экспорт;
 
&НаКлиенте
// Структура, в которой можно хранить служебные данные между запусками сценариев. Существует, пока открыта форма Vanessa-Automation.
Перем КонтекстСохраняемый Экспорт;

&НаКлиенте
// Функция экспортирует список шагов, которые реализованы в данной внешней обработке.
Функция ПолучитьСписокТестов(КонтекстФреймворкаBDD) Экспорт
	Ванесса = КонтекстФреймворкаBDD;
	
	ВсеТесты = Новый Массив;

	//описание параметров
	//Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,Снипет,ИмяПроцедуры,ПредставлениеТеста,ОписаниеШага,ТипШага,Транзакция,Параметр);

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯДобавляюВЛогПоУмолчаниюСпособЛогирования(Парам01)","ЯДобавляюВЛогПоУмолчаниюСпособЛогирования","И я добавляю в лог по умолчанию способ логирования ""Консоль""","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯВывожуЛогСУровнемЛогированияОтладкаСообщениеВЛогВИменем(Парам01,Парам02)","ЯВывожуЛогСУровнемЛогированияОтладкаСообщениеВЛогВИменем","И я вывожу лог с уровнем логирования отладка сообщение ""Привет. Это первый лог в консоли"" в лог с именем """"","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯВывожуЛогСУровнемЛогированияОтладкаСообщениеНеСервереВЛогСИменем(Парам01,Парам02)","ЯВывожуЛогСУровнемЛогированияОтладкаСообщениеНеСервереВЛогСИменем","и я вывожу лог с уровнем логирования отладка сообщение не сервере ""Привет. Этого лога не должно быть"" в лог с именем ""ЛогироватьНеУмею""","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯИнициализируюЛогПоУмолчаниюНаКлиенте()","ЯИнициализируюЛогПоУмолчаниюНаКлиенте","И я инициализирую лог по умолчанию на клиенте","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯИнициализируюЛогСИменемНаКлиенте(Парам01)","ЯИнициализируюЛогСИменемНаКлиенте","И я инициализирую лог с именем ""ЛогироватьНеУмею"" на клиенте","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯДобавляюВЛогПоУмолчаниюСпособЛогированияКонсоль()","ЯДобавляюВЛогПоУмолчаниюСпособЛогированияКонсоль","И я добавляю в лог по умолчанию способ логирования Консоль","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯВывожуЛогСУровнемЛогированияОтладкаСообщениеВЛогСИменем(Парам01,Парам02)","ЯВывожуЛогСУровнемЛогированияОтладкаСообщениеВЛогСИменем","И я вывожу лог с уровнем логирования отладка сообщение ""Привет. Это первый лог в консоли"" в лог с именем """"","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯВывожуЛогСУровнемЛогированияОтладкаСообщениеНаСервереВЛогСИменем(Парам01,Парам02)","ЯВывожуЛогСУровнемЛогированияОтладкаСообщениеНаСервереВЛогСИменем","И я вывожу лог с уровнем логирования отладка сообщение на сервере ""Привет. Это первый лог в консоли"" в лог с именем """"","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯВывожуЛогСУровнемЛогированияИнформацияСообщениеВЛогСИменем(Парам01,Парам02)","ЯВывожуЛогСУровнемЛогированияИнформацияСообщениеВЛогСИменем","И я вывожу лог с уровнем логирования информация сообщение ""Привет. Это первый лог в консоли"" в лог с именем """"","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"КоличествоСообщениеПользователюРавно(Парам01)","КоличествоСообщениеПользователюРавно","И количество сообщение пользователю равно 1","","");

	Возврат ВсеТесты;
КонецФункции
	
&НаСервере
// Служебная функция.
Функция ПолучитьМакетСервер(ИмяМакета)
	ОбъектСервер = РеквизитФормыВЗначение("Объект");
	Возврат ОбъектСервер.ПолучитьМакет(ИмяМакета);
КонецФункции
	
&НаКлиенте
// Служебная функция для подключения библиотеки создания fixtures.
Функция ПолучитьМакетОбработки(ИмяМакета) Экспорт
	Возврат ПолучитьМакетСервер(ИмяМакета);
КонецФункции

#КонецОбласти



#Область Работа_со_сценариями

&НаКлиенте
// Функция выполняется перед началом каждого сценария
Функция ПередНачаломСценария() Экспорт
	лЛог.ОчиститьСписокЛогов();
	ОчиститьСообщения();
КонецФункции

&НаКлиенте
// Функция выполняется перед окончанием каждого сценария
Функция ПередОкончаниемСценария() Экспорт
	
КонецФункции

#КонецОбласти


///////////////////////////////////////////////////
//Реализация шагов
///////////////////////////////////////////////////

&НаКлиенте
//И я инициализирую лог по умолчанию на клиенте
//@ЯИнициализируюЛогПоУмолчаниюНаКлиенте()
Функция ЯИнициализируюЛогПоУмолчаниюНаКлиенте() Экспорт
	лЛог.НовыйЛог();
КонецФункции

&НаКлиенте
//И я инициализирую лог с именем "ЛогироватьНеУмею" на клиенте
//@ЯИнициализируюЛогСИменемНаКлиенте(Парам01)
Функция ЯИнициализируюЛогСИменемНаКлиенте(ИмяЛога) Экспорт
	лЛог.НовыйЛог(ИмяЛога);
КонецФункции

&НаКлиенте
//и я вывожу лог с уровнем логирования отладка сообщение "Привет. Этого лога не должно быть" в лог с именем "ЛогироватьНеУмею"
//@ЯВывожуЛогСУровнемЛогированияОтладкаСообщениеВЛогСИменем(Парам01,Парам02)
Функция ЯВывожуЛогСУровнемЛогированияОтладкаСообщениеВЛогСИменем(Сообщение,ИмяЛога) Экспорт
	Если Не ЗначениеЗаполнено(ИмяЛога) Тогда
		лЛог.Отл_(Сообщение);
	Иначе
		лЛог.Отл_(Сообщение, ИмяЛога);
	КонецЕсли;
КонецФункции

&НаКлиенте
//И я добавляю в лог по умолчанию способ логирования Консоль
//@ЯДобавляюВЛогПоУмолчаниюСпособЛогированияКонсоль()
Функция ЯДобавляюВЛогПоУмолчаниюСпособЛогированияКонсоль() Экспорт
	лЛог.ДобавитьСпособЛогированияКонсоль();	
КонецФункции

&НаКлиенте
//И я вывожу лог с уровнем логирования отладка сообщение на сервере "Привет. Это первый лог в консоли" в лог с именем ""
//@ЯВывожуЛогСУровнемЛогированияОтладкаСообщениеНаСервереВЛогСИменем(Парам01,Парам02)
Функция ЯВывожуЛогСУровнемЛогированияОтладкаСообщениеНаСервереВЛогСИменем(Сообщение, ИмяЛога) Экспорт
	ВывестиЛогОтладкаСообщенияНаСервере(Сообщение, ИмяЛога);
КонецФункции

&НаСервере
Процедура ВывестиЛогОтладкаСообщенияНаСервере(Сообщение, ИмяЛога)
	Если Не ЗначениеЗаполнено(ИмяЛога) Тогда
		лЛог.Отл_(Сообщение);
	Иначе
		лЛог.Отл_(Сообщение, ИмяЛога);
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
//И я вывожу лог с уровнем логирования информация сообщение "Привет. Это первый лог в консоли" в лог с именем ""
//@ЯВывожуЛогСУровнемЛогированияИнформацияСообщениеВЛогСИменем(Парам01,Парам02)
Функция ЯВывожуЛогСУровнемЛогированияИнформацияСообщениеВЛогСИменем(Сообщение, ИмяЛога) Экспорт
	Если Не ЗначениеЗаполнено(ИмяЛога) Тогда
		лЛог.Инф_(Сообщение);
	Иначе
		лЛог.Инф_(Сообщение, ИмяЛога);
	КонецЕсли;
КонецФункции

&НаКлиенте
//И количество сообщение пользователю равно 1
//@КоличествоСообщениеПользователюРавно(Парам01)
Функция КоличествоСообщениеПользователюРавно(КоличествоСообщений) Экспорт
	Окна = ПолучитьОкна();
	ОкноМое = АктивноеОкно();
	ВызватьИсключение "Дальше";
	//ТекстыСообщений = ПолучитьСообщенияПользователю(Ложь);
	//ТестовоеПриложение = Ванесса.ПолучитьТестовоеПриложение();
	//АктивноеОкноТеста = ТестовоеПриложение.ПолучитьАктивноеОкно();	
	//ТекстыСообщений = АктивноеОкноТеста.ПолучитьПодчиненныеОбъекты();
	//
	//Ванесса.ПроверитьРавенство(ТекстыСообщений.Количество(), КоличествоСообщений);
КонецФункции
