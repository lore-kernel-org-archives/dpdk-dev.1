Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7056AC3601E
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Apr 2025 13:46:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B66804060C;
	Thu,  3 Apr 2025 15:46:50 +0200 (CEST)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id 4CA4F402A0
 for <dev@dpdk.org>; Thu,  3 Apr 2025 15:46:49 +0200 (CEST)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-301c4850194so707503a91.2
 for <dev@dpdk.org>; Thu, 03 Apr 2025 06:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=iol.unh.edu; s=unh-iol; t=1743688008; x=1744292808; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vOgP+Sp77Ea/JQaNYWg8t718V0pmxRLYv69jBXqOsLo=;
 b=fQNRCFTwktpBWI0ws5wCRFFt9TPZernAVr0S5b5EVTuP6sWOQt0WFNtFmevokXe4CU
 KZpuMEPkmn52avERtJfh8A9Np91kXvn+WwS2NlWTpaPDvwStsBdDa8H3DoPSrw/zSMQi
 tc99s6Q/J8NnFmDPz5kNBPu+xAXQ2G+kMcfSY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743688008; x=1744292808;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vOgP+Sp77Ea/JQaNYWg8t718V0pmxRLYv69jBXqOsLo=;
 b=csj7NEqVKIDMSUNZ6oQ5ElJgGxvDbLZO70OqvqXdxJ7qc6tLBAGwM59Dl+Oygx1FQj
 UrtCBvxIgluwUxuXSlOGA/dGM2+Ri6iLsLDMBt5Lb8JP6xAYTVcXfUmGl4QXq5h5z3CF
 +TeLQxIZCZgET9LQuwzTezPCbPBuE+g3VeUWu/sLKhydVKOnBj0thosZJWDl3yyCtPOr
 UIgg/lETZFadeDCsry6lXLO/NAvTTMp6JqfmdO0GApa+jIAE79Xum0cKi954Tf1blEmD
 xMeGyyhlZgD3r9TvdBwCn1mo2I1iPHrzIsHZgbAPp4uqnWBGYyqeONd5kH164akv89VV
 IdEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU81w9pm0wgfx+8I6n0grlyf08LN2Eej8ruUZxRywVD/ngAesXjrSfRJYU5PruDPZGbd3M=@dpdk.org
X-Gm-Message-State: AOJu0Yyrf5wH+XHhvmKVL8m8T00VFrqMNxWJBrxXCGujJNCGcPPf77vK
 Ms3EGfFTi3pKIQaN1/tvoGPCvdfmtxdnoank8BDVBYWCDow5mGZ5vQFEn8l2TqF9Ws2qVenvT8e
 vE1U0zENr3Mzu4QnbHtqIdliNoiQ/k11SnOGSjg==
X-Gm-Gg: ASbGnctJC/AIJwVqafimRP9kr4byUn7mNiC4ThkiGalJm8+9wsALpZM657XFqtsxEYo
 eddDbvo366rTeBGOs7tj/lv7WjAdeLNXFGffxwg8pKO5HoBZtmIfAq8ynexKzpb/l8tnl6OxD4p
 ylbYaShI4lx3F23kstCM16aBfnRbu28rz9athd1WjyCw==
X-Google-Smtp-Source: AGHT+IE+NerQB/CY7KS8Vpp23NMk2QjgUMWTkjl89IU+81bZpDMLCvH0YJaK33n28jOlRGPDDzhTRMLSBjQNzSEECgE=
X-Received: by 2002:a17:90a:d64d:b0:301:a0e9:66f with SMTP id
 98e67ed59e1d1-3057cbfae85mr3986648a91.14.1743688008398; Thu, 03 Apr 2025
 06:46:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250403023059.1762841-1-probb@iol.unh.edu>
 <20250403023059.1762841-2-probb@iol.unh.edu>
 <98bbf31f-adda-43e0-acbe-f4e4765883db@arm.com>
In-Reply-To: <98bbf31f-adda-43e0-acbe-f4e4765883db@arm.com>
From: Patrick Robb <probb@iol.unh.edu>
Date: Thu, 3 Apr 2025 09:42:45 -0400
X-Gm-Features: AQ5f1JqzGFaIzawL-cTXNrc8NG4efPvZIuS9amcxuWMEAmfpmcU1gSYeOCtCjfk
Message-ID: <CAJvnSUBZF2A04C_vhtj2w8-KA2xMo3hXs71huSfK2hbht9Pygg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dts: include smoke tests in tests config
To: Luca Vizzarro <Luca.Vizzarro@arm.com>
Cc: Paul.Szczepanek@arm.com, dev@dpdk.org, dmarx@iol.unh.edu, 
 npratte@iol.unh.edu, thomas.wilks@arm.com
Content-Type: multipart/alternative; boundary="000000000000571aae0631e000de"
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

--000000000000571aae0631e000de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks Luca for the info - there is also 1 other fix needed. I'll send a v2=
.

On Thu, Apr 3, 2025 at 9:45=E2=80=AFAM Luca Vizzarro <Luca.Vizzarro@arm.com=
> wrote:

> Hi Patrick,
>
> this looks good, easy and quick fix. I am afraid that you can't append
> to an `Iterable` type though. I've also confirmed this with mypy:
>
>    Unsupported left operand type for + ("Iterable[TestSuiteConfig]")
>
> I guess the easiest fix is to just change the argument type to `list`
> from `Iterable`.
>
> Best,
> Luca
>
>

--000000000000571aae0631e000de
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks Luca for the info - there is also 1 other fix neede=
d. I&#39;ll send a v2.</div><br><div class=3D"gmail_quote gmail_quote_conta=
iner"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, Apr 3, 2025 at 9:45=E2=
=80=AFAM Luca Vizzarro &lt;<a href=3D"mailto:Luca.Vizzarro@arm.com">Luca.Vi=
zzarro@arm.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">Hi Patrick,<br>
<br>
this looks good, easy and quick fix. I am afraid that you can&#39;t append =
<br>
to an `Iterable` type though. I&#39;ve also confirmed this with mypy:<br>
<br>
=C2=A0 =C2=A0Unsupported left operand type for + (&quot;Iterable[TestSuiteC=
onfig]&quot;)<br>
<br>
I guess the easiest fix is to just change the argument type to `list` <br>
from `Iterable`.<br>
<br>
Best,<br>
Luca<br>
<br>
</blockquote></div>

--000000000000571aae0631e000de--
