<?php
class Vacancy_Model_VaHasLocation
{
	protected $_va_location_id;
	protected $_province_id;
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
	
	public function getVaLocationId() {
		return $this->_va_location_id;
	}
	public function setVaLocationId($id) {
		$this->_va_location_id = $id;
	}
	
    public function getProvinceId() {
		return $this->_province_id;
	}
	public function setProvinceId($province_id) {
		$this->_province_id = $province_id;
	}
	
	public function getVacancyId() {
		return $this->_vacancy_id;
	}
	public function setVacancyId($vacancy_id) {
		$this->_vacancy_id = $vacancy_id;
	}
}
