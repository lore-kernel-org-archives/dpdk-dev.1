Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B082CCCD193
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 12:05:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A303440ECF;
	Wed, 15 Oct 2025 14:05:31 +0200 (CEST)
Received: from pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [35.155.198.111])
 by mails.dpdk.org (Postfix) with ESMTP id D19A840DDC
 for <dev@dpdk.org>; Wed, 15 Oct 2025 14:05:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1760529927; x=1792065927;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version;
 bh=/ceB2FK0raz3NKYlTF3UbcDPiNFhMoA0JI+K94nIjBk=;
 b=DLO2ZDraX5GyxmqbVlKKLeO8r+11XbIoFiPxVMJ5GWzsSBt8UL2m+618
 H7NeIfHnhGzPb1fpc7wfaayy/mMXUBiluCynnP64gnAySoL6hWfH6h8ze
 O2udHiYwS26318loS85Pm4QVpOfOsyhRj2NnxLNNCxAFHTlUGSE6jlhfP
 /hjLNcdGW6FafRW5KAzX4ZNc7gVP15HdcfOMIKkuX+DBdFL1p7/UCXOgj
 fJ4dCl1/O1D56FiVMEt0wsxsRNvG67XwZ69Ume7E/zbR9VuYHBTOagidX
 iIcItBn/PDamqIoAJQOC1x1UOGwQY6tZaqJD+DgWjgObsuuVeG+kJ8NO5 Q==;
X-CSE-ConnectionGUID: pqs9z7FPRfGVRuSOhWzDaw==
X-CSE-MsgGUID: ZCCZkS8sSOm9ck1Ky+OCrA==
X-IronPort-AV: E=Sophos;i="6.19,231,1754956800"; 
   d="scan'208";a="4813253"
Received: from ip-10-5-0-115.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.0.115])
 by internal-pdx-out-009.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 12:05:26 +0000
Received: from EX19MTAUWA002.ant.amazon.com [205.251.233.234:15995]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.13.122:2525]
 with esmtp (Farcaster)
 id a8c4da98-e898-4ef3-a672-7f7d8bf5bf24; Wed, 15 Oct 2025 12:05:26 +0000 (UTC)
X-Farcaster-Flow-ID: a8c4da98-e898-4ef3-a672-7f7d8bf5bf24
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 12:05:26 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.213.14) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 12:05:24 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH v2 04/20] net/ena/base: add lost interrupt indication
Date: Wed, 15 Oct 2025 15:03:59 +0300
Message-ID: <20251015120415.2204-5-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251015120415.2204-1-shaibran@amazon.com>
References: <20251015120415.2204-1-shaibran@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.213.14]
X-ClientProxiedBy: EX19D046UWB002.ant.amazon.com (10.13.139.181) To
 EX19D001UWA001.ant.amazon.com (10.13.138.214)
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

Add infrastructure for the driver to pass indication via
unmask register to support interrupt lost heuristic.

Signed-off-by: Shai Brandes <shaibran@amazon.com>
Reviewed-by: Amit Bernstein <amitbern@amazon.com>
Reviewed-by: Yosef Raisman <yraisman@amazon.com>
---
 drivers/net/ena/base/ena_com.h | 9 ++++++---
 drivers/net/ena/ena_ethdev.c   | 2 +-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ena/base/ena_com.h b/drivers/net/ena/base/ena_com.h
index 180fa8966e..7f9a9c1522 100644
--- a/drivers/net/ena/base/ena_com.h
+++ b/drivers/net/ena/base/ena_com.h
@@ -1196,6 +1196,8 @@ static inline int ena_com_get_customer_metric_count(struct ena_com_dev *ena_dev)
  * @unmask: unmask enable/disable
  * @no_moderation_update: 0 - Indicates that any of the TX/RX intervals was
  *                        updated, 1 - otherwise
+ * @lost_interrupt: true - if driver heuristic indicates interrupt was lost
+ *                  false - otherwise
  *
  * Prepare interrupt update register with the supplied parameters.
  */
@@ -1203,7 +1205,8 @@ static inline void ena_com_update_intr_reg(struct ena_eth_io_intr_reg *intr_reg,
 					   u32 rx_delay_interval,
 					   u32 tx_delay_interval,
 					   bool unmask,
-					   bool no_moderation_update)
+					   bool no_moderation_update,
+					   bool lost_interrupt)
 {
 	intr_reg->intr_control = 0;
 	intr_reg->intr_control |= rx_delay_interval &
@@ -1214,11 +1217,11 @@ static inline void ena_com_update_intr_reg(struct ena_eth_io_intr_reg *intr_reg,
 			       ENA_ETH_IO_INTR_REG_TX_INTR_DELAY_MASK,
 			       ENA_ETH_IO_INTR_REG_TX_INTR_DELAY_SHIFT);
 
-	if (unmask)
+	if (likely(unmask && !lost_interrupt))
 		intr_reg->intr_control |= ENA_ETH_IO_INTR_REG_INTR_UNMASK_MASK;
 
 	intr_reg->intr_control |=
-		ENA_FIELD_PREP(((u32)no_moderation_update),
+		ENA_FIELD_PREP(((u32)(no_moderation_update && !lost_interrupt)),
 			       ENA_ETH_IO_INTR_REG_NO_MODERATION_UPDATE_MASK,
 			       ENA_ETH_IO_INTR_REG_NO_MODERATION_UPDATE_SHIFT);
 }
diff --git a/drivers/net/ena/ena_ethdev.c b/drivers/net/ena/ena_ethdev.c
index b2d61c881b..656e25fbac 100644
--- a/drivers/net/ena/ena_ethdev.c
+++ b/drivers/net/ena/ena_ethdev.c
@@ -3939,7 +3939,7 @@ static void ena_rx_queue_intr_set(struct rte_eth_dev *dev,
 	struct ena_ring *rxq = &adapter->rx_ring[queue_id];
 	struct ena_eth_io_intr_reg intr_reg;
 
-	ena_com_update_intr_reg(&intr_reg, 0, 0, unmask, 1);
+	ena_com_update_intr_reg(&intr_reg, 0, 0, unmask, 1, 0);
 	ena_com_unmask_intr(rxq->ena_com_io_cq, &intr_reg);
 }
 
-- 
2.17.1

