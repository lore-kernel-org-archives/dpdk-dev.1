Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A6EC88E50
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 05:49:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7DCF402A2;
	Mon, 14 Sep 2026 07:49:25 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id 0F44740288
 for <dev@dpdk.org>; Mon, 14 Sep 2026 07:49:23 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc1cea4bfd1so1187234a12.0
 for <dev@dpdk.org>; Sun, 13 Sep 2026 22:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789364963;
 x=1789969763; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=PeaW+VFGuf5Y5g4vlyUoy4dkqCLFL8oEDLPIFdnyKfo=;
 b=qgI7yMrSt1vCCt2jZyVbRGJ0bOlM0zJdQK6qYTGKBj9orzVM0e7kYppU0Ja2rDwSc7
 k1ZitlOyXxrZxFgNve2InM+Zs64dfpKdUwMzvun3D8JGXrdmwHRLfs9qK2Pkg05G3DNg
 EPa7pGMN5NmWnZGTetj8yJzXkrktF/RplFgVQv0Z6jpRos5J8kPd3ZT6mBsBYxFkxOwt
 naUtcu0/s2d0V4rpIWMvsVyb5hP+XaSr19hpZAOlTRIJ5HoWa7zr+HdhM9rq07MzZTw6
 xCNYutlWwqY9XCdjMd/Bq70QIsuKPNNPV3g/Ujb2BeMa5kOC9dUQilkOgxtveDOs9TFT
 eBIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789364963; x=1789969763;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PeaW+VFGuf5Y5g4vlyUoy4dkqCLFL8oEDLPIFdnyKfo=;
 b=B/R1Qaf1WGD9ehAdvDDhDFb6lpXhUiK/63osXZaH6tl9DxY/KUK/nW69mIvwIuwPeW
 uPmJVgg8LKfP54FUyDgd7MOMM5RQj1UwmKVqdQGSKT8mHUd+dlGcV4zzs8xAxPBFj9Kq
 oJoHXaUUfcfHe3eX29bnWN19nV7AFljyl9cPd4DfKSv1nKlYEOsAU+CHCK09u3RolTzM
 YueyFm7GLpfXEu/bYjSxMN1W0YxtOS/PfFqbydWaTJC5Dje/zBzRmZ3e6hSWDWSx3jc2
 mFWbX1MP8T0EEPmsab5s4YtyVUZ5rjQKKSRxbUVGJmZlpRhvSWc14LtkCwQWwDVFv6vU
 8aDg==
X-Gm-Message-State: AFuF++l48eCDKZO86kbKLWFK8HDQntUB75aTx8o/L+GhZSqNSiVadC+U
 R4cMbqgzQrs9rSpWHj/Bo+5fC/5gF+0bGJCgcHu8xPNqGOKQw07Ms3q3Whsr8Qwv5wJn+pDA/Yy
 reSsc
X-Gm-Gg: AYBFou2AuIvy9DV1BOGFMEbgqpRrRdlqlT8kZJ7H8IS7azi5nUL30emKvyUJ7jZ07rU
 ogb3QJ3/L9abHxIGmyJs1W2YxoQjSRelZANoN68YB9+aoizBHeUc5pIjgbaKZuRPb9+LNY7Pz9z
 mPxKMnvWUZnscIAMF3LyYinSjqZU0zqRR5ZNa2m1B2LEyDnfPUzEb5Q5AE3ZCPgnQlAbzqhVGLM
 1Ywe9NMo4jB2JqX3QrUzs7HiEduvBGyhBPJ1yuQfseJlTZF7rkHFxkpP/Rx1IYVsD4VJHKXKdB4
 uiVvBd1gHcvkE6LkA4aFiaAXaGytF6CWnGdE2YhqS2zIAvAtVFKv2lYJlxe5Fw8eED8cEHzAlGB
 62rMyYVcfLGQcysyXhF8jgGfc7Gg/qh8wpCXVxoev7Xwh+jCd0E3HKUGa18EeREi5inCqWdrLju
 x0FG2BGZOi+BemO2URt9J3e2Ud1rDjP8SuyKbWB4eBMcFlHJIge372eWeTPQGqIVgpq0RbLLolN
 TBV3vgLBxK7s//U6WXfr/JvkT+crIpoJQwhyXo=
X-Received: by 2002:a17:90b:3e4f:b0:398:9be6:f997 with SMTP id
 98e67ed59e1d1-39dec0f7abamr2952751a91.22.1789364961500; 
 Sun, 13 Sep 2026 22:49:21 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39d95864b4fsm19794492a91.15.2026.09.13.22.49.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 13 Sep 2026 22:49:21 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 00/62] kvargs: add numeric conversion helpers and use them
Date: Sun, 13 Sep 2026 22:46:31 -0700
Message-ID: <20260914054912.755403-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

The txgbe driver fix (included) inspired a deeper look at kvargs parsing
across all of DPDK drivers. With AI assistance found lots of issues.

Almost every driver parses numeric device arguments with its own
code, and most get some part of it wrong: atoi() does not detect
invalid input, errno is checked without being cleared, the end
pointer is ignored, the value is truncated before it is range
checked, or base 0 turns a leading zero into octal.

This series adds range checked converters and ready made
rte_kvargs_process() handlers to librte_kvargs, then converts the
drivers to use them.

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

Values are decimal or 0x hexadecimal, no octal, no negative value for
an unsigned type, no trailing garbage.
The handlers log key, value, and expected range on failure.
Unit tests cover all of them.

The new api's are marked experimental for 26.11.

Drivers (patches 6 to 61)
-------------------------

Patch 1 is the txgbe FDIR width fix already in next-net, carried so
the txgbe conversion applies on main. Patch 5 fixes EAL -m/-n/-r
parsing, same class of bug, independent of the rest.

52 drivers converted. Local handlers that only did a range checked
store are deleted, 40 of them, which is why the driver patches remove
about a thousand more lines than they add. Handlers that map values
onto hardware constants or set flags are kept and call the
converters.

Converting forced the question of how wide each field is, and found
twelve handlers storing through a pointer of the wrong width, in
eleven drivers (octeontx, ice twice, vhost, vdpa/ifc, bbdev_null,
idpf, cpfl, ml/cnxk, mempool/cnxk, la12xx, turbo_sw) plus discarded
parse errors in i40e and bnxt. Each is fixed in the patch that
converts the driver.

Nine of those are filed as Bugzilla 2036 to 2044 and the patches
carry the IDs. The worst is octeontx, where "nr_port=1" writes four
bytes into a one byte struct on the stack; next is ice, where
"default-mac-disable" overruns into the protocol extraction array
that was memset a few lines earlier. The la12xx and turbo_sw
mismatches were found in the same audit but not filed separately.

These are probe time parsing bugs and the fixes are part of the
conversion, so they are not marked for stable. The one exception is
the bnxt error propagation fix, which is independent of the new API
and is marked. It is ordered after the bnxt conversion, so it needs
a manual backport.

Left alone: multi field and list syntax (cnxk pre_l2 and SDP
channels, queue ranges, enetc txq_prior), sysfs and getenv() parsing,
and drivers not touched in this round (mlx5 family, cnxk crypto/sec/
event, crypto/scheduler, pfe, vdev_netvsc, raw/cnxk_gpio, qat, sxe2,
bus/vmbus). rte_kvargs_process() return values are still discarded at
some call sites; making those fail probe is a per driver decision.

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

Stephen Hemminger (61):
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
  doc: note kvargs devargs conversion in release notes

Zhang Tengfei (1):
  net/txgbe: fix FDIR devarg integer width

 .mailmap                                      |   1 +
 app/test/test_kvargs.c                        | 297 +++++++++
 doc/guides/eventdevs/dlb2.rst                 |   4 +-
 doc/guides/nics/null.rst                      |   2 +-
 doc/guides/prog_guide/devargs.rst             |  18 +
 doc/guides/rel_notes/release_26_11.rst        |  44 ++
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
 drivers/event/sw/sw_evdev.c                   |  56 +-
 drivers/mempool/cnxk/cnxk_mempool.c           |  37 +-
 drivers/ml/cnxk/cn10k_ml_dev.c                |  70 +--
 drivers/ml/cnxk/cn10k_ml_dev.h                |   8 +-
 drivers/ml/cnxk/cn10k_ml_ops.c                |   2 +-
 drivers/ml/cnxk/mvtvm_ml_dev.c                |  47 +-
 drivers/ml/cnxk/mvtvm_ml_dev.h                |   2 +-
 drivers/net/af_packet/rte_eth_af_packet.c     |  72 +--
 drivers/net/af_xdp/rte_eth_af_xdp.c           |  68 ++-
 drivers/net/ark/ark_ethdev.c                  |   4 +-
 drivers/net/bnxt/bnxt_ethdev.c                | 148 ++---
 drivers/net/bonding/eth_bond_private.h        |   8 -
 drivers/net/bonding/rte_eth_bond_args.c       |  71 +--
 drivers/net/bonding/rte_eth_bond_pmd.c        |   8 +-
 drivers/net/cnxk/cnxk_ethdev_devargs.c        | 277 +++------
 drivers/net/cxgbe/cxgbe_main.c                |  38 +-
 drivers/net/ena/ena_ethdev.c                  |  45 +-
 drivers/net/enetc/enetc4_vf.c                 |  22 +-
 drivers/net/failsafe/failsafe_args.c          |  20 +-
 drivers/net/hns3/hns3_common.c                |  23 +-
 drivers/net/hns3/hns3_common.h                |   3 -
 drivers/net/intel/cpfl/cpfl_ethdev.c          |  26 +-
 drivers/net/intel/i40e/i40e_ethdev.c          |  57 +-
 drivers/net/intel/iavf/iavf.h                 |   8 +-
 drivers/net/intel/iavf/iavf_ethdev.c          |  61 +-
 drivers/net/intel/ice/ice_ethdev.c            | 123 +---
 drivers/net/intel/ice/ice_ethdev.h            |  10 +-
 drivers/net/intel/idpf/idpf_ethdev.c          |  26 +-
 drivers/net/intel/ixgbe/ixgbe_ethdev.c        |  40 +-
 drivers/net/intel/ixgbe/ixgbe_ethdev.h        |   4 +-
 drivers/net/memif/rte_eth_memif.c             |  73 ++-
 drivers/net/mlx4/mlx4.c                       |  33 +-
 drivers/net/netvsc/hn_ethdev.c                |   6 +-
 drivers/net/nfb/nfb_ethdev.c                  |  13 +-
 drivers/net/nfp/nfp_ethdev.c                  |  36 +-
 drivers/net/null/rte_eth_null.c               |  78 +--
 drivers/net/octeon_ep/otx_ep_ethdev.c         |  16 +-
 drivers/net/octeontx/octeontx_ethdev.c        |  18 +-
 drivers/net/pcap/pcap_ethdev.c                |  51 +-
 drivers/net/qede/qede_ethdev.c                |  55 +-
 drivers/net/ring/rte_eth_ring.c               |  21 +-
 drivers/net/sfc/sfc.c                         |   2 +-
 drivers/net/sfc/sfc_kvargs.c                  |  19 -
 drivers/net/sfc/sfc_kvargs.h                  |   2 -
 drivers/net/sfc/sfc_port.c                    |   2 +-
 drivers/net/softnic/rte_eth_softnic.c         |  30 +-
 .../net/softnic/rte_eth_softnic_internals.h   |   3 +-
 drivers/net/thunderx/nicvf_ethdev.c           |  13 +-
 drivers/net/txgbe/txgbe_ethdev.c              |  95 ++-
 drivers/net/vhost/rte_eth_vhost.c             |  69 +--
 drivers/net/virtio/virtio_ethdev.c            |  36 +-
 drivers/net/virtio/virtio_user_ethdev.c       |  59 +-
 drivers/net/xsc/xsc_dev.c                     |  50 +-
 drivers/raw/skeleton/skeleton_rawdev.c        |  20 +-
 drivers/vdpa/ifc/ifcvf_vdpa.c                 |  29 +-
 lib/eal/common/eal_common_options.c           |  27 +-
 lib/kvargs/rte_kvargs.c                       | 563 ++++++++++++++++++
 lib/kvargs/rte_kvargs.h                       | 257 ++++++++
 76 files changed, 2009 insertions(+), 1839 deletions(-)

-- 
2.53.0

