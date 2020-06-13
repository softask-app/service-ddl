/*--------------------------------------------------------*\
| Task Definitions                                         |
|                                                          |
| Details about individual tasks.                          |
|                                                          |
| The task table uses a soft delete.  Tasks that are       |
| marked as deleted will be cleaned up after a set period  |
| of time.                                                 |
\*--------------------------------------------------------*/
CREATE TABLE IF NOT EXISTS tasks.task
(
  -- Sequential task ID
  task_id          BIGSERIAL PRIMARY KEY,

  -- ID of the user that created the task.
  creator_id       BIGINT      NOT NULL
    REFERENCES users."user" (user_id) ON DELETE RESTRICT,

  -- ID of the name for this task in the common.task_name
  -- table.
  task_name_id     BIGINT      NOT NULL
    REFERENCES common.task_name (task_name_id) ON DELETE RESTRICT,

  -- Optional text describing the task.
  -- Capped at 1024 characters.
  task_description VARCHAR(1024),

  -- Timestamp for the creation of this task.
  created          TIMESTAMPTZ NOT NULL DEFAULT now(),

  -- Timestamp for the last modification of this task.
  updated          TIMESTAMPTZ NOT NULL DEFAULT now(),

  -- Optional timestamp for the deletion of this task.
  -- The presence of this value signifies that a task has
  -- been deleted.
  deleted          TIMESTAMPTZ
);

/*--------------------------------------------------------*\
| Task Step Definitions                                    |
|                                                          |
| Details about the individual steps under a task.         |
|                                                          |
| The step table uses a soft delete.  Steps that are       |
| marked as deleted will be cleaned up after a set period  |
| of time.                                                 |
\*--------------------------------------------------------*/
CREATE TABLE IF NOT EXISTS tasks.step
(
  -- Sequential ID of the step.
  step_id     BIGSERIAL PRIMARY KEY,

  -- ID of the task a step belongs to.
  task_id     BIGINT        NOT NULL
    REFERENCES tasks.task (task_id) ON DELETE CASCADE,

  -- Description of the individual step.
  -- Must be 3 >= length >= 1024
  description VARCHAR(1024) NOT NULL
    CONSTRAINT step_desc_min_len CHECK (length(description) >= 3),

  -- Ordering indicator for this step in the task.
  position    INT2          NOT NULL,

  -- ID of the user that created this step.
  creator_id  BIGINT        NOT NULL
    REFERENCES users.user (user_id) ON DELETE RESTRICT,

  -- Timestamp for the creation of this step.
  created     TIMESTAMPTZ   NOT NULL DEFAULT now(),

  -- Timestamp for the last modification of this step.
  updated     TIMESTAMPTZ   NOT NULL DEFAULT now(),

  -- Optional timestamp for the deletion of this step.
  --
  -- The absence/presence of this value signifies whether a
  -- step has been deleted.
  deleted     TIMESTAMPTZ
);
