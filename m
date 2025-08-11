Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04125C87FDB
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 13:43:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 425B840693;
	Mon, 11 Aug 2025 15:43:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id E4514402AC
 for <dev@dpdk.org>; Mon, 11 Aug 2025 15:43:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754919787; x=1786455787;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uARCxGFMmewwqkXRZVbUO51Q229M6ht/RH289bYs+gA=;
 b=aLE4ZYlEn1geau3z7tF8oDGLomlIxdyPUkbk+aQG5nELb/yDJuUX5ZcR
 e0lwlmqcvrCtaBO+Z882PyMUpyUijEgmmLoITdZ3ZE0UHnAS8FnSN/rGS
 87GujWPoR3olnkSPL3O7ABys6pPpQvqfT7LhQdZc57gKUaUzXyWILTjfQ
 VEPYzkmpEYiSCrc66R331Mn8AZko6WRWdZzjf+AdCgiQABWNQC/zf0dtb
 RuLtrYxGf62yy+u4vI//SAjLcWSFN6UALeYX0wWocBiZNK1fns3DkewAl
 bTW1yDDkC/nhFT2HxaMD2xN6JGF22Bw0lkdnpExXPTm+ZXoXTUXYdXZne A==;
X-CSE-ConnectionGUID: 2nZxARuqRzaKEyY2iBfDqg==
X-CSE-MsgGUID: xOKF76EwTgiVfg12CH+9gg==
X-IronPort-AV: E=McAfee;i="6800,10657,11518"; a="57041878"
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; d="scan'208";a="57041878"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2025 06:43:05 -0700
X-CSE-ConnectionGUID: z+ElvKDpTq6UZM0twj+GcQ==
X-CSE-MsgGUID: 3X0Zh4cSQXqhQdR2yndncA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,278,1747724400"; d="scan'208";a="171169004"
Received: from silpixa00401176.ir.intel.com (HELO
 silpixa00401176.ger.corp.intel.com) ([10.237.222.172])
 by fmviesa004.fm.intel.com with ESMTP; 11 Aug 2025 06:43:04 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	anatoly.burakov@intel.com
Subject: [PATCH v2 0/6] Enable DCB/PFC support for ICE PMD
Date: Mon, 11 Aug 2025 13:42:55 +0000
Message-ID: <20250811134301.459523-1-vladimir.medvedkin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250807122238.334177-1-vladimir.medvedkin@intel.com>
References: <20250807122238.334177-1-vladimir.medvedkin@intel.com>
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

This series introduces an initial implementation of DCB and PFC to the ICE PMD.
This includes adding support for TCs in ice_aq_set_mac_cfg() and asymmetric DCB/PFC configuration in base code.

Current implementation relies on current API and has a number of limitation and assumptions such as:

- Symmetric DCB configuration with respect to RX/TX, only dcb_rx_conf is used
- All TCs are configured equally with respect to BW they share
- No support for Low Latency TCs
- All existing queues are split evenly across TCs. Number of queues must be power of 2 and be no less than configured nb_tcs
- TX queues assigned to TCs the same way as RX queues

v2:
 - fix spelling
 - replace rte_memcpy with memcpy()
 - fix endianness in several places

Vladimir Medvedkin (6):
  net/ice/base: add utility functions
  net/ice/base: make set MAC config TC aware
  net/ice/base: add support for asymmetric PFC
  net/ice: enable DCB support
  net/ice: enable PFC support
  net/ice: add PFC statistics

 drivers/net/intel/ice/base/ice_common.c | 178 +++++++++---
 drivers/net/intel/ice/base/ice_common.h |  12 +-
 drivers/net/intel/ice/base/ice_dcb.c    |  96 +++++-
 drivers/net/intel/ice/base/ice_dcb.h    |  16 +-
 drivers/net/intel/ice/base/ice_type.h   |   2 +
 drivers/net/intel/ice/ice_ethdev.c      | 370 +++++++++++++++++++++++-
 drivers/net/intel/ice/ice_rxtx.c        |  21 ++
 7 files changed, 634 insertions(+), 61 deletions(-)

-- 
2.43.0

