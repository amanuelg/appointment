            $(document).ready(function () {
                //set default value 
                var start = $.now();
                
                $('#datetimepicker_start').datetimepicker({minDate: start,useCurrent: false});
                $('#datetimepicker_end').datetimepicker({useCurrent: false });
                
                $('#datetimepicker_start').datetimepicker().on('dp.change', function(e){
                        $('#datetimepicker_end').data("DateTimePicker").minDate(e.date);
                                
                });
                    
                $('#datetimepicker_end').datetimepicker().on('dp.change', function(e){
                        $('#datetimepicker_start').data("DateTimePicker").maxDate(e.date);
                                
                });
        });