<?php
if(isset($impresiones)){
    foreach ($impresiones as $row) {
        $impresion = (array ) $row;
    }
}
if(!isset($lote_select)){
    $lote_select = 0;
}
/*--------------------------------------------------------------------------------  
            Carga del select con los lotes
 --------------------------------------------------------------------------------*/ 
$option = '<option></option>';
if($lotes_ant)
{
    foreach ($lotes_ant as $row) 
    {
        $option  .= '<option value="'.$row->id_lote.'" ';
        
        if($lote_select == $row->id_lote)
        {
            $option .= ' selected ';
        }
        
        $option .= ' >';
        $option .= $row->nombre;
        $option .= ': 1 : ';
        $option .= formatDate($row->fecha_venc_1).' $ '.$row->importe_venc_1;
        $option .= ' - ';
        $option .= ' 2 : ';
        $option .= formatDate($row->fecha_venc_2).' $ '.$row->importe_venc_2;
                                
        $option .= '</option>';
    }
}
$select_lote = '<select name="id_lote" id="id_lote" class="form-control">'.$option.'</select>';
/*--------------------------------------------------------------------------------  
            Contenido
 --------------------------------------------------------------------------------*/ 
 
$html = start_content();
$html .= '<form method="post" class="form-horizontal" target="_blank" action="'.base_url().'index.php/'.$subjet.'/generar_impresion/">';
$html .= '<div class="row divider">';
$html .= setLabel($this->lang->line('lote'));
$html .= setLabel($select_lote, 9);
$html .= '<div class="col-md-2">';
/*--------------------------------------------------------------------------------  
            Button de imprimir
 --------------------------------------------------------------------------------*/ 
 
$html .= '<button type="submit" class="btn btn-app" value="PDF" id="pdf">';
$html .= '<i class="fa fa-file-pdf-o"></i> PDF';
$html .= '</button>';
       

$html .= '</div>';
$html .= '</div>';
$html .= '</form>';
/*--------------------------------------------------------------------------------  
            Impresion de boletas
 --------------------------------------------------------------------------------*/

                    
$html .= end_content();
echo $html;
?>
<script>

$(function() 
{
    $('#id_lote').chosen();
});
</script>
<style>
@media all 
{
   div.saltopagina
   {
      display: none;
   }
}
   
@media print
{
   div.saltopagina
   { 
      display:block; 
      page-break-before:always;
   }
}
</style>