/*--------------------------------------------------------*\
| Task Names                                               |
|                                                          |
| The number of tasks should be significantly greater than |
| the number of unique task names.                         |
\*--------------------------------------------------------*/
CREATE TABLE IF NOT EXISTS common.task_name
(
  task_name_id BIGSERIAL PRIMARY KEY,
  value        VARCHAR(128) NOT NULL UNIQUE
    CONSTRAINT task_name_min_len CHECK (length(value) >= 3)
);

INSERT INTO
  common.task_name (value)
VALUES
  ('Bathe'),
  ('Dishes'),
  ('Groceries'),
  ('Hoover'),
  ('Laundry'),
  ('Shopping'),
  ('Shower'),
  ('Trash'),
  ('Vacuum')
;
