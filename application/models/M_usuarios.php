<?php 
class m_usuarios extends MY_Model {
		
	protected $_tablename	= 'usuarios';
	protected $_id_table	= 'id_usuario';
	protected $_order		= 'usuario';
	protected $_relation	= array(
		'id_perfil' => array(
			'table'		=> 'perfiles',
			'subjet'	=> 'perfil'
		),
	);
		
	function __construct(){
		parent::__construct(
			$tablename		= $this->_tablename, 
			$id_table		= $this->_id_table, 
			$order			= $this->_order,
			$relation		= $this->_relation
		);
	}
	
/*--------------------------------------------------------------------------------	
 			Comprueba si usuario y pass coinciden
 --------------------------------------------------------------------------------*/		
	
	function login($username, $password, $id_perfil){
		$password = encrypt($password);
		
		$sql = 
		"SELECT 
			$this->_id_table, 
			usuario,
			id_perfil,
			date_add,
			eliminado
		FROM 
			$this->_tablename
		WHERE
			usuario	= '$username' AND 
			pass	= '$password' AND
			id_perfil = '$id_perfil'";
		
		return $this->getQuery($sql);
	}
	
/*--------------------------------------------------------------------------------	
 			Guarda registro del login del usuario
 --------------------------------------------------------------------------------*/		
	
	function log_login(){
		$session_data		= $this->session->userdata('logged_in');
		$this->load->library('user_agent');
		if ($this->agent->is_browser()){
			$agent = $this->agent->browser();
		}else if ($this->agent->is_robot()){
	    	$agent = $this->agent->robot();
		}else if ($this->agent->is_mobile()) {
	    	$agent = $this->agent->mobile();
		} else {
	    	$agent = 'Unidentified User Agent';
		}
		
		$arreglo_campos = array(
			'last_login'	=> date('Y/m/d H:i:s'),
			'ip_login'		=> $this->input->ip_address(),
			'navegador'		=> $agent,
			'sistema'		=> $this->agent->platform(),
		);
		
		$this->db->where($this->_id_table, $session_data[$this->_id_table]);
		$this->db->update($this->_tablename, $arreglo_campos);
	}
	
/*--------------------------------------------------------------------------------	
 			Elimina todas las relaciones entre un usuario y los entes
 --------------------------------------------------------------------------------*/		
	
	function truncateEntes($id_usuario){
		$sql = 
		"DELETE FROM 
			entes_usuarios
		WHERE
			entes_usuarios.id_usuario = '$id_usuario'";
			
		$this->db->query($sql);
	}
	
/*--------------------------------------------------------------------------------	
 			Genera la relacion ente usuario
 --------------------------------------------------------------------------------*/		

	function setEntes($id_ente, $id_usuario){
		$arreglo = array(
			'id_ente'		=> $id_ente,
			'id_usuario'	=> $id_usuario
		);
		
		$arreglo = $this->getExtraField($arreglo);		
		
		$this->db->insert('entes_usuarios', $arreglo);
	}
	
/*--------------------------------------------------------------------------------	
 			Controla que el usuario no exista
 --------------------------------------------------------------------------------*/		
	
	function control_usuarios($usuario, $id_usuario = NULL){
		$sql = 
		"SELECT
			*
		FROM
			$this->_tablename
		WHERE
			$this->_tablename.usuario = '$usuario'"; 	
			
		if($id_usuario != NULL){
			$sql .= "AND $this->_tablename.$this->_id_table != '$id_usuario'";
		}
		
		$query = $this->db->query($sql);
		
		if($query->num_rows() > 0){
			return 0;
		} else {
			return 1;
		}
	}
} 
?>