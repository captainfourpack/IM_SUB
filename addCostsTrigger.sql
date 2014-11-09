DROP TRIGGER IF EXISTS addDataCosts;


DELIMITER //
create trigger addDataCosts
	before insert on delivery_by_day
		for each row
			begin
				if (new.third_party_id is null)  then	 -- if the type is null (no metric) then zero data cost
					insert into data_cost_by_day (date, campaign_id, cost) values (now(), new.campaign_id, 0);
                
				elseif  ( (select metric_type from third_parties where third_party_id = new.third_party_id) = "CPC") -- if the type is CPC
				then
					insert into data_cost_by_day (date, campaign_id, cost)
					values (now(), new.campaign_id, new.clicks * (
															(select rate_paid_to_third_party from third_parties where third_party_id = new.third_party_id)  
                                                            ));
				else		-- otherwise it is percent revenue
					insert into data_cost_by_day (date, campaign_id, cost) 
                    values (now(), new.campaign_id, new.delivered_impressions * (
															(select rate_paid_to_third_party from third_parties where third_party_id = new.third_party_id)  
                                                            ));
                end if;
			end
				
            
     //  