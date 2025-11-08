Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70E9CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Sat,  8 Nov 2025 07:49:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 56067402CD;
	Sat,  8 Nov 2025 08:49:48 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by mails.dpdk.org (Postfix) with ESMTP id C6B22400D5;
 Sat,  8 Nov 2025 08:49:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762588187; x=1794124187;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=Yh/7DfFEZrSbcnYCKDuRUFrVGD11wNw8lNIhCn18fLY=;
 b=V0e0+Br2tgU9k0u1z33taY+JuTR7HbkXbgloXQldndZbjgjD9z+cBNgK
 pkpSk0gdWzGzjJAhOQJJ52yKx+6KyCmAq4NHpuZP4Htl4TUaSwfyBHPOV
 Hij47sDP+p5E8H2M0tIsGLKva8UIZWoYkWSiLd+PZgRT8CgbZoCk1+fkj
 PaGtY1I1zpz1rP8fEGoq6yjXuRjI2Y/iG+4bDmeB8Nefl3v18JqCAiP3+
 Cx9Q77+H9+izs6EluEcgVKNBqODiRvkXRYCxLl2H8n3qEgUVpa/40Yt8Z
 MRbjGDNZ3WvYYPHxNALYNxFT25YZevPWh/44uNtNrYhwy/gqYx4S6Omz8 g==;
X-CSE-ConnectionGUID: xUYNsovAQIS6nltuTov78A==
X-CSE-MsgGUID: BMR+ox92Q+Ke1ofzWUaL9g==
X-IronPort-AV: E=McAfee;i="6800,10657,11606"; a="64763039"
X-IronPort-AV: E=Sophos;i="6.19,289,1754982000"; d="scan'208";a="64763039"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2025 23:49:46 -0800
X-CSE-ConnectionGUID: QkKc5/LeTc2TjDsM5fq9Jw==
X-CSE-MsgGUID: b8s2O48dRiCdVhwoyIpLzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,289,1754982000"; d="scan'208";a="192338473"
Received: from peter-x299-ud4-pro.png.intel.com ([10.158.122.68])
 by orviesa003.jf.intel.com with ESMTP; 07 Nov 2025 23:49:45 -0800
From: Song Yoong Siang <yoong.siang.song@intel.com>
To: Bruce Richardson <bruce.richardson@intel.com>,
 David Zage <david.zage@intel.com>,
 Soumyadeep Hore <soumyadeep.hore@intel.com>, dev@dpdk.org
Cc: stable@dpdk.org
Subject: [PATCH v2 1/1] net/e1000: use device timestamp for igc read_clock()
 operation
Date: Sat,  8 Nov 2025 16:06:13 +0800
Message-ID: <20251108080613.123969-1-yoong.siang.song@intel.com>
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
v1: https://patches.dpdk.org/project/dpdk/patch/20251107031507.3890366-1-yoong.siang.song@intel.com/

changelog:
v1 -> v2
- reuse the existing eth_igc_timesync_read_time() (Soumyadeep).
---
 drivers/net/intel/e1000/igc_ethdev.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/e1000/igc_ethdev.c b/drivers/net/intel/e1000/igc_ethdev.c
index b9c91d2446..d4edc82668 100644
--- a/drivers/net/intel/e1000/igc_ethdev.c
+++ b/drivers/net/intel/e1000/igc_ethdev.c
@@ -2813,6 +2813,12 @@ eth_igc_timesync_read_time(struct rte_eth_dev *dev, struct timespec *ts)
 {
 	struct e1000_hw *hw = IGC_DEV_PRIVATE_HW(dev);
 
+	/*
+	 * Reading the SYSTIML register latches the upper 32 bits to the SYSTIMH
+	 * shadow register for coherent access. As long as we read SYSTIML first
+	 * followed by SYSTIMH, we avoid race conditions where the time rolls
+	 * over between the two register reads.
+	 */
 	ts->tv_nsec = E1000_READ_REG(hw, E1000_SYSTIML);
 	ts->tv_sec = E1000_READ_REG(hw, E1000_SYSTIMH);
 
@@ -2972,10 +2978,10 @@ eth_igc_timesync_disable(struct rte_eth_dev *dev)
 static int
 eth_igc_read_clock(__rte_unused struct rte_eth_dev *dev, uint64_t *clock)
 {
-	struct timespec system_time;
+	struct timespec ts;
 
-	clock_gettime(CLOCK_REALTIME, &system_time);
-	*clock = system_time.tv_sec * NSEC_PER_SEC + system_time.tv_nsec;
+	eth_igc_timesync_read_time(dev, &ts);
+	*clock = rte_timespec_to_ns(&ts);
 
 	return 0;
 }
-- 
2.48.1

