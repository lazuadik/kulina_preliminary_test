insert into ku_order_status(id, name) values
(1, 'pending'),
(2, 'success'),
(3, 'waiting_for_payment_service'),
(4, 'error'),
(5, 'void'),
(6, 'user_cancel'),
(7, 'payment_timeout'),
(8, 'refund_requested'),
(9, 'refund_approved'),
(10, 'refund_declined')
on conflict (id) do nothing;