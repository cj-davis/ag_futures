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
    ws = unique(sations);
    len = length(temps);
    % Initialize average temperatures vector
    avg_temp = zeros((2020-1973 + 1) * 365, length(ws));
    rows = 1;
    cols = 1;
    % This will track the number of weather stations recording data
    ws_per_day = zeros((2020-1973 + 1)*365, 1);

    for i=1:len
        % Date is in YYYYMMDD format
        date_str = int2str(dates(i));
        % This gives us the data as a string in MMDD format
        mmdd = date_str(5:);
        % This creates an index that tracks what year we're collecting data
        % for
        yyyy = str2num(date_str(1:4));
        if ~strcmp(mmdd, '0229') % We will exclude leap year data for simplicity
            if i==1 && min_date < dates(i)
                % Then the latest first recorded date happens after 19730101
                min_date = dates(i);
            
            elseif stations(i-1) ~= stations(i) % Then we are looking at data for a new weather station
                % Update avg_temp indices
                cols = cols + 1;
                if dates(i) ~= 19730101 % then our rows index needs to be greater than 1
                    rows = timeElapsed(19730101, dates(i));
                else
                    rows = 1;
                end
                if(min_date < dates(i)) % Then the latest first recorded date happens after min_date
                    min_date = dates(i);
                end

                % Need to fill avg_temp rows with zeros where we don't have
                % observations
            end
        end
        
        % Record average temperature data at station cols and time rows
        avg_temp(rows, cols) = temps(i);
        rows = rows+1;
        
    end
    
    ret_temp = zeros((2020-1973 + 1) * 365,1);

end