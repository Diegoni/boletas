<?php
/*--------------------------------------------------------------------------------	
 			Carga de array necesarios
 --------------------------------------------------------------------------------*/	
$cant_afiliados_cambio = 500; 
$afiliados_array = array();
$datos_array = array(
	'id_lote'			=> '',
	'fecha_venc_1'		=> '',
	'fecha_venc_2'		=> '',
	'importe_venc_1'	=> '',
	'importe_venc_2'	=> '',
	'nro_cuota'			=> '',
);

if(isset($afiliados_lote) && $afiliados_lote){
	foreach ($afiliados_lote as $row) {
		$afiliados_array[] = $row->id_afiliado;
	}
}

if(isset($datos_lote)){
	foreach ($datos_lote as $row) {
		$datos_array['id_lote']			= $row->id_lote;
		$datos_array['fecha_venc_1']	= $row->fecha_venc_1;
		$datos_array['fecha_venc_2']	= $row->fecha_venc_2;
		$datos_array['importe_venc_1']	= $row->importe_venc_1;
		$datos_array['importe_venc_2']	= $row->importe_venc_2;
		$datos_array['nro_cuota']		= $row->nro_cuota + 1;
	}
}

echo '<script src="'.base_url().'librerias/multiselect/js/jquery.multi-select.js"></script>';
echo '<link href="'.base_url().'librerias/multiselect/css/multi-select.css" rel="stylesheet">';

/*--------------------------------------------------------------------------------	
 			Carga de opciones en los select
 --------------------------------------------------------------------------------*/	
 
if($afiliados)
{
    $cant_afiliados = count($afiliados);
    if($cant_afiliados < $cant_afiliados_cambio)
    {
        $opciones_afiliados = setOption($afiliados, 'id_afiliado', array('apellido', 'nombre'), $afiliados_array);    
    }	
}else
{
    $cant_afiliados     = 0;
	$opciones_afiliados = '<option></option>';
}

$opciones_lotes = '<option></option>';

if($lotes_ant)
{
	foreach ($lotes_ant as $row) 
	{
		$opciones_lotes  .= '<option value="'.$row->id_lote.'" ';
		if($row->id_lote == $datos_array['id_lote'])
		{
			$opciones_lotes .= 'selected ';
		}
        
		$opciones_lotes .= ' >';
		if($row->nombre != '')
		{
			$opciones_lotes .= $row->nombre.'= ';	
		}
		
		$opciones_lotes .= '1 : ';
		$opciones_lotes .= formatDate($row->fecha_venc_1).' $ '.$row->importe_venc_1;
		$opciones_lotes .= ' - ';
		$opciones_lotes .= ' 2 : ';
		$opciones_lotes .= formatDate($row->fecha_venc_2).' $ '.$row->importe_venc_2;
								
		$opciones_lotes .= '</option>';
	}
}

/*--------------------------------------------------------------------------------	
 			Contenido
 --------------------------------------------------------------------------------*/	
 
echo start_content();

if(isset($mensaje) && $mensaje != '')
{
    echo setMensaje($mensaje);
}

?>
					
<form method="post" class="form-horizontal" action="alta">
	<div class="row divider">
		<?php echo setLabel($this->lang->line('lote'));?>
		<div class="col-md-10">
			<select name="lote_base" id="lote_base" class="form-control" onchange="this.form.submit()">
				<?php echo $opciones_lotes?>
			</select>
		</div>
		<div class="col-md-1">
			<button type="button" class="btn btn-default" data-toggle="modal" data-target="#myModal"><i class="fa fa-question-circle"></i></button>
		</div>
	</div>
</form>
					
<form method="post" id="generar_boletas" class="form-horizontal" action="generar_boletas" onsubmit="return control_boleta()">
	<?php
	if(isset($ente)){
		echo '<input name="id_ente" value="'.$ente.'" type="hidden">'; 
	}
	?>
	<div class="row divider">
		<?php echo setLabel($this->lang->line('nro_cuota'));?>
		<div class="col-md-4">
			<input class="form-control" name="nro_cuota" id="nro_cuota" type="text" onkeypress="return onlyInt(event)" value="<?php echo $datos_array['nro_cuota']?>"/>
		</div>
		<?php echo setLabel($this->lang->line('nombre'));?>
		<div class="col-md-5">
			<input class="form-control" name="nombre" id="nombre" type="text" onkeypress="return onlyCharInt(event)"/>
		</div>
	</div>
	
					
	<div class="row divider">
		<?php echo setLabel($this->lang->line('afiliados'));?>
		<div class="col-md-10">
		    <?php
		    if($cant_afiliados_cambio > 0)
		    {
                if($cant_afiliados < $cant_afiliados_cambio)
                {
                    $html = '<select class="form-control" name="afiliados[]" id="afiliados" multiple required/>';
                    $html .= $opciones_afiliados;
                    $html .= '</select>';
                }else
                {
                    $html = '';
                    $cabeceras = array(
                        '<input name="select_all" value="1" type="checkbox">',
                        lang('nombre'),
                        lang('apellido'),
                        lang('codigo'),
                    );
                    
                    $html .= start_table($cabeceras);
                    $html .= end_table();
                }
                
                echo $html;    
		    }
		    ?>
		</div>
		<div class="col-md-1">
		    <?php
		    if($cant_afiliados_cambio > 0)
            {
                if($cant_afiliados < $cant_afiliados_cambio)
                {
                    $html = '<button type="button" class="btn btn-default" id="select-all"><i class="fa fa-arrow-right"></i></button>';
			        $html .= '<button type="button" class="btn btn-default divider" id="deselect-all"><i class="fa fa-arrow-left"></i></button>';
                    
                    echo $html;
                }   
            }
            ?>
		</div>
	</div>
	
	 <div class="row divider">
        <?php echo setLabel($this->lang->line('vencimiento_1'));?>
        <div class="col-md-4">
            <div class="input-group" onclick="$('#primera_fecha').focus()">
                <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                <input class="form-control datepicker" name="primera_fecha" id="primera_fecha" type="text" onkeypress="return false" placeholder="<?php echo formatDate($datos_array['fecha_venc_1'])?>" required/>
            </div>
        </div>

        <?php echo setLabel($this->lang->line('importe_1'));?>
        <div class="col-md-5">
            <div class="input-group">
                <div class="input-group-addon">$</div>
                <input class="form-control importe" name="primer_importe" id="primer_importe" type="text" onkeypress="return onlyFloat(event)" value="<?php echo $datos_array['importe_venc_1']?>" required/>
            </div>
        </div>
    </div>
                    
    <div class="row divider">
        <?php echo setLabel($this->lang->line('vencimiento_2'));?>
        <div class="col-md-4">
            <div class="input-group" onclick="$('#segunda_fecha').focus()">
                <div class="input-group-addon"><i class="fa fa-calendar"></i></div>
                <input class="form-control datepicker" name="segunda_fecha" id="segunda_fecha" type="text" onkeypress="return false" placeholder="<?php echo formatDate($datos_array['fecha_venc_2'])?>" required/>
            </div>
        </div>

        <?php echo setLabel($this->lang->line('importe_2'));?>
        <div class="col-md-5">
            <div class="input-group">
                <div class="input-group-addon">$</div>
                <input class="form-control importe" name="segundo_importe" id="segundo_importe" type="text" onkeypress="return onlyFloat(event)" value="<?php echo $datos_array['importe_venc_2']?>" required/>
            </div>
        </div>
    </div>
		
					
	<div class="alert alert-dismissable divider" id="alert" style="display: none;">
		<div id="mensaje_error"></div>
	</div>
                 	
	<input type="hidden" name="clicks" id="clicks" value="0">
					
	<div class="col-md-8 col-md-offset-2 divider text-center">
	    <?php
	    if($cant_afiliados < $cant_afiliados_cambio)
        {
            //echo '<button type="submit" value="upload" class="btn btn-app" id="generar" onclick="cantidadAfiliados()"/>';
            echo '<button type="submit" value="upload" class="btn btn-app" id="generar"/>';
        }else
        {
            echo '<button type="submit" value="upload" class="btn btn-app" id="generar"/>';
        }
        ?>          
			<i class="fa fa-barcode"></i> <?php echo $this->lang->line('generar')?>
		</button>
		<img src="<?php echo base_url().'uploads/img/sitio/loading_small.gif'?>" class="image divider hide" id="loading" height= "45px;" style="margin-bottom: 15px;">
	</div>

</form>

<?php 
$mensaje = 'No es un campo obligatorio. Este campo permite cargar en el formulario antiguos lotes de factura, para evitar cargar los filtros de afiliados cada vez que se realiza el proceso.';

echo end_content();
echo get_modal('myModal', $mensaje);
?>

<script>
// Controlamos que esten los afiliados seleccionados
function cantidadAfiliados()
{
    var cantidad = 0;
    
    $( "select" ).change(function() {
        var str = "";
        $( "select option:selected" ).each(function() {
            cantidad = cantidad + 1;
        });
    });
    
    if(cantidad == 0)
    {
        $('#alert').show( "drop", 1000 );
        $('#alert').removeClass('alert-warning');
        $('#alert').addClass('alert-danger');
        $('#mensaje_error').html('<p>No se han seleccionado Afiliados</p>');
        $('#afiliados').focus();
    }
}


// Sacamos del calendario los sabados, domingos y feriados
function DisableSpecificDates(date) 
{
	var disableddates = [
	<?php 
	if($feriados)
	{
		$fechas = '';
		foreach ($feriados as $row) 
		{
			$ano = date('Y', strtotime($row->fecha));
			$mes = date('m', strtotime($row->fecha));
			$dia = date('d', strtotime($row->fecha));
			$mes = (int) $mes;
			$dia = (int) $dia;
			$fechas .= '"'.$mes.'-'.$dia.'-'.$ano.'",';
		}
		
		$fechas = substr($fechas, 0, -1);
		echo $fechas;
	}
	?>
	]; 	
	var m = date.getMonth();
	var d = date.getDate();
	var y = date.getFullYear();
	var currentdate = (m + 1) + '-' + d + '-' + y ;

	for (var i = 0; i < disableddates.length; i++) 
	{
	 	if ($.inArray(currentdate, disableddates) != -1 ) 
	 	{
	 		return [false];
	 	} 
	}

	var weekenddate = $.datepicker.noWeekends(date);
	
	return weekenddate; 
}


// Multiselect de afiliados
$(function() 
{
	$('#afiliados').multiSelect();
	$('.ms-selectable').unbind("click");
	$('#afiliados').change(function()
	{
		var count = $("#afiliados :selected").length;
		if(count > <?php echo $config['maximo_afiliados_boletas']?>)
		{
			alert('supero el número de selecciones posibles');
			$('.ms-selectable').hide( "clip" , 1000);
			
		}else
		{
			$('.ms-selectable').show( "clip" , 1000);
		}
	});
	
	var cantidad_option = $('#afiliados option').length;
	
	if(cantidad_option < <?php echo $config['maximo_afiliados_boletas']?>)
	{
		$('#select-all').click(function()
		{
			$('#afiliados').multiSelect('select_all');
			$('#afiliados').multiSelect('refresh');
			return false;
		});
		
		$('#deselect-all').click(function()
		{
			$('#afiliados').multiSelect('deselect_all');
			$('#afiliados').multiSelect('refresh');
			return false;
		});
	}else
	{
		$('#select-all').addClass('disabled');
		$('#select-all').attr( "title", 'Usted tiene más de <?php echo $config['maximo_afiliados_boletas']?> afiliados, esta función esta deshabilitada');
		$('#deselect-all').addClass('disabled');
		$('#deselect-all').attr( "title", 'Usted tiene más de <?php echo $config['maximo_afiliados_boletas']?> afiliados, esta función esta deshabilitada');
	}
	
	
	$('#lote_base').chosen();
	
	$("#primera_fecha" ).datepicker({
        defaultDate: "+1w",
        changeMonth: true,
        numberOfMonths: 3,
        beforeShowDay: DisableSpecificDates,
        <?php 
        if($config['usar_min_fecha']){
            echo  'minDate: '.$config['min_fecha'].',';
        }
	   ?>
        onClose: function( selectedDate ) {
            $( "#segunda_fecha" ).datepicker( "option", "minDate", selectedDate );
        }
    });
    
    $( "#segunda_fecha" ).datepicker({
        defaultDate: "+1w",
        changeMonth: true,
        numberOfMonths: 3,
        beforeShowDay: DisableSpecificDates,
        <?php 
        if($config['usar_min_fecha']){
            echo  'minDate: '.$config['min_fecha'].',';
        }
        ?>
        onClose: function( selectedDate ) {
            $( "#primera_fecha" ).datepicker( "option", "maxDate", selectedDate );
        }
    });
	
	$( ".datepicker" ).attr('autocomplete', 'off');
    
	$( ".importe" ).attr('autocomplete', 'off');
});

  
// Controles de los datos ingresados en las boletas  
function control_boleta()
{
   $('#alert').show( "drop", 1000 );
	clicks			= $('#clicks').val();
	primer_importe	= $('#primer_importe').val();
	segundo_importe = $('#segundo_importe').val();
	primera_fecha	= $('#primera_fecha').val();
	segunda_fecha	= $('#segunda_fecha').val();
	afiliados		= $('#afiliados').val();
	
	pf		= primera_fecha.split("/");
	sf		= segunda_fecha.split("/");
		
	fecha_1 = new Date(pf[2]+'/'+pf[1]+'/'+pf[0]).getTime();
	fecha_2 = new Date(sf[2]+'/'+sf[1]+'/'+sf[0]).getTime();
	
	primer_importe	= parseFloat(primer_importe);
	segundo_importe	= parseFloat(segundo_importe);
	
	error	= 0;
	warning = 0;
	mensaje = '';
	focus	= '';
	
	/*-------------------------------------------------------------
	ERRORES EN EL FORM
	--------------------------------------------------------------*/

	bandera = true;
	// Controlamos que sean float
	if(!isFloat(primer_importe))
	{	
		error	= 1;	
		mensaje = 'No es un numero';
		focus	= 'primer_importe';
	}
	
	
	if(!isFloat(segundo_importe))
	{
		error	= 1;	
		mensaje = 'No es un numero';
		focus	= 'segundo_importe';
	}
	
	
	if(primer_importe > segundo_importe)
	{	
		error	= 1;	
		mensaje = 'El primer importe no puede ser mayor al segundo';
		focus	= 'segundo_importe';
	}
	
	
	if(fecha_1 > fecha_2)
	{
		error	= 1;	
		mensaje = 'La primera fecha no puede ser mayor a la segunda '+fecha_1+' '+fecha_2;
		focus	= 'primera_fecha';	
	}
	
	
	if(error == 1)
	{
		$('#alert').removeClass('alert-warning');
		$('#alert').addClass('alert-danger');
		$('#mensaje_error').html('<p>'+mensaje+'</p>');
		$('#'+focus).focus();
		
		bandera = false;
	}

	/*-------------------------------------------------------------
	WARNING EN EL FORM
	--------------------------------------------------------------*/
	
	if(clicks == 0 )
	{
        if(primer_importe == segundo_importe)
        {
			warning = 1;	
			mensaje = 'Los importes coinciden';
			focus	= 'segundo_importe';	
		}
		
		if(primer_importe == 0)
		{
			warning = 1;	
			mensaje = 'El importe a pagar es 0';
			focus	= 'primer_importe';	
		}
		
		if(segundo_importe == 0)
		{
			warning = 1;	
			mensaje = 'El importe a pagar es 0';
			focus	= 'segundo_importe';	
		}
		
		if(fecha_1 == fecha_2)
		{
			warning = 1;	
			mensaje = 'Los fechas coinciden';
			focus = 'segunda_fecha';	
		}
		
		if(warning == 1)
		{
			$('#alert').removeClass('alert-danger');
			$('#alert').addClass('alert-warning');
			$('#mensaje_error').html('<p>'+mensaje+'</p>');
			$('#'+focus).focus();
			$('#clicks').val(1);
			
			bandera = false;
		}
	} 
	
	if(bandera == true)
	{
		$("#generar").addClass('hide');
		$("#loading").removeClass('hide');
	}
	
	return bandera;
}
</script>

<link rel="stylesheet" href="<?php echo base_url()?>librerias/plantilla/plugins/datatables/dataTables.bootstrap.css">
<script src="<?php echo base_url()?>librerias/plantilla/plugins/datatables/jquery.dataTables.min.js"></script>
<script src="<?php echo base_url()?>librerias/plantilla/plugins/datatables/dataTables.bootstrap.min.js"></script>

<script>
function updateDataTableSelectAllCtrl(table)
{
   var $table             = table.table().node();
   var $chkbox_all        = $('tbody input[type="checkbox"]', $table);
   var $chkbox_checked    = $('tbody input[type="checkbox"]:checked', $table);
   var chkbox_select_all  = $('thead input[name="select_all"]', $table).get(0);

   // Si no se selecciona ninguna de las casillas de verificación
   if($chkbox_checked.length === 0)
   {
      chkbox_select_all.checked = false;
      if('indeterminate' in chkbox_select_all)
      {
         chkbox_select_all.indeterminate = false;
      }

   // Si estan todas las casillas seleccionas
   }else if ($chkbox_checked.length === $chkbox_all.length)
   {
      chkbox_select_all.checked = true;
      if('indeterminate' in chkbox_select_all)
      {
         chkbox_select_all.indeterminate = false;
      }

   // Si alguno de los checkbox estan seleccionados
   }else 
   {
      chkbox_select_all.checked = true;
      if('indeterminate' in chkbox_select_all)
      {
         chkbox_select_all.indeterminate = true;
      }
   }
}

$(document).ready(function (){
    // Array holding selected row IDs
    var rows_selected = [];
    var table = $('#table_registros').DataTable({
        'ajax': {
            'url': "<?php echo base_url()?>index.php/afiliados/afiliados_form",
        },
        "lengthMenu": [[10, 25, 50, 2000], [10, 25, 50, 2000]],
        "language": {
            "sProcessing":    "Procesando...",
            "sLengthMenu":    "Mostrar _MENU_ registros",
            "sZeroRecords":   "No se encontraron resultados",
            "sEmptyTable":    "Ningún dato disponible en esta tabla",
            "sInfo":          "Mostrando registros del _START_ al _END_ de un total de _TOTAL_ registros",
            "sInfoEmpty":     "Mostrando registros del 0 al 0 de un total de 0 registros",
            "sInfoFiltered":  "(filtrado de un total de _MAX_ registros)",
            "sInfoPostFix":   "",
            "sSearch":        "Buscar:",
            "sUrl":           "",
            "sInfoThousands":  ",",
            "sLoadingRecords": "Cargando...",
            "oPaginate": {
                "sFirst":   "Primero",
                "sLast":    "Último",
                "sNext":    "Siguiente",
                "sPrevious":"Anterior"
            },
            "oAria": {
                "sSortAscending":  ": Activar para ordenar la columna de manera ascendente",
                "sSortDescending": ": Activar para ordenar la columna de manera descendente"
            }
        }, 
        'columnDefs': [{
            'targets': 0,
            'searchable': false,
            'orderable': false,
            'width': '1%',
            'className': 'dt-body-center',
            'render': function (data, type, full, meta){
                return '<input type="checkbox" name="afiliados[]" value="'+data+'">';
            }
        }],
        'order': [[1, 'asc']],
        'rowCallback': function(row, data, dataIndex){
            // Get row ID
            var rowId = data[0];
            // If row ID is in the list of selected row IDs
            if($.inArray(rowId, rows_selected) !== -1){
                $(row).find('input[type="checkbox"]').prop('checked', true);
                $(row).addClass('selected');
            }
        },
        select: {
            style:    'multi',
            selector: 'td:first-child'
        },
    });
  

   // Handle click on checkbox
   $('#table_registros tbody').on('click', 'input[type="checkbox"]', function(e){
      var $row = $(this).closest('tr');

      // Get row data
      var data = table.row($row).data();

      // Get row ID
      var rowId = data[0];

      // Determine whether row ID is in the list of selected row IDs 
      var index = $.inArray(rowId, rows_selected);

      // If checkbox is checked and row ID is not in list of selected row IDs
      if(this.checked && index === -1)
      {
         rows_selected.push(rowId);

      // Otherwise, if checkbox is not checked and row ID is in list of selected row IDs
      }else if(!this.checked && index !== -1)
      {
         rows_selected.splice(index, 1);
      }

      if(this.checked){
         $row.addClass('selected');
      }else 
      {
         $row.removeClass('selected');
      }

      // Update state of "Select all" control
      updateDataTableSelectAllCtrl(table);

      // Prevent click event from propagating to parent
      e.stopPropagation();
   });

   // Handle click on table cells with checkboxes
   $('#table_registros').on('click', 'tbody td, thead th:first-child', function(e){
      $(this).parent().find('input[type="checkbox"]').trigger('click');
   });

   // Handle click on "Select all" control
   $('thead input[name="select_all"]', table.table().container()).on('click', function(e){
      if(this.checked){
         $('#table_registros tbody input[type="checkbox"]:not(:checked)').trigger('click');
      } else {
         $('#table_registros tbody input[type="checkbox"]:checked').trigger('click');
      }

      // Prevent click event from propagating to parent
      e.stopPropagation();
   });

   // Handle table draw event
   table.on('draw', function(){
      // Update state of "Select all" control
      updateDataTableSelectAllCtrl(table);
   });

   // Handle form submission event 
   $('#generar_boletas').on('submit', function(e){
      var form = this;
      
      // Iterate over all selected checkboxes
      $.each(rows_selected, function(index, rowId){
         // Create a hidden element 
         $(form).append(
             $('<input>')
                .attr('type', 'hidden')
                .attr('name', 'afiliados[]')
                .val(rowId)
         );
      });
   });

});
</script>

<style>
    table.dataTable.select tbody tr,
    table.dataTable thead th:first-child {
        cursor: pointer;
    }
    
    table.dataTable td {
        cursor: pointer;
    }
</style>