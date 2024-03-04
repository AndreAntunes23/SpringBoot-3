alter table medicos add ativo tinyint;
update medicos set ativo = 1;
-- update medicos ativo not null;