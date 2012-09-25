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
		$data = array(
			'consultant_id' => $obj->getConsultantId(),
			'title' => $obj->getTitle(),
			'full_name' => $obj->getFullName(),
			'abbreviated_name' => $obj->getAbbreviatedName(),
			'job_title' => $obj->getJobTitle(),
			'office_phone' => $obj->getOfficePhone(),
			'email' => $obj->getEmail(),
			'password' => $obj->getPassword(),
			'join_date' => $obj->getJoinDate(),
			'resign_date' => $obj->getResignDate(),
			'status' => $obj->getStatus(),
			'created_date' => $obj->getCreateDate(),
			'updated_date' => $obj->getUpdateDate(),
		);

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

		$entry->setConsultantId($row->consultant_id)
		->setTitle($row->title)
		->setFullName($row->full_name)
		->setAbbreviatedName($row->abbreviated_name)
		->setJobTitle($row->job_title)
		->setOfficePhone($row->office_phone)
		->setEmail($row->email)
		->setPassword($row->password)
		->setJoinDate($row->join_date)
		->setResignDate($row->resign_date)
		->setStatus($row->status)
		->setCreateDate($row->created_date)
		->setUpdateDate($row->updated_date);
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
			$entry->setConsultantId($row->consultant_id)
			->setTitle($row->title)
			->setFullName($row->full_name)
			->setAbbreviatedName($row->abbreviated_name)
			->setJobTitle($row->job_title)
			->setOfficePhone($row->office_phone)
			->setEmail($row->email)
			->setPassword($row->password)
			->setJoinDate($row->join_date)
			->setResignDate($row->resign_date)
			->setStatus($row->status)
			->setCreateDate($row->created_date)
			->setUpdateDate($row->updated_date);

			$entries[] = $entry;
		}
		return $entries;
	}

	/**
	 *
	 * To fetch all active consultants
	 *
	 * @return array objects
	 */
	public function getColsultants() {
		$db = $this->getDbTable();

		//$db->getAdapter()->getProfiler()->setEnabled(true);

		$select = $db->select()->setIntegrityCheck(false)->from(
			'consultant AS c',
			array(
				'consultant_id',
				'title',
				'full_name',
				'abbreviated_name',
				'job_title',
				'office_phone',
				'email',
				'join_date',
				'resign_date',
				'status'
			)
		)
		->join('consultant_has_role AS cr', 'c.consultant_id=cr.consultant_id', array())
		->join('role_lookup AS rl', 'cr.role_id=rl.role_id AND rl.role_type=\'' . Vacancy_Model_RoleLookup::ROLE_TYPE_CONSULTANT . '\'', array('role_type', 'department_id', 'name', 'level'))
		->where('c.status=?', Vacancy_Model_Consultant::STATUS_ACTIVE)
		->order('c.full_name ASC');

		$rows = $db->fetchAll($select);

		//print_r($db->getAdapter()->getProfiler()->getLastQueryProfile()->getQuery());
		//$db->getAdapter()->getProfiler()->setEnabled(false);
		//exit;

		return $rows;
	}
}