
// @unit-test
// Параметры:
// 	Фреймворк - ФреймворкТестирования - Фреймворк тестирования
Процедура ПроверитьИнициализациюПоУмолчанию(Фреймворк) Экспорт

	лЛог.Инициализировать(Ложь);
	ПараметрыЛогирования = лЛог.ПараметрыЛогирования();

	Фреймворк.ПроверитьЛожь(ПараметрыЛогирования.Отключен);

	ЭталонноеЗначение = ПредопределенноеЗначение("Перечисление.лУровниЛогирования.Ошибка");
	ПроверяемоеЗначение = ПараметрыЛогирования.УровеньЛогирования;

	Фреймворк.ПроверитьРавенство(ЭталонноеЗначение, ПроверяемоеЗначение);

	Фреймворк.ПроверитьЗаполненность(ПараметрыЛогирования.УровеньЛогированияПредставление);

	Фреймворк.ПроверитьЗаполненность(ПараметрыЛогирования.ПриоритетУровняЛогирования);

	Фреймворк.ПроверитьНеЗаполненность(ПараметрыЛогирования.СпособыЛогирования);

	Фреймворк.ПроверитьЗаполненность(ПараметрыЛогирования.КлючСеанса);

	лЛог.ЗавершитьЛогирование();

КонецПроцедуры

// @unit-test
// Параметры:
// 	Фреймворк - ФреймворкТестирования - Фреймворк тестирования
Процедура ПроверитьИнициализациюПоИмениНастройки(Фреймворк) Экспорт

	лЛог.Инициализировать(Ложь, "unit-test-debug");
	ПараметрыЛогирования = лЛог.ПараметрыЛогирования();

	Фреймворк.ПроверитьЛожь(ПараметрыЛогирования.Отключен);

	ЭталонноеЗначение = ПредопределенноеЗначение("Перечисление.лУровниЛогирования.Отладка");
	ПроверяемоеЗначение = ПараметрыЛогирования.УровеньЛогирования;

	Фреймворк.ПроверитьРавенство(ЭталонноеЗначение, ПроверяемоеЗначение);

	Фреймворк.ПроверитьЗаполненность(ПараметрыЛогирования.УровеньЛогированияПредставление);

	Фреймворк.ПроверитьРавенство(0, ПараметрыЛогирования.ПриоритетУровняЛогирования);

	Фреймворк.ПроверитьЗаполненность(ПараметрыЛогирования.СпособыЛогирования);

	Фреймворк.ПроверитьЗаполненность(ПараметрыЛогирования.КлючСеанса);

	ПроверяемоеЗначение = ПараметрыЛогирования.СпособыЛогирования[ПредопределенноеЗначение(
		"Перечисление.лСпособыЛогирования.Файл")] <> Неопределено;

	Фреймворк.ПроверитьИстину(ПроверяемоеЗначение,
		"В параметрах логирования ожидается способ логирования ""Файл"", но он не найден");

	ПроверяемоеЗначение = ПараметрыЛогирования.СпособыЛогирования.Получить(ПредопределенноеЗначение(
		"Перечисление.лСпособыЛогирования.База")) <> Неопределено;

	Фреймворк.ПроверитьЛожь(ПроверяемоеЗначение,
		"В параметрах логирования не ожидается способ логирования ""База"", но он найден");

	лЛог.ЗавершитьЛогирование();

КонецПроцедуры

// @unit-test
// Параметры:
// 	Фреймворк - ФреймворкТестирования - Фреймворк тестирования
Процедура ПроверитьНеИнициализированноеОбращение(Фреймворк) Экспорт

	ПараметрыЛогирования = лЛог.ПараметрыЛогирования();

	Фреймворк.ПроверитьЛожь(ПараметрыЛогирования.Отключен);

	ЭталонноеЗначение = ПредопределенноеЗначение("Перечисление.лУровниЛогирования.Ошибка");
	ПроверяемоеЗначение = ПараметрыЛогирования.УровеньЛогирования;

	Фреймворк.ПроверитьРавенство(ЭталонноеЗначение, ПроверяемоеЗначение);

	Фреймворк.ПроверитьЗаполненность(ПараметрыЛогирования.УровеньЛогированияПредставление);

	Фреймворк.ПроверитьЗаполненность(ПараметрыЛогирования.ПриоритетУровняЛогирования);

	Фреймворк.ПроверитьНеЗаполненность(ПараметрыЛогирования.СпособыЛогирования);

	Фреймворк.ПроверитьЗаполненность(ПараметрыЛогирования.КлючСеанса);

	лЛог.ЗавершитьЛогирование();

КонецПроцедуры