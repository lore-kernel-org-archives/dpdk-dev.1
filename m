Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4533ECD3427
	for <dpdk-dev@archiver.kernel.org>; Mon,  4 May 2026 16:21:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02CF5402BC;
	Mon,  4 May 2026 18:21:50 +0200 (CEST)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181]) by mails.dpdk.org (Postfix) with ESMTP id A0BF6402B2
 for <dev@dpdk.org>; Mon,  4 May 2026 18:21:48 +0200 (CEST)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-2ee990e8597so3916330eec.1
 for <dev@dpdk.org>; Mon, 04 May 2026 09:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1777911707;
 x=1778516507; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VFuBLEeiCZf9BJa/Agr5HNXhyaLy1rYI3ybVfO6X+QQ=;
 b=FClAfU4NrAaiPD6c+yw8N/BzVA2FWFIT2xcGy57XLdrtSEMYPQXpk0ry23Jtom2DNJ
 qsOvKbdnwoSSu5k3SAip5ATpX9m8O/u3+SG896YaFIxeNI27R4hXeKQoCmaIkn3i3Oyp
 MoeIzR9sTaUKlviJ+9zOyGwVMn+haq9Vd71GLioN6Dtq+7PGwlFV8yGOpDdQxSyg503g
 rq2D4KtRFDiuSG9Mn5KeazkFfydIithSlrs2LjnquisiEzXzuu0csdu3XHtYRKNz676D
 qIPvbsQyr2mG4TaPzk7Pna4GiYMhemnPMjYX4d5PrAEO9qke+pgu43/YWdnpG1ctsf7/
 wpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777911707; x=1778516507;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VFuBLEeiCZf9BJa/Agr5HNXhyaLy1rYI3ybVfO6X+QQ=;
 b=DKHHy9aKPCQf75sCcsjlT9hwq+QEpZHf+j84M7bov4qhV3BJFMUhrlwrxlDRckQ4aA
 ORc0ThF8AtPgI3AEM8Vx5n+L8rAE9/1DerK93lzj+DGPyNXw/Z2DbY5wNWCKJ+o5llxn
 NmPFr3ni5xPoQmkFY1oYsDUZNxHCpDvoWCgG4Pxln4wNkUNU4OqCPxIumvdYUiwj26oc
 ViQOs5K94vV+o0R91PARoCmJ7LHPxUyS+OaX13kwtthWHMvRkjhuqYH8gxm3mGoO8Bll
 fH2jJKGaZwmqjh2qyFgNr4Szl+iX33M8p3uhbYmIe4Pbh1qvap8phHj7xFp9OHszsMp7
 LZrg==
X-Gm-Message-State: AOJu0YxzPGEL6DJ6VZkEYbsfJ+FMsS9spsWE6sixoGeUX6wcSnJLNPip
 ouP6TbK97tE0wLgpoe8Gltfu4gb9lx/w7an3db9dRc09M98HLiIiHaZmVi+6EgrqVbE=
X-Gm-Gg: AeBDieughPA3DvmGKgvrvnS/EpaSJ/2ffzDvkF/v1ZnjD9GM4KFP2Fbm84+TFyOPAjG
 BysGddJBJtHsWC/I6EMGoSoFP7L7D3yQZfOSH40pLqMB867IEkmFwO1qbH7DmqCr34DL0JquXe/
 7P0E4/XgLYvzn+A3OwCRPLp4J4zcI7OmcwT7FauRfGuhuaZP1UDBDRyX66R7ybAW74AOZpd5xO6
 BZXCJ44AwoeBO58r7xe6KWTJILgXthkV25VHbRr3riB2eqrNRs3rnBAeAVFG2l9R+O2TP03Dp7W
 ZpzEMoQTHQqyeqyDRDe8Uycml3Lzq0xSjAnY8VJHxXWm8bJQl3Qa9b2dnVEOGXeIpS57RUID8oh
 U80xrZdpxebirDDRwCNIQ26BFdNMlq66DVxPyaGMTJys57nB+7kXR+SSMombNeECRdW6DKrvt4D
 HMbMkFePYLomhqYerHRP3j+dkbSS6zHCCXFpvJm5cMdqc8bQ==
X-Received: by 2002:a05:7300:e8a3:b0:2e5:8ec2:82c9 with SMTP id
 5a478bee46e88-2efbb28fb53mr5001520eec.26.1777911707249; 
 Mon, 04 May 2026 09:21:47 -0700 (PDT)
Received: from phoenix.local ([104.202.41.210])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ee38e71b61sm16376879eec.12.2026.05.04.09.21.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 09:21:47 -0700 (PDT)
Date: Mon, 4 May 2026 09:21:44 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: sunyuechi <sunyuechi@iscas.ac.cn>
Cc: dev@dpdk.org, Zijian <zijian.oerv@isrc.iscas.ac.cn>, =?UTF-8?B?U3Rh?=
 =?UTF-8?B?bmlzxYJhdw==?= Kardach <stanislaw.kardach@gmail.com>, Nithin
 Dabilpuram <ndabilpuram@marvell.com>, Pavan Nikhilesh
 <pbhagavatula@marvell.com>, Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [PATCH v3] node: lookup with RISC-V vector extension
Message-ID: <20260504092144.63974943@phoenix.local>
In-Reply-To: <2bd9229f-c57f-415f-9929-9e10864e312f@iscas.ac.cn>
References: <20260206081635.1409106-1-sunyuechi@iscas.ac.cn>
 <2bd9229f-c57f-415f-9929-9e10864e312f@iscas.ac.cn>
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

On Sat, 28 Mar 2026 21:53:27 +0800
sunyuechi <sunyuechi@iscas.ac.cn> wrote:

> On 2/6/26 4:16 PM, Sun Yuechi wrote:
> 
> > Implement ip4_lookup_node_process_vec function for RISC-V architecture
> > using RISC-V Vector Extension instruction set
> >
> > Signed-off-by: Sun Yuechi <sunyuechi@iscas.ac.cn>
> > Signed-off-by: Zijian <zijian.oerv@isrc.iscas.ac.cn>
> > ---
> >   doc/guides/rel_notes/release_26_03.rst |   4 +
> >   lib/eal/riscv/include/rte_vect.h       |   2 +-
> >   lib/node/ip4_lookup.c                  |   5 +-
> >   lib/node/ip4_lookup_rvv.h              | 167 +++++++++++++++++++++++++
> >   4 files changed, 176 insertions(+), 2 deletions(-)
> >   create mode 100644 lib/node/ip4_lookup_rvv.h  
> 
> ping
> 

There as no ack yet.
Ran it through AI for review and it had lots of feedback.
The only item worth noting is the naming of rte_lpm_lookup_vec
which should match other arch.
---


This series adds RISC-V Vector Extension (RVV) support to the IPv4 LPM
lookup node.  Patch 1/2 is a clean one-liner enabling the default SIMD
bitwidth on RISC-V; cross-checked against the arm/ppc/x86 conventions
in lib/eal/*/include/rte_vect.h, the change is correct and consistent
with how those architectures handle the same define.  No findings on
patch 1/2.

Findings on patch 2/2 below.


[PATCH v4 2/2] node: lookup with RISC-V vector extension
========================================================

Warnings
--------

* lib/node/ip4_lookup_rvv.h:14: the static inline helper is named
  rte_lpm_lookup_vec().  The rte_lpm_* prefix is reserved for the LPM
  library's API namespace (see lib/lpm/rte_lpm*.h).  Defining a static
  inline with that prefix in a node-library private header is
  misleading -- it implies a public LPM API where there is none.

  For comparison, the SVE bulk lookup at lib/lpm/rte_lpm_sve.h:16 uses
  __rte_lpm_lookup_vec (double underscore, internal) and lives in the
  LPM library proper, exposed through rte_lpm.h's #undef/#define
  rte_lpm_lookup_bulk override.  The NEON and SSE node paths
  (lib/node/ip4_lookup_neon.h:114, lib/node/ip4_lookup_sse.h:116) do
  not define their own helpers at all -- they call the public
  rte_lpm_lookupx4() from the LPM library.

  Other static helpers in lib/node/ use the node_* prefix
  (e.g. node_mbuf_priv1, node_mbuf_priv2 in lib/node/node_private.h).

  Two suggested options, in order of preference:

  1. Move the bulk lookup into lib/lpm/rte_lpm_rvv.h as
     __rte_lpm_lookup_vec() with the same signature pattern as the SVE
     version, and have lib/lpm/rte_lpm.h conditionally override
     rte_lpm_lookup_bulk for the RVV case.  The node path then becomes
     a plain rte_lpm_lookup_bulk() call and the implementation is
     reusable by other consumers (FIB, l3fwd, etc.).

  2. Keep the helper local to the node header but rename it -- e.g.
     ip4_lookup_rvv_lpm_lookup() or just lpm_lookup_vec() -- so it
     does not occupy the rte_lpm_* namespace.

Info
----

* lib/node/ip4_lookup_rvv.h: unlike ip4_lookup_neon.h, the RVV path
  does no prefetching of upcoming mbufs or packet headers.  NEON
  prefetches both the next-line of objs[] and the next four packets'
  L3 headers.  On RISC-V cores with hardware prefetchers this may be
  a wash, but on cores without one the per-iteration vl-wide gather
  over pkts[i] and the IPv4 header reads may stall.  Worth measuring.

* lib/node/ip4_lookup_rvv.h: the per-mbuf metadata is written in two
  passes -- cksum/ttl in the first loop, nh in the second.  The NEON
  path packs all three into a uint64_t and writes once via
  node_mbuf_priv1(mbuf, dyn)->u = ...; (the overload struct is laid
  out as { uint16_t nh; uint16_t ttl; uint32_t cksum; } in
  rte_node_mbuf_dynfield.h:48).  A single 64-bit store per mbuf would
  halve the store traffic to the dynfield region.

* The release-notes entry is correctly placed under "New Features".
  Consider mentioning the dependency on RTE_RISCV_FEATURE_V (i.e.
  that this only activates when toolchain/-march reports the V
  extension), so users on non-V RISC-V builds know why they don't
  see a perf change.


Notes from cross-checking (no action needed)
--------------------------------------------

- The bswap32_vec() open-coded byte reversal is correct for the
  little-endian RISC-V configuration DPDK targets (rte_byteorder.h
  defines RTE_BYTE_ORDER == RTE_LITTLE_ENDIAN unconditionally for
  riscv).

- The byte-offset arithmetic for vluxei32 into tbl24 and tbl8 matches
  the scalar lookup in lib/lpm/rte_lpm.h:295-320 (entry index *
  sizeof(uint32_t) via <<2; tbl8 group_idx * 256 + ip_low).  The
  static_assert at rte_lpm.h:121 guarantees
  sizeof(rte_lpm_tbl_entry) == 4.

- The mu (mask-undisturbed) policy on the second vluxei32 correctly
  mirrors the scalar's "only follow tbl8 when VALID_EXT bit is set",
  and per the V spec masked-off elements raise no exceptions, so the
  unconditional pre-computation of vtbl8_index for masked-off lanes
  is safe even when those lanes contain garbage offsets.

- vbool4_t is the correct mask type for SEW=32, LMUL=8 (ratio 4).

- RVV_MAX_BURST=64 with the outer `while (n_left_from > 0)` loop
  correctly chunks the full nb_objs (up to RTE_GRAPH_BURST_SIZE=256)
  through repeated vsetvl calls.

- The miss-counting heuristic `(res[i] >> 16) == (drop_nh >> 16)`
  matches what NEON does at lib/node/ip4_lookup_neon.h:117-120; it
  diverges from the scalar's "rc != 0" only when a user's LPM table
  legitimately resolves to the drop next-node, which is the same
  behavior already present in the existing vector paths.
