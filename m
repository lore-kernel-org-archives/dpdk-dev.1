Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EC64CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:38:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A30840ED8;
	Tue, 29 Sep 2026 18:38:11 +0200 (CEST)
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12]) by mails.dpdk.org (Postfix) with ESMTP id 6E75A4026E
 for <dev@dpdk.org>; Tue, 29 Sep 2026 18:38:09 +0200 (CEST)
Received: by mail-pz2-f12.google.com with SMTP id
 d2e1a72fcca58-86212a185dcso3089874b3a.1
 for <dev@dpdk.org>; Tue, 29 Sep 2026 09:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790699888;
 x=1791304688; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2JfFoZDjteG8oTLDfEBm/xFWa/ZJ0ljD0K0rpxOMG4U=;
 b=kCUETlBg/Oo6Qlg3zcIIEJfbCuTCpRk6lW1CRLLNjHxLhdegbvXEOu/e5bQVwjfJex
 J47GVLqIbKJj3u2CVUAEscd5U1vA2J8hnFcfhNKbig6ZNgmFfpYev0ifoYlJFLf60Wyx
 N/LW2ou9oLqRvXwwqydFhxKPKvPUX4d7DF6A+MDttRjiJm/qDONF2VLKWC4gZ2OVYxjC
 iQLefAOwC/hFIbSQ7aVP8vjOYRpUnDiAltsOuwIDhF610GrsnoikJwKv7LmslLmfIZYW
 6dhd6p25Kh9UFK+simprPW71nbpCCUNc9LZk8Ue8G+HqE7sfDs2K0B7mMU5NXCcwknCx
 +qWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790699888; x=1791304688;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=2JfFoZDjteG8oTLDfEBm/xFWa/ZJ0ljD0K0rpxOMG4U=;
 b=AwIvIhM8OTrB/IJrIdZsqDBoD7GVl49msqrP4KGgj6Cx+C1JTiQr1t2flKYNLknyyy
 Wj8KIhMR9qtpiMz6CByYqIkbuAInEv7+X6ymQLKZX7KObnJAHTFwYhzaGToBitGIhRHc
 pqW6ADd8JDGP2idmupTO1qY6qDDEb0Ow3yQPkAfGPscNApeKhpS3oQi5wOD4eu6T6OQH
 Lsz1RP+LOgQPqq2Fa4DGHrxT6lRYzuBgInz+ui395mPmg/chGRyQLV0PJTTuZlC3AR1r
 j/lWRn3YO6VC9n3a0O2UKR9aOFjdf4IeAVxJy82oJPJEIFk+LFdEyxvLK9spJZU3mNrh
 2yZQ==
X-Gm-Message-State: AFuF++l9YEuyJpe1W2CnxroGIBUVTmNenfhXLu2zJa5Yj/R51I0BDMsf
 0ZjeEk/MBblHfIL+qEuyzTua2Qg83oSoES4Kt2OU4gOJ5Tj8zWPeDcA0hsw3f1WO9RwgfHFV/yi
 LK2in6fE=
X-Gm-Gg: AYBFou3iQu4gqw6LjL+HSunvq+Y6hbDxgzqSTz+5qhmxs5ymr3bPT538XJ6N0FI/in0
 1EEgw7HTRk5Rvg16QOU79Ka/0Uj666LNAY2Zv2n7KwKdASHnBTch+bBrBDs+/6GOJ18sbxi/Xjw
 ACa74U54RS6yUhrcKYMLs3tNu2d5iqGRJEFrxpe5tYEu9DQabdevINRiYe35Cf2V1Kr3PsmIg7q
 fDeRz0iZg+mHPZ5rtIO2lAOR5u/1eiZR/boPh1U6sHEejq3VxAx7He0nQTw2SY1kP2/RdHPc24i
 kUQNr3L10YNXiR9+/rkwUx4dUV+o1pRsBCVZEyy3FSLxV+S8In7tWYa+ZM9Y/VaNIuKTZa0CrgN
 zBJ08ZIGQlQfsdUAX8Thg/Dl7xMui4akjBHo88cBglcDPQTuvtMFs6KyPvxIdC3AA8mS6qQe4M/
 DlZJpsPLDW2K7J5JnCYNdsl29ZCzvXlVXM7to7T7hdluQEtezMBK8ii602RJEUinG4vtSVK9x2i
 JM5YaKMhGqVCKAvLeRFXm7LQ5NaHU9YrDIvaA==
X-Received: by 2002:a05:6a21:2d93:b0:3dd:a197:edef with SMTP id
 adf61e73a8af0-3de0e92114cmr15365235637.62.1790699888457; 
 Tue, 29 Sep 2026 09:38:08 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868ba02d02sm232392b3a.21.2026.09.29.09.38.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 09:38:07 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 00/61] kvargs: add numeric conversion helpers
Date: Tue, 29 Sep 2026 09:36:03 -0700
Message-ID: <20260929163800.1108305-1-stephen@networkplumber.org>
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

Library (patches 1 to 3)
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

Drivers (patches 5 to 60)
-------------------------

52 drivers converted. Local handlers that only did a range checked
store are deleted, 40 of them.

The af_xdp conversion (patch 17) goes further than the rest.
With some changes to types, like queue and indexes converted
to uint16_t, the local handlers can be replaced by helpers.
Likewise boolean flags can be bool instead of int.

There are some cases not covered easily by kvargs helpers
including ranges and other parsing.

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

v2 - rebase and fixup af_xdp

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
 drivers/net/bonding/rte_eth_bond_args.c       |  71 +--
 drivers/net/bonding/rte_eth_bond_pmd.c        |   8 +-
 drivers/net/cnxk/cnxk_ethdev_devargs.c        | 283 +++------
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
 drivers/net/txgbe/txgbe_ethdev.c              |  97 ++-
 drivers/net/vhost/rte_eth_vhost.c             |  69 +--
 drivers/net/virtio/virtio_ethdev.c            |  36 +-
 drivers/net/virtio/virtio_user_ethdev.c       |  59 +-
 drivers/net/xsc/xsc_dev.c                     |  50 +-
 drivers/raw/skeleton/skeleton_rawdev.c        |  20 +-
 drivers/vdpa/ifc/ifcvf_vdpa.c                 |  29 +-
 lib/eal/common/eal_common_options.c           |  27 +-
 lib/kvargs/rte_kvargs.c                       | 564 ++++++++++++++++++
 lib/kvargs/rte_kvargs.h                       | 257 ++++++++
 75 files changed, 2191 insertions(+), 2024 deletions(-)

-- 
2.53.0

