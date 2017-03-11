<template>
<div>
        <nav class="open" @click="open" v-bind:class="{openned: isActive }" >
            <span class="cls"></span>
            <span>
                <ul class="sub-menu">
                    <li>
                        <a href="#inicio" title="inicio">Inicio</a>
                    </li>
                    <li>
                        <a href="#sobre" title="sobre">myBookmarks</a>
                    </li>
                    <li>
                        <a href="#practices" title="practices">Boas Práticas</a>
                    </li>
                    <li>
                        <a href="#login"  @click="login" title="login">Login</a>
                    </li>
                </ul>
            </span>
            <span class="cls"></span>
        </nav>
<login v-if="ok===true"></login> 
</div>       
</template>

<script>
import Login from "./auth/login"

module.exports= {
data: ()=> ({

    isActive: false,
    ok:false
}),
methods:{

    open(event){
        this.isActive=!this.isActive;
    },
    login(event){
        this.ok=!this.ok;
    }
},
components:{Login}
};
/*
var animate=(function(){

    var TxtType = function(el, toRotate, period) {
            this.toRotate = toRotate;
            this.el = el;
            this.loopNum = 0;
            this.period = parseInt(period, 10) || 2000;
            this.txt = '';
            this.tick();
            this.isDeleting = false;
        };

        TxtType.prototype.tick = function() {
            var i = this.loopNum % this.toRotate.length;
            var fullTxt = this.toRotate[i];

            if (this.isDeleting) {
            this.txt = fullTxt.substring(0, this.txt.length - 1);
            } else {
            this.txt = fullTxt.substring(0, this.txt.length + 1);
            }

            this.el.innerHTML = '<span class="wrap">'+this.txt+'</span>';

            var that = this;
            var delta = 200 - Math.random() * 100;

            if (this.isDeleting) { delta /= 2; }

            if (!this.isDeleting && this.txt === fullTxt) {
            delta = this.period;
            this.isDeleting = true;
            } else if (this.isDeleting && this.txt === '') {
            this.isDeleting = false;
            this.loopNum++;
            delta = 500;
            }

            setTimeout(function() {
            that.tick();
            }, delta);
        };

        window.onload = function() {
            var elements = document.getElementsByClassName('typewrite');
            var el = document.getElementsByClassName('typed');

            for (var i=0; i<elements.length; i++) {
                var toRotate = elements[i].getAttribute('data-type');
                var period = elements[i].getAttribute('data-period');
                if (toRotate) {
                  new TxtType(elements[i], JSON.parse(toRotate), period);
                }
            }
            for (var j=0;j<el.length; j++) {
                var text=el[j].getAttribute('data-text');
                tick(el[j],text);
            }
            // INJECT CSS
            var css = document.createElement("style");
            css.type = "text/css";
            css.innerHTML = ".typewrite > .wrap { border-right: 0.08em solid #fff}";
            document.body.appendChild(css);
        }

    });//animate

animate(); */

</script>

