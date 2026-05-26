Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB34BCD5BCF
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 03:32:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2FD0140652;
	Tue, 26 May 2026 05:32:15 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [1.95.21.3])
 by mails.dpdk.org (Postfix) with ESMTP id A798540279
 for <dev@dpdk.org>; Tue, 26 May 2026 05:32:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=vgckMtAcF1djrqDuB6RAJMI1EPNLaqUrfOmZbZnwEhs=;
 b=B2NQwOdeKNnXeDVKMbYE0lN/1JDzZS2CO8xCfXI/umUlKWjdpj1/ww5RE3Lo2M
 7LF5/Z+2TkKTMn1xk8U7AuG7Y46zXPt8WSzInNfQg6dlmN1ISeYpas/IOiKC7LBe
 MmWN5F/ybSf7P+9FsbLkvig5rukUsGDa6RFyBqmAZRIq4=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp1 (Coremail) with SMTP id Ac8vCgCHTmo0FBVqDaWKCw--.46378S5;
 Tue, 26 May 2026 11:32:10 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>
Subject: [v3 1/1] net/hinic3: Fix VXLAN TSO issue
Date: Tue, 26 May 2026 11:31:45 +0800
Message-ID: <20260526033147.1045-2-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20260526033147.1045-1-wff_light@vip.163.com>
References: <20260520065817.931-2-wff_light@vip.163.com>
 <20260526033147.1045-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgCHTmo0FBVqDaWKCw--.46378S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF17JF1xJr4xWFWxtFy8uFg_yoW8Xr4DpF
 W5Gay8ZFWDtr4ku3Z8Wa1xuasxGw4UG3ykK3Zaya45uFyrZF12v34UKa43Aw13tr4xXFn7
 Zr1Du3sF9F12gaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UpGQDUUUUU=
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiMxry-GoVFDrmAAAA3Q
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

From: Feifei Wang <wangfeifei40@huawei.com>

VXLAN TSO lacks a flag bit, causing the processing function
to determine that the hardware does not support it, leading
to improper handling.

Signed-off-by: Feifei Wang <wangfeifei40@huawei.com>
---
 drivers/net/hinic3/hinic3_ethdev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index f4eb788..5071b64 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -652,6 +652,8 @@ hinic3_dev_configure(struct rte_eth_dev *dev)
 static void
 hinic3_dev_tnl_tso_support(struct rte_eth_dev_info *info, struct hinic3_nic_dev *nic_dev)
 {
+    if (HINIC3_SUPPORT_VXLAN_OFFLOAD(nic_dev))
+        info->tx_offload_capa |= RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO;
 	if (HINIC3_SUPPORT_GENEVE_OFFLOAD(nic_dev))
 		info->tx_offload_capa |= RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO;
 	if (HINIC3_SUPPORT_IPXIP_OFFLOAD(nic_dev))
@@ -698,7 +700,6 @@ hinic3_dev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *info)
 		RTE_ETH_TX_OFFLOAD_SCTP_CKSUM |
 		RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |
 		RTE_ETH_TX_OFFLOAD_TCP_TSO | RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
-	if (nic_dev->feature_cap & NIC_F_HTN_CMDQ)
 		hinic3_dev_tnl_tso_support(info, nic_dev);
 
 	info->hash_key_size = HINIC3_RSS_KEY_SIZE;
-- 
2.47.0.windows.2

