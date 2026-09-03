Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB80C61DD3
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Sep 2026 17:02:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F32E9427A6;
	Thu,  3 Sep 2026 19:02:08 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 90E2F40647
 for <dev@dpdk.org>; Thu,  3 Sep 2026 19:02:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788454927; x=1819990927;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=KBQqow35IK/CLijGEN4NkfoJUnRi8y+/XVxs+tSqWIo=;
 b=WHwrzyDqQYCN+kZonLks+6nmmMt+VqxrSepBqnRKhK5yR7trJTXhAQAI
 Gb1hrAvLDDxC2EvYL6yMN2DMJ6iyC4ABwgCXMkPsWVO9IRB6IRsfUS95O
 f6ziRKJFhzkQmcv8+R+zd980uei/5QxQcwvuPUjbziXaivfdUjjin7+dr
 nEPKWWhc2WcvqP+Hnvnp03XB2Xj7Kf4XnnvArGxR8Lv2zr58hPdaOH7Oi
 lDOg5zXSzCxutflWVco1V1McbPS9i0JEJJ4NbruDykF8bGaECk91vOA+D
 whWlY4vI3rqGwjgOFZWhZlwBpmeO112H6Gzl1Ry0+PBn2cCURQ/Oe7Ppw w==;
X-CSE-ConnectionGUID: fcPGp1IRRgWdymiCsbWxbQ==
X-CSE-MsgGUID: xgAoo0u2TEmEwytQgvoNXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11895"; a="100462951"
X-IronPort-AV: E=Sophos;i="6.25,260,1779174000"; d="scan'208";a="100462951"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Sep 2026 10:01:45 -0700
X-CSE-ConnectionGUID: iKJjl9KNQyiYz4t4/gzReg==
X-CSE-MsgGUID: LZTqDSzCTyK+bip2Q1QWZQ==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 03 Sep 2026 10:01:44 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 00/13] Consolidate ice and iavf vector Tx paths
Date: Thu,  3 Sep 2026 18:01:29 +0100
Message-ID: <20260903170140.360477-1-bruce.richardson@intel.com>
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

This patchset consolidates the ice and iavf vector Tx paths, moving the
code to net/intel/common. The iavf code is used as the basis for the
move, because it has a superset of the features. When the common code is
adopted by the ice driver, it then gains features such as QinQ support
and tunneling support.

Depends-on: series-39162  ("VLAN and QinQ fixes for iavf")

Bruce Richardson (13):
  net/iavf: remove unnecessary alignment calls
  net/intel: make Tx context flag common
  net/iavf: use separate params for VLAN and QinQ position
  net/iavf: deduplicate tunnel field fill functions
  net/intel: define common macros for tunneling bit-shifts
  net/intel: move iavf descriptor writing functions to common
  net/intel: use function callback for lldp
  net/ice: use common descriptor creation functions
  net/intel: move vector Tx paths to common
  net/ice: use common AVX Tx functions
  net/intel: add common vector Tx fns with context handling
  net/intel: improve Tx path selection logic
  net/ice: enable context desc offloads for vector Tx

 doc/guides/rel_notes/release_26_11.rst        |   6 +
 drivers/net/intel/common/tx.h                 |  77 +-
 drivers/net/intel/common/tx_vec_x86.h         | 783 ++++++++++++++++++
 drivers/net/intel/cpfl/cpfl_rxtx.c            |   3 +-
 drivers/net/intel/i40e/i40e_rxtx.c            |   2 +-
 drivers/net/intel/iavf/iavf_rxtx.c            |  76 +-
 drivers/net/intel/iavf/iavf_rxtx.h            |  34 -
 drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   | 496 +----------
 drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 495 +----------
 drivers/net/intel/iavf/iavf_rxtx_vec_common.h |  76 +-
 drivers/net/intel/ice/ice_ethdev.h            |   3 +
 drivers/net/intel/ice/ice_rxtx.c              |  34 +-
 drivers/net/intel/ice/ice_rxtx.h              |  11 +
 drivers/net/intel/ice/ice_rxtx_vec_avx2.c     | 159 +---
 drivers/net/intel/ice/ice_rxtx_vec_avx512.c   | 154 +---
 drivers/net/intel/ice/ice_rxtx_vec_common.h   |  59 --
 drivers/net/intel/idpf/idpf_rxtx.c            |   3 +-
 17 files changed, 1025 insertions(+), 1446 deletions(-)
 create mode 100644 drivers/net/intel/common/tx_vec_x86.h

--
2.53.0

