<div class="row wrapper border-bottom white-bg page-heading">
    <div class="col-sm-12">
        <div class="row">
            <div class="col-sm-10">
                <h2><?php __('infoOrdersListTitle');?></h2>
            </div>
        </div><!-- /.row -->

        <p class="m-b-none"><i class="fa fa-info-circle"></i> <?php __('infoOrdersListDesc');?></p>
    </div><!-- /.col-md-12 -->
</div>
<div class="row wrapper wrapper-content animated fadeInRight">
    <div class="col-lg-12">
    	<?php
    	$error_code = $controller->_get->toString('err');
    	if (!empty($error_code))
    	{
    	    $titles = __('error_titles', true);
    	    $bodies = __('error_bodies', true);
    	    switch (true)
    	    {
    	        case in_array($error_code, array('AR01', 'AR03')):
    	            ?>
    				<div class="alert alert-success">
    					<i class="fa fa-check m-r-xs"></i>
    					<strong><?php echo @$titles[$error_code]; ?></strong>
    					<?php echo @$bodies[$error_code]?>
    				</div>
    				<?php
    				break;
                case in_array($error_code, array('AR04', 'AR08')):
    				?>
    				<div class="alert alert-danger">
    					<i class="fa fa-exclamation-triangle m-r-xs"></i>
    					<strong><?php echo @$titles[$error_code]; ?></strong>
    					<?php echo @$bodies[$error_code]?>
    				</div>
    				<?php
    				break;
    		}
    	}
    	$statuses = __('order_statuses', true, false);
    	?>
        <div class="ibox float-e-margins">
            <div class="ibox-content">
                <div class="row m-b-md">
                    <div class="col-md-4">
                        <a href="<?php echo $_SERVER['PHP_SELF']; ?>?controller=pjAdminOrders&amp;action=pjActionCreate" class="btn btn-primary"><i class="fa fa-plus"></i> <?php __('btnAddOrder') ?></a>
                    </div><!-- /.col-md-6 -->

					 <form action="" method="get" class="form-horizontal frm-filter">
                        <div class="col-md-4">
                            <div class="input-group">
                                <input type="text" name="q" placeholder="<?php __('plugin_base_btn_search', false, true); ?>" class="form-control">
                                <div class="input-group-btn">
                                    <button class="btn btn-primary" type="submit">
                                        <i class="fa fa-search"></i>
                                    </button>
                                </div>
                            </div>
                        </div><!-- /.col-md-3 -->
    
                        <div class="col-md-2 col-md-offset-2 text-right">
                        	<select name="type" id="filter_type" class="form-control">
                				<option value="">-- <?php __('lblAll'); ?> --</option>
                				<?php
                				foreach (__('types', true, false) as $k => $v)
                				{
                				    ?><option value="<?php echo $k; ?>"<?php echo $controller->_get->toString('type') == $k ? ' selected="selected"' : NULL;?>><?php echo stripslashes($v); ?></option><?php
                				}
                				foreach (__('order_statuses', true, false) as $k => $v)
                				{
                					?><option value="<?php echo $k; ?>"><?php echo stripslashes($v); ?></option><?php
                				}
                				?>
                			</select>
                        </div><!-- /.col-md-6 -->
                    </form>
                </div><!-- /.row -->

                <div id="grid"></div>
            </div>
        </div>
    </div><!-- /.col-lg-12 -->
</div>
<script type="text/javascript">
var pjGrid = pjGrid || {};
pjGrid.queryString = "";
<?php
if ($controller->_get->toInt('client_id'))
{
    ?>pjGrid.queryString += "&client_id=<?php echo $controller->_get->toInt('client_id'); ?>";<?php
}
if ($controller->_get->toString('type'))
{
    ?>pjGrid.queryString += "&type=<?php echo $controller->_get->toString('type'); ?>";<?php
}
?>
var myLabel = myLabel || {};
myLabel.name = <?php __encode('lblName'); ?>;
myLabel.phone = <?php __encode('lblPhone'); ?>;
myLabel.date_time = <?php __encode('lblDateTime'); ?>;
myLabel.total = <?php __encode('lblTotal'); ?>;
myLabel.type = <?php __encode('lblType'); ?>;
myLabel.pickup = <?php __encode('lblPickup'); ?>;
myLabel.delivery = <?php __encode('lblDelivery'); ?>;
myLabel.status = <?php __encode('lblStatus'); ?>;
myLabel.exported = <?php __encode('lblExport'); ?>;
myLabel.delete_selected = <?php __encode('delete_selected'); ?>;
myLabel.delete_confirmation = <?php __encode('delete_confirmation'); ?>;
myLabel.pending = <?php __encode('order_statuses_ARRAY_pending'); ?>;
myLabel.confirmed = <?php __encode('order_statuses_ARRAY_confirmed'); ?>;
myLabel.cancelled = <?php __encode('order_statuses_ARRAY_cancelled'); ?>;
</script>