% Still need to work on ws_per_year variable, filling the avg_temp with zeros
% where we don't have data, and then aggregating the data for the ret_temp
% vector

function [ret_temp, min_date, ws] = getAvgTemps(state)
    % Open the state's excel file (note that this requires the data file to
    % be in the working directory)
    data = readtable(strcat(state, '.xlsx'));
    dates = table2array(data(:, "YEARMODA"));
    stations = table2array(data(:,"WBAN"));
    temps = table2array(data(:,"TEMP"));
    min_date = 19730101;
    ws = unique(stations);
    len = length(temps);
    % Initialize average temperatures vector
    tot_time = timeElapsed(19730101, 20201231);
    avg_temp = zeros(tot_time, length(ws));
    rows = 1;
    cols = 1;
    % This will track the number of weather stations recording data each
    % day
    ws_per_day = zeros(tot_time, 1);

    for i=1:len
        % Date is in YYYYMMDD format
        date_str = int2str(dates(i));
        % This gives us the data as a string in MMDD format
        date_str = date_str(5:8);
        
        if ~strcmp(date_str, '0229') % We will exclude leap year data for simplicity
            if i==1 && min_date < dates(i)
                % Then the latest first recorded date happens after 19730101
                min_date = dates(i);
            elseif i==1
                if dates(i) ~= 19730101 % then our rows index needs to be greater than 1
                    rows = timeElapsed(19730101, dates(i));
                end
            
            elseif stations(i-1) ~= stations(i) % Then we are looking at data for a new weather station
                % Update avg_temp indices
                fprintf('I activated!\n');
                cols = cols + 1;
                if dates(i) ~= 19730101 % then our rows index needs to be greater than 1
                    rows = timeElapsed(19730101, dates(i));
                else
                    rows = 1;
                end

                if min_date < dates(i) % Then the latest first recorded date happens after min_date
                    min_date = dates(i);
                end
            end
        end
        
        % Record average temperature data at station cols and time rows
        fprintf('%d\n', rows);
        ws_per_day(rows) = ws_per_day(rows) + 1;
        avg_temp(rows, cols) = temps(i);
        rows = rows+1;
        
    end
    
    ret_temp = zeros((2020-1973 + 1) * 365,1);
    num_days = (2020-1973 + 1) * 365;
    for i=1:num_days
        % Compute daily sample means
        ret_temp(i) = sum(avg_temp(i, :)) / ws_per_day(i);
    end

end