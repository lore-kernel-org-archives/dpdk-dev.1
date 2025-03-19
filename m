Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2DFC35FFC
	for <dpdk-dev@archiver.kernel.org>; Wed, 19 Mar 2025 16:32:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68B2640608;
	Wed, 19 Mar 2025 17:32:03 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id C111C402C4
 for <dev@dpdk.org>; Wed, 19 Mar 2025 17:32:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742401921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VbnVcWNfsQy6MMCNPknP6Wu/tHncINeijQcghFj0FqU=;
 b=Uh+iKDW94nURHm4EN6k0YsSU1Ae6i5DB/BbGbAp58GrutMSbQHfJ6DzemvapryCBpq6nBD
 bArK+k57Ql68nAWPWy0McQOyG4C9uARDcQ7FkLj6myqYQPRjtcPekQmayK2SA20Gno40on
 G0jxEpaCxxmgRFfDfWwg9NEW1JFDzfI=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-v2VjyX0wOaKwDA0qobz28g-1; Wed, 19 Mar 2025 12:31:59 -0400
X-MC-Unique: v2VjyX0wOaKwDA0qobz28g-1
X-Mimecast-MFC-AGG-ID: v2VjyX0wOaKwDA0qobz28g_1742401918
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-542a77b4a4cso4199178e87.1
 for <dev@dpdk.org>; Wed, 19 Mar 2025 09:31:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742401918; x=1743006718;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VbnVcWNfsQy6MMCNPknP6Wu/tHncINeijQcghFj0FqU=;
 b=VixsTmejGCc4GlGlm9cJiZL7hi8fLmmGNrWS+tcFUnG3HKL/kW/MU/DsiQB6xTwiEu
 zegd5hUky7uY0q2NJZEe8Ihvf2vwsRvzqjnUGJcoTEAO91bTu7BFD7Gdt8HFRfTPgKGq
 qjzd9jFax7Ayh8c95UDc0+C3rUNnRlcxWTEoUbfFSGTSxlOwUVbv1y+F7nLkHJkHmi4G
 0iTRMw1MTl+yf5E9GOTf9fTXuFH0SkhSG8yeWCEATzRIdpmnjOMHapP5hzuhsAFo/d8G
 GY4OLtL6qKIeIPjdlwCv3clkgWBGooRWNvnLND5E0VEXzNCRnuX+TYHtXVzOHUWLcyAm
 KTGA==
X-Gm-Message-State: AOJu0YxjV8NkbX2DoBZtef1uX4ZxzzK/TFzWnstqM5EyMPOO+a/8adSx
 BdcZ7ikFCcZ0TwaepT7bXVvlC6RLr4rdYsHISbca/Q2GSn3WLmhM93r7SrJ4Pcw54odQnPUN0x8
 bHF4RAGzOd5YjgeoqVLomUIxecTyRerPHZR1Q2mYvlZIIgqmPi5WcXLnOgWDz/NX6sqLbYMFPYW
 jKYNIwKfQBk+vRM9E=
X-Gm-Gg: ASbGncvRhK4IcH4qy09e6AZPUeIlUEEqxWoBa0VxMtQ6IfYiq4WyVt5W9tzum/psBaI
 3aO23he3+DOEU8eV6FCWEgvOO7s1gVlFBtXk79Mp/OOEMsOfgl+V+2d2JtXcZD7kB7E6n5QrYff
 S31OXPasu9emdKX658QxdG5/gvQZMCSw==
X-Received: by 2002:a05:6512:3a8c:b0:549:91dc:22cf with SMTP id
 2adb3069b0e04-54acb193440mr1152081e87.2.1742401917982; 
 Wed, 19 Mar 2025 09:31:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBCZVAcIdRbQQXBaBN20/ONp9zD007uxzuNHu/VnipDig+ly1i1HE+2/6tnoTG2Yjo/y5NNFxOs6e+GrPhGvI=
X-Received: by 2002:a05:6512:3a8c:b0:549:91dc:22cf with SMTP id
 2adb3069b0e04-54acb193440mr1152061e87.2.1742401917517; Wed, 19 Mar 2025
 09:31:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250305134720.907347-1-bruce.richardson@intel.com>
 <20250305162458.1059282-1-bruce.richardson@intel.com>
In-Reply-To: <20250305162458.1059282-1-bruce.richardson@intel.com>
From: David Marchand <david.marchand@redhat.com>
Date: Wed, 19 Mar 2025 17:31:45 +0100
X-Gm-Features: AQ5f1Jpxi_vEB1EvFAGn4wfFFQ0bZzpuMCBtfKqJpEiwQgV_hnDxBEd3_pVONCs
Message-ID: <CAJFAV8xA-HK63XxSEYNZBTeghOUgtEEKTe=iBE4syCF_vsoKxQ@mail.gmail.com>
Subject: Re: [PATCH v2] eal: fix undetected NUMA nodes
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org, Anatoly Burakov <anatoly.burakov@intel.com>, stable@dpdk.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4AhwtOf8bR_nHccLJt0seMaXwQC-WkQtPZaMY4VPlYw_1742401918
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

On Wed, Mar 5, 2025 at 5:25=E2=80=AFPM Bruce Richardson
<bruce.richardson@intel.com> wrote:
>
> In cases where the number of cores on a given socket is greater than
> RTE_MAX_LCORES, then EAL will be unaware of all the sockets/numa nodes
> on a system. Fix this limitation by having the EAL probe the NUMA node
> for cores it isn't going to use, and recording that for completeness.
>
> This is necessary as memory is tracked per node, and with the --lcores
> parameters our app lcores may be on different sockets than the lcore ids
> may imply. For example, lcore 0 is on socket zero, but if app is run
> with --lcores=3D0@64, then DPDK lcore 0 may be on socket one, so DPDK
> needs to be aware of that socket.
>
> Fixes: 952b20777255 ("eal: provide API for querying valid socket ids")
> Cc: stable@dpdk.org
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>

On the principle, the fix lgtm.

I have one comment.

>
> ---
> v2: handle case where RTE_MAX_LCORE > CPU_SETSIZE (i.e. >1024)
> ---
>  lib/eal/common/eal_common_lcore.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/lib/eal/common/eal_common_lcore.c b/lib/eal/common/eal_commo=
n_lcore.c
> index 2ff9252c52..820a6534b1 100644
> --- a/lib/eal/common/eal_common_lcore.c
> +++ b/lib/eal/common/eal_common_lcore.c
> @@ -144,7 +144,11 @@ rte_eal_cpu_init(void)
>         unsigned lcore_id;
>         unsigned count =3D 0;
>         unsigned int socket_id, prev_socket_id;
> -       int lcore_to_socket_id[RTE_MAX_LCORE];
> +#if CPU_SETSIZE > RTE_MAX_LCORE
> +       int lcore_to_socket_id[CPU_SETSIZE] =3D {0};
> +#else
> +       int lcore_to_socket_id[RTE_MAX_LCORE] =3D {0};
> +#endif

This initialisation was unneeded so far because, in the next loop (on
each possible lcore), eal_cpu_socket_id() (returning 0 even for
errors) was called regardless of eal_cpu_detected().
Moving this call after eal_cpu_detected() would be consistent with the
rest of this patch.


It is unrelated to this patch itself, but I also have some doubt about
the socket_id value stored per lcore, as no check against
RTE_MAX_NUMA_NODES is done afterwards.
(it is probably never hit since the default value for RTE_MAX_NUMA_NODES is=
 32).



--=20
David Marchand

