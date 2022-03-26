# Домашнее задание к занятию "10.01. Зачем и что нужно мониторить"

> 1. Вас пригласили настроить мониторинг на проект. На онбординге вам рассказали, что проект представляет из себя платформу для вычислений с выдачей текстовых отчетов, которые сохраняются на диск. Взаимодействие с платформой осуществляется по протоколу http. Также вам отметили, что вычисления загружают ЦПУ. Какой минимальный набор метрик вы выведите в мониторинг и почему?

1. коды ответов web-сервера  - количество успешных/неуспешных ответов
2. CPU LA - хватает ли мощности ЦПУ для вычислений
3. RAM/swap - загрузка ОЗУ
4. HDD/inodes - оставшееся свободное место для отчетов, логов, временных файлов
5. IOPS - количество операций ввода-вывода в секунду, мониторинг производительности дисковой системы
6. Загруженность по сети


> 2. Менеджер продукта посмотрев на ваши метрики сказал, что ему непонятно что такое RAM/inodes/CPUla. Также он сказал, что хочет понимать, насколько мы выполняем свои обязанности перед клиентами и какое качество обслуживания. Что вы можете ему предложить?
> 
Можно ввести понятные для менеджера метрики, например SLI.

SLI - индикатор качества обслуживания. Измеряет соответствие цели уровня обслуживания (SLO).

SLO - целевой уровень качества обслуживания. Например, время безотказной работы.

SLA (Service Level Agreement ) - соглашение об уровне обслуживания. Это соглашение между поставщиком и клиентом, который оплачивает сервис, включающий в себя последствия невыполнения SLO.

Например, в SLA указано, что сервис должен быть доступен 99,8% времени. Тогда для этого конкретного параметра SLO принимается равным 99,8 % времени. Тогда SLI — фактическое измеренное время безотказной работы. Чтобы удовлетворять требованиям SLA, показатель SLI должен соответствовать или быть выше параметров, прописанных в SLA.


> 3. Вашей DevOps команде в этом году не выделили финансирование на построение системы сбора логов. Разработчики в свою очередь хотят видеть все ошибки, которые выдают их приложения. Какое решение вы можете предпринять в этой ситуации, чтобы разработчики получали ошибки приложения?

В этом случае можно развернуть opensource сервисы для сбора логов, использовать системы сбора логов в реальном времени или же задать небольшой срок хранения логов и метрик, чтобы сэкономить ресурсы. 

> 4. Вы, как опытный SRE, сделали мониторинг, куда вывели отображения выполнения SLA=99% по http кодам ответов. Вычисляете этот параметр по следующей формуле: summ_2xx_requests/summ_all_requests. Данный параметр не поднимается выше 70%, но при этом в вашей системе нет кодов ответа 5xx и 4xx. Где у вас ошибка?

Нужно учесть коды 30x, 
Использовать следующую формулу:
SLI = (summ_2xx_requests + summ_3xx_requests)/(summ_all_requests)