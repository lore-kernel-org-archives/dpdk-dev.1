Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8433CA0EC4
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 Aug 2025 09:22:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0BE04026A;
	Tue, 12 Aug 2025 11:22:04 +0200 (CEST)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com
 [209.85.208.174])
 by mails.dpdk.org (Postfix) with ESMTP id 33DAB40264
 for <dev@dpdk.org>; Tue, 12 Aug 2025 11:22:03 +0200 (CEST)
Received: by mail-lj1-f174.google.com with SMTP id
 38308e7fff4ca-3322d10e29dso42566731fa.0
 for <dev@dpdk.org>; Tue, 12 Aug 2025 02:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754990523; x=1755595323; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=XJC6iIjMm7K1cZ/Nkwq272KHJF0hZ8jGZ8QKUwyjLTQ=;
 b=GXHliRhDGNNuHlTBoYchVhO9IcGfeBQ6dVLs9wB/5zZ2a/ZIWRwIRpgPTrl41w5jYE
 8mDHOCn8HQnlmZQJwncY6RgoUkpWS8uG2xHJoT5LjdZ7UBxVHDZvHZv+14zvyafS8VN2
 f9dVNLyvs5nbp4J72imCF1xItO5UjklmLugUuANwFV8sqNUu6HJ9HBc5fLxIHcWZ+g6N
 8ldMoQdmNjddkd0iijqCYpJ4EDXlF8R5Ivu1Xk156GU146expaaSTYnOkCGOe/1ovaAW
 eikUbW96wAsGys7qpHNeBuWEc/Bz4TNBbdKWr4r8uf6VTzGGLKcvn75/ZFdPSKH65Rz2
 Truw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754990523; x=1755595323;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XJC6iIjMm7K1cZ/Nkwq272KHJF0hZ8jGZ8QKUwyjLTQ=;
 b=E97c9F9O/eqJ5df9aoucYgKpCOHj5nakUfzB8xxsjeJubi6gCoWL2qvIBX8cq9vD3r
 YvlXSHjT1YQxLsJnl5tNIzsW4c3wx2boiyImkrhw8ePA9EGOTzgKSVG+eLiXfs0Z0aFQ
 GjaqCMyFyeiHU9U83EoicWkvbFlRcUYb9/THNQ1Dbwf2MVoW4oix+Zt522WszoioD63c
 K8TFn5s+ZQ5MyAmcudIKPQ/Zu3Hl4oJ5HePfEB3ruYTm7pKkHl1vSkuK0/kv54Oz83K4
 FIBim+gtvziYxvBu2lMiciUo/8Ad7yMveDkRC9UQMBxzt5QncA54qjVmIbzrbnKioXZR
 SteQ==
X-Gm-Message-State: AOJu0YxQjeFKa5HewPGGLTJV0ABH/mae4lu6odKlsFAJC3wqSNVQu3rM
 TD/ZB10CIlZIKcbV7MsFKhfoofeCZUc5B9MPG3Yswq5sO3k6wn/zBtx36gMy1yOAuMpr9virQ6G
 PTl32rRK2R5sb3M0UU7YQ/Ru6dqSbj4Q=
X-Gm-Gg: ASbGncuXZr/+QJa12u65OV3daR0zpaFxjTKDmgPEHx20j7pRJbnrcyfKBldIt3eVjza
 GzxQlJ1ySVHkZ5lUg/9RiTcVqm1u5/0/nCg/y++Ryw7NPMbKe0o5ZYVKT10QvNuasMMLoARk66D
 crCplbJuyQdASXi9UEC8ujfajTaqKN2AJ5d0JYDBcLgdu3i2CmhjC1zfm7oNHm96UQ7IBb3IDDg
 fFWZqQ=
X-Google-Smtp-Source: AGHT+IGUcMzsNoFN3dgDHedn/K7GdTMuYl+K06Nhi/UR/5gEObHiExOScZ6PK/c4dR+O0jyfr/XnqMfSIRFU8izRxzE=
X-Received: by 2002:a05:651c:4197:b0:32b:2f4a:35e4 with SMTP id
 38308e7fff4ca-333d7bf2424mr7009271fa.34.1754990522422; Tue, 12 Aug 2025
 02:22:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250701182033.642384-1-uk7b@foxmail.com>
 <tencent_512AC2D478AA548B2D4487968A1FE662B109@qq.com>
In-Reply-To: <tencent_512AC2D478AA548B2D4487968A1FE662B109@qq.com>
From: =?UTF-8?Q?Stanis=C5=82aw_Kardach?= <stanislaw.kardach@gmail.com>
Date: Tue, 12 Aug 2025 11:21:53 +0200
X-Gm-Features: Ac12FXxAo5Zv6hbgbPOZasqqXcAMuZmw-xeBG2lEaevWh4Qep3IJYa_MBnrGXmk
Message-ID: <CAJcPQBoWE2quf_xWMcmRVazRrj9okV_BJsM4pFt30EP9FbyFsA@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] config/riscv: detect V extension
To: uk7b@foxmail.com
Cc: dev@dpdk.org, Sun Yuechi <sunyuechi@iscas.ac.cn>, 
 Thomas Monjalon <thomas@monjalon.net>,
 Bruce Richardson <bruce.richardson@intel.com>
Content-Type: multipart/alternative; boundary="000000000000ac5c45063c2792d4"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

--000000000000ac5c45063c2792d4
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 1 Jul 2025, 20:21 , <uk7b@foxmail.com> wrote:

> From: Sun Yuechi <sunyuechi@iscas.ac.cn>
>
> This patch is derived from "config/riscv: detect presence of Zbc
> extension with modifications".
>
> The RISC-V C api defines architecture extension test macros
> These let us detect whether the V extension is supported on the
> compiler and -march we're building with. The C api also defines V
> intrinsics we can use rather than inline assembly on newer versions of
> GCC (14.1.0+) and Clang (18.1.0+).
>
> If the V extension and intrinsics are both present and we can detect
> the V extension at runtime, we define a flag, RTE_RISCV_FEATURE_V.
>
> Signed-off-by: Sun Yuechi <sunyuechi@iscas.ac.cn>
>
Reviewed-by: Stanis=C5=82aw Kardach <stanislaw.kardach@gmail.com>

> ---
>  .mailmap                         |  1 +
>  config/riscv/meson.build         | 25 +++++++++++++++++++++++++
>  lib/eal/riscv/include/rte_vect.h |  4 ++++
>  3 files changed, 30 insertions(+)
>
> diff --git a/.mailmap b/.mailmap
> index 8483d96ec5..21f5d7fb5e 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -1513,6 +1513,7 @@ Sunil Kumar Kori <skori@marvell.com> <
> skori@mavell.com> <sunil.kori@nxp.com>
>  Sunil Pai G <sunil.pai.g@intel.com>
>  Sunil Uttarwar <sunilprakashrao.uttarwar@amd.com>
>  Sun Jiajia <sunx.jiajia@intel.com>
> +Sun Yuechi <sunyuechi@iscas.ac.cn> <uk7b@foxmail.com>
>  Sunyang Wu <sunyang.wu@jaguarmicro.com>
>  Surabhi Boob <surabhi.boob@intel.com>
>  Suyang Ju <sju@paloaltonetworks.com>
> diff --git a/config/riscv/meson.build b/config/riscv/meson.build
> index 7562c6cb99..e3694cf2e6 100644
> --- a/config/riscv/meson.build
> +++ b/config/riscv/meson.build
> @@ -119,6 +119,31 @@ foreach flag: arch_config['machine_args']
>      endif
>  endforeach
>
> +# check if we can do buildtime detection of extensions supported by the
> target
> +riscv_extension_macros =3D false
> +if (cc.get_define('__riscv_arch_test', args: machine_args) =3D=3D '1')
> +  message('Detected architecture extension test macros')
> +  riscv_extension_macros =3D true
> +else
> +  warning('RISC-V architecture extension test macros not available.
> Build-time detection of extensions not possible')
> +endif
> +
> +# detect extensions
> +# Requires intrinsics available in GCC 14.1.0+ and Clang 18.1.0+
> +if (riscv_extension_macros and
> +    (cc.get_define('__riscv_vector', args: machine_args) !=3D ''))
> +  if ((cc.get_id() =3D=3D 'gcc' and cc.version().version_compare('>=3D14=
.1.0'))
> +      or (cc.get_id() =3D=3D 'clang' and
> cc.version().version_compare('>=3D18.1.0')))
> +    if (cc.compiles('''#include <riscv_vector.h>
> +        int main(void) { size_t vl =3D __riscv_vsetvl_e32m1(1); }''', ar=
gs:
> machine_args))
> +      message('Compiling with the V extension')
> +      machine_args +=3D ['-DRTE_RISCV_FEATURE_V']
> +    endif
> +  else
> +    warning('Detected V extension but cannot use because intrinsics are
> not available (present in GCC 14.1.0+ and Clang 18.1.0+)')
> +  endif
> +endif
> +
>  # apply flags
>  foreach flag: dpdk_flags
>      if flag.length() > 0
> diff --git a/lib/eal/riscv/include/rte_vect.h
> b/lib/eal/riscv/include/rte_vect.h
> index 6df10fa8ee..a4357e266a 100644
> --- a/lib/eal/riscv/include/rte_vect.h
> +++ b/lib/eal/riscv/include/rte_vect.h
> @@ -11,6 +11,10 @@
>  #include "generic/rte_vect.h"
>  #include "rte_common.h"
>
> +#ifdef RTE_RISCV_FEATURE_V
> +#include <riscv_vector.h>
> +#endif
> +
>  #ifdef __cplusplus
>  extern "C" {
>  #endif
> --
> 2.50.0
>
>

--000000000000ac5c45063c2792d4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, 1 Jul 2025, 20:21 , &lt;=
<a href=3D"mailto:uk7b@foxmail.com">uk7b@foxmail.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">From: Sun Yuechi &lt;<a=
 href=3D"mailto:sunyuechi@iscas.ac.cn" target=3D"_blank" rel=3D"noreferrer"=
>sunyuechi@iscas.ac.cn</a>&gt;<br>
<br>
This patch is derived from &quot;config/riscv: detect presence of Zbc<br>
extension with modifications&quot;.<br>
<br>
The RISC-V C api defines architecture extension test macros<br>
These let us detect whether the V extension is supported on the<br>
compiler and -march we&#39;re building with. The C api also defines V<br>
intrinsics we can use rather than inline assembly on newer versions of<br>
GCC (14.1.0+) and Clang (18.1.0+).<br>
<br>
If the V extension and intrinsics are both present and we can detect<br>
the V extension at runtime, we define a flag, RTE_RISCV_FEATURE_V.<br>
<br>
Signed-off-by: Sun Yuechi &lt;<a href=3D"mailto:sunyuechi@iscas.ac.cn" targ=
et=3D"_blank" rel=3D"noreferrer">sunyuechi@iscas.ac.cn</a>&gt;<br></blockqu=
ote></div></div><div dir=3D"auto">Reviewed-by: Stanis=C5=82aw Kardach &lt;<=
a href=3D"mailto:stanislaw.kardach@gmail.com">stanislaw.kardach@gmail.com</=
a>&gt;</div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_contain=
er"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0.mailmap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0config/riscv/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 25 ++++++=
+++++++++++++++++++<br>
=C2=A0lib/eal/riscv/include/rte_vect.h |=C2=A0 4 ++++<br>
=C2=A03 files changed, 30 insertions(+)<br>
<br>
diff --git a/.mailmap b/.mailmap<br>
index 8483d96ec5..21f5d7fb5e 100644<br>
--- a/.mailmap<br>
+++ b/.mailmap<br>
@@ -1513,6 +1513,7 @@ Sunil Kumar Kori &lt;<a href=3D"mailto:skori@marvell.=
com" target=3D"_blank" rel=3D"noreferrer">skori@marvell.com</a>&gt; &lt;<a =
href=3D"mailto:skori@mavell.com" target=3D"_blank" rel=3D"noreferrer">skori=
@mavell.com</a>&gt; &lt;<a href=3D"mailto:sunil.kori@nxp.com" target=3D"_bl=
ank" rel=3D"noreferrer">sunil.kori@nxp.com</a>&gt;<br>
=C2=A0Sunil Pai G &lt;<a href=3D"mailto:sunil.pai.g@intel.com" target=3D"_b=
lank" rel=3D"noreferrer">sunil.pai.g@intel.com</a>&gt;<br>
=C2=A0Sunil Uttarwar &lt;<a href=3D"mailto:sunilprakashrao.uttarwar@amd.com=
" target=3D"_blank" rel=3D"noreferrer">sunilprakashrao.uttarwar@amd.com</a>=
&gt;<br>
=C2=A0Sun Jiajia &lt;<a href=3D"mailto:sunx.jiajia@intel.com" target=3D"_bl=
ank" rel=3D"noreferrer">sunx.jiajia@intel.com</a>&gt;<br>
+Sun Yuechi &lt;<a href=3D"mailto:sunyuechi@iscas.ac.cn" target=3D"_blank" =
rel=3D"noreferrer">sunyuechi@iscas.ac.cn</a>&gt; &lt;<a href=3D"mailto:uk7b=
@foxmail.com" target=3D"_blank" rel=3D"noreferrer">uk7b@foxmail.com</a>&gt;=
<br>
=C2=A0Sunyang Wu &lt;<a href=3D"mailto:sunyang.wu@jaguarmicro.com" target=
=3D"_blank" rel=3D"noreferrer">sunyang.wu@jaguarmicro.com</a>&gt;<br>
=C2=A0Surabhi Boob &lt;<a href=3D"mailto:surabhi.boob@intel.com" target=3D"=
_blank" rel=3D"noreferrer">surabhi.boob@intel.com</a>&gt;<br>
=C2=A0Suyang Ju &lt;<a href=3D"mailto:sju@paloaltonetworks.com" target=3D"_=
blank" rel=3D"noreferrer">sju@paloaltonetworks.com</a>&gt;<br>
diff --git a/config/riscv/meson.build b/config/riscv/meson.build<br>
index 7562c6cb99..e3694cf2e6 100644<br>
--- a/config/riscv/meson.build<br>
+++ b/config/riscv/meson.build<br>
@@ -119,6 +119,31 @@ foreach flag: arch_config[&#39;machine_args&#39;]<br>
=C2=A0 =C2=A0 =C2=A0endif<br>
=C2=A0endforeach<br>
<br>
+# check if we can do buildtime detection of extensions supported by the ta=
rget<br>
+riscv_extension_macros =3D false<br>
+if (cc.get_define(&#39;__riscv_arch_test&#39;, args: machine_args) =3D=3D =
&#39;1&#39;)<br>
+=C2=A0 message(&#39;Detected architecture extension test macros&#39;)<br>
+=C2=A0 riscv_extension_macros =3D true<br>
+else<br>
+=C2=A0 warning(&#39;RISC-V architecture extension test macros not availabl=
e. Build-time detection of extensions not possible&#39;)<br>
+endif<br>
+<br>
+# detect extensions<br>
+# Requires intrinsics available in GCC 14.1.0+ and Clang 18.1.0+<br>
+if (riscv_extension_macros and<br>
+=C2=A0 =C2=A0 (cc.get_define(&#39;__riscv_vector&#39;, args: machine_args)=
 !=3D &#39;&#39;))<br>
+=C2=A0 if ((cc.get_id() =3D=3D &#39;gcc&#39; and cc.version().version_comp=
are(&#39;&gt;=3D14.1.0&#39;))<br>
+=C2=A0 =C2=A0 =C2=A0 or (cc.get_id() =3D=3D &#39;clang&#39; and cc.version=
().version_compare(&#39;&gt;=3D18.1.0&#39;)))<br>
+=C2=A0 =C2=A0 if (cc.compiles(&#39;&#39;&#39;#include &lt;riscv_vector.h&g=
t;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int main(void) { size_t vl =3D __riscv_vsetvl_=
e32m1(1); }&#39;&#39;&#39;, args: machine_args))<br>
+=C2=A0 =C2=A0 =C2=A0 message(&#39;Compiling with the V extension&#39;)<br>
+=C2=A0 =C2=A0 =C2=A0 machine_args +=3D [&#39;-DRTE_RISCV_FEATURE_V&#39;]<b=
r>
+=C2=A0 =C2=A0 endif<br>
+=C2=A0 else<br>
+=C2=A0 =C2=A0 warning(&#39;Detected V extension but cannot use because int=
rinsics are not available (present in GCC 14.1.0+ and Clang 18.1.0+)&#39;)<=
br>
+=C2=A0 endif<br>
+endif<br>
+<br>
=C2=A0# apply flags<br>
=C2=A0foreach flag: dpdk_flags<br>
=C2=A0 =C2=A0 =C2=A0if flag.length() &gt; 0<br>
diff --git a/lib/eal/riscv/include/rte_vect.h b/lib/eal/riscv/include/rte_v=
ect.h<br>
index 6df10fa8ee..a4357e266a 100644<br>
--- a/lib/eal/riscv/include/rte_vect.h<br>
+++ b/lib/eal/riscv/include/rte_vect.h<br>
@@ -11,6 +11,10 @@<br>
=C2=A0#include &quot;generic/rte_vect.h&quot;<br>
=C2=A0#include &quot;rte_common.h&quot;<br>
<br>
+#ifdef RTE_RISCV_FEATURE_V<br>
+#include &lt;riscv_vector.h&gt;<br>
+#endif<br>
+<br>
=C2=A0#ifdef __cplusplus<br>
=C2=A0extern &quot;C&quot; {<br>
=C2=A0#endif<br>
-- <br>
2.50.0<br>
<br>
</blockquote></div></div></div>

--000000000000ac5c45063c2792d4--
