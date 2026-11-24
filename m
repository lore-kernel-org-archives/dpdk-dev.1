Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5582606A31E
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Nov 2026 22:24:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 143774027A;
	Tue, 24 Nov 2026 23:24:35 +0100 (CET)
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com
 [74.125.224.46])
 by mails.dpdk.org (Postfix) with ESMTPS id 0A21740279
 for <dev@dpdk.org>; Tue, 24 Nov 2026 23:24:33 +0100 (CET)
Received: by mail-yx1-f46.google.com with SMTP id
 956f58d0204a3-67c246c0c60so4514160d50.0
 for <dev@dpdk.org>; Tue, 24 Nov 2026 14:24:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795559072; cv=none;
 d=google.com; s=arc-20260327;
 b=I3713GElwlEtivvfTDiADMGSCcfy4LyxKOGamttnkrGK1AGz28S32VKsKYszR9Rsqt
 OtTjpVzfMpggJZg5CqE6mnl8OLq+C95cHe/eAuZVaXmHQBMTaHqyhlEWdsjmOu1cF2LI
 RZEWuImPxHV4vLENaZYbzXAOrFotj7gyvhx7P/Y5AEH3NziAwIk27uLHTnC80B/oNKBN
 7voN6/Dy3wBXrc7mMAabDJFXuopfz5gNVJVhndtgx42yGY7DnwiwCSU/D9P6wHIFpE+N
 g1iO1LaLON3x4Mk3COSH2T8w79M8VWyqMgmMBO9HI87iiD5lqULE8nLaR+7TTyvhm+xc
 X/zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=OiE304xlhvcUrThVcEAIHw9sxGpf3xJeoYv66m0L9gw=;
 fh=IJw7n0Mo+iT2FqBjDhC98W2KFHG6IQD5wFor/a0gp/4=;
 b=BT8rGzaiI/hZYH2hl/Ip0Rrf2MinCEyKJ1P9UFkjRS8G2lEuJmvCEYUDio8JMdcgUG
 4U2NNWSgsreJV1dTLLK+FfHNsrOuT9H5hR/WCWuSxU+aiTZMrXdo30Ux0X7Ppbk5YL1R
 WTq9cVse+k3+v4msvMrs3Wj98VmdJF7ZsY3cMtHjwD7Dn90zxLvtKDRXOKHasrNsYanr
 yZC0af3KMQeCT8KDcFmFIGdYE4GhkyAAqPgtXAePRAFrZk7kmS2M/+SAZCJaEI7vsgE4
 g7q2ONUvbHvNXJRTaJTjbIU+Bm1SXvj93XQKrhN7UufYZEEyCSm5bvrECpdRP2SgPOtM
 kCMw==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795559072; x=1796163872;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OiE304xlhvcUrThVcEAIHw9sxGpf3xJeoYv66m0L9gw=;
 b=cZL9c1y2S9rRpcD2ns0Aic2jYkkPvjMJF0bDl2gZ86gMpTgkIB2EkNdYMjRb7YkXVn
 /261HZ3/vNU8pvYgmh5nVe6KKec1TwGmsVxVLAKttLJHqMyD3LjCPBO5nz/ls8CMTfRh
 23aqrIdS3hRmVWxCnxLJVobZ/AlX5d72jwhPQfih2kagIfhusLZk7aNsgO9e3Td1SzWr
 K/M/dyhroowELxXt1Bd/4Tp6qEPz370rYYH8z6W9cBeqgky3nmV4OThYMGHTjQ/v368V
 CA35gftk4I8DvGp056UY6/FZiWpZtNqpiZJQXMld4yAIIbMyEmWDaWnwhgiORHM2hzCv
 37aQ==
X-Gm-Message-State: APuU4Z812mDS203ie7OHfisyZI5eiUFDIDOcbegYsWoj91YhHAjfvP+g
 TR0Ar+Z0jpQVB4WZLmSnPeKxcxoImxC5FicCxz3kxHOnxrg7kWu3TC2wHtt66MQOXI3seTDXIYn
 YjDn3Z2vfzVYZHB3IJz6WwFkCy4lZ5jg=
X-Gm-Gg: AZFdTZeB0IXcniF/IWTHK1rWvSpK7WmrcHbNwWHQdASc+5eEhBVMUgalbOq6qH/K4PV
 AhE/wxT4oJSwrpbOJEzJEMTO0JqOT4VCeo53S+c/lU3s49tnUvyrBzCCiMnUuYNhZfFrsVIKOl6
 8VemVBAx/WdrY8qMGmD/7h6ueVovJKMZZmcvRzWrC/CSTNuMzZLgqcEZSVSz8FgZqCgElhEVAIV
 GL/LG6+B+VoXZgaVvPVheNZrzM+NuIHb/TW8TK6BcK8HpmKYiHBfnP4biZFyCv2lQJ4jEsBsIh6
 YSRNa4bNjN0ms9E+BgBW9N1HoboTfRO8skZUsAL+rNLHr8g3RagDU412ZGPts95g6IjlWrRaZZL
 TSwDKIrVzvhElYt4SGHyDcLsIf1/fzrxzwH/6AoaX3b5nLoA6z/JeAjMsn9QNDt/z9rqSH7nalV
 B3UqSPVcBMr05T/CmF7zp7dO5W
X-Received: by 2002:a05:690e:168d:b0:67d:b193:78c with SMTP id
 956f58d0204a3-67dec49a770mr8541651d50.36.1795559071526; Tue, 24 Nov 2026
 14:24:31 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
 <20261014183921.495158-1-vladimir.medvedkin@intel.com>
 <CAHHRULUEZX1fYkvS7YXCLirEbk_80wcoZZ6NoNroZhD-mmFNkw@mail.gmail.com>
 <CANDrEH=VnvZAWkPzVHwr=x-TxgFJBuDGXDiNiQTEzhZbwOihZQ@mail.gmail.com>
In-Reply-To: <CANDrEH=VnvZAWkPzVHwr=x-TxgFJBuDGXDiNiQTEzhZbwOihZQ@mail.gmail.com>
From: Maxime Leroy <maxime@leroys.fr>
Date: Tue, 24 Nov 2026 23:24:20 +0100
X-Gm-Features: Aa3M54oroyaz6FDy3h__OPTkTg8PFT4fugA_wtJudToy8AafCH8gz-bswtxytd8
Message-ID: <CAHHRULWR82N0ZM9eoBow_VnZPfixW5wKOfyfQ4VW397Y+EEsgg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/7] VRF support in FIB library
To: Vladimir Medvedkin <medvedkinv@gmail.com>
Cc: dev@dpdk.org, rjarry@redhat.com, mb@smartsharesystems.com, 
 konstantin.ananyev@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Vladimir,

On Sun, Nov 22, 2026 at 4:28=E2=80=AFPM Vladimir Medvedkin <medvedkinv@gmai=
l.com> wrote:
>
> Hi Maxime,
>
> =D0=BF=D1=82, 13 =D0=BD=D0=BE=D1=8F=D0=B1. 2026=E2=80=AF=D0=B3. =D0=B2 00=
:22, Maxime Leroy <maxime@leroys.fr>:
>>
>> Hi Vladimir,
>>
>> On Wed, Oct 14, 2026 at 8:39=E2=80=AFPM Vladimir Medvedkin
>> <vladimir.medvedkin@intel.com> wrote:
>> >
>> > This series adds multi-VRF support to the IPv4 FIB, allowing a single =
FIB
>> > instance to host multiple isolated routing tables.
>> >
>> > Today a FIB instance is a single routing table, so an application serv=
ing
>> > several VRFs needs one FIB per VRF. In a burst oriented datapath packe=
ts of
>> > one burst can belong to different VRFs, and the application either doe=
s
>> > per-packet lookups in different FIBs or regroups the burst by VRF befo=
re
>> > the lookup. Both are expensive. With this series all the VRFs live in =
one
>> > FIB, the bulk lookup takes a VRF ID per address, and the existing API
>> > operates on VRF 0.
>> >
>> > v1 replicated the 16M entry tbl24 per VRF. That kept the lookup on par=
 with
>> > the single VRF case, but memory grew linearly with the number of VRFs,
>> > which was the main concern raised on v1. v2 resolves the issue by addi=
ng
>> > of two dataplane algorithms with different memory/lookup trade-offs.
>> >
>> > DIR8-16-8 is a new three level variant of DIR-24-8 with 8, 16 and 8 bi=
t
>> > strides. Only the 256 entry root table (2 KB) is replicated per VRF; t=
he
>> > tbl16 and tbl8 groups come from pools shared by all the VRFs, so memor=
y
>> > follows the routes actually installed rather than the number of VRFs. =
The
>> > cost is an extra memory access for prefixes longer than /8.
>> >
>> > DIR-24-8 gets multi-VRF support by resolving the VRF after the longest
>> > prefix match, along the lines Konstantin suggested on v1. Instead of a
>> > vector of next hops per prefix, a single tbl24_8 shared by all the VRF=
s
>> > returns an internal prefix ID, and a hash table keyed by {VRF, prefix =
ID}
>> > returns the next hop, a miss meaning the VRF default next hop. The aim=
 is
>> > to resolve the VRF with a single memory access, so buckets hold 8 reco=
rds
>> > and there is no probing beyond the bucket.
>> >
>> > Such a table only works if the control path can keep buckets from
>> > overflowing while the hash stays cheap on the datapath. Since the pref=
ix
>> > ID is internal, the library can pick it so that the records of a prefi=
x
>> > land in buckets with free room. Collisions are chosen deliberately, so=
 they
>> > are not a security concern, but finding them has to be cheap. Toeplitz=
 was
>> > the first candidate: its structure is well studied and the thash libra=
ry
>> > already knows how to find collisions, but it is only fast with GFNI. C=
RC
>> > has the same linear properties, is trivially inverted and is hardware
>> > accelerated on x86 and Arm, so CRC32C is used. Linearity also places t=
he
>> > buckets of one prefix in different VRFs at fixed XOR offsets from each
>> > other, so a candidate prefix ID is checked for all the VRFs referencin=
g
>> > the prefix at once, and these records never share a bucket. If a bucke=
t
>> > fills up anyway, a prefix already in it is renumbered to make room.
>> >
>> > The price of the shared table is paid on the control path: a route in =
one
>> > VRF needs a record for every more specific prefix installed below it b=
y
>> > other VRFs. Default routes are excluded, they map onto the per-VRF def=
ault
>> > next hop.
>> >
>> > The two algorithms target different deployments. DIR8-16-8 fits a limi=
ted
>> > number of VRFs (tens to hundreds) carrying large tables, up to a BGP f=
ull
>> > view each. The hash based DIR-24-8 fits one large VRF alongside hundre=
ds
>> > or thousands of small ones.
>> >
>> > test-fib gets a VRF mode, including a profile with a full view in VRF =
0 and
>> > smaller VRFs made of random subsets of it. The first three patches are=
 fixes
>> > found along the way and are independent of the rest.
>> >
>> > Not done yet:
>> > - IPv6. The VRF bookkeeping of the hash based scheme is address family
>> >   agnostic and is meant to be reused by TRIE.
>> > - RCU support for multi-VRF DIR-24-8.
>> >
>> > Vladimir Medvedkin (7):
>> >   fib: fix return value of a nexthop update
>> >   app/test-fib: fix lookup of the last burst
>> >   app/test-fib: fix size of the tables for large counts
>> >   fib: add DIR8-16-8 algorithm
>> >   fib: add multi-VRF support
>> >   fib: split DIR24-8 table update from the FIB wrapper
>> >   fib: add hash based VRF support for DIR24-8
>> >
>> >  app/test-fib/main.c                    |  673 ++++++++++---
>> >  app/test/test_fib.c                    | 1001 ++++++++++++++++++-
>> >  app/test/test_fib_perf.c               |  440 +++------
>> >  app/test/test_fib_routes.h             |  282 ++++++
>> >  doc/guides/prog_guide/fib_lib.rst      |   66 ++
>> >  doc/guides/rel_notes/release_26_11.rst |   21 +
>> >  lib/fib/dir24_8.c                      |   34 +-
>> >  lib/fib/dir24_8.h                      |   43 +-
>> >  lib/fib/dir24_8_avx512.c               |   18 +-
>> >  lib/fib/dir24_8_avx512.h               |   32 +-
>> >  lib/fib/dir24_8_rvv.c                  |    3 +-
>> >  lib/fib/dir24_8_rvv.h                  |   16 +-
>> >  lib/fib/dir24_8_vrf.c                  |  290 ++++++
>> >  lib/fib/dir24_8_vrf.h                  |   60 ++
>> >  lib/fib/dir8_16_8.c                    |  665 +++++++++++++
>> >  lib/fib/dir8_16_8.h                    |  192 ++++
>> >  lib/fib/dir8_16_8_avx512.c             |  183 ++++
>> >  lib/fib/dir8_16_8_avx512.h             |   24 +
>> >  lib/fib/fib_vrf.c                      | 1256 +++++++++++++++++++++++=
+
>> >  lib/fib/fib_vrf.h                      |  277 ++++++
>> >  lib/fib/fib_vrf_avx512.c               |  142 +++
>> >  lib/fib/meson.build                    |   22 +-
>> >  lib/fib/rte_fib.c                      |  249 ++++-
>> >  lib/fib/rte_fib.h                      |  127 ++-
>> >  24 files changed, 5593 insertions(+), 523 deletions(-)
>> >  create mode 100644 app/test/test_fib_routes.h
>> >  create mode 100644 lib/fib/dir24_8_vrf.c
>> >  create mode 100644 lib/fib/dir24_8_vrf.h
>> >  create mode 100644 lib/fib/dir8_16_8.c
>> >  create mode 100644 lib/fib/dir8_16_8.h
>> >  create mode 100644 lib/fib/dir8_16_8_avx512.c
>> >  create mode 100644 lib/fib/dir8_16_8_avx512.h
>> >  create mode 100644 lib/fib/fib_vrf.c
>> >  create mode 100644 lib/fib/fib_vrf.h
>> >  create mode 100644 lib/fib/fib_vrf_avx512.c
>> >
>> > --
>> > 2.43.0
>> >
>>
>> Thanks for the v2. It addresses the large TBL24 memory footprint of
>> v1, but I think several of my original concerns remain.
>>
>> DIR8-16-8 is essentially a three-level lookup with an additional
>> memory access for prefixes longer than /8. While the TBL16 and TBL8
>> pools are shared across VRFs, their capacities still have to be
>> provisioned upfront. There is also a 2 KB root table per configured
>> VRF, plus a 512 KB TBL16 group for each /8 a VRF uses. A full-view VRF
>> has routes longer than /8 in most /8s, so it needs a TBL16 group for
>> most of them: close to the memory of a TBL24, with one more lookup
>> level.
>>
>> More importantly, the design still relies on dense VRF IDs in the
>> range [0, max_vrfs)
>
>
> I still don't understand why this is a problem

In Grout, a VRF is an interface and its ID is the interface ID. These
IDs are sparse because not every interface is a VRF. Dense IDs mean
allocating and recycling indexes below max_vrfs, a limit fixed when
the FIB is created. With one FIB per VRF, there is no library-imposed VRF
index or fixed max_vrfs limit: each VRF simply holds its FIB.

>
>>
>> , with a separate RIB per VRF. Each RIB is created
>> upfront in rte_fib_create() with the same max_routes capacity, which
>> still means substantial memory overhead for deployments with one
>> full-view VRF and hundreds of small or empty ones.
>
>
> Correct, and I'm going to fix this issue by making a shared rib_node pool=
 across all RIBs
>

Thanks, that fixes the RIB part.

>>
>>
>> The hash-based DIR24-8 avoids the extra trie level, but at the cost of
>> considerably more control-plane complexity: prefix IDs, bucket
>> placement constraints, prefix renumbering, and additional records for
>> overlapping prefixes across VRFs. RCU support is also still missing in
>> this mode, and renumbering looks hard to combine with it: old hash
>> entries would have to stay visible to concurrent readers until a grace
>> period has elapsed, which temporarily increases bucket occupancy.
>
>
> I don't think this is a big problem. The internal implementation already =
has RCU support.
>

I can only review what is posted: in v2, node_move() and ht_delete()
free and reuse hash records immediately.

The extra records are the bigger issue. The shared TBL24 returns the
longest prefix of any VRF, so next to a full view, a VRF holding only
8.0.0.0/8 needs about 2,300 records, and one holding 0.0.0.0/1 about
500,000, for a single route.

>>
>>
>> IPv6 remains unsupported, and neither approach provides a shared
>> resource pool across IPv4 and IPv6 FIBs.
>
>
> Yes, IPv6 support is not included in this RFC, as I mentioned in the cove=
r letter, although there is preliminary support in the internal implementat=
ion. At the moment I don't see any strong reason to share resource pools ac=
ross address families.

Same reason as for VRFs: the split of the tbl8 demand is not known at
creation. v2 already shares its pools between all the VRFs of a FIB,
and rightly so. My tbl8 pool RFC v2 [1] shares one resizable pool
between any FIBs, IPv4 and IPv6.

>
>>
>>
>> I would like to suggest an alternative that keeps one FIB per VRF and
>> still provides the mixed-VRF bulk lookup this series is after. The
>> idea is a small group object holding what the FIBs have in common
>> (type, flags, next hop size), which a FIB joins at creation:
>>
>>     grp =3D rte_fib_group_create(&grp_conf);
>>     conf.group =3D grp;
>>     fib =3D rte_fib_create(name, socket_id, &conf);
>>     rte_fib_group_lookup_bulk(grp, dps, ips, next_hops, n);
>>
>>   dps[i] would be the rte_fib_get_dp() pointer of the FIB to use for ips=
[i].
>>
>> On v1 you objected that allocating one TBL24 per VRF on demand would
>> add an indirection layer to the lookup. This would avoid it: in
>> DIR24-8 the TBL24 is embedded in the dataplane struct, so it sits at a
>> fixed offset from the pointer passed by the caller. There is no table
>> of pointers to go through: the TBL24 access needs no additional level
>> of indirection, and the existing single-FIB path is untouched.
>>
>> Compared to your API, your "fib" becomes the group and your "vrf"
>> becomes a FIB, identified by a pointer instead of a dense index. FIBs
>> are created on demand, each with its own RIB size, and nothing is
>> allocated for VRFs that do not exist. The same idea should apply to
>> the IPv6 trie, which embeds its TBL24 the same way.
>>
>> This does not reduce the per-VRF TBL24 by itself; that is where a
>> compact algorithm such as DIR8-16-8, used as a regular single-VRF
>> backend, would fit. It is also independent of my TBL8 pool RFC, which
>> addresses the sizing of num_tbl8.
>>
>> What do you think?
>
>
> This series is not just about mixed-VRF bulk lookup, this series is about=
 internal representations and algorithms. V1 was mostly about API and there=
 was reasonable criticism regarding memory consumption. Here this issue was=
 addressed with increased internal complexity.

It was about mixed-VRF bulk lookup: that is the only motivation in
both cover letters, and v1 promised performance "on par with non-VRF
implementation". It became about algorithms because the series
preallocates every VRF. A TBL24 per VRF is too expensive for
max_vrfs, so DIR8-16-8 and the hash mode cut memory at the price of
lookup performance and complexity (more than 2000 lines for the hash
mode). And a full-view VRF still needs 217 tbl16 groups in DIR8-16-8:
108 MB, against 128 MB for a TBL24.

Allocated on demand, a VRF keeps a plain DIR24-8 table. That is the
group of FIBs RFC [2].

>
> I'm not sure this implementation would avoid indirection layer, it just m=
oves it to the lookup function as dps argument.

dps[i] is the dataplane pointer and the TBL24 sits at a fixed offset
from it: one load, as vrf_ids[i] in yours.

> Your suggestion does not solve the memory consumption issue with many sma=
ll VRFs.

It preallocates nothing: a VRF costs its TBL24 only once it is
created. Setups with many small VRFs could use DIR8-16-8 (your
patch 4) for all their FIBs.

> I also doubt it would have a reasonable performance.

For a prefix between /9 and /24 (every route of a full view but 16),
a lookup reads one cache line with DIR24-8 and the group, two with
DIR8-16-8, three with the hash mode plus a CRC and up to eight key
compares.

Measured with your test-fib on a full view (1,075,223 routes), 4 VRFs,
8 byte next hops, cost relative to a single-VRF DIR24-8 lookup:

                                test-fib order          random order
                               scalar   AVX-512     scalar   AVX-512
  v1                         250%      180%         165%     135%
  group of FIBs       235%      155%         155%     160%
  DIR8-16-8            300%      200%         240%     155%
  hash DIR24-8       545%     465%         410%     375%
  one call/address   355%     335%         415%     415%

v1 matches your 180%. The group is on par with v1, the hash mode is 2
to 3 times slower than the others. The last line is one
rte_fib_lookup_bulk() call per address in 4 FIBs, what the series
wants to avoid. Laptop figures (Ryzen 7540U, no hugepages, median of 3
runs), please check the v2 lines on your side. The group uses
test-fib -G from [2]; the random order needs -t, fixed in [3].

Regards,

Maxime

[1] https://mails.dpdk.org/archives/dev/2026-November/351666.html
[2] https://mails.dpdk.org/archives/dev/2026-November/351680.html
[3] https://mails.dpdk.org/archives/dev/2026-November/351664.html
