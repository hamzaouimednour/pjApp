<?php
$titles = __('notifications_titles', true);
$sub_titles = __('notifications_subtitles', true);
$slug = sprintf("%s_%s_%s", $tpl['arr']['recipient'], $tpl['arr']['transport'], $tpl['arr']['variant']);
$is_ready = $tpl['arr']['transport'] != 'sms' || $tpl['is_sms_ready'];
?>
<form action="" method="post">
	<input type="hidden" name="id" value="<?php echo $tpl['arr']['id']; ?>">
	
	<div class="ibox float-e-margins settings-box">
		<div class="ibox-content ibox-heading">
			<h3><?php echo pjSanitize::html(@$titles[$slug]); ?></h3>
			<small><?php echo pjSanitize::html(@$sub_titles[$slug]); ?></small>
		</div>
		
		<div class="ibox-content">
			<?php 
			if ($tpl['arr']['transport'] == 'sms' && !$tpl['is_sms_ready'])
			{
				?>
				<div class="row">
					<div class="col-lg-2 col-md-3">
				<?php
			}
			if($tpl['arr']['transport'] == 'sms' && $tpl['is_sms_ready'])
			{
    			?>
    			<div class="form-group">
    				<label class="control-label"><?php __('notifications_is_active'); ?></label>
    
    				<div class="onoffswitch onoffswitch-yn">
    					<input type="checkbox" class="onoffswitch-checkbox" id="is_active" name="is_active"<?php echo $tpl['arr']['is_active'] ? ' checked' : NULL; ?><?php echo $tpl['arr']['transport'] == 'sms' && !$tpl['is_sms_ready'] ? ' disabled' : NULL; ?>>
    					<label class="onoffswitch-label" for="is_active">
    						<span class="onoffswitch-inner" data-on="<?php __('enum_arr_ARRAY_Yes', false, true); ?>" data-off="<?php __('enum_arr_ARRAY_No', false, true); ?>"></span>
    						<span class="onoffswitch-switch"></span>
    					</label>
    				</div>
    			</div>
				<?php
			}
			if ($tpl['arr']['transport'] == 'sms' && !$tpl['is_sms_ready'])
			{
				?>
					</div>
					<div class="col-lg-12 col-md-12">
						<div class="alert alert-warning">
							<i class="fa fa-warning m-r-xs"></i> <?php __('notifications_sms_na'); ?> <a href="https://www.phpjabbers.com/web-sms/" target="_blank"><?php __('notifications_sms_na_here'); ?></a>
						</div>
					</div>
				</div>
				<?php
			}
			
			if ($tpl['arr']['transport'] == 'email')
			{
				?>
				<div class="notification-area<?php echo $tpl['arr']['is_active'] && $is_ready ? NULL : ' hidden'; ?>">
					<div class="form-group">
						<label class="control-label"><?php __('notifications_subject'); ?></label>
						<?php
						foreach ($tpl['lp_arr'] as $v)
						{
							?>
							<div class="<?php echo $tpl['is_flag_ready'] ? 'input-group ' : NULL;?>pj-multilang-wrap" data-index="<?php echo $v['id']; ?>" style="display: <?php echo (int) $v['is_default'] === 0 ? 'none' : NULL; ?>">
								<input type="text" name="i18n[<?php echo $v['id']; ?>][subject]" class="form-control" value="<?php echo pjSanitize::html(@$tpl['arr']['i18n'][$v['id']]['subject']); ?>">
								<?php if ($tpl['is_flag_ready']) : ?>
								<span class="input-group-addon pj-multilang-input"><img src="<?php echo PJ_INSTALL_URL . PJ_FRAMEWORK_LIBS_PATH . 'pj/img/flags/' . $v['file']; ?>" alt="<?php echo pjSanitize::html($v['name']); ?>"></span>
								<?php endif; ?>
							</div>
							<?php
						}
						?>
					</div>
			
					<div class="form-group">
						<label class="control-label"><?php __('notifications_message'); ?></label>
						<?php
						foreach ($tpl['lp_arr'] as $v)
						{
							?>
							<div class="<?php echo $tpl['is_flag_ready'] ? 'input-group ' : NULL;?>pj-multilang-wrap" data-index="<?php echo $v['id']; ?>" style="display: <?php echo (int) $v['is_default'] === 0 ? 'none' : NULL; ?>">
								<textarea name="i18n[<?php echo $v['id']; ?>][message]" class="form-control mceEditor"><?php echo htmlspecialchars(stripslashes(@$tpl['arr']['i18n'][$v['id']]['message'])); ?></textarea>
								<?php if ($tpl['is_flag_ready']) : ?>
								<span class="input-group-addon pj-multilang-input"><img src="<?php echo PJ_INSTALL_URL . PJ_FRAMEWORK_LIBS_PATH . 'pj/img/flags/' . $v['file']; ?>" alt="<?php echo pjSanitize::html($v['name']); ?>"></span>
								<?php endif; ?>
							</div>
							<?php
						}
						?>
					</div>
				</div>
				<?php 
			} elseif ($tpl['arr']['transport'] == 'sms') {
				?>
				<div class="notification-area<?php echo $tpl['arr']['is_active'] && $is_ready ? NULL : ' hidden'; ?>">
					<div class="form-group">
						<label class="control-label"><?php __('notifications_message'); ?></label>
						<?php
						foreach ($tpl['lp_arr'] as $v)
						{
							?>
							<div class="<?php echo $tpl['is_flag_ready'] ? 'input-group ' : NULL;?>pj-multilang-wrap" data-index="<?php echo $v['id']; ?>" style="display: <?php echo (int) $v['is_default'] === 0 ? 'none' : NULL; ?>">
								<textarea name="i18n[<?php echo $v['id']; ?>][message]" class="form-control" style="height: 200px;"><?php echo htmlspecialchars(stripslashes(@$tpl['arr']['i18n'][$v['id']]['message'])); ?></textarea>
								<?php if ($tpl['is_flag_ready']) : ?>
								<span class="input-group-addon pj-multilang-input"><img src="<?php echo PJ_INSTALL_URL . PJ_FRAMEWORK_LIBS_PATH . 'pj/img/flags/' . $v['file']; ?>" alt="<?php echo pjSanitize::html($v['name']); ?>"></span>
								<?php endif; ?>
							</div>
							<?php
						}
						?>
					</div>
				</div>
				<?php 
			}
			?>
			<div class="notification-area<?php echo $tpl['arr']['is_active'] && $is_ready ? NULL : ' hidden'; ?>">
				<div class="hr-line-dashed"></div>
				
				<button type="submit" class="btn btn-primary btn-lg"><?php __('plugin_base_btn_save'); ?></button>
			</div>
		</div>
	</div>
</form>