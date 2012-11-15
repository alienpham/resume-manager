<?php
class Vacancy_Model_Vacancy
{
	protected $_vacancy_id;
	protected $_company_id;
	protected $_vacancy_code;
	protected $_job_title;
	
	protected $_no_of_vacancies;
	protected $_min_salary;
	protected $_max_salary;
	
	protected $_estimated_salary;
	protected $_work_level_id;
	protected $_public;
	
	protected $_status;
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
	
    public function getCompanyId() {
		return $this->_company_id;
	}
	public function setCompanyId($id) {
		$this->_company_id = $id;
	}
	
	public function getVacancyCode() {
		return $this->_vacancy_code;
	}
	public function setVacancyCode($vacancy_code) {
		$this->_vacancy_code = $vacancy_code;
	}
	
	public function getJobTitle() {
		return $this->_job_title;
	}
	public function setJobTitle($job_title) {
		$this->_job_title = $job_title;
	}
	
public function getNoOfVacancies() {
		return $this->_no_of_vacancies;
	}
	public function setNoOfVacancies($no_of_vacancies) {
		$this->_no_of_vacancies = $no_of_vacancies;
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
	
	public function getEstimatedSalary() {
			return $this->_estimated_salary;
	}
	public function setEstimatedSalary($estimated_salary) {
	    $this->_estimated_salary = $estimated_salary;
	}
	
    public function getWorkLevelId() {
            return $this->_work_level_id;
    }
    public function setWorkLevelId($work_level_id) {
        $this->_work_level_id = $work_level_id;
    }
    
    public function getPublic() {
            return $this->_public;
    }
    public function setPublic($public) {
        $this->_public = $public;
    }
    
	public function getStatus() {
            return $this->_status;
    }
    public function setStatus($status) {
        $this->_status = $status;
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
