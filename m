Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC1CCD98F2
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 13:25:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5F014027F;
	Thu, 18 Jun 2026 15:25:09 +0200 (CEST)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45]) by mails.dpdk.org (Postfix) with ESMTP id 631A540268
 for <dev@dpdk.org>; Thu, 18 Jun 2026 15:25:08 +0200 (CEST)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-69532288224so1733502a12.0
 for <dev@dpdk.org>; Thu, 18 Jun 2026 06:25:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781789107; cv=none;
 d=google.com; s=arc-20240605;
 b=BCjL6hxNIqanGbEm1Qns05UpYU0d8SNyJuzfCdhHTjBV3kfpjdvGtUupijhpdGYB+L
 jhRisbl87wJ0q2GC4/MVLMptvd6vZyKQKYzyuKgYKuHoAvnltB1V4DdBJfYwt2bxYh/x
 FDyf98pQKaxYUmaQ/T+QIIxqZHDyGV8YgBfyhDV8vFfNszw15/7lsUskFh7KveYF4YkG
 pv+L91wRzkEcVLwO7QrZRi6hdFfRUcNSXAFEZR3sgswmh+xGUYem4rKh67fvrlOTMJgS
 FsKxUSmXUKxEQsN15ALDYYYRmNbd8nvm8NXpQw0OGhHLhzxR0TzM+qudhoYCKYH8mvsB
 fBuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=GaU+ApCPdClKvy2AolxsVI1uByjVc4B46q+vFd5t3No=;
 fh=q1Y3yHjN5NOtqzxYGWsXJyPIZVsxwYa13TqeEq6wKlA=;
 b=WxBmll7gLpNHKCIEUvTqPdf+e0nQgRfbYou1anDAJHALgrEe9xCQpw38w+0SYnzVpN
 JmSF74iMEt8TwbNKYZSDmjClsaIb6ds7gRafxgQK3Uo7vJG4am+UZn8VKAG+d5WthK8R
 CO80oAuv/ohWHsa36ESeAoTAjADEbDNqt+vvCflL0H6f3D7HPZJxQ2FDppyYWk7la3tx
 1KUSjtISj82QhtOlbq37pZ1xmNUmoqIY3SmtyChxcMyx5vPTmcotUjcSyvsbapxdEnoG
 99zPzKkB1EGCTewQd+6SJUciM1tC+QTdf/qvWFn2C5p40wvcxtcdPdJocKhPVInpDKup
 40PQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1781789107; x=1782393907; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=GaU+ApCPdClKvy2AolxsVI1uByjVc4B46q+vFd5t3No=;
 b=XAvWV1tjwubpcejrgdJQWYZcHAERcvheelWiVIlYt4bShYM/JYNfqfphxDokiSmz1D
 7nU+TKOqt0BHWVlYPZraObivudqfXV93j2yTlY2JxmGCouMaDJtml4M6sZ4qPgy79Wtx
 xSy+IOKGmMoBTEpTYiFJ0LVPeLwN4hEmwOWyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781789107; x=1782393907;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GaU+ApCPdClKvy2AolxsVI1uByjVc4B46q+vFd5t3No=;
 b=F2SVzjqeYCY4rgr7xVUr6JxA274q9OMMsTuCiPGU6TdUvB1tHpFpCJ+hbZbDcCZzrR
 tMff8Vae4F8NK4GiZ6Cl+IszmGIpUuThrbgUG01Zm4gb7JSTtV5qDSQXhCptbFbkuBj7
 Ykvnmz89q/nBsXlonAhJ9b5SQtKge/EQzKhVYiLVEMVQoZOBn6U1DswICKuWVJJ1nuXu
 SeIyKVIo6PRPOSU60nYLfzUGBp9T2UHq6yWYb4QQ1kycKlkunZiWelNhPar6u4tVb98M
 Pbpdp8YD7n+LS/vRGoEEnJqxogjsOXqy6VCGnzYMSZLxmVY5cKlsmlyzCJb9uqJ0dTH0
 va+Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+0Qg/ZQadr/PZhlFcbWCxRmytI8vLuwhPeHxje1MmvnYw5Jcbpt558qzFa9TpuBE0td44=@dpdk.org
X-Gm-Message-State: AOJu0YwA3KSfy3yzPIdq/ItBIsgWhV4h0jelTb9J0QXf16y7Uwe3E0d8
 aMt9Hgo6JUHF+M0VWcuPeHg1g7zvnTItySD6W+N4yO0xppdRPZcXjp9JEWHC0UXmrlylmrEPr6t
 jCWEiuvicgmCPCxJhFCXGvN57WhF0g+3TmXJZL0LB6g==
X-Gm-Gg: AfdE7ckZxEq6elUHUFB2mOJd5Yud0Sema82xKJyNYmu2LssnQJ3d24wPzSfU/SkKaN+
 0uJzk7Mo/ald2VqXlrAjHBriEIEEePaP4F0zDc/XFzP+R/bdkLK0x56LlLwN9+pG7zjBhyDhudg
 MnuuYfRmR5vifsA//bxcQFmwms/AS8bthMbfOcufjM4gge72h0YW62dqxQtYp4n0RBMNf5kHySH
 /dIkf5qVlXBsJRsarNQz+FREl59HGDNvk6FPw0p2q8m7vJXzVKAuzxZays8lywjtxgo+s72aNf+
 7hJuZ+JkONATppZ6qMy8t/Julx5aCzkrlvXi26NvZA==
X-Received: by 2002:a17:907:72c7:b0:bd5:2a43:b471 with SMTP id
 a640c23a62f3a-c05d2a8eb60mr536704066b.48.1781789106707; Thu, 18 Jun 2026
 06:25:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260507163659.40739-1-abailey@iol.unh.edu>
 <20260513154055.134729-1-abailey@iol.unh.edu>
 <CAK6Duxv=rS07Wn9OOv=97DbvRYVNGmydH7_MPkcvXL+_dQC51w@mail.gmail.com>
In-Reply-To: <CAK6Duxv=rS07Wn9OOv=97DbvRYVNGmydH7_MPkcvXL+_dQC51w@mail.gmail.com>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Thu, 18 Jun 2026 09:24:54 -0400
X-Gm-Features: AVVi8Cfv-SsBE4E_rLuJ1qM46uWq9IHmimD91mzKWE0FP8GkhYAze9g8k0iFFjo
Message-ID: <CABJ3N2XixQhhXEnfWJYU_rOou4zXUiYd2SuAV5WYkAgCDOFn6Q@mail.gmail.com>
Subject: Re: [PATCH v3] dts: clean cryptodev environment after a test run
To: Patrick Robb <patrickrobb1997@gmail.com>
Cc: luca.vizzarro@arm.com, lylavoie@iol.unh.edu, ahassick@iol.unh.edu, 
 knimoji@iol.unh.edu, dev@dpdk.org
Content-Type: multipart/alternative; boundary="000000000000c536a90654871a8a"
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

--000000000000c536a90654871a8a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 17, 2026 at 5:13=E2=80=AFPM Patrick Robb <patrickrobb1997@gmail=
.com>
wrote:

> So, some cryptodevs must be unbound from their DPDK driver before they ca=
n
> be destroyed by linux? Out of curiosity, which devices are these?
>
> On the Intel QAT 4942, the virtual functions must be unbound and then
removed before the physical bdf is removed. Otherwise the system is left in
a bad state and causes subsequent failures.

--000000000000c536a90654871a8a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><div class=3D"=
gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Wed, Jun 17, 2026 at =
5:13=E2=80=AFPM Patrick Robb &lt;<a href=3D"mailto:patrickrobb1997@gmail.co=
m" target=3D"_blank">patrickrobb1997@gmail.com</a>&gt; wrote:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex"><div dir=3D"ltr"><div>So, som=
e cryptodevs=C2=A0must be unbound from their DPDK driver before they can be=
 destroyed by linux? Out of curiosity, which devices are these?</div><div><=
br></div></div></blockquote><div>On the Intel QAT 4942, the virtual functio=
ns must be unbound and then removed before the physical bdf is removed. Oth=
erwise the system is left in a bad=C2=A0state and causes subsequent=C2=A0fa=
ilures.=C2=A0</div></div></div>
</div>

--000000000000c536a90654871a8a--
