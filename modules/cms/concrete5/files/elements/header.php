<?php defined('C5_EXECUTE') or die("Access Denied."); ?>
<!DOCTYPE html>
<html lang="en">
<head>
  <?php Loader::element('header_required')?>
  <?php $this->inc('includes/css.php'); ?>
  <?php $this->inc('includes/js.php'); ?>
</head>
<body>
  <div class="<?php echo $c->getPageWrapperClass()?>">
    <header>
      <section>
        <div class="logo">
          <?php
            $a = new GlobalArea('Logo');
            $a->display($c);
          ?>
        </div>
        <nav>
          <?php
            $a = new GlobalArea('Nav');
            $a->display($c);
          ?>
        </nav>
      </section>
    </header>
