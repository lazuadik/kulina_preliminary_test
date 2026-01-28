select 
	u.id as user_id,
	u.name as user_name,
	u.email as user_email,
	u.phone as user_phone_number,
	od.delivery_date,
	p.name as product_name,
	string_agg(c.name, ', ') as product_category,
	od.quantity as quantity,
	ul.address,
	sum(od.quantity) over(
		partition by u.id
		order by od.delivery_date asc, u.id asc
	) as total
from
	ku_order_detail od
join ku_user_location ul on od.user_location_id = ul.id
join ku_user u on ul.user_id = u.id
join ku_product p on od.product_id = p.id
left join ku_product_category pc on p.id = pc.product_id
left join ku_category c on pc.category_id = c.id 
join ku_order_detail_status ods on od.status = ods.id
where 
	ods.name ilike '%success%' and od.delivery_date between '2025-09-01' and '2025-09-30'
group by
	u.id, u.name, u.email, u.phone, od.delivery_date, p.name, od.quantity, ul.address, od.id
order by
	od.delivery_date asc,
	u.id asc;

	
	
	
	