Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E752C02198
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 21:25:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0DC5D402A4;
	Mon, 10 Feb 2025 22:25:41 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 8BFA2402A1
 for <dev@dpdk.org>; Mon, 10 Feb 2025 22:25:39 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id D01282107A91; Mon, 10 Feb 2025 13:25:38 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D01282107A91
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1739222738;
 bh=bHRy3Gtp7rfmTxOXhFNUDne629VvW4nxkb0pj6R3+5k=;
 h=From:To:Cc:Subject:Date:From;
 b=H5epCPHGYEgiaCVzpnpwoH2+WbDRBkwkoVz/2NUjx9N/9tY0qC8cumVi3/ql2ccUr
 Gyl2JHQLjmptdYUtaAltKRMyLoIa1EZBFF5xZwYLUSTyEGOJcPK4eOO5Ksb6C2aiEA
 3Fhre19+Y+oGhpMhBdrhILOiMRG2UXnQx/wtlaEM=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: Jochen Behrens <jochen.behrens@broadcom.com>
Cc: dev@dpdk.org,
	Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH] drivers/net: signed/unsigned mismatch
Date: Mon, 10 Feb 2025 13:25:25 -0800
Message-Id: <1739222725-30747-1-git-send-email-andremue@linux.microsoft.com>
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

This patch avoids warning C4018: '>=': signed/unsigned mismatch

The fix is to use U suffix to indicate the numbers are unsigned before
the comparisons are made.

Also renamed variables to make them compliant to DPDK standards and
avoid checkpatch warnings.

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 drivers/net/vmxnet3/vmxnet3_ethdev.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_ethdev.h b/drivers/net/vmxnet3/vmxnet3_ethdev.h
index e9ded6663d..fd150d12c5 100644
--- a/drivers/net/vmxnet3/vmxnet3_ethdev.h
+++ b/drivers/net/vmxnet3/vmxnet3_ethdev.h
@@ -183,17 +183,17 @@ vmxnet3_read_addr(volatile void *addr)
 	VMXNET3_PCI_REG_WRITE(VMXNET3_PCI_BAR1_REG_ADDR((hw), (reg)), (value))
 
 static inline uint8_t
-vmxnet3_get_ring_idx(struct vmxnet3_hw *hw, uint32 rqID)
+vmxnet3_get_ring_idx(struct vmxnet3_hw *hw, uint32_t rq_id)
 {
-	return (rqID >= hw->num_rx_queues &&
-		rqID < 2 * hw->num_rx_queues) ? 1 : 0;
+	return (rq_id >= hw->num_rx_queues &&
+		rq_id < 2U * hw->num_rx_queues) ? 1 : 0;
 }
 
 static inline bool
-vmxnet3_rx_data_ring(struct vmxnet3_hw *hw, uint32 rqID)
+vmxnet3_rx_data_ring(struct vmxnet3_hw *hw, uint32_t rq_id)
 {
-	return (rqID >= 2 * hw->num_rx_queues &&
-		rqID < 3 * hw->num_rx_queues);
+	return (rq_id >= 2U * hw->num_rx_queues &&
+		rq_id < 3U * hw->num_rx_queues);
 }
 
 /*
-- 
2.47.2.vfs.0.1

