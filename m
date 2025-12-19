Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35D8D78770
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Dec 2025 17:26:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5FA1D402E5;
	Fri, 19 Dec 2025 18:26:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id BB38F40150
 for <dev@dpdk.org>; Fri, 19 Dec 2025 18:26:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1766165167; x=1797701167;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=/HDU1QZMLVeWQ0gFE2wv6Nfyd3vVfVlc9ztFjXdWgYE=;
 b=cqwwUyecu70VqslA0PDa7WGLno9ETHbmyXxCVXq8MtgsNatkRvEu1eHb
 15riAiH5PgU0sG0njtkF+P1ov4XANnt65YjewALX/SrrbMT8ZJNkXwVhg
 a3SGQiN9h/2zCqCIa1+9dDQoPynVkGi+pWwMWv3P1GTlnO9dNwPnDdBjN
 PoL4FMyQgW24WZDO7pCGNxZ7w/fdfkEhjzlS+Pzmwzf/cw6fxo1TijzqL
 3acKQgtF4Eyc8PMELU8P4WKLkWZmOVszDhjhhdYyvDEq8XemEJTWmOoG5
 BEn82HISJpAvIwLPIpD/evmCxNDwNTaQoDhZgxlSA+alY7LZywreNUavG g==;
X-CSE-ConnectionGUID: 4wjdKg/PSeyZRfoEJ7edcw==
X-CSE-MsgGUID: NkuyIIaQS0mbkWXdDnWCDw==
X-IronPort-AV: E=McAfee;i="6800,10657,11647"; a="71759455"
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; d="scan'208";a="71759455"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Dec 2025 09:26:05 -0800
X-CSE-ConnectionGUID: rKSQF4cpS22Z2k+2jtxcnw==
X-CSE-MsgGUID: zybOF7l/T7O6FNDclObRWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,161,1763452800"; d="scan'208";a="198170378"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 19 Dec 2025 09:26:04 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 00/27] combine multiple Intel scalar Tx paths
Date: Fri, 19 Dec 2025 17:25:17 +0000
Message-ID: <20251219172548.2660777-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
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

Bruce Richardson (27):
  net/intel: create common Tx descriptor structure
  net/intel: use common tx ring structure
  net/intel: create common post-Tx cleanup function
  net/intel: consolidate definitions for Tx desc fields
  net/intel: create separate header for Tx scalar fns
  net/intel: add common fn to calculate needed descriptors
  net/ice: refactor context descriptor handling
  net/i40e: refactor context descriptor handling
  net/idpf: refactor context descriptor handling
  net/intel: consolidate checksum mask definition
  net/intel: create common checksum Tx offload function
  net/intel: create a common scalar Tx function
  net/i40e: use common scalar Tx function
  net/intel: add IPSec hooks to common Tx function
  net/intel: support configurable VLAN tag insertion on Tx
  net/iavf: use common scalar Tx function
  net/i40e: document requirement for QinQ support
  net/idpf: use common scalar Tx function
  net/intel: avoid writing the final pkt descriptor twice
  net/intel: write descriptors using non-volatile pointers
  net/intel: remove unnecessary flag clearing
  net/intel: mark mid-burst ring cleanup as unlikely
  net/intel: add special handling for single desc packets
  net/intel: use separate array for desc status tracking
  net/ixgbe: use separate array for desc status tracking
  net/intel: drop unused Tx queue used count
  net/intel: remove index for tracking end of packet

 doc/guides/nics/i40e.rst                      |  18 +
 drivers/net/intel/common/tx.h                 | 101 ++-
 drivers/net/intel/common/tx_scalar_fns.h      | 441 ++++++++++++
 drivers/net/intel/cpfl/cpfl_rxtx.c            |   4 +-
 drivers/net/intel/i40e/i40e_fdir.c            |  34 +-
 drivers/net/intel/i40e/i40e_rxtx.c            | 500 +++-----------
 drivers/net/intel/i40e/i40e_rxtx.h            |  17 +-
 .../net/intel/i40e/i40e_rxtx_vec_altivec.c    |  23 +-
 drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c   |  34 +-
 drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c |  50 +-
 drivers/net/intel/i40e/i40e_rxtx_vec_common.h |   6 +-
 drivers/net/intel/i40e/i40e_rxtx_vec_neon.c   |  23 +-
 drivers/net/intel/i40e/i40e_rxtx_vec_sse.c    |  23 +-
 drivers/net/intel/iavf/iavf_rxtx.c            | 642 ++++--------------
 drivers/net/intel/iavf/iavf_rxtx.h            |  30 +-
 drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   |  53 +-
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 104 ++-
 drivers/net/intel/iavf/iavf_rxtx_vec_common.h |  36 +-
 drivers/net/intel/iavf/iavf_rxtx_vec_sse.c    |  27 +-
 drivers/net/intel/ice/ice_dcf_ethdev.c        |  10 +-
 drivers/net/intel/ice/ice_rxtx.c              | 590 +++++-----------
 drivers/net/intel/ice/ice_rxtx.h              |  15 +-
 drivers/net/intel/ice/ice_rxtx_vec_avx2.c     |  53 +-
 drivers/net/intel/ice/ice_rxtx_vec_avx512.c   |  51 +-
 drivers/net/intel/ice/ice_rxtx_vec_common.h   |  43 +-
 drivers/net/intel/ice/ice_rxtx_vec_sse.c      |  24 +-
 drivers/net/intel/idpf/idpf_common_rxtx.c     | 298 ++------
 drivers/net/intel/idpf/idpf_common_rxtx.h     |  21 +-
 .../net/intel/idpf/idpf_common_rxtx_avx2.c    |  53 +-
 .../net/intel/idpf/idpf_common_rxtx_avx512.c  |  53 +-
 drivers/net/intel/idpf/idpf_rxtx.c            |  17 +-
 drivers/net/intel/idpf/idpf_rxtx_vec_common.h |   6 +-
 drivers/net/intel/ixgbe/ixgbe_rxtx.c          | 103 ++-
 .../net/intel/ixgbe/ixgbe_rxtx_vec_common.c   |   1 -
 34 files changed, 1394 insertions(+), 2110 deletions(-)
 create mode 100644 drivers/net/intel/common/tx_scalar_fns.h

--
2.51.0

