var jQuery_1_8_2 = jQuery_1_8_2 || jQuery.noConflict();
(function ($, undefined) {
	$(function () {
		var validate = ($.fn.validate !== undefined),
			spinner = ($.fn.spinner !== undefined),
			multilang = ($.fn.multilang !== undefined),
			datagrid = ($.fn.datagrid !== undefined),
			$frmCreateUser = $("#frmCreateUser"),
			$frmUpdateUser = $("#frmUpdateUser"),
			$document = $(document);
		
		if ($frmCreateUser.length && validate) {
			$frmCreateUser.validate({
				rules: {
					"email": {
						remote: "index.php?controller=pjBaseUsers&action=pjActionCheckEmail"
					}
				},
				onkeyup: false,
				submitHandler: function (form) {
					$.post('index.php?controller=pjBaseUsers&action=pjActionCheckPassword', $(form).serialize()).done(function (data) {
            			if(data.status == 'OK')
        				{
            				form.submit();
        				}else{
        					swal({
        		                title: myLabel.invalid_password_title,
        		                type: "warning",
        		                text: data.text,
        		                showCancelButton: false,
        		                confirmButtonColor: "#11511a",
        		                confirmButtonText: myLabel.btn_ok,
        		                closeOnConfirm: true,
        		            });
        				}
            		});
					return false;
				}
			});
		}
		
		if ($frmUpdateUser.length && validate) {
			$frmUpdateUser.validate({
				rules: {
					"email": {
						remote: "index.php?controller=pjBaseUsers&action=pjActionCheckEmail&id=" + $frmUpdateUser.find("input[name='id']").val()
					}
				},
				onkeyup: false,
				submitHandler: function (form) {
					var pswd = $(form).find("#password").val();
					if (!pswd.length) {
						return true;
					}
					
					$.post('index.php?controller=pjBaseUsers&action=pjActionCheckPassword', $(form).serialize()).done(function (data) {
            			if(data.status == 'OK')
        				{
            				form.submit();
        				}else{
        					swal({
        		                title: myLabel.invalid_password_title,
        		                type: "warning",
        		                text: data.text,
        		                showCancelButton: false,
        		                confirmButtonColor: "#11511a",
        		                confirmButtonText: myLabel.btn_ok,
        		                closeOnConfirm: true,
        		            });
        				}
            		});
					return false;
				}
			});
		}
		if ($("#grid").length > 0 && datagrid) 
		{
			function formatRole (str, obj) {
				var type;

				switch (obj.role_id) {
				case '1':
					type = 'label label-warning';
					break;
				case '2':
					type = 'label';
					break;
				default:
					type = 'label';
				}
				
				return ['<span class="', type, '">', str, '</label>'].join("");
			}
			
			function formatEmail(str) {
				return ['<a href="mailto:', str, '">', str, '</a>'].join("");
			}
			
			function onBeforeShow (obj) {
				if (parseInt(obj.id, 10) === pjGrid.currentUserId || parseInt(obj.id, 10) === 1) {
					return false;
				}
				return true;
			}
			function onBeforeShowPermissions (obj) {
				if (parseInt(obj.id, 10) === 1) {
					return false;
				}
				return true;
			}
			function onBeforeShowEdit (obj) {
				if (parseInt(obj.id, 10) === 1 && pjGrid.currentUserId != 1) {
					return false;
				}
				return true;
			}
			var actions = [
			   {text: myLabel.delete_selected, url: "index.php?controller=pjBaseUsers&action=pjActionDeleteUserBulk", render: true, confirmation: myLabel.delete_confirmation},
			   {text: myLabel.revert_status, url: "index.php?controller=pjBaseUsers&action=pjActionStatusUser", render: true},
			   {text: myLabel.exported, url: "index.php?controller=pjBaseUsers&action=pjActionExportUser", ajax: false}
			];
			
			if (!pjGrid.has_revert) {
				actions.splice(1, 1);
			}
			
			var $grid = $("#grid").datagrid({
				buttons: [{type: "cog", title: myLabel.set_permissions, url: "index.php?controller=pjBasePermissions&action=pjActionUserPermission&id={:id}", beforeShow: onBeforeShowPermissions},
						  {type: "edit", url: "index.php?controller=pjBaseUsers&action=pjActionUpdate&id={:id}", beforeShow: onBeforeShowEdit},
				          {type: "delete", url: "index.php?controller=pjBaseUsers&action=pjActionDeleteUser&id={:id}", beforeShow: onBeforeShow}],
				columns: [{text: myLabel.name, type: "text", sortable: true, editable: true},
				          {text: myLabel.email, type: "text", sortable: true, editable: true, renderer: formatEmail},
				          {text: myLabel.last_login, type: "date", sortable: true, editable: false, renderer: $.datagrid._formatDate, dateFormat: pjGrid.jsDateFormat},
				          {text: myLabel.role, type: "text", sortable: true, renderer: formatRole},
				          {text: myLabel.status, type: "toggle", sortable: true, editable: true, positiveLabel: myLabel.active, positiveValue: "T", negativeLabel: myLabel.inactive, negativeValue: "F"},
                          {text: myLabel.account_locked, type: "toggle", sortable: true, editable: true, positiveLabel: myLabel.yesno['F'], positiveValue: "F", negativeLabel: myLabel.yesno['T'], negativeValue: "T"}],
				dataUrl: "index.php?controller=pjBaseUsers&action=pjActionGetUser",
				dataType: "json",
				fields: ['name', 'email', 'last_login', 'role', 'status', 'locked'],
				paginator: {
					actions: actions,
					gotoPage: true,
					paginate: true,
					total: true,
					rowCount: true
				},
				saveUrl: "index.php?controller=pjBaseUsers&action=pjActionSaveUser&id={:id}",
				select: {
					field: "id",
					name: "record[]",
					cellClass: 'cell-width-2'
				}
			});
		}
		
		$(document).on("click", ".btn-all", function (e) {
			if (e && e.preventDefault) {
				e.preventDefault();
			}
			$(this).addClass("btn-primary active").removeClass("btn-default")
				.siblings(".btn").removeClass("btn-primary active").addClass("btn-default");
			var content = $grid.datagrid("option", "content"),
				cache = $grid.datagrid("option", "cache");
			$.extend(cache, {
				status: "",
				q: ""
			});
			$grid.datagrid("option", "cache", cache);
			$grid.datagrid("load", $grid.data('datagrid').settings.dataUrl, content.column, content.direction, content.page, content.rowCount);
			return false;
		}).on("click", ".btn-filter", function (e) {
			if (e && e.preventDefault) {
				e.preventDefault();
			}
			var $this = $(this),
				content = $grid.datagrid("option", "content"),
				cache = $grid.datagrid("option", "cache"),
				obj = {};
			$this.addClass("btn-primary active").removeClass("btn-default")
				.siblings(".btn").removeClass("btn-primary active").addClass("btn-default");
			obj.status = "";
			obj[$this.data("column")] = $this.data("value");
			$.extend(cache, obj);
			$grid.datagrid("option", "cache", cache);
			$grid.datagrid("load", $grid.data('datagrid').settings.dataUrl, content.column, content.direction, content.page, content.rowCount);
			return false;
		}).on("submit", ".frm-filter", function (e) {
			if (e && e.preventDefault) {
				e.preventDefault();
			}
			var $this = $(this),
				content = $grid.datagrid("option", "content"),
				cache = $grid.datagrid("option", "cache");
			$.extend(cache, {
				q: $this.find("input[name='q']").val(),
				page: 1
			});
			$grid.datagrid("option", "cache", cache);
			$grid.datagrid("load", $grid.data('datagrid').settings.dataUrl, content.column, content.direction, 1, content.rowCount);
			return false;
		});
	});
})(jQuery_1_8_2);