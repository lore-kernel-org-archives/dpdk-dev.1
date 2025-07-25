Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC53CC87FCA
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Jul 2025 12:50:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B2D5A40144;
	Fri, 25 Jul 2025 14:50:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by mails.dpdk.org (Postfix) with ESMTP id 0FE15400D5
 for <dev@dpdk.org>; Fri, 25 Jul 2025 14:50:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1753447806; x=1784983806;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=930FQMgYlJBVtMyXGHNr/A9iHzwCxr9oOPGQwCYbFZQ=;
 b=VbaOYteoJa4NR8EkVJHchcP0tHiPM1t+fm5ZSRL7F45I9FkvMPNRcTMC
 PZwBl2ZeV0LrjNGXts7x8Gfa0VCm9xe28On1U4khnuvSUaBj/QFs/Uaqt
 ayOG4swb86midZHr18gZQ2XUjQphFySL+MaIfHXpnsQRsm2KrcwVXjNlr
 wrNxHjTLZP+ykFzUxDd2YWe7CxA0505NQLnefY7kJJISXtWpjA9xrzrTa
 PJofbejqq8isH7aFUYoRGMOa8Ih5iQwJKTz0I9DMEglX9Gcy0s28yNslq
 a7oFoK1XQ8dzzAkwheo//nQJRaYBK/9Jz4wieE+0xI73Hl3DHzeCbrYTi g==;
X-CSE-ConnectionGUID: S2PVL6pKRby/4JxkywvSUQ==
X-CSE-MsgGUID: dBu1IO9USh6nzmEVEmwxJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11503"; a="66480137"
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="66480137"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Jul 2025 05:50:05 -0700
X-CSE-ConnectionGUID: EWwDB11CRJSJDfKERO9kPQ==
X-CSE-MsgGUID: lLEwCyk4R4iLWQCg2AtSbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,339,1744095600"; d="scan'208";a="161152242"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by orviesa007.jf.intel.com with ESMTP; 25 Jul 2025 05:50:04 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [RFC PATCH 00/14] net/intel: rx path selection simplification
Date: Fri, 25 Jul 2025 12:49:05 +0000
Message-Id: <20250725124919.3564890-1-ciara.loftus@intel.com>
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

Bruce Richardson (1):
  net/intel: introduce common vector capability function

Ciara Loftus (13):
  net/ice: use the same Rx path across process types
  net/iavf: rename Rx/Tx function type variables
  net/iavf: use the same Rx path across process types
  net/i40e: use the same Rx path across process types
  net/ice: use the new common vector capability function
  net/iavf: use the new common vector capability function
  net/i40e: use the new common vector capability function
  net/iavf: remove redundant field from iavf adapter struct
  net/intel: introduce infrastructure for Rx path selection
  net/ice: remove unsupported Rx offload
  net/ice: use the common Rx path selection infrastructure
  net/iavf: use the common Rx path selection infrastructure
  net/i40e: use the common Rx path selection infrastructure

 drivers/net/intel/common/rx.h                 | 110 +++++
 drivers/net/intel/common/rx_vec_x86.h         |  23 +
 drivers/net/intel/i40e/i40e_ethdev.h          |  25 +-
 drivers/net/intel/i40e/i40e_rxtx.c            | 246 ++++------
 drivers/net/intel/i40e/i40e_rxtx.h            |  16 +
 .../net/intel/i40e/i40e_rxtx_vec_altivec.c    |   6 +
 drivers/net/intel/i40e/i40e_rxtx_vec_common.h |   9 +-
 drivers/net/intel/i40e/i40e_rxtx_vec_neon.c   |   6 +
 drivers/net/intel/i40e/i40e_rxtx_vec_sse.c    |   6 +
 drivers/net/intel/iavf/iavf.h                 |   9 +-
 drivers/net/intel/iavf/iavf_ethdev.c          |   1 -
 drivers/net/intel/iavf/iavf_rxtx.c            | 443 ++++++------------
 drivers/net/intel/iavf/iavf_rxtx.h            |  51 +-
 drivers/net/intel/iavf/iavf_rxtx_vec_common.h |  14 +-
 drivers/net/intel/iavf/iavf_rxtx_vec_neon.c   |   6 +
 drivers/net/intel/iavf/iavf_rxtx_vec_sse.c    |   6 +
 drivers/net/intel/ice/ice_ethdev.c            |   2 +
 drivers/net/intel/ice/ice_ethdev.h            |  25 +-
 drivers/net/intel/ice/ice_rxtx.c              | 269 ++++-------
 drivers/net/intel/ice/ice_rxtx.h              |  29 ++
 drivers/net/intel/ice/ice_rxtx_vec_common.h   |  18 +-
 drivers/net/intel/ice/ice_rxtx_vec_sse.c      |   6 +
 22 files changed, 639 insertions(+), 687 deletions(-)

-- 
2.34.1

