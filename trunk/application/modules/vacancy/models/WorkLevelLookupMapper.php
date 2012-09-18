<?php
class Vacancy_Model_WorkLevelLookupMapper {
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
			$this->setDbTable('Vacancy_Model_DbTable_WorkLevelLookup');
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
	 * @param Vacancy_Model_WorkLevelLookup $obj
	 */
	public function save(Vacancy_Model_WorkLevelLookup $obj)
	{
		$data = array(
			'work_level_id' => $obj->getWorkLevelId(),
			'name' => $obj->getName(),
			'sort_order' => $obj->getSortOrder()
		);

		return $this->getDbTable()->insert($data);
	}

	/**
	 *
	 * Find by ID
	 * @param int $id
	 * @param Vacancy_Model_WorkLevelLookup $workLevelLookup
	 */
	public function find($id, Vacancy_Model_WorkLevelLookup $workLevelLookup)
	{
		$result = $this->getDbTable()->find($id);

		if (0 == count($result)) {
			return null;
		}
		$row = $result->current();

		$workLevelLookup->setWorkLevelId($row->work_level_id)
						->setName($row->name)
						->setSortOrder($row->sort_order);
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
			$entry = new Vacancy_Model_WorkLevelLookup();
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