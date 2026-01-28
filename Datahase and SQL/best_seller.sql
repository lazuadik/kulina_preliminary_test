select
	p.name as product_name,
	sum(p.price * od.quantity) as gmv,
	sum(od.quantity) as total_quantity,
	count (distinct u.id) as unique_user_count
from 
	ku_product p
join 
	ku_order_detail od on p.id = od.product_id
join
	ku_user_location ul on od.user_location_id = ul.id
join
	ku_user u on ul.user_id = u.id
join 
	ku_order_detail_status ods on od.status = ods.id
where 
 	ods.name ilike '%success%' and od.delivery_date between '2025-07-01' and '2025-09-30'
group by 
	p.name
order by 
 	gmv desc,
 	total_quantity desc;