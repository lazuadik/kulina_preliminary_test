with new_user as (
	select
		id,
		name,
		created_at,
		(created_at + interval '7 days') as cutoff_date
	from
		ku_user
)
select 
	nu.id as user_id,
	nu.name as username,
	o.id as order_id,
	od.delivery_date, 
	p.name as product_name,
	p.price as product_price,
	od.quantity
from
	new_user nu
join 
	ku_order o on nu.id = o.user_id 
join 
	ku_order_detail od on o.id = od.order_id 
join
	ku_product p on od.product_id = p.id
join 
	ku_order_detail_status ods on od.status = ods.id
where 
	ods.name ilike '%success%' and od.delivery_date between nu.created_at::date and nu.cutoff_date::date;

	