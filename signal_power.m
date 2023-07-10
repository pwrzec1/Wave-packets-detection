function result = signal_power(samples)

    pw = 0;
    len = length(samples);

    if len > 0

        if len == 1
            pw = abs(samples)^2;
        else
            samples_abs2 = abs(samples).^2;
            pw = sum(samples_abs2)/len;
        endif

    endif

    result = pw;

endfunction
