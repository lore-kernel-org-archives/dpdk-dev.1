Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7088C369C7
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 20:58:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 718914278D;
	Wed, 16 Apr 2025 22:57:30 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id C65E641140
 for <dev@dpdk.org>; Wed, 16 Apr 2025 22:57:25 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 7DC2A2052505; Wed, 16 Apr 2025 13:57:25 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7DC2A2052505
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
 s=default; t=1744837045;
 bh=gbBtPODom7xjyOnq7eH27oHFPycwADNUTw0AprZVz/M=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=tGdbfIm1u9uouX5x13ffk5nm+UGHi9/csYt3GGkUt29c8/Dybl5gbxe2hjTXaV+dc
 i/HcI5Y/osZF47J2tG/EtmYXiuak0SPdR4b0oFTk74QmdADzo/x2CuV9vhDpd9kCOh
 YELz8EAVaUYyUH4M1ANEaWUlRZIxmdTW3eQsNF54=
From: longli@linuxonhyperv.com
To: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu <weh@microsoft.com>
Cc: dev@dpdk.org,
	Long Li <longli@microsoft.com>
Subject: [patch v6 6/6] bus/vmbus: set event for channel without monitoring
 support
Date: Wed, 16 Apr 2025 13:57:18 -0700
Message-Id: <1744837038-5387-7-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1744837038-5387-1-git-send-email-longli@linuxonhyperv.com>
References: <1744837038-5387-1-git-send-email-longli@linuxonhyperv.com>
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
v6: revert the v4 version back to v3 as it generates a warning under clang with enable_stdatomic=true

 drivers/bus/vmbus/vmbus_channel.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/vmbus/vmbus_channel.c b/drivers/bus/vmbus/vmbus_channel.c
index d066e3288d..6887fbad46 100644
--- a/drivers/bus/vmbus/vmbus_channel.c
+++ b/drivers/bus/vmbus/vmbus_channel.c
@@ -25,6 +25,19 @@ vmbus_sync_set_bit(volatile RTE_ATOMIC(uint32_t) *addr, uint32_t mask)
 	rte_atomic_fetch_or_explicit(addr, mask, rte_memory_order_seq_cst);
 }
 
+static inline void
+vmbus_send_interrupt(const struct rte_vmbus_device *dev, uint32_t relid)
+{
+	RTE_ATOMIC(uint32_t) *int_addr;
+	uint32_t int_mask;
+
+	int_addr = (RTE_ATOMIC(uint32_t) *) (dev->int_page + relid / 32);
+	int_mask = 1u << (relid % 32);
+	vmbus_sync_set_bit(int_addr, int_mask);
+
+	vmbus_uio_irq_control(dev, 1);
+}
+
 static inline void
 vmbus_set_monitor(const struct vmbus_channel *channel, uint32_t monitor_id)
 {
@@ -40,10 +53,13 @@ vmbus_set_monitor(const struct vmbus_channel *channel, uint32_t monitor_id)
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

