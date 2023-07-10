function result = signal_power_fragment(M, n, samples)

    vector_fragment = zeros(M,1);
    power_fragment = 0;
    len = length(samples);

    if n < len

        begin_index = n;
        end_index = n + M - 1;

        if end_index > len

            end_index = len

        endif

        index_m = 1;
        for index_f = begin_index:end_index

            vector_fragment(index_m) = samples(index_f);
            index_m = index_m + 1;

        endfor

        power_fragment = signal_power(vector_fragment);

    endif

    result = power_fragment;

endfunction
