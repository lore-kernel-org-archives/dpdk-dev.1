Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D1CC44500
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 10:53:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A68C40A6B;
	Mon,  6 Jul 2026 12:53:37 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 335AE40685
 for <dev@dpdk.org>; Mon,  6 Jul 2026 12:53:34 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gv1Qs6Q94zHnH62;
 Mon,  6 Jul 2026 18:52:37 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id E5E8740571;
 Mon,  6 Jul 2026 18:53:33 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 6 Jul 2026 12:53:33 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Long Li <longli@microsoft.com>, Wei Hu <weh@microsoft.com>
CC: <dev@dpdk.org>, <thomas@monjalon.net>, <bruce.richardson@intel.com>
Subject: [PATCH v2 4/7] doc: fix typos in rte_bus_vmbus.h
Date: Mon, 6 Jul 2026 11:52:52 +0100
Message-ID: <20260706105256.79904-5-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260706105256.79904-1-marat.khalili@huawei.com>
References: <20260702200050.88710-1-marat.khalili@huawei.com>
 <20260706105256.79904-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema100001.china.huawei.com (7.182.19.23) To
 frapema500003.china.huawei.com (7.182.19.114)
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

This file contained multiple doxygen issues that prevented successful
documentation build (missing, extra, misspelt parameter names etc). It
was not discovered previously because the driver despite the presence of
public headers was not included in the documentation build.

Fix invalid doxygen parameters annotations.

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 drivers/bus/vmbus/rte_bus_vmbus.h | 33 +++++++++++++++++++------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/bus/vmbus/rte_bus_vmbus.h b/drivers/bus/vmbus/rte_bus_vmbus.h
index 2e9898ed7fb6..7f3ebd823201 100644
--- a/drivers/bus/vmbus/rte_bus_vmbus.h
+++ b/drivers/bus/vmbus/rte_bus_vmbus.h
@@ -111,7 +111,7 @@ int rte_vmbus_max_channels(const struct rte_vmbus_device *device);
  *
  * @param primary
  *   A pointer to primary VMBUS channel
- * @param chan
+ * @param new_chan
  *   A pointer to a secondary VMBUS channel pointer that will be filled.
  * @return
  *   - 0 Success; channel opened.
@@ -158,6 +158,8 @@ bool rte_vmbus_chan_rx_empty(const struct vmbus_channel *channel);
 /**
  * Send the specified buffer on the given channel
  *
+ * @param dev
+ *	A pointer to a rte_vmbus_device structure describing the device
  * @param channel
  *	Pointer to vmbus_channel structure.
  * @param type
@@ -184,7 +186,9 @@ int rte_vmbus_chan_send(struct rte_vmbus_device *dev,
 /**
  * Explicitly signal host that data is available
  *
- * @param
+ * @param dev
+ *	A pointer to a rte_vmbus_device structure describing the device
+ * @param channel
  *	Pointer to vmbus_channel structure.
  *
  * Used when batching multiple sends and only signaling host
@@ -203,11 +207,10 @@ struct iova_list {
 /**
  * Send a scattered buffer on the given channel
  *
+ * @param dev
+ *	A pointer to a rte_vmbus_device structure describing the device
  * @param channel
  *	Pointer to vmbus_channel structure.
- * @param type
- *	Type of packet that is being send e.g. negotiate, time
- *	packet etc.
  * @param gpa
  *	Array of buffers to send
  * @param gpacnt
@@ -218,8 +221,6 @@ struct iova_list {
  *	 Maximum size of what the buffer will hold
  * @param xact
  *	Identifier of the request
- * @param flags
- *	Message type inband, rxbuf, gpa
  * @param need_sig
  *	Is host signal tx is required (optional)
  *
@@ -234,13 +235,15 @@ int rte_vmbus_chan_send_sglist(struct rte_vmbus_device *dev,
  * Receive response to request on the given channel
  * skips the channel header.
  *
- * @param channel
+ * @param dev
+ *	A pointer to a rte_vmbus_device structure describing the device
+ * @param chan
  *	Pointer to vmbus_channel structure.
  * @param data
  *	Pointer to the buffer you want to receive the data into.
  * @param len
  *	Pointer to size of receive buffer (in/out)
- * @param
+ * @param request_id
  *	Pointer to received transaction_id
  * @return
  *   On success, returns 0
@@ -255,7 +258,7 @@ int rte_vmbus_chan_recv(struct rte_vmbus_device *dev,
  * Receive response to request on the given channel
  * includes the channel header.
  *
- * @param channel
+ * @param chan
  *	Pointer to vmbus_channel structure.
  * @param data
  *	Pointer to the buffer you want to receive the data into.
@@ -272,7 +275,9 @@ int rte_vmbus_chan_recv_raw(struct vmbus_channel *chan,
  * Notify host of bytes read (after recv_raw)
  * Signals host if required.
  *
- * @param channel
+ * @param dev
+ *	A pointer to a rte_vmbus_device structure describing the device
+ * @param chan
  *	Pointer to vmbus_channel structure.
  * @param bytes_read
  *	Number of bytes read since last signal
@@ -284,7 +289,7 @@ void rte_vmbus_chan_signal_read(struct rte_vmbus_device *dev,
 /**
  * Determine sub channel index of the given channel
  *
- * @param channel
+ * @param chan
  *	Pointer to vmbus_channel structure.
  * @return
  *   Sub channel index (0 for primary)
@@ -309,7 +314,9 @@ void rte_vmbus_set_latency(const struct rte_vmbus_device *dev,
 /**
  * For debug dump contents of ring buffer.
  *
- * @param channel
+ * @param f
+ *	Output file to dump to.
+ * @param chan
  *	Pointer to vmbus_channel structure.
  */
 void rte_vmbus_chan_dump(FILE *f, const struct vmbus_channel *chan);
-- 
2.43.0

