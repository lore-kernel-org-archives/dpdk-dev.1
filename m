Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011F2CDB470
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 06:57:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 202E740150;
	Tue, 23 Jun 2026 08:57:07 +0200 (CEST)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com
 [209.85.160.176])
 by mails.dpdk.org (Postfix) with ESMTP id 1B0854014F
 for <dev@dpdk.org>; Tue, 23 Jun 2026 08:57:05 +0200 (CEST)
Received: by mail-qt1-f176.google.com with SMTP id
 d75a77b69052e-5176ca6bab1so8079691cf.0
 for <dev@dpdk.org>; Mon, 22 Jun 2026 23:57:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782197824; cv=none;
 d=google.com; s=arc-20240605;
 b=HEQUOHhPVNXsNvIM5LKWUIuBFXDIHfgTZDM1Wua13G7NV+rdEoSDtqphOoFDW/Pgb9
 FqX+OmSEWTBQTQ9pNJlLEyjyG7Ybof5uSzyBYI0hq7io+3JzLxtfcTxAMaXjL3/q+fZB
 1O5hqmkYb4dMo68xHGrZhVZSMFaZpSMflMICA8u6+Xv9c5sNl1s9124uBZLUgw7l43su
 BZXNlKC5+tmXf6jlqZ73Ve/vP6MkD2R7ivRqJ1h8aMbQufPGYcZA3mVWkEFU+4AAjbG/
 Zy28OwgfAgPwNYQeZGokligf1C30p5iHon7CHrtX6eCp3H9GKHpGc1VYL4itx+czK51Q
 Gn8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=4yuVfgAsUlGFSWmuyun7NhwXUHkD6UM84OwtrJCzw2g=;
 fh=JUruITkHmm9WOEqXVGAxfUeC/dKwGe9fpiGCN0yWOn8=;
 b=isEE5HxkiLwAxTldpPFZmpHyDeaP5Pyxc3Z0FhVxeDvY80+2RsS+QcxyG41agWT4jU
 7LcRjTaleIsAcXE0PGJ6bKLXK5O4YhW60/BiQnui12jnCXL22A+ypvX6CZB0TQJ332+U
 DSJEBTyb8otgWhQDizYJ+zXpWXS316efY0pJBzscsdoXKyROwrXOXQy08NREX2oDgTdK
 5Rjl5c2eFKShURuhVfK6BpyZZ5Rp9VvuqNDJElmV5ylhmocOff7FKDzW4ZO8HTix+W5m
 vQRcdvQz0W9Rd1IZMe1qZtxFsd+Ry1c1+MMavd/gzWK0tIsXBUWwwFompT1uvNMh7qXv
 n56w==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782197824; x=1782802624; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4yuVfgAsUlGFSWmuyun7NhwXUHkD6UM84OwtrJCzw2g=;
 b=E/mI9/sA7hr+IRxPuqbIxCz2+dwuCEeIJ6XeGfUOenRqSYsJNKjWIv3pAdLIgKdjIM
 B2iM4SZXhyqJgJ4Hx2EIe8EL1E+YqHrvOPGqHCrPldigxprrZzpuQ0Axnx0OnqSvQ3XH
 Jo870LKYx0S1FyHiGD4cEI8rytLZyxoEO6zx1EnBF4If3nKDa2xUA/4TiulqJ9Ai2Zh9
 rJvLG2RriiH5tRKp5mkfP32hH1LpcOEpIKaHxZOs7I4hOjl7eXOQrPHf6fE7UKea3HSC
 TgmaRktrsbIUJyaqDGFmpgjz/OFVWlVWm+1M3IERHYjfp5UIk7yvJ0VjdVcAdw8AnAXO
 nk0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782197824; x=1782802624;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4yuVfgAsUlGFSWmuyun7NhwXUHkD6UM84OwtrJCzw2g=;
 b=P/kgRKKw6hPVZh7Gsdr1D6Kf0zTB1hybhxWVv6wPYWkm88gsiOHsD2RPfV1MJg1E5t
 EoVbSCxchjSXejm2v4NtnTof3xkEE9bKjGA2yo0BH47mVjj0NWWqK8je/yIcSBoCs7ts
 2FkOfrunH7d/2BWbY+CFs1cSzukZEwu0ORY8jxT8zIDY6C9XVvPHFiosAH3gfz/TgUTf
 idg+BqTqg7wKJyxqTbcGE3mg790qTxYKO9OHu3lU5gclVKDT4s4jQbb834t7pyFjflPI
 oXyXNi/TKquZ50g9jfn2lX05S7n5MxC/LozBowi5+NNfdQnqLNyp854ZxC6jLoIeZg2Z
 uILg==
X-Gm-Message-State: AOJu0Yw6pavfHgaLgdYXXkQrlXMeFKt/NmohWWeGPQVFIU0YjncdM+rx
 aYqU1hToGiwUtKL8R1LQQtPtPcnuViPbbm6deyiZ7zH8m6RMCkSjHfYkrQzDAnasttUKtffukBW
 one9fHiKkJ3hRnDytQF9vsAUJoMVrRTIEiTX3
X-Gm-Gg: AfdE7ckfIFsy3gg+9b/ZauUv1IEaKfs9bfdzXvvHMzsWjCaGYllV8WohGsvLuhsCbgX
 jWdHHgZStHOHzdhPjgzfJurel6u9YCgbUnHaDTKV0FqOZ3Be/FOgy5keHUnxacUM3YXH5/+QsdL
 /KbL+rPKt3TDufaL/zbR11YxkNGA2xFPnNWxvcsNO1PeN9E7mJNjVLXf5ayE8DXB1HhQ8hL7wqD
 wIg3DukiToDjfBnnGaqek43GyfnwYaBD3tbWVPZWEaiJmJ/p8iXP5EdLD9OKp+hqeIr
X-Received: by 2002:a05:622a:250:b0:517:68a3:d9a1 with SMTP id
 d75a77b69052e-51a51abed11mr35736271cf.13.1782197824280; Mon, 22 Jun 2026
 23:57:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260619202047.2809165-1-mb@smartsharesystems.com>
 <20260621184140.2878132-1-mb@smartsharesystems.com>
 <CALBAE1OCbZ9GB1oGYgR5hRtzjRmev2ZFOaSNndf02AZptihOcw@mail.gmail.com>
 <98CBD80474FA8B44BF855DF32C47DC35F65937@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F65937@smartserver.smartshare.dk>
From: Jerin Jacob <jerinjacobk@gmail.com>
Date: Tue, 23 Jun 2026 12:26:37 +0530
X-Gm-Features: AVVi8CcGY0fd1-08aYHxqLHWIaUNhTTqm8qowYHYdOPgpdyBmb6Qj2gDQrLjsJs
Message-ID: <CALBAE1OZDXfH1FoVLJ=vXVqr=9hYPgqeCzN8h278wN8FbU+XaQ@mail.gmail.com>
Subject: Re: [PATCH v5] graph: add optional profiling stats
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: dev@dpdk.org, Jerin Jacob <jerinj@marvell.com>, 
 Kiran Kumar K <kirankumark@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, 
 Zhirun Yan <yanzhirun_163@163.com>
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

On Tue, Jun 23, 2026 at 12:15=E2=80=AFPM Morten Br=C3=B8rup <mb@smartshares=
ystems.com> wrote:
>
> > From: Jerin Jacob [mailto:jerinjacobk@gmail.com]
> > Sent: Tuesday, 23 June 2026 07.13
> >
> > On Mon, Jun 22, 2026 at 12:11=E2=80=AFAM Morten Br=C3=B8rup
> > <mb@smartsharesystems.com> wrote:
> > >
> > > Added graph node profiling stats, build time configurable by enabling
> > > RTE_GRAPH_PROFILE in rte_config.h.
> > >
> > > Signed-off-by: Morten Br=C3=B8rup <mb@smartsharesystems.com>
> >
> > Please update app/test/test_graph.c to validate this featue.
>
> Ack.
>
> > > @@ -92,7 +92,62 @@ rte_graph_obj_dump(FILE *f, struct rte_graph *g,
> > bool all)
> > >                         fprintf(f, "       total_sched_fail=3D%" PRId=
64
> > "\n",
> > >                                 n->dispatch.total_sched_fail);
> > >                 }
> > > -               fprintf(f, "       total_calls=3D%" PRId64 "\n", n-
> > >total_calls);
> > > +               fprintf(f, "       total_calls=3D%" PRIu64 "\n", n-
> > >total_calls);
> > > +               if (rte_graph_has_stats_feature()) {
> > > +                       fprintf(f, "       total_cycles=3D%" PRIu64 "=
,
> > avg cycles/call=3D%.1f\n",
> > > +                                       n->total_cycles,
> > > +                                       n->total_calls =3D=3D 0 ?
> > (double)0 :
> > > +                                       (double)n->total_cycles /
> > (double)n->total_calls);
> > > +               }
> > > +#ifdef RTE_GRAPH_PROFILE
> >
> >
> > Please introduce rte_graph_has_profile_featue() similar to
> > rte_graph_has_stats_feature() to reduce if def clutter as possible.
>
> Disagree, see below.
>
> >
> > > +               uint64_t calls =3D n->usage_stats[0].calls;
> > > +               fprintf(f, "       objs[0]\n");
> > > +               fprintf(f, "         calls=3D%" PRIu64 ", cycles=3D%"
> > PRIu64 ", avg cycles/call=3D%.1f\n",
> > > +                               calls,
> >
> > >
> > > diff --git a/lib/graph/rte_graph_worker_common.h
> > b/lib/graph/rte_graph_worker_common.h
> > > index 4ab53a533e..0d8039575d 100644
> > > --- a/lib/graph/rte_graph_worker_common.h
> > > +++ b/lib/graph/rte_graph_worker_common.h
> > > @@ -144,12 +144,26 @@ struct __rte_cache_aligned rte_node {
> > >                         rte_node_process_t process; /**< Process
> > function. */
> > >                         uint64_t process_u64;
> > >                 };
> > > +               /** Fast path area cache line 3. */
> > > +#ifdef RTE_GRAPH_PROFILE
> > > +               struct {
> > > +                       uint64_t calls;     /**< Calls processing
> > resp. 0 or 1 objects. */
> > > +                       uint64_t cycles;    /**< Cycles spent
> > processing resp. 0 or 1 objects. */
> > > +               } usage_stats[2];       /**< Usage when this node
> > processed 0 or 1 objects. */
> > > +               uint64_t full_burst_calls;  /**< Calls processing a
> > full burst of objects. */
> > > +               uint64_t full_burst_cycles; /**< Cycles spent
> > processing a full burst of objects. */
> > > +               uint64_t half_burst_calls;  /**< Calls processing a
> > half burst of objects. */
> > > +               uint64_t half_burst_cycles; /**< Cycles spent
> > processing a half burst of objects. */
> > > +               /** Fast path area cache line 4. */
> > > +#endif
> >
> > Is it an ABI breakage?
>
> No. The modifications are enclosed in #ifdef, and disabled by default.
> It is generally required that when rte_config.h options are modified, bot=
h the application and DPDK itself are built together; and then API/ABI brea=
kage becomes irrelevant.


Yes. I don't know the current policy for this. Adding @Thomas Monjalon
@David Marchand


>
> IMO, we should keep our structures lean in release builds. This means tha=
t fields used for detailed profiling, advanced debugging, cookie validation=
, etc. should use the #ifdef pattern rather than the rte_lib_has_some_featu=
re() pattern; especially if they affect the size of a structure. And when t=
hose fields are not present, any code accessing them cannot use the rte_lib=
_has_some_feature() pattern.
> The mbuf and mempool libraries also use #ifdef pattern for similar featur=
es.

Yes for the structure inclusion we can use #ifdef. But inside the
function we can use rte_lib_has_some_feature() scheme. Reasons are :
1)It will remove the ifdef cultter
2)Detect the compilation issue even if the feature is disabled. This
will make sure reduce the build options to enable build sanity
3) Compiler is smart enough to understand to disable the block if the
feature is not enabled.(Just like #ifdef)



>
> >
> > >                 alignas(RTE_CACHE_LINE_MIN_SIZE) struct rte_node
> > *nodes[]; /**< Next nodes. */
> > >         };
> > >  };
> > >
