function [c, r, t, cpulse, acq_codes, verbose] = tapas_physio_read_physlogfiles(log_files, cardiac_modality, ...
    verbose)
% reads out physiological time series and timing vector depending on the
% MR scanner vendor and the modality of peripheral cardiac monitoring (ECG
% or pulse oximetry)
%
%   [cpulse, rpulse, t, c] = tapas_physio_read_physlogfiles(log_files, vendor, cardiac_modality)
%
% IN
%   log_files   is a structure containing the following filenames (with full
%           path)
%       .vendor             'Philips', 'GE' or 'Siemens', depending on your
%                           MR Scanner system
%       .log_cardiac        contains ECG or pulse oximeter time course
%                           for Philips: 'SCANPHYSLOG<DATE&TIME>.log';
%                           can be found on scanner in G:/log/scanphyslog-
%                           directory, one file is created per scan, make sure to take
%                           the one with the time stamp corresponding to your PAR/REC
%                           files
%       .log_respiration    contains breathing belt amplitude time course
%                           for Philips: same as .log_cardiac
%   cardiac_modality    'ECG' for ECG, 'OXY'/'PPU' for pulse oximetry, default: 'ECG'
%
% OUT
%   c                   cardiac time series (ECG or pulse oximetry)
%   r                   respiratory time series
%   t                   vector of time points (in seconds)
%   cpulse              time events of R-wave peak in cardiac time series (seconds)
%   acq_codes           slice/volume start events marked by number <> 0
%                       for time points in t
%
% EXAMPLE
%   [ons_secs.cpulse, ons_secs.rpulse, ons_secs.t, ons_secs.c] =
%   tapas_physio_read_physlogfiles(logfile, vendor, cardiac_modality);
%
%   See physio_also main_create_regressors
%
% Author: Lars Kasper
% Created: 2013-02-16
% Copyright (C) 2013, Institute for Biomedical Engineering, ETH/Uni Zurich.
%
% This file is part of the PhysIO toolbox, which is released under the terms of the GNU General Public
% Licence (GPL), version 3. You can redistribute it and/or modify it under the terms of the GPL
% (either version 3 or, at your option, any later version). For further details, see the file
% COPYING or <http://www.gnu.org/licenses/>.
%
% $Id: tapas_physio_read_physlogfiles.m 559 2014-10-29 15:18:19Z kasperla $

if nargin < 2
    cardiac_modality = 'ECG';
end

if nargin < 3
    verbose.level = 0;
end

switch lower(log_files.vendor)
    case 'philips'
        [c, r, t, cpulse, acq_codes] = ...
        tapas_physio_read_physlogfiles_philips(log_files, cardiac_modality);
    case 'ge'
        [c, r, t, cpulse] = ...
            tapas_physio_read_physlogfiles_GE(log_files, verbose);
        acq_codes = [];
    case 'siemens'
        [c, r, t, cpulse, verbose] = ...
            tapas_physio_read_physlogfiles_siemens(log_files, verbose);
        acq_codes = [];
    case 'siemens_tics'
        [c, r, t, cpulse, verbose] = ...
            tapas_physio_read_physlogfiles_siemens_tics(log_files, verbose);
        acq_codes = [];
    case 'custom'
        [c, r, t, cpulse] = ...
            tapas_physio_read_physlogfiles_custom(log_files, verbose);
        acq_codes = [];
end
end
