Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D823CCD185
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 07:09:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6CF140611;
	Wed, 15 Oct 2025 09:09:24 +0200 (CEST)
Received: from pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com
 (pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com
 [35.162.73.231]) by mails.dpdk.org (Postfix) with ESMTP id 040BA402CA
 for <dev@dpdk.org>; Wed, 15 Oct 2025 09:09:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
 t=1760512163; x=1792048163;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=5EoQXisyRCH0v3SPkyRZ1n3w2gEFox8G7YPxFZ4Ulgw=;
 b=IYCGWUSW2QV+AsQZIxjlE2k9jYBsqhnpD4b8NhTZ88RjUQT5/GazRNdi
 zLLpDMmtkSmaXzFM5pXOfaG5Rdyh20CbeI+W99om4QdjJCczqnj3NIO9q
 Og5XGCbFSmHd5BfTGha8+FibL3OOSr7O2RxaDhuOjNAYonhqEnSt6fQx+
 8KSJuRSdyOP8FgzQrYPGyGIXJvPIQHHi8s2pwQ7Qa6gWcWX4TUcK/0sRN
 00LTkxRtzZAbRyDYMjssscv37+96wdjab3bNp1PMid5jTjjGPl1I0xy0a
 GniXv2qk2IyIAQ3DN+qqHmzxnMbNW13yb20ajEHYEkvAk+wwzo19l5zI4 g==;
X-CSE-ConnectionGUID: m3V64K7VRim5Oj0fS4hKcA==
X-CSE-MsgGUID: 9WhWcY9cQUujqtCFRmUcOg==
X-IronPort-AV: E=Sophos;i="6.19,230,1754956800"; 
   d="scan'208";a="4720297"
Received: from ip-10-5-9-48.us-west-2.compute.internal (HELO
 smtpout.naws.us-west-2.prod.farcaster.email.amazon.dev) ([10.5.9.48])
 by internal-pdx-out-012.esa.us-west-2.outbound.mail-perimeter.amazon.com with
 ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Oct 2025 07:09:20 +0000
Received: from EX19MTAUWC001.ant.amazon.com [205.251.233.105:8454]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.35.225:2525]
 with esmtp (Farcaster)
 id 072ac4c2-44ba-412c-afad-9a77a50539ca; Wed, 15 Oct 2025 07:09:20 +0000 (UTC)
X-Farcaster-Flow-ID: 072ac4c2-44ba-412c-afad-9a77a50539ca
Received: from EX19D001UWA001.ant.amazon.com (10.13.138.214) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 07:09:20 +0000
Received: from HFA15-CG15235BS.amazon.com (10.1.213.14) by
 EX19D001UWA001.ant.amazon.com (10.13.138.214) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.2562.20;
 Wed, 15 Oct 2025 07:09:18 +0000
From: Shai Brandes <shaibran@amazon.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, Shai Brandes <shaibran@amazon.com>
Subject: [PATCH 05/21] net/ena/base: add lost interrupt indication
Date: Wed, 15 Oct 2025 10:09:05 +0300
Message-ID: <20251015070905.455-1-shaibran@amazon.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.1.213.14]
X-ClientProxiedBy: EX19D032UWB003.ant.amazon.com (10.13.139.165) To
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
index 38892ac7e1..82306aaa9c 100644
--- a/drivers/net/ena/base/ena_com.h
+++ b/drivers/net/ena/base/ena_com.h
@@ -1197,6 +1197,8 @@ static inline int ena_com_get_customer_metric_count(struct ena_com_dev *ena_dev)
  * @unmask: unmask enable/disable
  * @no_moderation_update: 0 - Indicates that any of the TX/RX intervals was
  *                        updated, 1 - otherwise
+ * @lost_interrupt: true - if driver heuristic indicates interrupt was lost
+ *                  false - otherwise
  *
  * Prepare interrupt update register with the supplied parameters.
  */
@@ -1204,7 +1206,8 @@ static inline void ena_com_update_intr_reg(struct ena_eth_io_intr_reg *intr_reg,
 					   u32 rx_delay_interval,
 					   u32 tx_delay_interval,
 					   bool unmask,
-					   bool no_moderation_update)
+					   bool no_moderation_update,
+					   bool lost_interrupt)
 {
 	intr_reg->intr_control = 0;
 	intr_reg->intr_control |= rx_delay_interval &
@@ -1215,11 +1218,11 @@ static inline void ena_com_update_intr_reg(struct ena_eth_io_intr_reg *intr_reg,
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

