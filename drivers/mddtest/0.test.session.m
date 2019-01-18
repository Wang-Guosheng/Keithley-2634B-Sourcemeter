%% 0 Code for communicating with an instrument.
%
%   This is the machine generated representation of an instrument control
%   session. The instrument control session comprises all the steps you are
%   likely to take when communicating with your instrument. These steps are:
%   
%       1. Instrument Connection
%       2. Instrument Configuration and Control
%       3. Disconnect and Clean Up
% 
%   To run the instrument control session, type the name of the file,
%   0, at the MATLAB command prompt.
% 
%   The file, 0.M must be on your MATLAB PATH. For additional information 
%   on setting your MATLAB PATH, type 'help addpath' at the MATLAB command 
%   prompt.
% 
%   Example:
%       0;
% 
%   See also SERIAL, GPIB, TCPIP, UDP, VISA, BLUETOOTH, I2C, SPI.
% 
%   Creation time: 14-Jan-2019 14:41:30

%% Instrument Connection

% Find a VISA-TCPIP object.
obj1 = instrfind('Type', 'visa-tcpip', 'RsrcName', 'TCPIP0::169.254.0.1::inst0::INSTR', 'Tag', '');

% Create the VISA-TCPIP object if it does not exist
% otherwise use the object that was found.
if isempty(obj1)
    obj1 = visa('NI', 'TCPIP0::169.254.0.1::inst0::INSTR');
else
    fclose(obj1);
    obj1 = obj1(1);
end

% Connect to instrument object, obj1.
fopen(obj1);

%% Disconnect and Clean Up

% The following code has been automatically generated to ensure that any
% object manipulated in TMTOOL has been properly disposed when executed
% as part of a function or script.

% Disconnect all objects.
fclose(obj1);

% Clean up all objects.
delete(obj1);
clear obj1;

