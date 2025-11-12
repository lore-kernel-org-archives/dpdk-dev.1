Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A98CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 14:11:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78FF6406BC;
	Wed, 12 Nov 2025 15:11:07 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 168B2402AF;
 Wed, 12 Nov 2025 15:11:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762956666; x=1794492666;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=IovaTmsqsLyf6GlTVt5QGEsCey6ry6YlwO7vkhdCegA=;
 b=hEeLtmqLjWoQeBOCD7Nkpp6tC2vlQ3Mvkf5juuIv8GRcldx/aJ3PFCdF
 1cdjvWGZa4CHOC0HhdZ/360woBxIQXkQhRnF802dlF30zF4HBEk5MAu0C
 mToqIq1Rnq7ht5ASXsmX6AU9zzGRXAw46P2i6+8+Uvi7DJkuP4HvhfoNn
 p1ZPbQ1c7+7WXkxUynyAtf4iIEHjY5TffAeQoXr+Sjh4XRDYV2OCjKlmN
 JGaw27li/jblnJ+TJ9n3dg+AmOIFBi564nHN7AeGFWMIPW9XMIU2wgueF
 nwVtvg08oddp0RWstiutiAsokBFcj9IPP5WXz4V3XpQcMjvWT852Dnr4R A==;
X-CSE-ConnectionGUID: 0b29DJvfRheHndk7fG5dfg==
X-CSE-MsgGUID: 7oTccyZ2RomCrdyI8BwRhA==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="82415958"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; d="scan'208";a="82415958"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2025 06:11:05 -0800
X-CSE-ConnectionGUID: wCiDe2gQTRur6l8WOfIytQ==
X-CSE-MsgGUID: ivvaR8mFRC6zdZOYimylag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; d="scan'208";a="226500118"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 12 Nov 2025 06:11:04 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Sunil Kumar Kori <skori@marvell.com>, stable@dpdk.org,
 Hailin Xu <hailinx.xu@intel.com>
Subject: [PATCH v2 1/3] net/ice: fix null packet prepare function
Date: Wed, 12 Nov 2025 14:10:57 +0000
Message-ID: <20251112141059.1576919-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251112141059.1576919-1-bruce.richardson@intel.com>
References: <20251110122457.2575615-1-skori@marvell.com>
 <20251112141059.1576919-1-bruce.richardson@intel.com>
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

From: Sunil Kumar Kori <skori@marvell.com>

As per recent change by the following commit:

commit 066f3d9cc21c ("ethdev: remove callback checks from fast path")

framework unconditionally invokes dev->tx_pkt_prepare.
Due to this, ICE driver gets crashed as tx_pkt_prepare
was set to NULL during initialization.

Ensure dev->tx_pkt_prepare is not NULL when vector or simple
TX paths are selected, by assigning rte_eth_tx_pkt_prepare_dummy.

This aligns with expectations with above mentioned commit.

Bugzilla ID: 1795
Fixes: 6eac0b7fde95 ("net/ice: support advance Rx/Tx")
Cc: stable@dpdk.org

Signed-off-by: Sunil Kumar Kori <skori@marvell.com>
Tested-by: Hailin Xu <hailinx.xu@intel.com>
---
 drivers/net/intel/ice/ice_rxtx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 2673e885c3..74db0fbec9 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -4129,7 +4129,7 @@ ice_set_tx_function(struct rte_eth_dev *dev)
 	}
 
 	if (ad->tx_vec_allowed) {
-		dev->tx_pkt_prepare = NULL;
+		dev->tx_pkt_prepare = rte_eth_tx_pkt_prepare_dummy;
 		if (ad->tx_simd_width == RTE_VECT_SIMD_512) {
 #ifdef CC_AVX512_SUPPORT
 			if (tx_check_ret == ICE_VECTOR_OFFLOAD_PATH) {
@@ -4175,7 +4175,7 @@ ice_set_tx_function(struct rte_eth_dev *dev)
 	if (ad->tx_simple_allowed) {
 		PMD_INIT_LOG(DEBUG, "Simple tx finally be used.");
 		dev->tx_pkt_burst = ice_xmit_pkts_simple;
-		dev->tx_pkt_prepare = NULL;
+		dev->tx_pkt_prepare = rte_eth_tx_pkt_prepare_dummy;
 	} else {
 		PMD_INIT_LOG(DEBUG, "Normal tx finally be used.");
 		dev->tx_pkt_burst = ice_xmit_pkts;
-- 
2.48.1

