function Af_EditTurbSim(lines, edits, newname, defname, tempdir, input_mode)
% D. Zalkind 6/2/15 dan.zalkind@gmail.com, modified from FAST edit function
% by J. Aho- 3/10/11 jacob.aho@colorado.edu

% This function will take in a vector of .inp file line numbers or a 
% cell array containing strings of TurbSim parameters 
% (input_mode=1 or 2 respectively) that are to be edited to be edited.
% The defname.inp file is a default fast file which is copied line by line 
% into newname.inp, replacing lines associated with 'lines' input by the
% associated 'edit' followed by the line of the 'description' reference
% file (not an input, set name below if you want to change this file)

% Description of inputs
% Lines:
% If input_mode==1
%       lines- a vector of line numbers to be edited in X.inp file
% If input_mode==2
%       lines- a cell array w/ each cell as the FAST setting/variable name
% edits- a cell array of strings or numbers- one cell for each element of 'lines' 
% newname- the new fast file will be called [newname,'.inp']
% defname- the default fast file which should be called [defname,'.inp']
%    for any line number not an element of (lines), the default file
%    parameters will be copied over.

% Outputs:  Nothing, It makes a new .inp file in the current folder



if (input_mode~=1 && input_mode~=2 )
    error('Error, input_mode must be either 1 or 2')
end

fid=fopen([defname,'.inp']);
if fid==-1
    error(['Error: ', defname, '.inp not found.  Note: you do not need to end string with .inp']);
end

fidW=fopen([newname,'.inp'],'w+');
if fidW==-1
    error(['Error: ', newname, '.inp not found.  Note: you do not need to end string with .inp']);
end

fidD=fopen(fullfile(tempdir,'TSinputfile_desc.inp'));
if fidD==-1
    error(['Error: Blank settings TurbSim input file not found.']);
end

if input_mode==2
    fidI=fopen(fullfile(tempdir,'TSinputfile_inlist.inp'));
    if fidI==-1
        error(['Error: Input description file not found.']);
    end
end


if fid>0
    linenum=0;
    editID=1;
    numEdits=length(lines);
    for n=1:numEdits
        if isnumeric(edits{n})
            edits{n}=num2str(edits{n});
        end
    end  
    tline = fgets(fid);
    tlineD = fgets(fidD); %Could optimize this probably
    if input_mode==2
        tlineI=fgets(fidI);
    end
    
    while ischar(tline)
        linenum=linenum+1;
        Fchange=0;
        editID=[];
        if input_mode==1
            editID  = find(lines==linenum, 1, 'last');
            if ~isempty(editID)
                Fchange=1;
                fprintf(fidW,'%s',[edits{editID}, tlineD]);
            end
        elseif input_mode==2
            editID=0;
            for n=1:numEdits
                match=strfind(tlineI,lines{n});
                if match
                    Fchange=1;
                    editID=n;
                    fprintf(fidW,'%s',[edits{editID}, tlineD]);
                end
            end
        end
        if Fchange==0
            fprintf(fidW,'%s',tline);
        end
        if input_mode==2
        tlineI= fgets(fidI);
        end
        tlineD = fgets(fidD);
        tline = fgets(fid);
    end
end

fclose(fid);
fclose(fidW);
fclose(fidD);
if input_mode==2
    fclose(fidI);
end
disp(['Status: ', newname,'.inp created with ',num2str(numEdits),' changed input(s).']);
