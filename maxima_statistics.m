function result = maxima_statistics(maxima_table, fs)


    result = 0;

    if length(maxima_table) > 0

        former_max_index = 0;
        index_max = 0;

        for k=1:length(maxima_table)

            difference = maxima_table(k) - former_max_index;
            former_max_index = maxima_table(k);

            index_max = index_max + 1;
            difference_table(index_max) = difference;

        endfor

        index_even = 0;
        index_odd = 0;

        for k=1:length(difference_table)

            if mod(k,2) == 1

                if k > 1
                    index_odd = index_odd + 1;
                    table_odd(index_odd) = cast(difference_table(k),"double");
                endif
            else
                index_even = index_even + 1;
                table_even(index_even) = cast(difference_table(k),"double");
            endif

        endfor

        st.mean_odd = mean(table_odd);
        st.standard_odd =std(table_odd);
        st.uncertainty_odd = 100 * st.standard_odd/st.mean_odd;
        st.uncertainty_odd_time = st.standard_odd/(cast(fs,"double"));

        st.mean_even = mean(table_even);
        st.standard_even = std(table_even);
        st.uncertainty_even = 100 * st.standard_even/st.mean_even;
        st.uncertainty_even_time = st.standard_even/(cast(fs,"double"));

        if length(table_odd) < 3

            st.is3 = 0;

        else

            st.is3 = 1;


            for k=1:3

                table_even3(k) = table_even(k);
                table_odd3(k) = table_odd(k);
            endfor

                st.mean_odd3 = mean(table_odd3);
                st.standard_odd3 = std(table_odd3);
                st.uncertainty_odd3 = 100 * st.standard_odd3/st.mean_odd3;
                st.uncertainty_odd_time3 = st.standard_odd3/(cast(fs,"double"));

                st.mean_even3 = mean(table_even3);
                st.standard_even3 = std(table_even3);
                st.uncertainty_even3 = 100 * st.standard_even3/st.mean_even3;
                st.uncertainty_even_time3 = st.standard_even3/(cast(fs,"double"));

        endif

        result = st;

    endif

endfunction
