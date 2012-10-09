<?php
class Company_Model_ComHasConsultantIncharge
{
	protected $_com_consultant_incharge_id;
	protected $_company_id;
	protected $_consultant_id;
	protected $_action_date;
	protected $_status;
    
	public function __construct(array $options = null)
    {
        if (is_array($options)) {
            $this->setOptions($options);
        }
    }
 
    public function __set($name, $value)
    {
        $method = 'set' . $name;
        if (('mapper' == $name) || !method_exists($this, $method)) {
           throw new Exception('Invalid page property');
        }
        $this->$method($value);
    }
 
    public function __get($name)
    {
        $method = 'get' . $name;
        if (('mapper' == $name) || !method_exists($this, $method)) {
            throw new Exception('Invalid page property');
        }
        return $this->$method();
    }
	
	public function setOptions(array $options)
    {
        $methods = get_class_methods($this);
        foreach ($options as $key => $value) {
            $method = 'set' . ucfirst($key);
            if (in_array($method, $methods)) {
                $this->$method($value);
            }
        }
        return $this;
    }
	
	public function getComConsultantInchargeId() {
		return $this->_com_consultant_incharge_id;
	}
	public function setComConsultantInchargeId($id) {
		$this->_com_consultant_incharge_id = $id;
	}
	
    public function getCompanyId() {
		return $this->_company_id;
	}
	public function setCompanyId($id) {
		$this->_company_id = $id;
	}
	
	public function getConsultantId() {
		return $this->_consultant_id;
	}
	public function setConsultantId($consultant_id) {
		$this->_consultant_id = $consultant_id;
	}
	
	public function getStatus() {
		return $this->_status;
	}
	public function setStatus($status) {
		$this->_status = $status;
	}
	
	public function getActionDate() {
		return $this->_action_date;
	}
	public function setActionDate($action_date) {
		$this->_action_date = $action_date;
	}
}
