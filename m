Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7B6606A320
	for <dpdk-dev@archiver.kernel.org>; Sun, 22 Nov 2026 15:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=F4qPTxjR
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0147C402CC;
	Sun, 22 Nov 2026 16:28:07 +0100 (CET)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44])
 by mails.dpdk.org (Postfix) with ESMTPS id 98F0D402B9
 for <dev@dpdk.org>; Sun, 22 Nov 2026 16:28:05 +0100 (CET)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-c4cb6834eaaso419060566b.2
 for <dev@dpdk.org>; Sun, 22 Nov 2026 07:28:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795361285; cv=none;
 d=google.com; s=arc-20260327;
 b=dyxSfsBOlptRoB6BzCQihJLBoQXe8niYDDYfThK+OnkogYHkjwrx0T7fdgk7sjBTxu
 qNqMmcjNEUv+kR9lmdkjctUOMolkC0dAFLqe37d2DuW2O1O0/xthe38qDMIVfhaLoJzF
 xScdwJAKmRKiVdqzsyxGRY7bu6x0/B8Ck5glEJWucbhC8ng8HspX/NNy2r0dU3m0KBhd
 +knzDsE8LrUU9fh36KGJ1kfGv/ESzqH8TqwaHRuFXVAFa/xQW/JDlZuXA1i6NkxnGaKT
 2uybGoMNW6dTzz5AmS/cPhW+bkhofroQh/qgSVTfBnQCh/bhWwU1AibvaOLDY8Mavo6G
 UlTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=L+9K/EPvoPnaWH8pylXf0z6myH9NpATneN6pIrUnVzQ=;
 fh=SZGcqKcP3ETgg8XhiXYDuac4SEt4DIB/Fj8Wf40iB5Y=;
 b=lD161fGQrd8rY0DQDegief5IzbwxmuteFh+sX4Sc7K+eacYbkQvCHmZzjUsMaFPFL1
 FeJSmjhD54PIuE1Mc8QA4UTmL4G5TPeDBWfg5aI/9U23VSN2s4pI1HrMMTq2Avf7qIKU
 AebnTKHjUyVrusruJ86Lt6iYtbakr9ncmwA5M0TSLS7AMVOL9emJ5QKo2g5uxHD3eccx
 24fkcXeobJ4/Zj2kMf5V2pbrBoSTGDuMcszY/k6XMTEkTqReyJVx0lwrypMNdz6ol3rx
 ejgLDP1AV8KGaRjYvYDlQV7IQN4jDu9OaFblhniyQL69qn+TEhzzThkP7l2Zwb1RWTNQ
 qRrg==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795361285; x=1795966085; darn=dpdk.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=L+9K/EPvoPnaWH8pylXf0z6myH9NpATneN6pIrUnVzQ=;
 b=F4qPTxjR79b79gWWYGAkmrVI2mn3Z8QPIBF6LJUtniDhR0PGazwClyPqShpYuOk4iW
 9c3fbCDSFRlrwcxkeSSDdQyoK0mYfi37EYTtonPi59jJYBp3HVKgVOLhipkDzQlhlIjq
 7frIu3TlEZsjzYQPwVtXRaYQaXC28qWg05vn+qyA6Mhix4pi0QBH9KjkNMf+2Z9UK7wV
 zDZp9VnofLjwHkgwsKK/gAiU24Zn/0WmYwMBToep7eZNWtXkxutUQodT8Z9s5bZwLmDs
 Ww8FuTBdcqHEjNYuVN/lfWrzTNSVBhZ5lYCcOQQykCzuRErdDAcXsK4JckSfVCH5Eo9/
 xPlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795361285; x=1795966085;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=L+9K/EPvoPnaWH8pylXf0z6myH9NpATneN6pIrUnVzQ=;
 b=U35rzV1pRhoDBLfchDoij1W22KAJSZxttvD70hq/d0iwBS+ow6JW28vuSD7jb6/Ibw
 3rCS3xoInK4kotM2twHTR4kjmdVcvz7d69g8+cmfSCvysCZinLGA4Bp4MNq3VfIsJfzK
 nBztx+ZQEqEkdjSgpwoMWlQ4THLo6mwZMPKthnW9Ly+dcnaJyU6oNwPDBRZ48P+873A8
 fnzxVulYgl+9AX8sA10Ae3Y+K4g4NG0Zjtip9Y1I3Gx71XaEp6vYVujMuJzRsyKrPzmG
 GW/vuHtKKXVx4mNTRml9IgUtTjODXzfSKA3ydey7fghrcuc43dv6ox15/FWClJ5FmsWY
 bJgQ==
X-Forwarded-Encrypted: i=1;
 AL+hErE7O9Xcy9N72SLKoa/RQZKbCh1A4IPBAeHxU9sdk+nrlf1nByX2WNtqB+w0/Z4PdZEt8Vg=@dpdk.org
X-Gm-Message-State: APuU4Z9LlG6+A6FkVuFbSgV1OxGYfoOWuJMoIVKZwPy5hcmUM8ZsIXe0
 RUgutw1UjSSyDE0Ktht2Qd8ROEjMv0DH+eURrh/F6tgwK3cHc7ISyMFOJDB7YE9IPv0EDcl+qcV
 /YNeCiRwyggiH/gkGe1mAgPaQVvvxF9A=
X-Gm-Gg: AZFdTZeJZqb8xQ8D/ZSmnAYivwEJ/dAqWmUWJjD6BHpwtgipxa9znas6gspF1GsUixM
 8PH1+zKs/6yUPUOpEkiK3Y2JaHyjSaZI/52QjKBZfyiKF6A6+mCtPtLO4Myd7s4wFnENBD0cPEo
 4ubJHGNdUXsf0SIp1npSDhFDH7wTsSa4LUf3DqtIj6AQS3exJ7pjHvmgDxEmwoHtibAtbZPk1vz
 lT9ySvurfPGM5oAt1iJXpIeG4T2LIa9gIeN47+BkbxfpAR98WZwWon0xMoUaoxcMolOXPI7Zz58
 EsW5YcWAxnva+Z2vT6zZxQNly1/JeKeVMBi170i4T+S+S845Q6Ea92wgjumzFqyUFumk5rn45+B
 qTiGfr63Q8hgq0LyZ9U/m9cAAbJ4lh06QHw==
X-Received: by 2002:a17:906:99d4:b0:c46:ca2b:84bd with SMTP id
 a640c23a62f3a-c513a8929c4mr732354866b.30.1795361284748; Sun, 22 Nov 2026
 07:28:04 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
 <20261014183921.495158-1-vladimir.medvedkin@intel.com>
 <CAHHRULUEZX1fYkvS7YXCLirEbk_80wcoZZ6NoNroZhD-mmFNkw@mail.gmail.com>
In-Reply-To: <CAHHRULUEZX1fYkvS7YXCLirEbk_80wcoZZ6NoNroZhD-mmFNkw@mail.gmail.com>
From: Vladimir Medvedkin <medvedkinv@gmail.com>
Date: Sun, 22 Nov 2026 15:27:53 +0000
X-Gm-Features: Aa3M54oWfNEB-ncTg9bHluf2tiBOw9e10qls5K2upZOzvxNzFyGJ4gekeh4oKNA
Message-ID: <CANDrEH=VnvZAWkPzVHwr=x-TxgFJBuDGXDiNiQTEzhZbwOihZQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/7] VRF support in FIB library
To: Maxime Leroy <maxime@leroys.fr>
Cc: Vladimir Medvedkin <vladimir.medvedkin@intel.com>, dev@dpdk.org,
 rjarry@redhat.com, mb@smartsharesystems.com, konstantin.ananyev@huawei.com
Content-Type: multipart/alternative; boundary="0000000000009ef8a10660df1f67"
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

--0000000000009ef8a10660df1f67
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Maxime,

=D0=BF=D1=82, 13 =D0=BD=D0=BE=D1=8F=D0=B1. 2026=E2=80=AF=D0=B3. =D0=B2 00:2=
2, Maxime Leroy <maxime@leroys.fr>:

> Hi Vladimir,
>
> On Wed, Oct 14, 2026 at 8:39=E2=80=AFPM Vladimir Medvedkin
> <vladimir.medvedkin@intel.com> wrote:
> >
> > This series adds multi-VRF support to the IPv4 FIB, allowing a single F=
IB
> > instance to host multiple isolated routing tables.
> >
> > Today a FIB instance is a single routing table, so an application servi=
ng
> > several VRFs needs one FIB per VRF. In a burst oriented datapath packet=
s
> of
> > one burst can belong to different VRFs, and the application either does
> > per-packet lookups in different FIBs or regroups the burst by VRF befor=
e
> > the lookup. Both are expensive. With this series all the VRFs live in o=
ne
> > FIB, the bulk lookup takes a VRF ID per address, and the existing API
> > operates on VRF 0.
> >
> > v1 replicated the 16M entry tbl24 per VRF. That kept the lookup on par
> with
> > the single VRF case, but memory grew linearly with the number of VRFs,
> > which was the main concern raised on v1. v2 resolves the issue by addin=
g
> > of two dataplane algorithms with different memory/lookup trade-offs.
> >
> > DIR8-16-8 is a new three level variant of DIR-24-8 with 8, 16 and 8 bit
> > strides. Only the 256 entry root table (2 KB) is replicated per VRF; th=
e
> > tbl16 and tbl8 groups come from pools shared by all the VRFs, so memory
> > follows the routes actually installed rather than the number of VRFs. T=
he
> > cost is an extra memory access for prefixes longer than /8.
> >
> > DIR-24-8 gets multi-VRF support by resolving the VRF after the longest
> > prefix match, along the lines Konstantin suggested on v1. Instead of a
> > vector of next hops per prefix, a single tbl24_8 shared by all the VRFs
> > returns an internal prefix ID, and a hash table keyed by {VRF, prefix I=
D}
> > returns the next hop, a miss meaning the VRF default next hop. The aim =
is
> > to resolve the VRF with a single memory access, so buckets hold 8 recor=
ds
> > and there is no probing beyond the bucket.
> >
> > Such a table only works if the control path can keep buckets from
> > overflowing while the hash stays cheap on the datapath. Since the prefi=
x
> > ID is internal, the library can pick it so that the records of a prefix
> > land in buckets with free room. Collisions are chosen deliberately, so
> they
> > are not a security concern, but finding them has to be cheap. Toeplitz
> was
> > the first candidate: its structure is well studied and the thash librar=
y
> > already knows how to find collisions, but it is only fast with GFNI. CR=
C
> > has the same linear properties, is trivially inverted and is hardware
> > accelerated on x86 and Arm, so CRC32C is used. Linearity also places th=
e
> > buckets of one prefix in different VRFs at fixed XOR offsets from each
> > other, so a candidate prefix ID is checked for all the VRFs referencing
> > the prefix at once, and these records never share a bucket. If a bucket
> > fills up anyway, a prefix already in it is renumbered to make room.
> >
> > The price of the shared table is paid on the control path: a route in o=
ne
> > VRF needs a record for every more specific prefix installed below it by
> > other VRFs. Default routes are excluded, they map onto the per-VRF
> default
> > next hop.
> >
> > The two algorithms target different deployments. DIR8-16-8 fits a limit=
ed
> > number of VRFs (tens to hundreds) carrying large tables, up to a BGP fu=
ll
> > view each. The hash based DIR-24-8 fits one large VRF alongside hundred=
s
> > or thousands of small ones.
> >
> > test-fib gets a VRF mode, including a profile with a full view in VRF 0
> and
> > smaller VRFs made of random subsets of it. The first three patches are
> fixes
> > found along the way and are independent of the rest.
> >
> > Not done yet:
> > - IPv6. The VRF bookkeeping of the hash based scheme is address family
> >   agnostic and is meant to be reused by TRIE.
> > - RCU support for multi-VRF DIR-24-8.
> >
> > Vladimir Medvedkin (7):
> >   fib: fix return value of a nexthop update
> >   app/test-fib: fix lookup of the last burst
> >   app/test-fib: fix size of the tables for large counts
> >   fib: add DIR8-16-8 algorithm
> >   fib: add multi-VRF support
> >   fib: split DIR24-8 table update from the FIB wrapper
> >   fib: add hash based VRF support for DIR24-8
> >
> >  app/test-fib/main.c                    |  673 ++++++++++---
> >  app/test/test_fib.c                    | 1001 ++++++++++++++++++-
> >  app/test/test_fib_perf.c               |  440 +++------
> >  app/test/test_fib_routes.h             |  282 ++++++
> >  doc/guides/prog_guide/fib_lib.rst      |   66 ++
> >  doc/guides/rel_notes/release_26_11.rst |   21 +
> >  lib/fib/dir24_8.c                      |   34 +-
> >  lib/fib/dir24_8.h                      |   43 +-
> >  lib/fib/dir24_8_avx512.c               |   18 +-
> >  lib/fib/dir24_8_avx512.h               |   32 +-
> >  lib/fib/dir24_8_rvv.c                  |    3 +-
> >  lib/fib/dir24_8_rvv.h                  |   16 +-
> >  lib/fib/dir24_8_vrf.c                  |  290 ++++++
> >  lib/fib/dir24_8_vrf.h                  |   60 ++
> >  lib/fib/dir8_16_8.c                    |  665 +++++++++++++
> >  lib/fib/dir8_16_8.h                    |  192 ++++
> >  lib/fib/dir8_16_8_avx512.c             |  183 ++++
> >  lib/fib/dir8_16_8_avx512.h             |   24 +
> >  lib/fib/fib_vrf.c                      | 1256 ++++++++++++++++++++++++
> >  lib/fib/fib_vrf.h                      |  277 ++++++
> >  lib/fib/fib_vrf_avx512.c               |  142 +++
> >  lib/fib/meson.build                    |   22 +-
> >  lib/fib/rte_fib.c                      |  249 ++++-
> >  lib/fib/rte_fib.h                      |  127 ++-
> >  24 files changed, 5593 insertions(+), 523 deletions(-)
> >  create mode 100644 app/test/test_fib_routes.h
> >  create mode 100644 lib/fib/dir24_8_vrf.c
> >  create mode 100644 lib/fib/dir24_8_vrf.h
> >  create mode 100644 lib/fib/dir8_16_8.c
> >  create mode 100644 lib/fib/dir8_16_8.h
> >  create mode 100644 lib/fib/dir8_16_8_avx512.c
> >  create mode 100644 lib/fib/dir8_16_8_avx512.h
> >  create mode 100644 lib/fib/fib_vrf.c
> >  create mode 100644 lib/fib/fib_vrf.h
> >  create mode 100644 lib/fib/fib_vrf_avx512.c
> >
> > --
> > 2.43.0
> >
>
> Thanks for the v2. It addresses the large TBL24 memory footprint of
> v1, but I think several of my original concerns remain.
>
> DIR8-16-8 is essentially a three-level lookup with an additional
> memory access for prefixes longer than /8. While the TBL16 and TBL8
> pools are shared across VRFs, their capacities still have to be
> provisioned upfront. There is also a 2 KB root table per configured
> VRF, plus a 512 KB TBL16 group for each /8 a VRF uses. A full-view VRF
> has routes longer than /8 in most /8s, so it needs a TBL16 group for
> most of them: close to the memory of a TBL24, with one more lookup
> level.
>
> More importantly, the design still relies on dense VRF IDs in the
> range [0, max_vrfs)


I still don't understand why this is a problem


> , with a separate RIB per VRF. Each RIB is created
> upfront in rte_fib_create() with the same max_routes capacity, which
> still means substantial memory overhead for deployments with one
> full-view VRF and hundreds of small or empty ones.
>

Correct, and I'm going to fix this issue by making a shared rib_node pool
across all RIBs


>
> The hash-based DIR24-8 avoids the extra trie level, but at the cost of
> considerably more control-plane complexity: prefix IDs, bucket
> placement constraints, prefix renumbering, and additional records for
> overlapping prefixes across VRFs. RCU support is also still missing in
> this mode, and renumbering looks hard to combine with it: old hash
> entries would have to stay visible to concurrent readers until a grace
> period has elapsed, which temporarily increases bucket occupancy.
>

I don't think this is a big problem. The internal implementation already
has RCU support.


>
> IPv6 remains unsupported, and neither approach provides a shared
> resource pool across IPv4 and IPv6 FIBs.
>

Yes, IPv6 support is not included in this RFC, as I mentioned in the cover
letter, although there is preliminary support in the internal
implementation. At the moment I don't see any strong reason to share
resource pools across address families.


>
> I would like to suggest an alternative that keeps one FIB per VRF and
> still provides the mixed-VRF bulk lookup this series is after. The
> idea is a small group object holding what the FIBs have in common
> (type, flags, next hop size), which a FIB joins at creation:
>
>     grp =3D rte_fib_group_create(&grp_conf);
>     conf.group =3D grp;
>     fib =3D rte_fib_create(name, socket_id, &conf);
>     rte_fib_group_lookup_bulk(grp, dps, ips, next_hops, n);
>
>   dps[i] would be the rte_fib_get_dp() pointer of the FIB to use for
> ips[i].
>
> On v1 you objected that allocating one TBL24 per VRF on demand would
> add an indirection layer to the lookup. This would avoid it: in
> DIR24-8 the TBL24 is embedded in the dataplane struct, so it sits at a
> fixed offset from the pointer passed by the caller. There is no table
> of pointers to go through: the TBL24 access needs no additional level
> of indirection, and the existing single-FIB path is untouched.
>
> Compared to your API, your "fib" becomes the group and your "vrf"
> becomes a FIB, identified by a pointer instead of a dense index. FIBs
> are created on demand, each with its own RIB size, and nothing is
> allocated for VRFs that do not exist. The same idea should apply to
> the IPv6 trie, which embeds its TBL24 the same way.
>
> This does not reduce the per-VRF TBL24 by itself; that is where a
> compact algorithm such as DIR8-16-8, used as a regular single-VRF
> backend, would fit. It is also independent of my TBL8 pool RFC, which
> addresses the sizing of num_tbl8.
>
> What do you think?
>

This series is not just about mixed-VRF bulk lookup, this series is about
internal representations and algorithms. V1 was mostly about API and there
was reasonable criticism regarding memory consumption. Here this issue was
addressed with increased internal complexity.

I'm not sure this implementation would avoid indirection layer, it just
moves it to the lookup function as dps argument.
Your suggestion does not solve the memory consumption issue with many small
VRFs. I also doubt it would have a reasonable performance.


>
> Regards,
>
> Maxime
>


--=20
Regards,
Vladimir

--0000000000009ef8a10660df1f67
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi Maxime,</div><br><div class=3D"gmail_quote gmail_q=
uote_container"><div dir=3D"ltr" class=3D"gmail_attr">=D0=BF=D1=82, 13 =D0=
=BD=D0=BE=D1=8F=D0=B1. 2026=E2=80=AF=D0=B3. =D0=B2 00:22, Maxime Leroy &lt;=
<a href=3D"mailto:maxime@leroys.fr">maxime@leroys.fr</a>&gt;:<br></div><blo=
ckquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left=
:1px solid rgb(204,204,204);padding-left:1ex">Hi Vladimir,<br>
<br>
On Wed, Oct 14, 2026 at 8:39=E2=80=AFPM Vladimir Medvedkin<br>
&lt;<a href=3D"mailto:vladimir.medvedkin@intel.com" target=3D"_blank">vladi=
mir.medvedkin@intel.com</a>&gt; wrote:<br>
&gt;<br>
&gt; This series adds multi-VRF support to the IPv4 FIB, allowing a single =
FIB<br>
&gt; instance to host multiple isolated routing tables.<br>
&gt;<br>
&gt; Today a FIB instance is a single routing table, so an application serv=
ing<br>
&gt; several VRFs needs one FIB per VRF. In a burst oriented datapath packe=
ts of<br>
&gt; one burst can belong to different VRFs, and the application either doe=
s<br>
&gt; per-packet lookups in different FIBs or regroups the burst by VRF befo=
re<br>
&gt; the lookup. Both are expensive. With this series all the VRFs live in =
one<br>
&gt; FIB, the bulk lookup takes a VRF ID per address, and the existing API<=
br>
&gt; operates on VRF 0.<br>
&gt;<br>
&gt; v1 replicated the 16M entry tbl24 per VRF. That kept the lookup on par=
 with<br>
&gt; the single VRF case, but memory grew linearly with the number of VRFs,=
<br>
&gt; which was the main concern raised on v1. v2 resolves the issue by addi=
ng<br>
&gt; of two dataplane algorithms with different memory/lookup trade-offs.<b=
r>
&gt;<br>
&gt; DIR8-16-8 is a new three level variant of DIR-24-8 with 8, 16 and 8 bi=
t<br>
&gt; strides. Only the 256 entry root table (2 KB) is replicated per VRF; t=
he<br>
&gt; tbl16 and tbl8 groups come from pools shared by all the VRFs, so memor=
y<br>
&gt; follows the routes actually installed rather than the number of VRFs. =
The<br>
&gt; cost is an extra memory access for prefixes longer than /8.<br>
&gt;<br>
&gt; DIR-24-8 gets multi-VRF support by resolving the VRF after the longest=
<br>
&gt; prefix match, along the lines Konstantin suggested on v1. Instead of a=
<br>
&gt; vector of next hops per prefix, a single tbl24_8 shared by all the VRF=
s<br>
&gt; returns an internal prefix ID, and a hash table keyed by {VRF, prefix =
ID}<br>
&gt; returns the next hop, a miss meaning the VRF default next hop. The aim=
 is<br>
&gt; to resolve the VRF with a single memory access, so buckets hold 8 reco=
rds<br>
&gt; and there is no probing beyond the bucket.<br>
&gt;<br>
&gt; Such a table only works if the control path can keep buckets from<br>
&gt; overflowing while the hash stays cheap on the datapath. Since the pref=
ix<br>
&gt; ID is internal, the library can pick it so that the records of a prefi=
x<br>
&gt; land in buckets with free room. Collisions are chosen deliberately, so=
 they<br>
&gt; are not a security concern, but finding them has to be cheap. Toeplitz=
 was<br>
&gt; the first candidate: its structure is well studied and the thash libra=
ry<br>
&gt; already knows how to find collisions, but it is only fast with GFNI. C=
RC<br>
&gt; has the same linear properties, is trivially inverted and is hardware<=
br>
&gt; accelerated on x86 and Arm, so CRC32C is used. Linearity also places t=
he<br>
&gt; buckets of one prefix in different VRFs at fixed XOR offsets from each=
<br>
&gt; other, so a candidate prefix ID is checked for all the VRFs referencin=
g<br>
&gt; the prefix at once, and these records never share a bucket. If a bucke=
t<br>
&gt; fills up anyway, a prefix already in it is renumbered to make room.<br=
>
&gt;<br>
&gt; The price of the shared table is paid on the control path: a route in =
one<br>
&gt; VRF needs a record for every more specific prefix installed below it b=
y<br>
&gt; other VRFs. Default routes are excluded, they map onto the per-VRF def=
ault<br>
&gt; next hop.<br>
&gt;<br>
&gt; The two algorithms target different deployments. DIR8-16-8 fits a limi=
ted<br>
&gt; number of VRFs (tens to hundreds) carrying large tables, up to a BGP f=
ull<br>
&gt; view each. The hash based DIR-24-8 fits one large VRF alongside hundre=
ds<br>
&gt; or thousands of small ones.<br>
&gt;<br>
&gt; test-fib gets a VRF mode, including a profile with a full view in VRF =
0 and<br>
&gt; smaller VRFs made of random subsets of it. The first three patches are=
 fixes<br>
&gt; found along the way and are independent of the rest.<br>
&gt;<br>
&gt; Not done yet:<br>
&gt; - IPv6. The VRF bookkeeping of the hash based scheme is address family=
<br>
&gt;=C2=A0 =C2=A0agnostic and is meant to be reused by TRIE.<br>
&gt; - RCU support for multi-VRF DIR-24-8.<br>
&gt;<br>
&gt; Vladimir Medvedkin (7):<br>
&gt;=C2=A0 =C2=A0fib: fix return value of a nexthop update<br>
&gt;=C2=A0 =C2=A0app/test-fib: fix lookup of the last burst<br>
&gt;=C2=A0 =C2=A0app/test-fib: fix size of the tables for large counts<br>
&gt;=C2=A0 =C2=A0fib: add DIR8-16-8 algorithm<br>
&gt;=C2=A0 =C2=A0fib: add multi-VRF support<br>
&gt;=C2=A0 =C2=A0fib: split DIR24-8 table update from the FIB wrapper<br>
&gt;=C2=A0 =C2=A0fib: add hash based VRF support for DIR24-8<br>
&gt;<br>
&gt;=C2=A0 app/test-fib/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 673 ++++++++++---<br>
&gt;=C2=A0 app/test/test_fib.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 | 1001 ++++++++++++++++++-<br>
&gt;=C2=A0 app/test/test_fib_perf.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 440 +++------<br>
&gt;=C2=A0 app/test/test_fib_routes.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 282 ++++++<br>
&gt;=C2=A0 doc/guides/prog_guide/fib_lib.rst=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =
=C2=A066 ++<br>
&gt;=C2=A0 doc/guides/rel_notes/release_26_11.rst |=C2=A0 =C2=A021 +<br>
&gt;=C2=A0 lib/fib/dir24_8.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A034 +-<br>
&gt;=C2=A0 lib/fib/dir24_8.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A043 +-<br>
&gt;=C2=A0 lib/fib/dir24_8_avx512.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A018 +-<br>
&gt;=C2=A0 lib/fib/dir24_8_avx512.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A032 +-<br>
&gt;=C2=A0 lib/fib/dir24_8_rvv.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 3 +-<br>
&gt;=C2=A0 lib/fib/dir24_8_rvv.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A016 +-<br>
&gt;=C2=A0 lib/fib/dir24_8_vrf.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 290 ++++++<br>
&gt;=C2=A0 lib/fib/dir24_8_vrf.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A060 ++<br>
&gt;=C2=A0 lib/fib/dir8_16_8.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 665 +++++++++++++<br>
&gt;=C2=A0 lib/fib/dir8_16_8.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 192 ++++<br>
&gt;=C2=A0 lib/fib/dir8_16_8_avx512.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 183 ++++<br>
&gt;=C2=A0 lib/fib/dir8_16_8_avx512.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A024 +<br>
&gt;=C2=A0 lib/fib/fib_vrf.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 | 1256 ++++++++++++++++++++++++<br>
&gt;=C2=A0 lib/fib/fib_vrf.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 277 ++++++<br>
&gt;=C2=A0 lib/fib/fib_vrf_avx512.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 142 +++<br>
&gt;=C2=A0 lib/fib/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A022 +-<br>
&gt;=C2=A0 lib/fib/rte_fib.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 249 ++++-<br>
&gt;=C2=A0 lib/fib/rte_fib.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 127 ++-<br>
&gt;=C2=A0 24 files changed, 5593 insertions(+), 523 deletions(-)<br>
&gt;=C2=A0 create mode 100644 app/test/test_fib_routes.h<br>
&gt;=C2=A0 create mode 100644 lib/fib/dir24_8_vrf.c<br>
&gt;=C2=A0 create mode 100644 lib/fib/dir24_8_vrf.h<br>
&gt;=C2=A0 create mode 100644 lib/fib/dir8_16_8.c<br>
&gt;=C2=A0 create mode 100644 lib/fib/dir8_16_8.h<br>
&gt;=C2=A0 create mode 100644 lib/fib/dir8_16_8_avx512.c<br>
&gt;=C2=A0 create mode 100644 lib/fib/dir8_16_8_avx512.h<br>
&gt;=C2=A0 create mode 100644 lib/fib/fib_vrf.c<br>
&gt;=C2=A0 create mode 100644 lib/fib/fib_vrf.h<br>
&gt;=C2=A0 create mode 100644 lib/fib/fib_vrf_avx512.c<br>
&gt;<br>
&gt; --<br>
&gt; 2.43.0<br>
&gt;<br>
<br>
Thanks for the v2. It addresses the large TBL24 memory footprint of<br>
v1, but I think several of my original concerns remain.<br>
<br>
DIR8-16-8 is essentially a three-level lookup with an additional<br>
memory access for prefixes longer than /8. While the TBL16 and TBL8<br>
pools are shared across VRFs, their capacities still have to be<br>
provisioned upfront. There is also a 2 KB root table per configured<br>
VRF, plus a 512 KB TBL16 group for each /8 a VRF uses. A full-view VRF<br>
has routes longer than /8 in most /8s, so it needs a TBL16 group for<br>
most of them: close to the memory of a TBL24, with one more lookup<br>
level.<br>
<br>
More importantly, the design still relies on dense VRF IDs in the<br>
range [0, max_vrfs)</blockquote><div><br></div><div>I still don&#39;t under=
stand why this is a problem</div><div>=C2=A0</div><blockquote class=3D"gmai=
l_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,20=
4,204);padding-left:1ex">, with a separate RIB per VRF. Each RIB is created=
<br>
upfront in rte_fib_create() with the same max_routes capacity, which<br>
still means substantial memory overhead for deployments with one<br>
full-view VRF and hundreds of small or empty ones.<br></blockquote><div><br=
></div><div>Correct, and I&#39;m going to fix this issue by making a shared=
 rib_node pool across all RIBs</div><div>=C2=A0</div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">
<br>
The hash-based DIR24-8 avoids the extra trie level, but at the cost of<br>
considerably more control-plane complexity: prefix IDs, bucket<br>
placement constraints, prefix renumbering, and additional records for<br>
overlapping prefixes across VRFs. RCU support is also still missing in<br>
this mode, and renumbering looks hard to combine with it: old hash<br>
entries would have to stay visible to concurrent readers until a grace<br>
period has elapsed, which temporarily increases bucket occupancy.<br></bloc=
kquote><div><br></div><div>I don&#39;t think this is a big problem. The int=
ernal implementation already has RCU support.</div><div>=C2=A0</div><blockq=
uote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1p=
x solid rgb(204,204,204);padding-left:1ex">
<br>
IPv6 remains unsupported, and neither approach provides a shared<br>
resource pool across IPv4 and IPv6 FIBs.<br></blockquote><div><br></div><di=
v>Yes, IPv6 support is not included in this RFC, as I mentioned in the cove=
r letter, although there is preliminary support in the internal implementat=
ion. At the moment I don&#39;t see any strong reason to share resource pool=
s across address families.</div><div>=C2=A0</div><blockquote class=3D"gmail=
_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204=
,204);padding-left:1ex">
<br>
I would like to suggest an alternative that keeps one FIB per VRF and<br>
still provides the mixed-VRF bulk lookup this series is after. The<br>
idea is a small group object holding what the FIBs have in common<br>
(type, flags, next hop size), which a FIB joins at creation:<br>
<br>
=C2=A0 =C2=A0 grp =3D rte_fib_group_create(&amp;grp_conf);<br>
=C2=A0 =C2=A0 conf.group =3D grp;<br>
=C2=A0 =C2=A0 fib =3D rte_fib_create(name, socket_id, &amp;conf);<br>
=C2=A0 =C2=A0 rte_fib_group_lookup_bulk(grp, dps, ips, next_hops, n);<br>
<br>
=C2=A0 dps[i] would be the rte_fib_get_dp() pointer of the FIB to use for i=
ps[i].<br>
<br>
On v1 you objected that allocating one TBL24 per VRF on demand would<br>
add an indirection layer to the lookup. This would avoid it: in<br>
DIR24-8 the TBL24 is embedded in the dataplane struct, so it sits at a<br>
fixed offset from the pointer passed by the caller. There is no table<br>
of pointers to go through: the TBL24 access needs no additional level<br>
of indirection, and the existing single-FIB path is untouched.<br>
<br>
Compared to your API, your &quot;fib&quot; becomes the group and your &quot=
;vrf&quot;<br>
becomes a FIB, identified by a pointer instead of a dense index. FIBs<br>
are created on demand, each with its own RIB size, and nothing is<br>
allocated for VRFs that do not exist. The same idea should apply to<br>
the IPv6 trie, which embeds its TBL24 the same way.<br>
<br>
This does not reduce the per-VRF TBL24 by itself; that is where a<br>
compact algorithm such as DIR8-16-8, used as a regular single-VRF<br>
backend, would fit. It is also independent of my TBL8 pool RFC, which<br>
addresses the sizing of num_tbl8.<br>
<br>
What do you think?<br></blockquote><div><br></div><div>This series is not j=
ust about mixed-VRF bulk lookup, this series is about internal representati=
ons and algorithms. V1 was mostly about API and there was reasonable=C2=A0c=
riticism=C2=A0regarding memory consumption. Here this issue was addressed w=
ith increased internal complexity.</div><div><br></div><div>I&#39;m not sur=
e this implementation would avoid indirection layer, it just moves it to th=
e lookup function as dps argument.</div><div>Your suggestion does not solve=
 the memory consumption issue with many small VRFs. I also doubt it would h=
ave a reasonable performance.</div><div>=C2=A0</div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">
<br>
Regards,<br>
<br>
Maxime<br>
</blockquote></div><div><br clear=3D"all"></div><br><span class=3D"gmail_si=
gnature_prefix">-- </span><br><div dir=3D"ltr" class=3D"gmail_signature"><d=
iv dir=3D"ltr"><div>Regards,<br></div>Vladimir<br></div></div></div>

--0000000000009ef8a10660df1f67--
