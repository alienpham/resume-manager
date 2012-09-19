<?php
class Default_Model_Experience
{
	protected $_experience_id;
	protected $_resume_id;
	protected $_start_date;
	protected $_end_date;
	protected $_job_title;
	protected $_company_name;
	protected $_info;
	protected $_sort_order;
    
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
	
	public function getId() {
		return $this->_experience_id;
	}
	public function setId($id) {
		$this->_experience_id = $id;
	}
	
	public function getStartDate() {
		return $this->_start_date;
	}
	public function setStartDate($date) {
		$this->_start_date = $date;
	}
	
	public function getEndDate() {
		return $this->_end_date;
	}
	public function setEndDate($date) {
		$this->_end_date = $date;
	}
	
	public function getJobTitle() {
		return $this->_job_title;
	}
	public function setJobTitle($job) {
		$this->_job_title = $job;
	}
	
	public function getCompanyName() {
		return $this->_company_name;
	}
	public function setCompanyName($company) {
		$this->_company_name = $company;
	}
	
	public function getInfo() {
		return $this->_info;
	}
	public function setInfo($info) {
		$this->_info = $info;
	}
	
	public function getSortOrder() {
		return $this->_sort_order;
	}
	public function setSortOrder($order) {
		$this->_sort_order = $order;
	}
}