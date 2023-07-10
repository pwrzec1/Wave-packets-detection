function result = searching_for_impulses(M, sound_fragments_level)

    number_of_maxima = 0;
    index_of_last_max = 0;
    sample_shift = M;
    len = length(sound_fragments_level);

    while (index_of_last_max + sample_shift < len)

        if index_of_last_max == 0
            index_of_last_max = 1;
            begin_index = 1;
        else
            begin_index = index_of_last_max + sample_shift - 1;
        endif

        part_of_vector = sound_fragments_level(begin_index:end);
        [value position] = max(part_of_vector);

        number_of_maxima = number_of_maxima + 1;
        index_of_last_max = begin_index + position - 1;

        result_maxima(number_of_maxima) = index_of_last_max;

    endwhile

    if number_of_maxima == 0

        result = 0;
    else

        result = result_maxima;

    endif

endfunction
