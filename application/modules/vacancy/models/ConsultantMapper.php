<?php
class Vacancy_Model_ConsultantMapper {
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
			$this->setDbTable('Vacancy_Model_DbTable_Consultant');
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
	public function save(Vacancy_Model_Consultant $obj)
	{
		$data = array();

		return $this->getDbTable()->insert($data);
	}

	/**
	 *
	 * Find by ID
	 * @param int $id
	 * @param Vacancy_Model_Consultant $consultant
	 */
	public function find($id, Vacancy_Model_Consultant $consultant)
	{
		$result = $this->getDbTable()->find($id);

		if (0 == count($result)) {
			return;
		}
		$row = $result->current();

		$consultant->setResumeId($row->resume_id)
		->setResumeCode($row->resume_code)
		->setFullName($row->full_name)
		->setBirthday($row->birthday)
		->setGender($row->gender)
		->setMaritalStatus($row->marital_status)
		->setStatus($row->status)
		->setEmail1($row->email_1)
		->setEmail2($row->email_2)
		->setMobile1($row->mobile_1)
		->setMobile2($row->mobile_2)
		->setTel($row->tel)
		->setAddress($row->address)
		->setPrivinceId($row->province_id)
		->setNationalityId($row->nationality_id)
		->setViewCount($row->view_count)
		->setCreatedDate($row->created_date)
		->setUpdatedDate($row->updated_date);
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

		$entries = array();

		foreach ($resultSet as $row) {
			$entry = new Vacancy_Model_Consultant();
			$entry->setResumeId($row->resume_id)
			->setResumeCode($row->resume_code)
			->setFullName($row->full_name)
			->setBirthday($row->birthday)
			->setGender($row->gender)
			->setMaritalStatus($row->marital_status)
			->setStatus($row->status)
			->setEmail1($row->email_1)
			->setEmail2($row->email_2)
			->setMobile1($row->mobile_1)
			->setMobile2($row->mobile_2)
			->setTel($row->tel)
			->setAddress($row->address)
			->setPrivinceId($row->province_id)
			->setNationalityId($row->nationality_id)
			->setViewCount($row->view_count)
			->setCreatedDate($row->created_date)
			->setUpdatedDate($row->updated_date);

			$entries[] = $entry;
		}
		return $entries;
	}
}