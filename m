Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1936ACFD2F6
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Nov 2025 22:02:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D808A402BC;
	Thu, 27 Nov 2025 23:02:00 +0100 (CET)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by mails.dpdk.org (Postfix) with ESMTP id A09364013F
 for <dev@dpdk.org>; Thu, 27 Nov 2025 23:01:59 +0100 (CET)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-8b2f0f9e4cbso102033985a.0
 for <dev@dpdk.org>; Thu, 27 Nov 2025 14:01:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764280919;
 x=1764885719; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iSWKyPxs5KKczMsu32ANdgnuZol9KRYbHt2+Po6Unbs=;
 b=qyxttiHjX+CjocPp3KahmgB077HNUqjZEhtJezS5iWAEayh9Vv7GGlhdFkRm1La9Uj
 0dtEe4FPF0NcsLQ/JzdgjZbbOOXxW/BxR3Hg1KQNiO/7myu0Jc+7HIrZAIxT2o2lfATw
 yKQIl0EQRBEKWPNCeJkDPqdGDGhn+t5UgjGUwDOf60qFHeyqKJn1MLtaevXY/WskFN5D
 ts2txfrRtq09otyJTeggFLihyTsjA39KGmH0lawSUFdCCfvXVE/vlWUUNqBtXk4RTQ28
 UP0bPi1A17YHpgBrutU2vMloeSFak03SFE7HOOcFssBvNL3QbsSOUuTJjdi32xFVbyHS
 azhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764280919; x=1764885719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iSWKyPxs5KKczMsu32ANdgnuZol9KRYbHt2+Po6Unbs=;
 b=BUFULHpPcwANIQVrf7EuTovvqJb66tCvy7J6BOkN6YOvF2LBJMsLF0LISYtHQw7g95
 TTdLhThuvQ4Jb6gz+9GWt0GBzKkZ0ICNOeYn8er+fvqqw6z7SlFZhszZJoPgoGbXexQY
 Ax/oJnTxs12YYR0btHOUxZk6V9SI2CTNRrta5NxvX8KTNpjiMkWRtCwxoJcNuhQNZS/m
 Dom78NLQabKyeeGMivr/pq07bvrV19cW50WJrCZ9KV/Np3FoZ5fTtNfiUL5XvhK3/urS
 fXNx+pF3qsffAYbfqrf9cmd3e0Lvp0FOpOmliuk8q7L0VvX9/iGx6/nP2vaRSUIZlk3N
 H1hw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1XIiT2B0/KrE/z0UJrHw6o5lzbhfOR+X+es1l5XBjs7lAcgTO3K5zCmDQifYFTw8R1Ts=@dpdk.org
X-Gm-Message-State: AOJu0YxYWuhzXzG6CSrY0oO295sz05UK/3/Gb+kon/ON8skXtfKXWzrm
 I4jlcqVQZs94G71zOboi/D3ulB6vh0o31jMJguJImpbF9DdJ0zzC1yhe3THsy7/lCGA=
X-Gm-Gg: ASbGncsIIP09Z5iGNQ2LBn4CN/DI2q9mtEyJz/NyIlf3C3ts4KfD/BWNtRzlBBh0182
 wnkHYA/gTj0V5nDHLD5K1aTqmwNkTyGh+93w1LppJBsCFNhAHitHt2+K6hqIvtOA9jCsVSY6LG7
 HG6Tegg9Kk2bftWli654NPt75Ux42Q1XwjfdtrvHIMkg6BWDbcldRCa9lJ8a2zcXj6zA4pnQuud
 oz2swjUJrQbmwKkHrUfPx1XrwvX4wDrn1Yof7Bn8nFWQ0P8k9YENytV3PayxKT2zlAV7oD/mHeT
 +NAF/zTNv2qV+CR2O+uZMPuTEVzDJqlqAkqFGW1GWF4QuWd+Z+JT0urzoL/qYVpvpTW8A+Jaiwe
 ZwzfeDuWaAXqkqCr3pWRH+TQVQ9nH8tHeJM+PVOYGwE5AIpAM+QyYr1VAfKhkbQgNc3Tn6Lr56H
 Okuzk13MjbBuMM0igtfDpK0H/XFEBYmhjLzh/F1/hWuxTZ2PKlyXgM
X-Google-Smtp-Source: AGHT+IG1iQDJaqqqZmn/09iwwdGDCy/9o8sPuzFatd2G9pLnEQhh0yToWmHYkfgoHhUxINyMyAkOlg==
X-Received: by 2002:a05:620a:1a23:b0:8a0:7561:93c7 with SMTP id
 af79cd13be357-8b32aca7dfcmr4401273885a.17.1764280918715; 
 Thu, 27 Nov 2025 14:01:58 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b52a1b759esm182353185a.31.2025.11.27.14.01.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 14:01:58 -0800 (PST)
Date: Thu, 27 Nov 2025 14:01:53 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Morten =?UTF-8?B?QnLDuHJ1cA==?= <mb@smartsharesystems.com>
Cc: "Pavan Nikhilesh" <pbhagavatula@marvell.com>, "Jerin Jacob"
 <jerinj@marvell.com>, "Wathsala Vithanage" <wathsala.vithanage@arm.com>,
 "Bruce Richardson" <bruce.richardson@intel.com>, <dev@dpdk.org>
Subject: Re: [RFC 1/2] config: add optimal burst size configuration
Message-ID: <20251127140153.202a38dd@phoenix.local>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65592@smartserver.smartshare.dk>
References: <20251126082414.91933-1-pbhagavatula@marvell.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65592@smartserver.smartshare.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Wed, 26 Nov 2025 10:57:13 +0100
Morten Br=C3=B8rup <mb@smartsharesystems.com> wrote:

> > From: Pavan Nikhilesh <pbhagavatula@marvell.com>
> >=20
> > Add RTE_OPTIMAL_BURST_SIZE to allow platforms to configure the
> > optimal burst size.
> >=20
> > Set default value to 64 for soc_cn10k and 32 generally.
> >=20
> > Signed-off-by: Pavan Nikhilesh <pbhagavatula@marvell.com>
> > ---
> > This improves performance by 5% on l2fwd, other examples showed
> > negligible difference on CN10K.
> > =20
>=20
> I support the concept of having a recommended mbuf burst size, targeting =
the majority of generic applications.
> Making it CPU dependent seems like a good choice.
>=20
> It should be named differently.
> First of all, "optimal" depends on the use case; if targeting low latency=
, shorter bursts are better, so "OPTIMAL" should not be part of the name.
> Second, I would guess that it only targets mbuf bursts, not also bursts o=
f other operations (e.g. hash lookups), so "MBUF" should be part of the nam=
e.
>=20
> Suggestion:
> /* Recommended burst size for generic applications, striking a balance be=
tween throughput and latency. */
> dpdk_conf.set('RTE_MBUF_BURST_SIZE_MAX' (or _DEFAULT), 64)
>=20
> <feature creep>
> /* Recommended burst size for generic applications targeting low latency.=
 */
> dpdk_conf.set('RTE_MBUF_BURST_SIZE_MIN', 4)
> </feature creep>
>=20
> Having these standardized will also allow libraries and drivers to optimi=
ze for them, e.g. drivers should support bursts sizes all the way down to R=
TE_MBUF_BURST_SIZE_MIN, and can static_assert() that the RTE_MBUF_BURST_SIZ=
E_MIN is not lower than supported by the driver/hardware.
>=20
> <more feature creep>
> rte_config.h could have "#define RTE_MBUF_BURST_SIZE RTE_MBUF_BURST_SIZE_=
MAX", for the application developer to change to RTE_MBUF_BURST_SIZE_MIN fo=
r low latency applications.
> This will let the libraries and drivers optimize for the specific burst s=
ize used by the application.
> </more feature creep>
>=20
> <rambling>
> Intuitively, I would assume that the optimal burst size essentially depen=
ds on the CPU's L1D cache size and the application's number of non-mbuf cac=
he lines accessed per burst.
> Let's say a CPU core has 32 KiB cache (=3D 512 cache lines), and each bur=
st touches 4 cache lines per packet:
> 2 cache lines for the mbuf
> 1 cache line for the packet data
> 1 cache line per packet for some table lookup/forwarding entry
>=20
> Then the mbuf burst should be max 512/4 =3D 128.
> But local variables also use memory during processing, so using a burst o=
f 64 would leave room for that and some more.
> </rambling>
>=20
> >  config/arm/meson.build | 1 +
> >  config/meson.build     | 1 +
> >  2 files changed, 2 insertions(+)
> >=20
> > diff --git a/config/arm/meson.build b/config/arm/meson.build
> > index 523b0fc0ed50..fa64c07016b1 100644
> > --- a/config/arm/meson.build
> > +++ b/config/arm/meson.build
> > @@ -481,6 +481,7 @@ soc_cn10k =3D {
> >          ['RTE_MAX_LCORE', 24],
> >          ['RTE_MAX_NUMA_NODES', 1],
> >          ['RTE_MEMPOOL_ALIGN', 128],
> > +        ['RTE_OPTIMAL_BURST_SIZE', 64],
> >      ],
> >      'part_number': '0xd49',
> >      'extra_march_features': ['crypto'],
> > diff --git a/config/meson.build b/config/meson.build
> > index 0cb074ab95b7..95367ae88e2d 100644
> > --- a/config/meson.build
> > +++ b/config/meson.build
> > @@ -386,6 +386,7 @@ if get_option('mbuf_refcnt_atomic')
> >      dpdk_conf.set('RTE_MBUF_REFCNT_ATOMIC', true)
> >  endif
> >  dpdk_conf.set10('RTE_IOVA_IN_MBUF', get_option('enable_iova_as_pa'))
> > +dpdk_conf.set('RTE_OPTIMAL_BURST_SIZE', 32)
> >=20
> >  compile_time_cpuflags =3D []
> >  subdir(arch_subdir)
> > --
> > 2.50.1 (Apple Git-155) =20

I understand the motivation, and it make sense for a pure embedded system.
But then again on an embedded system the application can just set its burst=
 size;
this config option only impacts performance of testpmd and examples. And the
performance of testpmd is mostly irrelevant what matters is the real applic=
ation.

Making it a DPDK config option is a problem for DPDK build in distros.
The optimal burst size would be driver dependent etc.

Perhaps better off in the existing rx / tx descriptor hints.
Most of those device configs really need to be relooked at
since they were inherited from how old Intel drivers worked.
