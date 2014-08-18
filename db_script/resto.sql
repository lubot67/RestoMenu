create table resto_order(
  order_id int primary key,
  meal_name text,
  meal_price text
);

create or replace 
     function addOrder(p_order_id int, p_meal_name text, p_meal_price text)
     returns text as


$$
  declare
    v_order_id int;
  begin
    select into v_order_id order_id from resto_order
      where v_order_id = p_order_id;

    if v_order_id isnull then
      insert into resto_order(order_id, meal_name, meal_price) values (p_order_id, p_meal_name, p_meal_price);


    else
      update resto_order
        set meal_name = p_meal_name 
        where order_id = p_order_id;

      update resto_order
        set meal_price = p_meal_price
        where order_id = p_order_id;
    end if;

    return 'OK';
  end
$$
  language 'plpgsql';

--view
create or replace function 
	get_resto_order_perid(in int, out int, out text, out text)
returns setof record as
$$
	select order_id, meal_name, meal_price from resto_order
	where order_id = $1;
$$
 language 'sql';
