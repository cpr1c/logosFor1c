﻿
///////////////////////////////////////////////////
//Служебные функции и процедуры
///////////////////////////////////////////////////

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

	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"КоличествоСообщенийВПамятиРавно(Парам01)","КоличествоСообщенийВПамятиРавно","И количество сообщений в памяти равно 0","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯИзменяюУровеньЛогированияДляЛогаСИменемНа(Парам01,Парам02)","ЯИзменяюУровеньЛогированияДляЛогаСИменемНа","И я изменяю уровень логирования для лога с именем """" на ""Отладка""","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯДобавляюВЛогПоУмолчаниюСпособЛогированияПамять()","ЯДобавляюВЛогПоУмолчаниюСпособЛогированияПамять","И я добавляю в лог по умолчанию способ логирования Память","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"КоличествоСообщенийВПамятиЛогаСИменемРавно(Парам01,Парам02)","КоличествоСообщенийВПамятиЛогаСИменемРавно","И количество сообщений в памяти лога с именем """" равно 1","","");
	Ванесса.ДобавитьШагВМассивТестов(ВсеТесты,"ЯИзменяюУровеньЛогированияНаСервереДляЛогаСИменемНа(Парам01,Парам02)","ЯИзменяюУровеньЛогированияНаСервереДляЛогаСИменемНа","И я изменяю уровень логирования на сервере для лога с именем """" на ""Отладка""","","");

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



///////////////////////////////////////////////////
//Работа со сценариями
///////////////////////////////////////////////////

&НаКлиенте
// Функция выполняется перед началом каждого сценария
Функция ПередНачаломСценария() Экспорт
	лЛог.ОчиститьСписокЛогов();
КонецФункции

&НаКлиенте
// Функция выполняется перед окончанием каждого сценария
Функция ПередОкончаниемСценария() Экспорт
	
КонецФункции



///////////////////////////////////////////////////
//Реализация шагов
///////////////////////////////////////////////////

&НаКлиенте
//И я добавляю в лог по умолчанию способ логирования Память
//@ЯДобавляюВЛогПоУмолчаниюСпособЛогированияПамять()
Функция ЯДобавляюВЛогПоУмолчаниюСпособЛогированияПамять() Экспорт
	лЛог.ДобавитьСпособЛогированияПамять();	
КонецФункции

&НаКлиенте
//И количество сообщений в памяти равно 0
//@КоличествоСообщенийВПамятиРавно(Парам01)
Функция КоличествоСообщенийВПамятиРавно(ОжидаемоеКоличествоСообщений) Экспорт
	Ванесса.ПроверитьРавенство(лЛог.ДанныеЛога(), ОжидаемоеКоличествоСообщений);
КонецФункции

&НаКлиенте
//И количество сообщений в памяти лога с именем "" равно 0
//@КоличествоСообщенийВПамятиЛогаСИменемРавно(Парам01,Парам02)
Функция КоличествоСообщенийВПамятиЛогаСИменемРавно(ИмяЛога,ОжидаемоеКоличествоСообщений) Экспорт
	ТекЛог = ИмяЛога;
	Если Не ЗначениеЗаполнено(ТекЛог) Тогда
		ТекЛог =  Неопределено;
	КонецЕсли;
	
	Ванесса.ПроверитьРавенство(лЛог.ДанныеЛога(ТекЛог).Количество(), ОжидаемоеКоличествоСообщений);
КонецФункции

&НаКлиенте
//И я изменяю уровень логирования на сервере для лога с именем "" на "Отладка"
//@ЯИзменяюУровеньЛогированияНаСервереДляЛогаСИменемНа(Парам01,Парам02)
Функция ЯИзменяюУровеньЛогированияНаСервереДляЛогаСИменемНа(ИмяЛога,Уровень) Экспорт
	УстановитьНовыйУрровеньЛОгированияНаСервере(ИмяЛога, Уровень);
	лЛог.ОбновитьЛогиНаКлиентеПоДаннымСервера();
КонецФункции

&НаСервере
Процедура УстановитьНовыйУрровеньЛОгированияНаСервере(ИмяЛога, Уровень)
	ТекЛог = ИмяЛога;
	Если Не ЗначениеЗаполнено(ТекЛог) Тогда
		ТекЛог =  Неопределено;
	КонецЕсли;
	лЛог.УстановитьУровеньЛогирования(Уровень, ТекЛог);
КонецПроцедуры
