USE [Bank_loan];
GO
select * from financial_loan

--------Total loan applications--------
select count(id) Total_alpplications from financial_loan

--------MTD applications--------
select count(id) as no_of_applications from financial_loan
where month(issue_date)=(
select max(month(issue_date)) from financial_loan)

--pmtd appilcations----------
select count(id) as no_of_applications from financial_loan
where month(issue_date)=(
select max(month(issue_date)-1) from financial_loan)

--------good loan percentage--------
select
(count(case when loan_status='Fully paid' or loan_status='Current' then id end)*100)/count(id) as Good_loan_percentage
from financial_loan
-----------or-----------
select count(case when loan_status in('Fully Paid','Current')then 1 end)*100/count(id) as good_loans from financial_loan
select count(case when loan_status not in('Fully Paid','Current')then 1 end)*100/count(id) as good_loans from financial_loan
---Avg int rate--
select concat(round(avg(int_rate),2),'%')as Avg_interest from financial_loan

---mtd int rate----
select concat(round(avg(int_rate),2),'%')as MTD_avg_interest from financial_loan
where MONTH(issue_date)=(select max(MONTH(issue_date)) from financial_loan)

---mtd int rate----

select concat(round(avg(int_rate),2),'%')as PMTD_avg_interest from financial_loan
where MONTH(issue_date)=(select max(MONTH(issue_date)-1) from financial_loan)

---avg dti rate----
select concat(round(avg(dti),2),'%')as Avg_dti from financial_loan

---mtd avg dti rate----
select concat(round(avg(dti),2),'%')as MTD_avg_dti from financial_loan
where MONTH(issue_date)=(select max(MONTH(issue_date)) from financial_loan)

---pmtd dti avg rate----

select concat(round(avg(dti),2),'%')as PMTD_avg_dti from financial_loan
where MONTH(issue_date)=(select max(MONTH(issue_date)-1) from financial_loan)

---------Total funded amount-----------
select sum(loan_amount)from financial_loan

----MTD funded amount-----
select sum(loan_amount) MTD_amount from financial_loan
where MONTH(issue_date)=(select max(MONTH(issue_date)) from financial_loan)

----------PMTD funded amount-----------
select sum(loan_amount) PMTD_amount from financial_loan
where MONTH(issue_date)=(select max(MONTH(issue_date)-1) from financial_loan)

---Good loan funded amount---------
select sum(loan_amount)from financial_loan
where loan_status <>'Charged Off'

select sum(loan_amount) Good_loan_funded_amount from financial_loan
where loan_status in('Fully Paid','Current')

select sum(total_payment) Good_loan_amount_recieved from financial_loan
where loan_status in('Fully Paid','Current')

--------------Bad loan funded amount------
select sum(loan_amount) Bad_loan_funded_amount from financial_loan
where loan_status='Charged Off'

---Bad loan amount received----------
select sum(total_payment) Bad_loan_amount_recieved from financial_loan
where loan_status='Charged Off'

---------------Total Amount received--------
select sum(total_payment) Total_amount_received from financial_loan

-----MTD received amount-----------
select sum(total_payment) MTD_recieved_amount from financial_loan
where MONTH(issue_date)=(select max(MONTH(issue_date)) from financial_loan)

--PMTD received amount------------
select sum(total_payment) PMTD_receievd_amount from financial_loan
where MONTH(issue_date)=(select max(MONTH(issue_date)-1) from financial_loan)

----Loan status-------
select loan_status,
count(id) loanCount,
sum(loan_amount) total_funded_amount,
sum(total_payment) total_amount_received,
avg(int_rate) avg_int_rate,
avg(dti) avg_dti
from financial_loan
group by loan_status

---MTD loan status------------
select loan_status,
count(id) loanCount,
sum(loan_amount) total_funded_amount,
sum(total_payment) total_amount_received
from financial_loan
where MONTH(issue_date)=(select max(MONTH(issue_date)) from financial_loan)
group by loan_status

---PMTD loan status------------
select loan_status,
count(id) loanCount,
sum(loan_amount) total_funded_amount,
sum(total_payment) total_amount_received
from financial_loan
where MONTH(issue_date)=(select max(MONTH(issue_date)-1) from financial_loan)
group by loan_status

---Bank report over view-------
select  month(issue_date) as Month_count,
datename(MONTH,issue_date) as Month_name,
count(id) Total_loan_applications,
sum(loan_amount) Total_funded_amount,
sum(total_payment) Total_received_amount
from financial_loan
group by datename(MONTH,issue_date),month(issue_date)
order by month(issue_date) asc

----state wise----------
select address_state,
count(id) Total_loan_applications,
sum(loan_amount) Total_funded_amount,
sum(total_payment) Total_amount_received
from financial_loan
group by address_state
select * from financial_loan

-----Term wise----------
select term,
count(id) Total_loan_applications,
sum(loan_amount) Total_funded_amount,
sum(total_payment) Total_amount_received
from financial_loan
group by term

----employee length--------
select emp_length,
count(id) Total_loan_applications,
sum(loan_amount) Total_funded_amount,
sum(total_payment) Total_amount_received
from financial_loan
group by emp_length

----purpose----------
select purpose,
count(id) Total_loan_applications,
sum(loan_amount) Total_funded_amount,
sum(total_payment) Total_amount_received
from financial_loan
group by purpose

----------Home ownership---
select home_ownership,
count(id) Total_loan_applications,
sum(loan_amount) Total_funded_amount,
sum(total_payment) Total_amount_received
from financial_loan
group by home_ownership
