select 
    from_user,
    count(distinct id) as total_emails,
    row_number() over(order by count(distinct id) desc, from_user asc) as rnk
from google_gmail_emails
group by 1;
