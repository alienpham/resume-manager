<?php
class Vacancy_Model_VaHasConsultant
{
	protected $_va_consultant_id;
	protected $_consultant_id;
	protected $_vacancy_id;
	protected $_inchange_type;
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
	
	public function getVaConsultantId() {
		return $this->_va_consultant_id;
	}
	public function setVaConsultantId($id) {
		$this->_va_consultant_id = $id;
	}
	
    public function getConsultantId() {
		return $this->_consultant_id;
	}
	public function setConsultantId($consultant_id) {
		$this->_consultant_id = $consultant_id;
	}
	
	public function getVacancyId() {
		return $this->_vacancy_id;
	}
	public function setVacancyId($vacancy_id) {
		$this->_vacancy_id = $vacancy_id;
	}
	
	public function getInchangeType() {
		return $this->_inchange_type;
	}
	public function setInchangeType($inchange_type) {
		$this->_inchange_type = $inchange_type;
	}
	
	public function getStatus() {
		return $this->_status;
	}
	public function setStatus($status) {
		$this->_status = $status;
	}
}
