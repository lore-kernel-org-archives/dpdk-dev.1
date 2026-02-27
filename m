Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54844FD5309
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 07:49:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 22D60402C6;
	Fri, 27 Feb 2026 08:49:31 +0100 (CET)
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com
 [209.85.160.170])
 by mails.dpdk.org (Postfix) with ESMTP id 452754028E
 for <dev@dpdk.org>; Fri, 27 Feb 2026 07:36:55 +0100 (CET)
Received: by mail-qt1-f170.google.com with SMTP id
 d75a77b69052e-506a3400f30so15371791cf.1
 for <dev@dpdk.org>; Thu, 26 Feb 2026 22:36:55 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772174214; cv=none;
 d=google.com; s=arc-20240605;
 b=TIKdWgMJF7W/tOQFl4LgwE9Q+oMjOs9rr91srOWf5IbzgzqlLDaqbtPmwrHunWGWoU
 SJKAY7lQkGF1we2Ml/vQUlNkgdtHUyPuqsRuyXg5FO02tb96fMcU03giUYt4E2oCXzNE
 U09PF15NaLJVXUTZv/c2ihZJGRvdvYYOlUVaAPHRWAotgToC+zFrbqJ7f804gubzgM7N
 czi22uE7kWnXwjd645YJ4zY5/OsSP7S0cpn16Tt1hnrrL5X8KfLJ+I2Udbdj/5onlE5e
 wd06pA/iZ8TQ5/VUduSEZlP/5+CdRjggqGnhrY/q18M9G6UOYpk5IvYKaHsF3Fwg3r2Q
 QtTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=9EC6enFtsWfGqhpUbvI+eymnYh8jsjpwo0hqA28yzrc=;
 fh=QqSp2qOfjmgRLQMSjxDk3o6rKv5A4907mNSxsDT3zMc=;
 b=iuSsZKgGdCCjPeKt+L4mhFRQ+VPEL8MMjtXmHdIQt3ihwyNhb5yf8VPByv1rHUWYbv
 GoIWefygCfVy+Kaokj6UPu0CQX49mVv6qW7Na/rdEO0UnlOtWvu1nqJJeCEbVsCgijbE
 4Kz6fpzkgX6OrXESz2kUQMZrT/T8clfi4nKS38uk8QgZIdd9i7+222WUzXN/tD/6R06l
 RRERBkQ+aIQnYDdXrSiLEOTHuI9v9Cg7S+tQGUj2Pe7Dd0FNz69/tchXRIeQIXDpB/wz
 H5XAgyXBGflq/GZD2ijiqZQe01O+MRrTE4FhSZ3lVyg7Pay2PzWmutzMymewzReq4zmA
 vCfQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772174214; x=1772779014; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=9EC6enFtsWfGqhpUbvI+eymnYh8jsjpwo0hqA28yzrc=;
 b=X31+0U9ofRRC5TG0qMt8CT66XHXLzlI86lbjVc8w11JBHu9D0EzHbdE+I4LK7yRZ5O
 ZGgQTV7dGUf/6FB2wU1l21BWyJRdNa1vvPhhpS+Tc7It+WeAFF42TBFKshed4FhruT15
 h2UYwkpqx9XAnYb8J+b92H4ysnKlzffSPJ38967jPYlo3YNaDnZYU7VWts/PrDwsZGPO
 x4i0gRY88OtU3Veacfh7xIDGiZL41bOp10TvP3jEfiN5j2hrTmfTrPr8DjNapp8q0trK
 Eccig7tEXiKzSH58yw7shpB0tDOVWcDkSjZyeSOrOf6StsjSoNsGgsbgn+aAvfXcy8dq
 k1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772174214; x=1772779014;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9EC6enFtsWfGqhpUbvI+eymnYh8jsjpwo0hqA28yzrc=;
 b=cCZVWD5Z3iGaIDtGKLpmS2cX4iqvWu/eWMI3G+KoQpJNoRo9lkyKcifhHGh1AEm2+9
 IMzud4te7Knn8CyGfm1O8xHI27iUuxO4S8IOdlX80lFTpXF5kA1f1CC4l5V/Q5GqwvwT
 do7B2LWbRjRzcnSxX5u3oVTD5P5tRc1D3hMql4b4JXaYi2/p4Y+6KVJHbiPeIEblc/zR
 AfVNmDynDtrnfNZQFTlXCyxKwD1qxyyG2yLKW51PR33FrW138dBnSNHoi/7OJIrMPrVo
 uukTUibqRn4X0ayW8V5c5LxPUTnmgnLC/XrhMLwqP1J9ycCUWjOybZyklrSanR3D/L0a
 Zn2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnfTGXlCMOYxwGpdCvWAov55YlWUehS4Tvych5LXa41zjV7wwYIjOOD4FTLMLPO1H3SF4=@dpdk.org
X-Gm-Message-State: AOJu0Yw+UNCqCYN+1U99KEUEmnOX8H2+PWMfZwOL+6vgV9WOIGr4Z6tm
 6d6naDWP4+IUbpO250Az12B61bKPwAHJvmSP945gUl/17EO07XS70M9ljeUld20K7GiDjdoQUcb
 asa0ugDcKKDZ/DBGNX07DI630wu+6lhA=
X-Gm-Gg: ATEYQzzrd30gPkrxCxcsWiPTlziBSK0weMQxAkycQ2WWfqxOT1XzXjGpxf5kWxnr+cA
 1JBCj4O5k8FLDeiM+IIszSW/wL/TRlCMnBe+xn/ejTXRSJ818t3VaBCAdFGDQJocF372HDd4dro
 N/3sG9HYX8Mmjk33tAMp0HOlwrIGnpF1fwlISXErbw2WrDLsybh0vliGWnjOqiyqv1QNa79Vwyn
 JPwvG3s+b0hHjuhFmvQTRiCM3BOFOAMmF/Gj5bCJeLtgvS/5aabUcqON3zy2Y8v+KTsEX0Fr/10
 nZ1Vq3Yxvv9mLnuViPz6
X-Received: by 2002:a05:622a:113:b0:506:1f30:bfc3 with SMTP id
 d75a77b69052e-5075248447bmr20850161cf.36.1772174214539; Thu, 26 Feb 2026
 22:36:54 -0800 (PST)
MIME-Version: 1.0
References: <20250803090837.15589edd@hermes.local>
 <7c1a559c1d4d4e9bb58c318a95399138@huawei.com>
 <ac1777c39e66443789e6d45fb1b9d7fd@huawei.com> <33965644.t2Qszz9eOc@thomas>
 <f33de0e613c44887a26fe8bf90022d2d@huawei.com>
 <db2579eb3b0a4476bd53d867ea1a8d04@huawei.com>
In-Reply-To: <db2579eb3b0a4476bd53d867ea1a8d04@huawei.com>
From: su sai <spiderdetective.ss@gmail.com>
Date: Fri, 27 Feb 2026 14:36:43 +0800
X-Gm-Features: AaiRm52BBaH-FpyzWsIKEdyj5DCz6o2uwwbc776tSWduaPQnQ91Ndt9xPHobcX8
Message-ID: <CAFQeoKheq+AcTiJ7UCxu5=x9OtDNX0vSV1SvVVVDB08Vm8vH5g@mail.gmail.com>
Subject: Re: [v3] net/cksum: compute raw cksum for several segments
To: Marat Khalili <marat.khalili@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>
Cc: "stephen@networkplumber.org" <stephen@networkplumber.org>,
 "dev@dpdk.org" <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="00000000000089aea4064bc87672"
X-Mailman-Approved-At: Fri, 27 Feb 2026 08:49:30 +0100
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

--00000000000089aea4064bc87672
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

As noted in Marat Khalili's analysis, we identified this issue in the
production environment. Meanwhile, I simplified the problematic scenario
into corresponding test cases and added them to app/test/test_cksum.c

On Sat, Feb 21, 2026 at 2:35=E2=80=AFAM Marat Khalili <marat.khalili@huawei=
.com>
wrote:

> > I can suggest my condition to get a wrong checksum, which does not go
> into the details of how it was
> > observed in the wild:
> >
> > Function rte_raw_cksum_mbuf may produce incorrect result when multiple
> segments are present in the
> > checksummed range, and some of them have odd checksummed length. More
> precisely, if any segment except
> > the last one begins at an odd offset from the start, and arithmetic sum
> of its 16-bit words overflows,
> > the part that has overflown will be lost. Cases when there is only one
> segment, or all of the segment
> > sizes and checksum offsets are even, are not affected.
>
> Apologies, rushed to send. The "except the last one" condition is
> unnecessary. Corrected version:
>
> Function rte_raw_cksum_mbuf may produce incorrect result when multiple
> segments are present in the checksummed range, and some of them have odd
> checksummed length. More precisely, if any segment begins at an odd offse=
t
> from the start, and arithmetic sum of its 16-bit words overflows, the par=
t
> that has overflown will be lost. Cases when there is only one segment, or
> all of the segment sizes and checksum offsets are even, are not affected.
>

--00000000000089aea4064bc87672
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div style=3D"color:rgb(0,0,0);font-varia=
nt-numeric:normal;font-variant-east-asian:normal;font-variant-alternates:no=
rmal;font-size-adjust:none;font-kerning:auto;font-feature-settings:normal;f=
ont-stretch:normal;font-size:16px;line-height:24px;font-family:ui-sans-seri=
f,system-ui,sans-serif,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&q=
uot;,&quot;Segoe UI Symbol&quot;,&quot;Noto Color Emoji&quot;;padding:0px;m=
argin:0px;background:none 0% 0%/auto repeat scroll padding-box border-box r=
gba(0,0,0,0)">As noted in Marat Khalili&#39;s analysis, we identified this =
issue in the production environment. Meanwhile, I simplified the problemati=
c scenario into corresponding test cases and added them to app/test/test_ck=
sum.c</div><div style=3D"color:rgb(0,0,0);font-variant-numeric:normal;font-=
variant-east-asian:normal;font-variant-alternates:normal;font-size-adjust:n=
one;font-kerning:auto;font-feature-settings:normal;font-stretch:normal;font=
-size:16px;line-height:24px;font-family:ui-sans-serif,system-ui,sans-serif,=
&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI Sym=
bol&quot;,&quot;Noto Color Emoji&quot;;padding:0px;margin:0px;background:no=
ne 0% 0%/auto repeat scroll padding-box border-box rgba(0,0,0,0)"></div>
<h3 style=3D"color:rgb(0,0,0);font-variant-numeric:normal;font-variant-east=
-asian:normal;font-variant-alternates:normal;font-size-adjust:none;font-ker=
ning:auto;font-feature-settings:normal;font-weight:400;font-stretch:normal;=
font-size:16px;line-height:24px;font-family:ui-sans-serif,system-ui,sans-se=
rif,&quot;Apple Color Emoji&quot;,&quot;Segoe UI Emoji&quot;,&quot;Segoe UI=
 Symbol&quot;,&quot;Noto Color Emoji&quot;;padding:0px;margin:0px;backgroun=
d:none 0% 0%/auto repeat scroll padding-box border-box rgba(0,0,0,0)"></h3>=
</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr"=
 class=3D"gmail_attr">On Sat, Feb 21, 2026 at 2:35=E2=80=AFAM Marat Khalili=
 &lt;<a href=3D"mailto:marat.khalili@huawei.com">marat.khalili@huawei.com</=
a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">&g=
t; I can suggest my condition to get a wrong checksum, which does not go in=
to the details of how it was<br>
&gt; observed in the wild:<br>
&gt; <br>
&gt; Function rte_raw_cksum_mbuf may produce incorrect result when multiple=
 segments are present in the<br>
&gt; checksummed range, and some of them have odd checksummed length. More =
precisely, if any segment except<br>
&gt; the last one begins at an odd offset from the start, and arithmetic su=
m of its 16-bit words overflows,<br>
&gt; the part that has overflown will be lost. Cases when there is only one=
 segment, or all of the segment<br>
&gt; sizes and checksum offsets are even, are not affected.<br>
<br>
Apologies, rushed to send. The &quot;except the last one&quot; condition is=
 unnecessary. Corrected version:<br>
<br>
Function rte_raw_cksum_mbuf may produce incorrect result when multiple segm=
ents are present in the checksummed range, and some of them have odd checks=
ummed length. More precisely, if any segment begins at an odd offset from t=
he start, and arithmetic sum of its 16-bit words overflows, the part that h=
as overflown will be lost. Cases when there is only one segment, or all of =
the segment sizes and checksum offsets are even, are not affected. <br>
</blockquote></div></div>

--00000000000089aea4064bc87672--
