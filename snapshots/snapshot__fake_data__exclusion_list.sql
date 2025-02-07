{% snapshot snapshot__fake_data__exclusion_list %}

{{ config(
    strategy="check",
    check_cols="all",
    unique_key="user_id"
) }}

select
    safe_cast(id as integer) as user_id
from
    {{ source('google_drive_marketing', 'users_exclusion_list') }}

{% endsnapshot %}