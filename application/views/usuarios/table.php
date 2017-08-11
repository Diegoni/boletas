<?php
if($config['usuarios_delete'] == 1){
    $cabeceras = array(
        $this->lang->line('usuario'),
        $this->lang->line('perfil'),
        $this->lang->line('last_login'),
        $this->lang->line('estado'),
        $this->lang->line('opciones'),
    ); 
    
}else{
    $cabeceras = array(
        $this->lang->line('usuario'),
        $this->lang->line('perfil'),
        $this->lang->line('last_login'),
        $this->lang->line('opciones'),
    ); 
}



$html = start_content();

if(isset($mensaje)){
	$html .= setMensaje($mensaje);
}

if($permisos['agregar'] == 1){
	$html .= getExportsButtons($cabeceras, table_add($subjet));
}else{
	$html .= getExportsButtons($cabeceras);
}

$html .= start_table($cabeceras);

if($registros){
	$hoy = date('Y-m-d H:i:s');
	foreach ($registros as $row) {
		if($row->id_perfil == 2){
			$perfil = setSpan($row->perfil, 'default');
		} else {
			$perfil = setSpan($row->perfil, 'primary');
		}
        
        if($config['usuarios_delete'] == 1){
            if($row->eliminado == 0){
                $estado = setSpan('<i class="fa fa-check"></i>', 'success');
            } else {
                $estado = setSpan('<i class="fa fa-trash"></i>', 'danger');
            }
        }
	
        if($config['usuarios_delete'] == 1){
    		$registro = array(
    			$row->usuario,
    			$perfil,
    			formatDatetime($row->last_login).dias_transcurridos($row->last_login, $hoy, TRUE),
    			$estado,
    			table_upd($subjet, $row->id_usuario).' <a class="btn btn-default" href="'.base_url().'index.php/usuarios/logs/'.$row->id_usuario.'" title="logs""><i class="fa fa-sign-in"></i></a>',
    		);
        } else {
           $registro = array(
                $row->usuario,
                $perfil,
                formatDatetime($row->last_login).dias_transcurridos($row->last_login, $hoy, TRUE),
                table_upd($subjet, $row->id_usuario).' <a class="btn btn-default" href="'.base_url().'index.php/usuarios/logs/'.$row->id_usuario.'" title="logs""><i class="fa fa-sign-in"></i></a>',
            ); 
        }            
		
		$html .= setTableContent($registro);	
	}
}
			
$html .= end_table($cabeceras);			
			
$html .= end_content();
$html .= setDatatables();

echo $html;
?>