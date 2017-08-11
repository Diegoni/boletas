<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Boletas extends My_Controller {

	protected $_subject		= 'boletas';
	
	function __construct(){
		parent::__construct(
				$subjet		= $this->_subject 
		);
		
		$this->load->model('m_afiliados');
		$this->load->model('m_barcore');
		$this->load->model('m_boletas');
		$this->load->model('m_entes');
		$this->load->model('m_impresiones');
		$this->load->model('m_impresiones_campos');
		$this->load->model('m_feriados');
		$this->load->model('m_localidades');
		$this->load->model('m_lotes');
		$this->load->model('m_pagos_boletas');
		$this->load->model('m_provincias');

	} 
		
/*--------------------------------------------------------------------------------	
 			Alta masiva de boletas: Formulario
 --------------------------------------------------------------------------------*/

	public function alta($mensaje = NULL){
	    if($mensaje != NULL){
	        $db['mensaje']     = $mensaje;
	    }
		$db['feriados']		= $this->m_feriados->getRegistros();
		$db['lotes_ant']	= $this->m_lotes->getRegistros($this->_session_data['id_ente'], 'id_ente');
		$db['afiliados']	= $this->m_afiliados->getAfiliados($this->_session_data['id_ente'], $this->_session_data['id_usuario']);
			
		if($this->input->post('lote_base')){
			$db['datos_lote']		= $this->m_lotes->getRegistros($this->input->post('lote_base'));
			$db['afiliados_lote']	= $this->m_boletas->getLote($this->input->post('lote_base'), $this->_session_data['id_ente']);
		}
			
		$this->armar_vista('alta', $db);
	}
	
/*--------------------------------------------------------------------------------	
 			Alta masiva de boletas: Generación
 --------------------------------------------------------------------------------*/	
	
	public function generar_boletas()
	{
	    $mensaje = '';
         
		$array_fecha1 = explode("/", $this->input->post('primera_fecha'));
		$array_fecha2 = explode("/", $this->input->post('segunda_fecha'));
        

		$registro = array(
			'fecha_venc_1'		=> $array_fecha1[2].'-'.$array_fecha1[1].'-'.$array_fecha1[0],
			'importe_venc_1'	=> $this->input->post('primer_importe'),
			'fecha_venc_2'		=> $array_fecha2[2].'-'.$array_fecha2[1].'-'.$array_fecha2[0],
			'importe_venc_2'	=> $this->input->post('segundo_importe'),
			'id_ente'			=> $this->_session_data['id_ente'],
			'nombre'			=> $this->input->post('nombre'),
			'nro_cuota'			=> $this->input->post('nro_cuota'),
		);
			
		$registro['id_lote'] = $this->m_lotes->insert($registro);
		unset($registro['nombre']);
		
        $cantidad_boletas = 0;
        $cantida_afiliados = count($this->input->post('afiliados'));
        
        if($cantida_afiliados > 0)
        {
            foreach ($this->input->post('afiliados') as $id_afiliado) 
            {
                if($id_afiliado)
                {
                    $registro['id_afiliado'] = $id_afiliado;
                    $id_control = $this->m_boletas->control_generadas($registro);
                        
                    if($id_control == 0)
                    {
                        $this->m_boletas->insertBoleta($registro);
                        
                        $cantidad_boletas = $cantidad_boletas + 1;
                    }else
                    {
                        $url = '<p><a href="'.base_url().'index.php/'.$this->_subject.'/abm/'.$id_control.'" >'.$this->lang->line('boleta_existente').': '.$id_control.'</a></p>';
                        $this->alerta($url);
                    }
                }
            };            
        }else
        {
            $mensaje = lang('seleccione').' '.lang('afiliados');    
        }
		
        
        if($cantidad_boletas > 0)
        {
            redirect('/'.$this->_subject.'/generar_impresion/'.$registro['id_lote'], 'refresh');    
        }else 
        {
            $this->m_lotes->delete($registro['id_lote']);
            if($mensaje == '')
            {
                $mensaje = lang('boleta_existente');    
            }            
            
            $this->alta($mensaje);
        }
	}

/*--------------------------------------------------------------------------------	
 			Alta masiva de boletas: Impresión
 --------------------------------------------------------------------------------*/
	
	public function generar_impresion($id_lote = NULL, $id_boleta = NULL)
	{
	    if($this->input->post('id_lote'))
		{
			foreach ($this->input->post($id_lote) as $value) 
			{
				redirect('/'.$this->_subject.'/generar_pdf/'.$value, 'refresh');
			}
		}
        
        if($id_boleta != NULL)
        {
            redirect('/'.$this->_subject.'/generar_pdf/'.$id_lote.'/'.$id_boleta, 'refresh');
        }
        
		$db['lotes_ant']	= $this->m_lotes->getRegistros($this->_session_data['id_ente'], 'id_ente');
        
        if($id_lote != NULL)
        {
            $db['lote_select']    = $id_lote;    
        }

        $this->armar_vista('impresion', $db);         
    }

/*--------------------------------------------------------------------------------  
            Generacion del PDF con las boletas
 --------------------------------------------------------------------------------*/

    function generar_pdf($id_lote = NULL, $id_boleta = NULL)
    {
        $db['lotes_ant']    = $this->m_lotes->getRegistros($this->_session_data['id_ente'], 'id_ente');
        $impresiones        = $this->m_impresiones->getRegistros();
        
        foreach ($impresiones as $_row) 
        {
            $cantidad_x_hoja = $_row->x_hoja;
        } 
        
        if($id_lote != NULL)
        {
            if($id_boleta != NULL)
            {
                $boletas        = $this->m_boletas->getBoleta($id_boleta);
            }else
            {
                $boletas        = $this->m_boletas->getLote($id_lote, $this->_session_data['id_ente']);
            }
            
            foreach ($db['lotes_ant'] as $row) 
            {
                if($row->id_lote == $id_lote)
                {
                    $_lote = (array) $row;
                }                
            }
        }
        
        // Cargo las librerias de pdf y los parametros 
        $this->load->library('CI_fpdf');
        $this->load->library('CI_Code128');
           
        $pdf = new CI_Code128();
        $pdf->AddPage();
        $pdf->SetFont('Arial','',10);
            
        $code = 'CODE 128';
            
        $cantidad  = 0;
        $_div   = 1;
        $_hoja  = 1;
        
        // Recorro el array de boletas
        if($boletas)
        {
            foreach ($boletas as $row) 
            {
                // Cada tres boletas agrego una nueva pagina
                if($_div == 1)
                {
                    if($_hoja != 1)
                    {
                        $pdf->AddPage();
                    }
                        
                    $_hoja = $_hoja + 1;
                    $_div  = 0;
                    $cantidad = 0;
                }
                    
                $cantidad = $cantidad + 1;
                    
                $boleta_array = (array) $row;
                
                // Datos de la tabla                    
                $pdf->Cell(60,6, lang('ente'),1);
                $pdf->Cell(130,6, iconv("UTF-8", "CP1250//TRANSLIT", $boleta_array['ente']) ,1);
                $pdf->Ln();
                    
                $pdf->Cell(60,6, formatStringPdf(lang('codigo').' '.lang('ente')),1);
                $pdf->Cell(130,6, $boleta_array['codigo_ente'] ,1);
                $pdf->Ln();
                    
                $pdf->Cell(60,6, formatStringPdf(lang('codigo').' '.lang('afiliado')),1);
                $pdf->Cell(130,6, $boleta_array['codigo_afiliado'] ,1);
                $pdf->Ln();
                    
                $pdf->Cell(60,6, lang('nombre').' '.lang('afiliado'),1);
                $pdf->Cell(130,6, formatStringPdf($boleta_array['apellido'].' '.$boleta_array['nombre']) ,1);
                $pdf->Ln();                        
                    
                $pdf->Cell(60,6, lang('vencimiento_1'),1);
                $pdf->Cell(130,6, formatDate($boleta_array['fecha_venc_1']) ,1);
                $pdf->Ln();
                    
                $pdf->Cell(60,6, lang('importe_1'),1);
                $pdf->Cell(130,6, formatImporte($boleta_array['importe_venc_1']) ,1);
                $pdf->Ln();   
                    
                $pdf->Cell(60,6, lang('vencimiento_2'),1);
                $pdf->Cell(130,6, formatDate($boleta_array['fecha_venc_2']) ,1);
                $pdf->Ln();
                    
                $pdf->Cell(60,6, lang('importe_2'),1);
                $pdf->Cell(130,6, formatImporte($boleta_array['importe_venc_2']) ,1);
                $pdf->Ln();                 
                
                // Codigos de barra por hoja                     
                if($cantidad == 1)
                {
                    $code128    = 65;
                    $setxn      = 80;
                }else if($cantidad == 2)
                {
                    $code128    = 160;
                    $setxn      = 175;
                }else
                {
                    $code128    = 255;
                    $setxn      = 270;
                }
                
                $pdf->Code128(50 , $code128, $boleta_array['codigo_barra'], 120, 15);
                $pdf->SetXY(55, $setxn);
                $pdf->Write(5, $boleta_array['codigo_barra']);    
                
                // Saltos de linea    
                $pdf->Ln(); 
                $pdf->Ln();
                $pdf->Ln();
                $pdf->Ln();
                $pdf->Ln();
                                
                // Lineas para dividir las boletas
                $pdf->Line(0, 95, 210, 95);
                // Segunda linea, solo cuando hay mas de un registro por hoja
                if($cantidad > 1)
                {
                    $pdf->Line(0, 190, 210, 190);    
                }                
                
                // Seteo de variables par los salto de pagina    
                if($cantidad != 0 && $cantidad % $cantidad_x_hoja == 0 )
                {
                    $_div  = 1;
                }       
            }
        }            
        
        // Armado del nombre del archivo
        $nombre_archivo = '';
        
        if($_lote['nro_cuota'] != 0)
        {
             $nombre_archivo .= $_lote['nro_cuota'].'-'; 
        }
        
        if($_lote['nombre'] != '')
        {
            $nombre_archivo .= $_lote['nombre'];
        }
        
        if($nombre_archivo == '')
        {
            $nombre_archivo .= date('Ymd');
        }
        
        $nombre_archivo = preg_replace('([^A-Za-z0-9--])', '', $nombre_archivo);
        
        $pdf->Output($nombre_archivo.'.pdf','I');
            
        unset($pdf);
    }

	
/*--------------------------------------------------------------------------------	
 			Administración de boletas: tabla
 --------------------------------------------------------------------------------*/	
	
	function table($id_afiliado = NULL)
	{
		$this->load->library('Graficos');
		if($id_afiliado === NULL)
		{
			$db['id_afiliado']	= 0;	
			$db['registros']	= $this->m_boletas->getBoletas($this->_session_data['id_ente']);
			$db['pagos']		= $this->m_pagos_boletas->getPagos($this->_config['boletas_pagos']*-1);
		}else if ($id_afiliado == 0)
		{
			$db['mensaje']		= 'update_ok';
			$db['id_afiliado']	= 0;
			$db['registros']	= $this->m_boletas->getBoletas($this->_session_data['id_ente']);
			$db['pagos']		= $this->m_pagos_boletas->getPagos($this->_config['boletas_pagos']*-1);
		}else
		{
			$db['id_afiliado']	= $id_afiliado;
			$db['registros']	= $this->m_boletas->getBoletas($this->_session_data['id_ente'], $id_afiliado);
			$db['pagos']		= $this->m_pagos_boletas->getPagos($this->_config['boletas_pagos']*-1, $id_afiliado);
			$db['afiliados']	= $this->m_afiliados->getRegistros($id_afiliado);
		}
			
		$this->armar_vista('table', $db);
	}
	
/*--------------------------------------------------------------------------------	
 			Administración de boletas: ajax para armar tabla
 --------------------------------------------------------------------------------*/	
 	
	public function ajax($id_afiliado = NULL){
		if($id_afiliado == NULL){
			$registros	= $this->m_boletas->getBoletas($this->_session_data['id_ente']);
		}else{
			$registros	= $this->m_boletas->getBoletas($this->_session_data['id_ente'], $id_afiliado);
		}
		$json = "";
		if($registros){
			$btn_class 		= "'btn btn-default'";
			$btn_classxs	= "'btn btn-default btn-xs'";
			$icon_class		= "'fa fa-pencil-square-o'";
			$icon_print		= "'fa fa-print'";
			$icon_bolafi	= "'fa fa-file-text-o'";
			$title_modificar= "'Ver'";
			$title_imprimir	= "'Imprimir'";
            $blank          = "'_blank'";
			$title_bolafi	= "'Ver boletas afiliado'";
			$title_afi 		= "'Ver afiliado'";
			$url_bol_i 		= "'".base_url()."index.php/".$this->_subject."/abm/";
			$url_afi_i 		= "'".base_url()."index.php/afiliados/abm/";
			$url_pri_i 		= "'".base_url()."index.php/".$this->_subject."/generar_impresion/";
			$url_bolafi_i 	= "'".base_url()."index.php/".$this->_subject."/table/";
			

			foreach ($registros as $row) {
				$url_bol_f = $row->id_boleta."'";
				$url_afi_f = $row->id_afiliado."'";
				$url_pri_f = $row->id_lote."/".$row->id_boleta."'";
				
				if(date('Y-m-d') > $row->fecha_venc_1 && $row->pago == 0){
					$registro['fecha_venc_1']	= setSpan(formatDate($row->fecha_venc_1), 'default');
					$registro['importe_venc_1']	= setSpan(formatImporte($row->importe_venc_1), 'default');
				}else{
					$registro['fecha_venc_1']	= formatDate($row->fecha_venc_1);
					$registro['importe_venc_1']	= formatImporte($row->importe_venc_1);
				}
								
				if(date('Y-m-d') > $row->fecha_venc_2 && $row->pago == 0){
					$registro['fecha_venc_2']	= setSpan(formatDate($row->fecha_venc_2), 'default');
					$registro['importe_venc_2']	= setSpan(formatImporte($row->importe_venc_2), 'default');
				}else{
					$registro['fecha_venc_2']	= formatDate($row->fecha_venc_2);
					$registro['importe_venc_2'] = formatImporte($row->importe_venc_2);
				}
                $registro['apellido'] = $row->apellido;    
				$registro['nombre'] = '<a title='.$title_afi.' href='.$url_afi_i.$url_afi_f.'>'.$row->nombre.'</a>';
				if($id_afiliado == NULL){
					$registro['nombre'] .= ' <a class='.$btn_classxs.' title='.$title_bolafi.' href='.$url_bolafi_i.$url_afi_f.'><i class='.$icon_bolafi.'></i></a>';
				}		
				$registro['codigo'] = $row->codigo_afiliado;
				if($row->eliminado == 1){
					$registro['estado'] = estadoPago(-1);
					$registro['buttons'] = "";	
				}else{
					$registro['estado'] = estadoPago($row->pago);
					$registro['buttons'] = '<a class='.$btn_class.' title='.$title_modificar.' href='.$url_bol_i.$url_bol_f.'><i class='.$icon_class.'></i></a>';
					$registro['buttons'] .= ' <a class='.$btn_class.' title='.$title_imprimir.' href='.$url_pri_i.$url_pri_f.' target='.$blank.'><i class='.$icon_print.'></i></a>';	
				}
				
		 		$json .= setJsonContent($registro);
			}
			
			$json = substr($json, 0, -2);
		}
		echo '{ "data": ['.$json.' ]  }';
	}
	
/*--------------------------------------------------------------------------------	
 			Administración de boletas: registro
 --------------------------------------------------------------------------------*/	
	
	function abm($id_boleta = NULL){
		if($this->input->post('id_boleta')){
			$this->m_boletas->delete($this->input->post('id_boleta'));
			redirect($this->_subject.'/table/0', 'refresh');
		}else{
			$db['registro']	= $this->m_boletas->getBoleta($id_boleta);
			$db['pago']		= $this->m_pagos_boletas->getRegistros($id_boleta, 'id_boleta');
			$db['id_boleta']= $id_boleta;
			
			$this->armar_vista('abm', $db);	
		}
	}
	
/*--------------------------------------------------------------------------------	
 			Administración de boletas: generación de PDF, no se usa
 --------------------------------------------------------------------------------*/	
	
	function pdf($id_lote = NULL, $id_boleta = NULL)
	{
		$this->load->library('PDFF');
		
		if($id_boleta != NULL){
			$db['boletas']		= $this->m_boletas->getBoletas($id_boleta);
		}else{
			$db['boletas']		= $this->m_boletas->getLote($id_lote, $this->_session_data['id_ente']);
		}
		
		$db['impresiones_campos'] = $this->m_impresiones_campos->getRegistros();
		$db['impresiones']		= $this->m_entes->getRegistros($this->_session_data['id_ente']);
		
		$this->load->view( $this->_subject.'/pdf', $db);
	}
	
/*--------------------------------------------------------------------------------	
 			Administración de boletas: generación de la imagen
 --------------------------------------------------------------------------------*/	
	
	function generacion_codigo($code)
	{
		$barcore		= $this->m_barcore->getRegistros();
		foreach ($barcore as $row) {
			$config = (array) $row;
		}
		
		$this->load->library('Barcores');
		$fontSize = 10;   					// GD1 in px ; GD2 in point
		$marge    = 10;   					// between barcode and hri in pixel
		$x        = $config['canvas_x'];	// barcode center
		$y        = $config['canvas_y'];	// barcode center
		$height   = $config['height'] ;		// barcode height in 1D ; module size in 2D
		$width    = $config['width'] ;		// barcode height in 1D ; not use in 2D
		$angle    = 0;   					// rotation in degrees : nb : non horizontable barcode might not be usable because of pixelisation
  		$type     = $config['tipo'] ;
	
		// configuracion de la imagen
		
		$im     = imagecreatetruecolor($config['size_x'], $config['size_y']);
		$black  = ImageColorAllocate($im,0x00,0x00,0x00);
		$white  = ImageColorAllocate($im,0xff,0xff,0xff);
		$red    = ImageColorAllocate($im,0xff,0x00,0x00);
		$blue   = ImageColorAllocate($im,0x00,0x00,0xff);
		imagefilledrectangle($im, 0, 0, $config['size_x'], $config['size_y'], $white);
  
		// configuracion del codigo de barra
		$data = Barcode::gd(
			$im, 
		  	$black, 
			$x, 
			$y, 
			$angle, 
			$type, 
			array('code'=>$code), 
			$width, 
			$height
		);

		// generacion de la imagen
		
  		header('Content-type: image/gif');
  		imagepng($im);
  		imagedestroy($im);
	}
}