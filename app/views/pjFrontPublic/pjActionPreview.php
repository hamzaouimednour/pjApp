<div class="fdLoader"></div>
<?php
$index = $controller->_get->toString('index');
$STORAGE = @$_SESSION[$controller->defaultStore];
$FORM = isset($_SESSION[$controller->defaultForm]) ? $_SESSION[$controller->defaultForm] : array();
$CLIENT = $controller->isFrontLogged() ? @$_SESSION[$controller->defaultClient] : array();
?>
<br />
<div class="row">
	<div id="fdMain_<?php echo $index; ?>" class="col-md-8 col-sm-8 col-xs-12 pjFdPanelLeft">
		
		<div class="panel panel-default">
			<?php include_once dirname(__FILE__) . '/elements/header.php';?>
			<div class="panel-body pjFdPanelBody">
				<div class="form-horizontal">
				<?php
				if($tpl['status'] == 'OK')
				{
					if($STORAGE['type'] == 'pickup')
					{
						if(isset($STORAGE['next_day']))
						{
							$p_dt = strtotime($STORAGE['next_day']);
						}else{
						    if($STORAGE['p_time'] == 'asap')
						    {
						        $p_dt = strtotime(pjDateTime::formatDate($STORAGE['p_date'], $tpl['option_arr']['o_date_format']));
						    }else{
						        $p_dt = strtotime(pjDateTime::formatDate($STORAGE['p_date'], $tpl['option_arr']['o_date_format']) . ' ' . pjDateTime::formatTime($STORAGE['p_time'], $tpl['option_arr']['o_time_format']));
						    }
						}
						?>
						<h2 class="text-muted text-center"><?php __('front_pickup');?></h2>
		
						<br />
						<dl class="dl-horizontal">
							<dt><?php __('front_location');?></dt>
							<dd><?php echo pjSanitize::html($tpl['p_location_arr']['name']);?></dd>
						</dl><!-- /.dl-horizontal -->
						<dl class="dl-horizontal">
							<dt><?php __('front_pickup_datetime'); ?></dt>
							<?php
							if(isset($STORAGE['next_day']))
							{ 
								?>
								<dd><?php echo  date($tpl['option_arr']['o_date_format'], $p_dt) . ', ' . date($tpl['option_arr']['o_time_format'], $p_dt);?></dd>
								<?php
							}else{
								?>
								<dd><?php echo $STORAGE['p_date'];?>, <?php echo $STORAGE['p_time'] == 'asap' ? __('front_asap', true) : date($tpl['option_arr']['o_time_format'], $p_dt);?></dd>
								<?php
							} 
							?>
						</dl><!-- /.dl-horizontal -->
						<?php
					}	
					if($STORAGE['type'] == 'delivery')
					{
						if(isset($STORAGE['next_day']))
						{
							$d_dt = strtotime($STORAGE['next_day']);
						}else{
						    if($STORAGE['d_time'] == 'asap')
						    {
						        $d_dt = strtotime(pjDateTime::formatDate($STORAGE['d_date'], $tpl['option_arr']['o_date_format']));
						    }else{
						        $d_dt = strtotime(pjDateTime::formatDate($STORAGE['d_date'], $tpl['option_arr']['o_date_format']) . ' ' . pjDateTime::formatTime($STORAGE['d_time'], $tpl['option_arr']['o_time_format']));
						    }
						}
						?>
						<h2 class="text-muted text-center"><?php __('front_delivery');?></h2>
		
						<br />
						
						<dl class="dl-horizontal">
							<dt><?php __('front_location');?></dt>
							<dd><?php echo pjSanitize::html($tpl['location_arr']['name']);?></dd>
						</dl><!-- /.dl-horizontal -->
						<dl class="dl-horizontal">
							<dt><?php __('front_delivery_datetime'); ?></dt>
							<?php
							if(isset($STORAGE['next_day']))
							{ 
								?>
								<dd><?php echo  date($tpl['option_arr']['o_date_format'], $d_dt) . ', ' . date($tpl['option_arr']['o_time_format'], $d_dt);?></dd>
								<?php
							}else{
								?>
								<dd><?php echo $STORAGE['d_date'];?>, <?php echo $STORAGE['d_time'] == 'asap' ? __('front_asap', true) : date($tpl['option_arr']['o_time_format'], $d_dt)?></dd>
								<?php
							} 
							?>
						</dl><!-- /.dl-horizontal -->
						<?php
						if (in_array($tpl['option_arr']['o_df_include_address_1'], array(2, 3)))
						{
							 ?>
							 <dl class="dl-horizontal">
								<dt><?php __('front_address_line_1');?></dt>
								<dd><?php echo pjSanitize::html($STORAGE['d_address_1']);?></dd>
							</dl><!-- /.dl-horizontal -->
							 <?php
						}
						if (in_array($tpl['option_arr']['o_df_include_address_2'], array(2, 3)))
						{
							?>
							 <dl class="dl-horizontal">
								<dt><?php __('front_address_line_2');?></dt>
								<dd><?php echo pjSanitize::html($STORAGE['d_address_2']);?></dd>
							</dl><!-- /.dl-horizontal -->
							 <?php
						}
						if (in_array($tpl['option_arr']['o_df_include_city'], array(2, 3)))
						{
							?>
							 <dl class="dl-horizontal">
								<dt><?php __('front_city');?></dt>
								<dd><?php echo pjSanitize::html($STORAGE['d_city']);?></dd>
							</dl><!-- /.dl-horizontal -->
							 <?php
						}
						if (in_array($tpl['option_arr']['o_df_include_state'], array(2, 3)))
						{
							?>
							 <dl class="dl-horizontal">
								<dt><?php __('front_state');?></dt>
								<dd><?php echo pjSanitize::html($STORAGE['d_state']);?></dd>
							</dl><!-- /.dl-horizontal -->
							 <?php
						}
						if (in_array($tpl['option_arr']['o_df_include_zip'], array(2, 3)))
						{
							?>
							 <dl class="dl-horizontal">
								<dt><?php __('front_zip');?></dt>
								<dd><?php echo pjSanitize::html($STORAGE['d_zip']);?></dd>
							</dl><!-- /.dl-horizontal -->
							 <?php
						}
						if ((int) $STORAGE['d_country_id'] > 0 && in_array($tpl['option_arr']['o_df_include_country'], array(2, 3)))
						{
							?>
							 <dl class="dl-horizontal">
								<dt><?php __('front_country');?></dt>
								<dd><?php echo pjSanitize::html($tpl['d_country_arr']['country_title']);?></dd>
							</dl><!-- /.dl-horizontal -->
							 <?php
						}
						if (in_array($tpl['option_arr']['o_df_include_notes'], array(2, 3)) && !empty($STORAGE['d_notes']))
						{
							?>
							 <dl class="dl-horizontal">
								<dt><?php __('front_special_instructions');?></dt>
								<dd><?php echo nl2br(pjSanitize::clean($STORAGE['d_notes']));?></dd>
							</dl><!-- /.dl-horizontal -->
							 <?php
						}
					}
					
					ob_start();
					if (in_array($tpl['option_arr']['o_bf_include_address_1'], array(2, 3)))
					{
						?>
						<dl class="dl-horizontal">
							<dt><?php __('front_address_line_1'); ?></dt>
							<dd><?php echo isset($FORM['c_address_1']) ? pjSanitize::html(@$FORM['c_address_1']) : pjSanitize::html(@$CLIENT['c_address_1']); ?></dd>
						</dl><!-- /.dl-horizontal -->
						<?php
					}
					if (in_array($tpl['option_arr']['o_bf_include_address_2'], array(2, 3)))
					{
						?>
						<dl class="dl-horizontal">
							<dt><?php __('front_address_line_2'); ?></dt>
							<dd><?php echo isset($FORM['c_address_2']) ? pjSanitize::html(@$FORM['c_address_2']) : pjSanitize::html(@$CLIENT['c_address_2']); ?></dd>
						</dl><!-- /.dl-horizontal -->
						<?php
					}
					if (in_array($tpl['option_arr']['o_bf_include_city'], array(2, 3)))
					{
						?>
						<dl class="dl-horizontal">
							<dt><?php __('front_city'); ?></dt>
							<dd><?php echo isset($FORM['c_city']) ? pjSanitize::html(@$FORM['c_city']) : pjSanitize::html(@$CLIENT['c_city']); ?></dd>
						</dl><!-- /.dl-horizontal -->
						<?php
					}
					if (in_array($tpl['option_arr']['o_bf_include_state'], array(2, 3)))
					{
						?>
						<dl class="dl-horizontal">
							<dt><?php __('front_state'); ?></dt>
							<dd><?php echo isset($FORM['c_state']) ? pjSanitize::html(@$FORM['c_state']) : pjSanitize::html(@$CLIENT['c_state']); ?></dd>
						</dl><!-- /.dl-horizontal -->
						<?php
					}
					if (in_array($tpl['option_arr']['o_bf_include_zip'], array(2, 3)))
					{
						?>
						<dl class="dl-horizontal">
							<dt><?php __('front_zip'); ?></dt>
							<dd><?php echo isset($FORM['c_zip']) ? pjSanitize::html(@$FORM['c_zip']) : pjSanitize::html(@$CLIENT['c_zip']); ?></dd>
						</dl><!-- /.dl-horizontal -->
						<?php
					}
					if (in_array($tpl['option_arr']['o_bf_include_country'], array(2, 3)) && !empty($tpl['country_arr']))
					{
						?>
						<dl class="dl-horizontal">
							<dt><?php __('front_country'); ?></dt>
							<dd><?php echo pjSanitize::html($tpl['country_arr']['country_title']);?></dd>
						</dl><!-- /.dl-horizontal -->
						<?php
					}
					$ob_address = ob_get_contents();
					ob_end_clean();
					if (!empty($ob_address))
					{
						?>
						<br />
						<h2 class="text-muted text-center"><?php __('front_address');?></h2>
			
						<br />
						<?php
						echo $ob_address;
					} 
					?>
					<h2 class="text-muted text-center"><?php __('front_personal_details');?></h2>
		
					<br />
					<?php
					if (in_array($tpl['option_arr']['o_bf_include_title'], array(2, 3)))
					{
						$name_titles = __('personal_titles', true, false);
						?>
						<dl class="dl-horizontal">
							<dt><?php __('front_title'); ?></dt>
							<dd><?php echo isset($FORM['c_title']) ? $name_titles[$FORM['c_title']] : pjSanitize::html($name_titles[@$CLIENT['c_title']]);?></dd>
						</dl><!-- /.dl-horizontal -->
						<?php
					}
					if (in_array($tpl['option_arr']['o_bf_include_name'], array(2, 3)))
					{
						?>
						<dl class="dl-horizontal">
							<dt><?php __('front_name'); ?></dt>
							<dd><?php echo isset($FORM['c_name']) ? pjSanitize::html(@$FORM['c_name']) : pjSanitize::html(@$CLIENT['c_name']); ?></dd>
						</dl><!-- /.dl-horizontal -->
						<?php
					}
					if (in_array($tpl['option_arr']['o_bf_include_email'], array(2, 3)))
					{
						?>
						<dl class="dl-horizontal">
							<dt><?php __('front_email'); ?></dt>
							<dd><?php echo isset($FORM['c_email']) ? pjSanitize::html(@$FORM['c_email']) : pjSanitize::html(@$CLIENT['c_email']); ?></dd>
						</dl><!-- /.dl-horizontal -->
						<?php
					}
					if (in_array($tpl['option_arr']['o_bf_include_phone'], array(2, 3)))
					{
						?>
						<dl class="dl-horizontal">
							<dt><?php __('front_phone'); ?></dt>
							<dd><?php echo isset($FORM['c_phone']) ? pjSanitize::html(@$FORM['c_phone']) : pjSanitize::html(@$CLIENT['c_phone']); ?></dd>
						</dl><!-- /.dl-horizontal -->
						<?php
					}
					if (in_array($tpl['option_arr']['o_bf_include_company'], array(2, 3)))
					{
						?>
						<dl class="dl-horizontal">
							<dt><?php __('front_company'); ?></dt>
							<dd><?php echo isset($FORM['c_company']) ? pjSanitize::html(@$FORM['c_company']) : pjSanitize::html(@$CLIENT['c_company']); ?></dd>
						</dl><!-- /.dl-horizontal -->
						<?php
					}
					if (in_array($tpl['option_arr']['o_bf_include_notes'], array(2, 3)))
					{
						?>
						<dl class="dl-horizontal">
							<dt><?php __('front_notes'); ?></dt>
							<dd><?php echo isset($FORM['c_notes']) ? nl2br(pjSanitize::clean(@$FORM['c_notes'])) : nl2br(pjSanitize::clean(@$CLIENT['c_notes'])); ?></dd>
						</dl><!-- /.dl-horizontal -->
						<?php
					}
					?>
					
					<?php
					if($tpl['option_arr']['o_payment_disable'] == 'No')
					{
						$payment_methods = $tpl['payment_titles'];
						?>
						<h2 class="text-muted text-center"><?php __('front_payment', false, false); ?></h2>
		
						<br />
						<dl class="dl-horizontal">
							<dt><?php __('front_payment_medthod'); ?></dt>
							<dd><?php echo $payment_methods[$FORM['payment_method']]; ?></dd>
						</dl><!-- /.dl-horizontal -->
						<div id="fdBankData_<?php echo $index;?>" style="display: <?php echo isset($FORM['payment_method']) && $FORM['payment_method'] == 'bank' ? 'block' : 'none'; ?>">
							<dl class="dl-horizontal">
								<dt>&nbsp;</dt>
								<dd><?php echo nl2br(pjSanitize::clean($tpl['option_arr']['o_bank_account']));?></dd>
							</dl><!-- /.dl-horizontal -->
						</div>
						<?php
						
					}
					?>
					<br/>
					<div class="row" style="display: none;">
						<div class="col-sm-12 text-left">
							<div id="fdOrderMessage_<?php echo $index; ?>" class="alert alert-info" role="alert"></div>
						</div>
						<br/>
					</div><!-- /.row -->
					<div class="row fdButtonContainer">
						<div class="col-lg-6 col-md-6 col-sm-6 col-xs-6 text-left">
							<a href="#" class="btn btn-default text-uppercase fdButtonGetCheckout"><?php __('front_button_back');?></a>
						</div>
						<div class="col-lg-6 col-md-6 col-sm-6 col-xs-6 text-right">
							<a href="#" data-loading-text="Loading..." class="btn btn-default text-uppercase fdButtonConfirm<?php echo ($tpl['cart_box']['cart'] !== false && count($tpl['cart_box']['cart'])) > 0 ? null : ' fdButtonDisabled';?>"><?php __('front_button_confirm');?></a>
						</div><!-- /.col-sm-8 col-sm-offset-4 -->
					</div><!-- /.row -->
					<?php
				}else{
					?>
					<div>
						<?php
						$front_messages = __('front_messages', true, false);
						$system_msg = str_replace("[STAG]", "<a href='#' class='fdStartOver'>", $front_messages[13]);
						$system_msg = str_replace("[ETAG]", "</a>", $system_msg); 
						echo $system_msg; 
						?>
					</div>
					<?php
				}					 
				?>
				</div>
			</div><!-- /.panel-body pjFdPanelBody -->
			
		</div><!-- /.panel panel-default -->
	</div><!-- /.col-md-8 col-sm-8 col-xs-12 pjFdPanelLeft -->
	<div id="fdCart_<?php echo $index; ?>" class="col-md-4 col-sm-4 col-xs-12 pjFdPanelRight">
		<?php include_once dirname(__FILE__) . '/elements/cart.php';?>
	</div><!-- /.col-md-4 col-sm-4 col-xs-12 pjFdPanelRight -->
</div><!-- /.row -->