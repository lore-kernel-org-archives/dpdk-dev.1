Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0A64E81BDF
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 16:45:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A0B8E402B0;
	Mon,  9 Feb 2026 17:45:44 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 78DA34028F
 for <dev@dpdk.org>; Mon,  9 Feb 2026 17:45:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770655544; x=1802191544;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6TSwTHlOHA2LFcHzhePXGDi5VgbDtYxZ5BiRXcC7uQY=;
 b=bbtKm9kWtNcRspEgSW6edVfRPbH+LgsP13mAVbCW2I6rSW3I00rxZyYv
 2P8YEVrV3xgegXVh9KWRVEiQsRu03GSlqPg3j9O8hoH54PWtb2yRB6J0F
 P9RlTiF90Zt1b66dBvjMLEgSccO8iULmLHKy03QkCD5K9dQlbbpMSWjDn
 zPE4TfP9R6SN6hsu2fWTmwJbv1iYsA3zYxU/fzR4VBOhdrI0c+IC3HXvh
 Ab1xDRYWPR8Ax/xPwSZ4zkf2L74Q08te8krK/K1EB4cHudaCr9SXI5a0I
 LAfw/mcBLzHXKwZyhHY9nHqQEaCadmCTso4/llrFj+9BeFjy3/+/3ARp5 Q==;
X-CSE-ConnectionGUID: RW6DDcM5RdK+hs1sSZxVBQ==
X-CSE-MsgGUID: PiphNeU3SAybdwYnHfNAgQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71663382"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="71663382"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 08:45:42 -0800
X-CSE-ConnectionGUID: 5NzUk+8CTzygoLt0hG3CBQ==
X-CSE-MsgGUID: h2GYM1G9SHCdOW17b4+UOw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="210789037"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa006.fm.intel.com with ESMTP; 09 Feb 2026 08:45:42 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 00/35]  combine multiple Intel scalar Tx paths
Date: Mon,  9 Feb 2026 16:44:58 +0000
Message-ID: <20260209164538.1428499-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251219172548.2660777-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
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

The scalar Tx paths, with support for offloads and multiple mbufs
per packet, are almost identical across drivers ice, i40e, iavf and
the single-queue mode of idpf. Therefore, we can do some rework to
combine these code paths into a single function which is parameterized
by compile-time constants, allowing code saving to give us a single
path to optimize and maintain - apart from edge cases like IPSec
support in iavf.

The ixgbe driver has a number of similarities too, which we take
advantage of where we can, but the overall descriptor format is
sufficiently different that its main scalar code path is kept
separate.

Once merged, we can then optimize the drivers a bit to improve
performance, and also easily extend some drivers to use additional
paths for better performance, e.g. add the "simple scalar" path
to IDPF driver for better performance on platforms without AVX.

V4:
- Updates following review:
  - merged patches 3 and 5
  - renamed new file to tx_scalar.h
  - added UDP_TSO flag to drivers
  - other minor fixups

V3:
- rebase on top of latest next-net-intel tree
- fix issues with iavf and cpfl drivers seen in some testing

V2:
 - reworked the simple-scalar path as well as full scalar one
 - added simple scalar path support to idpf driver
 - small cleanups, e.g. issues flagged by checkpatch


Bruce Richardson (35):
  net/intel: create common Tx descriptor structure
  net/intel: use common Tx ring structure
  net/intel: create common post-Tx cleanup function
  net/intel: consolidate definitions for Tx desc fields
  net/intel: add common fn to calculate needed descriptors
  net/ice: refactor context descriptor handling
  net/i40e: refactor context descriptor handling
  net/idpf: refactor context descriptor handling
  net/intel: consolidate checksum mask definition
  net/intel: create common checksum Tx offload function
  net/intel: create a common scalar Tx function
  net/i40e: use common scalar Tx function
  net/intel: add IPsec hooks to common Tx function
  net/intel: support configurable VLAN tag insertion on Tx
  net/iavf: use common scalar Tx function
  net/i40e: document requirement for QinQ support
  net/idpf: use common scalar Tx function
  net/intel: avoid writing the final pkt descriptor twice
  eal: add macro for marking assumed alignment
  net/intel: write descriptors using non-volatile pointers
  net/intel: remove unnecessary flag clearing
  net/intel: mark mid-burst ring cleanup as unlikely
  net/intel: add special handling for single desc packets
  net/intel: use separate array for desc status tracking
  net/ixgbe: use separate array for desc status tracking
  net/intel: drop unused Tx queue used count
  net/intel: remove index for tracking end of packet
  net/intel: merge ring writes in simple Tx for ice and i40e
  net/intel: consolidate ice and i40e buffer free function
  net/intel: complete merging simple Tx paths
  net/intel: use non-volatile stores in simple Tx function
  net/intel: align scalar simple Tx path with vector logic
  net/intel: use vector SW ring entry for simple path
  net/intel: use vector mbuf cleanup from simple scalar path
  net/idpf: enable simple Tx function

 doc/guides/nics/i40e.rst                      |  18 +
 drivers/net/intel/common/tx.h                 | 117 ++-
 drivers/net/intel/common/tx_scalar.h          | 593 ++++++++++++++
 drivers/net/intel/cpfl/cpfl_rxtx.c            |  25 +-
 drivers/net/intel/i40e/i40e_fdir.c            |  34 +-
 drivers/net/intel/i40e/i40e_rxtx.c            | 673 +++-------------
 drivers/net/intel/i40e/i40e_rxtx.h            |  17 +-
 .../net/intel/i40e/i40e_rxtx_vec_altivec.c    |  25 +-
 drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c   |  36 +-
 drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c |  52 +-
 drivers/net/intel/i40e/i40e_rxtx_vec_common.h |   6 +-
 drivers/net/intel/i40e/i40e_rxtx_vec_neon.c   |  25 +-
 drivers/net/intel/iavf/iavf_rxtx.c            | 642 ++++-----------
 drivers/net/intel/iavf/iavf_rxtx.h            |  31 +-
 drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   |  55 +-
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 104 +--
 drivers/net/intel/iavf/iavf_rxtx_vec_common.h |  36 +-
 drivers/net/intel/ice/ice_dcf_ethdev.c        |  10 +-
 drivers/net/intel/ice/ice_rxtx.c              | 740 ++++--------------
 drivers/net/intel/ice/ice_rxtx.h              |  16 +-
 drivers/net/intel/ice/ice_rxtx_vec_avx2.c     |  55 +-
 drivers/net/intel/ice/ice_rxtx_vec_avx512.c   |  53 +-
 drivers/net/intel/ice/ice_rxtx_vec_common.h   |  43 +-
 drivers/net/intel/idpf/idpf_common_device.h   |   2 +
 drivers/net/intel/idpf/idpf_common_rxtx.c     | 314 ++------
 drivers/net/intel/idpf/idpf_common_rxtx.h     |  24 +-
 .../net/intel/idpf/idpf_common_rxtx_avx2.c    |  53 +-
 .../net/intel/idpf/idpf_common_rxtx_avx512.c  |  55 +-
 drivers/net/intel/idpf/idpf_rxtx.c            |  43 +-
 drivers/net/intel/idpf/idpf_rxtx_vec_common.h |   6 +-
 drivers/net/intel/ixgbe/ixgbe_rxtx.c          | 103 ++-
 .../net/intel/ixgbe/ixgbe_rxtx_vec_common.c   |   3 +-
 lib/eal/include/rte_common.h                  |   6 +
 33 files changed, 1579 insertions(+), 2436 deletions(-)
 create mode 100644 drivers/net/intel/common/tx_scalar.h

--
2.51.0

