Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AECCC6B1F
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 02:08:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BBDCA4060B;
	Wed, 14 Oct 2026 04:07:58 +0200 (CEST)
Received: from esa.hc5801-97.iphmx.com (esa.hc5801-97.iphmx.com
 [139.138.58.96])
 by mails.dpdk.org (Postfix) with ESMTP id 74D3040279;
 Wed, 14 Oct 2026 04:07:57 +0200 (CEST)
X-CSE-ConnectionGUID: VeNLmMsUSe2UsRbmICBsug==
X-CSE-MsgGUID: +D2eebfIQiG37SK6ZpJZog==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from unknown (HELO se3ccprlyapp01.olympus.f5net.com)
 ([104.219.104.72])
 by esa1.hc5801-97.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Oct 2026 19:08:01 -0700
Received: from K6FNKPXYVK.olympus.f5net.com ([172.18.4.35]) by
 se3ccprlyapp01.olympus.f5net.com over TLS secured channel with Microsoft
 SMTPSVC(10.0.17763.1697); Tue, 13 Oct 2026 19:07:55 -0700
From: Shrey Khandelwal <s.khandelwal@f5.com>
To: weh@microsoft.com
Cc: longli@microsoft.com, stephen@networkplumber.org, dev@dpdk.org,
 stable@dpdk.org
Subject: [PATCH 1/2] net/netvsc: fix link speed not updated
Date: Tue, 13 Oct 2026 19:07:43 -0700
Message-ID: <20261014020744.13605-2-s.khandelwal@f5.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261014020744.13605-1-s.khandelwal@f5.com>
References: <20261014020744.13605-1-s.khandelwal@f5.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 14 Oct 2026 02:07:55.0430 (UTC)
 FILETIME=[D38F2C60:01DD5B80]
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

hn_dev_link_update() returns without updating the cached link when
the link status has not changed. A speed change alone is never
reported, and if the link is down at port start, the cached speed
and duplex stay zero.

Always update the cached link, and only log when the status changes.

Fixes: 4e9c73e96e83 ("net/netvsc: add Hyper-V network device")
Cc: stable@dpdk.org

Signed-off-by: Shrey Khandelwal <s.khandelwal@f5.com>
---
 .mailmap                       | 1 +
 drivers/net/netvsc/hn_ethdev.c | 8 +++-----
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/.mailmap b/.mailmap
index 2e348c3bce..131b9f86cb 100644
--- a/.mailmap
+++ b/.mailmap
@@ -1558,6 +1558,7 @@ Shlomi Gridish <sgridish@marvell.com>
 Shougang Wang <shougangx.wang@intel.com>
 Shraddha Joshi <jshraddha@vmware.com>
 Shreesh Adiga <16567adigashreesh@gmail.com>
+Shrey Khandelwal <s.khandelwal@f5.com>
 Shreyansh Jain <shreyansh.jain@nxp.com>
 Shrikrishna Khare <skhare@vmware.com>
 Shu Shen <shu.shen@radisys.com>
diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethdev.c
index e4fdf89873..5dc91f9503 100644
--- a/drivers/net/netvsc/hn_ethdev.c
+++ b/drivers/net/netvsc/hn_ethdev.c
@@ -298,11 +298,9 @@ hn_dev_link_update(struct rte_eth_dev *dev,
 	else
 		link.link_status = RTE_ETH_LINK_DOWN;
 
-	if (old.link_status == link.link_status)
-		return 0;
-
-	PMD_INIT_LOG(DEBUG, "Port %d is %s", dev->data->port_id,
-		     (link.link_status == RTE_ETH_LINK_UP) ? "up" : "down");
+	if (old.link_status != link.link_status)
+		PMD_INIT_LOG(DEBUG, "Port %d is %s", dev->data->port_id,
+			     (link.link_status == RTE_ETH_LINK_UP) ? "up" : "down");
 
 	return rte_eth_linkstatus_set(dev, &link);
 }
-- 
2.55.0

