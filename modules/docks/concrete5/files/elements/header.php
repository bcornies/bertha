<?php defined('C5_EXECUTE') or die("Access Denied."); ?>
<!DOCTYPE html>
<html lang="en">
<head>
<?php Loader::element('header_required'); ?>
  
<!-- Site Header Content //-->
<?php $this->inc('includes/css.php'); ?>

</head>
<body>
  <div id="header">
    
    <?php if ($c->isEditMode()) { ?>
    <div style="min-height: 80px">
    <?php } ?>
    
    <div id="nav">
      <?php
      $a = new Area('Header Nav');
      $a->display($c);
      ?>
    </div>
    
    <h1 id="logo"><!-- <a href="<?php echo DIR_REL?>/"></a> --></h1>

    <?php if ($c->isEditMode()) { ?>
    </div>
    <?php } ?>
    
  </div>