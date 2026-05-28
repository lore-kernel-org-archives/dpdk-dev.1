Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2709CCD5BD1
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 May 2026 10:58:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 433A5402EE;
	Thu, 28 May 2026 12:58:55 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.220])
 by mails.dpdk.org (Postfix) with ESMTP id CDD0C4021F;
 Thu, 28 May 2026 12:58:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=KNGiHT85OhoVzALQ1QUZLbpxalUS3Rlp+eiLjND4xE4=;
 b=RDFEwU0umxPy+f1yJgLO+XGuG5P0cruXer7XBpTHGTUJ6gIU/Hk+Whoo+g54Gf
 7CddVwbG0A/9IkJf0kZweZEVgW9DppSTrtkHyM/sIEj3OHKltVhmUBkoceUs2gNS
 RYviwZXNY5aV7B6d4e1iw1waBqf41C4s6XRv9uJbImdZo=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgBn+mzmHxhq2FbeCw--.38948S4;
 Thu, 28 May 2026 18:58:49 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
	stable@dpdk.org
Subject: [v5 1/1] net/hinic3: Fix VXLAN TSO issue
Date: Thu, 28 May 2026 18:58:29 +0800
Message-ID: <20260528105831.1158-1-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20260526121820.1093-2-wff_light@vip.163.com>
References: <20260526121820.1093-2-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgBn+mzmHxhq2FbeCw--.38948S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7CF17CF1kXw48Jr1kAryrWFg_yoW8AryrpF
 W5GayUXFWDJrs7u3Z8Wa1xCas8Gw4UC3y2k3WSya45ua48ZF12v34Uta47Aryrtr4fXFn7
 Zr1DZ34qkF12gF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UdcTQUUUUU=
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNwmirGoYH+lmCgAA3Y
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

Fixes: 7608f0367d ("net/hinic3: add dev ops")
Cc: stable@dpdk.org

Signed-off-by: Feifei Wang <wangfeifei40@huawei.com>
---
 drivers/net/hinic3/hinic3_ethdev.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index f4eb788..66c5c3a 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -652,8 +652,12 @@ hinic3_dev_configure(struct rte_eth_dev *dev)
 static void
 hinic3_dev_tnl_tso_support(struct rte_eth_dev_info *info, struct hinic3_nic_dev *nic_dev)
 {
+	if (HINIC3_SUPPORT_VXLAN_OFFLOAD(nic_dev))
+		info->tx_offload_capa |= RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO;
+
 	if (HINIC3_SUPPORT_GENEVE_OFFLOAD(nic_dev))
 		info->tx_offload_capa |= RTE_ETH_TX_OFFLOAD_GENEVE_TNL_TSO;
+
 	if (HINIC3_SUPPORT_IPXIP_OFFLOAD(nic_dev))
 		info->tx_offload_capa |= RTE_ETH_TX_OFFLOAD_IPIP_TNL_TSO;
 }
@@ -698,8 +702,8 @@ hinic3_dev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *info)
 		RTE_ETH_TX_OFFLOAD_SCTP_CKSUM |
 		RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |
 		RTE_ETH_TX_OFFLOAD_TCP_TSO | RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
-	if (nic_dev->feature_cap & NIC_F_HTN_CMDQ)
-		hinic3_dev_tnl_tso_support(info, nic_dev);
+
+	hinic3_dev_tnl_tso_support(info, nic_dev);
 
 	info->hash_key_size = HINIC3_RSS_KEY_SIZE;
 	info->reta_size = HINIC3_RSS_INDIR_SIZE;
-- 
2.47.0.windows.2

