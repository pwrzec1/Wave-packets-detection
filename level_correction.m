function result = level_correction(calibration_level, sound_samples)

    weight = 0;
    len = length(sound_samples);

    if len > 1024

        calculated_power = signal_power(sound_samples);
        calculated_level = signal_db(calculated_power,1);

        weight = calibration_level - calculated_level;

    endif

    result = weight;

endfunction
