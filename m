Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E166C87FCB
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 Aug 2025 09:22:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 600FA4026A;
	Tue, 12 Aug 2025 11:22:52 +0200 (CEST)
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com
 [209.85.167.46]) by mails.dpdk.org (Postfix) with ESMTP id 6AD4640264
 for <dev@dpdk.org>; Tue, 12 Aug 2025 11:22:51 +0200 (CEST)
Received: by mail-lf1-f46.google.com with SMTP id
 2adb3069b0e04-55ccc6964c9so2533302e87.0
 for <dev@dpdk.org>; Tue, 12 Aug 2025 02:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754990571; x=1755595371; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LUpqrVaA1S67pjKSZs9m1uQesqtoJn5UTdPDzbp93Bc=;
 b=alTGtA+EG2gLiPR/zcXiT7+Qbz/N8cneI/iiuncRIxbNQkrfvn4GYYqSKFr7bx9nj/
 AVrf2HTWKwQt+sLROgsDoipiIybCBZQplLvlKWXg0e8X3/G7vbw7TDL3/zWmSFzL8Ff+
 cOsbTMoMAaQmYKKSJQssXYQuTtt/3rE5nj5MbLYmjLiTaytEkvxXDrNwW0RaVb960CKv
 YyZjOBtpS8D/KX8QpgdVikFA5572eKs0VPspA6bFUACplymzG+JHY+pWsFmUSjjcVxqV
 fHEpY4qZywN+XV5AAnbChrY29VYP7DCxBf3eTAEUuSaPKkYiSwjiwj3hJM+x874qJVvi
 xnuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754990571; x=1755595371;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LUpqrVaA1S67pjKSZs9m1uQesqtoJn5UTdPDzbp93Bc=;
 b=CTsVPeGAC560NOOfaA0KpMokNpzm4pfmRbkfArjc09W9y6jzJ/lG9coZ+OR0GgT7Jt
 HHpVAGy957sT7XBfcQdYfFt/0fP1PNMfn8O/3TfaC8CBnqgIkxMUuuN6VDWT2Wa+AjNA
 2A4G383EV/44ydl44kXf8lAbH6hFTQ+S29RYWfAPkw0/tKkDo1ggH4E67WOe52RcXOm0
 +2r/+hhU929NnquXDIywPagn6qHhsIXxeAYtCscojxH1Egc8IY4s5bWPS8Ta/9Lj+IJW
 k8U9LFK3yskBuzwja91HUra9ikcZVyiRIotDpSEaoODX6YCcribpwKxcQSCJ5gCEXoJ8
 YYNQ==
X-Gm-Message-State: AOJu0Yy2M1d37Gjq+OPJ+aZdvqlHd6y38+sDxyCZoe/MpHBxP8+YLcFI
 xDywhPUqwQDWRmd1JXIeC1Yy1V3MPA3mN5qNApz8iVrS3ZuiayHZsIf0SrxOPBH1fXLFnk5KEQJ
 9imSKhfPEtMPYNPrFL/YisMxPAlhEAh0=
X-Gm-Gg: ASbGncsMQMek5kErB9Nu98fbdyiItI1BQcpqWDPUyF/kydJLr7IQevXCt950+1Qqnbp
 zgYn7w7AbFgylX9RJCGhdTERBcIjCQCxvjas6dJkSq87HAjkgJOFne4dpIOC/h3AjJtptqq/9Bx
 iPwsQzhOEuql5jldItwmoFF9ZC+9PQ5ayEGY6HVlSbGzeXagwOS3Qaw7s1QrFt3kytF9lZfp3rt
 xFwals=
X-Google-Smtp-Source: AGHT+IGRMf1tqi50Wz5YKw58Iyyg8pMmIbfatEj+gQ4hIWtAdmzUutXhJwQ8l0uEUo5nNfTPIqxKVG5vkNYZ7tbuSxc=
X-Received: by 2002:a05:6512:3041:b0:55b:5eda:2e9 with SMTP id
 2adb3069b0e04-55cd763b678mr908519e87.36.1754990570465; Tue, 12 Aug 2025
 02:22:50 -0700 (PDT)
MIME-Version: 1.0
References: <20250701182033.642384-1-uk7b@foxmail.com>
 <tencent_3E73B758DC611A3C43AA4016704308C54E08@qq.com>
In-Reply-To: <tencent_3E73B758DC611A3C43AA4016704308C54E08@qq.com>
From: =?UTF-8?Q?Stanis=C5=82aw_Kardach?= <stanislaw.kardach@gmail.com>
Date: Tue, 12 Aug 2025 11:22:39 +0200
X-Gm-Features: Ac12FXxl9aVddCEEiHQ2I5e2Aw5zJ1A4aK5knzh36n57hh58SlTVcvbHhD3AhaU
Message-ID: <CAJcPQBoLZAMdAwATEY59m+bsU_LrZd_EktTpSExzcuwxXVP-PA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] lib/fib: R-V V rte_fib_lookup_bulk
To: uk7b@foxmail.com
Cc: dev@dpdk.org, Sun Yuechi <sunyuechi@iscas.ac.cn>, 
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Content-Type: multipart/alternative; boundary="0000000000008970e3063c279569"
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

--0000000000008970e3063c279569
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 1 Jul 2025, 20:21 , <uk7b@foxmail.com> wrote:

> From: Sun Yuechi <sunyuechi@iscas.ac.cn>
>
> Implement rte_fib_lookup_bulk function for RISC-V architecture using RISC=
-V
> Vector Extension instruction set
>
> Signed-off-by: Sun Yuechi <sunyuechi@iscas.ac.cn>
>
From RISC-V perspective:

Reviewed-by: Stanis=C5=82aw Kardach <stanislaw.kardach@gmail.com>

> ---
>  lib/fib/dir24_8.c     | 20 ++++++++++++++
>  lib/fib/dir24_8_rvv.c | 64 +++++++++++++++++++++++++++++++++++++++++++
>  lib/fib/dir24_8_rvv.h | 24 ++++++++++++++++
>  lib/fib/meson.build   |  2 ++
>  4 files changed, 110 insertions(+)
>  create mode 100644 lib/fib/dir24_8_rvv.c
>  create mode 100644 lib/fib/dir24_8_rvv.h
>
> diff --git a/lib/fib/dir24_8.c b/lib/fib/dir24_8.c
> index 2ba7e93511..c652d3ca98 100644
> --- a/lib/fib/dir24_8.c
> +++ b/lib/fib/dir24_8.c
> @@ -20,6 +20,10 @@
>
>  #include "dir24_8_avx512.h"
>
> +#elif defined(RTE_RISCV_FEATURE_V)
> +
> +#include "dir24_8_rvv.h"
> +
>  #endif /* CC_AVX512_SUPPORT */
>
>  #define DIR24_8_NAMESIZE       64
> @@ -88,6 +92,22 @@ get_vector_fn(enum rte_fib_dir24_8_nh_sz nh_sz, bool
> be_addr)
>         default:
>                 return NULL;
>         }
> +#elif defined(RTE_RISCV_FEATURE_V)
> +       RTE_SET_USED(be_addr);
> +       if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_RISCV_ISA_V) <=3D 0)
> +               return NULL;
> +       switch (nh_sz) {
> +       case RTE_FIB_DIR24_8_1B:
> +               return rte_dir24_8_vec_lookup_bulk_1b;
> +       case RTE_FIB_DIR24_8_2B:
> +               return rte_dir24_8_vec_lookup_bulk_2b;
> +       case RTE_FIB_DIR24_8_4B:
> +               return rte_dir24_8_vec_lookup_bulk_4b;
> +       case RTE_FIB_DIR24_8_8B:
> +               return rte_dir24_8_vec_lookup_bulk_8b;
> +       default:
> +               return NULL;
> +       }
>  #else
>         RTE_SET_USED(nh_sz);
>         RTE_SET_USED(be_addr);
> diff --git a/lib/fib/dir24_8_rvv.c b/lib/fib/dir24_8_rvv.c
> new file mode 100644
> index 0000000000..9c14ca0481
> --- /dev/null
> +++ b/lib/fib/dir24_8_rvv.c
> @@ -0,0 +1,64 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright (c) 2025 Institute of Software Chinese Academy of Sciences
> (ISCAS).
> + */
> +
> +#if defined(RTE_RISCV_FEATURE_V)
> +
> +#include <rte_vect.h>
> +#include <rte_fib.h>
> +
> +#include "dir24_8.h"
> +#include "dir24_8_rvv.h"
> +
> +#define DECLARE_VECTOR_FN(SFX, NH_SZ) \
> +void \
> +rte_dir24_8_vec_lookup_bulk_##SFX(void *p, \
> +               const uint32_t *ips, uint64_t *next_hops, unsigned int n)=
 \
> +{ \
> +       const uint8_t  idx_bits =3D 3 - NH_SZ; \
> +       const uint32_t idx_mask =3D (1u << (3 - NH_SZ)) - 1u; \
> +       const uint64_t e_mask   =3D ~0ULL >> (64 - (8u << NH_SZ)); \
> +       struct dir24_8_tbl *tbl =3D (struct dir24_8_tbl *)p; \
> +       const uint64_t *tbl24   =3D tbl->tbl24; \
> +       size_t vl; \
> +       for (unsigned int i =3D 0; i < n; i +=3D vl) { \
> +               vl =3D __riscv_vsetvl_e32m4(n - i); \
> +               vuint32m4_t v_ips =3D __riscv_vle32_v_u32m4(&ips[i], vl);=
 \
> +               vuint64m8_t vtbl_word =3D __riscv_vluxei32_v_u64m8(tbl24,=
 \
> +                               __riscv_vsll_vx_u32m4( \
> +                               __riscv_vsrl_vx_u32m4(v_ips, idx_bits + 8=
,
> vl), 3, vl), vl); \
> +               vuint32m4_t v_tbl_index =3D __riscv_vsrl_vx_u32m4(v_ips, =
8,
> vl); \
> +               vuint32m4_t v_entry_idx =3D
> __riscv_vand_vx_u32m4(v_tbl_index, idx_mask, vl); \
> +               vuint32m4_t v_shift     =3D
> __riscv_vsll_vx_u32m4(v_entry_idx, 3 + NH_SZ, vl); \
> +               vuint64m8_t vtbl_entry  =3D __riscv_vand_vx_u64m8( \
> +                               __riscv_vsrl_vv_u64m8(vtbl_word, \
> +
>  __riscv_vwcvtu_x_x_v_u64m8(v_shift, vl), vl), e_mask, vl); \
> +               vbool8_t mask =3D __riscv_vmseq_vx_u64m8_b8( \
> +                               __riscv_vand_vx_u64m8(vtbl_entry, 1, vl),
> 1, vl); \
> +               if (__riscv_vcpop_m_b8(mask, vl)) { \
> +                       const uint64_t *tbl8 =3D tbl->tbl8; \
> +                       v_tbl_index =3D __riscv_vadd_vv_u32m4_mu(mask,
> v_tbl_index, \
> +                                       __riscv_vsll_vx_u32m4( \
> +
>  __riscv_vnsrl_wx_u32m4(vtbl_entry, 1, vl), 8, vl), \
> +
>  __riscv_vand_vx_u32m4(v_ips, 0xFF, vl), vl); \
> +                       vtbl_word =3D __riscv_vluxei32_v_u64m8_mu(mask,
> vtbl_word, tbl8, \
> +                                       __riscv_vsll_vx_u32m4( \
> +                                       __riscv_vsrl_vx_u32m4(v_tbl_index=
,
> idx_bits, vl), 3, vl), \
> +                                               vl); \
> +                       v_entry_idx =3D __riscv_vand_vx_u32m4(v_tbl_index=
,
> idx_mask, vl); \
> +                       v_shift     =3D __riscv_vsll_vx_u32m4(v_entry_idx=
, 3
> + NH_SZ, vl); \
> +                       vtbl_entry  =3D __riscv_vand_vx_u64m8( \
> +                                       __riscv_vsrl_vv_u64m8(vtbl_word, =
\
> +
>  __riscv_vwcvtu_x_x_v_u64m8(v_shift, vl), vl), e_mask, vl); \
> +               } \
> +               __riscv_vse64_v_u64m8(&next_hops[i], \
> +                               __riscv_vsrl_vx_u64m8(vtbl_entry, 1, vl),
> vl); \
> +       } \
> +}
> +
> +DECLARE_VECTOR_FN(1b, 0)
> +DECLARE_VECTOR_FN(2b, 1)
> +DECLARE_VECTOR_FN(4b, 2)
> +DECLARE_VECTOR_FN(8b, 3)
> +
> +#endif
> diff --git a/lib/fib/dir24_8_rvv.h b/lib/fib/dir24_8_rvv.h
> new file mode 100644
> index 0000000000..7be99f7882
> --- /dev/null
> +++ b/lib/fib/dir24_8_rvv.h
> @@ -0,0 +1,24 @@
> +/* SPDX-License-Identifier: BSD-3-Clause
> + * Copyright (c) 2025 Institute of Software Chinese Academy of Sciences
> (ISCAS).
> + */
> +
> +#ifndef _DIR248_RVV_H_
> +#define _DIR248_RVV_H_
> +
> +void
> +rte_dir24_8_vec_lookup_bulk_1b(void *p, const uint32_t *ips,
> +       uint64_t *next_hops, const unsigned int n);
> +
> +void
> +rte_dir24_8_vec_lookup_bulk_2b(void *p, const uint32_t *ips,
> +       uint64_t *next_hops, const unsigned int n);
> +
> +void
> +rte_dir24_8_vec_lookup_bulk_4b(void *p, const uint32_t *ips,
> +       uint64_t *next_hops, const unsigned int n);
> +
> +void
> +rte_dir24_8_vec_lookup_bulk_8b(void *p, const uint32_t *ips,
> +       uint64_t *next_hops, const unsigned int n);
> +
> +#endif /* _DIR248_RVV_H_ */
> diff --git a/lib/fib/meson.build b/lib/fib/meson.build
> index 6992ccc040..573fc50ff1 100644
> --- a/lib/fib/meson.build
> +++ b/lib/fib/meson.build
> @@ -10,4 +10,6 @@ deps +=3D ['net']
>
>  if dpdk_conf.has('RTE_ARCH_X86_64')
>      sources_avx512 +=3D files('dir24_8_avx512.c', 'trie_avx512.c')
> +elif dpdk_conf.has('RTE_ARCH_RISCV')
> +    sources +=3D files('dir24_8_rvv.c')
>  endif
> --
> 2.50.0
>
>

--0000000000008970e3063c279569
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
Implement rte_fib_lookup_bulk function for RISC-V architecture using RISC-V=
<br>
Vector Extension instruction set<br>
<br>
Signed-off-by: Sun Yuechi &lt;<a href=3D"mailto:sunyuechi@iscas.ac.cn" targ=
et=3D"_blank" rel=3D"noreferrer">sunyuechi@iscas.ac.cn</a>&gt;<br></blockqu=
ote></div></div><div dir=3D"auto">From RISC-V perspective:</div><div dir=3D=
"auto"><br></div><div dir=3D"auto">Reviewed-by: Stanis=C5=82aw Kardach &lt;=
<a href=3D"mailto:stanislaw.kardach@gmail.com">stanislaw.kardach@gmail.com<=
/a>&gt;</div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_contai=
ner"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bo=
rder-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0lib/fib/dir24_8.c=C2=A0 =C2=A0 =C2=A0| 20 ++++++++++++++<br>
=C2=A0lib/fib/dir24_8_rvv.c | 64 ++++++++++++++++++++++++++++++++++++++++++=
+<br>
=C2=A0lib/fib/dir24_8_rvv.h | 24 ++++++++++++++++<br>
=C2=A0lib/fib/meson.build=C2=A0 =C2=A0|=C2=A0 2 ++<br>
=C2=A04 files changed, 110 insertions(+)<br>
=C2=A0create mode 100644 lib/fib/dir24_8_rvv.c<br>
=C2=A0create mode 100644 lib/fib/dir24_8_rvv.h<br>
<br>
diff --git a/lib/fib/dir24_8.c b/lib/fib/dir24_8.c<br>
index 2ba7e93511..c652d3ca98 100644<br>
--- a/lib/fib/dir24_8.c<br>
+++ b/lib/fib/dir24_8.c<br>
@@ -20,6 +20,10 @@<br>
<br>
=C2=A0#include &quot;dir24_8_avx512.h&quot;<br>
<br>
+#elif defined(RTE_RISCV_FEATURE_V)<br>
+<br>
+#include &quot;dir24_8_rvv.h&quot;<br>
+<br>
=C2=A0#endif /* CC_AVX512_SUPPORT */<br>
<br>
=C2=A0#define DIR24_8_NAMESIZE=C2=A0 =C2=A0 =C2=A0 =C2=A064<br>
@@ -88,6 +92,22 @@ get_vector_fn(enum rte_fib_dir24_8_nh_sz nh_sz, bool be_=
addr)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return NULL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+#elif defined(RTE_RISCV_FEATURE_V)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0RTE_SET_USED(be_addr);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (rte_cpu_get_flag_enabled(RTE_CPUFLAG_RISCV_=
ISA_V) &lt;=3D 0)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0switch (nh_sz) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case RTE_FIB_DIR24_8_1B:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return rte_dir24_8_=
vec_lookup_bulk_1b;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case RTE_FIB_DIR24_8_2B:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return rte_dir24_8_=
vec_lookup_bulk_2b;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case RTE_FIB_DIR24_8_4B:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return rte_dir24_8_=
vec_lookup_bulk_4b;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0case RTE_FIB_DIR24_8_8B:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return rte_dir24_8_=
vec_lookup_bulk_8b;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return NULL;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0#else<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 RTE_SET_USED(nh_sz);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 RTE_SET_USED(be_addr);<br>
diff --git a/lib/fib/dir24_8_rvv.c b/lib/fib/dir24_8_rvv.c<br>
new file mode 100644<br>
index 0000000000..9c14ca0481<br>
--- /dev/null<br>
+++ b/lib/fib/dir24_8_rvv.c<br>
@@ -0,0 +1,64 @@<br>
+/* SPDX-License-Identifier: BSD-3-Clause<br>
+ * Copyright (c) 2025 Institute of Software Chinese Academy of Sciences (I=
SCAS).<br>
+ */<br>
+<br>
+#if defined(RTE_RISCV_FEATURE_V)<br>
+<br>
+#include &lt;rte_vect.h&gt;<br>
+#include &lt;rte_fib.h&gt;<br>
+<br>
+#include &quot;dir24_8.h&quot;<br>
+#include &quot;dir24_8_rvv.h&quot;<br>
+<br>
+#define DECLARE_VECTOR_FN(SFX, NH_SZ) \<br>
+void \<br>
+rte_dir24_8_vec_lookup_bulk_##SFX(void *p, \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const uint32_t *ips=
, uint64_t *next_hops, unsigned int n) \<br>
+{ \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0const uint8_t=C2=A0 idx_bits =3D 3 - NH_SZ; \<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0const uint32_t idx_mask =3D (1u &lt;&lt; (3 - N=
H_SZ)) - 1u; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0const uint64_t e_mask=C2=A0 =C2=A0=3D ~0ULL &gt=
;&gt; (64 - (8u &lt;&lt; NH_SZ)); \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0struct dir24_8_tbl *tbl =3D (struct dir24_8_tbl=
 *)p; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0const uint64_t *tbl24=C2=A0 =C2=A0=3D tbl-&gt;t=
bl24; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0size_t vl; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (unsigned int i =3D 0; i &lt; n; i +=3D vl)=
 { \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vl =3D __riscv_vset=
vl_e32m4(n - i); \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vuint32m4_t v_ips =
=3D __riscv_vle32_v_u32m4(&amp;ips[i], vl); \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vuint64m8_t vtbl_wo=
rd =3D __riscv_vluxei32_v_u64m8(tbl24, \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__riscv_vsll_vx_u32m4( \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__riscv_vsrl_vx_u32m4(v_ips, idx_bits=
 + 8, vl), 3, vl), vl); \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vuint32m4_t v_tbl_i=
ndex =3D __riscv_vsrl_vx_u32m4(v_ips, 8, vl); \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vuint32m4_t v_entry=
_idx =3D __riscv_vand_vx_u32m4(v_tbl_index, idx_mask, vl); \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vuint32m4_t v_shift=
=C2=A0 =C2=A0 =C2=A0=3D __riscv_vsll_vx_u32m4(v_entry_idx, 3 + NH_SZ, vl); =
\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vuint64m8_t vtbl_en=
try=C2=A0 =3D __riscv_vand_vx_u64m8( \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__riscv_vsrl_vv_u64m8(vtbl_word, \<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__riscv_v=
wcvtu_x_x_v_u64m8(v_shift, vl), vl), e_mask, vl); \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vbool8_t mask =3D _=
_riscv_vmseq_vx_u64m8_b8( \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__riscv_vand_vx_u64m8(vtbl_entry, 1, =
vl), 1, vl); \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (__riscv_vcpop_m=
_b8(mask, vl)) { \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0const uint64_t *tbl8 =3D tbl-&gt;tbl8; \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0v_tbl_index =3D __riscv_vadd_vv_u32m4_mu(mask, v_tbl_index, \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__riscv_v=
sll_vx_u32m4( \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0__riscv_vnsrl_wx_u32m4(vtbl_entry, 1, vl), 8, vl), \<br=
>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0__riscv_vand_vx_u32m4(v_ips, 0xFF, vl), vl); \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0vtbl_word =3D __riscv_vluxei32_v_u64m8_mu(mask, vtbl_word, tbl8, =
\<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__riscv_v=
sll_vx_u32m4( \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__riscv_v=
srl_vx_u32m4(v_tbl_index, idx_bits, vl), 3, vl), \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0vl); \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0v_entry_idx =3D __riscv_vand_vx_u32m4(v_tbl_index, idx_mask, vl);=
 \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0v_shift=C2=A0 =C2=A0 =C2=A0=3D __riscv_vsll_vx_u32m4(v_entry_idx,=
 3 + NH_SZ, vl); \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0vtbl_entry=C2=A0 =3D __riscv_vand_vx_u64m8( \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__riscv_v=
srl_vv_u64m8(vtbl_word, \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__riscv_v=
wcvtu_x_x_v_u64m8(v_shift, vl), vl), e_mask, vl); \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__riscv_vse64_v_u64=
m8(&amp;next_hops[i], \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0__riscv_vsrl_vx_u64m8(vtbl_entry, 1, =
vl), vl); \<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} \<br>
+}<br>
+<br>
+DECLARE_VECTOR_FN(1b, 0)<br>
+DECLARE_VECTOR_FN(2b, 1)<br>
+DECLARE_VECTOR_FN(4b, 2)<br>
+DECLARE_VECTOR_FN(8b, 3)<br>
+<br>
+#endif<br>
diff --git a/lib/fib/dir24_8_rvv.h b/lib/fib/dir24_8_rvv.h<br>
new file mode 100644<br>
index 0000000000..7be99f7882<br>
--- /dev/null<br>
+++ b/lib/fib/dir24_8_rvv.h<br>
@@ -0,0 +1,24 @@<br>
+/* SPDX-License-Identifier: BSD-3-Clause<br>
+ * Copyright (c) 2025 Institute of Software Chinese Academy of Sciences (I=
SCAS).<br>
+ */<br>
+<br>
+#ifndef _DIR248_RVV_H_<br>
+#define _DIR248_RVV_H_<br>
+<br>
+void<br>
+rte_dir24_8_vec_lookup_bulk_1b(void *p, const uint32_t *ips,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t *next_hops, const unsigned int n);<br>
+<br>
+void<br>
+rte_dir24_8_vec_lookup_bulk_2b(void *p, const uint32_t *ips,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t *next_hops, const unsigned int n);<br>
+<br>
+void<br>
+rte_dir24_8_vec_lookup_bulk_4b(void *p, const uint32_t *ips,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t *next_hops, const unsigned int n);<br>
+<br>
+void<br>
+rte_dir24_8_vec_lookup_bulk_8b(void *p, const uint32_t *ips,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t *next_hops, const unsigned int n);<br>
+<br>
+#endif /* _DIR248_RVV_H_ */<br>
diff --git a/lib/fib/meson.build b/lib/fib/meson.build<br>
index 6992ccc040..573fc50ff1 100644<br>
--- a/lib/fib/meson.build<br>
+++ b/lib/fib/meson.build<br>
@@ -10,4 +10,6 @@ deps +=3D [&#39;net&#39;]<br>
<br>
=C2=A0if dpdk_conf.has(&#39;RTE_ARCH_X86_64&#39;)<br>
=C2=A0 =C2=A0 =C2=A0sources_avx512 +=3D files(&#39;dir24_8_avx512.c&#39;, &=
#39;trie_avx512.c&#39;)<br>
+elif dpdk_conf.has(&#39;RTE_ARCH_RISCV&#39;)<br>
+=C2=A0 =C2=A0 sources +=3D files(&#39;dir24_8_rvv.c&#39;)<br>
=C2=A0endif<br>
-- <br>
2.50.0<br>
<br>
</blockquote></div></div></div>

--0000000000008970e3063c279569--
