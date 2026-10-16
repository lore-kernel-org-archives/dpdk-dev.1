Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 531F4CCF2C1
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 22:54:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6EB8B4027D;
	Sat, 17 Oct 2026 00:54:40 +0200 (CEST)
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com
 [209.85.216.50]) by mails.dpdk.org (Postfix) with ESMTP id 3F21C4003C
 for <dev@dpdk.org>; Sat, 17 Oct 2026 00:54:39 +0200 (CEST)
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-38d489b6b71so304441a91.0
 for <dev@dpdk.org>; Fri, 16 Oct 2026 15:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1792191278;
 x=1792796078; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bCHkcO0G78VLuYE/NMqtn6xVzS5FPPfdEMKOOhw2j34=;
 b=SGCBDFOdK+CY2f+7907HcD7feB5xWOjx5lDd2p979Ed10SVHsZvViD6rKNLRp/xlJK
 7c4n5hVZc2SoM+GeHH/Ub4+AWQXogNY661dkp0iVnIBVABIGHULRKUHwessZvKTVk3IG
 r5i+5s+Q85EzQPftL+9MxDR+WTkOOWkflUhgCKJweM9/LNdF+WsmZyPcip4v1deXu5du
 AifZ3usC377vQQVUduv9ZhjMSHrcJwYLMFRazOcIwApIfSSAwKJhnVmc4yscWdckbz3U
 JkzdUdPqoGXJr8U3RRx2giJFNBpKZknEDMHKvIAGyxisN1SLlgRFEDojJsYEP8U643p3
 LHwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792191278; x=1792796078;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=bCHkcO0G78VLuYE/NMqtn6xVzS5FPPfdEMKOOhw2j34=;
 b=p4yGU4C9KlDiz/UYw1YktvdpN/AkLL266l3yHzvnPjFOx3hBjjQDUSRGjB1sy2v23e
 RlHN4F89AEWpwLgOYIQx+DwFi7Q0CBfXeUY42y/ZRNU6tZkQp4/GzHF1ZhLR1lYR7arP
 kaHE0op+kw+d6TtDGZY5B8xISCAt9yxgVITnrAUXH9vDSVu5FgVNU8RcRiiFi/MpgaOl
 QyYwQKaV+WXK9WMT/xrPw7XfUJp8pBwn0jB7cdP3IkJTxpDzvSvm4GQ/RM4G9Sdb1ddk
 ivvJvOw2IAidj0RbGV8b0RDKNVFAiqs0p7bDFVhl1C+0Lxla6wMdSpP7RQM/NXMW6eNc
 IX3Q==
X-Gm-Message-State: AFq9FYJdqb5gtyJc7ZcFyNqv1sGuwzOociMacR0K0TsZUVWbKvBs3ewV
 SQfKGnko+pQGBmgJPKho7BdFhzWQVuGDgw8RIY+PnomzZ1zoCVWmhmceM5MVzPMpOC4=
X-Gm-Gg: AYBFou2ETEdJ9YV3YNuhpwzAVV+OTj6JjRkdDuJrAsamWLeSb4eqg1ooRloDp9+7phC
 2aiswQ1PBa1YAr7dHVaeuR96T1yZVwYfuejEt8SGuAOZq/zl717nLSBkPaZOI9vkfWK2zWXd7Ga
 XxwFXCEsqykjqdwU3upzPQrHI1hE4c/sBKmZAWH99fWhSwjMjPexsAKSZND5k3EAFGepdMF6opA
 yPOioIhjXAXz6jrPOAi3FrarH1WxCzi99imBYWQKu7+ozloerGmlkFypi3edNOEtm2CFJFiI7X+
 yoz8rGGKF/RvELDeNYL9jIBc/Dts67GIy+fEcAyefjHJJE0NxZSqYTPhQgU6U1q6Q3RTQhFQ+BU
 dZcLhD7xVdy6UoNufIrt3uceyWvciiPlw1qWjqKClXNQY+9OrL3p7G+YPt8GiKbmoz36RhYQphP
 X+AyAY2VFQxWygfKMsLWVfUJzDBgQItUOgov5WibpPO0jcHu+pHTlYOipbXq7LByKR7qjdmszmM
 +xQySY+xLzS73sVwQ5khGNxL9yRFE5g/9xR27KZ
X-Received: by 2002:a17:90b:1d4c:b0:3a8:cb54:e132 with SMTP id
 98e67ed59e1d1-3acef148617mr1044399a91.49.1792191278140; 
 Fri, 16 Oct 2026 15:54:38 -0700 (PDT)
Received: from phoenix.local (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac94748c6csm11068001a91.10.2026.10.16.15.54.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 15:54:37 -0700 (PDT)
Date: Fri, 16 Oct 2026 15:54:35 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Cc: dev@dpdk.org, rjarry@redhat.com, mb@smartsharesystems.com,
 maxime@leroys.fr, konstantin.ananyev@huawei.com
Subject: Re: [RFC PATCH v2 0/7] VRF support in FIB library
Message-ID: <20261016155435.17225ba7@phoenix.local>
In-Reply-To: <20261014183921.495158-1-vladimir.medvedkin@intel.com>
References: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
 <20261014183921.495158-1-vladimir.medvedkin@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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

On Wed, 14 Oct 2026 18:39:14 +0000
Vladimir Medvedkin <vladimir.medvedkin@intel.com> wrote:

> This series adds multi-VRF support to the IPv4 FIB, allowing a single FIB
> instance to host multiple isolated routing tables.
> 
> Today a FIB instance is a single routing table, so an application serving
> several VRFs needs one FIB per VRF. In a burst oriented datapath packets of
> one burst can belong to different VRFs, and the application either does
> per-packet lookups in different FIBs or regroups the burst by VRF before
> the lookup. Both are expensive. With this series all the VRFs live in one
> FIB, the bulk lookup takes a VRF ID per address, and the existing API
> operates on VRF 0.
> 
> v1 replicated the 16M entry tbl24 per VRF. That kept the lookup on par with
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
> land in buckets with free room. Collisions are chosen deliberately, so they
> are not a security concern, but finding them has to be cheap. Toeplitz was
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
> other VRFs. Default routes are excluded, they map onto the per-VRF default
> next hop.
> 
> The two algorithms target different deployments. DIR8-16-8 fits a limited
> number of VRFs (tens to hundreds) carrying large tables, up to a BGP full
> view each. The hash based DIR-24-8 fits one large VRF alongside hundreds
> or thousands of small ones.
> 
> test-fib gets a VRF mode, including a profile with a full view in VRF 0 and
> smaller VRFs made of random subsets of it. The first three patches are fixes
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

The AI review feedback was interesting - not sure I agree.

On Wed, 14 Oct 2026 18:39 +0000
Vladimir Medvedkin <vladimir.medvedkin@intel.com> wrote:

Patches 1-3 are independent fixes and can go in ahead of the rest.

The VRF API is reasonable, but the series does not show a memory
saving over what applications do today, which is one rte_fib per VRF.
Pools and RIBs are still preallocated per VRF at worst case size.
Please include memory and lookup cycle numbers against N independent
DIR8_16_8 and 4B DIR24_8 FIBs for a realistic mix (one full view plus
many small VRFs, which --vrfconf already generates).

The hash based DIR24_8 (patch 7) is not safe with concurrent readers
and has no RCU support. Suggest dropping patches 6-7 from the next
version and going in with DIR8_16_8 VRF support first.

Series
------
Warning: per-VRF RIBs are sized for the whole FIB.
fib_create_ribs() creates every VRF RIB with max_nodes = 2 * max_routes
and the rib mempool is preallocated. With a full table max_routes this
dominates memory use and scales linearly with max_vrfs. Needs a
per-VRF route limit in rte_fib_conf, or RIB nodes from a shared pool.

[4/7] fib: add DIR8-16-8 algorithm
----------------------------------
Warning: memory cost is set by tbl16 group size, not the root table.
A tbl16 group is 65536 * 8 = 512 KB and a VRF consumes one for every
/8 it has a longer prefix in. A full view touches ~220 /8s, about
110 MB, same order as DIR24_8 with 8B next hops. The fib_lib.rst claim
that this suits a large number of VRFs only holds for VRFs touching
few /8s; say so in the guide.

Info: only 8 byte next hops are supported. A 4 byte entry variant
would halve the tbl16 cost.

Info: tbl_group_recycle() on a tbl16 group compares up to 65536
entries after every partial install. Sparse groups, the common VRF
case, rarely exit early.

[5/7] fib: add multi-VRF support
--------------------------------
Warning: the test-fib dump_lookup() IPv6 change
(&tbl6[i * 16] -> &tbl6[i]) fixes an out of bounds read unrelated to
VRF. Send it as a separate patch with Fixes: and Cc: stable@dpdk.org.

Warning: rte_fib_create() now allocates the dataplane and RIBs before
the duplicate name check. A duplicate fails in rte_rib_create() and
logs "Can not allocate RIBs". Keep the original order: take the tailq
lock, check the name, then allocate.

Info: new API should take const input:

	int rte_fib_vrf_lookup_bulk(struct rte_fib *fib,
		const uint16_t *vrf_ids, const uint32_t *ips,
		uint64_t *next_hops, int n);

Info: an out of range vrf_id reads past tbl0 (DIR8_16_8) or def_nh
(hash path). Fine not to check in the fast path, but add a debug
assert in the lookup functions:

	RTE_ASSERT(vrf_ids == NULL || vrf_ids[i] < dp->num_vrfs);

Info: in test-fib run_v4() the lpm_vrf_lookup_burst() branch of the
timed LPM loop leaves ret stale. Set ret = 0 on that branch.

Info: patch 7 reorders the rte_fib_create() error path and removes
comments added here. Settle both in this patch.

Info: "%p-v%u" RIB names and the "keep the name short" comment in
test_fib_perf.c work around the 32 byte memzone name limit, which
goes to 64 in 26.11. Derive readable names from the FIB name once
that lands.

[7/7] fib: add hash based VRF support for DIR24-8
-------------------------------------------------
Error: a lookup racing with an update can return another prefix's
next hop. ht_upsert() and ht_delete() reuse bucket slots in place.
A reader that matched key K in slot j can read val[j] after the
writer freed the slot and republished it for key K' (val then key),
returning K' next hop for a different VRF or prefix. ht_delete()
clears key then val, so the same window returns 0.

Error: node_move() switches the prefix ID in tbl24 and deletes the
old ID records immediately. A reader holding the old ID misses in the
hash and gets the VRF default. Relocation is driven by ordinary adds
(node_relocate_if_polarized(), record_upsert() eviction), so adding a
route can blackhole an unrelated prefix. remove_node() has the same
issue: a stale ID resolves to the default, not the covering route.

Both need deferred reclaim. rte_fib_rcu_qsbr_add() returns -ENOTSUP
in this mode; freed slots and retired prefix IDs need to go through
an rte_rcu_qsbr_dq and be reused only after a grace period.

Warning: the hash table is sized for the worst case,
max_routes * max_vrfs * 2 records at 16 bytes, i.e. 32 bytes per
route per VRF. At max_routes = 2M that is 64 MB per VRF, the same as
replicating a 4B DIR24_8 per VRF, so the shared tbl24 saves nothing.
Past the 2^24 bucket cap (2 GB) adds fail with -ENOSPC and nothing
warns at create time. Make the record count configurable and reject
values above the cap in rte_fib_create():

	struct {
		enum rte_fib_dir24_8_nh_sz nh_sz;
		uint32_t num_tbl8;
		uint32_t num_vrf_records; /* 0: derive from max_routes */
	} dir24_8;

Warning: inherited records are not bounded by a VRF's own routes.
A VRF holding a covering /8 gets one record for every prefix any other
VRF has below it. Document this next to the sizing parameter.

Info: pid_alloc() for single VRF prefixes always scans from bucket 0,
so adds slow down as the low buckets fill.

Info: -mvpclmulqdq is added to cflags_avx512 for every AVX512 source
in lib/fib; only fib_vrf_avx512.c needs it.

Info: fib_vrf.c is ~1250 lines of CRC inversion placement, polarized
bucket tracking and eviction. That maintenance cost needs the numbers
above to justify it.
