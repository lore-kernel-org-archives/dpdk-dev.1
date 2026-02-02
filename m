Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E623E7DF08
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 16:47:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D2D84027D;
	Mon,  2 Feb 2026 17:47:09 +0100 (CET)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com
 [209.85.208.48]) by mails.dpdk.org (Postfix) with ESMTP id CCFCE4026D
 for <dev@dpdk.org>; Mon,  2 Feb 2026 17:47:07 +0100 (CET)
Received: by mail-ed1-f48.google.com with SMTP id
 4fb4d7f45d1cf-64b9dfc146fso8283654a12.0
 for <dev@dpdk.org>; Mon, 02 Feb 2026 08:47:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770050827; cv=none;
 d=google.com; s=arc-20240605;
 b=SqzHP8fVq43jMiPARngP8+u1TPOgbZ01d7OI3P8bucbmECt7VFTXLJJKwsxhHQdy+3
 RMbt5oa8QVYBgKW5OKgS80MeFJU4ev9JW7gjOByt9XxqbmxAbH1H/cmJ59M3SmR2Aw0L
 9aoAlHcrWcxXS0lYSVAf/UeDqi37McF/xOsoV+Ea8I3jg/aSeJyJ3oAz+RqGFtfPA7k4
 MMO+sRIDPmJadJx+Ljo5lT/2l1likHO7zrKdE3hbTpTlFnIA67flTJ0psf23Pf0hU6w3
 qnuBeMZw6A2UOFhdwY7BV8aJvi+r6ocDHOSX60+QMgt9wqOz4JRq0/qqFCcBrvI5XXCx
 yAaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TcnSPqsmvskmX1cilRPgIoFhnpXz/vz2UOUxTLJ1fiw=;
 fh=AGA8jY1CaDhYz3ALWPlXheqSksjxw63cnP4VgCgnobs=;
 b=eHCRIfuwaQG8oTSbStYkhlkvsA+gHayc3QdnWvvEYhXHGirPGpC5vzphgQBEcgTwJO
 FAbWyUdi55uoBa1l7xz/ecYMMCPxCI2r1oLGrB/AOAxHqp6JTljP5M4Em+nEHRPXSsxM
 TURJUCZEvVmMEqrwL8HVY17Pfy9hMpYIZdw0TNMdxmotyfEiStQP96BNvWCndPzx8DxE
 ePdFShzFzj28ljRvOhXwoCKOW6x5dZFvomhoU1yhfWviwE7ZhQ5U0EqTL8hVFXvDBpqs
 lMhdBQZR82KsYK/Sd14T7K1xAhfJFaoqisImPkQab/3frZJP9RqGbwrd9G6vWFYlQFye
 wCzQ==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1770050827; x=1770655627; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TcnSPqsmvskmX1cilRPgIoFhnpXz/vz2UOUxTLJ1fiw=;
 b=bV1z7QMWWYUNvQvNBmZ/XadpbPemKp+4wElmX+Sc8gSJsx+3sZxEBBtot9GnxM9VdP
 5Jgjq9e/dJ9Qzn7LxSfyoonjc94sUpfO33/t/m+GCrR5DwtuXNmZPCuP4QtU0+HnQgxc
 1vFdBhZO7dFvCCfPPBbZmPcW27UNYHN0sG0DQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770050827; x=1770655627;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TcnSPqsmvskmX1cilRPgIoFhnpXz/vz2UOUxTLJ1fiw=;
 b=PFb0Qn4FRknaOtvfj6mEq+ngGv7igTv/4Auh8q+VS4Mjbu/gQC2v4D6wf+MhmIRtCr
 MmM4Z8c4Z9N6g4wata/i1g1ljJ/fXBvNrOUh7LbnsjnfX9YK8HsvxFLEAb9+VCgdHdJ8
 pUaJwIvsWjJTM2vm6ayP4GdaKwlV+WN+9or1hWeagzaotIRucI214/ymzO2hoN7i6dmE
 P283MwM8ccZ/y2yFGqOnEw2+b3C1VENIiWQsJ/4Dted5mtpMilnN4sz0yeUGS4MmBLsq
 DQO1jir6F0DWNYsobanJFkqSHEGAFvoMGwZcNHZahYPl9YiCpKQmV6KBwnOjKAsuwGXs
 P+yA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBPkKGaG6k5MBG66GjWDhPa01FZMU7TI7UNMudxk04PiafQ7JQX6WFU4Z4gPs6xbOiyd0=@dpdk.org
X-Gm-Message-State: AOJu0YxBOVly6FWPl2hloN6h7VcMbIZU7ozpJA3p3OvPdi1sYWLeKJXN
 AqcCVImogVFA7wql9t3q/l23PTdF60G/0elhwKD0J6isLtZvYiuXcYoosY/lLIfPWyE8CL8Cq1Q
 GSdumMQz4CG3CNDSWNQOYFfhuoa1ANwJtsDtW2Tp7rA==
X-Gm-Gg: AZuq6aJ5zwjjama5ueR6PQO15Vj/LT2p49PZc5lSD97+sJRwesYZ01mn7f454xzuGiP
 wpBlm/7d6g0IzYF/fYw36anvqu4C2lU4+qNP6GXO0RmPE1QX19CU7pF6HLiYb4KjgsPCP4q4h1K
 MhX7ATYRtvdPeiU+DYDTi+g0Gy/7tESrGPUFmjTH8cMf/4yAAkOle5C9lvOEGWd2RC8G5fZ7Ayc
 Vyh2FOCCRhq0dj8Bj3fXUj9GlEFmmWMF89ru6C4cnj4O2h+zvy1qFDntV5J9eHYotnWU3QqRnCc
 3i970bEY315v6ISFbNgLrhW+Xrz3
X-Received: by 2002:a05:6402:1a53:b0:62f:9091:ff30 with SMTP id
 4fb4d7f45d1cf-659327eb130mr37194a12.3.1770050827359; Mon, 02 Feb 2026
 08:47:07 -0800 (PST)
MIME-Version: 1.0
References: <20260105190647.63244-1-abailey@iol.unh.edu>
 <20260105190647.63244-3-abailey@iol.unh.edu>
 <CAJvnSUBTtGyQ7WtE9GF-gawS=A8rHAqcaqTSo8eWYa+GBkhRwg@mail.gmail.com>
 <CABJ3N2W6QXQ1Aae4QWaZhSMrwMfmDa6oYjHby1YDQJdK2FknvA@mail.gmail.com>
 <CABJ3N2VTZc-73hP=0KG8EPbdrCexYZXToLzhJPAhkN+Eo77DWg@mail.gmail.com>
 <CO6PR18MB4484327639EC118ACFFF3810D881A@CO6PR18MB4484.namprd18.prod.outlook.com>
 <CABJ3N2Vf=guy5qJmmbTHY76Bnnn-5PTEkmB+FewahHqDzxJLiw@mail.gmail.com>
 <CO6PR18MB4484D1EF6B0BDF1205164276D896A@CO6PR18MB4484.namprd18.prod.outlook.com>
 <CABJ3N2UzbranA3ZTjm42Vf2UU8ajYh8uNVvttzm_D7z+oqH5uQ@mail.gmail.com>
In-Reply-To: <CABJ3N2UzbranA3ZTjm42Vf2UU8ajYh8uNVvttzm_D7z+oqH5uQ@mail.gmail.com>
From: Andrew Bailey <abailey@iol.unh.edu>
Date: Mon, 2 Feb 2026 11:46:55 -0500
X-Gm-Features: AZwV_QhBehZmZhDL-qNTLKMUsRw0ruBApFrGOp75Gh6scYz9AINQ9ti5PQLCkTA
Message-ID: <CABJ3N2VbQD=jWqg-UBbe2kuWAJtKsxkXNFy_bK+4imvTLR0+jA@mail.gmail.com>
Subject: Re: [EXTERNAL] Re: [RFC PATCH 3/3] dts: add cryptodev testsuite
To: Akhil Goyal <gakhil@marvell.com>
Cc: Kai Ji <kai.ji@intel.com>, Patrick Robb <probb@iol.unh.edu>, 
 "fanzhang.oss@gmail.com" <fanzhang.oss@gmail.com>,
 "luca.vizzarro@arm.com" <luca.vizzarro@arm.com>, 
 "dmarx@iol.unh.edu" <dmarx@iol.unh.edu>, "dev@dpdk.org" <dev@dpdk.org>
Content-Type: multipart/alternative; boundary="000000000000cca6b10649da12bf"
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

--000000000000cca6b10649da12bf
Content-Type: text/plain; charset="UTF-8"

Touching base,

When you have time to get back to us, if you have insight on question #1 it
would be most helpful. In the meantime we are going ahead with using a
smaller subset of cipher and authentication algorithms. Additionally we
plan on using 10,000,000 total operations but this is not final and can be
influenced by your response to question #2.

>
> 1. Test case reusability: If a cipher algorithm passes validation in
> cipher-only mode, can we reuse that cipher algorithm across all
> cipher-then-auth test runs while varying only the authentication algorithm?
>
> 2. Operations threshold: What is the recommended number of total
> operations per test to generate statistically meaningful performance
> metrics? We are starting with 30,000,000 total operations per run of the
> app.  since test execution time is always a concern and we may run
> dpdk-crypto-perf many times with a broad matrix of ciphers/algorithms based
> on your response to question #1, we are curious if there are tests where
> the total-operations argument can be reduced
>
>>

--000000000000cca6b10649da12bf
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr">Touching base,=C2=A0<div><br></div><div>W=
hen you have time to get back to us, if you have insight on question #1 it =
would be most helpful. In the meantime we are going ahead with using a smal=
ler subset of cipher and authentication algorithms. Additionally we plan on=
 using 10,000,000 total operations but this is not final and can be influen=
ced=C2=A0by your response to question #2.</div></div><div class=3D"gmail_qu=
ote gmail_quote_container"><blockquote class=3D"gmail_quote" style=3D"margi=
n:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex=
"><div dir=3D"ltr"><div dir=3D"ltr"><br>1. Test case reusability: If a ciph=
er algorithm passes validation in cipher-only mode, can we reuse that ciphe=
r algorithm across all cipher-then-auth test runs while varying only the au=
thentication algorithm?<br><br>2. Operations threshold: What is the recomme=
nded number of total operations per test to generate statistically meaningf=
ul performance metrics? We are starting with 30,000,000 total operations pe=
r run of the app. =C2=A0since test execution time is always a concern and w=
e may run dpdk-crypto-perf many times with a broad matrix of ciphers/algori=
thms based on your response to question #1, we are curious if there are tes=
ts where the total-operations argument can be reduced</div><div class=3D"gm=
ail_quote"><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><div><div lang=
=3D"EN-US"><div><div style=3D"border-top:none;border-right:none;border-bott=
om:none;border-left:1.5pt solid blue;padding:0in 0in 0in 4pt"><div><blockqu=
ote style=3D"border-top:none;border-right:none;border-bottom:none;border-le=
ft:1pt solid rgb(204,204,204);padding:0in 0in 0in 6pt;margin-left:4.8pt;mar=
gin-right:0in"><div><div><div><div style=3D"border-top:none;border-right:no=
ne;border-bottom:none;border-left:1.5pt solid blue;padding:0in 0in 0in 4pt"=
><div><div>
</div>
</div>
</div>
</div>
</div>
</div>
</blockquote>
</div>
</div>
</div>
</div>

</div></blockquote></div></div>
</blockquote></div></div>

--000000000000cca6b10649da12bf--
