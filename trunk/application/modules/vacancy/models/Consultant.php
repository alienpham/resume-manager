<?php
class Vacancy_Model_Consultant {
	const STATUS_ACTIVE		= 'Active';
	const STATUS_INACTIVE	= 'Inactive';
	const STATUS_DELETE		= 'Deleted';

	const TITLE_MR		= 'Mr.';
	const TITLE_MRS		= 'Mrs.';
	const TITLE_MS		= 'Ms.';

	protected $_consultant_id;
	protected $_title;
	protected $_full_name;
	protected $_user_name;
	protected $_job_title;
	protected $_email;
	protected $_phone;
	protected $_password;
	protected $_status;
	protected $_created_date;
	protected $_updated_date;

	/**
	 *
	 * Setter - setConsultantId
	 * @param int $consultantId
	 */
	public function setConsultantId($consultantId) {
		$this->_consultant_id = $consultantId;
	}

	/**
	 * Getter - getConsultantId
	 * @return int
	 */
	public function getConsultantId() {
		return $this->_consultant_id;
	}

	public function setTitle($title) {
		$this->_title = $title;
	}

	public function getTitle() {
		return $this->_title;
	}
	
    public function setPhone($phone) {
		$this->_phone = $phone;
	}

	public function getPhone() {
		return $this->_phone;
	}

	public function setFullName($fullName) {
		$this->_full_name = $fullName;
	}

	public function getFullName() {
		return $this->_full_name;
	}

	public function setJobTitle($jobTitle) {
		$this->_job_title = $jobTitle;
	}
    
    public function getJobTitle() {
		return $this->_job_title;
	}
	
    public function getUserName() {
		return $this->_user_name;
	}

	public function setUserName($username) {
		$this->_user_name = $username;
	}

    public function setEmail($email) {
		$this->_email = $email;
	}

	public function getEmail() {
		return $this->_email;
	}

	public function setPassword($password) {
		$this->_password = $password;
	}

	public function getPassword() {
		return $this->_password;
	}

	public function setStatus($status) {
		$this->_status = $status;
	}

	public function getStatus() {
		return $this->_status;
	}

	public function setCreateDate($createDate) {
		$this->_created_date = $createDate;
	}

	public function getCreateDate() {
		return $this->_created_date;
	}

	public function setUpdateDate($updateDate) {
		$this->_updated_date = $updateDate;
	}

	public function getUpdateDate() {
		return $this->_updated_date;
	}

	/**
	 *
	 * Default constructor of class model
	 * @param $options
	 */
	public function __construct(array $options = null)
	{
		if (is_array($options)) {
			$this->setOptions($options);
		}
	}

	/**
	 *
	 * Setter - Magic method
	 * @param string $property
	 * @param mixed $value
	 */
	public function __set($name, $value)
	{
		$method = 'set' . $name;
		if (('mapper' == $name) || !method_exists($this, $method)) {
			throw new Exception('Invalid page property');
		}
		$this->$method($value);
	}

	/**
	 *
	 * Getter - Magic method
	 * @param string $property
	 */
	public function __get($name)
	{
		$method = 'get' . $name;
		if (('mapper' == $name) || !method_exists($this, $method)) {
			throw new Exception('Invalid page property');
		}
		return $this->$method();
	}

	/**
	 *
	 * Set options
	 * @param $options
	 */
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
}