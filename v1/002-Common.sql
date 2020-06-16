/*--------------------------------------------------------*\
| Task Names                                               |
|                                                          |
| The number of tasks should be significantly greater than |
| the number of unique task names.                         |
\*--------------------------------------------------------*/
CREATE TABLE IF NOT EXISTS common.task_name
(
  -- Sequential, database assigned index to the record.
  task_name_id  BIGSERIAL PRIMARY KEY,

  -- Task name value.
  --
  -- Must be non-null and between [3..128] characters.
  name          VARCHAR(128) NOT NULL UNIQUE
    CONSTRAINT task_name_min_len CHECK (length(name) >= 3),

  -- Whether or not this task name should appear in type ahead searches.
  --
  -- This value should be set to false for any value that is determined to
  -- likely be (by content) triggering or offensive.
  can_recommend BOOL         NOT NULL DEFAULT FALSE
);

INSERT INTO
  common.task_name (name, can_recommend)
  VALUES
    ('Bathe', TRUE)
  , ('Dishes', TRUE)
  , ('Groceries', TRUE)
  , ('Hoover', TRUE)
  , ('Laundry', TRUE)
  , ('Shopping', TRUE)
  , ('Shower', TRUE)
  , ('Trash', TRUE)
  , ('Vacuum', TRUE)
;

CREATE TABLE IF NOT EXISTS common.tag
(
  -- Sequential, database assigned index to the record.
  tag_id        BIGSERIAL PRIMARY KEY,

  -- Tag name value.
  --
  -- Must be unique and [3..32] characters.
  name          VARCHAR(32) NOT NULL UNIQUE
    CONSTRAINT tag_name_min_len CHECK (length(name) >= 3),

  -- Optional parent tag (for tag hierarchies)
  parent        BIGINT REFERENCES common.tag (tag_id) ON DELETE CASCADE,

  -- Whether or not this tag should appear in type ahead searches.
  --
  -- This value should be set to false for any value that is determined to
  -- likely be (by content) triggering or offensive.
  can_recommend BOOL        NOT NULL DEFAULT FALSE
);
