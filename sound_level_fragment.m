function result = sound_level_fragment(M, n, level_correction, samples)

    pw_fragment = signal_power_fragment(M, n, samples);
    pw_level_before_correction = signal_db(pw_fragment,1);

    result = pw_level_before_correction + level_correction;

endfunction
