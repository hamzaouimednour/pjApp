<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-sm-12">
        <div class="row">
            <div class="col-sm-10">
                <h2><?php __('infoAddOrderTitle');?></h2>
            </div>
        </div><!-- /.row -->

        <p class="m-b-none"><i class="fa fa-info-circle"></i> <?php __('infoAddOrderDesc');?></p>
    </div><!-- /.col-md-12 -->
</div>
<?php
$time_format = 'HH:mm';
if((strpos($tpl['option_arr']['o_time_format'], 'a') > -1))
{
    $time_format = 'hh:mm a';
}
if((strpos($tpl['option_arr']['o_time_format'], 'A') > -1))
{
    $time_format = 'hh:mm A';
}
$months = __('months', true);
ksort($months);
$short_days = __('short_days', true);
?>
<div class="row wrapper wrapper-content animated fadeInRight">
    <div class="col-lg-9">
    	<form action="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminOrders&amp;action=pjActionCreate" method="post" id="frmCreateOrder">
			<input type="hidden" name="order_create" value="1" />
			<input type="hidden" id="price" name="price" value="" />
			<input type="hidden" id="price_delivery" name="price_delivery" value="" />
			<input type="hidden" id="discount" name="discount" value="" />
			<input type="hidden" id="subtotal" name="subtotal" value="" />
			<input type="hidden" id="tax" name="tax" value="" />
			<input type="hidden" id="total" name="total" value="" />
			
			<div id="dateTimePickerOptions" style="display:none;" data-wstart="<?php echo (int) $tpl['option_arr']['o_week_start']; ?>" data-dateformat="<?php echo pjUtil::toMomemtJS($tpl['option_arr']['o_date_format']); ?>" data-format="<?php echo pjUtil::toMomemtJS($tpl['option_arr']['o_date_format']); ?> <?php echo $time_format;?>" data-months="<?php echo implode("_", $months);?>" data-days="<?php echo implode("_", $short_days);?>"></div>
            <div class="tabs-container tabs-reservations m-b-lg">
                <ul class="nav nav-tabs" role="tablist">
                    <li role="presentation" class="active"><a href="#order-details" aria-controls="order-details" role="tab" data-toggle="tab"><?php __('menuOrders'); ?></a></li>
                    <li role="presentation"><a href="#client-details" aria-controls="client-details" role="tab" data-toggle="tab"><?php __('menuClients'); ?></a></li>
                </ul>
    
                <div class="tab-content">
                    <div role="tabpanel" class="tab-pane active" id="order-details">
                        <div class="panel-body">
                            <div class="row">
                                <div class="col-lg-3 col-md-4 col-sm-6">
                                    <div class="form-group">
                                        <label class="control-label"><?php __('lblStatus'); ?></label>
    
                                        <select name="status" id="status" class="form-control required" data-msg-required="<?php __('fd_field_required', false, true);?>">
                                            <?php
    										foreach (__('order_statuses', true, false) as $k => $v)
    										{
    											?><option value="<?php echo $k; ?>"<?php echo $k =='pending' ? ' selected="selected"' : NULL;?>><?php echo stripslashes($v); ?></option><?php
    										}
    										?>
                                        </select>
                                    </div>
                                </div><!-- /.col-md-3 -->
    
                                <div class="col-lg-3 col-md-4 col-sm-6">
                                    <div class="form-group">
                                        <label class="control-label"><?php __('lblType'); ?></label>
    
                                        <div class="clearfix">
                                            <div class="switch onoffswitch-data pull-left">
                                                <div class="onoffswitch onoffswitch-order">
                                                    <input type="checkbox" class="onoffswitch-checkbox" id="type" name="type" checked>
                                                    <label class="onoffswitch-label" for="type">
                                                        <span class="onoffswitch-inner" data-on="<?php __('types_ARRAY_delivery', false, true);?>" data-off="<?php __('types_ARRAY_pickup', false, true);?>"></span>
                                                        <span class="onoffswitch-switch"></span>
                                                    </label>
                                                </div>
                                            </div>
                                        </div><!-- /.clearfix -->
                                    </div>
                                </div><!-- /.col-md-3 -->
    
                                <div class="col-lg-3 col-md-4 col-sm-6">
                                    <div class="form-group order-delivery">
                                        <label class="control-label"><?php __('lblDeliveryDateTime'); ?></label>
    
                                        <div class="input-group">
                                            <input type="text" id="d_dt" name="d_dt" class="form-control fdRequired required" data-wt="open" data-msg-required="<?php __('fd_field_required', false, true);?>" readonly>
    
                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span> 
                                        </div>
                                    </div>
    
                                    <div class="form-group order-pickup">
                                        <label class="control-label"><?php __('lblPickerDateTime'); ?></label>
    
                                        <div class="input-group">
                                            <input type="text" id="p_dt" name="p_dt" class="form-control fdRequired" data-wt="open" data-msg-required="<?php __('fd_field_required', false, true);?>" readonly>
    
                                            <span class="input-group-addon"><i class="fa fa-calendar"></i></span> 
                                        </div>
                                    </div>
                                </div><!-- /.col-md-3 -->
                            </div><!-- /.row -->
    
                            <div class="row">
                            	<div class="col-lg-3 col-md-4 col-sm-6">
                                    <div class="form-group">
                                        <label class="control-label"><?php __('lblOrderIsPaid'); ?></label>
    
                                        <div class="switch">
                                            <div class="onoffswitch onoffswitch-yn">
                                                <input type="checkbox" class="onoffswitch-checkbox" name="is_paid" id="is_paid">
                                                <label class="onoffswitch-label" for="is_paid">
                                                    <span class="onoffswitch-inner" data-on="<?php __('_yesno_ARRAY_T', false, true);?>" data-off="<?php __('_yesno_ARRAY_T', false, true);?>"></span>
                                                    <span class="onoffswitch-switch"></span>
                                                </label>
                                            </div>
                                        </div>
                                    </div>
                                </div><!-- /.col-md-3 -->
                                
                                <div class="col-lg-3 col-md-4 col-sm-6">
                                    <div class="form-group">
                                        <label class="control-label"><?php __('lblPaymentMethod');?></label>
    									<?php
    									$online_arr = array();
    									$offline_arr = array();
    									foreach (__('payment_methods', true, false) as $k => $v)
    									{
    									    if($k == 'creditcard') continue;
    									    if(in_array($k, array('cash', 'bank')))
    									    {
    									        $offline_arr[$k] = $v;
    									    }else{
    									        $online_arr[$k] = $v;
    									    }
    									}
    									?>
                                        <select name="payment_method" id="payment_method" class="form-control required" data-msg-required="<?php __('fd_field_required', false, true);?>">
    										<option value="">-- <?php __('lblChoose'); ?>--</option>
    										<optgroup label="<?php __('script_online_payment_gateway', false, true); ?>">
    										<?php
    										foreach($online_arr as $k => $v)
    										{
    										    ?><option value="<?php echo $k;?>"><?php echo $v;?></option><?php
    										}
    										?>
    										</optgroup>
    										<optgroup label="<?php __('script_offline_payment', false, true); ?>">
    										<?php
    										foreach($offline_arr as $k => $v)
    										{
    										    ?><option value="<?php echo $k;?>"><?php echo $v;?></option><?php
    										}
    										?>
    										</optgroup>
    									</select>
                                    </div>
                                </div><!-- /.col-md-3 -->
    
                                <div class="col-lg-3 col-md-4 col-sm-6">
                                    <div class="form-group">
                                        <label class="control-label"><?php __('lblVoucher'); ?></label>
    
                                        <input type="text" name="voucher_code" id="voucher_code" class="form-control">
                                    </div>
                                </div><!-- /.col-md-3 -->
                            </div><!-- /.row -->
    
                            <div class="hr-line-dashed"></div>
    
                            <div class="m-b-md">
                                <a href="#" class="btn btn-primary btn-outline m-t-xs" id="btnAddProduct"><i class="fa fa-plus"></i> <?php __('btnAddProduct');?></a>
                            </div>
    
                            <div class="form-group ibox-content">
                            	<div class="sk-spinner sk-spinner-double-bounce"><div class="sk-double-bounce1"></div><div class="sk-double-bounce2"></div></div>
                                <div class="table-responsive table-responsive-secondary">
                                    <table id="fdOrderList" class="table table-striped table-hover">
                                        <thead>
                                            <tr>
                                                <th><?php __('lblProduct');?></th>
                                                <th><?php __('lblSizeAndPrice');?></th>
                                                <th><?php __('lblQty');?></th>
                                                <th>
                                                    <div class="p-w-xs"><?php __('lblExtra');?></div>
                                                </th>
                                                <th><?php __('lblTotal');?></th>
                                                <th></th>
                                            </tr>
                                        </thead>
                                        <?php
                                        $index = "new_" . mt_rand(0, 999999); 
                                        ?>                    
                                        <tbody class="main-body">
                                            <tr class="fdLine" data-index="<?php echo $index;?>">
                                                <td>
                                                    <select id="fdProduct_<?php echo $index;?>" data-index="<?php echo $index;?>" name="product_id[<?php echo $index;?>]" class="form-control fdProduct">
                										<option value="">-- <?php __('lblChoose'); ?>--</option>
                										<?php
                										foreach ($tpl['product_arr'] as $p)
                										{
                											?><option value="<?php echo $p['id']; ?>" data-extra="<?php echo $p['cnt_extras'];?>"><?php echo stripslashes($p['name']); ?></option><?php
                										}
                										?>
                									</select>
                                                </td>
                                                
                                                <td id="fdPriceTD_<?php echo $index;?>">
                									<div class="business-<?php echo $index;?>" style="display: none;">
                										<select id="fdPrice_<?php echo $index;?>" name="price_id[<?php echo $index;?>]" data-type="select" class="fdSize form-control">
                											<option value="">-- <?php __('lblChoose'); ?>--</option>
                										</select>
                									</div>
                								</td>
                            
                                                <td>
                									<div class="business-<?php echo $index;?>" style="display: none;">
                										<input type="text" id="fdProductQty_<?php echo $index;?>" name="cnt[<?php echo $index;?>]" class="form-control pj-field-count" value="1" />
                									</div>
                								</td>
                            
                                                <td>
                									<div class="business-<?php echo $index;?>" style="display: none;">
                										<table id="fdExtraTable_<?php echo $index;?>" class="table no-margins pj-extra-table">							
                											<tbody>
                											</tbody>
                										</table>
                										<div class="p-w-xs">
                                                            <a href="#" class="btn btn-primary btn-xs btn-outline pj-add-extra fdExtraBusiness_<?php echo $index;?> fdExtraButton_<?php echo $index;?>" data-index="<?php echo $index;?>"><i class="fa fa-plus"></i> <?php __('btnAddExtra');?></a>
                                                        </div><!-- /.p-w-xs -->
                										<span class="fdExtraBusiness_<?php echo $index;?> fdExtraNA_<?php echo $index;?>"><?php __('lblNA');?></span>
                									</div>
                								</td>
                                                
                                                <td>
                									<strong><span id="fdTotalPrice_<?php echo $index;?>"><?php echo pjCurrency::formatPrice(0);?></span></strong>
                								</td>
                                                            
                                                <td>
                                                   	&nbsp;
                                                </td>
                                            </tr>
    
                                        </tbody>
                                    </table>
                                </div>
                            </div>
    
                            <div class="hr-line-dashed"></div>
    
                            <div class="clearfix">
                                <button type="submit" class="ladda-button btn btn-primary btn-lg btn-phpjabbers-loader pull-left" data-style="zoom-in" style="margin-right: 15px;">
                                    <span class="ladda-label"><?php __('btnSave'); ?></span>
                                    <?php include $controller->getConstant('pjBase', 'PLUGIN_VIEWS_PATH') . 'pjLayouts/elements/button-animation.php'; ?>
                                </button>
                                <button type="button" class="btn btn-white btn-lg pull-right" onclick="window.location.href='<?php echo PJ_INSTALL_URL; ?>index.php?controller=pjAdminOrders&action=pjActionIndex';"><?php __('btnCancel'); ?></button>
                            </div><!-- /.clearfix -->
                        </div>
                    </div>
    
                    <div role="tabpanel" class="tab-pane" id="client-details">
                        <div class="panel-body">
                            <div class="form-group">
                                <label class="control-label"><?php __('lblClient'); ?></label>
    
                                <div class="clearfix">
                                    <div class="switch onoffswitch-data pull-left">
                                        <div class="onoffswitch onoffswitch-client">
                                            <input type="checkbox" class="onoffswitch-checkbox" id="new_client" name="new_client" checked>
    
                                            <label class="onoffswitch-label" for="new_client">
                                                <span class="onoffswitch-inner" data-on="<?php __('lblNewClient'); ?>" data-off="<?php __('lblExistingClient'); ?>"></span>
                                                <span class="onoffswitch-switch"></span>
                                            </label>
                                        </div>
                                    </div>
                                </div><!-- /.clearfix -->
                            </div><!-- /.form-group -->
    
                            <div class="current-client-area" style="display:none;">
                            	
                    			<div class="form-group">
                                    <label class="control-label"><?php __('lblExistingClient'); ?></label>
                                    <div class="row">
                                		<div class="col-md-10">
                                            <select name="client_id" id="client_id" class="form-control fdRequired" data-msg-required="<?php __('fd_field_required', false, true);?>">
            									<option value="">-- <?php __('lblChoose'); ?>--</option>
            									<?php
            									foreach ($tpl['client_arr'] as $v)
            									{
            										$email_phone = array();
            										if(!empty($v['c_email']))
            										{
            											$email_phone[] = stripslashes($v['c_email']);
            										}
            										if(!empty($v['c_phone']))
            										{
            											$email_phone[] = stripslashes($v['c_phone']);
            										}
            										?><option value="<?php echo $v['id']; ?>"><?php echo pjSanitize::clean($v['c_name']); ?> (<?php echo join(" | ", $email_phone); ?>)</option><?php
            									}
            									?>
            								</select>
    									</div>
            							<div class="col-md-2">
                                			<a id="pjFdEditClient" class="btn btn-primary btn-outline btn-sm m-l-xs" href="#" target="blank" data-href="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminClients&amp;action=pjActionUpdate&id={ID}" style="display:none;"><i class="fa fa-pencil"></i></a>
                                		</div>
                                   </div>
                            	</div>
                            </div><!-- /.hidden-area -->
    
                            <div class="new-client-area">
                                <div class="hr-line-dashed"></div>
    							<?php
    							ob_start();
    							$field = 0;
    							if (in_array($tpl['option_arr']['o_bf_include_title'], array(2, 3)))
    							{
    							    $title_arr = pjUtil::getTitles();
    							    $name_titles = __('personal_titles', true, false);
    							    ?>
    							    <div class="col-md-4 col-sm-6">
                                        <div class="form-group">
                                            <label class="control-label"><?php __('lblTitle'); ?></label>
    
                                            <select id="c_title" name="c_title" class="form-control<?php echo ($tpl['option_arr']['o_bf_include_title'] == 3) ? ' fdRequired required' : NULL; ?>" data-msg-required="<?php __('fd_field_required', false, true);?>">
        										<option value="">----</option>
        										<?php
        										$title_arr = pjUtil::getTitles();
        										$name_titles = __('personal_titles', true, false);
        										foreach ($title_arr as $v)
        										{
        											?><option value="<?php echo $v; ?>"><?php echo $name_titles[$v]; ?></option><?php
        										}
        										?>
        									</select>
                                        </div>
                                    </div><!-- /.col-md-3 -->
    							    <?php
    							    $field++;
    							}
    							if (in_array($tpl['option_arr']['o_bf_include_name'], array(2, 3)))
    							{
    							    ?>
    							    <div class="col-md-4 col-sm-6">
                                        <div class="form-group">
                                            <label class="control-label"><?php __('lblName'); ?></label>
    
                                            <input type="text" name="c_name" id="c_name" class="form-control<?php echo $tpl['option_arr']['o_bf_include_name'] == 3 ? ' fdRequired required' : NULL; ?>" data-msg-required="<?php __('fd_field_required', false, true);?>"/>
                                        </div>
                                    </div><!-- /.col-md-3 -->
    							    <?php
    							    $field++;
    							}
    							if (in_array($tpl['option_arr']['o_bf_include_email'], array(2, 3)))
    							{
    							    ?>
    							    <div class="col-md-4 col-sm-6">
                                        <div class="form-group">
                                            <label class="control-label"><?php __('lblEmail'); ?></label>
    
                                            <input type="text" name="c_email" id="c_email" class="form-control email<?php echo $tpl['option_arr']['o_bf_include_email'] == 3 ? ' fdRequired required' : NULL; ?>" data-msg-required="<?php __('fd_field_required', false, true);?>"/>
                                        </div>
                                    </div><!-- /.col-md-3 -->
    							    <?php
    							    $field++;
    							}
    							if($field == 3)
    							{
        							$ob_fields = ob_get_contents();
        							ob_end_clean();
        							?>
    							    <div class="row">
    							    	<?php echo $ob_fields;?>
    							    </div><!-- /.row -->
    							    <?php
    							    ob_start();
    							    $field = 0;
    							}
    							if (in_array($tpl['option_arr']['o_bf_include_email'], array(2, 3)))
    							{
    							    ?>
    							    <div class="col-md-4 col-sm-6">
                                        <div class="form-group">
                                            <label class="control-label"><?php __('lblPassword'); ?></label>
    
                                            <input type="text" name="c_password" id="c_password" class="form-control<?php echo $tpl['option_arr']['o_bf_include_email'] == 3 ? ' fdRequired required' : NULL; ?>" data-msg-required="<?php __('fd_field_required', false, true);?>"/>
                                        </div>
                                    </div><!-- /.col-md-3 -->
    							    <?php
    							    $field++;
    							}
    							if($field == 3)
    							{
    							    $ob_fields = ob_get_contents();
    							    ob_end_clean();
    							    ?>
    							    <div class="row">
    							    	<?php echo $ob_fields;?>
    							    </div><!-- /.row -->
    							    <?php
    							    ob_start();
    							    $field = 0;
    							}
    							if (in_array($tpl['option_arr']['o_bf_include_phone'], array(2, 3)))
    							{
    							    ?>
    							    <div class="col-md-4 col-sm-6">
                                        <div class="form-group">
                                            <label class="control-label"><?php __('lblPhone'); ?></label>
    
                                            <input type="text" name="c_phone" id="c_phone" class="form-control<?php echo $tpl['option_arr']['o_bf_include_phone'] == 3 ? ' fdRequired required' : NULL; ?>" data-msg-required="<?php __('fd_field_required', false, true);?>"/>
                                        </div>
                                    </div><!-- /.col-md-3 -->
    							    <?php
    							    $field++;
    							}
    							if($field == 3)
    							{
    							    $ob_fields = ob_get_contents();
    							    ob_end_clean();
    							    ?>
    							    <div class="row">
    							    	<?php echo $ob_fields;?>
    							    </div><!-- /.row -->
    							    <?php
    							    ob_start();
    							    $field = 0;
    							}
    							if (in_array($tpl['option_arr']['o_bf_include_company'], array(2, 3)))
    							{
    							    ?>
    							    <div class="col-md-4 col-sm-6">
                                        <div class="form-group">
                                            <label class="control-label"><?php __('lblCompany'); ?></label>
    
                                            <input type="text" name="c_company" id="c_company" class="form-control<?php echo $tpl['option_arr']['o_bf_include_company'] == 3 ? ' fdRequired required' : NULL; ?>" data-msg-required="<?php __('fd_field_required', false, true);?>"/>
                                        </div>
                                    </div><!-- /.col-md-3 -->
    							    <?php
    							    $field++;
    							}
    							if($field > 0)
    							{
    							    $ob_fields = ob_get_contents();
    							    ob_end_clean();
    							    ?>
    							    <div class="row">
    							    	<?php echo $ob_fields;?>
    							    </div><!-- /.row -->
    							    <?php
    							}
    							?>
                            </div><!-- /.new-client-area -->
    
                            <div class="hr-line-dashed"></div>
    						<div class="order-pickup">
                                <div class="form-group">
                                    <label class="control-label"><?php __('lblLocation');?></label>
        
                                    <select name="p_location_id" id="p_location_id" class="form-control fdRequired" data-msg-required="<?php __('fd_field_required', false, true);?>">
    									<option value="">-- <?php __('lblChoose'); ?>--</option>
    									<?php
    									foreach ($tpl['location_arr'] as $location)
    									{
    										?><option value="<?php echo $location['id']; ?>"><?php echo stripslashes($location['name']); ?></option><?php
    									}
    									?>
    								</select>
                                </div>
        						<?php
        						if (in_array($tpl['option_arr']['o_pf_include_notes'], array(2, 3)))
        						{
            						?>
                                    <div class="form-group">
                                        <label class="control-label"><?php __('lblSpecialInstructions'); ?></label>
            							<textarea name="p_notes" id="p_notes" class="form-control form-control-sm<?php echo $tpl['option_arr']['o_pf_include_notes'] == 3 ? ' fdRequired' : NULL; ?>" data-msg-required="<?php __('fd_field_required', false, true);?>"></textarea>
                                    </div>
                                    <?php
        						}
                                ?>
        					
                                <div class="hr-line-dashed"></div>
    						</div><!-- /.pickup -->
    						<div class="order-delivery">
    							<div class="form-group">
                                    <label class="control-label"><?php __('lblLocation');?></label>
        
                                    <select name="d_location_id" id="d_location_id" class="form-control fdRequired required" data-msg-required="<?php __('fd_field_required', false, true);?>">
    									<option value="">-- <?php __('lblChoose'); ?>--</option>
    									<?php
    									foreach ($tpl['location_arr'] as $location)
    									{
    										?><option value="<?php echo $location['id']; ?>"><?php echo stripslashes($location['name']); ?></option><?php
    									}
    									?>
    								</select>
                                </div>
                                <?php
                                ob_start();
                                $field = 0;
                                if (in_array($tpl['option_arr']['o_df_include_address_1'], array(2, 3)))
                                {
                                    ?>
                                    <div class="col-md-4 col-sm-6">
                                        <div class="form-group">
                                            <label class="control-label"><?php __('lblAddress1'); ?></label>
    
                                            <input type="text" name="d_address_1" id="d_address_1" class="form-control<?php echo $tpl['option_arr']['o_df_include_address_1'] == 3 ? ' fdRequired required' : NULL; ?>" data-msg-required="<?php __('fd_field_required', false, true);?>"/>
                                        </div>
                                    </div><!-- /.col-md-3 -->
                                    <?php
                                    $field++;
                                }
                                if (in_array($tpl['option_arr']['o_df_include_address_2'], array(2, 3)))
                                {
                                    ?>
                                    <div class="col-md-4 col-sm-6">
                                        <div class="form-group">
                                            <label class="control-label"><?php __('lblAddress2'); ?></label>
    
                                            <input type="text" name="d_address_2" id="d_address_2" class="form-control<?php echo $tpl['option_arr']['o_df_include_address_2'] == 3 ? ' fdRequired required' : NULL; ?>" data-msg-required="<?php __('fd_field_required', false, true);?>"/>
                                        </div>
                                    </div><!-- /.col-md-3 -->
                                    <?php
                                    $field++;
                                }
                                if (in_array($tpl['option_arr']['o_df_include_city'], array(2, 3)))
                                {
                                    ?>
                                    <div class="col-md-4 col-sm-6">
                                        <div class="form-group">
                                            <label class="control-label"><?php __('lblCity'); ?></label>
    
                                            <input type="text" name="d_city" id="d_city" class="form-control<?php echo $tpl['option_arr']['o_df_include_city'] == 3 ? ' fdRequired required' : NULL; ?>" data-msg-required="<?php __('fd_field_required', false, true);?>"/>
                                        </div>
                                    </div><!-- /.col-md-3 -->
                                    <?php
                                    $field++;
                                }
                                if($field == 3)
                                {
                                    $ob_fields = ob_get_contents();
                                    ob_end_clean();
                                    ?>
    							    <div class="row">
    							    	<?php echo $ob_fields;?>
    							    </div><!-- /.row -->
    							    <?php
    							    ob_start();
    							    $field = 0;
    							}
    							if (in_array($tpl['option_arr']['o_df_include_state'], array(2, 3)))
    							{
    							    ?>
                                    <div class="col-md-4 col-sm-6">
                                        <div class="form-group">
                                            <label class="control-label"><?php __('lblState'); ?></label>
    
                                            <input type="text" name="d_state" id="d_state" class="form-control<?php echo $tpl['option_arr']['o_df_include_state'] == 3 ? ' fdRequired required' : NULL; ?>" data-msg-required="<?php __('fd_field_required', false, true);?>"/>
                                        </div>
                                    </div><!-- /.col-md-3 -->
                                    <?php
                                    $field++;
                                }
                                if($field == 3)
                                {
                                    $ob_fields = ob_get_contents();
                                    ob_end_clean();
                                    ?>
    							    <div class="row">
    							    	<?php echo $ob_fields;?>
    							    </div><!-- /.row -->
    							    <?php
    							    ob_start();
    							    $field = 0;
    							}
    							if (in_array($tpl['option_arr']['o_df_include_zip'], array(2, 3)))
    							{
    							    ?>
                                    <div class="col-md-4 col-sm-6">
                                        <div class="form-group">
                                            <label class="control-label"><?php __('lblZip'); ?></label>
    
                                            <input type="text" name="d_zip" id="d_zip" class="form-control<?php echo $tpl['option_arr']['o_df_include_zip'] == 3 ? ' fdRequired required' : NULL; ?>" data-msg-required="<?php __('fd_field_required', false, true);?>"/>
                                        </div>
                                    </div><!-- /.col-md-3 -->
                                    <?php
                                    $field++;
                                }
                                if($field == 3)
                                {
                                    $ob_fields = ob_get_contents();
                                    ob_end_clean();
                                    ?>
    							    <div class="row">
    							    	<?php echo $ob_fields;?>
    							    </div><!-- /.row -->
    							    <?php
    							    ob_start();
    							    $field = 0;
    							}
    							if (in_array($tpl['option_arr']['o_df_include_country'], array(2, 3)))
    							{
    							    ?>
                                    <div class="col-md-4 col-sm-6">
                                        <div class="form-group">
                                            <label class="control-label"><?php __('lblCountry'); ?></label>
    
                                            <select name="d_country_id" id="d_country_id" class="form-control<?php echo $tpl['option_arr']['o_df_include_country'] == 3 ? ' fdRequired required' : NULL; ?>" data-msg-required="<?php __('fd_field_required', false, true);?>">
        										<option value="">-- <?php __('lblChoose'); ?>--</option>
        										<?php
        										foreach ($tpl['country_arr'] as $v)
        										{
        											?><option value="<?php echo $v['id']; ?>"><?php echo stripslashes($v['country_title']); ?></option><?php
        										}
        										?>
        									</select>
                                        </div>
                                    </div><!-- /.col-md-3 -->
                                    <?php
                                    $field++;
                                }
                                if($field == 3)
                                {
                                    $ob_fields = ob_get_contents();
                                    ob_end_clean();
                                    ?>
    							    <div class="row">
    							    	<?php echo $ob_fields;?>
    							    </div><!-- /.row -->
    							    <?php
    							    ob_start();
    							    $field = 0;
    							}
    							if (in_array($tpl['option_arr']['o_df_include_notes'], array(2, 3)))
    							{
    							    ?>
                                    <div class="col-md-4 col-sm-6">
                                        <div class="form-group">
                                            <label class="control-label"><?php __('lblSpecialInstructions'); ?></label>
    
                                            <textarea name="d_notes" id="d_notes" class="form-control<?php echo $tpl['option_arr']['o_df_include_notes'] == 3 ? ' fdRequired required' : NULL; ?>" data-msg-required="<?php __('fd_field_required', false, true);?>"></textarea>
                                        </div>
                                    </div><!-- /.col-md-3 -->
                                    <?php
                                    $field++;
                                }
                                if($field > 0)
                                {
                                    $ob_fields = ob_get_contents();
                                    ob_end_clean();
                                    ?>
    							    <div class="row">
    							    	<?php echo $ob_fields;?>
    							    </div><!-- /.row -->
    							    <?php
    							}
                                ?>
    						</div><!-- /.delivery -->
                            <div class="clearfix">
                                <button type="submit" class="ladda-button btn btn-primary btn-lg btn-phpjabbers-loader pull-left" data-style="zoom-in" style="margin-right: 15px;">
                                    <span class="ladda-label"><?php __('btnSave'); ?></span>
                                    <?php include $controller->getConstant('pjBase', 'PLUGIN_VIEWS_PATH') . 'pjLayouts/elements/button-animation.php'; ?>
                                </button>
                                <button type="button" class="btn btn-white btn-lg pull-right" onclick="window.location.href='<?php echo PJ_INSTALL_URL; ?>index.php?controller=pjAdminOrders&action=pjActionIndex';"><?php __('btnCancel'); ?></button>
                            </div><!-- /.clearfix -->
                        </div>
                    </div>
                </div>
            </div>
        </form>
    </div><!-- /.col-lg-8 -->

    <div class="col-lg-3">
        <div class="m-b-lg">
            <div id="pjFdPriceWrapper" class="panel no-borders ibox-content">
            	<div class="sk-spinner sk-spinner-double-bounce"><div class="sk-double-bounce1"></div><div class="sk-double-bounce2"></div></div>
                <div class="panel-heading bg-pending">
                    <p class="lead m-n"><i class="fa fa-check"></i> <?php __('lblStatus'); ?>: <span class="pull-right status-text"><?php __('order_statuses_ARRAY_pending');?></span></p>    
                </div><!-- /.panel-heading -->

                <div class="panel-body">
                    <p class="lead m-b-md"><?php __('lblPrice'); ?>: <span id="price_format" class="pull-right"><?php echo pjCurrency::formatPrice(0);?></span></p>
                    <p class="lead m-b-md"><?php __('lblDelivery'); ?>: <span id="delivery_format" class="pull-right"><?php echo pjCurrency::formatPrice(0);?></span></p>
                    <p class="lead m-b-md"><?php __('lblDiscount'); ?>: <span id="discount_format" class="pull-right text-right"><?php echo pjCurrency::formatPrice(0);?></span></p>
                    <p class="lead m-b-md"><?php __('lblSubTotal'); ?>: <span id="subtotal_format" class="pull-right text-right"><?php echo pjCurrency::formatPrice(0);?></span></p>
                    <p class="lead m-b-md"><?php __('lblTax'); ?>: <span id="tax_format" class="pull-right text-right"><?php echo pjCurrency::formatPrice(0);?></span></p>

                    <div class="hr-line-dashed"></div>

                    <h3 class="lead m-b-md"><?php __('lblTotal'); ?>: <strong id="total_format" class="pull-right text-right"><?php echo pjCurrency::formatPrice(0);?></strong></h3>
                </div><!-- /.panel-body -->
            </div>

        </div><!-- /.m-b-lg -->
    </div><!-- /.col-lg-4 -->
    
</div><!-- /.wrapper wrapper-content -->

<table style="display: none" id="boxProductClone">
	<tbody>
	<?php
	include PJ_VIEWS_PATH . 'pjAdminOrders/elements/clone.php'; 
	?>
	</tbody>
</table>

<script type="text/javascript">
var myLabel = myLabel || {};
myLabel.currency = "<?php echo $tpl['option_arr']['o_currency'];?>";
myLabel.restaurant_closed = <?php __encode('lblRestaurantClosed');?>;
</script>