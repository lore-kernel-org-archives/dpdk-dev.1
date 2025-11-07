Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D979CCFA05
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Nov 2025 02:58:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 95CE64021F;
	Fri,  7 Nov 2025 03:58:48 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id F19D44013F;
 Fri,  7 Nov 2025 03:58:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762484327; x=1794020327;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=JnFRzrC+1Lb8JxMgwi6F18zSqWp58zT0TxR74ciqPAA=;
 b=OqlGi4YNqeJU4pswawfQAuqF+vY2hWGAoe8wOCcUfd3CFS9wlMlBt6xx
 6O/ILI9erR0DZ8MjefLp/9umdW2OAq8PsVCFswXOufA0yWkqs+W8x4y7w
 n6Nzy4BC51vMJTzQAGIRWo/xk7a9UiZOaQRCqv7c54RE09DrcY3YuTFSf
 7fph4IK/8RpthitvCcMw5tm1BVH8zV1ZGuzRkUKMd4yLKigrxfbv/hYlp
 HPiWa3SrED7NlXK5aULk2RaFiyFRmJbm2Bog5sxE+I1eeUNnmRmzBhmnc
 VlGzoGITWvYfZdpdNBJD3ElnJtTOk2l8jpUqis73mnQsAJlMx3Pq9r6R1 g==;
X-CSE-ConnectionGUID: UHiAvuOZSgiP/s7HTTLAyA==
X-CSE-MsgGUID: g4eyeskkTHGlCAJCyxpbJA==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="74925263"
X-IronPort-AV: E=Sophos;i="6.19,285,1754982000"; d="scan'208";a="74925263"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 18:58:46 -0800
X-CSE-ConnectionGUID: Lg3hVmwZQWmyqP/Z8Mg+QA==
X-CSE-MsgGUID: jL+Y/dMsTSmXpsvkhcp9EA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,285,1754982000"; d="scan'208";a="192193813"
Received: from peter-x299-ud4-pro.png.intel.com ([10.158.122.68])
 by fmviesa005.fm.intel.com with ESMTP; 06 Nov 2025 18:58:44 -0800
From: Song Yoong Siang <yoong.siang.song@intel.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 David Zage <david.zage@intel.com>, dev@dpdk.org
Cc: stable@dpdk.org
Subject: [PATCH v1 1/1] net/e1000: use device timestamp for igc read_clock()
 operation
Date: Fri,  7 Nov 2025 11:15:07 +0800
Message-ID: <20251107031507.3890366-1-yoong.siang.song@intel.com>
X-Mailer: git-send-email 2.48.1
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

Change eth_igc_read_clock() to read from hardware timestamp registers
(E1000_SYSTIML/E1000_SYSTIMH) instead of using system clock_gettime().

This ensures that the clock reading is consistent with the hardware's
internal time base used for Qbv cycle and launch time scheduling,
providing better accuracy for Time-Sensitive Networking applications.

Fixes: 9630f7c71ecd ("net/igc: enable launch time offloading")
Cc: stable@dpdk.org

Signed-off-by: David Zage <david.zage@intel.com>
Signed-off-by: Song Yoong Siang <yoong.siang.song@intel.com>
---
 drivers/net/intel/e1000/igc_ethdev.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/e1000/igc_ethdev.c b/drivers/net/intel/e1000/igc_ethdev.c
index b9c91d2446..045f7c784d 100644
--- a/drivers/net/intel/e1000/igc_ethdev.c
+++ b/drivers/net/intel/e1000/igc_ethdev.c
@@ -2972,10 +2972,18 @@ eth_igc_timesync_disable(struct rte_eth_dev *dev)
 static int
 eth_igc_read_clock(__rte_unused struct rte_eth_dev *dev, uint64_t *clock)
 {
-	struct timespec system_time;
+	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
+	uint32_t nsec, sec;
 
-	clock_gettime(CLOCK_REALTIME, &system_time);
-	*clock = system_time.tv_sec * NSEC_PER_SEC + system_time.tv_nsec;
+	/*
+	 * Reading the SYSTIML register latches the upper 32 bits to the SYSTIMH
+	 * shadow register for coherent access. As long as we read SYSTIML first
+	 * followed by SYSTIMH, we avoid race conditions where the time rolls
+	 * over between the two register reads.
+	 */
+	nsec = E1000_READ_REG(hw, E1000_SYSTIML);
+	sec = E1000_READ_REG(hw, E1000_SYSTIMH);
+	*clock = (uint64_t)sec * NSEC_PER_SEC + (uint64_t)nsec;
 
 	return 0;
 }
-- 
2.48.1

