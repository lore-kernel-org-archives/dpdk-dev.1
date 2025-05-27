Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D632C3ABB2
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 May 2025 07:05:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F2199402A8;
	Wed, 28 May 2025 09:05:05 +0200 (CEST)
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by mails.dpdk.org (Postfix) with ESMTP id 0A0B740662
 for <dev@dpdk.org>; Tue, 27 May 2025 17:40:12 +0200 (CEST)
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-47686580529so28430431cf.2
 for <dev@dpdk.org>; Tue, 27 May 2025 08:40:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748360411; x=1748965211; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7A1mgeJ+ca8iN3fdfPfjf7N+JTWyUoEiGRVcmf1Vc/4=;
 b=DvtZGLKyFOdEpCWew3t0TOUIRnv8GQUPEymNOSCrxVVmPnE6tLUlIJrCHvxopwyvBI
 Ysg/sIXvGzD0mA+8VePfZVnQXQ92Zhd+rKi/X6KZ8SaVQlI54aig0Jixcu/qVLirbx9S
 sGcY5ozGvuAlzb4cMQpvtGjz6cY30XgToVar+CyN7ISmxS/nxuhP0k8pSpGjALdZR8E/
 ZPckEUymGoW03A7fHk1IHdV8Il+CP2SZsxqdYmrtn764vIANewa/RNhQINs6pa246Oy7
 wpXoVzLEKtcyAXR/EEEPOCdsFGt3bKcp981UHY67DpxwfOSRRMS3riG91g13Ua9dSFHT
 G4Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748360411; x=1748965211;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7A1mgeJ+ca8iN3fdfPfjf7N+JTWyUoEiGRVcmf1Vc/4=;
 b=mqFeTL7UcVRW5MrSGdjZbjRmJcnaTdSvSGHh5agwVAqbkROvWE3wVjjfO/6KqfcFd4
 Yi1+qhDeQuCrHv07rsQ+gH+zh0MeBZBTdVi0LW07gxXmHmWTaLTLsqehNPbYhMjyzIZ/
 rYXxttvBPM8ej6l7TId6W5/y6Ic0HJXZGIP6ZsJ9c0BSqyOKfMcTnjQhf/fXRTnRSfHM
 zuXHtOousuPwqHRsndjU9tzrOdRQjz+4j9vxd+/6n+7WvasJIGJhRDBr694mSr2UQo9a
 A/R9mw7eTORQJU3vN/JN6r0SbzppDDCJYUT1J2Lyal1LxKS6i7oxKzOlOiK/jS24Ij/U
 85CQ==
X-Gm-Message-State: AOJu0YxqRMIvOasabFBuH9wD76iG5SXFeJwouY8UYzdk4hGntxzpS1Sj
 9zFcyZvGMAyqbK4axZhWnvipsWwL5W6+saDzfybYexhU4KSGU8LC5uW85ihgMNVdiYMrxC8whaI
 hp/u7fzktMMMMbfQCxuabvL8bODOIPq+94Msy
X-Gm-Gg: ASbGncvHKp7VVpYWmob5UH8mnZ3BN6cq3TBMzO4LMX6w9J8J1mDa00m1sDx+K4d6bEQ
 4m1VmjkmyR2xKHHNrBcsUPXMnyZwexIy5smaiznmbW/Tf6Ji6TCI8rOv1+Z6H8d9rJBsRrlXBj0
 fglqhirrEvtrSsxONj4bEp2P8v5z+Oul2J
X-Google-Smtp-Source: AGHT+IF52h3OKpGLVRplKdxlSFKKiWvkbZaamhgSGWElRMMc2VbHP7jmDXz52yXJnsdPCZank9f1Ot7JtKUJLpg+qoE=
X-Received: by 2002:a05:622a:558d:b0:494:b316:3c8a with SMTP id
 d75a77b69052e-49f46057003mr244450391cf.5.1748360411206; Tue, 27 May 2025
 08:40:11 -0700 (PDT)
MIME-Version: 1.0
References: <CA+xuiv2jL934JR_QyLC1M5A+5dGPzw5L0=4RoS98eRjueA+9-g@mail.gmail.com>
 <20250521071845.50d6f9e1@hermes.local>
 <CA+xuiv0gKOp=Ukd=Nd-b=CV3YvA8P+HpR3PiH4h+9Dus9-vK1g@mail.gmail.com>
 <20250522082105.2aa03935@hermes.local>
In-Reply-To: <20250522082105.2aa03935@hermes.local>
From: farooq basha <farooq.juturu@gmail.com>
Date: Tue, 27 May 2025 21:09:57 +0530
X-Gm-Features: AX0GCFsAl9e3-pD_ernAVvQ4ilWvwznq98nrqw-_nc4PUMC1F4ZQ27Pt0rvJOns
Message-ID: <CA+xuiv0zZ82m9gUM5D73hLVC89si72piuax6jk_a6ZzHuoBzzg@mail.gmail.com>
Subject: Re: [dpdk-dev] Regarding HQOS with run-to-completion Model
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="0000000000003fdacb06361fe185"
X-Mailman-Approved-At: Wed, 28 May 2025 09:05:04 +0200
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

--0000000000003fdacb06361fe185
Content-Type: text/plain; charset="UTF-8"

Thanks Stephen.

             While browsing the DPDK qos code, i figured out that existing
PIPE-PROFILE cannot be updated or deleted at run time.
Was there any reason why this limitation ?

Thanks
Farooq.J

On Thu, 22 May, 2025, 20:51 Stephen Hemminger, <stephen@networkplumber.org>
wrote:

> On Thu, 22 May 2025 08:15:14 +0530
> farooq basha <farooq.juturu@gmail.com> wrote:
>
> > Thanks Stephen for addressing my queries , and it is helpful.
> >
> >     One more follow up question on the same ,   Can DPDK HQOS be
> customized
> > based on Use case ?
> >
> >     For example: Hqos config for one of the use cases ,  *One Port , One
> > Subport , 16 Pipes & Each Pipe with only one TC*.
> >                          16 pipe config was allowed but changing the
> 13TCs
> > to 1TC is not allowed per Pipe.
> >
> >     Can I still use 13 TCs but use the QueueSize as 0, Can that impact
> > performance ?
> >
>
> No. Current qos sched code has hard coded assumptions on number of pipes
> etc.
> I think it is modeled after some carrier standard and is not generally
> that useful.
>

--0000000000003fdacb06361fe185
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks Stephen.<div><br></div><div>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0While browsing the DPDK qos code, i figured out =
that existing PIPE-PROFILE cannot be updated or deleted at run time.=C2=A0<=
/div><div>Was there any reason why this limitation ?</div><div><br></div><d=
iv>Thanks</div><div>Farooq.J</div></div><div dir=3D"auto"></div><br><div cl=
ass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, 22 May, 2=
025, 20:51 Stephen Hemminger, &lt;<a href=3D"mailto:stephen@networkplumber.=
org" target=3D"_blank">stephen@networkplumber.org</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-l=
eft:1px solid rgb(204,204,204);padding-left:1ex">On Thu, 22 May 2025 08:15:=
14 +0530<br>
farooq basha &lt;<a href=3D"mailto:farooq.juturu@gmail.com" rel=3D"noreferr=
er" target=3D"_blank">farooq.juturu@gmail.com</a>&gt; wrote:<br>
<br>
&gt; Thanks Stephen for addressing my queries , and it is helpful.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0One more follow up question on the same ,=C2=A0 =C2=
=A0Can DPDK HQOS be customized<br>
&gt; based on Use case ?<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0For example: Hqos config for one of the use cases ,=
=C2=A0 *One Port , One<br>
&gt; Subport , 16 Pipes &amp; Each Pipe with only one TC*.<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 16 pipe config was allowed but changing the 13TCs<br>
&gt; to 1TC is not allowed per Pipe.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Can I still use 13 TCs but use the QueueSize as 0, =
Can that impact<br>
&gt; performance ?<br>
&gt; <br>
<br>
No. Current qos sched code has hard coded assumptions on number of pipes et=
c.<br>
I think it is modeled after some carrier standard and is not generally<br>
that useful.<br>
</blockquote></div>

--0000000000003fdacb06361fe185--
