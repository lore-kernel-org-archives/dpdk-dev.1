Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83B0CCD4F54
	for <dpdk-dev@archiver.kernel.org>; Sat, 23 May 2026 07:36:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 72903402F0;
	Sat, 23 May 2026 09:36:50 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.220])
 by mails.dpdk.org (Postfix) with ESMTP id 78A6E402CC
 for <dev@dpdk.org>; Sat, 23 May 2026 09:36:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=3eAhK+9sPfOqo5DU42l20xRFAcpj/CoyLH7UOvjaJkE=;
 b=JzArvIIrlRpnT2Ardn0DokMidLWNbU7NsHFXHrVXt2YM8DqsZZ84MMI6luqnZO
 zea1644hUTDmF9+qqnHLYc7BvqDpqWn19V0s1SSE9TW8+kzr9DpSTrHxZN+ut8tn
 4+9g2fu49HN77CmQxrFlxX5MeJdmwUcudG85dGL30G2bU=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp2 (Coremail) with SMTP id As8vCgAHjHYCWRFqzLsOCw--.49981S5;
 Sat, 23 May 2026 15:36:39 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>
Subject: [V2 1/1] net/hinic3: Fix VXLAN TSO issue
Date: Sat, 23 May 2026 15:36:17 +0800
Message-ID: <20260523073619.996-2-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20260523073619.996-1-wff_light@vip.163.com>
References: <20260520065817.931-2-wff_light@vip.163.com>
 <20260523073619.996-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: As8vCgAHjHYCWRFqzLsOCw--.49981S5
X-Coremail-Antispam: 1Uf129KBjvdXoW7JF17AFy7Zr1xZFyrJF1fZwb_yoWkurg_ur
 y09r47Cr1DWF4Yy34Fka1S934UKr10gw1kAFy7Zr9rZr13AF1aqw1qvasrtr9rGF1Yy3y3
 J3WfXw1fAFn5KjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbMqcUUUUUU==
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiMwg3QWoRWQgyugAA3v
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
 drivers/net/hinic3/hinic3_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index f4eb788..fbadb1e 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -696,7 +696,7 @@ hinic3_dev_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *info)
 		RTE_ETH_TX_OFFLOAD_VLAN_INSERT | RTE_ETH_TX_OFFLOAD_IPV4_CKSUM |
 		RTE_ETH_TX_OFFLOAD_UDP_CKSUM | RTE_ETH_TX_OFFLOAD_TCP_CKSUM |
 		RTE_ETH_TX_OFFLOAD_SCTP_CKSUM |
-		RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM |
+		RTE_ETH_TX_OFFLOAD_OUTER_IPV4_CKSUM | RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO |
 		RTE_ETH_TX_OFFLOAD_TCP_TSO | RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
 	if (nic_dev->feature_cap & NIC_F_HTN_CMDQ)
 		hinic3_dev_tnl_tso_support(info, nic_dev);
-- 
2.47.0.windows.2

