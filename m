Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22641C35FFA
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Mar 2025 17:28:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 35C6C402C4;
	Wed, 19 Mar 2025 18:28:33 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 51E694026B
 for <dev@dpdk.org>; Wed, 19 Mar 2025 18:28:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742405310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J2Owe93JuoSF61/OcqgJ/gA2Eg6Cn6U93zhtgh8s/BU=;
 b=aUGkjJJ0AORI1j03fewX1nseeAouyHCUqq32cZQ3WrFMue/GzKDd7kPamLsoxsCKKW4VHI
 mc8fIB24Y7uOYoQrMNLdJBQKmrq2H/320OHX1d8es7zkJ1KOeD+U/e7bGaxUTVKBNoRX1T
 D14h3qelkXEQWldwJwpPGvJTtFu7YCQ=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-205-xM57JJyNMjankpYYa5Tnmg-1; Wed, 19 Mar 2025 13:28:29 -0400
X-MC-Unique: xM57JJyNMjankpYYa5Tnmg-1
X-Mimecast-MFC-AGG-ID: xM57JJyNMjankpYYa5Tnmg_1742405308
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-30bf67adf33so5363271fa.0
 for <dev@dpdk.org>; Wed, 19 Mar 2025 10:28:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742405308; x=1743010108;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J2Owe93JuoSF61/OcqgJ/gA2Eg6Cn6U93zhtgh8s/BU=;
 b=IVd95hXW7s+J29XDRlTFTgCLYkPRm7CwaZgun0A1kDQhKqhouJKyjBEUarnL/oEX6O
 5GrCZpN2HxmHRfF5pPt315lQ81D+W3ygKKE82Y26LGxSoTKWF6rsTggHyl40UlPFs81z
 Ge3KaFMB2lZALxCxs+Jfo+VD3XvYiAhzGATs8/sTvBGL20dFpIbxctWOXCNwNhoE6p5q
 hZrPfKXM+/HBeoZ7O7bwBNRmT0ebE7wDw0OmQ/IaHnz1Vx9hPyLZljREavx9fVYlA+Iq
 zgsQVnwxJZdvWxa2TZkWTS/TXMRohf+VSt+7XvoHCcH5qMsocv7DoPrgbfFusKKhNmyM
 uH3A==
X-Gm-Message-State: AOJu0Yw7kCImW26H9wGY7Svy9qNOOHP2OK/S/u6zen8zjrO9DKjn2553
 XZwS+vbYqnzAI/LXakipHK4l4tMJdKSvOG/G8Ldjx6xQotSsfj1ExgFIVrfjrF5IJW5JsLtC44T
 TAml89Y4w4JTfsfYXaVA3jGwOQjvXsy9TCeWg0aL/1cyYBlYR70hC1oukbBg9LzczBwE4jN0J6M
 WN2GzRszNgL4/1v7w=
X-Gm-Gg: ASbGncsFnPmKBWN1RgIyGEDtLlBwSYt0oqeOgdfVNhAxwDFeZNxIpKJJd9bvKtjMujf
 kOXFnmXY2Juq6p3EbQk/UN4c1MbFfR4K81kqqOOvBjM+LijAP0spOP2Zsmy818fzAKn+PyBq1Bg
 1PA4mbBa0ZQc5959Cfuixen8R4ueUxwQ==
X-Received: by 2002:a2e:a589:0:b0:308:e956:66e with SMTP id
 38308e7fff4ca-30d72669124mr1738941fa.0.1742405307865; 
 Wed, 19 Mar 2025 10:28:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvLSmVWC5ZxszMX4tYnoCvDBNncFWs9CMG+6RaszCVf/7qCM80vuhN/shRca0xX8lWXDAni6rSPC0ZPxMxJpQ=
X-Received: by 2002:a2e:a589:0:b0:308:e956:66e with SMTP id
 38308e7fff4ca-30d72669124mr1738841fa.0.1742405307444; Wed, 19 Mar 2025
 10:28:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250305134720.907347-1-bruce.richardson@intel.com>
 <20250305162458.1059282-1-bruce.richardson@intel.com>
 <CAJFAV8xA-HK63XxSEYNZBTeghOUgtEEKTe=iBE4syCF_vsoKxQ@mail.gmail.com>
 <Z9r2xwbFB2S2200Q@bricha3-mobl1.ger.corp.intel.com>
In-Reply-To: <Z9r2xwbFB2S2200Q@bricha3-mobl1.ger.corp.intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 19 Mar 2025 18:28:16 +0100
X-Gm-Features: AQ5f1JodzDAyhrUj0fwa_McH93zCqvh2hr5TkADFGIeaS0atCHwnhADdC-og1BY
Message-ID: <CAJFAV8yL-RThZMckwNn+Tt0EDJ_BfRhP2uw+N7vkLP+3r1UqQQ@mail.gmail.com>
Subject: Re: [PATCH v2] eal: fix undetected NUMA nodes
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Anatoly Burakov <anatoly.burakov@intel.com>, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2DnWyO-iN5eSYr8iRIEs1pQeWmNrQ_4EXS1SqkOkrAM_1742405308
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Mar 19, 2025 at 5:55=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> On Wed, Mar 19, 2025 at 05:31:45PM +0100, David Marchand wrote:
> > On Wed, Mar 5, 2025 at 5:25=E2=80=AFPM Bruce Richardson
> > <bruce.richardson@intel.com> wrote:
> > >
> > > In cases where the number of cores on a given socket is greater than
> > > RTE_MAX_LCORES, then EAL will be unaware of all the sockets/numa node=
s
> > > on a system. Fix this limitation by having the EAL probe the NUMA nod=
e
> > > for cores it isn't going to use, and recording that for completeness.
> > >
> > > This is necessary as memory is tracked per node, and with the --lcore=
s
> > > parameters our app lcores may be on different sockets than the lcore =
ids
> > > may imply. For example, lcore 0 is on socket zero, but if app is run
> > > with --lcores=3D0@64, then DPDK lcore 0 may be on socket one, so DPDK
> > > needs to be aware of that socket.
> > >
> > > Fixes: 952b20777255 ("eal: provide API for querying valid socket ids"=
)
> > > Cc: stable@dpdk.org
> > >
> > > Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> >
> > On the principle, the fix lgtm.
> >
> > I have one comment.
> >
> > >
> > > ---
> > > v2: handle case where RTE_MAX_LCORE > CPU_SETSIZE (i.e. >1024)
> > > ---
> > >  lib/eal/common/eal_common_lcore.c | 17 ++++++++++++-----
> > >  1 file changed, 12 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/lib/eal/common/eal_common_lcore.c b/lib/eal/common/eal_c=
ommon_lcore.c
> > > index 2ff9252c52..820a6534b1 100644
> > > --- a/lib/eal/common/eal_common_lcore.c
> > > +++ b/lib/eal/common/eal_common_lcore.c
> > > @@ -144,7 +144,11 @@ rte_eal_cpu_init(void)
> > >         unsigned lcore_id;
> > >         unsigned count =3D 0;
> > >         unsigned int socket_id, prev_socket_id;
> > > -       int lcore_to_socket_id[RTE_MAX_LCORE];
> > > +#if CPU_SETSIZE > RTE_MAX_LCORE
> > > +       int lcore_to_socket_id[CPU_SETSIZE] =3D {0};
> > > +#else
> > > +       int lcore_to_socket_id[RTE_MAX_LCORE] =3D {0};
> > > +#endif
> >
> > This initialisation was unneeded so far because, in the next loop (on
> > each possible lcore), eal_cpu_socket_id() (returning 0 even for
> > errors) was called regardless of eal_cpu_detected().
> > Moving this call after eal_cpu_detected() would be consistent with the
> > rest of this patch.
> >
>
> So keep the zero-init, and move the function call to set the initial valu=
es
> in the array then?

I see no elegant way with current code.
I would completely separate this socket discovery from the rest...

Anyway, this is not the subject of this fix, so I'll withdraw this comment.

>
> >
> > It is unrelated to this patch itself, but I also have some doubt about
> > the socket_id value stored per lcore, as no check against
> > RTE_MAX_NUMA_NODES is done afterwards.
> > (it is probably never hit since the default value for RTE_MAX_NUMA_NODE=
S is 32).
> >
>
> Well, it's an open question whether RTE_MAX_NUMA_NODES is the max value f=
or a
> node id, or the maximum number of ids which can be handled. I imagine mos=
t
> of the code assumes both - that we have sequential numa nodes with value =
<
> MAX.

Regardless of the meaning, we can end up in a situation where a lcore
has a socket_id set in lcore_config[] / rte_lcore_XX API, that is
outside the list of numa nodes stored in config->numa_nodes[] /
rte_socket_XX API, which is used for memory init for example.


--=20
David Marchand

