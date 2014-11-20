<?php defined('C5_EXECUTE') or die("Access Denied."); ?>
	<footer>
	  <section>
	  	<?php
				$a = new GlobalArea('Footer');
				$a->display($c);
			?>
	  </section>
	</footer>
</div>
<?php Loader::element('footer_required')?>
</body>
</html>
