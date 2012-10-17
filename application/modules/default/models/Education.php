<?php
class Default_Model_Education
{
	protected $_res_education_id;
	protected $_resume_id;
	protected $_start_date;
	protected $_end_date;
	protected $_school_name;
	protected $_program_name;
	protected $_program_info;
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
	
	public function getEducationId() {
		return $this->_res_education_id;
	}
	public function setEducationId($id) {
		$this->_res_education_id = $id;
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
	
	public function getSchoolName() {
		return $this->_school_name;
	}
	public function setSchoolName($school) {
		$this->_school_name = $school;
	}
	
	public function getProgramName() {
		return $this->_program_name;
	}
	public function setProgramName($program) {
		$this->_program_name = $program;
	}
	
	public function getProgramInfo() {
		return $this->_program_info;
	}
	public function setProgramInfo($info) {
		$this->_program_info = $info;
	}
	
	public function getSortOrder() {
		return $this->_sort_order;
	}
	public function setSortOrder($order) {
		$this->_sort_order = $order;
	}
}