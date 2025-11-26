Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66E08D111A2
	for <dpdk-dev@archiver.kernel.org>; Wed, 26 Nov 2025 21:28:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 344164026F;
	Wed, 26 Nov 2025 22:28:51 +0100 (CET)
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by mails.dpdk.org (Postfix) with ESMTP id ED4FD4013F
 for <dev@dpdk.org>; Wed, 26 Nov 2025 22:28:49 +0100 (CET)
Received: by mail-qt1-f177.google.com with SMTP id
 d75a77b69052e-4ed7024c8c5so2239161cf.3
 for <dev@dpdk.org>; Wed, 26 Nov 2025 13:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764192529;
 x=1764797329; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rwVPbCuMpcb1h8jlG5sylXpf7Bk/CQzbd3UK5mellbo=;
 b=qF4xDCxFgTlhDTuHxS7ngzZ3CoiIRGCV4/+Q0qEpO2qBTupXYKo0r4f9Lm58OqCQoJ
 SxMyRBsVhYf1C1OO8xsGPY++fiskdwS2RHmAZ44sTrWWutq6cTehE3xjU/qMRhhxzKUG
 c9g99Qu6+C8CoFKRmK7lbMdPfE3KWkQZLX4chFftg4qt+dk6NoQ30C4PetkOSnZob6Vk
 jUuRB4cZkkpfDZOYiB4yA+ZJVmaV0MnI6Qs1QrSbAGa4O0T09WP599DYYLfGSZoOKfqL
 +9a/cwGL6W1XiwUaZiKNEGV8cjLx51VvgcFoYthBa1vTPENhigzU63dUSHgonzjDFjg4
 cTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764192529; x=1764797329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rwVPbCuMpcb1h8jlG5sylXpf7Bk/CQzbd3UK5mellbo=;
 b=n5D12WpoA2mOSb027jWI+1LU1V74vZqn+R7tORpYZbD4c7N5DDOqVUfVic5XewSrfK
 eY0S5QrlpqcHNLN3E0/Uudo5MkaMf/dtEnksosE8Eu44CZaqM/xDrOuqLePfJOby7vpo
 J11oPERTeDcRO/dB/PeBjkrhAU7SzsMTolPknmcuiPGOlE3WSj3P4n6Zzfzko+Jghy3p
 359az0Bds4Kf6e9ZRiMzznyYe8Ghw25ziPApgtA8YOdCfagiOQyLbNDq2uS+84f7kjty
 ii3O3DXhbAM3JbMqjiJB9iGxjtUJfGGOogcpt3YA6VzNAbh3zfTvnyKecSUy9Dfy/FXI
 pwxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6PRnK2VwLjiUsMgD86e0PE57GsTq51XkxPW2/LNzEWsTs8wdCJKD7lHkgGoafGk+ll8E=@dpdk.org
X-Gm-Message-State: AOJu0Yz8CJlpC3NCtMTdRAotAfimduYJcUsqQf+H9udsoF9ENTmnG/Tq
 bl5kJWO3aL68xrIS1ZKASpLgwuf6WZ9VbuPo7HEPxe5+VyhkDQQP7bdL/6RvCNX7V+M=
X-Gm-Gg: ASbGncvyqh6LWI5eEBM5rjsc0zi0foI11W/1Qyvx7Kj68NMca8qBqzQjJpTDW7yC+Vw
 CvmrJ8sCSM6ls69CEQyk7CNXcCKsQ2pYdpKOdWB4SKwNRKJ4WPKCw1gUx9PhyivmWtzMpk82jf2
 Afl4WC+kcRKroMNztAtpDmwteZbBtG5NUlGJftKrfHjN1FIUbLzHRr9LXtia6bkoB3iBnmbv67K
 INjErn62FMhQMyp1gZFwNVR9EOu61Y3AGGHguoSBwoJuqP5XA/NDrTyhuqZR/La/4HcHndSCBzS
 Uk7g77//3RobcaINQpE6sCRilaf7S7fu55FVIq+fN24opv4yHDiFU+JanSerizHAkp10H6QnW01
 eOpCLR0ZpB25db4DRBR6v+d8Lq9cnDs8gcbI5ao8RvSFgQs33boWD/lRGMPJEdu4hpqx0sQvDpj
 XYrIzkqW2y6u3WLqhyyocio/YxHTu33KUY5bK8rl2yvOEgSNXcujrp
X-Google-Smtp-Source: AGHT+IFENDPPGDBh0unAF2qzM1YoWCLswH1+YfMwEj7h5lnxJdcADc9vxTFqkF9eCH0xrFHThNA8cA==
X-Received: by 2002:ac8:7f47:0:b0:4ee:1b0e:860b with SMTP id
 d75a77b69052e-4ee5885878amr264937991cf.23.1764192528889; 
 Wed, 26 Nov 2025 13:28:48 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4ee4905d285sm129357001cf.14.2025.11.26.13.28.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Nov 2025 13:28:48 -0800 (PST)
Date: Wed, 26 Nov 2025 13:28:43 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: "=?UTF-8?B?bWFubnl3YW5n?=(=?UTF-8?B?546L5rC45bOw?=)"
 <mannywang@tencent.com>
Cc: Dmitry Kozlyuk <dmitry.kozliuk@gmail.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>, dev@dpdk.org
Subject: Re: [PATCH v3] acl: support custom memory allocator
Message-ID: <20251126132843.12340ad8@phoenix.local>
In-Reply-To: <08881270F044B8AD+5e6e521c-8430-4b66-a44c-9b1b8f8f297a@tencent.com>
References: <66734dfb22e841ddad035c630bb74f1c@huawei.com>
 <16C60E2E552D75E0+20251125121446.41247-1-mannywang@tencent.com>
 <8e00f0b5-84de-40ce-bec3-673c4b9dd3f1@gmail.com>
 <7E45BE076ACCC3B2+d9eeffa0-a442-4766-b45f-406cd99700e9@tencent.com>
 <cb7c53de-bc26-42c1-8695-00a4a335ebef@gmail.com>
 <08881270F044B8AD+5e6e521c-8430-4b66-a44c-9b1b8f8f297a@tencent.com>
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

On Wed, 26 Nov 2025 16:09:20 +0800
"mannywang(=E7=8E=8B=E6=B0=B8=E5=B3=B0)" <mannywang@tencent.com> wrote:

> Thanks for the follow-up question.
>=20
>  > I don't understand the build stage issue and why it needs a custom  =20
> allocator.
>=20
> The fragmentation concern does not come from the amount of address space,
> but from how the underlying heap allocator manages **large / mid-sized
> temporary buffers** that are repeatedly allocated and freed during ACL=20
> build.
>=20
> ACL build allocates many temporary arrays, tables and sorted structures.
> Some of them are several MB in size. When these allocations are done via
> malloc/calloc, they typically end up in the general heap. Every build
> iteration produces a different allocation pattern and size distribution.
> Even if the allocations are freed at the end, the internal heap layout is
> not restored to a =E2=80=9Cflat=E2=80=9D state. Small holes remain, and f=
uture allocation of
> large contiguous blocks may fail even if the total free memory is=20
> sufficient.
>=20
> This becomes a real operational issue in long-running processes.
>=20
>  > What exactly gets fragmented? It is the entire process address space  =
=20
> which is practically unlimited?
>=20
> It is not the address space that is the limiting factor.
> It is the **allocator's internal arena**.
>=20
> Most allocators (glibc malloc, jemalloc, tcmalloc, etc) retain internal
> metadata, bins, and split blocks. Their fragmentation behavior accumulates
> over time. The process may still have hundreds of MB of =E2=80=9Cfree mem=
ory=E2=80=9D, but
> not in **contiguous regions** that satisfy the next large request.
>=20
>  > How does malloc/free overhead compare to overall ACL build time? =20
>=20
> The cost of malloc/free calls themselves is not the core problem.
> The overhead is small relative to the total build time.
>=20
> The risk is that allocator fragmentation increases unpredictably over a l=
ong
> deployment, until a large block allocation fails in the data plane.
>=20
> Our team has seen this exact behavior in production environments.
> Because we cannot fully control the allocator state, we prefer a model
> with zero dynamic allocation after init:
>=20
> * persistent runtime structures =E2=86=92 pre-allocated static region
> * temporary build data =E2=86=92 resettable memory pool
>=20
> This avoids failure modes caused by allocator history and guarantees stab=
le
> latency regardless of system uptime or build frequency.
>=20
> On 11/26/2025 3:57 PM, Dmitry Kozlyuk wrote:
> > On 11/26/25 05:44, mannywang(=E7=8E=8B=E6=B0=B8=E5=B3=B0) wrote: =20
> >> Thanks for sharing this suggestion.
> >>
> >> We actually evaluated the heap-based approach before implementing this=
=20
> >> patch.
> >> It can help in some scenarios, but unfortunately it does not fully=20
> >> solve our
> >> use cases. Specifically:
> >>
> >> 1. **Heap count / scalability**
> >> =C2=A0=C2=A0 Our application maintains at least ~200 rte_acl_ctx insta=
nces (due=20
> >> to the
> >> =C2=A0=C2=A0 total rule count and multi-tenant isolation). Allowing a =
dedicated=20
> >> heap per
> >> =C2=A0=C2=A0 context would exceed the practical limits of the current =
rte_malloc=20
> >> heap
> >> =C2=A0=C2=A0 model. The number of heaps that can be created is not unl=
imited, and
> >> =C2=A0=C2=A0 maintaining hundreds of separate heaps would introduce co=
nsiderable
> >> =C2=A0=C2=A0 management overhead. =20
> > This is a valid point against heaps, thanks. =20
> >> 2. **Temporary allocations in build stage**
> >> =C2=A0=C2=A0 During `rte_acl_build`, a significant portion of memory i=
s=20
> >> allocated through
> >> =C2=A0=C2=A0 `calloc()` for internal temporary structures. These alloc=
ations are=20
> >> freed
> >> =C2=A0=C2=A0 right after the build completes. Even if runtime memory c=
ould come=20
> >> from a
> >> =C2=A0=C2=A0 custom heap, these temporary allocations would still need=
 an=20
> >> independent
> >> =C2=A0=C2=A0 allocator or callback mechanism to avoid fragmentation an=
d repeated
> >> =C2=A0=C2=A0 malloc/free cycles. =20
> > I don't understand the build stage issue and why it needs a custom=20
> > allocator.
> > What exactly gets fragmented?
> > It is the entire process address space which is practically unlimited?
> > How does is malloc/free overhead compare to the overall ACL build time?
> >  =20

I have seen similar issues in other networking software, mostly it is becau=
se
glibc wants to avoid expensive compaction. See https://sourceware.org/glibc=
/wiki/MallocInternals

The solution was to call malloc_trim() at the end of control transaction.
If ACL library is doing lots of small allocations, then adding it there
would help.

The effect can also be mitigated by using mallopt to adjust MALLOC_TRIM_THR=
ESHOLD.
There is lots of documentation on the Internet on this.

Another option for some workloads is using an alternative library for mallo=
c.
There are lots of benchmarks on glibc vs tcmalloc vs jemalloc.



