json.extract! item, :id, :item_group_id, :name, :quantity, :purchase_price_cents, :created_at, :updated_at
json.url item_url(item, format: :json)
