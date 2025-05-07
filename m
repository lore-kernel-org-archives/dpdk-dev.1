Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BCF9C3ABC5
	for <dpdk-dev@archiver.kernel.org>; Wed,  7 May 2025 08:52:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0AD94025D;
	Wed,  7 May 2025 10:52:32 +0200 (CEST)
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com
 [209.85.221.182])
 by mails.dpdk.org (Postfix) with ESMTP id 41FB84025A
 for <dev@dpdk.org>; Wed,  7 May 2025 10:52:32 +0200 (CEST)
Received: by mail-vk1-f182.google.com with SMTP id
 71dfb90a1353d-525b44b7720so1751492e0c.0
 for <dev@dpdk.org>; Wed, 07 May 2025 01:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1746607951;
 x=1747212751; darn=dpdk.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=D59scH/KxYS4caL0VSMNEC37QGyt/nPGgabYxRdoiyc=;
 b=q5D5wNEj1iL/eDOGpdcdtyuH6u1i6VQIvnOO4KzVbFbMZeHHFKYmbPU5FRFCjibOHv
 KzCGCipJHbn8Yzq60th6OrSuFQskEciLUqBCmOAtwAwJT2nabwYyuXmq2B4iwOvdiJg7
 JB2dswk2YOICkzlm5lnmRYWHrtfAcYHV4HKsSSBNN3HLc3OsmUmX4YrMDNnylbR021SX
 vsz5Z5T4VFVhWIhw3WYOM+jc1vlobv2zO8sTHd9pi526xUpiSpk1u5JQXB/gohMiM9eU
 xVfyE/OAzY7M8IMe66d5JGWzrJP51wOHBM2R6Lo8FWdDy8avFGjlEbwTsrSCC2g9aqw8
 MBoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746607951; x=1747212751;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=D59scH/KxYS4caL0VSMNEC37QGyt/nPGgabYxRdoiyc=;
 b=clQRL/py42ZHW0HwqDrXbzFOUjvliF56h3+B7eFDm+YhUI+evR67zdjx72X/KnATw4
 wnkQD5VTkmil4q1vLP2H5Q7KfigJTpM6Hjuh4MaaWuTPG7H+Yf1sLfdfbnNGfDgOxEFD
 7R7DVrFdl5MOZjDQPsydgRu0MneQC52mnGi7pUKGLQ7/N0fGk7wXDKdQd5KEvJCMn6gG
 tHQNxKLgzsOBMmWpEXSXjNkcY5d3g3GS/zHkl2kHFMCQy349NRWVVjXb+cpqkigb+W8O
 5g1l433otcWyofmN89vTNjDrb4shGRkpsDrni7sCGsKSaJ9lQHrY6swUiTH3QUuTwCGI
 Vztw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUx4wmwHHysev9YyoQLEVi/YUYFQw8vTycir+nxexXlU3KYnabbesy5XNgArctWFNDtrbU=@dpdk.org
X-Gm-Message-State: AOJu0YxOhA+RFCbdJj2DMOL6cmsKie/iwhaOXzb9bPLj2FLGAW7M/GsQ
 NKPqp5rli6RcVclM4N2e08aOOpeqBV0GQhIE1Iz1MXPYLl65po5Smn6JMM9W2pv1jL2/4FutHgu
 U/HwRIF38/K3APRM4CuGt/4SxuoYl6Rxk9rzUCg==
X-Gm-Gg: ASbGnctJaRCPBI/BFH/eUtxT0Bccb1iMg9qR+oV00pCU5/9jU+9vSuT1MjdAX6V5UC3
 6+/DjVzStKhkeKVucJZkoPNxCjnsZAUCY/L8teK4v/vZz+6Z0UYiXcW5GUIOVjm7Lzsx7Xmzvlf
 bPAd+cYOgmfd/75cOHx9Cd+s9M37e7yFUE7w==
X-Google-Smtp-Source: AGHT+IESLLQxmFfHTSa4TtqqVEE7v7+K6T4gSuMtFB7Z9etJzdk4fa0Z5+uV79U3EgotkNpc23gFKcn6M0TKnJu3uKE=
X-Received: by 2002:a05:6122:551:b0:528:f40f:347f with SMTP id
 71dfb90a1353d-52c379a4c40mr1734644e0c.2.1746607951436; Wed, 07 May 2025
 01:52:31 -0700 (PDT)
MIME-Version: 1.0
References: <20250506175010.1141585-1-jfree@FreeBSD.org>
 <20250506175010.1141585-4-jfree@FreeBSD.org>
In-Reply-To: <20250506175010.1141585-4-jfree@FreeBSD.org>
From: Stephen Hemminger <stephen@networkplumber.org>
Date: Wed, 7 May 2025 17:52:19 +0900
X-Gm-Features: ATxdqUHE3q4py3OUSWKSLKI8RgTTcKNnkCtA4zLadev7oOsi0JaRjNyLSU_2CtQ
Message-ID: <CAOaVG142x9ENgVF_p2GuhYA7wRuSXN83=__4D_+kXvxghZB-mg@mail.gmail.com>
Subject: Re: [PATCH 3/3] eal/linux: Check hugepage access permissions
To: Jake Freeland <jfree@freebsd.org>
Cc: Anatoly Burakov <anatoly.burakov@intel.com>, 
 Bruce Richardson <bruce.richardson@intel.com>, dev <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="00000000000081f521063487da5e"
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

--00000000000081f521063487da5e
Content-Type: text/plain; charset="UTF-8"

Please don't split message a across multiple lines.
Open and access are not the same in all security checks, so not a great
idea.
Some analyzer tools may flag as time of check, time of use issue.

On Wed, May 7, 2025, 02:50 Jake Freeland <jfree@freebsd.org> wrote:

> Currently, hugepage mountpoints will be used irrespective of permissions,
> leading to potential EACCES errors during memory allocation. Fix this by
> not using a mountpoint if we do not have read/write permissions on it.
>
> Signed-off-by: Jake Freeland <jfree@FreeBSD.org>
> ---
>  lib/eal/linux/eal_hugepage_info.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/lib/eal/linux/eal_hugepage_info.c
> b/lib/eal/linux/eal_hugepage_info.c
> index d47a19c56a..dbfa38b05c 100644
> --- a/lib/eal/linux/eal_hugepage_info.c
> +++ b/lib/eal/linux/eal_hugepage_info.c
> @@ -260,6 +260,12 @@ get_hugepage_dir(uint64_t hugepage_sz, char *hugedir,
> int len)
>                                 continue;
>                 }
>
> +               if (access(splitstr[MOUNTPT], R_OK | W_OK) < 0) {
> +                       EAL_LOG(NOTICE, "Missing r/w permissions on huge
> dir: "
> +                           "'%s'. Skipping it", splitstr[MOUNTPT]);
> +                       continue;
> +               }
> +
>                 /*
>                  * If no --huge-dir option has been given, we're done.
>                  */
> -
>

>

--00000000000081f521063487da5e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto"><div dir=3D"auto">Please don&#39;t split message a across=
 multiple lines.</div><div dir=3D"auto">Open and access are not the same in=
 all security checks, so not a great idea.</div><div dir=3D"auto">Some anal=
yzer tools may flag as time of check, time of use issue.</div><br><div clas=
s=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, May 7, 2025=
, 02:50 Jake Freeland &lt;<a href=3D"mailto:jfree@freebsd.org" target=3D"_b=
lank" rel=3D"noreferrer">jfree@freebsd.org</a>&gt; wrote:<br></div><blockqu=
ote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px=
 solid rgb(204,204,204);padding-left:1ex">Currently, hugepage mountpoints w=
ill be used irrespective of permissions,<br>
leading to potential EACCES errors during memory allocation. Fix this by<br=
>
not using a mountpoint if we do not have read/write permissions on it.<br>
<br>
Signed-off-by: Jake Freeland &lt;jfree@FreeBSD.org&gt;<br>
---<br>
=C2=A0lib/eal/linux/eal_hugepage_info.c | 6 ++++++<br>
=C2=A01 file changed, 6 insertions(+)<br>
<br>
diff --git a/lib/eal/linux/eal_hugepage_info.c b/lib/eal/linux/eal_hugepage=
_info.c<br>
index d47a19c56a..dbfa38b05c 100644<br>
--- a/lib/eal/linux/eal_hugepage_info.c<br>
+++ b/lib/eal/linux/eal_hugepage_info.c<br>
@@ -260,6 +260,12 @@ get_hugepage_dir(uint64_t hugepage_sz, char *hugedir, =
int len)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 continue;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (access(splitstr=
[MOUNTPT], R_OK | W_OK) &lt; 0) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0EAL_LOG(NOTICE, &quot;Missing r/w permissions on huge dir: &quot;=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&quot;&#39;%s&#39;. Skipping it&quot;, splitstr[MOU=
NTPT]);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0continue;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* If no --hug=
e-dir option has been given, we&#39;re done.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-<br></blockquote></div><div class=3D"gmail_quote" dir=3D"auto"><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
<br>
</blockquote></div></div>

--00000000000081f521063487da5e--
