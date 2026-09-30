Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3D05CA5FC5
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Sep 2026 22:43:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD74B40289;
	Thu,  1 Oct 2026 00:43:45 +0200 (CEST)
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by mails.dpdk.org (Postfix) with ESMTP id CE43540262
 for <dev@dpdk.org>; Thu,  1 Oct 2026 00:43:43 +0200 (CEST)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-39dacf053eeso3027759a91.2
 for <dev@dpdk.org>; Wed, 30 Sep 2026 15:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790808223;
 x=1791413023; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RIHe/f6XVxz9U4zvUk6v8zpa/j89Hk+WP/nib2/jfbE=;
 b=EViMuTLmR3krXuGzswvBGEDRvaT7MAKxrsGZDbaUvz1oa4zn4OHNPj7zCRcDTBFOMC
 GPTYdDV6J8Jzu/vMBsR/pDhAw5ju6DSd0D7+WvVrws/lSKnsy5aaAuXdxEZxb7rbLTKZ
 KoMBPmcyavqDhRIiIGjZfP0smywAPNjQLPsnO2zaDCFpEetFTYaC6AamSu2gAQJFzzXy
 VMmv38mPMADTCnJWO1H6K+d4wZlXT56pVdF4RIXYLu16C7RFuURHfwYNWmjHH6vTg9Sj
 FaDSCmAUcl/G5CAV1F1bI/JINYduftn3mXSCNgCZFdjEPn0vMXBSZq7JkhMVaA43J6nN
 yYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790808223; x=1791413023;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=RIHe/f6XVxz9U4zvUk6v8zpa/j89Hk+WP/nib2/jfbE=;
 b=GBUMDGe95tudJmHEzrVzt+1SlMkMDfUYrGU4dDm6qAHQb1v8nw6QEHMl0eIaQxs48s
 WvxwTGghAI3kCeKl4w18CRuEL0OpEplWayZBs+FYssBvtAWrDS0Ep91bkrR2UAQIgfE3
 lPC+xm2ahsfx/2uZ+byGR1NC+poDg4TiQMKDvMA/E33MuZCC/EmdN/LLHhtb7x5ambXp
 5/n5yVNT2xJgQY3Rg8v6tsPBmiq6Su1eVS43z+no6VJWKreeElFG0WnAin+6aUNtGXIm
 vvEnf+QCK/ggf9o0Mccq8zjDaw4q4UP1tsry8lQ1tjUKNxH0W9rjJUuGbUqXc4qWu+1Q
 EyPA==
X-Gm-Message-State: AFq9FYLYbJEfSvO6j62TiSZJRNGreww6iFbar3NT5dMJaALjPfMrW7An
 wSmrjkArCJlOmGYKC0UHDt2qFijYdR7SZRlQvGv596n4fq0Ssg22vS3oEDCKmxiGxAuaiUy+Y2S
 t3CylaxI=
X-Gm-Gg: AYBFou3+Kyop7Yrp8GgtUdGwyk/xfXDBgbrui1q4CjaIpg8ppSbo5vCystNQZvUjZbr
 hXB8rGGE9Yt1q8YXKBWNyCtmqo0H6PfZt6oH0cLmFQ8GfvSyGlReTR5drmLrkU+p2W8HN6KZQlx
 wI7OCTanYBWfrdYmCWzhemzGie/P2bmAee+xbFyCJZRQs0/B7VK3yDycNKiujcLj72+1e/c5GkZ
 hhrS6kQ262GZ4XHfsW1+IXngf6T+HLCZjC92bWuLCYkHL9qwFqQxaQWTWdh7sCRI/bxbr5RKU5O
 itVbNc2dTbQ/7DAmP4YITwBVqOtXo1wKrR4GCxurC63t2sk6L3/CUo0bDWu9EcELFmtCLguZCsr
 QUffKO3/JDbbwkgB4Pkhh4vKmGcmxM9396t1zjYRC7Ou8ShFNgv100HwZpDX+nwUxfTXrebKLXP
 kR4eZYw42oenSzuEOfKa5x5xbfoCLY7dnw4opcHC3c+n8vF4mpzqanDqFYAQVjZFE/NOVCWh/HE
 fJtG2rtNqk3LRBxyx3MFsqlwjBPd/Da4xNHuABLHEVSDa9B
X-Received: by 2002:a17:90b:28d0:b0:3a4:fe48:d412 with SMTP id
 98e67ed59e1d1-3a4fe48e5eamr82727a91.30.1790808222580; 
 Wed, 30 Sep 2026 15:43:42 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4f4371383sm1258985a91.2.2026.09.30.15.43.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 15:43:42 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 00/65] kvargs: add numeric conversion helpers
Date: Wed, 30 Sep 2026 15:40:18 -0700
Message-ID: <20260930224340.58580-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260914054912.755403-1-stephen@networkplumber.org>
References: <20260914054912.755403-1-stephen@networkplumber.org>
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

Almost every driver parses numeric device arguments with its own
code, and most get some part of it wrong: atoi() does not detect
invalid input, errno is checked without being cleared, the end
pointer is ignored, the value is truncated before it is range
checked, or base 0 turns a leading zero into octal.

This series adds range checked converters and ready made
rte_kvargs_process() handlers to librte_kvargs, then converts the drivers.

Patch 1 is a type fix to drivers/net/ring so that it can
use helper for socket id.

Library (patches 2 to 4)
------------------------

  rte_kvargs_to_uint/to_int/to_hex     convert with an explicit range

  rte_kvargs_handle_u8/u16/u32/u64     store into a typed variable
  rte_kvargs_handle_i8/i16/i32/i64
  rte_kvargs_handle_uint/int/long/ulong/size

  rte_kvargs_handle_bool               1/y/yes/on/true and negatives,
                                       bare key means true
  rte_kvargs_handle_socket_id          -1 (SOCKET_ID_ANY) through
                                       RTE_MAX_NUMA_NODES - 1
  rte_kvargs_handle_hex32/hex64        bare hex mask, 0x optional
  rte_kvargs_handle_urange/irange      caller supplied bounds

Values are decimal or 0x hexadecimal, no octal, no negative value for
an unsigned type, no trailing garbage.
The handlers log key, value, and expected range on failure.
Unit tests cover all of them.

The new api's are marked experimental for 26.11.

Drivers (patches 6 to 61)
-------------------------

52 drivers converted. Local handlers that only did a range checked
store are deleted, 40 of them.

The af_xdp conversion (patch 17) goes further than the rest.
With some changes to types, like queue and indexes converted
to uint16_t, the local handlers can be replaced by helpers.
Likewise boolean flags can be bool instead of int.

There are some cases not covered easily by kvargs helpers, where the
driver parses a list, or does more with the value than store it.

Range handlers (patches 63 to 65)
---------------------------------

An argument whose range is narrower than its type still needed a local
handler, about 25 of them, and 22 of those rejected a bad value without
logging anything. The new handlers take the bounds from the caller, so
these report like the typed ones do.

event/sw and net/cnxk are converted, 9 more handlers deleted.

Behaviour changes
-----------------

  - malformed, out of range and wrapped values now fail probe with a
    message instead of being silently misread
  - a leading zero is decimal, not octal
  - boolean arguments accept on/off/yes/no/true/false and reject
    anything else, including numbers other than 0 and 1
  - socket IDs are checked at both ends (dlb2 accepted
    RTE_MAX_NUMA_NODES, turbo_sw and bbdev_null accepted negatives)
  - the four bare hex masks (ice hw_debug_mask, hns3 dev_caps_mask,
    cxgbe filtermode/filtermask, ark Pkt_dir) keep their syntax

v3 - add range helper
   - declutter the AI generated comments

Stephen Hemminger (65):
  net/ring: make numa node signed
  kvargs: add numeric conversion helpers
  kvargs: add a socket ID handler
  kvargs: add hexadecimal conversion helpers
  eal: validate memory size arguments
  net/null: use kvargs numeric helpers
  net/vhost: use kvargs numeric helpers
  vdpa/ifc: use kvargs numeric helpers
  net/softnic: use kvargs numeric helpers
  dma/skeleton: use kvargs numeric helpers
  raw/skeleton: use kvargs numeric helpers
  baseband/null: use kvargs numeric helpers
  net/memif: use kvargs numeric helpers
  net/af_packet: use kvargs numeric helpers
  net/pcap: use kvargs numeric helpers
  net/ring: use kvargs numeric helpers
  net/af_xdp: use kvargs numeric helpers
  net/ark: use kvargs numeric helpers
  net/failsafe: use kvargs numeric helpers
  net/virtio: use kvargs numeric helpers
  net/bonding: use kvargs numeric helpers
  net/ena: use kvargs numeric helpers
  net/netvsc: use kvargs numeric helpers
  net/ice: use kvargs numeric helpers
  net/iavf: use kvargs numeric helpers
  net/i40e: use kvargs numeric helpers
  net/idpf: use kvargs numeric helpers
  net/cpfl: use kvargs numeric helpers
  net/ixgbe: use kvargs numeric helpers
  net/txgbe: use kvargs numeric helpers
  net/octeontx: use kvargs numeric helpers
  net/octeon_ep: use kvargs numeric helpers
  net/qede: use kvargs numeric helpers
  net/nfb: use kvargs numeric helpers
  net/thunderx: use kvargs numeric helpers
  net/i40e: propagate VF queue number parse errors
  net/cnxk: use kvargs numeric helpers
  net/xsc: use kvargs numeric helpers
  net/hns3: use kvargs numeric helpers
  net/enetc: use kvargs numeric helpers
  event/dlb2: use kvargs numeric helpers
  net/nfp: use kvargs numeric helpers
  drivers/crypto: use kvargs numeric helpers
  event/sw: use kvargs numeric helpers
  net/bnxt: use kvargs numeric helpers
  net/bnxt: propagate devargs parsing errors
  net/mlx4: use kvargs numeric helpers
  net/sfc: use kvargs numeric helpers
  crypto/mvsam: use kvargs numeric helpers
  ml/cnxk: use kvargs numeric helpers in cn10k
  ml/cnxk: use kvargs numeric helpers in mvtvm
  event/opdl: use kvargs numeric helpers
  mempool/cnxk: use kvargs numeric helpers
  event/octeontx: use kvargs numeric helpers
  baseband/turbo_sw: use kvargs numeric helpers
  baseband/la12xx: use kvargs numeric helpers
  dma/hisi_acc: use kvargs numeric helpers
  crypto/virtio: use kvargs numeric helpers
  net/ice: use kvargs hex helper for debug mask
  net/hns3: use kvargs hex helper for capability mask
  net/cxgbe: use kvargs numeric helpers
  kvargs: add range conversion handlers
  event/sw: use kvargs range handlers
  net/cnxk: use kvargs range handlers
  doc: note kvargs devargs conversion in release notes

 app/test/test_kvargs.c                        | 340 ++++++++++
 doc/guides/eventdevs/dlb2.rst                 |   4 +-
 doc/guides/nics/null.rst                      |   2 +-
 doc/guides/prog_guide/devargs.rst             |  18 +
 doc/guides/rel_notes/release_26_11.rst        |  57 ++
 drivers/baseband/la12xx/bbdev_la12xx.c        |  60 +-
 drivers/baseband/null/bbdev_null.c            |  29 +-
 .../baseband/turbo_sw/bbdev_turbo_software.c  |  29 +-
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c   |  15 +-
 drivers/crypto/dpaa_sec/dpaa_sec.c            |  17 +-
 drivers/crypto/mvsam/rte_mrvl_pmd.c           |  22 +-
 drivers/crypto/virtio/virtio_user_cryptodev.c |  21 +-
 drivers/dma/hisi_acc/hisi_acc_dmadev.c        |   5 +-
 drivers/dma/skeleton/skeleton_dmadev.c        |  23 +-
 drivers/event/dlb2/dlb2.c                     | 127 +---
 drivers/event/octeontx/ssovf_evdev.c          |  25 +-
 drivers/event/opdl/opdl_evdev.c               |  49 +-
 drivers/event/sw/sw_evdev.c                   | 107 +---
 drivers/mempool/cnxk/cnxk_mempool.c           |  37 +-
 drivers/ml/cnxk/cn10k_ml_dev.c                |  74 +--
 drivers/ml/cnxk/cn10k_ml_dev.h                |   8 +-
 drivers/ml/cnxk/cn10k_ml_ops.c                |   2 +-
 drivers/ml/cnxk/mvtvm_ml_dev.c                |  47 +-
 drivers/ml/cnxk/mvtvm_ml_dev.h                |   2 +-
 drivers/net/af_packet/rte_eth_af_packet.c     |  72 +--
 drivers/net/af_xdp/rte_eth_af_xdp.c           | 431 ++++++-------
 drivers/net/ark/ark_ethdev.c                  |   4 +-
 drivers/net/bnxt/bnxt_ethdev.c                | 148 ++---
 drivers/net/bonding/eth_bond_private.h        |   8 -
 drivers/net/bonding/rte_eth_bond_args.c       |  71 +-
 drivers/net/bonding/rte_eth_bond_pmd.c        |   8 +-
 drivers/net/cnxk/cnxk_ethdev_devargs.c        | 353 +++-------
 drivers/net/cxgbe/cxgbe_main.c                |  38 +-
 drivers/net/ena/ena_ethdev.c                  |  45 +-
 drivers/net/enetc/enetc4_vf.c                 |  22 +-
 drivers/net/failsafe/failsafe_args.c          |  20 +-
 drivers/net/hns3/hns3_common.c                |  23 +-
 drivers/net/hns3/hns3_common.h                |   3 -
 drivers/net/intel/cpfl/cpfl_ethdev.c          |  26 +-
 drivers/net/intel/i40e/i40e_ethdev.c          |  57 +-
 drivers/net/intel/iavf/iavf.h                 |   6 +-
 drivers/net/intel/iavf/iavf_ethdev.c          |  55 +-
 drivers/net/intel/ice/ice_ethdev.c            | 123 +---
 drivers/net/intel/ice/ice_ethdev.h            |  10 +-
 drivers/net/intel/idpf/idpf_ethdev.c          |  26 +-
 drivers/net/intel/ixgbe/ixgbe_ethdev.c        |  40 +-
 drivers/net/intel/ixgbe/ixgbe_ethdev.h        |   4 +-
 drivers/net/memif/rte_eth_memif.c             |  73 +--
 drivers/net/mlx4/mlx4.c                       |  33 +-
 drivers/net/netvsc/hn_ethdev.c                |   6 +-
 drivers/net/nfb/nfb_ethdev.c                  |  13 +-
 drivers/net/nfp/nfp_ethdev.c                  |  36 +-
 drivers/net/null/rte_eth_null.c               |  78 +--
 drivers/net/octeon_ep/otx_ep_ethdev.c         |  16 +-
 drivers/net/octeontx/octeontx_ethdev.c        |  18 +-
 drivers/net/pcap/pcap_ethdev.c                |  51 +-
 drivers/net/qede/qede_ethdev.c                |  55 +-
 drivers/net/ring/rte_eth_ring.c               |  59 +-
 drivers/net/ring/rte_eth_ring.h               |  11 +-
 drivers/net/sfc/sfc.c                         |   2 +-
 drivers/net/sfc/sfc_kvargs.c                  |  19 -
 drivers/net/sfc/sfc_kvargs.h                  |   2 -
 drivers/net/sfc/sfc_port.c                    |   2 +-
 drivers/net/softnic/rte_eth_softnic.c         |  30 +-
 .../net/softnic/rte_eth_softnic_internals.h   |   3 +-
 drivers/net/thunderx/nicvf_ethdev.c           |  13 +-
 drivers/net/txgbe/txgbe_ethdev.c              |  97 ++-
 drivers/net/vhost/rte_eth_vhost.c             |  69 +-
 drivers/net/virtio/virtio_ethdev.c            |  36 +-
 drivers/net/virtio/virtio_user_ethdev.c       |  59 +-
 drivers/net/xsc/xsc_dev.c                     |  50 +-
 drivers/raw/skeleton/skeleton_rawdev.c        |  20 +-
 drivers/vdpa/ifc/ifcvf_vdpa.c                 |  29 +-
 lib/eal/common/eal_common_options.c           |  27 +-
 lib/kvargs/rte_kvargs.c                       | 604 ++++++++++++++++++
 lib/kvargs/rte_kvargs.h                       | 314 +++++++++
 76 files changed, 2371 insertions(+), 2167 deletions(-)

-- 
2.53.0

