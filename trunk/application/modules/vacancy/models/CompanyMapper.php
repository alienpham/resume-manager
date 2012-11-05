<?php
class Vacancy_Model_CompanyMapper {
	protected $_dbTable;

	/**
	 *
	 * Set table object
	 * @param object $dbTable
	 * @throws Exception
	 */
	public function setDbTable ($dbTable)
	{
		if (is_string($dbTable)) {
			$dbTable = new $dbTable();
		}
		if (! $dbTable instanceof Zend_Db_Table_Abstract) {
			throw new Exception('Invalid table data gateway provided');
		}
		$this->_dbTable = $dbTable;
		return $this;
	}

	/**
	 *
	 * To get table object
	 *
	 * @return object
	 */
	public function getDbTable ()
	{
		if (null === $this->_dbTable) {
			$this->setDbTable('Vacancy_Model_DbTable_Company');
		}
		return $this->_dbTable;
	}

	/**
	 *
	 * To update data
	 * @param array $data
	 * @param mixed $where
	 */
	public function update($data, $where) {
		$this->getDbTable ()->update ( $data, $where );
	}

	/**
	 *
	 * On Save Action
	 * @param Vacancy_Model_Consultant $obj
	 */
	public function save(Vacancy_Model_Company $obj)
	{
		$data = array(

		);

		return $this->getDbTable()->insert($data);
	}

	/**
	 *
	 * Find by ID
	 * @param int $id
	 * @param Vacancy_Model_Consultant $consultant
	 */
	public function find($id, Vacancy_Model_Company $company)
	{
		$result = $this->getDbTable()->find($id);

		if (0 == count($result)) {
			return;
		}

		return $result;
	}

	/**
	 *
	 * Fetch all rows
	 * @param mixed $where
	 * @param mixed $orderby
	 */
	public function fetchAll ($where = null, $orderby = null)
	{
		$resultSet = $this->getDbTable()->fetchAll($where, $orderby);

		return $resultSet;
	}

	public function getDisplaySalaries() {
		$company = new Vacancy_Model_Company();
		return $company->getDisplaySalaryConfig();
	}

	/**
	 *
	 * To fetch all active consultants
	 *
	 * @return array objects
	 */
	public function getCompanies() {
		$db = $this->getDbTable();

		//$db->getAdapter()->getProfiler()->setEnabled(true);

		$select = $db->select()->from(
			'company AS c',
			array(
				'company_id',
				'company_code',
				'full_name_en',
				'short_name_en',
				'full_name_vn',
				'short_name_vn',
				'busines_type_id',
				'industry_id',
				'tel',
				'fax',
				'email',
				'address',
				'website',
				'status'
			)
		)
		->where('c.status=?', Vacancy_Model_Company::ACTIVE_STATUS)
		->order('c.full_name_en ASC')
		->order('c.full_name_vn ASC');

		$rows = $db->fetchAll($select);

		//print_r($db->getAdapter()->getProfiler()->getLastQueryProfile()->getQuery());
		//$db->getAdapter()->getProfiler()->setEnabled(false);
		//exit;

		return $rows;
	}
}