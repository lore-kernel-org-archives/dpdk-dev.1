Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E76EEF30B
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Mar 2026 06:33:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E56B04029D;
	Thu,  5 Mar 2026 07:33:08 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 9B5714027A
 for <dev@dpdk.org>; Thu,  5 Mar 2026 07:33:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1772692387; x=1804228387;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=w7B9hxIpjC1+7majyGqgE+znJH3orSRZ7/H+Uu0EGts=;
 b=kmRFr0DBQq1VErQnc3CvaDRkEzoKT5BOOHmkCzKQcNP/WcmSSheT2pW5
 AUGh4J+dhjYH/H02Eq5xDZitTFhHEf7+T+M61Y1yD5ymmroaEZ+JNowrk
 8Yu0SqVThGL3vqh7qXFTfy5ahqN6gTBHQprfZ5dos0Zr8G7Tud+Ky32i+
 y4bmitBk6JD/MqFhgx+VMQ0XEqx+cYedeJ8W3Dr9rdUWqUWPZ50KC48Sl
 ftVOHL6nvllcY7yusbyPWZJ0KoKjacUugeE4CQ8mJL82wkyBuC9ahck8e
 tjDYWT/RGvsgZYnYkCh1CuCgX/Sor9X3y/1sGf6eft9j5/+DJSdqYlINO A==;
X-CSE-ConnectionGUID: r7o2WGYUSWyJpKuEW2n8Yw==
X-CSE-MsgGUID: kCJdsA0CTj6kudpFy86eyA==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="84855498"
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; d="scan'208";a="84855498"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Mar 2026 22:33:05 -0800
X-CSE-ConnectionGUID: jR6HvTssTRGorIcloadpUQ==
X-CSE-MsgGUID: 9hMS4tztSWqp47PVPAOeTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,325,1763452800"; d="scan'208";a="215429800"
Received: from icx005.iind.intel.com (HELO icx005..) ([10.190.212.217])
 by fmviesa006.fm.intel.com with ESMTP; 04 Mar 2026 22:33:03 -0800
From: AKSHATHA S <akshathax.s@intel.com>
To: dev@dpdk.org,
	bruce.richardson@intel.com,
	aman.deep.singh@intel.com
Cc: shaiq.wani@intel.com,
	AKSHATHA S <akshathax.s@intel.com>
Subject: [PATCH] net/e1000: align igb link update for consistency
Date: Thu,  5 Mar 2026 16:51:41 +0000
Message-ID: <20260305165142.89960-1-akshathax.s@intel.com>
X-Mailer: git-send-email 2.43.0
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

The igb PMD currently updates auto-neg status only during specific
link transitions. Updated auto-neg status regardless of link transition.

Signed-off-by: AKSHATHA S <akshathax.s@intel.com>
---
 drivers/net/intel/e1000/igb_ethdev.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/intel/e1000/igb_ethdev.c b/drivers/net/intel/e1000/igb_ethdev.c
index 1f51ba6406..ef1599ac38 100644
--- a/drivers/net/intel/e1000/igb_ethdev.c
+++ b/drivers/net/intel/e1000/igb_ethdev.c
@@ -2568,14 +2568,13 @@ eth_igb_link_update(struct rte_eth_dev *dev, int wait_to_complete)
 				RTE_ETH_LINK_HALF_DUPLEX;
 		link.link_speed = speed;
 		link.link_status = RTE_ETH_LINK_UP;
-		link.link_autoneg = !(dev->data->dev_conf.link_speeds &
-				RTE_ETH_LINK_SPEED_FIXED);
 	} else if (!link_check) {
 		link.link_speed = 0;
 		link.link_duplex = RTE_ETH_LINK_HALF_DUPLEX;
 		link.link_status = RTE_ETH_LINK_DOWN;
-		link.link_autoneg = RTE_ETH_LINK_FIXED;
 	}
+	link.link_autoneg = !(dev->data->dev_conf.link_speeds &
+			RTE_ETH_LINK_SPEED_FIXED);
 
 	return rte_eth_linkstatus_set(dev, &link);
 }
-- 
2.43.0

