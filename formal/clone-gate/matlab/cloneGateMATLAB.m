% SPDX-License-Identifier: LicenseRef-Sovereign-Leviathan-SL-AGPL3-001
function ok = cloneGateMATLAB(challengeFile, keyFile, expectedHex, idrisBin)
% Licensed MATLAB launcher for the checked Idris subprocess.
% Inputs are binary file paths (16-byte challenge, 32-byte key).
    if ~license('test', 'MATLAB')
        error('cloneGate:noMATLAB', 'No MATLAB license available.');
    end
    [status, errmsg] = license('checkout', 'MATLAB');
    if status ~= 1
        error('cloneGate:checkoutFailed', 'License checkout failed: %s', errmsg);
    end
    if nargin ~= 4 || isempty(regexp(expectedHex, '^[0-9a-fA-F]{32}$', 'once'))
        error('cloneGate:arguments', 'Four arguments and a 16-byte hex fingerprint are required.');
    end
    paths = {idrisBin, challengeFile, keyFile};
    for i = 1:numel(paths)
        % system invokes a shell: reject expansion/control characters.
        if ~ischar(paths{i}) || isempty(paths{i}) || ...
           any(ismember(paths{i}, [char(0:31), '"', '''', '&|<>^%!`$;'])) || ...
           ~isfile(paths{i})
            error('cloneGate:path', 'Invalid or missing file path.');
        end
    end
    cmd = sprintf('"%s" --challenge "%s" --key "%s" --expected "%s"', ...
                  idrisBin, challengeFile, keyFile, expectedHex);
    [exitCode, output] = system(cmd);
    if exitCode == 2 || exitCode == 3
        error('cloneGate:runtime', 'Idris input/runtime failure (%d): %s', exitCode, output);
    end
    if exitCode ~= 0 && exitCode ~= 1
        error('cloneGate:runtime', 'Unexpected Idris exit (%d): %s', exitCode, output);
    end
    ok = exitCode == 0;
    if ~ok, fprintf(2, 'cloneGate: denied.\n'); end
end
