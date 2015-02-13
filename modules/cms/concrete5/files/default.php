<?php defined('C5_EXECUTE') or die("Access Denied.");
$this->inc('elements/header.php'); ?>
	<section>
		<div class="left">
			<?php
				$a = new Area('Left');
				$a->display($c);
			?>
		</div>
		<div class="right">
			<?php
				$a = new Area('Right');
				$a->display($c);
			?>
		</div>
	</section>
<?php $this->inc('elements/footer.php'); ?>
