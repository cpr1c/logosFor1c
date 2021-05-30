#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)

	ЛимитЗаписей = 200;

	Период.ДатаНачала = НачалоДня(ТекущаяДатаСеанса());
	Период.ДатаОкончания = ТекущаяДатаСеанса();

	Для Каждого ИмяСобытия Из РазличныеПоляЗаписей("ИмяСобытия") Цикл
		ОтборИмяСобытия.Добавить(ИмяСобытия);
	КонецЦикла;

	Для Каждого КлючСеанса Из РазличныеПоляЗаписей("КлючСеанса") Цикл
		ОтборКлючСеанса.Добавить(КлючСеанса);
	КонецЦикла;

КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ОтборИмяСобытияПометкаПриИзменении(Элемент)
	Если ОбновлятьСразу Тогда
		ОбновитьЛог();
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ОтборКлючСеансаПометкаПриИзменении(Элемент)
	Если ОбновлятьСразу Тогда
		ОбновитьЛог();
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ПериодПриИзменении(Элемент)
	Если ОбновлятьСразу Тогда
		ОбновитьЛог();
	КонецЕсли;
КонецПроцедуры

&НаКлиенте
Процедура ЛимитЗаписейПриИзменении(Элемент)
	Если ОбновлятьСразу Тогда
		ОбновитьЛог();
	КонецЕсли;
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура ОбновитьЛогКоманда(Команда)

	ОбновитьЛог();

КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

&НаСервере
Функция РазличныеПоляЗаписей(ИмяПоля)

	РазличныеПоля = Новый Массив;

	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ РАЗЛИЧНЫЕ Записи." + ИмяПоля + " КАК Значение 
														   |ИЗ РегистрСведений.лСообщенияЛогирования КАК Записи";

	Выборка = Запрос.Выполнить().Выбрать();

	Пока Выборка.Следующий() Цикл
		РазличныеПоля.Добавить(Выборка.Значение);
	КонецЦикла;

	Возврат РазличныеПоля;

КонецФункции

&НаСервере
Процедура ОбновитьЛог()

	ПоляОтбора = Новый Структура;

	Для Каждого Эл Из ОтборИмяСобытия Цикл
		Если Эл.Пометка Тогда
			Если Не ПоляОтбора.Свойство("ИменаСобытия") Тогда
				ПоляОтбора.Вставить("ИменаСобытия", Новый Массив);
			КонецЕсли;
			ПоляОтбора.ИменаСобытия.Добавить(Эл.Значение);
		КонецЕсли;
	КонецЦикла;

	Для Каждого Эл Из ОтборКлючСеанса Цикл
		Если Эл.Пометка Тогда
			Если Не ПоляОтбора.Свойство("КлючиСеанса") Тогда
				ПоляОтбора.Вставить("КлючиСеанса", Новый Массив);
			КонецЕсли;
			ПоляОтбора.КлючиСеанса.Добавить(Эл.Значение);
		КонецЕсли;
	КонецЦикла;

	Если ЗначениеЗаполнено(Период.ДатаНачала) Тогда
		ПоляОтбора.Вставить("ДатаНач", Период.ДатаНачала);
		ПоляОтбора.Вставить("ДатаКон", Период.ДатаОкончания);
	КонецЕсли;

	Если ЗначениеЗаполнено(ЛимитЗаписей) Тогда
		ПоляОтбора.Вставить("ЛимитЗаписей", ЛимитЗаписей);
	КонецЕсли;

	ДанныеПросмотра = лЛог.ЛогИзБазы(ПоляОтбора);

КонецПроцедуры

#КонецОбласти