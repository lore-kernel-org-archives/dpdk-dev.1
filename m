Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B461C83F0A
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 21:47:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A18F40E39;
	Wed,  9 Jul 2025 23:47:44 +0200 (CEST)
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com
 [209.85.215.170])
 by mails.dpdk.org (Postfix) with ESMTP id 63F1640654
 for <dev@dpdk.org>; Wed,  9 Jul 2025 23:47:42 +0200 (CEST)
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-b31d578e774so1334744a12.1
 for <dev@dpdk.org>; Wed, 09 Jul 2025 14:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=broadcom.com; s=google; t=1752097661; x=1752702461; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Qv0hyPK5X6JZe3ajMeb8rniGTy+V9beLVuDVHwPGd/k=;
 b=H+QlIZOacYZLU86H07dOqDOG7efwdJjYMovNuly/JD9JKIFQE0g4fLrTGQA+8xBMP0
 k7t5f0evnoTk4VVoLkO+zchQsw8j1DIhjj9iF4w8sT0Yk4NnsX1T7+hfmEjtckoAfZVT
 hc2ZjisRxLlICEh2byqk59TgSWJaIZmjsqLDc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752097661; x=1752702461;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Qv0hyPK5X6JZe3ajMeb8rniGTy+V9beLVuDVHwPGd/k=;
 b=oAqIQhu/ZdxknTS3quIFciBD1UOS1C9XcGOekAqHzJ8VDjN+8y5EToUO9OYqYsKZzO
 6JQOw0Ah9CNa2QHsFxioibYkp7UyZ+3X/BQlSeBpOfLlkIazIWql6hPzdUbo2ZW0ocBj
 DA2TN6PgF3ydLT2qUxDXcAMdI29B1oXK8ZCt1spwdbvPyN64jiEVtfjcorVuBTIYE5m9
 98TdQnjrPq5Er3ODWla6QNvey+O9Q40Fbr8LInt1PHViDvQ+dUQwNg3J2NC4JpUhrdaP
 hYoxvKlxiD51a70+JaDPtj5Hsu2WJjJfaAqeXw9hGtszZ1xsUbKkDbVihaltvWmnbIgT
 2y4g==
X-Gm-Message-State: AOJu0Yxrl7HLKdzMeqqEA8W5Q8j5+lQGqZE1BzlLEeWaILINJnxs7Rbs
 a9C5HtTcfSbQXcOYPEr7DRievxpziC8Eq10ecJaz4uTYy1Zvy2IzCyZ4aUXfGUBfrqVdsebM+6Q
 o/U3B43VIMYLUujiYRdKcYCunYMhb3+4fb2unB0BOrdKeKNLeaBaCggZcmIsqF2VVsTwrFfR9dW
 wBisIZUEUKCf0ULb7ZkCoDutvFZH7D+nwS
X-Gm-Gg: ASbGncuIT2uyRLIL/wdoTSIeL37lB/iY6zCOzVW47Qa0MCHYQr210A5LHZkjiCeGbFF
 zA3zddIWrZb5S66a1+8vXl1/WtMlG7DRG/stzK16huc3RQcBHNbn50wpvXUiupsMZ6i7qMPreKe
 /j/tXtq+pxyXgYeLCmR++NlduMTM27u5+uwn/8/7lKhQTGm2OqWnCmxh2FV4kCyT5Xrw7byQVyf
 PpWS870QVzaU/zmCZ7IUAOraUWWqHd4U3gEbied/nbHmx7V05FDOw8LDekfJ/iEQ9HmwtA2EW6j
 zam5HTs8oD7DbJ8MmlqgoSmIooyx6eg6NWvKcp/Zu18MNkqKdRB9EYhlNoWTC+eL3sgF25qipMg
 FpQ+GHDIN+xE=
X-Google-Smtp-Source: AGHT+IFjV9QGOZ9RAwY9LFNGU8S/57/Zu+YkEI+Ld5EzbHiKD9Mb5DF5TCN+D7e0P2Fv9TBLT+H3Iw==
X-Received: by 2002:a17:90b:51c5:b0:314:2cd2:595d with SMTP id
 98e67ed59e1d1-31c3cf5e389mr1785875a91.8.1752097660841; 
 Wed, 09 Jul 2025 14:47:40 -0700 (PDT)
Received: from ubuntu.. ([192.19.161.250]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c3e957d1bsm227577a91.8.2025.07.09.14.47.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jul 2025 14:47:40 -0700 (PDT)
From: Ronak Doshi <ronak.doshi@broadcom.com>
To: dev@dpdk.org, Jochen Behrens <jochen.behrens@broadcom.com>,
 Jin Heo <jin.heo@broadcom.com>, Guolin Yang <guolin.yang@broadcom.com>,
 Yong Wang <wang.yong19@zte.com.cn>, Shrikrishna Khare <skhare@vmware.com>
Cc: Ronak Doshi <ronak.doshi@broadcom.com>,
	stable@dpdk.org
Subject: [PATCH net] net/vmxnet3: fix mapping of mempools to queues
Date: Wed,  9 Jul 2025 21:29:03 +0000
Message-ID: <20250709212905.126851-1-ronak.doshi@broadcom.com>
X-Mailer: git-send-email 2.45.2
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

Index bitmask variable used was uint8_t, too small for bitmask with
9 or more queues. This patch changes it to uint16_t for now, to be
same as in the Vmxnet3_MemoryRegion structure. This way txQueues
can be lesser than rxQueues and have correct mapping of memory regions.

Also, the patch fixes memory region check as 16 queues are allowed on
both RX and TX.

Fixes: 6a113992060e ("net/vmxnet3: add cmd to register memory region")
Cc: stable@dpdk.org
Signed-off-by: Ronak Doshi <ronak.doshi@broadcom.com>
Acked-by: Jochen Behrens <jochen.behrens@broadcom.com>
---
 drivers/net/vmxnet3/base/vmxnet3_defs.h |  3 +++
 drivers/net/vmxnet3/vmxnet3_ethdev.c    | 23 ++++++++++++++---------
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/net/vmxnet3/base/vmxnet3_defs.h b/drivers/net/vmxnet3/base/vmxnet3_defs.h
index a6bb281d8d..15d4d88c5c 100644
--- a/drivers/net/vmxnet3/base/vmxnet3_defs.h
+++ b/drivers/net/vmxnet3/base/vmxnet3_defs.h
@@ -598,6 +598,9 @@ enum vmxnet3_intr_type {
 /* addition 1 for events */
 #define VMXNET3_MAX_INTRS      25
 
+/* Max number of queues that can request memreg, for both RX and TX. */
+#define VMXNET3_MAX_MEMREG_QUEUES  16
+
 /* Version 6 and later will use below macros */
 #define VMXNET3_EXT_MAX_TX_QUEUES  32
 #define VMXNET3_EXT_MAX_RX_QUEUES  32
diff --git a/drivers/net/vmxnet3/vmxnet3_ethdev.c b/drivers/net/vmxnet3/vmxnet3_ethdev.c
index 15ca25b187..e19aa43888 100644
--- a/drivers/net/vmxnet3/vmxnet3_ethdev.c
+++ b/drivers/net/vmxnet3/vmxnet3_ethdev.c
@@ -801,14 +801,15 @@ vmxnet3_dev_setup_memreg(struct rte_eth_dev *dev)
 	Vmxnet3_DriverShared *shared = hw->shared;
 	Vmxnet3_CmdInfo *cmdInfo;
 	struct rte_mempool *mp[VMXNET3_MAX_RX_QUEUES];
-	uint8_t index[VMXNET3_MAX_RX_QUEUES + VMXNET3_MAX_TX_QUEUES];
-	uint32_t num, i, j, size;
+	uint16_t index[VMXNET3_MAX_MEMREG_QUEUES];
+	uint16_t tx_index_mask;
+	uint32_t num, tx_num, i, j, size;
 
 	if (hw->memRegsPA == 0) {
 		const struct rte_memzone *mz;
 
 		size = sizeof(Vmxnet3_MemRegs) +
-			(VMXNET3_MAX_RX_QUEUES + VMXNET3_MAX_TX_QUEUES) *
+			(2 * VMXNET3_MAX_MEMREG_QUEUES) *
 			sizeof(Vmxnet3_MemoryRegion);
 
 		mz = gpa_zone_reserve(dev, size, "memRegs", rte_socket_id(), 8,
@@ -822,7 +823,9 @@ vmxnet3_dev_setup_memreg(struct rte_eth_dev *dev)
 		hw->memRegsPA = mz->iova;
 	}
 
-	num = hw->num_rx_queues;
+	num = RTE_MIN(hw->num_rx_queues, VMXNET3_MAX_MEMREG_QUEUES);
+	tx_num = RTE_MIN(hw->num_tx_queues, VMXNET3_MAX_MEMREG_QUEUES);
+	tx_index_mask = (uint16_t)((1UL << tx_num) - 1);
 
 	for (i = 0; i < num; i++) {
 		vmxnet3_rx_queue_t *rxq = dev->data->rx_queues[i];
@@ -857,13 +860,15 @@ vmxnet3_dev_setup_memreg(struct rte_eth_dev *dev)
 			(uintptr_t)STAILQ_FIRST(&mp[i]->mem_list)->iova;
 		mr->length = STAILQ_FIRST(&mp[i]->mem_list)->len <= INT32_MAX ?
 			STAILQ_FIRST(&mp[i]->mem_list)->len : INT32_MAX;
-		mr->txQueueBits = index[i];
 		mr->rxQueueBits = index[i];
+		/* tx uses same pool, but there may be fewer tx queues */
+		mr->txQueueBits = index[i] & tx_index_mask;
 
 		PMD_INIT_LOG(INFO,
 			     "index: %u startPA: %" PRIu64 " length: %u, "
-			     "rxBits: %x",
-			     j, mr->startPA, mr->length, mr->rxQueueBits);
+			     "rxBits: %x, txBits: %x",
+			     j, mr->startPA, mr->length,
+			     mr->rxQueueBits, mr->txQueueBits);
 		j++;
 	}
 	hw->memRegs->numRegs = j;
@@ -1087,8 +1092,8 @@ vmxnet3_dev_start(struct rte_eth_dev *dev)
 	}
 
 	/* Check memregs restrictions first */
-	if (dev->data->nb_rx_queues <= VMXNET3_MAX_RX_QUEUES &&
-	    dev->data->nb_tx_queues <= VMXNET3_MAX_TX_QUEUES) {
+	if (dev->data->nb_rx_queues <= VMXNET3_MAX_MEMREG_QUEUES &&
+	    dev->data->nb_tx_queues <= VMXNET3_MAX_MEMREG_QUEUES) {
 		ret = vmxnet3_dev_setup_memreg(dev);
 		if (ret == 0) {
 			VMXNET3_WRITE_BAR1_REG(hw, VMXNET3_REG_CMD,
-- 
2.45.2

