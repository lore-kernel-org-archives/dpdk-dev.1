Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456B1C02192
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jan 2025 13:03:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C9DA442DD6;
	Fri, 31 Jan 2025 14:00:14 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id 8706342E3A;
 Fri, 31 Jan 2025 14:00:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1738328405; x=1769864405;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=rAb6+rTAskPMNhNkzrQoEwuo0SJeWIr1cYKLnK/dL8U=;
 b=OU00RUpqYz8h1gktuvE2djLJM7xhBtyfV9Ti+pZEDTMDv5rgDtJTwgvR
 cO/Joo0IW0cKR75SO/2m6cXb6OWAUiHcQgkFlC/q9FkHsZgeNDDCyRy6n
 FMBI41BToNyD3O8jA9c0jGOZwM8DzHYMi1pauCSGuDpAvxVZrsK9uwkD8
 ZOM3cSD7DwDDi7MxLxKk7Bfs5nNowtCtQmVdvgUPcuNdT86D8aFxLW9tv
 pkaC0vvNH/8SuLmETcXmXv5zSLGbtMzw/hiYYutTUyCeOap9ruttVWW+K
 1luufG7RFMY5OnZCmT9u4wEtXqGnfz7GKZ7VJg4Tu9yuWU77WiwHGvhva w==;
X-CSE-ConnectionGUID: e2NBugE6T4SyoVhzSYQOZA==
X-CSE-MsgGUID: iLZaXjPISL2DgUnKJdRmdQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="50315676"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; d="scan'208";a="50315676"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jan 2025 05:00:04 -0800
X-CSE-ConnectionGUID: m9QDuzJVST2JGaXpw6RGjQ==
X-CSE-MsgGUID: JMjxt+n1ShWABKEVL8FrJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; d="scan'208";a="140503475"
Received: from silpixa00401119.ir.intel.com ([10.55.129.167])
 by fmviesa001.fm.intel.com with ESMTP; 31 Jan 2025 05:00:03 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Cc: stable@dpdk.org
Subject: [PATCH v1 36/42] net/e1000/base: fix reset for 82580
Date: Fri, 31 Jan 2025 12:58:49 +0000
Message-ID: <b353fc594d9b985b80b205eb27c9d874d656358c.1738328108.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1738328106.git.anatoly.burakov@intel.com>
References: <cover.1738328106.git.anatoly.burakov@intel.com>
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

From: Barbara Skobiej <barbara.skobiej@intel.com>

Fix setting device reset status bit in e1000_reset_hw_82580() function
for 82580 by first reading the register value, and then setting the
device reset bit.

Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: Barbara Skobiej <barbara.skobiej@intel.com>
Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/e1000/base/e1000_82575.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/e1000/base/e1000_82575.c b/drivers/net/intel/e1000/base/e1000_82575.c
index ff5a5cad80..34b315a540 100644
--- a/drivers/net/intel/e1000/base/e1000_82575.c
+++ b/drivers/net/intel/e1000/base/e1000_82575.c
@@ -2272,7 +2272,7 @@ STATIC s32 e1000_reset_hw_82580(struct e1000_hw *hw)
 	s32 ret_val = E1000_SUCCESS;
 	/* BH SW mailbox bit in SW_FW_SYNC */
 	u16 swmbsw_mask = E1000_SW_SYNCH_MB;
-	u32 ctrl;
+	u32 ctrl, status;
 	bool global_device_reset = hw->dev_spec._82575.global_device_reset;
 
 	DEBUGFUNC("e1000_reset_hw_82580");
@@ -2337,7 +2337,8 @@ STATIC s32 e1000_reset_hw_82580(struct e1000_hw *hw)
 	}
 
 	/* clear global device reset status bit */
-	E1000_WRITE_REG(hw, E1000_STATUS, E1000_STAT_DEV_RST_SET);
+	status = E1000_READ_REG(hw, E1000_STATUS);
+	E1000_WRITE_REG(hw, E1000_STATUS, status | E1000_STAT_DEV_RST_SET);
 
 	/* Clear any pending interrupt events. */
 	E1000_WRITE_REG(hw, E1000_IMC, 0xffffffff);
-- 
2.43.5

