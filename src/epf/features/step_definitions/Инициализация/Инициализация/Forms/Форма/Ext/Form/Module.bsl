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

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ПроверяюЕгоНаличиеНаКлиентеИСервере()","ПроверяюЕгоНаличиеНаКлиентеИСервере","И проверяю его наличие на клиенте и сервере","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯЗапускаюСценарийОткрытияTestClientИлиПодключаюУжеСуществующий()","ЯЗапускаюСценарийОткрытияTestClientИлиПодключаюУжеСуществующий","Дано Я запускаю сценарий открытия TestClient или подключаю уже существующий","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯИнициализируюОдинЛогНаКлиентеПоУмолчанию()","ЯИнициализируюОдинЛогНаКлиентеПоУмолчанию","И я инициализирую один лог на клиенте по умолчанию","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"НаКлиентеИСервереДолженБытьЛогСИменемПоУмолчанию()","НаКлиентеИСервереДолженБытьЛогСИменемПоУмолчанию","И на клиенте и сервере должен быть лог с именем по умолчанию","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯИнициализируюОдинЛогНаСервереПоУмолчанию()","ЯИнициализируюОдинЛогНаСервереПоУмолчанию","И я инициализирую один лог на сервере по умолчанию","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯИнициализируюОдинЛогНаКлиентеСИменем(Парам01)","ЯИнициализируюОдинЛогНаКлиентеСИменем","И я инициализирую один лог на клиенте с именем ""ПервыйЛог""","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"КоличествоЛоговНаКлиентеДолжноБытьРавно(Парам01)","КоличествоЛоговНаКлиентеДолжноБытьРавно","И количество логов на клиенте должно быть равно 3","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"КоличествоЛоговНаСервереДолжноБытьРавно(Парам01)","КоличествоЛоговНаСервереДолжноБытьРавно","И количество логов на сервере должно быть равно 3","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"НаКлиентеИСервереДолженБытьЛогСИменем(Парам01)","НаКлиентеИСервереДолженБытьЛогСИменем","И на клиенте и сервере должен быть лог с именем ""ПервыйЛог""","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯИнициализируюОдинЛогНаСервереСИменем(Парам01)","ЯИнициализируюОдинЛогНаСервереСИменем","И я инициализирую один лог на сервере с именем ""ПервыйЛог""","","");

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
//И я инициализирую один лог на клиенте по умолчанию
//@ЯИнициализируюОдинЛогНаКлиентеПоУмолчанию()
Функция ЯИнициализируюОдинЛогНаКлиентеПоУмолчанию() Экспорт
	лЛог.НовыйЛог();
КонецФункции

&НаКлиенте
//И проверяю его наличие на клиенте и сервере
//@ПроверяюЕгоНаличиеНаКлиентеИСервере()
Функция ПроверяюЕгоНаличиеНаКлиентеИСервере() Экспорт
	Лог = лЛог.ЛогПоИмени();
	Ванесса.ПроверитьНеРавенство(Лог, Неопределено, "Не доступен лог на клиенте");
	ПроверитьНаличиеЛогаНаСервере();
КонецФункции

&НаКлиенте
//И я инициализирую один лог на сервере по умолчанию
//@ЯИнициализируюОдинЛогНаСервереПоУмолчанию()
Функция ЯИнициализируюОдинЛогНаСервереПоУмолчанию() Экспорт
	ИнициализироватьЛогНаСервере();
	лЛог.ОбновитьЛогиНаКлиентеПоДаннымСервера();
КонецФункции

&НаСервере
Процедура ПроверитьНаличиеЛогаНаСервере()
	Лог = лЛог.ЛогПоИмени();
	Если Лог = Неопределено Тогда
		ВызватьИсключение "Не доступен лог на сервере";
	КонецЕсли;
КонецПроцедуры

&НаСервере
Процедура ИнициализироватьЛогНаСервере()
	лЛог.НовыйЛог();
КонецПроцедуры

&НаКлиенте
//И на клиенте и сервере должен быть лог с именем по умолчанию
//@НаКлиентеИСервереДолженБытьЛогСИменемПоУмолчанию()
Функция НаКлиентеИСервереДолженБытьЛогСИменемПоУмолчанию() Экспорт
	Лог = лЛог.ЛогПоИмени();
	Если Лог = Неопределено Тогда
		ВызватьИсключение "Лог по умолчанию не инициализирован";
	КонецЕсли;
	
	Ванесса.ПроверитьРавенство(Лог.Имя, "logFor1C");
	НаСервереДолженБытьЛогСИменем("logFor1C");
КонецФункции

&НаКлиенте
//И я инициализирую один лог на клиенте с именем "ПервыйЛог"
//@ЯИнициализируюОдинЛогНаКлиентеСИменем(Парам01)
Функция ЯИнициализируюОдинЛогНаКлиентеСИменем(ИмяЛога) Экспорт
	лЛог.НовыйЛог(ИмяЛога);
КонецФункции

&НаКлиенте
//И на клиенте и сервере должен быть лог с именем "ПервыйЛог"
//@НаКлиентеИСервереДолженБытьЛогСИменем(Парам01)
Функция НаКлиентеИСервереДолженБытьЛогСИменем(ИмяЛога) Экспорт
	Лог = лЛог.ЛогПоИмени();
	Ванесса.ПроверитьНеРавенство(Лог.Имя, ИмяЛога, "Не доступен лог на клиенте с именем "+ИмяЛога );
	НаСервереДолженБытьЛогСИменем(ИмяЛога);
КонецФункции

&НаСервере
Процедура НаСервереДолженБытьЛогСИменем(ИмяЛога) 
	Лог = лЛог.ЛогПоИмени(ИмяЛога);
	Если Лог = Неопределено Тогда
		ВызватьИсключение "Не доступен лог на сервере с именем "+ИмяЛога;
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
//И количество логов на клиенте должно быть равно 3
//@КоличествоЛоговНаКлиентеДолжноБытьРавно(Парам01)
Функция КоличествоЛоговНаКлиентеДолжноБытьРавно(КоличествоЛогов) Экспорт
	АктивныеЛоги = лЛог.АктивныеЛоги();
	Ванесса.ПроверитьРавенство(АктивныеЛоги.Количество(), КоличествоЛогов, "Неправильное количество логов на клиенте");
КонецФункции

&НаКлиенте
//И количество логов на сервере должно быть равно 3
//@КоличествоЛоговНаСервереДолжноБытьРавно(Парам01)
Функция КоличествоЛоговНаСервереДолжноБытьРавно(КоличествоЛогов) Экспорт
	КоличествоЛоговНаСервереДолжноБытьРавноНаСервере(КоличествоЛогов);
КонецФункции

&НаСервере
Процедура КоличествоЛоговНаСервереДолжноБытьРавноНаСервере(КоличествоЛогов) 
	АктивныеЛоги = лЛог.АктивныеЛоги();
	
	Если АктивныеЛоги.Количество()<>КоличествоЛогов Тогда
		ВызватьИсключение "На сервере нет необходимого количества логов. Сейчас "+АктивныеЛоги.Количество();
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
//И я инициализирую один лог на сервере с именем "ПервыйЛог"
//@ЯИнициализируюОдинЛогНаСервереСИменем(Парам01)
Функция ЯИнициализируюОдинЛогНаСервереСИменем(ИмяЛога) Экспорт
	ИнициализироватьЛогНаСервереСИменем(ИмяЛога);
	лЛог.ОбновитьЛогиНаКлиентеПоДаннымСервера();
КонецФункции

&НаСервере
Процедура ИнициализироватьЛогНаСервереСИменем(ИмяЛога)
	лЛог.НовыйЛог(ИмяЛога);
КонецПроцедуры

