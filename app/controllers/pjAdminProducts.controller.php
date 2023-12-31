<?php
if (!defined("ROOT_PATH"))
{
	header("HTTP/1.1 403 Forbidden");
	exit;
}
class pjAdminProducts extends pjAdmin
{
	public function pjActionCreate()
	{
	    $post_max_size = pjUtil::getPostMaxSize();
	    if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_SERVER['CONTENT_LENGTH']) && (int) $_SERVER['CONTENT_LENGTH'] > $post_max_size)
	    {
	        pjUtil::redirect(PJ_INSTALL_URL . "index.php?controller=pjAdminProducts&action=pjActionIndex&err=AP05");
	    }
	    
	    $this->checkLogin();
	    if (!pjAuth::factory()->hasAccess())
	    {
	        $this->sendForbidden();
	        return;
	    }
	    if (self::isPost() && $this->_post->toInt('product_create'))
	    {
	        $pjProductModel = pjProductModel::factory();
	        
	        $data = array();
	        $post = $this->_post->raw();
	        if($this->_post->check('is_featured'))
	        {
	            $data['is_featured'] = 1;
	        }else{
	            $data['is_featured'] = 0;
	        }
	        if($this->_post->check('set_different_sizes'))
	        {
	            $data['set_different_sizes'] = "T";
	        }else{
	            $data['set_different_sizes'] = "F";
	        }
	        $data['order'] = $pjProductModel->getLastOrder();
	        $id = $pjProductModel->setAttributes(array_merge($post,$data))->insert()->getInsertId();
	        if ($id !== false && (int) $id > 0)
	        {
	            $err = 'AP03';
	            $pjMultiLangModel = pjMultiLangModel::factory();
	            $pjProductPriceModel = pjProductPriceModel::factory();
	            if (isset($post['i18n']))
	            {
	                $pjMultiLangModel->saveMultiLang($post['i18n'], $id, 'pjProduct', 'data');
	                
	                if($post['set_different_sizes'] == 'T')
	                {
	                    if(isset($post['index_arr']) && $post['index_arr'] != '')
	                    {
	                        $index_arr = explode("|", $post['index_arr']);
	                        foreach($index_arr as $k => $v)
	                        {
	                            if(strpos($v, 'fd') !== false)
	                            {
	                                $p_data = array();
	                                $p_data['product_id'] = $id;
	                                $p_data['price'] = $post['product_price'][$v];
	                                $price_id = $pjProductPriceModel->reset()->setAttributes($p_data)->insert()->getInsertId();
	                                if ($price_id !== false && (int) $price_id > 0)
	                                {
	                                    foreach ($post['i18n'] as $locale => $locale_arr)
	                                    {
	                                        foreach ($locale_arr as $field => $content)
	                                        {
	                                            if(is_array($content))
	                                            {
	                                                $insert_id = $pjMultiLangModel->reset()->setAttributes(array(
	                                                    'foreign_id' => $price_id,
	                                                    'model' => 'pjProductPrice',
	                                                    'locale' => $locale,
	                                                    'field' => $field,
	                                                    'content' => $content[$v],
	                                                    'source' => 'data'
	                                                ))->insert()->getInsertId();
	                                            }
	                                        }
	                                    }
	                                }
	                            }
	                        }
	                    }
	                }
	            }
	            if (isset($_FILES['image']))
	            {
	                if($_FILES['image']['error'] == 0)
	                {
	                    if(getimagesize($_FILES['image']["tmp_name"]) != false)
	                    {
	                        $Image = new pjImage();
	                        if ($Image->getErrorCode() !== 200)
	                        {
	                            $Image->setAllowedTypes(array('image/png', 'image/gif', 'image/jpg', 'image/jpeg', 'image/pjpeg'));
	                            if ($Image->load($_FILES['image']))
	                            {
	                                $resp = $Image->isConvertPossible();
	                                if ($resp['status'] === true)
	                                {
	                                    $hash = md5(uniqid(rand(), true));
	                                    $image_path = PJ_UPLOAD_PATH . 'products/' . $id . '_' . $hash . '.' . $Image->getExtension();
	                                    
	                                    $Image->loadImage($_FILES['image']["tmp_name"]);
	                                    $Image->resizeSmart(116, 87);
	                                    $Image->saveImage($image_path);
	                                    
	                                    $pjProductModel->reset()->where('id', $id)->limit(1)->modifyAll(array('image'=>$image_path));
	                                    
	                                }
	                            }
	                        }
	                    }else{
	                        $err = 'AP09';
	                    }
	                }else if($_FILES['image']['error'] != 4){
	                    $err = 'AP09';
	                }
	            }
	            $pjProductCategoryModel = pjProductCategoryModel::factory();
	            if (isset($post['category_id']) && is_array($post['category_id']) && count($post['category_id']) > 0)
	            {
	                $pjProductCategoryModel->begin();
	                foreach ($post['category_id'] as $category_id)
	                {
	                    $pjProductCategoryModel
	                    ->reset()
	                    ->set('product_id', $id)
	                    ->set('category_id', $category_id)
	                    ->insert();
	                }
	                $pjProductCategoryModel->commit();
	            }
	            $pjProductExtraModel = pjProductExtraModel::factory();
	            if (isset($post['extra_id']) && is_array($post['extra_id']) && count($post['extra_id']) > 0)
	            {
	                $pjProductExtraModel->begin();
	                foreach ($post['extra_id'] as $extra_id)
	                {
	                    $pjProductExtraModel
	                    ->reset()
	                    ->set('product_id', $id)
	                    ->set('extra_id', $extra_id)
	                    ->insert();
	                }
	                $pjProductExtraModel->commit();
	            }
	            if($err != 'AP03')
	            {
	                pjUtil::redirect($_SERVER['PHP_SELF'] . "?controller=pjAdminProducts&action=pjActionUpdate&id=$id&err=AP09");
	            }
	        } else {
	            $err = 'AP04';
	        }
	        pjUtil::redirect($_SERVER['PHP_SELF'] . "?controller=pjAdminProducts&action=pjActionIndex&err=$err");
	    }
	    if (self::isGet())
	    {
	        $this->setLocalesData();
	        
	        $this->set('category_arr', pjCategoryModel::factory()
	            ->select('t1.*, t2.content AS name')
	            ->join('pjMultiLang', "t2.model='pjCategory' AND t2.foreign_id=t1.id AND t2.field='name' AND t2.locale='".$this->getLocaleId()."'", 'left outer')
	            ->where('t1.status', 'T')
	            ->orderBy('`order` ASC')
	            ->findAll()
	            ->getData());
	        $this->set('extra_arr', pjExtraModel::factory()
	            ->select('t1.*, t2.content AS name')
	            ->join('pjMultiLang', "t2.model='pjExtra' AND t2.foreign_id=t1.id AND t2.field='name' AND t2.locale='".$this->getLocaleId()."'", 'left outer')
	            ->orderBy('name ASC')
	            ->findAll()
	            ->getData());
	        
	        $this->appendJs('jquery.validate.min.js', PJ_THIRD_PARTY_PATH . 'validate/');
	        $this->appendJs('jquery.multilang.js', $this->getConstant('pjBase', 'PLUGIN_JS_PATH'), false, false);
	        $this->appendJs('jquery.tipsy.js', PJ_THIRD_PARTY_PATH . 'tipsy/');
	        $this->appendCss('jquery.tipsy.css', PJ_THIRD_PARTY_PATH . 'tipsy/');
	        $this->appendCss('bootstrap-chosen.css', PJ_THIRD_PARTY_PATH . 'chosen/');
	        $this->appendJs('chosen.jquery.js', PJ_THIRD_PARTY_PATH . 'chosen/');
	        $this->appendCss('jasny-bootstrap.min.css', PJ_THIRD_PARTY_PATH . 'jasny/');
	        $this->appendJs('jasny-bootstrap.min.js',  PJ_THIRD_PARTY_PATH . 'jasny/');
	        $this->appendJs('pjAdminProducts.js');
	    }
	}
		
	public function pjActionDeleteProduct()
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
	    $pjProductModel = pjProductModel::factory();
	    $arr = $pjProductModel->find($this->_get->toInt('id'))->getData();
	    if (!$arr)
	    {
	        self::jsonResponse(array('status' => 'ERR', 'code' => 103, 'text' => 'Product not found.'));
	    }
	    $id = $this->_get->toInt('id');
	    if ($pjProductModel->setAttributes(array('id' => $id))->erase()->getAffectedRows() == 1)
	    {
	        if (file_exists(PJ_INSTALL_PATH . $arr['image'])) {
	            @unlink(PJ_INSTALL_PATH . $arr['image']);
	        }
	        pjMultiLangModel::factory()->where('model', 'pjProduct')->where('foreign_id', $id)->eraseAll();
	        pjProductCategoryModel::factory()->where('product_id', $id)->eraseAll();
	        pjProductExtraModel::factory()->where('product_id', $id)->eraseAll();
	        pjProductPriceModel::factory()->where('product_id', $id)->eraseAll();
	        self::jsonResponse(array('status' => 'OK', 'code' => 200, 'text' => 'Product has been deleted'));
	    }else{
	        self::jsonResponse(array('status' => 'ERR', 'code' => 105, 'text' => 'Product has not been deleted.'));
	    }
		exit;
	}
	
	public function pjActionDeleteProductBulk()
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
	    $pjProductModel = pjProductModel::factory();
	    $arr = $pjProductModel->whereIn('id', $record)->findAll()->getData();
	    foreach($arr as $v)
	    {
	        if (file_exists(PJ_INSTALL_PATH . $v['image'])) {
	            @unlink(PJ_INSTALL_PATH . $v['image']);
	        }
	    }
	    $pjProductModel->reset()->whereIn('id', $record)->eraseAll();
	    pjMultiLangModel::factory()->where('model', 'pjProduct')->whereIn('foreign_id', $record)->eraseAll();
	    pjProductCategoryModel::factory()->whereIn('product_id', $record)->eraseAll();
	    pjProductExtraModel::factory()->whereIn('product_id', $record)->eraseAll();
	    pjProductPriceModel::factory()->whereIn('product_id', $record)->eraseAll();
	    self::jsonResponse(array('status' => 'OK', 'code' => 200, 'text' => 'Product(s) has been deleted.'));
	    exit;
	}
	
	public function pjActionGetProduct()
	{
		$this->setAjax(true);
	
		if ($this->isXHR())
		{
			$pjProductModel = pjProductModel::factory()
				->join('pjMultiLang', "t2.foreign_id = t1.id AND t2.model = 'pjProduct' AND t2.locale = '".$this->getLocaleId()."' AND t2.field = 'name'", 'left');
			
			if ($this->_get->toString('status'))
			{
			    $status = $this->_get->toString('status');
			    if(in_array($status, array('T', 'F')))
			    {
			        $pjProductModel->where('t1.status', $status);
			    }
			}
			if ($q = $this->_get->toString('q'))
			{
			    $pjProductModel->where("(t2.content LIKE '%$q%')");
			}
			if ($category_id = $this->_get->toInt('category_id'))
			{
			    $pjProductModel->where("(t1.id IN (SELECT TPC.product_id FROM `".pjProductCategoryModel::factory()->getTable()."` AS TPC WHERE TPC.category_id='".$category_id."'))");
			}

			$column = 'is_featured';
			$direction = 'DESC';
			if ($this->_get->toString('column') && in_array(strtoupper($this->_get->toString('direction')), array('ASC', 'DESC')))
			{
			    $column = $this->_get->toString('column');
			    $direction = strtoupper($this->_get->toString('direction'));
			}

			$total = $pjProductModel->findCount()->getData();
			$rowCount = $this->_get->toInt('rowCount') ?: 10;
			$pages = ceil($total / $rowCount);
			$page = $this->_get->toInt('page') ?: 1;
			$offset = ((int) $page - 1) * $rowCount;
			if ($page > $pages)
			{
				$page = $pages;
			}
			
			$pjProductPriceModel = pjProductPriceModel::factory();
			$data = $pjProductModel
				->select("t1.*, t2.content AS name")
				->orderBy("$column $direction")
				->limit($rowCount, $offset)
				->findAll()
				->getData();
			foreach($data as $k => $v)
			{
				if($v['set_different_sizes'] == 'T')
				{
					$_arr = $pjProductPriceModel
						->reset()
						->join('pjMultiLang', "t2.foreign_id = t1.id AND t2.model = 'pjProductPrice' AND t2.locale = '".$this->getLocaleId()."' AND t2.field = 'price_name'", 'left')
						->select('t1.*, t2.content as price_name')
						->where('product_id', $v['id'])
						->findAll()
						->getData();
					$price_arr = array();
					foreach($_arr as $price)
					{
						$price_arr[] = $price['price_name'] . ': ' . pjCurrency::formatPrice($price['price']);
					}
					$v['price'] = join("<br/>", $price_arr);
				}else{
				    $v['price'] = pjCurrency::formatPrice($v['price']);
				}
				$data[$k] = $v;
			}	
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
	    $this->appendJs('pjAdminProducts.js');
	}
	
	public function pjActionSaveProduct()
	{
		$this->setAjax(true);
	
		$this->setAjax(true);
		
		if (!$this->isXHR())
		{
		    self::jsonResponse(array('status' => 'ERR', 'code' => 100, 'text' => 'Missing headers.'));
		}
		
		if (!self::isPost())
		{
		    self::jsonResponse(array('status' => 'ERR', 'code' => 101, 'text' => 'HTTP method not allowed.'));
		}
		
		if (!pjAuth::factory($this->_get->toString('controller'), 'pjActionUpdate')->hasAccess())
		{
		    self::jsonResponse(array('status' => 'ERR', 'code' => 102, 'text' => 'Access denied.'));
		}
		$pjProductModel = pjProductModel::factory();
		$arr = $pjProductModel->find($this->_get->toInt('id'))->getData();
		if (!$arr)
		{
		    self::jsonResponse(array('status' => 'ERR', 'code' => 103, 'text' => 'Product not found.'));
		}
		if (!in_array($this->_post->toString('column'), $pjProductModel->getI18n()))
		{
		    $pjProductModel->reset()->where('id', $this->_get->toInt('id'))->limit(1)->modifyAll(array($this->_post->toString('column') => $this->_post->toString('value')));
		} else {
		    pjMultiLangModel::factory()->updateMultiLang(array($this->getLocaleId() => array($this->_post->toString('column') => $this->_post->toString('value'))), $this->_get->toInt('id'), 'pjProduct', 'data');
		}
		self::jsonResponse(array('status' => 'OK', 'code' => 201, 'text' => 'Product has been updated.'));
		exit;
	}
	
	public function pjActionUpdate()
	{
	    $post_max_size = pjUtil::getPostMaxSize();
	    if ($_SERVER['REQUEST_METHOD'] == 'POST' && isset($_SERVER['CONTENT_LENGTH']) && (int) $_SERVER['CONTENT_LENGTH'] > $post_max_size)
	    {
	        pjUtil::redirect(PJ_INSTALL_URL . "index.php?controller=pjAdminProducts&action=pjActionIndex&err=AP05");
	    }
	    
	    $this->checkLogin();
	    if (!pjAuth::factory()->hasAccess())
	    {
	        $this->sendForbidden();
	        return;
	    }
	    if (self::isPost() && $this->_post->toInt('product_update'))
	    {
	        $data = array();
	        $post = $this->_post->raw();
	        if($this->_post->check('is_featured'))
	        {
	            $data['is_featured'] = 1;
	        }else{
	            $data['is_featured'] = 0;
	        }
	        if($this->_post->check('set_different_sizes'))
	        {
	            $data['set_different_sizes'] = "T";
	        }else{
	            $data['set_different_sizes'] = "F";
	        }
	        $pjProductModel = pjProductModel::factory();
	        $err = 'AP01';
	        $id = $this->_post->toInt('id');
	        $arr = $pjProductModel->find($id)->getData();
	        if (empty($arr))
	        {
	            pjUtil::redirect($_SERVER['PHP_SELF'] . "?controller=pjAdminProducts&action=pjActionIndex&err=AP08");
	        }
	        if (isset($_FILES['image']))
	        {
	            if($_FILES['image']['error'] == 0)
	            {
	                if(getimagesize($_FILES['image']["tmp_name"]) != false)
	                {
	                    if(!empty($arr['image']))
	                    {
	                        @unlink(PJ_INSTALL_PATH . $arr['image']);
	                    }
	                    $Image = new pjImage();
	                    if ($Image->getErrorCode() !== 200)
	                    {
	                        $Image->setAllowedTypes(array('image/png', 'image/gif', 'image/jpg', 'image/jpeg', 'image/pjpeg'));
	                        if ($Image->load($_FILES['image']))
	                        {
	                            $resp = $Image->isConvertPossible();
	                            if ($resp['status'] === true)
	                            {
	                                $hash = md5(uniqid(rand(), true));
	                                $image_path = PJ_UPLOAD_PATH . 'products/' . $id . '_' . $hash . '.' . $Image->getExtension();
	                                
	                                $Image->loadImage($_FILES['image']["tmp_name"]);
	                                $Image->resizeSmart(116, 87);
	                                $Image->saveImage($image_path);
	                                $data['image'] = $image_path;
	                            }
	                        }
	                    }
	                }else{
	                    $err = 'AP10';
	                }
	            }else if($_FILES['image']['error'] != 4){
	                $err = 'AP10';
	            }
	        }
	        $pjProductModel->reset()->where('id', $id)->limit(1)->modifyAll(array_merge($post, $data));
	           
	        if (isset($post['i18n']))
	        {
	            $pjMultiLangModel = pjMultiLangModel::factory();
	            foreach ($post['i18n'] as $locale => $locale_arr)
	            {
	                foreach ($locale_arr as $field => $content)
	                {
	                    if(!is_array($content))
	                    {
	                        $sql = sprintf("INSERT INTO `%1\$s` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`)
													VALUES (NULL, :foreign_id, :model, :locale, :field, :update_content, :source)
													ON DUPLICATE KEY UPDATE `content` = :update_content, `source` = :source;",$pjMultiLangModel->getTable());
	                        $foreign_id = $id;
	                        $model = 'pjProduct';
	                        $source = 'data';
	                        $update_content = $content;
	                        $modelObj = $pjMultiLangModel->reset()->prepare($sql)->exec(compact('foreign_id', 'model', 'locale', 'field', 'update_content', 'source'));
	                    }
	                }
	            }
	            $pjProductPriceModel = pjProductPriceModel::factory();
	            
	            if($post['set_different_sizes'] == 'T')
	            {
	                if(isset($post['index_arr']) && $post['index_arr'] != '')
	                {
	                    $index_arr = explode("|", $post['index_arr']);
	                    foreach($index_arr as $k => $v)
	                    {
	                        if(strpos($v, 'fd') !== false)
	                        {
	                            $p_data = array();
	                            $p_data['product_id'] = $post['id'];
	                            $p_data['price'] = $post['product_price'][$v];
	                            $price_id = $pjProductPriceModel->reset()->setAttributes($p_data)->insert()->getInsertId();
	                            if ($price_id !== false && (int) $price_id > 0)
	                            {
	                                foreach ($post['i18n'] as $locale => $locale_arr)
	                                {
	                                    foreach ($locale_arr as $field => $content)
	                                    {
	                                        if(is_array($content))
	                                        {
	                                            $insert_id = $pjMultiLangModel->reset()->setAttributes(array(
	                                                'foreign_id' => $price_id,
	                                                'model' => 'pjProductPrice',
	                                                'locale' => $locale,
	                                                'field' => $field,
	                                                'content' => $content[$v],
	                                                'source' => 'data'
	                                            ))->insert()->getInsertId();
	                                        }
	                                    }
	                                }
	                            }
	                            
	                        }else{
	                            $p_data = array();
	                            $p_data['price'] = $post['product_price'][$v];
	                            $pjProductPriceModel->reset()->where('id', $v)->limit(1)->modifyAll($p_data);
	                            foreach ($post['i18n'] as $locale => $locale_arr)
	                            {
	                                foreach ($locale_arr as $field => $content)
	                                {
	                                    if(is_array($content))
	                                    {
	                                        $sql = sprintf("INSERT INTO `%1\$s` (`id`, `foreign_id`, `model`, `locale`, `field`, `content`, `source`)
													VALUES (NULL, :foreign_id, :model, :locale, :field, :update_content, :source)
													ON DUPLICATE KEY UPDATE `content` = :update_content, `source` = :source;",
	                                            $pjMultiLangModel->getTable()
	                                            );
	                                        $foreign_id = $v;
	                                        $model = 'pjProductPrice';
	                                        $source = 'data';
	                                        $update_content = $content[$v];
	                                        $modelObj = $pjMultiLangModel->reset()->prepare($sql)->exec(compact('foreign_id', 'model', 'locale', 'field', 'update_content', 'source'));
	                                    }
	                                }
	                            }
	                        }
	                    }
	                }
	                
	                if(isset($post['remove_arr']) && $post['remove_arr'] != '')
	                {
	                    $remove_arr = explode("|", $post['remove_arr']);
	                    $pjMultiLangModel->reset()->where('model', 'pjProductPrice')->whereIn('foreign_id', $remove_arr)->eraseAll();
	                    $pjProductPriceModel->reset()->whereIn('id', $remove_arr)->eraseAll();
	                }
	                $pjProductModel->reset()->where('id', $post['id'])->limit(1)->modifyAll(array('price' => ':NULL'));
	            }else{
	                $id_arr = $pjProductPriceModel->where('product_id', $post['id'])->findAll()->getDataPair("id", "id");
	                $pjMultiLangModel->reset()->where('model', 'pjProductPrice')->whereIn('foreign_id', $id_arr);
	                $pjProductPriceModel->reset()->where('product_id', $post['id'])->eraseAll();
	            }
	        }
	        $pjProductCategoryModel = pjProductCategoryModel::factory();
	        $pjProductCategoryModel->where('product_id', $post['id'])->eraseAll();
	        if (isset($post['category_id']) && is_array($post['category_id']) && count($post['category_id']) > 0)
	        {
	            $pjProductCategoryModel->reset()->begin();
	            foreach ($post['category_id'] as $category_id)
	            {
	                $pjProductCategoryModel
	                ->reset()
	                ->set('product_id', $post['id'])
	                ->set('category_id', $category_id)
	                ->insert();
	            }
	            $pjProductCategoryModel->commit();
	        }
	        $pjProductExtraModel = pjProductExtraModel::factory();
	        $pjProductExtraModel->where('product_id', $post['id'])->eraseAll();
	        if (isset($post['extra_id']) && is_array($post['extra_id']) && count($post['extra_id']) > 0)
	        {
	            $pjProductExtraModel->reset()->begin();
	            foreach ($post['extra_id'] as $extra_id)
	            {
	                $pjProductExtraModel
	                ->reset()
	                ->set('product_id', $post['id'])
	                ->set('extra_id', $extra_id)
	                ->insert();
	            }
	            $pjProductExtraModel->commit();
	        }
	        if($err == 'AP01')
	        {
	            pjUtil::redirect(PJ_INSTALL_URL . "index.php?controller=pjAdminProducts&action=pjActionIndex&err=AP01");
	        }else{
	            pjUtil::redirect(PJ_INSTALL_URL . "index.php?controller=pjAdminProducts&action=pjActionUpdate&id=".$id."&err=AP10");
	        }
	    }
	    if (self::isGet() && $this->_get->toInt('id'))
	    {
	        $id = $this->_get->toInt('id');
	        $pjMultiLangModel = pjMultiLangModel::factory();
	        
	        $arr = pjProductModel::factory()->find($id)->getData();
	        if (count($arr) === 0)
	        {
	            pjUtil::redirect(PJ_INSTALL_URL. "index.php?controller=pjAdminProducts&action=pjActionIndex&err=AP08");
	        }
	        $arr['i18n'] = $pjMultiLangModel->getMultiLang($arr['id'], 'pjProduct');
	        $this->set('arr', $arr);
	        
	        $this->setLocalesData();
	        
	        $this->set('category_arr', pjCategoryModel::factory()
	            ->select('t1.*, t2.content AS name')
	            ->join('pjMultiLang', "t2.model='pjCategory' AND t2.foreign_id=t1.id AND t2.field='name' AND t2.locale='".$this->getLocaleId()."'", 'left outer')
	            ->where('t1.status', 'T')
	            ->orderBy('`order` ASC')
	            ->findAll()
	            ->getData());
	        $this->set('extra_arr', pjExtraModel::factory()
	            ->select('t1.*, t2.content AS name')
	            ->join('pjMultiLang', "t2.model='pjExtra' AND t2.foreign_id=t1.id AND t2.field='name' AND t2.locale='".$this->getLocaleId()."'", 'left outer')
	            ->orderBy('name ASC')
	            ->findAll()
	            ->getData());
	        
	        $this->set('category_id_arr', pjProductCategoryModel::factory()
	            ->where("product_id", $id)
	            ->findAll()
	            ->getDataPair("category_id", "category_id"));
	        $this->set('extra_id_arr', pjProductExtraModel::factory()
	            ->where("product_id", $id)
	            ->findAll()
	            ->getDataPair("extra_id", "extra_id"));
	        
	        if($arr['set_different_sizes'] == 'T')
	        {
	            $size_arr = pjProductPriceModel::factory()->where('product_id', $id)->findAll()->getData();
	            foreach($size_arr as $k => $v)
	            {
	                $size_arr[$k]['i18n'] = pjMultiLangModel::factory()->getMultiLang($v['id'], 'pjProductPrice');
	            }
	            $this->set('size_arr', $size_arr);
	        }
	        
	        $this->appendJs('jquery.validate.min.js', PJ_THIRD_PARTY_PATH . 'validate/');
	        $this->appendJs('jquery.multilang.js', $this->getConstant('pjBase', 'PLUGIN_JS_PATH'), false, false);
	        $this->appendJs('jquery.tipsy.js', PJ_THIRD_PARTY_PATH . 'tipsy/');
	        $this->appendCss('jquery.tipsy.css', PJ_THIRD_PARTY_PATH . 'tipsy/');
	        $this->appendCss('bootstrap-chosen.css', PJ_THIRD_PARTY_PATH . 'chosen/');
	        $this->appendJs('chosen.jquery.js', PJ_THIRD_PARTY_PATH . 'chosen/');
	        $this->appendCss('jasny-bootstrap.min.css', PJ_THIRD_PARTY_PATH . 'jasny/');
	        $this->appendJs('jasny-bootstrap.min.js',  PJ_THIRD_PARTY_PATH . 'jasny/');
	        $this->appendJs('pjAdminProducts.js');
	    }
	}
	
	public function pjActionDeleteImage()
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
		$id = $this->_get->toInt('id');
		$pjProductModel = pjProductModel::factory();
		$arr = $pjProductModel->find($id)->getData(); 
		if(empty($arr))
		{
		    self::jsonResponse(array('status' => 'ERR', 'code' => 104, 'text' => 'Product not found.'));
		}
		if(!empty($arr['image']))
		{
		    @unlink(PJ_INSTALL_PATH . $arr['image']);
		}
		$data = array();
		$data['image'] = ':NULL';
		$pjProductModel->reset()->where(array('id' => $id))->limit(1)->modifyAll($data);
		self::jsonResponse(array('status' => 'OK', 'code' => 200, 'text' => 'Product image has been deleted.'));
	}
}
?>