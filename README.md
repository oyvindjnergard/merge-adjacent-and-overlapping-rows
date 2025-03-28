# merge-rows

We have the following table with mappings between a segment and parts of a road sequence.
We want to merge rows in this table that represent contiguous or overlapping parts of the same road sequence and shares the same direction (i.e. row 2-4 and 5-6 should be merged)

| segment_id         | road_sequence_id   | start_position     | end_position       | direction          |
| ------------------ | ------------------ | ------------------ | ------------------ | ------------------ |
| a                  | 1                  | 0.3                | 0.4                | against            |
| a                  | 1                  | 0.0                | 0.1                | with               |
| a                  | 1                  | 0.1                | 0.15               | with               |
| a                  | 1                  | 0.15               | 0.2                | with               |
| a                  | 1                  | 0.25               | 0.5                | with               |
| a                  | 1                  | 0.45               | 0.7                | with               |
| a                  | 1                  | 0.8                | 1.0                | with               |
| b                  | 2                  | 0.0                | 1.0                | with               |


1. Go to https://sqlfiddle.com/postgresql/online-compiler
2. Copy the code from task.sql into the editor
3. Iterate until you have the following solution:

| segment_id         | road_sequence_id   | start_position     | end_position       | direction          |
| ------------------ | ------------------ | ------------------ | ------------------ | ------------------ |
| a                  | 1                  | 0.3                | 0.4                | against            |
| a                  | 1                  | 0.0                | 0.2                | with               |
| a                  | 1                  | 0.25               | 0.7                | with               |
| a                  | 1                  | 0.8                | 1.0                | with               |
| b                  | 2                  | 0.0                | 1.0                | with               |
