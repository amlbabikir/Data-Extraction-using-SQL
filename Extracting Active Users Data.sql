with sample_table as (
select 
JSON_VALUE(invoices.data , "$.amount") as TopedupAmount ,
JSON_QUERY (users.data,'$.createdAt') as createdAt,
JSON_QUERY (users.data,'$.dateOfBirth') as dateOfBirth,
JSON_VALUE(users.data , "$.displayName") as displayName ,
JSON_VALUE(users.data , "$.email") as email ,
JSON_VALUE(users.data , "$.followerCount") as followerCount ,
JSON_VALUE(users.data , "$.followingCount") as followingCount ,
JSON_QUERY (users.data,'$.lastSeen') as lastSeen,
JSON_VALUE(users.data , "$.postCount") as postCount ,
JSON_VALUE(users.data , "$.username") as username ,
JSON_VALUE(users.data , "$.gender") as gender,
JSON_VALUE(users.data , "$.totalSpent") as totalSpent,
JSON_VALUE(users.data , "$.wallet.dueBalance") as dueBalance ,
JSON_VALUE(users.data , "$.wallet.totalAmount") as wallettotalAmount 

 FROM `website.all.users_raw_latest` as users
 INNER JOIN `website.all.invoices_raw_latest` as invoices  
 ON JSON_VALUE(invoices.data, "$.userId") = users.document_id
 where JSON_VALUE(invoices.data, "$.status") = 'paid'
  )  

 
select 
createdAt,
lastSeen,
displayName,
TopedupAmount ,
postCount,
totalSpent,
email,
followerCount,
followingCount,
gender,
username,
dueBalance,
wallettotalAmount
  from 
(
select  cast(PARSE_DATETIME("%s", JSON_EXTRACT_SCALAR(createdAt, "$['_seconds']"))as TIMESTAMP )  as createdAt ,
cast(PARSE_DATETIME("%s", JSON_EXTRACT_SCALAR(dateOfBirth, "$['_seconds']"))as TIMESTAMP )  as dateOfBirth ,
cast(PARSE_DATETIME("%s", JSON_EXTRACT_SCALAR(lastSeen, "$['_seconds']"))as TIMESTAMP )  as lastSeen ,
TopedupAmount ,
displayName,
totalSpent,
email,
followerCount,
followingCount,
gender,
postCount,
username,
dueBalance,
wallettotalAmount
from sample_table  
) 

