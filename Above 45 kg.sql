-----|| 1st Part
-----|| Name: Above 45 kg Sales Report Last 10 Days


Select  cast(dbo.toBdt(s.DeliveryWindowStart)as date) [date],
	    s.OrderId [OrderQty],
		Sum(pv.Weight) [Weight]
		

from ProductVariant pv
join ThingRequest tr on tr.ProductVariantId=pv.id
join thing t on t.id=tr.AssignedThingId
join Shipment s on s.id=tr.ShipmentId

where s.ReconciledOn is not null
and s.DeliveryWindowStart >= '2022-07-31 07:00 +06:00'
and s.DeliveryWindowEnd < '2022-08-11 11:59 +06:00'
and s.ShipmentStatus in (8)
and IsReturned=0
and IsCancelled=0
and HasFailedBeforeDispatch=0
and IsMissingAfterDispatch=0
and pv.DistributionNetworkId = 1
and s.WarehouseId = 41

group by cast(dbo.toBdt(s.DeliveryWindowStart)as date),
		 s.OrderId

order by 1 asc