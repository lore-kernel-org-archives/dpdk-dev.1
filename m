Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B487CA0EC6
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 10:59:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 93BD44014F;
	Mon, 18 Aug 2025 12:59:32 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 6DE704013F
 for <dev@dpdk.org>; Mon, 18 Aug 2025 12:59:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755514771; x=1787050771;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=5SIlenS668cq1lj/MjGb9UR5aEqm9L+LB0FLb/EYSe4=;
 b=ksC0dpzKmLs1LDi/Q+dnrF+9xLJHQ/YHEA8vJaFCc2BeFaVZyC/XWDS+
 rk/eJritu/WLt+PH/e6hUdT2JFpNPNVm9d3J3hzR6s/EvgYYI75V+i20J
 TgHyhvcptA+I2JyrbLS3nOk6Xu1/WmAAcBj0AS9DWpecaes8th8S9JDdV
 xQ6lOSni+E6JqHHJ20usKagFVOhqeWvem8AUrrp60io0e8Gm/QoQt1rZn
 r0pELsceL5k3/vtlQ0DdQcRJIDMSARlyqGWYZ1Zs1GC00CayfuJEFR15S
 PCy5UIZKBkNXX15h5deeafVBQqnnYrVS/BtzujkM6wJR68rmpXl7PsMxH w==;
X-CSE-ConnectionGUID: 2t6x4vuaTnSLSsSLj2eQqg==
X-CSE-MsgGUID: 3LyxGwCXTn2h14/pybhswA==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="83165412"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; d="scan'208";a="83165412"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2025 03:59:29 -0700
X-CSE-ConnectionGUID: 3nS5auQKSqyuCzTNVmODQA==
X-CSE-MsgGUID: +jXuDjerRcyi+6wcZ1eMVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; d="scan'208";a="166722916"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by orviesa006.jf.intel.com with ESMTP; 18 Aug 2025 03:59:28 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v3 00/15] net/intel: rx path selection simplification
Date: Mon, 18 Aug 2025 10:58:59 +0000
Message-Id: <20250818105914.169732-1-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
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

This series aims to simplify the process of selecting an Rx burst
function for the i40e, iavf and ice drivers. Three main simplifications
are made:
1. enforcing the same rx burst function for both primary and secondary
processes.
2. using a common function for determining the maximum SIMD width based
on compiler flags, CPU flags and user-defined limits.
3. using a common function for selecting the rx burst function based on
maximum SIMD width, function features (flex desc, scattered, bulk alloc)
and requested rx offloads.

v3:
* removed arbitrary defines for features and replaced with new sub structure within features
  structure
* removed unnecessary initialisation in the path select function
* added error log for case when tx simd width is invalid in i40e driver
* fixed ice vector offload mask to excude QINQ
* removed unnecessary #ifdef CC_AVX512_SUPPORT in ice and i40e driver
* changed == RTE_VECT_SIMD_256 to >= RTE_VECT_SIMD_256 in ice driver

Bruce Richardson (1):
  net/intel: introduce common vector capability function

Ciara Loftus (14):
  net/ice: use the same Rx path across process types
  net/iavf: rename Rx/Tx function type variables
  net/iavf: use the same Rx path across process types
  net/i40e: use the same Rx path across process types
  net/ice: use the new common vector capability function
  net/iavf: use the new common vector capability function
  net/i40e: use the new common vector capability function
  net/iavf: remove redundant field from iavf adapter struct
  net/ice: remove unsupported Rx offload
  net/iavf: reorder enum of Rx function types
  net/intel: introduce infrastructure for Rx path selection
  net/ice: use the common Rx path selection infrastructure
  net/iavf: use the common Rx path selection infrastructure
  net/i40e: use the common Rx path selection infrastructure

 drivers/net/intel/common/rx.h                 |  98 ++++
 drivers/net/intel/common/rx_vec_x86.h         |  22 +
 drivers/net/intel/i40e/i40e_ethdev.h          |  25 +-
 drivers/net/intel/i40e/i40e_rxtx.c            | 256 ++++------
 drivers/net/intel/i40e/i40e_rxtx.h            |  16 +
 .../net/intel/i40e/i40e_rxtx_vec_altivec.c    |   6 +
 drivers/net/intel/i40e/i40e_rxtx_vec_common.h |   9 +-
 drivers/net/intel/i40e/i40e_rxtx_vec_neon.c   |   6 +
 drivers/net/intel/i40e/i40e_rxtx_vec_sse.c    |   6 +
 drivers/net/intel/iavf/iavf.h                 |  31 +-
 drivers/net/intel/iavf/iavf_ethdev.c          |   1 -
 drivers/net/intel/iavf/iavf_rxtx.c            | 439 ++++++------------
 drivers/net/intel/iavf/iavf_rxtx.h            |  51 +-
 drivers/net/intel/iavf/iavf_rxtx_vec_common.h |  14 +-
 drivers/net/intel/iavf/iavf_rxtx_vec_neon.c   |   6 +
 drivers/net/intel/iavf/iavf_rxtx_vec_sse.c    |   6 +
 drivers/net/intel/ice/ice_ethdev.c            |   2 +
 drivers/net/intel/ice/ice_ethdev.h            |  25 +-
 drivers/net/intel/ice/ice_rxtx.c              | 270 ++++-------
 drivers/net/intel/ice/ice_rxtx.h              |  30 ++
 drivers/net/intel/ice/ice_rxtx_vec_common.h   |  18 +-
 drivers/net/intel/ice/ice_rxtx_vec_sse.c      |   6 +
 22 files changed, 636 insertions(+), 707 deletions(-)

-- 
2.34.1

