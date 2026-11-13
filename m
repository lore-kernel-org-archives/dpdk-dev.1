Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D6D3606A31C
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Nov 2026 00:22:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B9E0140E22;
	Fri, 13 Nov 2026 01:22:29 +0100 (CET)
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com
 [74.125.224.44])
 by mails.dpdk.org (Postfix) with ESMTPS id 7CBC9402B4
 for <dev@dpdk.org>; Fri, 13 Nov 2026 01:22:28 +0100 (CET)
Received: by mail-yx1-f44.google.com with SMTP id
 956f58d0204a3-67c0ffaae1dso1633944d50.1
 for <dev@dpdk.org>; Thu, 12 Nov 2026 16:22:28 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794529347; cv=none;
 d=google.com; s=arc-20260327;
 b=iZRqWJAq0ryXSsITpgvQdyw8BvGwrpFjdMRV/oqP2Bs8KT/bNBeFPylhDgMfgVzqKo
 ASivI7FIz/HVUZFHvt8DsVWRnt3R6TJOFIZ3SM89ai/0rw4xVzNB1ZC/ywC8gngSL4WA
 QtlpVyBmMl+q90g+0puee1e0M3YE+i6ZaOCdeFChzXsWtGqyZ9BfE9M7Zc5MIb/CfRt6
 YIwVCWd6LLbQ4FxisFgII6/Miqx6zrNV3VphhiOVaCFCmCqgrb2Rk/zamc8kmTOi1bSI
 VcrSXYs9QRtEoCvWP+1qlhEY8utN814jdofHeDa95n7Bt+J/hjJhVukdRYU5t/Qd7Eft
 933g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version;
 bh=II5HW9eR4y/rbsWVSgsuF92hq4rb0pfeqxK9pb9xkQ0=;
 fh=yWe3Wf8fdlKCVJW57D7CIFvxTLuUanf7xma3w7gQB4U=;
 b=j3Sbjxx80gppRk3/JEdNHB2ssRmlK5rh9B17f30SwkhZIx0zg0qxunsRM62FoI6mzy
 lak6oCRGDmfQy6rmgHUeHYzWxNHX8sc6sZNq3Io5ikk5O/gY4BOP1JxM80n0z9oSXxXv
 OiwDxI+V2jK9D2vJFpigbn0KCdviT5kDbtCSu8MyEgyazfwmvA02EieWflLUjnZmF7Hi
 BODdd64IBvfCTtXFMo8oTvt0UcgorVFeAg0m5k89XTBKvY1yklWXc8+r+AQoJtmsXeid
 zIGu6Xo39X1/qvy5mAb5L1fnXfHRGfstUFQCkudZxTZA/D8deYzAOf2Ng+ubGaIInIZm
 0uog==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794529347; x=1795134147;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=II5HW9eR4y/rbsWVSgsuF92hq4rb0pfeqxK9pb9xkQ0=;
 b=w/h/Jo05mi3YE/5gWt1nfxyoUBmt1QLH6QOmqPKGMaKfy8RFdqnvpTXiTO018m8CC+
 bGM7IoXuQ/ceICQmtXzm7lH1vNVW0mTcGIjLqbBIY4SmgCVdux995uSKrSl0LEcRJzmQ
 UIMWWF45US0zc1ypgw5DPBNmgII5tZjEdVzmojiKbIBpGWF5QWEGniLicQPwScX2KWCO
 meTsEZvYmHulL+MYqUkQuzyAIEG/3nX+JwvGnwSE/gORwTvAXgAk8GdHOTod5t5zBiFq
 Y8w3VItaLGkVOkVII93Q8fQKd7t6XKaNCqWJlxnGQZdhoSOGrpWmXUoGAw660baeP8hn
 0KNw==
X-Gm-Message-State: APuU4Z8NdcqagamGJ5OXvJltW7dnAPdGdlHbznLOiMKiRz0Hlc8IO1E3
 IMUuZY0Bl3tx4JJt6sXFvn7f3CEPEF1vuW8RJkLDFd3Refr57ctG8Vz3p7aUoa2MK5evmdNsEge
 GyRWioqVJf/xyUudKvclFsDSWa0JQbU8=
X-Gm-Gg: AYBFou0jP8Wh1Rk2PKVkQjMYPWai/oQ6m/OgTFx58MEBRDbYuK+ZpKHjHVuV5WpKO4w
 07YLj+qTbYE7u+lLrnP889jK+Q2FC1W2V0FsXNVdNoptefyKj/+WQbVPbBFXIkECpGjj3MT6T/V
 F4H9kbmJYX2sYq4LwZXyIR3SS8ZTDrp75YO+Td9L07vU59pawf/WQ+4BdtMu1cOVokkDFsizV5F
 w9wHRHXVz7Bx1pbECmGCtYGMFBOYLqGVKzs3rXnqLPhQKj9PMkIZWiGk1fDYUnGy6JaVcty2YM9
 /P4sHbbgXbMKjtrk1peygsYc1t0Cf46LBnYHWofVFfkIUXoq9mG8Cc0jZJwFEq2sh41CfcMOvt7
 f67LwTYTFZq4/otemfaXwRmBXvIdJukcPQqyx8VeGk2SYc1KRSoVuEDG+n2GmxKfiUMT2kpkMgy
 VQvYFMUEskWguJkJSUAqsIDO79Qg==
X-Received: by 2002:a05:690e:1385:b0:67c:6bcd:b914 with SMTP id
 956f58d0204a3-67d8935d5fbmr829126d50.7.1794529347230; Thu, 12 Nov 2026
 16:22:27 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
 <20261014183921.495158-1-vladimir.medvedkin@intel.com>
In-Reply-To: <20261014183921.495158-1-vladimir.medvedkin@intel.com>
From: Maxime Leroy <maxime@leroys.fr>
Date: Fri, 13 Nov 2026 01:22:15 +0100
X-Gm-Features: AclHuK9LaHAn5NhKP-GBQVdbJK5yg4jX_YW1q-Boz46dP5ZwYSkOLpwtblS4phI
Message-ID: <CAHHRULUEZX1fYkvS7YXCLirEbk_80wcoZZ6NoNroZhD-mmFNkw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/7] VRF support in FIB library
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
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

On Wed, Oct 14, 2026 at 8:39=E2=80=AFPM Vladimir Medvedkin
<vladimir.medvedkin@intel.com> wrote:
>
> This series adds multi-VRF support to the IPv4 FIB, allowing a single FIB
> instance to host multiple isolated routing tables.
>
> Today a FIB instance is a single routing table, so an application serving
> several VRFs needs one FIB per VRF. In a burst oriented datapath packets =
of
> one burst can belong to different VRFs, and the application either does
> per-packet lookups in different FIBs or regroups the burst by VRF before
> the lookup. Both are expensive. With this series all the VRFs live in one
> FIB, the bulk lookup takes a VRF ID per address, and the existing API
> operates on VRF 0.
>
> v1 replicated the 16M entry tbl24 per VRF. That kept the lookup on par wi=
th
> the single VRF case, but memory grew linearly with the number of VRFs,
> which was the main concern raised on v1. v2 resolves the issue by adding
> of two dataplane algorithms with different memory/lookup trade-offs.
>
> DIR8-16-8 is a new three level variant of DIR-24-8 with 8, 16 and 8 bit
> strides. Only the 256 entry root table (2 KB) is replicated per VRF; the
> tbl16 and tbl8 groups come from pools shared by all the VRFs, so memory
> follows the routes actually installed rather than the number of VRFs. The
> cost is an extra memory access for prefixes longer than /8.
>
> DIR-24-8 gets multi-VRF support by resolving the VRF after the longest
> prefix match, along the lines Konstantin suggested on v1. Instead of a
> vector of next hops per prefix, a single tbl24_8 shared by all the VRFs
> returns an internal prefix ID, and a hash table keyed by {VRF, prefix ID}
> returns the next hop, a miss meaning the VRF default next hop. The aim is
> to resolve the VRF with a single memory access, so buckets hold 8 records
> and there is no probing beyond the bucket.
>
> Such a table only works if the control path can keep buckets from
> overflowing while the hash stays cheap on the datapath. Since the prefix
> ID is internal, the library can pick it so that the records of a prefix
> land in buckets with free room. Collisions are chosen deliberately, so th=
ey
> are not a security concern, but finding them has to be cheap. Toeplitz wa=
s
> the first candidate: its structure is well studied and the thash library
> already knows how to find collisions, but it is only fast with GFNI. CRC
> has the same linear properties, is trivially inverted and is hardware
> accelerated on x86 and Arm, so CRC32C is used. Linearity also places the
> buckets of one prefix in different VRFs at fixed XOR offsets from each
> other, so a candidate prefix ID is checked for all the VRFs referencing
> the prefix at once, and these records never share a bucket. If a bucket
> fills up anyway, a prefix already in it is renumbered to make room.
>
> The price of the shared table is paid on the control path: a route in one
> VRF needs a record for every more specific prefix installed below it by
> other VRFs. Default routes are excluded, they map onto the per-VRF defaul=
t
> next hop.
>
> The two algorithms target different deployments. DIR8-16-8 fits a limited
> number of VRFs (tens to hundreds) carrying large tables, up to a BGP full
> view each. The hash based DIR-24-8 fits one large VRF alongside hundreds
> or thousands of small ones.
>
> test-fib gets a VRF mode, including a profile with a full view in VRF 0 a=
nd
> smaller VRFs made of random subsets of it. The first three patches are fi=
xes
> found along the way and are independent of the rest.
>
> Not done yet:
> - IPv6. The VRF bookkeeping of the hash based scheme is address family
>   agnostic and is meant to be reused by TRIE.
> - RCU support for multi-VRF DIR-24-8.
>
> Vladimir Medvedkin (7):
>   fib: fix return value of a nexthop update
>   app/test-fib: fix lookup of the last burst
>   app/test-fib: fix size of the tables for large counts
>   fib: add DIR8-16-8 algorithm
>   fib: add multi-VRF support
>   fib: split DIR24-8 table update from the FIB wrapper
>   fib: add hash based VRF support for DIR24-8
>
>  app/test-fib/main.c                    |  673 ++++++++++---
>  app/test/test_fib.c                    | 1001 ++++++++++++++++++-
>  app/test/test_fib_perf.c               |  440 +++------
>  app/test/test_fib_routes.h             |  282 ++++++
>  doc/guides/prog_guide/fib_lib.rst      |   66 ++
>  doc/guides/rel_notes/release_26_11.rst |   21 +
>  lib/fib/dir24_8.c                      |   34 +-
>  lib/fib/dir24_8.h                      |   43 +-
>  lib/fib/dir24_8_avx512.c               |   18 +-
>  lib/fib/dir24_8_avx512.h               |   32 +-
>  lib/fib/dir24_8_rvv.c                  |    3 +-
>  lib/fib/dir24_8_rvv.h                  |   16 +-
>  lib/fib/dir24_8_vrf.c                  |  290 ++++++
>  lib/fib/dir24_8_vrf.h                  |   60 ++
>  lib/fib/dir8_16_8.c                    |  665 +++++++++++++
>  lib/fib/dir8_16_8.h                    |  192 ++++
>  lib/fib/dir8_16_8_avx512.c             |  183 ++++
>  lib/fib/dir8_16_8_avx512.h             |   24 +
>  lib/fib/fib_vrf.c                      | 1256 ++++++++++++++++++++++++
>  lib/fib/fib_vrf.h                      |  277 ++++++
>  lib/fib/fib_vrf_avx512.c               |  142 +++
>  lib/fib/meson.build                    |   22 +-
>  lib/fib/rte_fib.c                      |  249 ++++-
>  lib/fib/rte_fib.h                      |  127 ++-
>  24 files changed, 5593 insertions(+), 523 deletions(-)
>  create mode 100644 app/test/test_fib_routes.h
>  create mode 100644 lib/fib/dir24_8_vrf.c
>  create mode 100644 lib/fib/dir24_8_vrf.h
>  create mode 100644 lib/fib/dir8_16_8.c
>  create mode 100644 lib/fib/dir8_16_8.h
>  create mode 100644 lib/fib/dir8_16_8_avx512.c
>  create mode 100644 lib/fib/dir8_16_8_avx512.h
>  create mode 100644 lib/fib/fib_vrf.c
>  create mode 100644 lib/fib/fib_vrf.h
>  create mode 100644 lib/fib/fib_vrf_avx512.c
>
> --
> 2.43.0
>

Thanks for the v2. It addresses the large TBL24 memory footprint of
v1, but I think several of my original concerns remain.

DIR8-16-8 is essentially a three-level lookup with an additional
memory access for prefixes longer than /8. While the TBL16 and TBL8
pools are shared across VRFs, their capacities still have to be
provisioned upfront. There is also a 2 KB root table per configured
VRF, plus a 512 KB TBL16 group for each /8 a VRF uses. A full-view VRF
has routes longer than /8 in most /8s, so it needs a TBL16 group for
most of them: close to the memory of a TBL24, with one more lookup
level.

More importantly, the design still relies on dense VRF IDs in the
range [0, max_vrfs), with a separate RIB per VRF. Each RIB is created
upfront in rte_fib_create() with the same max_routes capacity, which
still means substantial memory overhead for deployments with one
full-view VRF and hundreds of small or empty ones.

The hash-based DIR24-8 avoids the extra trie level, but at the cost of
considerably more control-plane complexity: prefix IDs, bucket
placement constraints, prefix renumbering, and additional records for
overlapping prefixes across VRFs. RCU support is also still missing in
this mode, and renumbering looks hard to combine with it: old hash
entries would have to stay visible to concurrent readers until a grace
period has elapsed, which temporarily increases bucket occupancy.

IPv6 remains unsupported, and neither approach provides a shared
resource pool across IPv4 and IPv6 FIBs.

I would like to suggest an alternative that keeps one FIB per VRF and
still provides the mixed-VRF bulk lookup this series is after. The
idea is a small group object holding what the FIBs have in common
(type, flags, next hop size), which a FIB joins at creation:

    grp =3D rte_fib_group_create(&grp_conf);
    conf.group =3D grp;
    fib =3D rte_fib_create(name, socket_id, &conf);
    rte_fib_group_lookup_bulk(grp, dps, ips, next_hops, n);

  dps[i] would be the rte_fib_get_dp() pointer of the FIB to use for ips[i]=
.

On v1 you objected that allocating one TBL24 per VRF on demand would
add an indirection layer to the lookup. This would avoid it: in
DIR24-8 the TBL24 is embedded in the dataplane struct, so it sits at a
fixed offset from the pointer passed by the caller. There is no table
of pointers to go through: the TBL24 access needs no additional level
of indirection, and the existing single-FIB path is untouched.

Compared to your API, your "fib" becomes the group and your "vrf"
becomes a FIB, identified by a pointer instead of a dense index. FIBs
are created on demand, each with its own RIB size, and nothing is
allocated for VRFs that do not exist. The same idea should apply to
the IPv6 trie, which embeds its TBL24 the same way.

This does not reduce the per-VRF TBL24 by itself; that is where a
compact algorithm such as DIR8-16-8, used as a regular single-VRF
backend, would fit. It is also independent of my TBL8 pool RFC, which
addresses the sizing of num_tbl8.

What do you think?

Regards,

Maxime
