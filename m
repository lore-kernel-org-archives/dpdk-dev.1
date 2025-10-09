Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19452CCD183
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 08:17:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B930E402A3;
	Thu,  9 Oct 2025 10:17:13 +0200 (CEST)
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com
 [209.85.221.173])
 by mails.dpdk.org (Postfix) with ESMTP id 5D6C740277
 for <dev@dpdk.org>; Thu,  9 Oct 2025 10:17:12 +0200 (CEST)
Received: by mail-vk1-f173.google.com with SMTP id
 71dfb90a1353d-54aa0792200so441508e0c.3
 for <dev@dpdk.org>; Thu, 09 Oct 2025 01:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1759997831;
 x=1760602631; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2SbI5w0c2lUFgXmTYdX8D/HDNYIwkvV2edqv84fGtS4=;
 b=05FbAaGWfoxbmknoh1H0dZJVY+WJO9HyIVxOPJE2AvcHnxvbn51tPRkS5X+td3SdN/
 T6SkH8ACgY1VkG6J2ySMEUgDQG43wGkT+O5/vUd1giSGcvNQVBFguAXQdBOP0YYATXpv
 Fm30oVZx0C7jfylWfKxaWloNEU+b/ZWU2OouQGcoovrg6+xJvVnPHCpmqQlmXGLWk64Z
 oKV4APQpMWKxjd6jPX/sswLg0DIc6dMn9S/f8sR2GRwcmEjNt79qsi0xMTRJspMT58VM
 I0lIBh2/JyHbw3vfZ3tFn+rrcjWpclvsmFS8/yvM1oVGevMYj8tqZIGomTgwCsiFQ+m/
 VlTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759997831; x=1760602631;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2SbI5w0c2lUFgXmTYdX8D/HDNYIwkvV2edqv84fGtS4=;
 b=KNrdzwcmRn/d3yh6t4mw+3UQa5KNwy6SXaLeNVoXLdu0fDfRlMEKVTLgZUursTF4J0
 E3fD6BBaLGn8SLzAKW6DNcC252bPyGyb980uHZ8vBIHATAvHPxFBeRyiqvfWpUyEjCau
 lC/tK0AVZBYDWDyWJ/9SgFR+pc5PDlFd9u/debzCz1Nqqg8MsdiHvDdeFUU/KnFjL8Zw
 sqm7GLmgyLxgthbtMJ6WMzsWcwyLH7WrC9Vjrnasu/GoQbtMRxBPUqbgRM/oScc35izs
 5yTu/IQPubwWCV21ZfrEHj33hX3i96kxsZ9qvQeAulnEnqY+3TdMe0Wrtx5Nif9yX277
 6wbg==
X-Gm-Message-State: AOJu0Yxa8vVdoW2nxFCW2kbaNpl3KftoZ9Q0noGi4air9Jojq39rp2id
 XFzoHazp4YJ6VjEBYWYqdGdlzUZWH53rdJzd6MPjZf9GliWMm7cEv+xBFLIrJacKCS61OCag/82
 x34MK48ADjFkrB8foteQqcMm6Z4QtIyeS+sPvxqDskQ==
X-Gm-Gg: ASbGncv+Z9Cpea+eVdfAuTOfhwiBpLKiMgNXQ6aQNmSivnUn5llgpOSBSJzwTnuoKiO
 k4cCj48qf4vv8emzj3b89UiMQ0/k5zoLIt5aS3OFN1VFbvKHFfcEvpSZwjGfvUB8quGVkc4xtR4
 HGUIvVLJP+JiX5CeTE/3ntLw7f04WbTCaVDBE7lsmnQJs3UOkivtwPTceA6VsO4xDqKpxeDCF+B
 rXpTXSfRbrQNQBb0ukfZFMJhBgrP7bNuLybQ7cuMELri5Rw+4MBwg==
X-Google-Smtp-Source: AGHT+IEgQrV7QA13W8rZjVx+PO4Evj62vgSqH4gY4SzbIPPn5qjoqLcRA4K7c4xS7tyxIOXArTiUXct3AswkiL3ejII=
X-Received: by 2002:a05:6122:e002:10b0:554:b928:6f with SMTP id
 71dfb90a1353d-554b9280175mr2156551e0c.0.1759997831430; Thu, 09 Oct 2025
 01:17:11 -0700 (PDT)
MIME-Version: 1.0
References: <20251009063030.2776794-1-sunyuechi@iscas.ac.cn>
In-Reply-To: <20251009063030.2776794-1-sunyuechi@iscas.ac.cn>
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Thu, 9 Oct 2025 10:17:02 +0200
X-Gm-Features: AS18NWDh-NmreCWSpYGmJ2dqJwCTETgz5hhNv62q87tfo_M-NKdqTtIG5pvONec
Message-ID: <CAOaVG16WTkzVUE6qLkAmtBNJYBKRseFK5BoBSjYjk3rVRw+KYw@mail.gmail.com>
Subject: Re: [PATCH] eal/riscv: optimize memcpy for small copies under 64 bytes
To: Sun Yuechi <sunyuechi@iscas.ac.cn>
Cc: dev <dev@dpdk.org>,
 =?UTF-8?Q?Stanis=C5=82aw_Kardach?= <stanislaw.kardach@gmail.com>, 
 Bruce Richardson <bruce.richardson@intel.com>
Content-Type: multipart/alternative; boundary="0000000000008c4e8d0640b56dd4"
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

--0000000000008c4e8d0640b56dd4
Content-Type: text/plain; charset="UTF-8"

How does this compare to glibc/gcc memcpy? I would like to see rte_memcpy
go away

On Thu, Oct 9, 2025, 08:32 Sun Yuechi <sunyuechi@iscas.ac.cn> wrote:

> Improve rte_memcpy implementation on RISC-V platform for sizes under
> 64 bytes, based on the ARM implementation.
>
> Enhanced handling for cases smaller than 64 bytes shows very significant
> performance benefits, while the impact is minimal after 64 bytes.
>
> This optimization is disabled by default as a conservative measure,
> since future glibc versions may include similar improvements that
> could conflict with this implementation.
>
> Use RTE_ARCH_RISCV_MEMCPY to enable this optimization.
>
> Signed-off-by: Sun Yuechi <sunyuechi@iscas.ac.cn>
> ---
>  config/riscv/meson.build           |   5 ++
>  lib/eal/riscv/include/rte_memcpy.h | 122 +++++++++++++++++++++++++++++
>  2 files changed, 127 insertions(+)
>
> diff --git a/config/riscv/meson.build b/config/riscv/meson.build
> index f93ea3e145..73fd0ab4da 100644
> --- a/config/riscv/meson.build
> +++ b/config/riscv/meson.build
> @@ -20,6 +20,11 @@ dpdk_conf.set('RTE_FORCE_INTRINSICS', 1)
>
>  # common flags to all riscv builds, with lowest priority
>  flags_common = [
> +    # Accelerate rte_memcpy for copies smaller than 64 bytes. Be sure to
> run
> +    # the unit test (memcpy_perf_autotest) to verify performance
> improvements.
> +    # Refer to notes in source file (lib/eal/riscv/include/rte_memcpy.h)
> for
> +    # more details.
> +    ['RTE_ARCH_RISCV_MEMCPY', false],
>      ['RTE_ARCH_RISCV', true],
>      ['RTE_CACHE_LINE_SIZE', 64],
>      # Manually set wall time clock frequency for the target. If 0, then
> it is
> diff --git a/lib/eal/riscv/include/rte_memcpy.h
> b/lib/eal/riscv/include/rte_memcpy.h
> index d8a942c5d2..ae6e79e2fc 100644
> --- a/lib/eal/riscv/include/rte_memcpy.h
> +++ b/lib/eal/riscv/include/rte_memcpy.h
> @@ -2,6 +2,7 @@
>   * Copyright(c) 2022 StarFive
>   * Copyright(c) 2022 SiFive
>   * Copyright(c) 2022 Semihalf
> + * Copyright(c) 2025 ISCAS
>   */
>
>  #ifndef RTE_MEMCPY_RISCV_H
> @@ -14,6 +15,125 @@
>
>  #include "generic/rte_memcpy.h"
>
> +#ifdef RTE_ARCH_RISCV_MEMCPY
> +
> +#ifdef __cplusplus
> +extern "C" {
> +#endif
> +
> +/*
> + * This implementation is improved from eal/arm/include/rte_memcpy_64.h,
> + * targeting only cases of < 64 bytes.
> + * Currently shows significant performance improvement over various glibc
> versions,
> + * but is disabled by default due to uncertainty about potential
> performance
> + * degradation in future versions.
> + * You can use memcpy_perf_autotest to test the performance.
> + */
> +
> +static __rte_always_inline
> +void rte_mov16(uint8_t *dst, const uint8_t *src)
> +{
> +       __uint128_t *dst128 = (__uint128_t *)dst;
> +       const __uint128_t *src128 = (const __uint128_t *)src;
> +       *dst128 = *src128;
> +}
> +
> +static __rte_always_inline
> +void rte_mov32(uint8_t *dst, const uint8_t *src)
> +{
> +       __uint128_t *dst128 = (__uint128_t *)dst;
> +       const __uint128_t *src128 = (const __uint128_t *)src;
> +       const __uint128_t x0 = src128[0], x1 = src128[1];
> +       dst128[0] = x0;
> +       dst128[1] = x1;
> +}
> +
> +static __rte_always_inline
> +void rte_mov48(uint8_t *dst, const uint8_t *src)
> +{
> +       __uint128_t *dst128 = (__uint128_t *)dst;
> +       const __uint128_t *src128 = (const __uint128_t *)src;
> +       const __uint128_t x0 = src128[0], x1 = src128[1], x2 = src128[2];
> +       dst128[0] = x0;
> +       dst128[1] = x1;
> +       dst128[2] = x2;
> +}
> +
> +static __rte_always_inline void
> +rte_mov64(uint8_t *dst, const uint8_t *src)
> +{
> +       memcpy(dst, src, 64);
> +}
> +
> +static __rte_always_inline void
> +rte_mov128(uint8_t *dst, const uint8_t *src)
> +{
> +       memcpy(dst, src, 128);
> +}
> +
> +static __rte_always_inline void
> +rte_mov256(uint8_t *dst, const uint8_t *src)
> +{
> +       memcpy(dst, src, 256);
> +}
> +
> +static __rte_always_inline void
> +rte_memcpy_lt16(uint8_t *dst, const uint8_t *src, size_t n)
> +{
> +       if (n & 0x08) {
> +               /* copy 8 ~ 15 bytes */
> +               *(uint64_t *)dst = *(const uint64_t *)src;
> +               *(uint64_t *)(dst - 8 + n) = *(const uint64_t *)(src - 8 +
> n);
> +       } else if (n & 0x04) {
> +               /* copy 4 ~ 7 bytes */
> +               *(uint32_t *)dst = *(const uint32_t *)src;
> +               *(uint32_t *)(dst - 4 + n) = *(const uint32_t *)(src - 4 +
> n);
> +       } else if (n & 0x02) {
> +               /* copy 2 ~ 3 bytes */
> +               *(uint16_t *)dst = *(const uint16_t *)src;
> +               *(uint16_t *)(dst - 2 + n) = *(const uint16_t *)(src - 2 +
> n);
> +       } else if (n & 0x01) {
> +               /* copy 1 byte */
> +               *dst = *src;
> +       }
> +}
> +
> +static __rte_always_inline void
> +rte_memcpy_ge16_lt64(uint8_t *dst, const uint8_t *src, size_t n)
> +{
> +       if (n == 16) {
> +               rte_mov16(dst, src);
> +       } else if (n <= 32) {
> +               rte_mov16(dst, src);
> +               rte_mov16(dst - 16 + n, src - 16 + n);
> +       } else if (n <= 48) {
> +               rte_mov32(dst, src);
> +               rte_mov16(dst - 16 + n, src - 16 + n);
> +       } else {
> +               rte_mov48(dst, src);
> +               rte_mov16(dst - 16 + n, src - 16 + n);
> +       }
> +}
> +
> +static __rte_always_inline void *
> +rte_memcpy(void *dst, const void *src, size_t n)
> +{
> +       if (n >= 64)
> +               return memcpy(dst, src, n);
> +       if (n < 16) {
> +               rte_memcpy_lt16((uint8_t *)dst, (const uint8_t *)src, n);
> +               return dst;
> +       }
> +       rte_memcpy_ge16_lt64((uint8_t *)dst, (const uint8_t *)src, n);
> +       return dst;
> +}
> +
> +#ifdef __cplusplus
> +}
> +#endif
> +
> +#else /* RTE_ARCH_RISCV_MEMCPY */
> +
>  #ifdef __cplusplus
>  extern "C" {
>  #endif
> @@ -60,4 +180,6 @@ rte_mov256(uint8_t *dst, const uint8_t *src)
>  }
>  #endif
>
> +#endif /* RTE_ARCH_RISCV_MEMCPY */
> +
>  #endif /* RTE_MEMCPY_RISCV_H */
> --
> 2.51.0
>
>

--0000000000008c4e8d0640b56dd4
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">How does this compare to glibc/gcc memcpy? I would like t=
o see rte_memcpy go away=C2=A0</div><br><div class=3D"gmail_quote gmail_quo=
te_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 9, 2025, 08=
:32 Sun Yuechi &lt;<a href=3D"mailto:sunyuechi@iscas.ac.cn">sunyuechi@iscas=
.ac.cn</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"m=
argin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left=
:1ex">Improve rte_memcpy implementation on RISC-V platform for sizes under<=
br>
64 bytes, based on the ARM implementation.<br>
<br>
Enhanced handling for cases smaller than 64 bytes shows very significant<br=
>
performance benefits, while the impact is minimal after 64 bytes.<br>
<br>
This optimization is disabled by default as a conservative measure,<br>
since future glibc versions may include similar improvements that<br>
could conflict with this implementation.<br>
<br>
Use RTE_ARCH_RISCV_MEMCPY to enable this optimization.<br>
<br>
Signed-off-by: Sun Yuechi &lt;<a href=3D"mailto:sunyuechi@iscas.ac.cn" targ=
et=3D"_blank" rel=3D"noreferrer">sunyuechi@iscas.ac.cn</a>&gt;<br>
---<br>
=C2=A0config/riscv/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A05 ++<br>
=C2=A0lib/eal/riscv/include/rte_memcpy.h | 122 ++++++++++++++++++++++++++++=
+<br>
=C2=A02 files changed, 127 insertions(+)<br>
<br>
diff --git a/config/riscv/meson.build b/config/riscv/meson.build<br>
index f93ea3e145..73fd0ab4da 100644<br>
--- a/config/riscv/meson.build<br>
+++ b/config/riscv/meson.build<br>
@@ -20,6 +20,11 @@ dpdk_conf.set(&#39;RTE_FORCE_INTRINSICS&#39;, 1)<br>
<br>
=C2=A0# common flags to all riscv builds, with lowest priority<br>
=C2=A0flags_common =3D [<br>
+=C2=A0 =C2=A0 # Accelerate rte_memcpy for copies smaller than 64 bytes. Be=
 sure to run<br>
+=C2=A0 =C2=A0 # the unit test (memcpy_perf_autotest) to verify performance=
 improvements.<br>
+=C2=A0 =C2=A0 # Refer to notes in source file (lib/eal/riscv/include/rte_m=
emcpy.h) for<br>
+=C2=A0 =C2=A0 # more details.<br>
+=C2=A0 =C2=A0 [&#39;RTE_ARCH_RISCV_MEMCPY&#39;, false],<br>
=C2=A0 =C2=A0 =C2=A0[&#39;RTE_ARCH_RISCV&#39;, true],<br>
=C2=A0 =C2=A0 =C2=A0[&#39;RTE_CACHE_LINE_SIZE&#39;, 64],<br>
=C2=A0 =C2=A0 =C2=A0# Manually set wall time clock frequency for the target=
. If 0, then it is<br>
diff --git a/lib/eal/riscv/include/rte_memcpy.h b/lib/eal/riscv/include/rte=
_memcpy.h<br>
index d8a942c5d2..ae6e79e2fc 100644<br>
--- a/lib/eal/riscv/include/rte_memcpy.h<br>
+++ b/lib/eal/riscv/include/rte_memcpy.h<br>
@@ -2,6 +2,7 @@<br>
=C2=A0 * Copyright(c) 2022 StarFive<br>
=C2=A0 * Copyright(c) 2022 SiFive<br>
=C2=A0 * Copyright(c) 2022 Semihalf<br>
+ * Copyright(c) 2025 ISCAS<br>
=C2=A0 */<br>
<br>
=C2=A0#ifndef RTE_MEMCPY_RISCV_H<br>
@@ -14,6 +15,125 @@<br>
<br>
=C2=A0#include &quot;generic/rte_memcpy.h&quot;<br>
<br>
+#ifdef RTE_ARCH_RISCV_MEMCPY<br>
+<br>
+#ifdef __cplusplus<br>
+extern &quot;C&quot; {<br>
+#endif<br>
+<br>
+/*<br>
+ * This implementation is improved from eal/arm/include/rte_memcpy_64.h,<b=
r>
+ * targeting only cases of &lt; 64 bytes.<br>
+ * Currently shows significant performance improvement over various glibc =
versions,<br>
+ * but is disabled by default due to uncertainty about potential performan=
ce<br>
+ * degradation in future versions.<br>
+ * You can use memcpy_perf_autotest to test the performance.<br>
+ */<br>
+<br>
+static __rte_always_inline<br>
+void rte_mov16(uint8_t *dst, const uint8_t *src)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__uint128_t *dst128 =3D (__uint128_t *)dst;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0const __uint128_t *src128 =3D (const __uint128_=
t *)src;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0*dst128 =3D *src128;<br>
+}<br>
+<br>
+static __rte_always_inline<br>
+void rte_mov32(uint8_t *dst, const uint8_t *src)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__uint128_t *dst128 =3D (__uint128_t *)dst;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0const __uint128_t *src128 =3D (const __uint128_=
t *)src;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0const __uint128_t x0 =3D src128[0], x1 =3D src1=
28[1];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dst128[0] =3D x0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dst128[1] =3D x1;<br>
+}<br>
+<br>
+static __rte_always_inline<br>
+void rte_mov48(uint8_t *dst, const uint8_t *src)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0__uint128_t *dst128 =3D (__uint128_t *)dst;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0const __uint128_t *src128 =3D (const __uint128_=
t *)src;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0const __uint128_t x0 =3D src128[0], x1 =3D src1=
28[1], x2 =3D src128[2];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dst128[0] =3D x0;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dst128[1] =3D x1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0dst128[2] =3D x2;<br>
+}<br>
+<br>
+static __rte_always_inline void<br>
+rte_mov64(uint8_t *dst, const uint8_t *src)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(dst, src, 64);<br>
+}<br>
+<br>
+static __rte_always_inline void<br>
+rte_mov128(uint8_t *dst, const uint8_t *src)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(dst, src, 128);<br>
+}<br>
+<br>
+static __rte_always_inline void<br>
+rte_mov256(uint8_t *dst, const uint8_t *src)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0memcpy(dst, src, 256);<br>
+}<br>
+<br>
+static __rte_always_inline void<br>
+rte_memcpy_lt16(uint8_t *dst, const uint8_t *src, size_t n)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (n &amp; 0x08) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* copy 8 ~ 15 byte=
s */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*(uint64_t *)dst =
=3D *(const uint64_t *)src;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*(uint64_t *)(dst -=
 8 + n) =3D *(const uint64_t *)(src - 8 + n);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (n &amp; 0x04) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* copy 4 ~ 7 bytes=
 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*(uint32_t *)dst =
=3D *(const uint32_t *)src;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*(uint32_t *)(dst -=
 4 + n) =3D *(const uint32_t *)(src - 4 + n);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (n &amp; 0x02) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* copy 2 ~ 3 bytes=
 */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*(uint16_t *)dst =
=3D *(const uint16_t *)src;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*(uint16_t *)(dst -=
 2 + n) =3D *(const uint16_t *)(src - 2 + n);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (n &amp; 0x01) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* copy 1 byte */<b=
r>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*dst =3D *src;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+}<br>
+<br>
+static __rte_always_inline void<br>
+rte_memcpy_ge16_lt64(uint8_t *dst, const uint8_t *src, size_t n)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (n =3D=3D 16) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rte_mov16(dst, src)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (n &lt;=3D 32) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rte_mov16(dst, src)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rte_mov16(dst - 16 =
+ n, src - 16 + n);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (n &lt;=3D 48) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rte_mov32(dst, src)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rte_mov16(dst - 16 =
+ n, src - 16 + n);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rte_mov48(dst, src)=
;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rte_mov16(dst - 16 =
+ n, src - 16 + n);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+}<br>
+<br>
+static __rte_always_inline void *<br>
+rte_memcpy(void *dst, const void *src, size_t n)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (n &gt;=3D 64)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return memcpy(dst, =
src, n);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (n &lt; 16) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0rte_memcpy_lt16((ui=
nt8_t *)dst, (const uint8_t *)src, n);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return dst;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0rte_memcpy_ge16_lt64((uint8_t *)dst, (const uin=
t8_t *)src, n);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0return dst;<br>
+}<br>
+<br>
+#ifdef __cplusplus<br>
+}<br>
+#endif<br>
+<br>
+#else /* RTE_ARCH_RISCV_MEMCPY */<br>
+<br>
=C2=A0#ifdef __cplusplus<br>
=C2=A0extern &quot;C&quot; {<br>
=C2=A0#endif<br>
@@ -60,4 +180,6 @@ rte_mov256(uint8_t *dst, const uint8_t *src)<br>
=C2=A0}<br>
=C2=A0#endif<br>
<br>
+#endif /* RTE_ARCH_RISCV_MEMCPY */<br>
+<br>
=C2=A0#endif /* RTE_MEMCPY_RISCV_H */<br>
-- <br>
2.51.0<br>
<br>
</blockquote></div>

--0000000000008c4e8d0640b56dd4--
