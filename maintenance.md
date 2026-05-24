# Maintenance

## Atuin

Add or refresh fish completions:

```sh
atuin gen-completions --shell fish --out-dir ~/.config/fish/completions
```

Work with atuin history:

```sql
-- stats by command
select count(id) as total, max(command) from history group by command order by total desc
-- stats by command, cwd
select count(id) as total, max(command), max(cwd) from history group by command, cwd order by total desc
-- stats by command, cwd, hostname
select count(id) as total, max(command), max(cwd), max(hostname) from history group by command, cwd, hostname order by command desc

-- remove duplicates
delete from history where rowid not in (select max(rowid) from history group by command, cwd, session, hostname)
-- remove duplicates (most aggressive)
delete from history where rowid not in (select max(rowid) from history group by command)
```
