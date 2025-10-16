Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55646CCD194
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Oct 2025 11:32:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15A79410E8;
	Thu, 16 Oct 2025 13:32:50 +0200 (CEST)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mails.dpdk.org (Postfix) with ESMTP id 0A05640A71
 for <dev@dpdk.org>; Thu, 16 Oct 2025 13:32:49 +0200 (CEST)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-b49c1c130c9so351374a12.0
 for <dev@dpdk.org>; Thu, 16 Oct 2025 04:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1760614368; x=1761219168; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6gE4EXQJ1chArXV6QmEsy39DWEUgEdjML2ggVWWBRRg=;
 b=ZRA+tf2BugRnenAYc+Bs3dedghx1WfEjHaAQkx2/TWJXQ1JV8oqk/GAN53NOYI9rwN
 R+bZeFTCEGUExTH7wMFht7csbtAQbvsHRuEpbEH0yUAmhe3V/BSMpL5OUtnTRD108ZjT
 RC8iPW4Yygst/IVc8Z2eupXSu6CSNi1n1LYI4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760614368; x=1761219168;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6gE4EXQJ1chArXV6QmEsy39DWEUgEdjML2ggVWWBRRg=;
 b=CKVRKGlKgFtxvorshUBCdxfTLhVdHlGiJJ7uEKaO9MrIJSGSkmWz2clxDbrPy8h8ql
 aeJPZCXu5ugBTM6i8oFKI2+2SDIOdMIB4sKomiGdK7dEqkiSGaForfTeWVuLeM7B4Ugs
 PRgB3kfJG2xqZKw2mJ2sWAq8EGU63Z0RC0hQVccI9FVRM+Or0AEhKYUUOjFIuRbBT/4M
 f6Jh0PRx5+KaNlCWFjv0uwdPjV+JTdf3Afn+GYbUawyoiljwWhMgqJJTDlJwun0bweGk
 +GPlDzEzSD/WN5OF/5I8fiaLphWx6iQZqBr4BciOyMXX6XG5Gsb9ohXbvUINM3SUUSJw
 JZeQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRwEVyFApOfI0YTgGOTSAFCNfo8gwRxrszLMrEryTmBdlVBG6ANCFmlGOQbUNbFSlWUdU=@dpdk.org
X-Gm-Message-State: AOJu0Yxmc81U+UWa+WuCvUThHTURZviMlTd95JVWc7DFc9D5EZQxOY40
 RMCAWLW1rz0puIDmXmgbudMThnQfj0xxbcVX70CGLw80tLvkg6dlU45uiTHmwktD7aKra0joMU1
 +BMieti8Q/xk3lzodkbNWE0Hok6K3kl9D2tZ64pwfxA==
X-Gm-Gg: ASbGncvcTdcGTDEeaeie7P1fTSi4sz7qLhCS/pvQCCz4gBvYQxchCTxei4fKGuuhXBg
 pt8AXpuzEeeLlnkoDDBXgiC4vcaQ/s0CE4Q+vwynkl7IHvetYswI7PNTxAgJtxjLuFaQiS9cKug
 JUHydgHInh4vU/lcm0dPPFNmckAP81tvfGybm0tn48C3PSbtIPMDHg3FQ07Rn/sJlaqSH9zcU/N
 /H8j4QBXUc/YpM+W3fopTCSDNrEolnZHwKoCWjZW594pnib1+A+p8y8nrwdq1diKlI4Ujuc4kPq
 u+SmrPxcVTnY7jzc
X-Google-Smtp-Source: AGHT+IHXP0193LYnVzKJv4Xc/RotQ+cw0GgERGFfUZUCSQm5c4buPov/CwkRbJspixUXOZJcqfQU2e3intqQsQorfEI=
X-Received: by 2002:a17:903:2c06:b0:27e:dc53:d239 with SMTP id
 d9443c01a7336-290272b547bmr407320425ad.35.1760614367922; Thu, 16 Oct 2025
 04:32:47 -0700 (PDT)
MIME-Version: 1.0
References: <20251016090948.836029-1-zhoumin@loongson.cn>
In-Reply-To: <20251016090948.836029-1-zhoumin@loongson.cn>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 16 Oct 2025 07:32:02 -0400
X-Gm-Features: AS18NWCyGBDaxxNA2uhN8yAhCxi3Ch3XFAqpLDx1uCK-g_qIfqpp1S1yfGMrgIc
Message-ID: <CAJvnSUCqYoRQg29ovs+r7CQH=wnJQMMLusi_oJthvXA6oa4aEQ@mail.gmail.com>
Subject: Re: [PATCH v1] maintainers: update for LoongArch
To: Min Zhou <zhoumin@loongson.cn>
Cc: thomas@monjalon.net, maobibo@loongson.cn, dev@dpdk.org, ci@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000fc9d4e064144f9a3"
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

--000000000000fc9d4e064144f9a3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Min Zhou,

Will Bibi be responsible for maintaining the Loongarch CI testing going
forward, or are you retaining that responsibility? Thanks.

On Thu, Oct 16, 2025 at 5:46=E2=80=AFAM Min Zhou <zhoumin@loongson.cn> wrot=
e:

> Update maintainers for LoongArch architecture.
>
> Signed-off-by: Min Zhou <zhoumin@loongson.cn>
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  MAINTAINERS | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1a2729be66..7abe482e7d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -320,7 +320,7 @@ F: examples/*/*_neon.*
>  F: examples/common/neon/
>
>  LoongArch
> -M: Min Zhou <zhoumin@loongson.cn>
> +M: Bibo Mao <maobibo@loongson.cn>
>  F: config/loongarch/
>  F: doc/guides/linux_gsg/cross_build_dpdk_for_loongarch.rst
>  F: lib/eal/loongarch/
> --
> 2.27.0
>
>

--000000000000fc9d4e064144f9a3
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi Min Zhou,<div><br></div><div>Will Bibi be responsible f=
or maintaining the Loongarch CI testing going forward, or are you retaining=
 that responsibility? Thanks.</div></div><br><div class=3D"gmail_quote gmai=
l_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Oct 16, 20=
25 at 5:46=E2=80=AFAM Min Zhou &lt;<a href=3D"mailto:zhoumin@loongson.cn">z=
houmin@loongson.cn</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote=
" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);=
padding-left:1ex">Update maintainers for LoongArch architecture.<br>
<br>
Signed-off-by: Min Zhou &lt;<a href=3D"mailto:zhoumin@loongson.cn" target=
=3D"_blank">zhoumin@loongson.cn</a>&gt;<br>
Signed-off-by: Bibo Mao &lt;<a href=3D"mailto:maobibo@loongson.cn" target=
=3D"_blank">maobibo@loongson.cn</a>&gt;<br>
---<br>
=C2=A0MAINTAINERS | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/MAINTAINERS b/MAINTAINERS<br>
index 1a2729be66..7abe482e7d 100644<br>
--- a/MAINTAINERS<br>
+++ b/MAINTAINERS<br>
@@ -320,7 +320,7 @@ F: examples/*/*_neon.*<br>
=C2=A0F: examples/common/neon/<br>
<br>
=C2=A0LoongArch<br>
-M: Min Zhou &lt;<a href=3D"mailto:zhoumin@loongson.cn" target=3D"_blank">z=
houmin@loongson.cn</a>&gt;<br>
+M: Bibo Mao &lt;<a href=3D"mailto:maobibo@loongson.cn" target=3D"_blank">m=
aobibo@loongson.cn</a>&gt;<br>
=C2=A0F: config/loongarch/<br>
=C2=A0F: doc/guides/linux_gsg/cross_build_dpdk_for_loongarch.rst<br>
=C2=A0F: lib/eal/loongarch/<br>
-- <br>
2.27.0<br>
<br>
</blockquote></div>

--000000000000fc9d4e064144f9a3--
