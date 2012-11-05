<?php
class Vacancy_Model_Company {
	const ACTIVE_STATUS = 'Active';
	const DELETE_STATUE = 'Deleted';

	protected $_DISPLAY_SALARY_CONFIG = array(
		'Negotiable','Around','Up to','Above','Range'
	);

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

	public function getDisplaySalaryConfig() {
		return $this->_DISPLAY_SALARY_CONFIG;
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