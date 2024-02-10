select * from users;
select *from users order by created_at desc limit 5;      -- #Q1- 5 oldest users om instagram



select * from users where id not in (select user_id from photos) ; --#Q2- Identify users who have never posted a single photo on Instagram.





select count(user_id), photo_id from likes  group by photo_id  order by count(user_id) desc limit 3 ;  --#Q3 a) most liked photo (1 method)
select * from photos where id = 145;                                                                 --#b) user who posted most like photo
select * from users where id= 52;                                                                  --#C)  name of user

select photos.id, photos.user_id, Count(likes.user_id)         
from photos inner join likes on photos.id = likes.photo_id group by photos.id order by count(likes.user_id) desc limit 3;  -- 2 tabel join (method 2)


select photos.id photo_id, photos.user_id, users.username,Count(likes.user_id) likes
from photos inner join likes inner join users on photos.id = likes.photo_id
and users.id=photos.user_id
group by photos.id order by count(likes.user_id) desc limit 3;    --# - 3 table join (method 3)





select * from photo_tags;
select tag_id, count(photo_id), tag_name from photo_tags  inner join tags 
on photo_tags.tag_id= tags.id group by tag_id order by count(photo_id) desc limit 5 ;    --#Q4 - Top 5 popular hastags


select tag_id, count(photo_id) from photo_tags group by tag_id order by count(photo_id) desc limit 5 ;   --#Q4 - Top 5 popular hastags (easy method)
select * from tags where id in(21,20,17, 13, 18);



SELECT count(*), DAYOFWEEK(created_at) from users group by 2  order by 2;   --Q5. weekly photo count milega /- yaha "group by 2" ka mtlb "DAYOFWEEK(created_at)" isse hai, kuki yah dusre no. pe hai 


SELECT count(*), DAYOFWEEK(created_at) ,                  --yah Q5. ka hissa hai. ise "case statment" ki madad se day ka column banaya gaya hai (sun,mon,tue,wed,thur,fri,sat)
case 
when DAYOFWEEK(created_at) = 1 then  "Sunday"
when DAYOFWEEK(created_at) = 2 then  "Monday"
when DAYOFWEEK(created_at) = 3 then  "Tuesday"
when DAYOFWEEK(created_at) = 4 then  "Wednesday"
when DAYOFWEEK(created_at) = 5 then  "Thursday"
when DAYOFWEEK(created_at) = 6 then  "Friday"
when DAYOFWEEK(created_at) = 7 then  "Saterday"
end as day
from users group by 2, day order by 2;      --yaha group by 2, order by 2 = [DAYOFWEEK(created_at)] hai, "day" column 2 ka alias hai



--Part B) ka 1st Question


select round(avg(no_post),2) from (select user_id, count(id) no_post from photos group by user_id order by user_id) a;          --Q(b)1. isme 1(photo table) hi use kiya hai aur isme un users ka avg aya hai jisne post kiya hai, 0 post vale ka data isme nhi hai


select count(* )from photos ;      --Q(B) 1. ko simpl tarike se 
select count(*) from users;
select round(257/100,2);

select round(p_cnt/u_cnt,2) from (select count(*) p_cnt from photos) p, (select count(*) u_cnt from users) u;            --Q(b)1. row no. 62,63,64 me jo diya hai usi method ko bus ek line me likha hai, sahi answer 59 row ki query ka hai



select count(*) from photos;
select count(*) from likes;
select count(*) from (select user_id, count(photo_id) count_like from likes group by user_id having count_like =257) a;    --Q(B) 2. isme bot nikalne hai, ye vo log hai jinhone sabhi photo per like kiya hai, (step 1)


select * from users where id in (select user_id from likes group by user_id having count(photo_id) =257);   --isme un sabhi logo ki detail hai jinhone sabhi logo ki photo per like kiya hai (step 2S)
