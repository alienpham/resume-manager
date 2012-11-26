<?php
class Default_Model_Vacancy
{
	protected $_vacancy_id;
	protected $_company_name;
	protected $_job_title;
	protected $_min_salary;
	protected $_max_salary;
	protected $_priority;
	protected $_work_level;
	protected $_function;
	protected $_location;
	protected $_desc_reqs;
	protected $_created_date;
	protected $_updated_date;
    
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
	
	public function getVacancyId() {
		return $this->_vacancy_id;
	}
	public function setVacancyId($id) {
		$this->_vacancy_id = $id;
	}
	
	public function getCompanyName() {
		return $this->_company_name;
	}
	public function setCompanyName($company_name) {
		$this->_company_name = $company_name;
	}
		
	public function getJobTitle() {
		return $this->_job_title;
	}
	public function setJobTitle($job_title) {
		$this->_job_title = $job_title;
	}
	
	public function getMinSalary() {
		return $this->_min_salary;
	}
	public function setMinSalary($min_salary) {
		$this->_min_salary = $min_salary;
	}
	
	public function getMaxSalary() {
		return $this->_max_salary;
	}
	public function setMaxSalary($max_salary) {
		$this->_max_salary = $max_salary;
	}
	
 	public function setPriority($priority) {
        $this->_priority = $priority;
    }
    
	public function getPriority() {
        return $this->_max_salary;
    }
	
    public function getWorkLevel() {
            return $this->_work_level;
    }
    public function setWorkLevel($work_level) {
        $this->_work_level = $work_level;
    }
    
	public function getFunction() {
            return $this->_function;
    }
    
    public function setFunction($function) {
        $this->_function = $function;
    }
    
	public function getLocation() {
        return $this->_location;
    }
    
    public function setLocation($location) {
        $this->_location = $location;
    }
    
	public function getDescReqs() {
            return $this->_desc_reqs;
    }
    
    public function setDescReqs($desc_reqs) {
        $this->_desc_reqs = $desc_reqs;
    }
    
    public function getCreatedDate() {
            return $this->_created_date;
    }
    public function setCreatedDate($created_date) {
        $this->_created_date = $created_date;
    }
    
    public function getUpdatedDate() {
            return $this->_updated_date;
    }
    public function setUpdatedDate($updated_date) {
        $this->_updated_date = $updated_date;
    }
}
