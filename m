Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4DECC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 18:39:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5C73402A4;
	Wed, 14 Oct 2026 20:39:26 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id D6CA14025A
 for <dev@dpdk.org>; Wed, 14 Oct 2026 20:39:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792003166; x=1823539166;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1KtKJV8M0vTtlh2Oek4uaz2tSWUUP6vD+lSlueUdClY=;
 b=RTtKtqafEAIg5+YTAE8G9OzZI8LG0kypQOXm4BlR1k2XVshfj171mW11
 71n7MWvz6ZBhw7FKo5zbSQU5vcVgEzEgxvX+Hi+ecv7yqbeXsRLZ9UoYf
 xkjZKlx06TgWyx1D5akEwHn7WYDQCrkdWtJSBa0tqBY0ebvspaF0beKpb
 lbzaWB2HNQTP60NJUBRS/UWYOiM6TJgbd6MOJAtZH7F8T3prMHurEfMHu
 JgFf0PjZQ1WUgIY+9L7I7ZF2vQEYEqbPbodXRYEaeRASQ53sHceOR+7Z+
 XAZ/NpVkja8u48T82QBiG4HbSx6Z9MiREptpwQ94q1YdPXv/5sSX0RQah g==;
X-CSE-ConnectionGUID: ypdk87fpQ8uIOClV7Tp1pg==
X-CSE-MsgGUID: 59yxdvLCSVWsOA02qV9O6w==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="753342"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="753342"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 11:39:24 -0700
X-CSE-ConnectionGUID: LqRqUKuQTOSwuDYtGhk8VQ==
X-CSE-MsgGUID: KtXkiYVISKuAmKtNnFFfRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="1419834"
Received: from silpixa00401176.ir.intel.com ([10.20.224.212])
 by orviesa009.jf.intel.com with ESMTP; 14 Oct 2026 11:39:24 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: rjarry@redhat.com, mb@smartsharesystems.com, maxime@leroys.fr,
 konstantin.ananyev@huawei.com
Subject: [RFC PATCH v2 0/7] VRF support in FIB library
Date: Wed, 14 Oct 2026 18:39:14 +0000
Message-ID: <20261014183921.495158-1-vladimir.medvedkin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
References: <20260322154215.3686528-1-vladimir.medvedkin@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

This series adds multi-VRF support to the IPv4 FIB, allowing a single FIB
instance to host multiple isolated routing tables.

Today a FIB instance is a single routing table, so an application serving
several VRFs needs one FIB per VRF. In a burst oriented datapath packets of
one burst can belong to different VRFs, and the application either does
per-packet lookups in different FIBs or regroups the burst by VRF before
the lookup. Both are expensive. With this series all the VRFs live in one
FIB, the bulk lookup takes a VRF ID per address, and the existing API
operates on VRF 0.

v1 replicated the 16M entry tbl24 per VRF. That kept the lookup on par with
the single VRF case, but memory grew linearly with the number of VRFs,
which was the main concern raised on v1. v2 resolves the issue by adding
of two dataplane algorithms with different memory/lookup trade-offs.

DIR8-16-8 is a new three level variant of DIR-24-8 with 8, 16 and 8 bit
strides. Only the 256 entry root table (2 KB) is replicated per VRF; the
tbl16 and tbl8 groups come from pools shared by all the VRFs, so memory
follows the routes actually installed rather than the number of VRFs. The
cost is an extra memory access for prefixes longer than /8.

DIR-24-8 gets multi-VRF support by resolving the VRF after the longest
prefix match, along the lines Konstantin suggested on v1. Instead of a
vector of next hops per prefix, a single tbl24_8 shared by all the VRFs
returns an internal prefix ID, and a hash table keyed by {VRF, prefix ID}
returns the next hop, a miss meaning the VRF default next hop. The aim is
to resolve the VRF with a single memory access, so buckets hold 8 records
and there is no probing beyond the bucket.

Such a table only works if the control path can keep buckets from
overflowing while the hash stays cheap on the datapath. Since the prefix
ID is internal, the library can pick it so that the records of a prefix
land in buckets with free room. Collisions are chosen deliberately, so they
are not a security concern, but finding them has to be cheap. Toeplitz was
the first candidate: its structure is well studied and the thash library
already knows how to find collisions, but it is only fast with GFNI. CRC
has the same linear properties, is trivially inverted and is hardware
accelerated on x86 and Arm, so CRC32C is used. Linearity also places the
buckets of one prefix in different VRFs at fixed XOR offsets from each
other, so a candidate prefix ID is checked for all the VRFs referencing
the prefix at once, and these records never share a bucket. If a bucket
fills up anyway, a prefix already in it is renumbered to make room.

The price of the shared table is paid on the control path: a route in one
VRF needs a record for every more specific prefix installed below it by
other VRFs. Default routes are excluded, they map onto the per-VRF default
next hop.

The two algorithms target different deployments. DIR8-16-8 fits a limited
number of VRFs (tens to hundreds) carrying large tables, up to a BGP full
view each. The hash based DIR-24-8 fits one large VRF alongside hundreds
or thousands of small ones.

test-fib gets a VRF mode, including a profile with a full view in VRF 0 and
smaller VRFs made of random subsets of it. The first three patches are fixes
found along the way and are independent of the rest.

Not done yet:
- IPv6. The VRF bookkeeping of the hash based scheme is address family
  agnostic and is meant to be reused by TRIE.
- RCU support for multi-VRF DIR-24-8.

Vladimir Medvedkin (7):
  fib: fix return value of a nexthop update
  app/test-fib: fix lookup of the last burst
  app/test-fib: fix size of the tables for large counts
  fib: add DIR8-16-8 algorithm
  fib: add multi-VRF support
  fib: split DIR24-8 table update from the FIB wrapper
  fib: add hash based VRF support for DIR24-8

 app/test-fib/main.c                    |  673 ++++++++++---
 app/test/test_fib.c                    | 1001 ++++++++++++++++++-
 app/test/test_fib_perf.c               |  440 +++------
 app/test/test_fib_routes.h             |  282 ++++++
 doc/guides/prog_guide/fib_lib.rst      |   66 ++
 doc/guides/rel_notes/release_26_11.rst |   21 +
 lib/fib/dir24_8.c                      |   34 +-
 lib/fib/dir24_8.h                      |   43 +-
 lib/fib/dir24_8_avx512.c               |   18 +-
 lib/fib/dir24_8_avx512.h               |   32 +-
 lib/fib/dir24_8_rvv.c                  |    3 +-
 lib/fib/dir24_8_rvv.h                  |   16 +-
 lib/fib/dir24_8_vrf.c                  |  290 ++++++
 lib/fib/dir24_8_vrf.h                  |   60 ++
 lib/fib/dir8_16_8.c                    |  665 +++++++++++++
 lib/fib/dir8_16_8.h                    |  192 ++++
 lib/fib/dir8_16_8_avx512.c             |  183 ++++
 lib/fib/dir8_16_8_avx512.h             |   24 +
 lib/fib/fib_vrf.c                      | 1256 ++++++++++++++++++++++++
 lib/fib/fib_vrf.h                      |  277 ++++++
 lib/fib/fib_vrf_avx512.c               |  142 +++
 lib/fib/meson.build                    |   22 +-
 lib/fib/rte_fib.c                      |  249 ++++-
 lib/fib/rte_fib.h                      |  127 ++-
 24 files changed, 5593 insertions(+), 523 deletions(-)
 create mode 100644 app/test/test_fib_routes.h
 create mode 100644 lib/fib/dir24_8_vrf.c
 create mode 100644 lib/fib/dir24_8_vrf.h
 create mode 100644 lib/fib/dir8_16_8.c
 create mode 100644 lib/fib/dir8_16_8.h
 create mode 100644 lib/fib/dir8_16_8_avx512.c
 create mode 100644 lib/fib/dir8_16_8_avx512.h
 create mode 100644 lib/fib/fib_vrf.c
 create mode 100644 lib/fib/fib_vrf.h
 create mode 100644 lib/fib/fib_vrf_avx512.c

-- 
2.43.0

