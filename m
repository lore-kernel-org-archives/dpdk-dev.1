Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178BCD37E56
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 15:46:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E645E40E13;
	Wed, 14 Jan 2026 16:45:22 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id A30A740B8D
 for <dev@dpdk.org>; Wed, 14 Jan 2026 16:45:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768405521; x=1799941521;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=BD9AYqJbD6ejB2VFYDXZDZ1fK6gKDRMFlgPS5s7ytoM=;
 b=HSCbw0LwDKZbcMnDPdv3H+QU3cQJmEVYCfdTaFwUepzFgssHjzFu6i36
 +Pb5m189ZiPtK2d9w9iTon+YOyA+IJLV+zrXAgwpmvft9tRIxirTj1TFB
 X2BlGWqQdq/kGap8ADVseB2FSmSzip4q/7OSTYG2qT3UH6njQYxvyyK1W
 rDoywWMQDr38IMbpw9crerstOcz4kW2OfUAAfK6qGxhpbA+9Spp/sH9+n
 XC8N44e2ihx0Zaxr1AUkCDkLsZ+6koQlAYLRh/iNbNOqKoXz29g0LURRc
 nXtKHlcUsCkC8MST21/fsLwC7p+YlUY8IjCgLuu2P4LjIWsE0haN69C2L Q==;
X-CSE-ConnectionGUID: tJbYvaCOQTesJGX9AMRgdA==
X-CSE-MsgGUID: C+qA8v5ZQXeqVZjFJ1gOIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69870851"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="69870851"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2026 07:45:21 -0800
X-CSE-ConnectionGUID: rxGzHZMrQdKm29Zg5iHdxg==
X-CSE-MsgGUID: k2Y8aWNPTWC7OXR8HHGQLg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="203925002"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 14 Jan 2026 07:45:19 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 12/31] net/intel: rename function param to avoid shadow
 warnings
Date: Wed, 14 Jan 2026 15:44:26 +0000
Message-ID: <20260114154450.2969716-13-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260114154450.2969716-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20260114154450.2969716-1-bruce.richardson@intel.com>
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

The rx_free_thresh parameter was conflicting with a global value in
testpmd when certain driver-specific files were included in the testpmd
build. Rename the parameter to just "free_thresh" - the "rx" is
unnecessary since the function itself is for Rx queues.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/intel/common/rx.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/rx.h
index ea7fb98b47..463d1eb834 100644
--- a/drivers/net/intel/common/rx.h
+++ b/drivers/net/intel/common/rx.h
@@ -228,11 +228,11 @@ ci_rxq_mbuf_initializer(uint16_t port_id)
  * Individual drivers may have other further tests beyond this.
  */
 static inline bool
-ci_rxq_vec_capable(uint16_t nb_desc, uint16_t rx_free_thresh)
+ci_rxq_vec_capable(uint16_t nb_desc, uint16_t free_thresh)
 {
 	if (!rte_is_power_of_2(nb_desc) ||
-			rx_free_thresh < CI_RX_MAX_BURST ||
-			(nb_desc % rx_free_thresh) != 0)
+			free_thresh < CI_RX_MAX_BURST ||
+			(nb_desc % free_thresh) != 0)
 		return false;
 
 	return true;
-- 
2.51.0

