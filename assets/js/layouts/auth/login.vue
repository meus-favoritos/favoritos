<template>
	<div>
		<section v-show="ok" class="modal-bg">
			<div class="container">
				<div class="row">
					<div class="column column-50 column-offset-25 text-center">
						<h3>Olá</h3>

						<p v-show="show.email">Para fazer login, digite seu e-mail.</p>
						<p v-show="show.senha">Digite a senha para {{data.email}}</p>

						<input v-show="show.email" v-model="data.email" type="email" placeholder="usuário@email.com" />

						<button v-show="show.email" @click="change" class="button button-100">Enviar</button>

						<input v-show="show.senha" type="password" v-model="data.senha" />
						<button v-show="show.senha" @click="submit" class="button button-100">Enviar</button>

					</div>
				</div>
			</div>
		</section>

	</div>
</template>

<script>
	export default{

		data: () => ({
			data:{
				email:"",
				senha:""
			},
			show:{
				email:true,
				senha:false
			},
			ok:true,

		}),
		methods:{

			change(event){
				if(event) event.preventDefault();

				this.show.email=false;
				this.show.senha=true;
			}
		}
	}
</script>