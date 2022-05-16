{{
    config(
        materialized='incremental',
        unique_key='INSERT_DT'
    )
}}

SELECT EMP_ID, EMP_NAME,INSERT_DT FROM EMP
{% if is_incremental() %}
  -- this filter will only be applied on an incremental run
  where INSERT_DT > (SELECT MAX(INSERT_DT) from PC_DBT_DB.PUBLIC.EMP_tgt )

{% endif %}

