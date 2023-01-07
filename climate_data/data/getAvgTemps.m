% Still need to work on ws_per_year variable, filling the avg_temp with zeros
% where we don't have data, and then aggregating the data for the ret_temp
% vector
% Noticed a problem with the data file for Colorado. I need to investigate
% to see if this problem occurs in other data files.

function [ret_temp, min_date, ws] = getAvgTemps(state)
    % Open the state's excel file (note that this requires the data file to
    % be in the working directory)
    data = readtable(strcat(state, '.xlsx'));
    % Create dates array with date data
    dates = table2array(data(:, "YEARMODA"));
    % Create stations array with station IDs
    stations = table2array(data(:,"STN"));
    % Create temps array with daily temperatures
    temps = table2array(data(:,"TEMP"));
    % Starting date yyyymmdd
    min_date = 19730101;
    max_date = 20201231;
    ws = unique(stations);
    len = length(temps);
    % Initialize average temperatures matrix
    tot_time = timeElapsed(min_date, max_date);
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
            if (i==1) && (dates(i) ~= min_date) 
                % then our rows index needs to be greater than 1
                rows = timeElapsed(min_date, dates(i));
            end
            
            if i>1 && (dates(i-1) > dates(i) || stations(i-1) ~= stations(i))
            % Then we are looking at data for a new weather station
                % Update avg_temp indices
                cols = cols + 1;
                if dates(i) ~= min_date % then our rows index needs to be greater than 1
                    rows = timeElapsed(min_date, dates(i));
                else
                    rows = 1;
                end
            end
        end
        
        if rows >= 17520
            fprintf('error at WS: %d\n', stations(i));
            fprintf('date occurred: %d\n', dates(i));
        end
        
        % Record average temperature data at station cols and time rows
        ws_per_day(rows) = ws_per_day(rows) + 1;
        avg_temp(rows, cols) = temps(i);
        rows = rows+1;
        
    end
    
    ret_temp = zeros(tot_time,1);
    for i=1:tot_time
        % Compute daily sample means
        ret_temp(i) = sum(avg_temp(i, :)) / ws_per_day(i);
    end

end