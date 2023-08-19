<?php
if (!defined("ROOT_PATH"))
{
	header("HTTP/1.1 403 Forbidden");
	exit;
}
class pjAdminClients extends pjAdmin
{
	public function pjActionCheckEmail()
	{
		$this->setAjax(true);
	
		if ($this->isXHR())
		{
			if (!$this->_get->toString('c_email'))
			{
				echo 'false';
				exit;
			}
			$pjClientModel = pjClientModel::factory()
			->join("pjAuthUser", 't2.id=t1.foreign_id', 'left outer')
			->where('t2.email', $this->_get->toString('c_email'));
			if ($this->_get->toInt('id'))
			{
			    $pjClientModel->where('t1.id !=', $this->_get->toInt('id'));
			}
			echo $pjClientModel->findCount()->getData() == 0 ? 'true' : 'false';
		}
		exit;
	}
	
	public function pjActionCreate()
	{
	    $this->checkLogin();
	    if (!pjAuth::factory()->hasAccess())
	    {
	        $this->sendForbidden();
	        return;
	    }
	    if (self::isPost() && $this->_post->toInt('client_create'))
	    {
	        $post = $this->_post->raw();
	        if($this->_post->check('status'))
	        {
	            $post['status'] = 'T';
	        }else{
	            $post['status'] = 'F';
	        }
	        $post['locale_id'] = $this->getLocaleId();
	        $response = pjFrontClient::init($post)->createClient();
	        if($response['status'] == 'OK')
	        {
	            $err = 'AC03';
	        }else{
	            $err = 'AC04';
	        }
	        pjUtil::redirect($_SERVER['PHP_SELF'] . "?controller=pjAdminClients&action=pjActionIndex&err=$err");
	    }
	    if (self::isGet())
	    {
	        $country_arr = pjBaseCountryModel::factory()
	        ->select('t1.id, t2.content AS country_title')
	        ->join('pjBaseMultiLang', "t2.model='pjBaseCountry' AND t2.foreign_id=t1.id AND t2.field='name' AND t2.locale='".$this->getLocaleId()."'", 'left outer')
	        ->where('status', 'T')
	        ->orderBy('`country_title` ASC')->findAll()->getData();
	        $this->set('country_arr', $country_arr);
	        
	        $this->appendCss('bootstrap-chosen.css', PJ_THIRD_PARTY_PATH . 'chosen/');
	        $this->appendJs('chosen.jquery.js', PJ_THIRD_PARTY_PATH . 'chosen/');
	        $this->appendJs('jquery.validate.min.js', PJ_THIRD_PARTY_PATH . 'validate/');
	        $this->appendJs('pjAdminClients.js');
	    }
	}
	
	public function pjActionDeleteClient()
	{
		$this->setAjax(true);
	
		if (!$this->isXHR())
		{
		    self::jsonResponse(array('status' => 'ERR', 'code' => 100, 'text' => 'Missing headers.'));
		}
		if (!self::isPost())
		{
		    self::jsonResponse(array('status' => 'ERR', 'code' => 101, 'text' => 'HTTP method not allowed.'));
		}
		if (!pjAuth::factory()->hasAccess())
		{
		    self::jsonResponse(array('status' => 'ERR', 'code' => 102, 'text' => 'Access denied.'));
		}
		if (!($this->_get->toInt('id')))
		{
		    self::jsonResponse(array('status' => 'ERR', 'code' => 103, 'text' => 'Missing, empty or invalid parameters.'));
		}
		$pjClientModel = pjClientModel::factory();
		$client = $pjClientModel->find($this->_get->toInt('id'))->getData();
		if (!$pjClientModel->reset()->set('id', $this->_get->toInt('id'))->erase()->getAffectedRows())
		{
		    self::jsonResponse(array('status' => 'ERR', 'code' => 105, 'text' => 'Client has not been deleted.'));
		}
		pjAuthUserModel::factory()->set('id', $client['foreign_id'])->erase();
		self::jsonResponse(array('status' => 'OK', 'code' => 200, 'text' => 'Client has been deleted'));
		exit;
	}
	
	public function pjActionDeleteClientBulk()
	{
	    $this->setAjax(true);
	    if (!$this->isXHR())
	    {
	        self::jsonResponse(array('status' => 'ERR', 'code' => 100, 'text' => 'Missing headers.'));
	    }
	    if (!self::isPost())
	    {
	        self::jsonResponse(array('status' => 'ERR', 'code' => 101, 'text' => 'HTTP method not allowed.'));
	    }
	    if (!pjAuth::factory()->hasAccess())
	    {
	        self::jsonResponse(array('status' => 'ERR', 'code' => 102, 'text' => 'Access denied.'));
	    }
	    if (!$this->_post->has('record'))
	    {
	        self::jsonResponse(array('status' => 'ERR', 'code' => 103, 'text' => 'Missing, empty or invalid parameters.'));
	    }
	    $record = $this->_post->toArray('record');
	    if (empty($record))
	    {
	        self::jsonResponse(array('status' => 'ERR', 'code' => 104, 'text' => 'Missing, empty or invalid parameters.'));
	    }
	    $pjClientModel = pjClientModel::factory();
	    $foreign_ids = $pjClientModel->whereIn('id', $record)->findAll()->getDataPair(null, 'foreign_id');
	    $pjClientModel->reset()->whereIn('id', $record)->eraseAll();
	    if(!empty($foreign_ids))
	    {
	        pjAuthUserModel::factory()
	        ->where('role_id', 3)
	        ->whereIn('id', $foreign_ids)
	        ->eraseAll();
	    }
	    self::jsonResponse(array('status' => 'OK', 'code' => 200, 'text' => 'Client(s) has been deleted.'));
		exit;
	}
	
	public function pjActionExportClient()
	{
	    $this->checkLogin();
	    if (!pjAuth::factory()->hasAccess())
	    {
	        $this->sendForbidden();
	        return;
	    }
	    
	    $record = $this->_post->toArray('record');
	    if (count($record))
	    {
	        $arr = pjClientModel::factory()
	        ->select("t1.*, t2.email as c_email, t2.name as c_name, t2.phone as c_phone")
	        ->join("pjAuthUser", 't2.id=t1.foreign_id', 'left outer')
	        ->whereIn('id', $record)->findAll()->getData();
	        $csv = new pjCSV();
	        $csv
	        ->setHeader(true)
	        ->setName("Clients-".time().".csv")
	        ->process($arr)
	        ->download();
	    }
	    exit;
	}
	
	public function pjActionGetClient()
	{
		$this->setAjax(true);
	
		if ($this->isXHR())
		{
		    $pjClientModel = pjClientModel::factory()->join('pjAuthUser', 't2.id=t1.foreign_id', 'left outer');
			
			if ($q = $this->_get->toString('q'))
			{
				$pjClientModel->where("(t2.email LIKE '%$q%' OR t2.name LIKE '%$q%')");
			}
			if ($this->_get->toString('status'))
			{
			    $status = $this->_get->toString('status');
			    if(in_array($status, array('T', 'F')))
			    {
			        $pjClientModel->where('t2.status', $status);
			    }
			}
			$column = 'c_name';
			$direction = 'ASC';
			if ($this->_get->toString('column') && in_array(strtoupper($this->_get->toString('direction')), array('ASC', 'DESC')))
			{
			    $column = $this->_get->toString('column');
			    $direction = strtoupper($this->_get->toString('direction'));
			}

			$total = $pjClientModel->findCount()->getData();
			$rowCount = $this->_get->toInt('rowCount') ?: 10;
			$pages = ceil($total / $rowCount);
			$page = $this->_get->toInt('page') ?: 1;
			$offset = ((int) $page - 1) * $rowCount;
			if ($page > $pages)
			{
				$page = $pages;
			}

			$data = $pjClientModel
				->select("t1.id, t2.email AS c_email, t2.name AS c_name, t2.status, (SELECT COUNT(TO.client_id) FROM `".pjOrderModel::factory()->getTable()."` AS `TO` WHERE `TO`.client_id=t1.id) AS cnt_orders")
				->orderBy("$column $direction")
				->limit($rowCount, $offset)
				->findAll()
				->getData();
			$data = pjSanitize::clean($data);
			
			pjAppController::jsonResponse(compact('data', 'total', 'pages', 'page', 'rowCount', 'column', 'direction'));
		}
		exit;
	}
	
	public function pjActionIndex()
	{
	    $this->checkLogin();
	    if (!pjAuth::factory()->hasAccess())
	    {
	        $this->sendForbidden();
	        return;
	    }
	    $this->appendJs('jquery.datagrid.js', PJ_FRAMEWORK_LIBS_PATH . 'pj/js/');
	    $this->appendJs('pjAdminClients.js');
	}
	
	public function pjActionSaveClient()
	{
		$this->setAjax(true);
	
		if (!$this->isXHR())
		{
		    self::jsonResponse(array('status' => 'ERR', 'code' => 100, 'text' => 'Missing headers.'));
		}
		if (!self::isPost())
		{
		    self::jsonResponse(array('status' => 'ERR', 'code' => 101, 'text' => 'HTTP method not allowed.'));
		}
		$params = array(
		    'id' => $this->_get->toInt('id'),
		    'column' => $this->_post->toString('column'),
		    'value' => $this->_post->toString('value'),
		);
		if (!(isset($params['id'], $params['column'], $params['value'])
		    && pjValidation::pjActionNumeric($params['id'])
		    && pjValidation::pjActionNotEmpty($params['column'])))
		{
		    self::jsonResponse(array('status' => 'ERR', 'code' => 102, 'text' => 'Missing, empty or invalid parameters.'));
		}
		pjClientModel::factory()->where('id', $params['id'])->limit(1)->modifyAll(array($params['column'] => $params['value']));
		if(in_array($params['column'], array('status', 'c_email')))
		{
		    $client = pjClientModel::factory()->find($params['id'])->getData();
		    $params['id'] = $client['foreign_id'];
		    if($params['column'] == 'c_email')
		    {
		        $params['column'] = 'email';
		    }
		    pjAuth::init($params)->updateUser();
		}
		self::jsonResponse(array('status' => 'OK', 'code' => 200, 'text' => 'Client has been updated!'));
		exit;
	}
	
	public function pjActionStatusClient()
	{
		$this->setAjax(true);
		if (!$this->isXHR())
		{
		    self::jsonResponse(array('status' => 'ERR', 'code' => 100, 'text' => 'Missing headers.'));
		}
		if (!self::isPost())
		{
		    self::jsonResponse(array('status' => 'ERR', 'code' => 101, 'text' => 'HTTP method not allowed.'));
		}
		if (!pjAuth::factory()->hasAccess())
		{
		    self::jsonResponse(array('status' => 'ERR', 'code' => 102, 'text' => 'Access denied.'));
		}
		$record = $this->_post->toArray('record');
		if (empty($record))
		{
		    self::jsonResponse(array('status' => 'ERR', 'code' => 103, 'text' => 'Missing, empty or invalid parameters.'));
		}
		$foreign_ids = pjClientModel::factory()->whereIn('id', $record)->findAll()->getDataPair(null, 'foreign_id');
		if(!empty($foreign_ids))
		{
		    pjAuthUserModel::factory()
		    ->whereIn('id', $foreign_ids)
		    ->where('id !=', 1)
		    ->modifyAll(array(
		        'status' => ":IF(`status`='F','T','F')"
		    ));
		}
		self::jsonResponse(array('status' => 'OK', 'code' => 200, 'text' => 'Client status has been updated.'));
		exit;
	}
	
	public function pjActionUpdate()
	{
	    $this->checkLogin();
	    if (!pjAuth::factory()->hasAccess())
	    {
	        $this->sendForbidden();
	        return;
	    }
	    if (self::isPost() && $this->_post->toInt('client_update') && $this->_post->toInt('id'))
	    {
	        $pjClientModel = pjClientModel::factory();
	        $id = $this->_post->toInt('id');
	        $post = $this->_post->raw();
	        $data = array();
	        if($this->_post->check('status'))
	        {
	            $post['status'] = 'T';
	            $data['status'] = 'T';
	        }else{
	            $post['status'] = 'F';
	            $data['status'] = 'F';
	        }
	        $pjClientModel->where('id', $id)->limit(1)->modifyAll($post);
	        $client = $pjClientModel->reset()->find($id)->getData();
	        $data['id'] = $client['foreign_id'];
	        $data['email'] = $this->_post->toString('c_email');
	        $data['password'] = $this->_post->toString('c_password');
	        $data['name'] = $this->_post->toString('c_name');
	        $data['phone'] = $this->_post->toString('c_phone');
	        pjAuth::init($data)->updateUser();
	        pjUtil::redirect(PJ_INSTALL_URL . "index.php?controller=pjAdminClients&action=pjActionUpdate&id=".$id."&err=AC01");
	    }
	    if (self::isGet() && $this->_get->toInt('id'))
	    {
	        $id = $this->_get->toInt('id');
	        $order_table = pjOrderModel::factory()->getTable();
	        $arr = pjClientModel::factory()
	        ->select("t1.*, t2.email as c_email, t2.name as c_name, t2.phone as c_phone, t2.status as status, AES_DECRYPT(t2.password, '".PJ_SALT."') AS c_password,
							  (SELECT COUNT(TB.id) FROM `".$order_table."` AS TB WHERE TB.client_id = t1.id) AS cnt_orders,
							  (SELECT SUM(TB.total) FROM `".$order_table."` AS TB WHERE TB.client_id = t1.id) AS total_amount,
							  (SELECT CONCAT(TB.created, '~:~', TB.id) FROM `".$order_table."` AS TB WHERE TB.client_id = t1.id ORDER BY TB.created DESC LIMIT 1) AS last_order")
			->join('pjAuthUser', 't2.id=t1.foreign_id', 'left outer')
		    ->find($id)
    		->toArray("last_order", "~:~")
    		->getData();
    		  
    		if (count($arr) === 0)
    		{
    		    pjUtil::redirect(PJ_INSTALL_URL. "index.php?controller=pjAdminClients&action=pjActionIndex&err=AC08");
    		}
            $this->set('arr', $arr);
            
            $country_arr = pjBaseCountryModel::factory()
            ->select('t1.id, t2.content AS country_title')
            ->join('pjBaseMultiLang', "t2.model='pjBaseCountry' AND t2.foreign_id=t1.id AND t2.field='name' AND t2.locale='".$this->getLocaleId()."'", 'left outer')
            ->where('status', 'T')
            ->orderBy('`country_title` ASC')->findAll()->getData();
            
            $this->set('country_arr', $country_arr);
            
            $this->appendCss('bootstrap-chosen.css', PJ_THIRD_PARTY_PATH . 'chosen/');
            $this->appendJs('chosen.jquery.js', PJ_THIRD_PARTY_PATH . 'chosen/');
            $this->appendJs('jquery.validate.min.js', PJ_THIRD_PARTY_PATH . 'validate/');
            $this->appendJs('pjAdminClients.js');
	    }
	}
}
?>