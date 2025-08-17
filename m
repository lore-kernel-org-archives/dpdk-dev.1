Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 494EFCA0EE4
	for <dpdk-dev@archiver.kernel.org>; Sun, 17 Aug 2025 13:02:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1ADFC4014F;
	Sun, 17 Aug 2025 15:02:01 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 3816D4003C
 for <dev@dpdk.org>; Sun, 17 Aug 2025 15:01:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1755435717; x=1786971717;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=YlgZFM6xsjvqfnyKfuNadSTAH3zHvG5Jj4UC1CP9CwM=;
 b=DFTn0dFC4i8VH3dEBrsgd2AIX6LmTl1MTxr4NN57wHR1KHOaBzI6U4pV
 VOKzeiunln+0Z8kk/pzgAv4xX3l4G3jyLYr2eOv+QFKEYwB64tn4EnI/Q
 RPwYJZ16uHz72FDsV+Ll961x6nz8klE8GIjJgyTADDMQSRd+pSSsqfgrh
 ab+uc+3nt1tcnctfzbl4UQc9hKS89XcUVYIo2GRidni20KswChMUe99K9
 d02pTnpuw/vIflrIAnm44yBSHFJVS+W1eI2ZMOLazRoCZeM56BPUdXw20
 t5woSjmrn0VZ3XDxJQ91UITg7gRK0HB6cx0t99Yz73AenFQ7oVGAliHmm Q==;
X-CSE-ConnectionGUID: jcwy7526SbGGG1dUb5grCw==
X-CSE-MsgGUID: TwXADPj9Q1avZZQctBoxvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11524"; a="57756057"
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; d="scan'208";a="57756057"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2025 06:01:56 -0700
X-CSE-ConnectionGUID: bcP0QXVGSPC062gPDn2SXA==
X-CSE-MsgGUID: LyK725NTSg6DMsK/QuDJ6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,293,1747724400"; d="scan'208";a="171581443"
Received: from silpixa00401176.ir.intel.com (HELO
 silpixa00401176.ger.corp.intel.com) ([10.237.222.172])
 by fmviesa005.fm.intel.com with ESMTP; 17 Aug 2025 06:01:55 -0700
From: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com,
	anatoly.burakov@intel.com
Subject: [PATCH v4 0/6] Enable DCB/PFC support for ICE PMD
Date: Sun, 17 Aug 2025 13:01:46 +0000
Message-ID: <20250817130152.682972-1-vladimir.medvedkin@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250812173252.507954-1-vladimir.medvedkin@intel.com>
References: <20250812173252.507954-1-vladimir.medvedkin@intel.com>
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

v4:
- fix more endianness

v3:
 - ice_get_tc_by_up() is renamed to ice_get_tc_by_priority() for better clarity
 - added ice_aq_set_mac_pfc_cfg(). Old ice_aq_set_mac_cfg() is a wrapper around a new function to keep better backward compatibility with an old code
 - removed rte_memcpy() and memcry() with direct assignment
 - addressed various style-related comments

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

 drivers/net/intel/ice/base/ice_common.c | 191 +++++++++---
 drivers/net/intel/ice/base/ice_common.h |  11 +
 drivers/net/intel/ice/base/ice_dcb.c    |  96 +++++-
 drivers/net/intel/ice/base/ice_dcb.h    |  16 +-
 drivers/net/intel/ice/base/ice_type.h   |   2 +
 drivers/net/intel/ice/ice_ethdev.c      | 370 ++++++++++++++++++++++++
 drivers/net/intel/ice/ice_rxtx.c        |  21 ++
 7 files changed, 650 insertions(+), 57 deletions(-)

-- 
2.43.0

