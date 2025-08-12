Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89080C87FCB
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 Aug 2025 09:20:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C5534026A;
	Tue, 12 Aug 2025 11:20:31 +0200 (CEST)
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com
 [209.85.167.48]) by mails.dpdk.org (Postfix) with ESMTP id B9C4840264
 for <dev@dpdk.org>; Tue, 12 Aug 2025 11:20:29 +0200 (CEST)
Received: by mail-lf1-f48.google.com with SMTP id
 2adb3069b0e04-55b93104888so6717575e87.1
 for <dev@dpdk.org>; Tue, 12 Aug 2025 02:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1754990429; x=1755595229; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w/x/LOUtWCPNTvKaZTrCNdxRxxZbAHQtu98sgCz7brE=;
 b=hRCDAB3H45MU43b6nHL1tDV0ivE/ztyCCKDce73zk+MrUoIzK2nFtlCTfwuRj5qpCA
 RKIJ8OVnCKpme7blrX0jG23gOB6rYkyHN/w5upBMNrpkns+InKx4Th7El14T0BZL3RTE
 j9+d1dgDqE0xpZ1EtVf2z4qtK4OM1cClFyLcyPe7cMhGyaVIXdoTzf4S/ziglx3+nkAb
 bpDXEa1K1qezRwaxGvJnrugVOV08KpLdpKIOPisab0bq0HAzradruhizR19c7kcwfxfm
 d4aN/2yZUmLi0Q2I3aKY4Pim4HsJwMSD+z8U9o32lM6+WEQaNvhl73iEeFcM1vUZ8+ud
 /u4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754990429; x=1755595229;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w/x/LOUtWCPNTvKaZTrCNdxRxxZbAHQtu98sgCz7brE=;
 b=cifiMPi7dbDrgp6av69WhwK0u/UksUShHuoLNJV8Mw7kZC0TQ56VcyZA9BZ+WAMTLA
 nFecw51wklYM/AMsX+WNVUAcN7G0UtTG1Op/LA8bL31hKj9osCs5ihgitSs2VnscZXdm
 tVuqBD2O9PP7+4eXmnS1h6cylGDSZRn3k0TWOCRv6UsJq7gzfbntCXLlrEtPHF3neHxP
 eL0/eS7+PVFvUn546Gwcndy9qkfjr/ueXNBHemUEutw+U8BePSUfBZE6rAwCsCijegps
 6XgF0mOwCUXjOxUr3NnPjeNsBJ7zShR3g5u4yMtsoowmgAC/MLFLNLsaK9D1IABvjZng
 nv7Q==
X-Gm-Message-State: AOJu0YxGmWtk2qXOWbtdjfbptipNDfuD1ety/35fBBiZ4z9EKg2f8fvI
 qZb7WEO3EY8YYKnIdXOfhwMbfyEi5E5hu7ncTb0rCvgExDGqpUk6YaAaYw7WijbiFIgnCx4XVN3
 rO8bIs9r9mra30LQq1ONnU2pWTDMGyM0=
X-Gm-Gg: ASbGncts/2kRywhlbaik1//GIbgpyURctuYVVatKImuRslxUfzlrr45iAFXx7wja/af
 c1J3jGYflhju5TN9uQ3TyrKt/ukMDH18AjvSt/PzxMJrQkkveSY5uESSSkF+RrwD7YyBA4h3UYc
 wdrlTqAU9xTdqg9dxdBPelrNTCPld/nLyr3HXuci/zFOt59sH3itZ0ggs+DrfzsR3DFwtNG1vrK
 2L9O/Y=
X-Google-Smtp-Source: AGHT+IE6aToIZ/DCmBZWYoYRQ6Wrr5FcDTFD4jsH0el3kTdf1BROYEuXlHHM+Jem4SfdJ32PCKcpwzS+XCAU0RNCY54=
X-Received: by 2002:a05:6512:1310:b0:55b:5b29:61ef with SMTP id
 2adb3069b0e04-55cd765dc9dmr852057e87.56.1754990428752; Tue, 12 Aug 2025
 02:20:28 -0700 (PDT)
MIME-Version: 1.0
References: <20250701182033.642384-1-uk7b@foxmail.com>
 <tencent_EFCE09AB3F6C9C0743F5C9226108A2D86D05@qq.com>
In-Reply-To: <tencent_EFCE09AB3F6C9C0743F5C9226108A2D86D05@qq.com>
From: =?UTF-8?Q?Stanis=C5=82aw_Kardach?= <stanislaw.kardach@gmail.com>
Date: Tue, 12 Aug 2025 11:20:19 +0200
X-Gm-Features: Ac12FXxx9MnCtSmL87aWD15tSBIhrH0Ei9Vol0-QRSBM1LcDkW_cf-fyF8Y2syw
Message-ID: <CAJcPQBquqVhnPPkBvgp1ouC7ptNg7p_GZDx1VredPd2DULiKMA@mail.gmail.com>
Subject: Re: [PATCH v2 2/5] eal/riscv/spinlock: add rte_cpuflag.h
To: uk7b@foxmail.com
Cc: dev@dpdk.org, Sun Yuechi <sunyuechi@iscas.ac.cn>
Content-Type: multipart/alternative; boundary="0000000000001712c7063c278d24"
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

--0000000000001712c7063c278d24
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 1 Jul 2025, 20:20 , <uk7b@foxmail.com> wrote:

> From: Sun Yuechi <sunyuechi@iscas.ac.cn>
>
> Same as the x86 style, include "rte_cpuflags.h" in rte_spinlock.h
> so that files like lib/fib/dir24_8.c don=E2=80=99t need to include it.
>
> Signed-off-by: Sun Yuechi <sunyuechi@iscas.ac.cn>
>
Reviewed-by: Stanis=C5=82aw Kardach <stanislaw.kardach@gmail.com>

> ---
>  lib/eal/riscv/include/rte_spinlock.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/eal/riscv/include/rte_spinlock.h
> b/lib/eal/riscv/include/rte_spinlock.h
> index 5fe4980e44..afbe83a061 100644
> --- a/lib/eal/riscv/include/rte_spinlock.h
> +++ b/lib/eal/riscv/include/rte_spinlock.h
> @@ -14,6 +14,7 @@
>
>  #include <rte_common.h>
>  #include "generic/rte_spinlock.h"
> +#include "rte_cpuflags.h"
>
>  #ifdef __cplusplus
>  extern "C" {
> --
> 2.50.0
>
>

--0000000000001712c7063c278d24
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
Same as the x86 style, include &quot;rte_cpuflags.h&quot; in rte_spinlock.h=
<br>
so that files like lib/fib/dir24_8.c don=E2=80=99t need to include it.<br>
<br>
Signed-off-by: Sun Yuechi &lt;<a href=3D"mailto:sunyuechi@iscas.ac.cn" targ=
et=3D"_blank" rel=3D"noreferrer">sunyuechi@iscas.ac.cn</a>&gt;<br></blockqu=
ote></div></div><div dir=3D"auto">Reviewed-by: Stanis=C5=82aw Kardach &lt;<=
a href=3D"mailto:stanislaw.kardach@gmail.com">stanislaw.kardach@gmail.com</=
a>&gt;</div><div dir=3D"auto"><div class=3D"gmail_quote gmail_quote_contain=
er"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bor=
der-left:1px solid rgb(204,204,204);padding-left:1ex">
---<br>
=C2=A0lib/eal/riscv/include/rte_spinlock.h | 1 +<br>
=C2=A01 file changed, 1 insertion(+)<br>
<br>
diff --git a/lib/eal/riscv/include/rte_spinlock.h b/lib/eal/riscv/include/r=
te_spinlock.h<br>
index 5fe4980e44..afbe83a061 100644<br>
--- a/lib/eal/riscv/include/rte_spinlock.h<br>
+++ b/lib/eal/riscv/include/rte_spinlock.h<br>
@@ -14,6 +14,7 @@<br>
<br>
=C2=A0#include &lt;rte_common.h&gt;<br>
=C2=A0#include &quot;generic/rte_spinlock.h&quot;<br>
+#include &quot;rte_cpuflags.h&quot;<br>
<br>
=C2=A0#ifdef __cplusplus<br>
=C2=A0extern &quot;C&quot; {<br>
-- <br>
2.50.0<br>
<br>
</blockquote></div></div></div>

--0000000000001712c7063c278d24--
