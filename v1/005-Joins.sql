CREATE TABLE IF NOT EXISTS joins.user_to_task
(
  join_id BIGSERIAL PRIMARY KEY,
  user_id BIGINT NOT NULL
    REFERENCES users."user" (user_id) ON DELETE CASCADE,
  task_id BIGINT NOT NULL
    REFERENCES tasks.task (task_id) ON DELETE CASCADE
);

ALTER TABLE joins.user_to_task
  ADD CONSTRAINT jutt_unique
    UNIQUE (user_id, task_id);


CREATE TABLE IF NOT EXISTS joins.task_to_tag
(
  task_id BIGINT NOT NULL
    REFERENCES tasks.task (task_id) ON DELETE CASCADE,

  tag_id  BIGINT NOT NULL
    REFERENCES common.tag (tag_id) ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS joins.user_to_user
(
  provider_user_id BIGINT NOT NULL
    REFERENCES users."user" (user_id) ON DELETE CASCADE,
  supported_user_id BIGINT NOT NULL
    REFERENCES users."user" (user_id) ON DELETE CASCADE
);