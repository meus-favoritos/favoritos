<template>

<div>
	<menu-component></menu-component>
	<head-component></head-component>
	<content-component></content-component>
	<rodape></rodape>	
</div>

</template>

<script>
	import Menu from "./layouts/menu"
	import Rodape from "./layouts/rodape"
	import Head from "./views/pages/head"
	import Content from "./views/pages/content"

	export default {
		name: "App",
		components:{"menu-component":Menu,"head-component":Head,"content-component":Content,Rodape}
	}

</script>

<style lang="scss">
@import "~milligram/src/milligram.sass";
@import "../css/app.scss";
@import "~font-awesome/css/font-awesome.css";
</style>
