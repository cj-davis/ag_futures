% Computes the number of days between init and term including day of init 
% and term
% @Params: should be YYYYMMDD formatted ints
% @Return: the number of days between init and term including the day of
% init and term
function [time] = timeElapsed(init, term)
    yyyy_init = floor(init/10000);
    yyyy_term = floor(term/10000);
    time = 365 * (yyyy_term - yyyy_init);
    date_str_init = int2str(init);
    date_str_term = int2str(term);
    mm_init = str2num(date_str_init(5:6));
    mm_term = str2num(date_str_term(5:6));
    dd_init = str2num(date_str_init(7:8));
    dd_term = str2num(date_str_term(7:8));

    if mm_init > mm_term
        % If this is the case, then yyyy_init < yyyy_term
        time = time - 365;
        
        % Add the days from init to the end of the month
        if mm_init == 1 || mm_init == 3 || mm_init == 5 || mm_init == 7 || mm_init == 8 || mm_init == 10 || mm_init == 12
            % Then there are 31 days in the month
            time = time + 31 - dd_init + 1;
        elseif mm_init == 2
            % Then there are 28 days in the month
            time = time + 28 - dd_init + 1;
        else
            % Then there are 30 days in the month
            time = time + 30 - dd_init + 1;
        end

        % Add the remaining days
        if mm_init ~= 12
            % Add all the days in the reaminder of the year
            for i=(mm_init+1):12
                if i == 1 || i == 3 || i == 5 || i == 7 || i == 8 || i == 10 || i == 12
                    time = time + 31;
                elseif i == 2
                    time = time + 28;
                else
                    time = time + 30;
                end
            end
        end
        
        if mm_term ~= 1
            for i=1:mm_term-1
                if i == 1 || i == 3 || i == 5 || i == 7 || i == 8 || i == 10 || i == 12
                    time = time + 31;
                elseif i == 2
                    time = time + 28;
                else
                    time = time + 30;
                end
            end
        end

        time = time + dd_term;
    elseif mm_init < mm_term
        % Add the days from init to the end of the month
        if mm_init == 1 || mm_init == 3 || mm_init == 5 || mm_init == 7 || mm_init == 8 || mm_init == 10 || mm_init == 12
            % Then there are 31 days in the month
            time = time + 31 - dd_init + 1;
        elseif mm_init == 2
            % Then there are 28 days in the month
            time = time + 28 - dd_init + 1;
        else
            % Then there are 30 days in the month
            time = time + 30 - dd_init + 1;
        end

        for i=mm_init+1:mm_term-1
                if i == 1 || i == 3 || i == 5 || i == 7 || i == 8 || i == 10 || i == 12
                    time = time + 31;
                elseif i == 2
                    time = time + 28;
                else
                    time = time + 30;
                end
        end

        time = time + dd_term;

    else % mm_init == mm_term & 
        time = time + dd_term - dd_init + 1;
    end


end