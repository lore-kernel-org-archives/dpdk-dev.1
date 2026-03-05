Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73688F33A62
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 13:50:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43B8B40287;
	Thu,  5 Mar 2026 14:50:34 +0100 (CET)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com
 [209.85.222.52]) by mails.dpdk.org (Postfix) with ESMTP id 7BBBB4027A
 for <dev@dpdk.org>; Thu,  5 Mar 2026 14:50:32 +0100 (CET)
Received: by mail-ua1-f52.google.com with SMTP id
 a1e0cc1a2514c-94de664b541so2336790241.1
 for <dev@dpdk.org>; Thu, 05 Mar 2026 05:50:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772718632; cv=none;
 d=google.com; s=arc-20240605;
 b=Ej6Z9Ds79SyB+pqLrZnXE536uLBujcbRLX2FtYfcXiXXZv2kVHKNukNqq1z0v8dM1p
 L4wj8RGHDlr1Ybs2xtewzFoKLbCfD0eQzuI0mgiyHZDs9I6HrhjLjse+sh/C03mra7U5
 LAGkWA0QKiyNMnYBtRYvJI3Zin4inS2ubyPER5o4N5zvcQQwLZWL3fECyXAn1Ri7eXv1
 1VSOXQiK9fFf1wPvfEMkfJQNwc3gw9zMjeKMPA5rMM0q7fWS4TIKgMh2xxUFxYEIkViC
 NWeQZr6s8yRxF4PsbbCJJY3fgbpTSfDig5hf/yE2TFiB02lIfoaOZv2RwRpngj16zIm7
 FtQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mOa1jrcSXOUBjJo/TBRXXqp/xMeJAOkDbb0wYIC1U/M=;
 fh=J3a7HCx1EIriacs9f118WfqyUFUJ3b457GJ+ffmA5DM=;
 b=h1o1JRFx71isRIeOP3DG58b+z5eAXqfLYS6seO02xmvoOAsmwCzAYHXpTq3gy4caFN
 LVqPneC92VIzV13gkiFyI4Qb5AcAnPDUWOBRe6nUv4VKDtvLOOAux3RNn7DsjRzj68af
 WbcsNa6PZtMXJWO1SYfjX+IPlBaTHvH0XEy19jYTspOnB8XcuEotmO8vd1hwTaxLFga7
 FAUzqyNEfw+DnZVRgi5Ccw9uMmL2Xb7b8hGLzaASRB+lcdY8Cn1RAWr1rOPzXSzYH1bF
 X5Ftdy6/qjZ1/VwWGp3ZwyywSskJbdSiM71BxtjB/kYkTlyyw3waqA/ls7BvlqtrM0TK
 R3gA==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772718632; x=1773323432; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mOa1jrcSXOUBjJo/TBRXXqp/xMeJAOkDbb0wYIC1U/M=;
 b=AHyp8KrAAywR7wDRtBZqptCqL4u02dXPuUNMbjXp8OsfovoFyhRFRk5hQy93aCs73x
 0zuqG62OBqhz3vV8EOeuwtdInj3Xugp1XzUbnwkSsRjzQE1xzfZEu5QFuBtGfnNSyL5f
 jOo+lYIyMjhVfzujvvUwvpwPb/poXfxGs3xv0lTLPYVF3fpHTNZg4Ge+p7E2kaaJ45Rc
 ssMBQwh4a58i0UqUxgmDw/b3pkL31Vb/Bm3xyEOyu99EmIr92Xc9sRW8BEpwUGP//ZWD
 MWzM+VXn1mSVCZc5D9vJtJgqFID+PVsQUEpxlBgNlEmUjtIO8NGgVaWTgopTp1wsxElX
 8TyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772718632; x=1773323432;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mOa1jrcSXOUBjJo/TBRXXqp/xMeJAOkDbb0wYIC1U/M=;
 b=ZriVNyA3bDIGtTlki0jWhP46W/ic3sia8OM3uFfZJBspVIhfFGDRG/GuFL3QqTt/rq
 nL3FLQiz5J77KHVKn6elYnZ33AehBdprDIMlJiw+tKAmRAvSXLxLahz3w8bnjELYzmon
 TadzHCDWYLeUZpKOO/3Mi8Y9xcwsVJXPu6OMeXHRHhM6lSwu0a67Aak9JpXK/WzxVFcW
 CwYMvPCy5WGIaAeh3sM1KNb+4R6Fq3HOTM4sj0PDxSczFT3RMkucHPGiqsr7cv5ej8I/
 J3va5s5RwZgm45VQworIe25WVstgy9Ki6KUoI8kJDdfHuOEY4ZrJCsiMSaeN0Xjs2uma
 7M4g==
X-Gm-Message-State: AOJu0Yz0aK4CLwF3os44k7S5FqHxaiLUTnx1r4o3TiL2U0qUEvfR1I9T
 +3E8keg4VpN5k7WixXMQVibvTJwrsvD8bKRwcpe5Iy6FcalFv0KZG5iCbtgf+oIalCHTamlW4B/
 1w9l1hQ9b+iRgO2dFpZlgT8whPsPRj8A=
X-Gm-Gg: ATEYQzwLOG1g8RzgCZaJgSwUlA5lpKm0VBY2Aj9Cz1PCerpBdBEj71Dnw3sY8tRdjYW
 7PqI/lV60qqBa+6xZg3J4jCLnpqmm+Py8D7wRqzK3zHbcKyXvNSygeja+xetX9gwTD/rpixBGQT
 ctXj3n23Nr8iLJ5YiLJm71cbSxJcfP05iqKFJV6cF0FYEw4dqY7NPvdIHxTdo3lfFpCGCY3aevw
 J+O7G9XztX+ZsmwLLcaXH+2NwIo19BU4lATPTUBm9hGxq160U3H31eGgM2EdQ+XBi9T6G+VLRSX
 C4Kywc7rbAASQNdu2HhKm63p13kQJw0+2cVr0bSq
X-Received: by 2002:a05:6102:3046:b0:5f5:37f6:2b4e with SMTP id
 ada2fe7eead31-5ffab25d996mr2121071137.40.1772718631601; Thu, 05 Mar 2026
 05:50:31 -0800 (PST)
MIME-Version: 1.0
References: <20260218101859.3028581-1-david.marchand@redhat.com>
 <CAJFAV8xoT+rV3J1JR_zy0hCQhM6cW6J50dcd1s=LBft1qrdMKA@mail.gmail.com>
 <CAKx8PBiSXZJDAgLvFAZ85UhRU+FK7VHpYEqJTo=bwHngMCjFoQ@mail.gmail.com>
 <CAJFAV8x20i75_HhLb0Z2KxLY909NstvtQRyv54eqUV5SYAm9Lg@mail.gmail.com>
In-Reply-To: <CAJFAV8x20i75_HhLb0Z2KxLY909NstvtQRyv54eqUV5SYAm9Lg@mail.gmail.com>
From: Ben Magistro <koncept1@gmail.com>
Date: Thu, 5 Mar 2026 08:50:20 -0500
X-Gm-Features: AaiRm51uk5_aAEt-vNxPONsRDY_AxRgjP5ZnMfdydygmZqZxFCejNEazY_AuoCc
Message-ID: <CAKx8PBhDOAS7G7zK333U5P-H2tyDn1RJGD9m5+Ue13cN7_FMTQ@mail.gmail.com>
Subject: Re: [PATCH] eal/linux: fix HPET symbols export
To: David Marchand <david.marchand@redhat.com>
Cc: dev@dpdk.org, Chengwen Feng <fengchengwen@huawei.com>
Content-Type: multipart/alternative; boundary="00000000000052c94d064c4738b0"
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

--00000000000052c94d064c4738b0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

We know we are behind on updating our usage of DPDK so this might just help
nudge that along.  Appreciate the heads up though!

Cheers

On Thu, Mar 5, 2026 at 8:43=E2=80=AFAM David Marchand <david.marchand@redha=
t.com>
wrote:

> Hello,
>
> On Thu, 5 Mar 2026 at 14:21, Ben Magistro <koncept1@gmail.com> wrote:
> >
> > Just now getting to cleaning up my mailing list folder and came across
> this so apologize for reopening an older thread.  We will likely apprecia=
te
> the patch a great deal as we needed to switch to lld form clang (this pas=
t
> week).  When we made this switch (had some size related issues with
> sanitizer builds in our app with ld) lld definitely complained about the
> symbols not being defined.
> >
> > I don't have more of the output saved from when we found this, but did
> save off these lines while discussing with the team.
> >
> > ld.lld: error: version script assignment of 'DPDK_23' to symbol
> 'rte_eal_hpet_init' failed: symbol not defined
> > ld.lld: error: version script assignment of 'DPDK_23' to symbol
> 'rte_get_hpet_cycles' failed: symbol not defined
> > ld.lld: error: version script assignment of 'DPDK_23' to symbol
> 'rte_get_hpet_hz' failed: symbol not defined
>
> .map files were static until v25.07 and you seem to use a version
> prior to 23.11 LTS.
> The dynamic generation of .map has not been backported, so
> unfortunately this current patch will not help in your case.
>
>
> --
> David Marchand
>
>

--00000000000052c94d064c4738b0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">We know we are behind on updating our usage of DPDK so thi=
s might just help nudge that along.=C2=A0 Appreciate the heads up though!<d=
iv><br></div><div>Cheers</div></div><br><div class=3D"gmail_quote gmail_quo=
te_container"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 5, 2026 at =
8:43=E2=80=AFAM David Marchand &lt;<a href=3D"mailto:david.marchand@redhat.=
com">david.marchand@redhat.com</a>&gt; wrote:<br></div><blockquote class=3D=
"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(2=
04,204,204);padding-left:1ex">Hello,<br>
<br>
On Thu, 5 Mar 2026 at 14:21, Ben Magistro &lt;<a href=3D"mailto:koncept1@gm=
ail.com" target=3D"_blank">koncept1@gmail.com</a>&gt; wrote:<br>
&gt;<br>
&gt; Just now getting to cleaning up my mailing list folder and came across=
 this so apologize for reopening an older thread.=C2=A0 We will likely appr=
eciate the patch a great deal as we needed to switch to lld form clang (thi=
s past week).=C2=A0 When we made this switch (had some size related issues =
with sanitizer builds in our app with ld) lld definitely complained about t=
he symbols not being defined.<br>
&gt;<br>
&gt; I don&#39;t have more of the output saved from when we found this, but=
 did save off these lines while discussing with the team.<br>
&gt;<br>
&gt; ld.lld: error: version script assignment of &#39;DPDK_23&#39; to symbo=
l &#39;rte_eal_hpet_init&#39; failed: symbol not defined<br>
&gt; ld.lld: error: version script assignment of &#39;DPDK_23&#39; to symbo=
l &#39;rte_get_hpet_cycles&#39; failed: symbol not defined<br>
&gt; ld.lld: error: version script assignment of &#39;DPDK_23&#39; to symbo=
l &#39;rte_get_hpet_hz&#39; failed: symbol not defined<br>
<br>
.map files were static until v25.07 and you seem to use a version<br>
prior to 23.11 LTS.<br>
The dynamic generation of .map has not been backported, so<br>
unfortunately this current patch will not help in your case.<br>
<br>
<br>
-- <br>
David Marchand<br>
<br>
</blockquote></div>

--00000000000052c94d064c4738b0--
