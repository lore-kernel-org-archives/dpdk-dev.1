Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF39FC55184
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 10:09:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A42F4064E;
	Fri, 20 Feb 2026 11:09:36 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 7E89840276;
 Fri, 20 Feb 2026 02:10:07 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id EA79820B6F00; Thu, 19 Feb 2026 17:10:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EA79820B6F00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1771549806;
 bh=C1TFytOMx2jqR8N0DNqjZvpDEFRTARKFZ1Q8zsifcAY=;
 h=From:To:Cc:Subject:Date:From;
 b=WSla9JHv9nRMXYSug3kh+ssboqJgWzccbe8B+qOi67ucA2u9cJcjcc/mBCf45g6+N
 SdKtg//23svQjq43HZi5VrXaAnIS7dlUl7r3bIuCEi8iEuOC1KWNKopjh3xhkEplA1
 8RrprkPVtlcZtd/zGLjDhH1p4tu9+mu8CbXI7d9Y=
From: longli@linux.microsoft.com
To: dev@dpdk.org, Stephen Hemminger <stephen@networkplumber.org>,
 Wei Hu <weh@microsoft.com>, stable@dpdk.org
Cc: Long Li <longli@microsoft.com>
Subject: [PATCH 1/8] net/netvsc: secondary ignore promiscuous enable/disable
Date: Thu, 19 Feb 2026 17:09:31 -0800
Message-ID: <20260220010938.595319-2-longli@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 20 Feb 2026 11:09:31 +0100
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

Secondary process should not attempt to configure promiscuous mode
on the netvsc device as it is managed by the primary process.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/net/netvsc/hn_ethdev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethdev.c
index 6584819f4f..5d7b410f1b 100644
--- a/drivers/net/netvsc/hn_ethdev.c
+++ b/drivers/net/netvsc/hn_ethdev.c
@@ -480,6 +480,9 @@ hn_dev_promiscuous_enable(struct rte_eth_dev *dev)
 {
 	struct hn_data *hv = dev->data->dev_private;
 
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return 0;
+
 	hn_rndis_set_rxfilter(hv, NDIS_PACKET_TYPE_PROMISCUOUS);
 	return hn_vf_promiscuous_enable(dev);
 }
@@ -490,6 +493,9 @@ hn_dev_promiscuous_disable(struct rte_eth_dev *dev)
 	struct hn_data *hv = dev->data->dev_private;
 	uint32_t filter;
 
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return 0;
+
 	filter = NDIS_PACKET_TYPE_DIRECTED | NDIS_PACKET_TYPE_BROADCAST;
 	if (dev->data->all_multicast)
 		filter |= NDIS_PACKET_TYPE_ALL_MULTICAST;
-- 
2.43.0

