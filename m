Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 112A1C369A1
	for <dpdk-dev@archiver.kernel.org>; Mon,  7 Apr 2025 22:45:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7C9740E43;
	Tue,  8 Apr 2025 00:45:17 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id BC27E40E21
 for <dev@dpdk.org>; Tue,  8 Apr 2025 00:45:13 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 54DB32113E7E; Mon,  7 Apr 2025 15:45:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 54DB32113E7E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
 s=default; t=1744065913;
 bh=4sOWOF9h56Av735t4QSF81YrPqGMmLeRf/RHfTe8CLY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=eX2BOrb9tMGAJuZHulXDt1OvCtI7B6bcmXPBtH7Ae5nEi9+bEoutP45XBvMSVn1Qa
 Bt/a5l781Ar/e23pwYte2T6r7GnGl+u9k3vKidVsk1b2xCWQ3RrigQck07kc9OMteo
 PXLPkV3BONyTJeAWE0ypJsDNa9gJgP0nCp/ODGG4=
From: longli@linuxonhyperv.com
To: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu <weh@microsoft.com>
Cc: dev@dpdk.org,
	Long Li <longli@microsoft.com>
Subject: [patch v4 6/6] bus/vmbus: set event for channel without monitoring
 support
Date: Mon,  7 Apr 2025 15:45:04 -0700
Message-Id: <1744065904-18455-7-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1744065904-18455-1-git-send-email-longli@linuxonhyperv.com>
References: <1744065904-18455-1-git-send-email-longli@linuxonhyperv.com>
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

For vmbus channels without monitoring support, use kernel UIO interface
to indicate packet through interrupt page and UIO file handle.

Signed-off-by: Long Li <longli@microsoft.com>
---
Changes:
v4: replace RTE_ATOMIC(uint32_t) * with RTE_ATOMIC(uint32_t *) for declaring variable

 drivers/bus/vmbus/vmbus_channel.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/vmbus/vmbus_channel.c b/drivers/bus/vmbus/vmbus_channel.c
index bccef168d3..96ac3ba6d6 100644
--- a/drivers/bus/vmbus/vmbus_channel.c
+++ b/drivers/bus/vmbus/vmbus_channel.c
@@ -19,15 +19,28 @@
 #include "private.h"
 
 static inline void
-vmbus_sync_set_bit(volatile RTE_ATOMIC(uint32_t) *addr, uint32_t mask)
+vmbus_sync_set_bit(volatile RTE_ATOMIC(uint32_t *) addr, uint32_t mask)
 {
 	rte_atomic_fetch_or_explicit(addr, mask, rte_memory_order_seq_cst);
 }
 
+static inline void
+vmbus_send_interrupt(const struct rte_vmbus_device *dev, uint32_t relid)
+{
+	RTE_ATOMIC(uint32_t *) int_addr;
+	uint32_t int_mask;
+
+	int_addr = dev->int_page + relid / 32;
+	int_mask = 1u << (relid % 32);
+	vmbus_sync_set_bit(int_addr, int_mask);
+
+	vmbus_uio_irq_control(dev, 1);
+}
+
 static inline void
 vmbus_set_monitor(const struct vmbus_channel *channel, uint32_t monitor_id)
 {
-	RTE_ATOMIC(uint32_t) *monitor_addr;
+	RTE_ATOMIC(uint32_t *) monitor_addr;
 	uint32_t monitor_mask;
 	unsigned int trigger_index;
 
@@ -39,10 +52,13 @@ vmbus_set_monitor(const struct vmbus_channel *channel, uint32_t monitor_id)
 }
 
 static void
-vmbus_set_event(struct rte_vmbus_device *dev __rte_unused,
-		const struct vmbus_channel *chan)
+vmbus_set_event(struct rte_vmbus_device *dev, const struct vmbus_channel *chan)
 {
-	vmbus_set_monitor(chan, chan->monitor_id);
+	/* Use monitored bit if supported, otherwise use interrupt/Hypercall */
+	if (chan->monitor_id != UINT8_MAX)
+		vmbus_set_monitor(chan, chan->monitor_id);
+	else
+		vmbus_send_interrupt(dev, chan->relid);
 }
 
 /*
-- 
2.34.1

