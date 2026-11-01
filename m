Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5376E606A325
	for <dpdk-dev@archiver.kernel.org>; Sun,  1 Nov 2026 20:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=networkplumber-org.20260707.gappssmtp.com header.i=@networkplumber-org.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=jZF0EsEY
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65AA640279;
	Sun,  1 Nov 2026 21:57:28 +0100 (CET)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com
 [209.85.221.176])
 by mails.dpdk.org (Postfix) with ESMTPS id 00B0440264
 for <dev@dpdk.org>; Sun,  1 Nov 2026 21:57:26 +0100 (CET)
Received: by mail-vk1-f176.google.com with SMTP id
 71dfb90a1353d-5e948e56af3so763258e0c.2
 for <dev@dpdk.org>; Sun, 01 Nov 2026 12:57:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793566645; cv=none;
 d=google.com; s=arc-20260327;
 b=D7mmALg47XZPAoy7RnMRF1QPtj6oDR4QFZoPif00bZkE2p+jIBtO2+7F5PVR9mKbAJ
 7FMY/I1ck9zg5pYXkW0GFAL4w0+5njK2EoCcvelpB25R7dQXf8WHZ7+JHfW8DbkFRJIc
 v1FvmWnPneJ14uIA4WquuUSNtnKGz7qkEGsyY0rLZKIPZQtwquaswa35mj5/gs3AfJxl
 a+lMWs/k2eRj4Kry5s66ZaC8SjkE3PIBTzQI0PNso8m3Q5Hydmi9z8d55gxP2m2Juf7A
 MqcTbc4F5WlZtCiHETHjscNnQVTLzhycYg1rrAQKFjUlxJzBeJxBmd5JLT+dqXptFxmI
 MUmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=1hYu2PnnEm+goNKFA8kmZ5794FPnVA5zOwh+8iqttk8=;
 fh=I4Y+EtxVtVxd55enkiPnq+f+i43aNGZLEovOc1GEeQ4=;
 b=QLaHC3Ljr+3pWUdIBmNXVJx1aCC80DEitM6BAdm68ogk3uBjZ24zcF7I3FiWXqmXSj
 AEUk+k//EjdedwfW3Pw2S3P9Ao566Hpl5lARBuN+hIuDS+SUiTjzTT7vay4XJgg55AoK
 8T9VJ/7wLeK57AwGYa1Y1WDCeuJMpASkjk0ChGv8MNSebBYUGFu5vSXEU6LM64hJGJY3
 j/RE3cMohhBJ/JY0eUpuAPvwpimhpHlBtJHqECMvtjPSPXg6s+LmwCQKdHUzRA5K6cPE
 3QGnsskfhUS4Isgk+NnGAAMhVuRn0dK8ciJq6t1/Zdk4zF8bGjPSSAzHgm3GbhmLP+yv
 yl/w==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20260707.gappssmtp.com; s=20260707; t=1793566645;
 x=1794171445; darn=dpdk.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=1hYu2PnnEm+goNKFA8kmZ5794FPnVA5zOwh+8iqttk8=;
 b=jZF0EsEYM2eAhE7oLN9KJHta7OwFs3nEjDETh9g10jEVAmpE16JCjF/nFY+WzGVCg2
 fqzFCTiK+GvrotPdd/NDMKCZWBqlMthbfcKyIuwK4mk5F66u5ND8pxCVG8EWi0yDBxEf
 WY+j/d3t5edex8Bgjxva81DEHkd9qUmYix8vOorp5S5xdE8e03g0e2UrRm3pSC+KDBld
 ckFP+JCiQwzlUKa4UnQajtMBHHVBH6jTKYlyqmYWX9SuxqEaXYA2BjJPGTiD4D5ujnay
 Hqlh9Ebh5819wU+lL3nkta2gNbHQ+2fdIcm7R0n5zdfOfdtbuIA9BfGR7Y+2oWzKPXdF
 Y5mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793566645; x=1794171445;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=1hYu2PnnEm+goNKFA8kmZ5794FPnVA5zOwh+8iqttk8=;
 b=JmQQUrpQoMFcoKtcRRSpdbG4xDTCnMR07BYWbfotWp8tVMFgk6Uj0V1dbW22ecQy2e
 erYS9BFB0o+zvMhqRg6q+kjt2qkg+gW1Ero3R9+42yBBmgpbYa+GM+BkDKRkVqRMLAa/
 ZSiDH+HMNUdEOPKWGtlL6+t8jT0NnHOhYUFoDwUNeBC1S5nKxcQ6U2+h66uIA4e0SGMs
 9q0JOhTftS4xUN5flp9ncCX1K0zQt63A4hhQDf+pSuPOpsn3AjMGd4FRPoIa9D1CYyYu
 fgVwspurtBIO0un252eiWiRHMe5AA0uuBydUcXh/SD9HsADKdz7wLUfSXv7rIVyLfVdj
 wX3g==
X-Forwarded-Encrypted: i=1;
 AKwUvByVX0WosKJAfkVQjlEGzyn9/MCoGZ9PlskFrxRgAYzEIZPkFFjeyGxEvM/hzcp1/clvyEE=@dpdk.org
X-Gm-Message-State: APuU4Z88xUkc0592+4fThh92PRncd0EOIgXa1SEyCZ7jIpmsVO3SYF/1
 XI/fs/paxFP1NxzShnYacsfN/I/hYcn+1KINV/82Vlc9vrvxlf3l2CRryij9AG8dvZq7bqcLyHl
 1szce2F3r/phNQwpPruE2XaIr3HoYzIiRvfpJR4qm7g==
X-Gm-Gg: AYBFou0P7KtFbskXWk4/nQk52sHDAJ3eoEZtWYUU1PgOrcruX3A86hl5B1k7ZHbmMIG
 mvqBzPWg9FpCgex6kaUGBpbzh8aFT19zE/ZXUFwGQa07Pw26cWlV15xLvsbWXqNX66bI1Of8i5/
 azmZj6+ZS/Qg061wUu+toVLzM4iFjF5aYgA0EguYbjH9IIaDbq+lOT/Jv1thXTZFbUdkOqA+E85
 i030ay/ycV6T0EQbUe+s6F5Y7+90Hjw/7aGqVkG4eBb86z2rhiOA+HDKSEn3dLSmD1BGnV30JJm
 FAtt3J/6+WrMLnAlmVbPp+q6LgH/Am8+M0i/H73PcLB0RlQI+V8v4nlwrY56rAsfNLEav/zjaCI
 ZiadaXbG7y5lcxjYYgbPxrqMajE+WKPGAlNhoUQ==
X-Received: by 2002:a05:6122:32d5:b0:5c9:a60d:3279 with SMTP id
 71dfb90a1353d-5ec6895502bmr3462903e0c.13.1793566644709; Sun, 01 Nov 2026
 12:57:24 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <cover.1793520104.git.sunyuechi@iscas.ac.cn>
In-Reply-To: <cover.1793520104.git.sunyuechi@iscas.ac.cn>
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Sun, 1 Nov 2026 21:57:13 +0100
X-Gm-Features: AclHuK9I6S4V2lCABeMT_84u3pj8ZqJE4Fqufw_HWgFuWOwDc7AFPMra1HY2qs8
Message-ID: <CAOaVG14=ECO921X+DmupfY60Dpo9r2xq=Y4+QC22G=AQ0kALQA@mail.gmail.com>
Subject: Re: [PATCH 0/2] acl: avoid vector spills in the RVV search loops
To: Sun Yuechi <sunyuechi@iscas.ac.cn>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, dev <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="000000000000bd3da3065f3d4676"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--000000000000bd3da3065f3d4676
Content-Type: text/plain; charset="UTF-8"

The compiler is doing what we asked. Why workaround it.

On Sun, Nov 1, 2026, 9:04 AM Sun Yuechi <sunyuechi@iscas.ac.cn> wrote:

> At -O2 the ACL match checks are not inlined into the RVV search loops, so
> a vector value live across those calls is spilled and the remaining locals
> are addressed through vlenb.  -O3 inlines them already and is unchanged.
>
> Add __rte_flatten, and apply it to the two search functions.
>
> Sun Yuechi (2):
>   eal: add flatten function attribute
>   acl: inline the match checks into the RVV search loops
>
>  lib/acl/acl_run_rvv.h        |  8 +++++---
>  lib/eal/include/rte_common.h | 13 +++++++++++++
>  2 files changed, 18 insertions(+), 3 deletions(-)
>
> --
> 2.56.0
>
>

--000000000000bd3da3065f3d4676
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">The compiler is doing what we asked. Why workaround it.</=
div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" c=
lass=3D"gmail_attr">On Sun, Nov 1, 2026, 9:04 AM Sun Yuechi &lt;<a href=3D"=
mailto:sunyuechi@iscas.ac.cn">sunyuechi@iscas.ac.cn</a>&gt; wrote:<br></div=
><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border=
-left:1px solid rgb(204,204,204);padding-left:1ex">At -O2 the ACL match che=
cks are not inlined into the RVV search loops, so<br>
a vector value live across those calls is spilled and the remaining locals<=
br>
are addressed through vlenb.=C2=A0 -O3 inlines them already and is unchange=
d.<br>
<br>
Add __rte_flatten, and apply it to the two search functions.<br>
<br>
Sun Yuechi (2):<br>
=C2=A0 eal: add flatten function attribute<br>
=C2=A0 acl: inline the match checks into the RVV search loops<br>
<br>
=C2=A0lib/acl/acl_run_rvv.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 8 +++++---<b=
r>
=C2=A0lib/eal/include/rte_common.h | 13 +++++++++++++<br>
=C2=A02 files changed, 18 insertions(+), 3 deletions(-)<br>
<br>
-- <br>
2.56.0<br>
<br>
</blockquote></div>

--000000000000bd3da3065f3d4676--
