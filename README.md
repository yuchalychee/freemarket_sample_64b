# README

# freemarket_sample_64b DB設計
## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nickname|string|null: false|
|e-mail|string|null: false|
|password|string|null: false|
|family_name|string|null: false|
|first_name|string|null: false|
|kana_fa_name|string|null: false|
|kana_fi_name|string|null: false|
|birth_year|integer|null: false|
|birth_month|integer|null: false|
|dirth_day|integer|null: false|
|phone_number|integer|null: false|
### Association
- has_many :items
- has_many :credits
- has_many :snses
- has_many :addresses
- has_many :images
- has_many :items, through: :comments

## addressesテーブル
|Column|Type|Options|
|------|----|-------|
|postal_code|integer|null: false|
|prefecture|string|null: false|
|city|string|null: false|
|address|string|null: false|
|building|string|null: false|
|phone_number|integer||
### Association
- belongs_to :user

## snsesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|token|string|null: false|
### Association
- belongs_to :user

## creditsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|card_number|integer|null: false|
|pin_namber|integer|null: false|
### Association
- belongs_to :user

## itemsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|price|string|null: false|
|user_id|references|null: false,foreign_key: true|
|buyer_id|references|null: false,foreign_key: true|
|category_id|references|null: false,foreign_key: true|
|brand_id|references|null: false,foreign_key: true|
|size|string||
|status|string|null: false|
|send_burden|string|null: false|
|send_plan|string|null: false|
|delivery_source|string|null: false|
|send_day|string|null: false|
|description|text|null: false|
### Association
- belongs_to :brand
- belongs_to :category
- has_many :images
- has_many :users
- has_many :users, through: :comments


## commentsテーブル
|Column|Type|Options|
|------|----|-------|
|user_id|references|null: false,foreign_key: true|
|item_id|references|null: false,foreign_key: true|
### Association
- belongs_to :item
- belongs_to :user

## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|image_name|string||
|post_id|references|null: false,foreign_key: true|
|user_id|references|null: false,foreign_key: true|
### Association
- belongs_to :item
- belongs_to :user

## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|category_name|string|null: false|
|item_id|references|null: false,foreign_key: true|
### Association
- has_many :items

## brandsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string||
|brand-group_id|references|null: false,foreign_key: true|
### Association
- has_many :items
- has_many :brandgroups
- has_many :brandgroups, through: :brands_brandgroups

## brandgroupsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string||
### Association
- has_many :brands
- has_many :brands, through: :brands_brandgroups