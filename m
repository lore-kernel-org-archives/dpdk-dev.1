Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84B11C19F32
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Feb 2025 01:09:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 10D6A40E34;
	Fri, 28 Feb 2025 02:09:17 +0100 (CET)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 2479E40E19
 for <dev@dpdk.org>; Fri, 28 Feb 2025 02:09:10 +0100 (CET)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 825FC210EAC5; Thu, 27 Feb 2025 17:09:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 825FC210EAC5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
 s=default; t=1740704949;
 bh=GFrQnmp53B65Y8xQFSie9TwH2eyIhBogNCzHPmtsPXA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=JwX7ZorGaggM+EP3oHuAq4WgN6aas49P0DJdqKcAP37eNKD2D+RgdEOEpA6SJHaUD
 0Vfq6webM/0Ul1uQRFQIMZcx7gGAEhvckqWLKKZxXzU9aCD6CDjkhE1zUIJI4Vq5aJ
 5EV63xONssVxwrwcP20qg3jYTWdMj0MLJxrtInqY=
From: longli@linuxonhyperv.com
To: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu <weh@microsoft.com>
Cc: dev@dpdk.org,
	Long Li <longli@microsoft.com>
Subject: [PATCH 6/6] bus/vmbus: set event for channel without monitoring
 support
Date: Thu, 27 Feb 2025 17:09:01 -0800
Message-Id: <1740704941-1631-7-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1740704941-1631-2-git-send-email-longli@linuxonhyperv.com>
References: <1740704941-1631-2-git-send-email-longli@linuxonhyperv.com>
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
 drivers/bus/vmbus/vmbus_channel.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/bus/vmbus/vmbus_channel.c b/drivers/bus/vmbus/vmbus_channel.c
index bccef168d3..1b54961cff 100644
--- a/drivers/bus/vmbus/vmbus_channel.c
+++ b/drivers/bus/vmbus/vmbus_channel.c
@@ -24,6 +24,19 @@ vmbus_sync_set_bit(volatile RTE_ATOMIC(uint32_t) *addr, uint32_t mask)
 	rte_atomic_fetch_or_explicit(addr, mask, rte_memory_order_seq_cst);
 }
 
+static inline void
+vmbus_send_interrupt(const struct rte_vmbus_device *dev, uint32_t relid)
+{
+	uint32_t *int_addr;
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
@@ -39,10 +52,12 @@ vmbus_set_monitor(const struct vmbus_channel *channel, uint32_t monitor_id)
 }
 
 static void
-vmbus_set_event(struct rte_vmbus_device *dev __rte_unused,
-		const struct vmbus_channel *chan)
+vmbus_set_event(struct rte_vmbus_device *dev, const struct vmbus_channel *chan)
 {
-	vmbus_set_monitor(chan, chan->monitor_id);
+	if (chan->monitor_id != UINT8_MAX)
+		vmbus_set_monitor(chan, chan->monitor_id);
+	else
+		vmbus_send_interrupt(dev, chan->relid);
 }
 
 /*
-- 
2.34.1

