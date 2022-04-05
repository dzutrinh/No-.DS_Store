uses	dos;

const   FOUND	: longint = 0;

function        unlink(name: string): boolean;
var	f	: FILE;
begin
	assign(f, name);
        {$I-}
        erase(f);
        {$I+}
        unlink := ioresult = 0;
end;

procedure	search(dir: string; remove: boolean);
var	sr	: SEARCHREC;
	name	: string;
begin
        findfirst(dir+'*.*', archive + directory, sr);
        while doserror = 0 do
        begin
                if (sr.attr and directory <> 0) and
                   (sr.name <> '.') and (sr.name <> '..') then
                	search(dir + sr.name + '\', remove);
        	if sr.name = 'DS_STO~1' then
                begin
                	name := dir + sr.name;
	                writeln('==> ', name);
                        if remove then unlink(name);
                        inc(FOUND);
                end;
                findnext(sr);
        end;
end;

var	drive	: char;
        path	: string;
	remove	: boolean;
	i	: byte;
begin
        if paramcount = 0 then
        begin
                writeln('usage: nods [-f] drive');
                exit;
        end;

	remove := false;
	for i := 1 to paramcount do
	begin
		if paramstr(i) = '-f' then
			remove := true
		else
			path := paramstr(i);
                if i = 2 then break;
	end;

        path[1] := upcase(path[1]);
        if path[1] in ['A'..'Z'] then
        	path := path[1] + ':\'
        else	path := '\';
        if remove then
		writeln('cleaning up all DS_STORE on ', path, '...')
        else	writeln('scanning for DS_STORE on ', path, '...');

	search(path, remove);
        if remove then
		writeln('removed ', FOUND, ' file(s)')
        else	writeln('found ', FOUND, ' file(s)');
end.
