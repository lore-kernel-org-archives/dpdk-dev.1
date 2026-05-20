Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B591CD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 06:58:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E9934065B;
	Wed, 20 May 2026 08:58:48 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.222])
 by mails.dpdk.org (Postfix) with ESMTP id 1A47B40276
 for <dev@dpdk.org>; Wed, 20 May 2026 08:58:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=okHomGVRQ+5RKqMyQbuqfTxja0fTXzn+Hp/xbwBCPXg=;
 b=V/ejjhkTD0IAlt1C49Yndy2HvC2IQ2IanoOWvdMz55ni8CgNXWmgIc89cgUYWe
 hEqX9v4LIAcn9/Q+z6Pc4iKBc5dJ5PbV2xvGJ4HEl1iIE9eDdW/nP23CO49mYNzj
 Rhm/zLzIjppjCMA8gUC83SuKu25qsehOscUiaOmbYBAdo=
Received: from localhost.localdomain (unknown [114.116.198.59])
 by gzsmtp1 (Coremail) with SMTP id Ac8vCgD3z8eZWw1qNLy5Cg--.60640S5;
 Wed, 20 May 2026 14:58:41 +0800 (CST)
From: Feifei Wang <wff_light@vip.163.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>
Subject: [V1 1/1] net/hinic3: Add VXLAN TSO function
Date: Wed, 20 May 2026 14:58:15 +0800
Message-ID: <20260520065817.931-2-wff_light@vip.163.com>
X-Mailer: git-send-email 2.47.0.windows.2
In-Reply-To: <20260520065817.931-1-wff_light@vip.163.com>
References: <20260520065817.931-1-wff_light@vip.163.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgD3z8eZWw1qNLy5Cg--.60640S5
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw1UuF1fKFW3KFyrCr15Jwb_yoWDtFX_ur
 y09r42kw1DWr4Yyw1Fka1S9348Kr10gw1kAFy7Xr9rury3ZF1avw1qv3W7tF97JF1Yyay3
 J3WrXw1fAFn5GjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUbRnQUUUUUU==
X-Originating-IP: [114.116.198.59]
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiMwHc5moNW6EPagAA3w
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

The RTE_ETH_TX_OFFLOAD_VXLAN_TNL_TSO flag is added to support the VXLAN TSO function

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

