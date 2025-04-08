Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1358CC369A6
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 15:57:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F375040264;
	Tue,  8 Apr 2025 17:57:42 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id CD898400D7;
 Tue,  8 Apr 2025 17:57:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1744127862; x=1775663862;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=LomwNPmMKF1s/uMD81/bylLWyNdpy7LLEiDAd0JuILU=;
 b=g3JNXdctRLx2rY1a7lHv1u2c8Nk9DsZ/NFWAnCY2bWWyTqZWY2bPccGd
 dyhPvNdz/HmoUca5Fds7oXLlJyH5sINu6vEJpK2lHMj75hctNd/LlQ+IQ
 2p1r2DfK+i4rKOQy+zcGWtSXOgyOJbDSV5wJfVgVjqBe6mYaJZONEYWik
 XpdvO17Vlqop9eT64jJAhsPD2IoPB5b2yNSqIKETT+N8pj07d4W4+RFAI
 t+RsyNui2zUsYnzQTiCU3tGQYaAyuCh8E9vFBbWQQMz7oRRgPUuJTLJWA
 QR5hBjwKsX7zQPLa+H2LDpwImsMcV13ON+85QJ6GzPTRLnRD4TH3L2uQu w==;
X-CSE-ConnectionGUID: oYwJ22+ySCaTvCQJuqzckA==
X-CSE-MsgGUID: bDdkGSGlSf2jJZJ5St164A==
X-IronPort-AV: E=McAfee;i="6700,10204,11397"; a="45732630"
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; d="scan'208";a="45732630"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2025 08:57:41 -0700
X-CSE-ConnectionGUID: C6IPpmThTh2rX60qIufmzg==
X-CSE-MsgGUID: CGXQOrtyRFuRjw6tcIFC7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,198,1739865600"; d="scan'208";a="128843937"
Received: from unknown (HELO silpixa00401385.ir.intel.com) ([10.237.214.31])
 by orviesa007.jf.intel.com with ESMTP; 08 Apr 2025 08:57:40 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>, stable@dpdk.org,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH] net/ice: fix Rx of large packets
Date: Tue,  8 Apr 2025 16:57:36 +0100
Message-ID: <20250408155736.2739406-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.45.2
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

The determination of whether or not the buffer size is less than the
packet MTU is made in the Rx queue start function in the ice driver.
This means that we cannot choose the Rx function before we have started
the queues. Move the Rx function section down in the code to fix this.

Fixes: 3c79a3d91d9d ("net/ice: fix mbuf cleanup function")
Cc: stable@dpdk.org

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/ice/ice_ethdev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 21d3795954..2e163d706c 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -3965,7 +3965,7 @@ ice_dev_start(struct rte_eth_dev *dev)
 	ice_declare_bitmap(pmask, ICE_PROMISC_MAX);
 	ice_zero_bitmap(pmask, ICE_PROMISC_MAX);
 
-	ice_set_rx_function(dev);
+	/* choose vector Tx function before starting queues */
 	ice_set_tx_function(dev);
 
 	/* program Tx queues' context in hardware */
@@ -3996,6 +3996,9 @@ ice_dev_start(struct rte_eth_dev *dev)
 		}
 	}
 
+	/* we need to choose Rx fn after queue start, when we know if we need scattered Rx */
+	ice_set_rx_function(dev);
+
 	mask = RTE_ETH_VLAN_STRIP_MASK | RTE_ETH_VLAN_FILTER_MASK |
 			RTE_ETH_VLAN_EXTEND_MASK;
 	if (ice_is_dvm_ena(hw))
-- 
2.45.2

