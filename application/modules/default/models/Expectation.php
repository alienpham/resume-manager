<?php
class Default_Model_Expectation
{
	protected $_res_expectation_id;
	protected $_resume_id;
	protected $_estimated_salary_to;
	protected $_estimated_salary_from;
	protected $_current_salary;
	    
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
	
	public function getResumeId() {
		return $this->_resume_id;
	}
	public function setResumeId($id) {
		$this->_resume_id = $id;
	}
	
	public function getResExpectationId() {
		return $this->_res_expectation_id;
	}
	public function setResExpectationId($id) {
		$this->_res_expectation_id = $id;
	}
	
	public function getEstimatedSalaryTo() {
		return $this->_estimated_salary_to;
	}
	public function setEstimatedSalaryTo($salary) {
		$this->_estimated_salary_to = $salary;
	}
	
	public function getEstimatedSalaryFrom() {
		return $this->_estimated_salary_from;
	}
	public function setEstimatedSalaryFrom($salary) {
		$this->_estimated_salary_from = $salary;
	}

	public function getCurrentSalary() {
		return $this->_current_salary;
	}
	public function setCurrentSalary($salary) {
		$this->_current_salary = $salary;
	}
}