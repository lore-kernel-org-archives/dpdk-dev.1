Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7459FE81BCB
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 14:14:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0CE4F402C6;
	Mon,  9 Feb 2026 15:14:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by mails.dpdk.org (Postfix) with ESMTP id 4597A402B0
 for <dev@dpdk.org>; Mon,  9 Feb 2026 15:13:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770646438; x=1802182438;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=TjX72Smf7CdgnwrHEGz2U47sDwh0kT9SM6RmfXixSTo=;
 b=DsK2xcylhn0aZX1RAvKiTtx/DVadXQO6Q8XNZA8o8Uw8nGIDJgHoconV
 Nu4bYOgZndKXflWh3rdQDSDxMB/rgKYFiDYgojTNZgt7mtXyDoy6ajdG+
 TYFAugaYRc+O88sK4CuDcY7nW1CIzzjc2Lqfu49gkYkxntL9xFoOa64A9
 akEZbazJ6Lw89h1m6YIe4yhOATTkFi2CY1YPu6K72t/8HSgjsyEQ+11u1
 4qnH5/XVewDfT/SJkxzHOdi/t1h422GHSmfCRBtA/YjagJN8gql4ulU2m
 6eTnjJZBWN9nIprVCWyJhyKxHmiS7GB5kO5Z+UQlpzLEBmain7FjNJjUj w==;
X-CSE-ConnectionGUID: dkK2OnqASFWslZAzprdyOA==
X-CSE-MsgGUID: MWTkdIL7Q9WtwikaeHKG5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11696"; a="71658475"
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="71658475"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Feb 2026 06:13:55 -0800
X-CSE-ConnectionGUID: xtRT+i1MQpyg6lc+sTFbMA==
X-CSE-MsgGUID: AMBq2aUwS4WFU5AQ1GKQ+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,282,1763452800"; d="scan'208";a="242215946"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa002.jf.intel.com with ESMTP; 09 Feb 2026 06:13:55 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 00/12] Cleanups for ixgbe, i40e, and iavf PMD's
Date: Mon,  9 Feb 2026 14:13:36 +0000
Message-ID: <cover.1770646012.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
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

This patchset is an assortment of cleanups for ixgbe, i40e, and iavf PMD.

IXGBE:

- Remove unnecessary macros and #ifdef's
- Disentangle unrelated flow API code paths

I40E:

- Get rid of global variables and unnecessary allocations
- Reduce code duplication around default RSS keys
- Use more appropriate integer types and definitions

IAVF:

- Remove dead code
- Remove unnecessary allocations
- Separate RSS uninit from hash flow parser uninit

This is done in preparation for further rework.

Anatoly Burakov (12):
  net/ixgbe: remove MAC type check macros
  net/ixgbe: remove security-related ifdefery
  net/ixgbe: split security and ntuple filters
  net/i40e: get rid of global filter variables
  net/i40e: use stack allocations for tunnel set
  net/i40e: make default RSS key global
  net/i40e: use unsigned types for queue comparisons
  net/i40e: use proper flex len define
  net/i40e: remove global pattern variable
  net/iavf: remove remnants of pipeline mode
  net/iavf: do not use malloc in crypto VF commands
  net/iavf: decouple hash uninit from parser uninit

 drivers/net/intel/i40e/i40e_ethdev.c         | 148 ++++++++---------
 drivers/net/intel/i40e/i40e_ethdev.h         |  24 +--
 drivers/net/intel/i40e/i40e_flow.c           | 146 ++++++++---------
 drivers/net/intel/i40e/i40e_hash.c           |  27 +++-
 drivers/net/intel/i40e/i40e_hash.h           |   3 +
 drivers/net/intel/iavf/iavf_ethdev.c         |   4 +
 drivers/net/intel/iavf/iavf_fdir.c           |   1 -
 drivers/net/intel/iavf/iavf_fsub.c           |   1 -
 drivers/net/intel/iavf/iavf_generic_flow.h   |  15 --
 drivers/net/intel/iavf/iavf_hash.c           |  14 +-
 drivers/net/intel/iavf/iavf_hash.h           |  13 ++
 drivers/net/intel/iavf/iavf_ipsec_crypto.c   | 158 ++++++------------
 drivers/net/intel/ixgbe/ixgbe_ethdev.c       |   8 -
 drivers/net/intel/ixgbe/ixgbe_ethdev.h       |  16 --
 drivers/net/intel/ixgbe/ixgbe_flow.c         | 162 ++++++++++++-------
 drivers/net/intel/ixgbe/ixgbe_rxtx.c         |  26 ---
 drivers/net/intel/ixgbe/ixgbe_rxtx.h         |   2 -
 drivers/net/intel/ixgbe/ixgbe_rxtx_vec_sse.c |   6 -
 18 files changed, 352 insertions(+), 422 deletions(-)
 create mode 100644 drivers/net/intel/iavf/iavf_hash.h

-- 
2.47.3

