<?php
class Vacancy_Model_VaDetails
{
	protected $_va_va_details_id;
	protected $_desc_reqs;
	protected $_vacancy_id;
    
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
	
	public function getVaVaDetailsId() {
		return $this->_va_va_details_id;
	}
	public function setVaVaDetailsId($id) {
		$this->_va_va_details_id = $id;
	}
	
    public function getDescReqs() {
		return $this->_desc_reqs;
	}
	public function setDescReqs($desc_reqs) {
		$this->_desc_reqs = $desc_reqs;
	}
	
	public function getVacancyId() {
		return $this->_vacancy_id;
	}
	public function setVacancyId($vacancy_id) {
		$this->_vacancy_id = $vacancy_id;
	}
}
