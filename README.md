# TrafficLightFPGA

## [RUS]

Первый и относительно простой проект для ПЛИС. Реализует управление четырмя светодиодами.

Один диод - сигнал таймера, мигает с частотой в пол-секунды. Оставшиеся три - имитация работы трехцветного светофора. Для полноты счастья рекомендую использовать диоды соответствующих цветов.

### Содержимое проекта.

Папка "Svetofors_025" содержит Quartus проект.

Проект распространяется по либеральной лицензии MIT, текст которой приводится в файле "LICENSE".

Файл "README.md" содержит данное описание проекта.

Принципиальная схема проекта приводится в "Svetofors_025_scheme.png".

### Для реализации проекта потребуются следующие компоненты:

1. Учебная плата от Waveshare CoreEP4CE10 на базе Cyclone IV. Простая, дешевая, китайская.
 На Ebay и AliExpress широкий выбор.
 Можно использовать платы и на более простых чипах с логическими уровнями на выводах не более 3,3 В. Но.
 Придется менять назначения выводов в проекте согласно Вашей схемы.  
 Кнопка сброса, генератор тактовой частоты на 50 МГц, и один красный светодиод, из имеющегося на плате CoreEP4CE10.
  
2. Три светодиода повышеной светоотдачи (в номенклатуре обозначаются как bright): красный, желтый и зеленый.

3. Три токоограничивающих резистора: два на 620 Ом (для красного и желтого диодов) и один на 200 Ом (для зеленого).
  Минимальной мощности, от 0,125 Вт. Номинал резисторов может быть и больше или меньше, до двух раз от указаного.
  Чем больше сопротивление, тем слабее будут светиться диоды.
  
4. Для удобства коммутации: вилка штыревая типа PLD-12 (шаг 2,54 мм, 12 контактов) или аналог. 
  Плюс соединительные провода с гнездами на вилку с шагом 2,54 мм (с одной стороны) и 2 мм (со стороны платы CoreEP4CE10).
  
5. Макетная плата для монтажа диодов и резисторов.

Проект создан в Altera Quartus 13.0.1. Язык описания модулей: Verylog HDL.

## [ENG]

The first simple FPGA project. Four LEDs: a traffic light plus time.

### Files description.

"Svetofors_025" is a quartus project folder.

"LICENSE" - is project MIT license.

"README.md" - this readme file.

"Svetofors_025_scheme.png" is a project electrical scheme.

### Project needs components:

1. A demo board Waveshare CoreEP4CE10, Cyclone IV based. Simple, cheap, chinese.
 You may use boards with simpler chips, but logic level must be not higher 3,3 V. 
 And pin assigments the project must be changed too.  
 A reset button, 50 MHz clock generator and red led placed on CoreEP4CE10 board.

2. Three bright leds: red, yellow and green.

3. Three resistors for current limit. Two 620 Ohm for red, yellow. 200 Ohm for green. Low wattage, like 0.125 W.
  The higher or lower resistor values may be used. Double, maximum.
  
4. A PLD-12 connector or equal. Connect wires with 2.45 mm and 2 mm tips. For usability.

5. A prototyping board.

Project was created with Altera Quartus 13.0.1. Modules language is Verilog HDL.
