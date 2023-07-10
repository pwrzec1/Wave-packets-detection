%%Octave program
pkg load parallel

command_line = argv();

printf("\nThe program for the calculation of the measurement uncertainty of the pulse detecting.\n");
printf("(c) Piotr Wrzeciono, Michał Szymański, Hydayatullah Bayat, 2023\n\n");

impulse_duration = 0; #The default value

if length(command_line) >= 7

    file_pulses = command_line{1};
    file_94dB = command_line{2};
    file_out_txt = command_line{3};

    impulse_duration_txt = command_line{4};
    dispersion_begin_txt = command_line{5};
    dispersion_end_txt = command_line{6};
    dispersion_step_txt = command_line{7};

    impulse_duration = str2num(impulse_duration_txt);
    dispersion_begin = str2num(dispersion_begin_txt);
    dispersion_end = str2num(dispersion_end_txt);
    dispersion_step = str2num(dispersion_step_txt);

else

    printf("\nThe number of parameters is too small. You have to set 7 parameters:\n");
    printf("the file name of the recording of the pulses (file1), the file name of the recording of the 94dB reference (file2),\n");
    printf("the name of the output file (file3), the duration of the pulse (t1), the beginning value of dispersion (v_b),\n");
    printf("the final value of dispersion (v_end), and the step value for dispersion (v_step)\n");
    printf("\nthe command syntax is:\n\n");
    printf("octave calculation_of_errors_paralell file1 file2 file3 t1 v_b v_end v_step\n");

    exit;

endif

[level94wave, fs] =  audioread(file_94dB);
[impulse_wave, fs] = audioread(file_pulses);


weight94dB = level_correction(94,level94wave);
impulse_len = length(impulse_wave);


number_of_steps = (dispersion_end - dispersion_begin + dispersion_step)/dispersion_step;
number_of_steps = int32(number_of_steps);

counter = 0;

dispersion_value = dispersion_begin;


    while(dispersion_value <= dispersion_end +(dispersion_step/2))

        M = int32(dispersion_value * impulse_duration * fs);
        number_of_level_samples = impulse_len - M;

        counter = counter + 1;

        level_values = 0; #To prevent errors in matrix operation.
        maxima = 0;

        percent_all = 100 * cast(counter,"double")/cast(number_of_steps,"double");


        index_l = 1:number_of_level_samples;

        level_values = pararrayfun(nproc, @(index_l) sound_level_fragment(M, index_l, weight94dB, impulse_wave), index_l);

        maxima = searching_for_impulses(M, level_values);
        pulse_statistic(counter) = maxima_statistics(maxima, fs);
        dispersion_table(counter) = dispersion_value;

        pause(0.05); #Prevent the parallel operation errors.
        printf("Progress of calculating for dispersion: %1.2f is %3.2f%%    \r", dispersion_value, percent_all);

        dispersion_value = dispersion_value + dispersion_step;

    endwhile


    file_id = fopen(file_out_txt,"w");

    fprintf(file_id, "Results of the calculation of the measure uncertainty\n");
    fprintf(file_id, "\tConcrete\t\t\t\tSpeaker\n");
    fprintf(file_id, "Dispersion\tMean\tStd\tError [%%]\tError of time [s]\t");
    fprintf(file_id, "Mean\tStd\tError [%%]\tError of time [s]\n");

    for k=1:length(pulse_statistic)

        st = pulse_statistic(k);

        fprintf(file_id, "%1.2f\t", dispersion_table(k));

        fprintf(file_id, "%1.2f\t",st.mean_even3);
        fprintf(file_id, "%f\t", st.standard_even3);
        fprintf(file_id, "%f\t", st.uncertainty_even3);
        fprintf(file_id, "%f\t", st.uncertainty_even_time3);

        fprintf(file_id, "%1.2f\t",st.mean_odd3);
        fprintf(file_id, "%f\t", st.standard_odd3);
        fprintf(file_id, "%f\t", st.uncertainty_odd3);
        fprintf(file_id, "%f\n", st.uncertainty_odd_time3);

    endfor


    fclose(file_id);

    printf("\n");
