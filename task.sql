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
    )

select *
from base
order by retning, startposisjon
