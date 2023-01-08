## 사용법
> ./transactions_per_day_v1.0.sh 폴더명 날짜포맷NUM


```bash
test@ykd2:~/gitwork_day$ ls accesslog
access.202209220000  access.202209230000  access.202209240000  access.202209250000  access.202209260000  access.202209270000  access.202209280000

test@ykd2:~/gitwork_day$ ./transactions_per_day_v1.0.sh accesslog 1


Total Line Count : 8364386

******************Group by Method*****************
GET Methon Count : 4102551

POST Method Count : 4257950

OPTION Method Count : 2376

HEAD Method Count : 1502

ETC Count : 7

Method Total Count : 8364386

GET AND POST Method to Test Count : 8360501

OK
**********Group by Dynamic & Statuc***************
Static pages in GETPOST Count : 1874588

Dynamic pages in GETPOST Count : 6485913

OK
*********transaction count per day****************
Dynamic pages in GET AND POST
20/Sep/2022 : 1
21/Sep/2022 : 1021974
22/Sep/2022 : 1084094
23/Sep/2022 : 1073290
24/Sep/2022 : 366588
25/Sep/2022 : 187425
26/Sep/2022 : 1345414
27/Sep/2022 : 1407127
SUM : 6485913

OK
