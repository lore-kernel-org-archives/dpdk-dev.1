Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED012CA0FFE
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Sep 2025 10:49:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1B6F4065C;
	Tue,  2 Sep 2025 12:49:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 32763402B2
 for <dev@dpdk.org>; Tue,  2 Sep 2025 12:49:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1756810166; x=1788346166;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=D3zmRrHEiaTCV7n63GXxT8G+n2N9kOsQCSXMm3rbHnE=;
 b=fm1zWbqPT1Yn3P8Ep61tLeDmjoN4IfJRuPXgE4TTL9LxrfO0tCiGQ9U3
 BOu86rNJ1qNpaFLc42OAEzhsBM6AqMFBFCx2vc4dXkVryaTrsbSXk3W1s
 D2SEUuzrXms6h1ZI64Huf2JiCok4PAVFitedrtXZQ0i+YU478juDHXjCR
 rMGJvueiKoenH0+dq5CFtfT7SiMhUAcA/G4WXzJGPVw1YHPlvoroIuzzm
 ZrQHGdkh3+1Rx7d4y35pnS38nowIuvncMgUo+9XRX4IrDqUWcWujwOHwK
 vEuQjeZfmt3tgbSYzdIhHgkMF8yn22hSy/weGhDn+FgqQaBpjIpBWYzT3 A==;
X-CSE-ConnectionGUID: lL/k4W8NRC+h/vsstJ9UIg==
X-CSE-MsgGUID: oNnNMUksSuqJBTmnSAO3vg==
X-IronPort-AV: E=McAfee;i="6800,10657,11540"; a="59014550"
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; d="scan'208";a="59014550"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2025 03:49:25 -0700
X-CSE-ConnectionGUID: gDyyzbSuQEOGMM0J2SX+0Q==
X-CSE-MsgGUID: WKFyLN4uQMm9Y01RlOD4gA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,230,1751266800"; d="scan'208";a="175609390"
Received: from silpixa00401177.ir.intel.com ([10.237.213.77])
 by orviesa004.jf.intel.com with ESMTP; 02 Sep 2025 03:49:25 -0700
From: Ciara Loftus <ciara.loftus@intel.com>
To: dev@dpdk.org
Cc: Ciara Loftus <ciara.loftus@intel.com>
Subject: [PATCH v2 2/4] net/i40e: fix vector Rx queue set up logic
Date: Tue,  2 Sep 2025 10:48:57 +0000
Message-Id: <20250902104859.2100141-3-ciara.loftus@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250902104859.2100141-1-ciara.loftus@intel.com>
References: <20250901095953.1858938-1-ciara.loftus@intel.com>
 <20250902104859.2100141-1-ciara.loftus@intel.com>
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

The logic to set up a vector Rx queue was present in two places, before
and after the Rx path was selected. In some cases, the rx queue would
have been set up for vector Rx twice. Another scenario could occur where
first the queue was set up for vector rx, then the scalar path selected
but the vector rx setup would still persist. This of course would be
incorrect behaviour, so it has been fixed by removing the setup logic
that was before the path select code.

Fixes: 052ae311091c ("net/i40e: use the common Rx path selection infrastructure")

Signed-off-by: Ciara Loftus <ciara.loftus@intel.com>
---
 drivers/net/intel/i40e/i40e_rxtx.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/net/intel/i40e/i40e_rxtx.c b/drivers/net/intel/i40e/i40e_rxtx.c
index 4c0d12c179..434959e1c0 100644
--- a/drivers/net/intel/i40e/i40e_rxtx.c
+++ b/drivers/net/intel/i40e/i40e_rxtx.c
@@ -3356,17 +3356,6 @@ i40e_set_rx_function(struct rte_eth_dev *dev)
 
 		rx_simd_width = RTE_VECT_SIMD_DISABLED;
 	}
-	if (rx_simd_width != RTE_VECT_SIMD_DISABLED) {
-		for (i = 0; i < dev->data->nb_rx_queues; i++) {
-			struct ci_rx_queue *rxq =
-				dev->data->rx_queues[i];
-
-			if (rxq && i40e_rxq_vec_setup(rxq)) {
-				rx_simd_width = RTE_VECT_SIMD_DISABLED;
-				break;
-			}
-		}
-	}
 
 	req_features.simd_width = rx_simd_width;
 	if (dev->data->scattered_rx)
-- 
2.34.1

