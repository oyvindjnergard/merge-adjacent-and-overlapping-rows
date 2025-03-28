with
    base as (
        select
            'a' as segment_id,
            1 as veglenkesekvens_id,
            0.0 as startposisjon,
            0.1 as sluttposisjon,
            'with' as retning
        union
        select
            'a' as segment_id,
            1 as veglenkesekvens_id,
            0.1 as startposisjon,
            0.15 as sluttposisjon,
            'with' as retning
        union
        select
            'a' as segment_id,
            1 as veglenkesekvens_id,
            0.15 as startposisjon,
            0.2 as sluttposisjon,
            'with' as retning
        union
        select
            'a' as segment_id,
            1 as veglenkesekvens_id,
            0.25 as startposisjon,
            0.5 as sluttposisjon,
            'with' as retning
        union
        select
            'a' as segment_id,
            1 as veglenkesekvens_id,
            0.3 as startposisjon,
            0.4 as sluttposisjon,
            'against' as retning
        union
        select
            'a' as segment_id,
            1 as veglenkesekvens_id,
            0.45 as startposisjon,
            0.7 as sluttposisjon,
            'with' as retning
        union
        select
            'a' as segment_id,
            1 as veglenkesekvens_id,
            0.8 as startposisjon,
            1.00 as sluttposisjon,
            'with' as retning
    ),

    generate_merge_key as (
        select
            *,
            case
                when
                    startposisjon > lag(sluttposisjon) over (
                        partition by segment_id, veglenkesekvens_id, retning
                        order by startposisjon
                    )
                    or lag(sluttposisjon) over (
                        partition by segment_id, veglenkesekvens_id, retning
                        order by startposisjon
                    )
                    is null
                then 1
                else 0
            end as merge_key
        from base
    ),

    generate_merge_group as (
        select
            *,
            sum(merge_key) over (
                partition by segment_id, veglenkesekvens_id, retning
                order by startposisjon
            ) as merge_group
        from generate_merge_key
    ),

    merge_rows as (
        select
            segment_id,
            veglenkesekvens_id,
            min(startposisjon) as startposisjon,
            max(sluttposisjon) as sluttposisjon,
            retning
        from generate_merge_group
        group by segment_id, veglenkesekvens_id, retning, merge_group
    )

select *
from merge_rows
order by retning, startposisjon
