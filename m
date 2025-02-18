Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90D61C021AA
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Feb 2025 21:13:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9CEC7402A0;
	Tue, 18 Feb 2025 22:13:29 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id B2BCF40264;
 Tue, 18 Feb 2025 22:13:27 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id C0DD620376EA; Tue, 18 Feb 2025 13:13:26 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C0DD620376EA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
 s=default; t=1739913206;
 bh=uVIj4U68o6mmcrNZVH62Oxv3oJX8kiQ4UgHIVMnjxao=;
 h=From:To:Cc:Subject:Date:From;
 b=blqoHwmRMuajJRGoQe5RATb3AKjoay8rDKDbF1hNeb0LVY1JViYd9SElYDMnAIB7T
 CEuf/aJYsde5fpj90hF3XtZHrFNZFOdqvsovact4Y39b5WatP6TSD7sGUREXkNMoCa
 DF5OmCgkfmWmMIw7V4HiprZj3qG7zvxEcyVwI9qE=
From: longli@linuxonhyperv.com
To: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu <weh@microsoft.com>
Cc: dev@dpdk.org,
	Long Li <longli@microsoft.com>,
	stable@dpdk.org
Subject: [PATCH] net/netvsc: add stats counters from VF
Date: Tue, 18 Feb 2025 13:13:19 -0800
Message-Id: <1739913199-8988-1-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
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

From: Long Li <longli@microsoft.com>

The netvsc driver should add per-queue and rx_nombuf counters from VF.

Fixes: 4e9c73e96e83 ("net/netvsc: add Hyper-V network device")
Cc: stable@dpdk.org
Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/net/netvsc/hn_ethdev.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethdev.c
index 988c51928d..069d603d90 100644
--- a/drivers/net/netvsc/hn_ethdev.c
+++ b/drivers/net/netvsc/hn_ethdev.c
@@ -824,8 +824,8 @@ static int hn_dev_stats_get(struct rte_eth_dev *dev,
 		stats->oerrors += txq->stats.errors;
 
 		if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			stats->q_opackets[i] = txq->stats.packets;
-			stats->q_obytes[i] = txq->stats.bytes;
+			stats->q_opackets[i] += txq->stats.packets;
+			stats->q_obytes[i] += txq->stats.bytes;
 		}
 	}
 
@@ -841,12 +841,12 @@ static int hn_dev_stats_get(struct rte_eth_dev *dev,
 		stats->imissed += rxq->stats.ring_full;
 
 		if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
-			stats->q_ipackets[i] = rxq->stats.packets;
-			stats->q_ibytes[i] = rxq->stats.bytes;
+			stats->q_ipackets[i] += rxq->stats.packets;
+			stats->q_ibytes[i] += rxq->stats.bytes;
 		}
 	}
 
-	stats->rx_nombuf = dev->data->rx_mbuf_alloc_failed;
+	stats->rx_nombuf += dev->data->rx_mbuf_alloc_failed;
 	return 0;
 }
 
-- 
2.34.1

