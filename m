Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDC38CA0EC4
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 Aug 2025 09:21:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFF4F4026A;
	Tue, 12 Aug 2025 11:21:44 +0200 (CEST)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com
 [209.85.208.179])
 by mails.dpdk.org (Postfix) with ESMTP id 8CFD140264
 for <dev@dpdk.org>; Tue, 12 Aug 2025 11:21:42 +0200 (CEST)
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-333dde3fa8dso2140401fa.2
 for <dev@dpdk.org>; Tue, 12 Aug 2025 02:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754990502; x=1755595302; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=58BXkX/xGlCNPn6EQHngac3G4+JbveIM2qFz45Eg9Nw=;
 b=PxMZr+pKITMH1GLtXkMUxc1Sk8V1O70Ggj5XX8MgJHYWT//ozG5RcKenK+cOBSVKG1
 YqEsF9qODNknIB4uWvBcl/kc6BDfCyz77ic3rdoLryz738bRydmDQCw0x0E6pcJfZlps
 JGu9A7LfC/P+PpcwoMfj1eYW4fc9AkRCcx1WR21dMX44qK5xVodFQvzZiepXk+uWqvK+
 GZM3dv28PO8AySFd1ZOcJ4Ac1mvKxQRZBk/7FYZmpM/5FZfjnyYaVg9DPfmvmlWP5Uwn
 Q0lEpM80ZS2P8s7oyTUn3tMXnEbIkZ61aJURt++so/V2fkLnSLyvXIx/PEtamDSU85Ye
 oH9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754990502; x=1755595302;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=58BXkX/xGlCNPn6EQHngac3G4+JbveIM2qFz45Eg9Nw=;
 b=BDrVf94pM9wCQW16VJaWGLkWPxy81WdsHX5XYe9Oc0gfp+OIVIubbaC2AShPOZfF8w
 eYs2AWCuxfUMq0mVJM4fwck/iM/CULXKGgA5shCcXIuagV4JOiFs3Rjm9mPh770ABJYv
 19KC+kLUKbzgD9zn1cz5htx85eotLsA6yZaWJ83Wf6I/D5C5jCOqV8Cknxt3sjLr9XFO
 GUb5sWZn+RyZPio21Vf5QeBZuZnPzIrvc2lTO38RPJUr6uIfaZiolKEXU57vAEd1XeaS
 +C5Si6SOaZQYBwAsYdYAnVFTIUzKeidMCaP9qOqzT8hoX8g1B+0pojv6K5NpSmT1OFXp
 OZvw==
X-Gm-Message-State: AOJu0YwUa38bcT4avEeL4HGJO2nCq2Y+jZvvFOtDsaVc/wpgvBVaPU7K
 HPCpD+A092ti3OXA9bWuFqe4oT9vn+Q7EViGaQ8sYnqYH1Jxen5u39VIxve+6v7OG8+HvBEJh+l
 I4jRYGZaqSWPtdCJQwkTYo83EdHxzOlc=
X-Gm-Gg: ASbGncsh5eiUI0vv/V9rn2nRrsKUfSXXatSxfFN7NjvJ4+B0VJE0zkbQRG1LGIakxDQ
 FS/yaVuglNSm/bxkLm2HSxDjYV9Pr9OtuT330hQvO7atQx+TVpIfFRhiA4LIHPwgUh1w1quuUp6
 V6yT/2XCvIGEihd33AfJgyaN83qE+7oe7DyQqKYB5b1B3MurH/5+ns9aZa6sJFrUA/xfiPAqQvL
 ZYFpK4=
X-Google-Smtp-Source: AGHT+IEB+WWtGO9P/TNzindo33FUyJqEV8xW7YHLgsIJYGdWm+E8YSX2GeAm/lBwfohtNkQaL+UcdWqa35consRoQPQ=
X-Received: by 2002:a2e:ae11:0:b0:333:bab4:aa73 with SMTP id
 38308e7fff4ca-333d7d070eamr6964051fa.37.1754990501628; Tue, 12 Aug 2025
 02:21:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250701182033.642384-1-uk7b@foxmail.com>
 <tencent_78E26E08AE98768E000B338C8B474EB5C005@qq.com>
In-Reply-To: <tencent_78E26E08AE98768E000B338C8B474EB5C005@qq.com>
From: =?UTF-8?Q?Stanis=C5=82aw_Kardach?= <stanislaw.kardach@gmail.com>
Date: Tue, 12 Aug 2025 11:21:32 +0200
X-Gm-Features: Ac12FXw38QLOt4-rpo4ZWb4MCsXfXDco3LilKNwsj-3EHGgOC-cE2KtUwrrLQz8
Message-ID: <CAJcPQBojPCmyDHS0_rmK-kiiUtGJDTjA53FkQV=+yDayzb2wJw@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] lib/lpm: R-V V rte_lpm_lookupx4
To: uk7b@foxmail.com
Cc: dev@dpdk.org, Sun Yuechi <sunyuechi@iscas.ac.cn>, 
 Thomas Monjalon <thomas@monjalon.net>,
 Bruce Richardson <bruce.richardson@intel.com>, 
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Content-Type: multipart/alternative; boundary="0000000000006f0f92063c27917f"
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

--0000000000006f0f92063c27917f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 1 Jul 2025, 20:20 , <uk7b@foxmail.com> wrote:

> From: Sun Yuechi <sunyuechi@iscas.ac.cn>
>
> Implement LPM lookupx4 function for RISC-V architecture using RISC-V
> Vector Extension instruction set
>
> Signed-off-by: Sun Yuechi <sunyuechi@iscas.ac.cn>
>
Reviewed-by: Stanis=C5=82aw Kardach <stanislaw.kardach@gmail.com>

> ---
>  MAINTAINERS           |  2 ++
>  lib/lpm/meson.build   |  1 +
>  lib/lpm/rte_lpm.h     |  2 ++
>  lib/lpm/rte_lpm_rvv.h | 59 +++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 64 insertions(+)
>  create mode 100644 lib/lpm/rte_lpm_rvv.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 0e9357f3a3..9bd97879b6 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -341,6 +341,8 @@ M: Stanislaw Kardach <stanislaw.kardach@gmail.com>
>  F: config/riscv/
>  F: doc/guides/linux_gsg/cross_build_dpdk_for_riscv.rst
>  F: lib/eal/riscv/
> +M: sunyuechi <sunyuechi@iscas.ac.cn>
> +F: lib/**/*rvv*
>
>  Intel x86
>  M: Bruce Richardson <bruce.richardson@intel.com>
> diff --git a/lib/lpm/meson.build b/lib/lpm/meson.build
> index cff8fed473..c4522eaf0c 100644
> --- a/lib/lpm/meson.build
> +++ b/lib/lpm/meson.build
> @@ -11,6 +11,7 @@ indirect_headers +=3D files(
>          'rte_lpm_scalar.h',
>          'rte_lpm_sse.h',
>          'rte_lpm_sve.h',
> +        'rte_lpm_rvv.h',
>  )
>  deps +=3D ['hash']
>  deps +=3D ['rcu']
> diff --git a/lib/lpm/rte_lpm.h b/lib/lpm/rte_lpm.h
> index 6bf8d9d883..edfe77b458 100644
> --- a/lib/lpm/rte_lpm.h
> +++ b/lib/lpm/rte_lpm.h
> @@ -420,6 +420,8 @@ rte_lpm_lookupx4(const struct rte_lpm *lpm, xmm_t ip,
> uint32_t hop[4],
>  #include "rte_lpm_altivec.h"
>  #elif defined(RTE_ARCH_X86)
>  #include "rte_lpm_sse.h"
> +#elif defined(RTE_ARCH_RISCV) && defined(RTE_RISCV_FEATURE_V)
> +#include "rte_lpm_rvv.h"
>  #else
>  #include "rte_lpm_scalar.h"
>  #endif
> diff --git a/lib/lpm/rte_lpm_rvv.h b/lib/lpm/rte_lpm_rvv.h
> new file mode 100644
> index 0000000000..0d3dc91055
> --- /dev/null
> +++ b/lib/lpm/rte_lpm_rvv.h
> @@ -0,0 +1,59 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright (c) 2025 Institute of Software Chinese Academy of Sciences
> (ISCAS).
> + */
> +
> +#ifndef _RTE_LPM_RVV_H_
> +#define _RTE_LPM_RVV_H_
> +
> +#include <rte_vect.h>
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +#define RTE_LPM_LOOKUP_SUCCESS 0x01000000
> +#define RTE_LPM_VALID_EXT_ENTRY_BITMASK 0x03000000
> +
> +static inline void rte_lpm_lookupx4(
> +       const struct rte_lpm *lpm, xmm_t ip, uint32_t hop[4], uint32_t
> defv)
> +{
> +       size_t vl =3D 4;
> +
> +       const uint32_t *tbl24_p =3D (const uint32_t *)lpm->tbl24;
> +       uint32_t tbl_entries[4] =3D {
> +               tbl24_p[((uint32_t)ip[0]) >> 8],
> +               tbl24_p[((uint32_t)ip[1]) >> 8],
> +               tbl24_p[((uint32_t)ip[2]) >> 8],
> +               tbl24_p[((uint32_t)ip[3]) >> 8],
> +       };
> +       vuint32m1_t vtbl_entry =3D __riscv_vle32_v_u32m1(tbl_entries, vl)=
;
> +
> +       vbool32_t mask =3D __riscv_vmseq_vx_u32m1_b32(
> +           __riscv_vand_vx_u32m1(vtbl_entry,
> RTE_LPM_VALID_EXT_ENTRY_BITMASK, vl),
> +           RTE_LPM_VALID_EXT_ENTRY_BITMASK, vl);
> +
> +       vuint32m1_t vtbl8_index =3D __riscv_vsll_vx_u32m1(
> +           __riscv_vadd_vv_u32m1(
> +               __riscv_vsll_vx_u32m1(__riscv_vand_vx_u32m1(vtbl_entry,
> 0x00FFFFFF, vl), 8, vl),
> +               __riscv_vand_vx_u32m1(
> +                   __riscv_vle32_v_u32m1((const uint32_t *)&ip, vl),
> 0x000000FF, vl),
> +               vl),
> +           2, vl);
> +
> +       vtbl_entry =3D __riscv_vluxei32_v_u32m1_mu(
> +           mask, vtbl_entry, (const uint32_t *)(lpm->tbl8), vtbl8_index,
> vl);
> +
> +       vuint32m1_t vnext_hop =3D __riscv_vand_vx_u32m1(vtbl_entry,
> 0x00FFFFFF, vl);
> +       mask =3D __riscv_vmseq_vx_u32m1_b32(
> +           __riscv_vand_vx_u32m1(vtbl_entry, RTE_LPM_LOOKUP_SUCCESS, vl)=
,
> 0, vl);
> +
> +       vnext_hop =3D __riscv_vmerge_vxm_u32m1(vnext_hop, defv, mask, vl)=
;
> +
> +       __riscv_vse32_v_u32m1(hop, vnext_hop, vl);
> +}
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#endif /* _RTE_LPM_RVV_H_ */
> --
> 2.50.0
>
>

--0000000000006f0f92063c27917f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div><br><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, 1 Jul 2025, 20:20 , &lt;=
<a href=3D"mailto:uk7b@foxmail.com">uk7b@foxmail.com</a>&gt; wrote:<br></di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;borde=
r-left:1px solid rgb(204,204,204);padding-left:1ex">From: Sun Yuechi &lt;<a=
 href=3D"mailto:sunyuechi@iscas.ac.cn" target=3D"_blank" rel=3D"noreferrer"=
>sunyuechi@iscas.ac.cn</a>&gt;<br>
<br>
Implement LPM lookupx4 function for RISC-V architecture using RISC-V<br>
Vector Extension instruction set<br>
<br>
Signed-off-by: Sun Yuechi &lt;<a href=3D"mailto:sunyuechi@iscas.ac.cn" targ=
et=3D"_blank" rel=3D"noreferrer">sunyuechi@iscas.ac.cn</a>&gt;<br></blockqu=
ote></div></div><div dir=3D"auto">Reviewed-by: Stanis=C5=82aw Kardach &lt;<=
a href=3D"mailto:stanislaw.kardach@gmail.com">stanislaw.kardach@gmail.com</=
a>&gt;</div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_contain=
er"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 ++<br>
=C2=A0lib/lpm/meson.build=C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0lib/lpm/rte_lpm.h=C2=A0 =C2=A0 =C2=A0|=C2=A0 2 ++<br>
=C2=A0lib/lpm/rte_lpm_rvv.h | 59 ++++++++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A04 files changed, 64 insertions(+)<br>
=C2=A0create mode 100644 lib/lpm/rte_lpm_rvv.h<br>
<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index 0e9357f3a3..9bd97879b6 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -341,6 +341,8 @@ M: Stanislaw Kardach &lt;<a href=3D"mailto:stanislaw.ka=
rdach@gmail.com" target=3D"_blank" rel=3D"noreferrer">stanislaw.kardach@gma=
il.com</a>&gt;<br>
=C2=A0F: config/riscv/<br>
=C2=A0F: doc/guides/linux_gsg/cross_build_dpdk_for_riscv.rst<br>
=C2=A0F: lib/eal/riscv/<br>
+M: sunyuechi &lt;<a href=3D"mailto:sunyuechi@iscas.ac.cn" target=3D"_blank=
" rel=3D"noreferrer">sunyuechi@iscas.ac.cn</a>&gt;<br>
+F: lib/**/*rvv*<br>
<br>
=C2=A0Intel x86<br>
=C2=A0M: Bruce Richardson &lt;<a href=3D"mailto:bruce.richardson@intel.com"=
 target=3D"_blank" rel=3D"noreferrer">bruce.richardson@intel.com</a>&gt;<br=
>
diff --git a/lib/lpm/meson.build b/lib/lpm/meson.build<br>
index cff8fed473..c4522eaf0c 100644<br>
--- a/lib/lpm/meson.build<br>
+++ b/lib/lpm/meson.build<br>
@@ -11,6 +11,7 @@ indirect_headers +=3D files(<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;rte_lpm_scalar.h&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;rte_lpm_sse.h&#39;,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;rte_lpm_sve.h&#39;,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 &#39;rte_lpm_rvv.h&#39;,<br>
=C2=A0)<br>
=C2=A0deps +=3D [&#39;hash&#39;]<br>
=C2=A0deps +=3D [&#39;rcu&#39;]<br>
diff --git a/lib/lpm/rte_lpm.h b/lib/lpm/rte_lpm.h<br>
index 6bf8d9d883..edfe77b458 100644<br>
--- a/lib/lpm/rte_lpm.h<br>
+++ b/lib/lpm/rte_lpm.h<br>
@@ -420,6 +420,8 @@ rte_lpm_lookupx4(const struct rte_lpm *lpm, xmm_t ip, u=
int32_t hop[4],<br>
=C2=A0#include &quot;rte_lpm_altivec.h&quot;<br>
=C2=A0#elif defined(RTE_ARCH_X86)<br>
=C2=A0#include &quot;rte_lpm_sse.h&quot;<br>
+#elif defined(RTE_ARCH_RISCV) &amp;&amp; defined(RTE_RISCV_FEATURE_V)<br>
+#include &quot;rte_lpm_rvv.h&quot;<br>
=C2=A0#else<br>
=C2=A0#include &quot;rte_lpm_scalar.h&quot;<br>
=C2=A0#endif<br>
diff --git a/lib/lpm/rte_lpm_rvv.h b/lib/lpm/rte_lpm_rvv.h<br>
new file mode 100644<br>
index 0000000000..0d3dc91055<br>
--- /dev/null<br>
+++ b/lib/lpm/rte_lpm_rvv.h<br>
@@ -0,0 +1,59 @@<br>
+/* SPDX-License-Identifier: BSD-3-Clause<br>
+ * Copyright (c) 2025 Institute of Software Chinese Academy of Sciences (I=
SCAS).<br>
+ */<br>
+<br>
+#ifndef _RTE_LPM_RVV_H_<br>
+#define _RTE_LPM_RVV_H_<br>
+<br>
+#include &lt;rte_vect.h&gt;<br>
+<br>
+#ifdef __cplusplus<br>
+extern &quot;C&quot; {<br>
+#endif<br>
+<br>
+#define RTE_LPM_LOOKUP_SUCCESS 0x01000000<br>
+#define RTE_LPM_VALID_EXT_ENTRY_BITMASK 0x03000000<br>
+<br>
+static inline void rte_lpm_lookupx4(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0const struct rte_lpm *lpm, xmm_t ip, uint32_t h=
op[4], uint32_t defv)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0size_t vl =3D 4;<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0const uint32_t *tbl24_p =3D (const uint32_t *)l=
pm-&gt;tbl24;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t tbl_entries[4] =3D {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tbl24_p[((uint32_t)=
ip[0]) &gt;&gt; 8],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tbl24_p[((uint32_t)=
ip[1]) &gt;&gt; 8],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tbl24_p[((uint32_t)=
ip[2]) &gt;&gt; 8],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tbl24_p[((uint32_t)=
ip[3]) &gt;&gt; 8],<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0};<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0vuint32m1_t vtbl_entry =3D __riscv_vle32_v_u32m=
1(tbl_entries, vl);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0vbool32_t mask =3D __riscv_vmseq_vx_u32m1_b32(<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__riscv_vand_vx_u32m1(vtbl_entry,=
 RTE_LPM_VALID_EXT_ENTRY_BITMASK, vl),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_LPM_VALID_EXT_ENTRY_BITMASK, =
vl);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0vuint32m1_t vtbl8_index =3D __riscv_vsll_vx_u32=
m1(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__riscv_vadd_vv_u32m1(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__riscv_vsll_vx_u32=
m1(__riscv_vand_vx_u32m1(vtbl_entry, 0x00FFFFFF, vl), 8, vl),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__riscv_vand_vx_u32=
m1(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__ris=
cv_vle32_v_u32m1((const uint32_t *)&amp;ip, vl), 0x000000FF, vl),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vl),<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A02, vl);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0vtbl_entry =3D __riscv_vluxei32_v_u32m1_mu(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0mask, vtbl_entry, (const uint32_t=
 *)(lpm-&gt;tbl8), vtbl8_index, vl);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0vuint32m1_t vnext_hop =3D __riscv_vand_vx_u32m1=
(vtbl_entry, 0x00FFFFFF, vl);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0mask =3D __riscv_vmseq_vx_u32m1_b32(<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__riscv_vand_vx_u32m1(vtbl_entry,=
 RTE_LPM_LOOKUP_SUCCESS, vl), 0, vl);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0vnext_hop =3D __riscv_vmerge_vxm_u32m1(vnext_ho=
p, defv, mask, vl);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__riscv_vse32_v_u32m1(hop, vnext_hop, vl);<br>
+}<br>
+<br>
+#ifdef __cplusplus<br>
+}<br>
+#endif<br>
+<br>
+#endif /* _RTE_LPM_RVV_H_ */<br>
-- <br>
2.50.0<br>
<br>
</blockquote></div></div></div>

--0000000000006f0f92063c27917f--
