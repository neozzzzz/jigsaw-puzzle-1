alter table public.kids_jigsaw_users
  add column if not exists progress jsonb not null default '{"xp":0,"totalStars":0,"unlockedStage":1,"lastPlayedStage":1,"streak":0,"lastPlayedDate":"","completed":{}}'::jsonb;

alter table public.kids_jigsaw_users
  add column if not exists updated_at timestamptz not null default timezone('utc'::text, now());

update public.kids_jigsaw_users
set progress = coalesce(progress, '{}'::jsonb) || '{"xp":0,"totalStars":0,"unlockedStage":1,"lastPlayedStage":1,"streak":0,"lastPlayedDate":"","completed":{}}'::jsonb
where progress is null
   or jsonb_typeof(progress) <> 'object';

create unique index if not exists kids_jigsaw_users_app_slug_client_user_id_idx
  on public.kids_jigsaw_users (app_slug, client_user_id);

create or replace function public.touch_kids_jigsaw_users_updated_at()
returns trigger
language plpgsql
as $$
begin
  new.updated_at = timezone('utc'::text, now());
  return new;
end;
$$;

drop trigger if exists kids_jigsaw_users_set_updated_at on public.kids_jigsaw_users;
create trigger kids_jigsaw_users_set_updated_at
before update on public.kids_jigsaw_users
for each row execute function public.touch_kids_jigsaw_users_updated_at();

alter table public.kids_jigsaw_users enable row level security;

do $$
begin
  if not exists (
    select 1 from pg_policies
    where schemaname = 'public' and tablename = 'kids_jigsaw_users' and policyname = 'kids_jigsaw_users_update_anon'
  ) then
    create policy kids_jigsaw_users_update_anon
      on public.kids_jigsaw_users
      for update
      to anon, authenticated
      using (true)
      with check (true);
  end if;

  if not exists (
    select 1 from pg_policies
    where schemaname = 'public' and tablename = 'kids_jigsaw_users' and policyname = 'kids_jigsaw_users_delete_anon'
  ) then
    create policy kids_jigsaw_users_delete_anon
      on public.kids_jigsaw_users
      for delete
      to anon, authenticated
      using (true);
  end if;
end
$$;