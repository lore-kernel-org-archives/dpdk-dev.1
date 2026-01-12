Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD423C9EC99
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 16:00:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED83B40156;
	Mon, 12 Jan 2026 17:00:50 +0100 (CET)
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com
 [209.85.222.52]) by mails.dpdk.org (Postfix) with ESMTP id 2029840041
 for <dev@dpdk.org>; Mon, 12 Jan 2026 17:00:49 +0100 (CET)
Received: by mail-ua1-f52.google.com with SMTP id
 a1e0cc1a2514c-93f56804894so4119328241.3
 for <dev@dpdk.org>; Mon, 12 Jan 2026 08:00:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768233648; x=1768838448; darn=dpdk.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Jn9NPYWxxOsgJDW/tukn5ShJ0o8QUemHP20ncFDLutk=;
 b=Yu+ZYb+JW6ER2sqyFt8V+85qImMZDYUOvLdrRNvsHTwsIX8jH/nmGOHYX/Vy7Bypc+
 mt/CEaamd/gRl68X93nIJgGHQmmOMFa+1bwveyrB9QhdGfu6SFBnXVr98U3ku5GMz4H6
 M8vOFS9+rvgxm/Tl3zRTiWpe0Fc6ByCWeFRmvxp6NnhSb9AKA3g54GHgxndXqkcSTP2h
 MqItNBIeIo/KbwriQIkcIFN4gHIuwqhzsq8ZqzzPCBAxEFY1jElg3gCN5xlhrJYHNcEW
 FMX9WTKq2BrGupOIPNJgwODMi13/N+PXek/qmilX1yuE9bPT+spWwtyyNoyZ0WlOK8+5
 cQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768233648; x=1768838448;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Jn9NPYWxxOsgJDW/tukn5ShJ0o8QUemHP20ncFDLutk=;
 b=jaEmuGUsMdAL/c2175cwUuUKKqms6eqt6hx6Ck9cF2zgFgizGY3BmzRxzqf/bT8Erh
 vKctZCZ8PwEBdp8vTPsAv2mh2kwBuwOrQy7Bl4YX8Lwqcg3HzY+UWktEcaa+2e8VVRY3
 1n3kQkjJ65+XoD1WF/yt895joDL9kL/dZXovums0CIK5Fv3eqTrLUQ6LbTLE6ksiJVZJ
 AmOyx0AEmz/xKWLt5/tNPV1n4UQb7FgWerzHPQY8qYXUXad3rOh3XuzCBQtT9oKd0Cn2
 YJfGpTnm2GXFS6FYKahUmsa2/OlJGQrBjd1St6JRyTXo8Y7Eamo2tk6zZL3KoF/ngp++
 AhaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqQg9wPQnxgLONNhz0DkVn0/ZW9DtuGxPFYoXFobRoGUWSxDmB5fJhVt/GCdcWN/KsXKE=@dpdk.org
X-Gm-Message-State: AOJu0Yy3a2ZqIRdZ+hvM1g5ATdp4aSBsLegJkN4ZbnayFNie+jYdb+6P
 U/+UdNe5CDMLPYcxO3hbtVBOt4HU+DeuVuEjQtgNZqURiq1tblT9nMaN9KXSDtDKmMTkIjqy1Xz
 k18Wmab7qJZ94f19NRwqAj0KQg10xVWc=
X-Gm-Gg: AY/fxX4Ps9pMWSONippU03DWWbmvDmzLjeokiLZGznvvtqVibmbEqmeedXiAkV0ZePO
 FOv9MPHZy9bJQ/Te8FoXrTRjrZUbn66QXXQbdAxsOR/wPSUhH4S3sLHMZrm+66J/xuobrRlGOyf
 otUko+bCHDYCE/I9fjJwU9mwP2ZqxofEHUdl3KIXIiDd0WTDk3BtXTvwbuPjJ4HbMcFNi1IxTy7
 T8FWYRM4BNJgtf0NmWylPE5pj/gbzB3TMPSysjgsemtCecguhqvEjMPNUpyoQVaJl1345aZoxbA
 keFdfg==
X-Google-Smtp-Source: AGHT+IG5IbfEwe5ylkHXWezejJqPAZhy26htV8pHZxQ4VX5vJlyzt6GCNQggYy/Z5i7h59tjVFvCZiz+ROOXeT7pcvI=
X-Received: by 2002:a05:6102:5242:b0:5de:31b1:1ffe with SMTP id
 ada2fe7eead31-5ecb6980e5bmr7811754137.32.1768233646794; Mon, 12 Jan 2026
 08:00:46 -0800 (PST)
MIME-Version: 1.0
References: <20251120114554.950287-1-mb@smartsharesystems.com>
 <20251201155525.1538260-1-mb@smartsharesystems.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6561B@smartserver.smartshare.dk>
 <c2bf94e103f64dcaad115e1d3d39d654@huawei.com>
 <98CBD80474FA8B44BF855DF32C47DC35F6564F@smartserver.smartshare.dk>
In-Reply-To: <98CBD80474FA8B44BF855DF32C47DC35F6564F@smartserver.smartshare.dk>
From: Scott Mitchell <scott.k.mitch1@gmail.com>
Date: Mon, 12 Jan 2026 11:00:36 -0500
X-Gm-Features: AZwV_Qh9m0TyynoW2ycw9nMSvkuJcFb-NqwuMvoE6SLTgVSoMBwRaRbXGgxOeVM
Message-ID: <CAFn2buBx3JNXS1pb6w=0S1HOAxmG+HVTkk=_b+1kou5MnAnqpw@mail.gmail.com>
Subject: Re: [PATCH v5] eal/x86: optimize memcpy of small sizes
To: =?UTF-8?Q?Morten_Br=C3=B8rup?= <mb@smartsharesystems.com>
Cc: Konstantin Ananyev <konstantin.ananyev@huawei.com>, dev@dpdk.org, 
 Bruce Richardson <bruce.richardson@intel.com>, 
 Konstantin Ananyev <konstantin.v.ananyev@yandex.ru>,
 Vipin Varghese <vipin.varghese@amd.com>, 
 Stephen Hemminger <stephen@networkplumber.org>
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

>
> The discussion about the optimized checksum function [1] has shown us tha=
t memcpy() sometimes prevents Clang from optimizing (loop unrolling and vec=
torizing) and potentially causes strict aliasing bugs with GCC, so I will w=
ork on a new patch version that keeps using the above types, instead of int=
roducing memcpy() inside rte_memcpy().
>
> [1]: https://inbox.dpdk.org/dev/CAFn2buBzBLFLVN-K=3Du3MgBEbQ-hqbgJLVpDx3v=
SXVKJpa0yPNg@mail.gmail.com/
>

Great timing for this thread :)

My observation:
- clang is unable to apply optimizations with RTE_PTR_[ADD,SUB]
like loop unrolling and vectorization (e.g. cksum)
- Even when clang/gcc do apply optimizations the assembly can be non-optima=
l
- direct usage of unaligned_NN_t types can cause incorrect results
(due to gcc bugs)

I don't think "rte_NN_alias" structs are safe on architectures that don't a=
llow
unaligned access bcz the inner "val" needs to indicate it maybe for
unaligned access.

My suggestion:
1. Fix unaligned_NN_t types to ensure compiler doesn't aggressively
apply strict-alias
optimizations resulting in incorrect results
(https://patches.dpdk.org/project/dpdk/patch/20260112120411.27314-2-scott.k=
.mitch1@gmail.com/).
Intermediate structs rte_NN_alias are then unnecessary and we can directly =
use
unaligned_NN_t instead (e.g.
https://patches.dpdk.org/project/dpdk/patch/20260112120411.27314-3-scott.k.=
mitch1@gmail.com/)

2. Improve RTE_PTR_[ADD,SUB] to be more compiler friendly
(https://patches.dpdk.org/project/dpdk/patch/20260112154059.36879-1-scott.k=
.mitch1@gmail.com/)
