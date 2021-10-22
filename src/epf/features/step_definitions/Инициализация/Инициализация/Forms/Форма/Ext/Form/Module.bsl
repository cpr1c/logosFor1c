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

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯИнициализируюОдинЛогНаКлиентеПоУмолчанию()","ЯИнициализируюОдинЛогНаКлиентеПоУмолчанию","И я инициализирую один лог на клиенте по умолчанию","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ПроверяюЕгоНаличиеНаКлиентеИСервере()","ПроверяюЕгоНаличиеНаКлиентеИСервере","И проверяю его наличие на клиенте и сервере","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯИнициализируюОдинЛогНаСервереПоУмолчанию()","ЯИнициализируюОдинЛогНаСервереПоУмолчанию","И я инициализирую один лог на сервере по умолчанию","","");

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
