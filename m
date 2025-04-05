Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07A84C36010
	for <dpdk-dev@archiver.kernel.org>; Sat,  5 Apr 2025 00:36:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A587440652;
	Sat,  5 Apr 2025 02:35:50 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id C57CF40430
 for <dev@dpdk.org>; Sat,  5 Apr 2025 02:35:47 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1202)
 id 3BDEB2027E0F; Fri,  4 Apr 2025 17:35:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3BDEB2027E0F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
 s=default; t=1743813347;
 bh=dp/dzj1fRmPeSPbLTTmjNfJV3kXnFLEEMOqNaaS+csc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ilyosG2m1pn55KfB6y26oXQfTqFy6YeNqrCB2cV7NRpryD2RfR90kvAxSYYlnEZZc
 RsPIra32XuFYfDsnt7SJGfDBBZyw3nbg32Va/e4Z1YpeU5xVI5o5EGjk+E3NSO0ofJ
 U2dAjsddVmIHcJ2M2z9JH0/qlEN3BbxERenisV+0=
From: longli@linuxonhyperv.com
To: Stephen Hemminger <stephen@networkplumber.org>, Wei Hu <weh@microsoft.com>
Cc: dev@dpdk.org,
	Long Li <longli@microsoft.com>
Subject: [Patch v3 5/6] bus/vmbus: add rte_vmbus_device to all functions
 accessing vmbus
Date: Fri,  4 Apr 2025 17:35:37 -0700
Message-Id: <1743813338-28238-6-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1743813338-28238-1-git-send-email-longli@linuxonhyperv.com>
References: <1743813338-28238-1-git-send-email-longli@linuxonhyperv.com>
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

The secondary process can access its vmbus device through device private
region. Add and pass it on all call chains leading to vmbus code.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/bus/vmbus/linux/vmbus_uio.c |  2 +-
 drivers/bus/vmbus/private.h         |  2 +-
 drivers/bus/vmbus/rte_bus_vmbus.h   | 16 ++++++++++-----
 drivers/bus/vmbus/vmbus_channel.c   | 32 +++++++++++++++++------------
 drivers/net/netvsc/hn_nvs.c         | 18 ++++++++--------
 drivers/net/netvsc/hn_nvs.h         | 15 +++++++-------
 drivers/net/netvsc/hn_rndis.c       | 11 +++++-----
 drivers/net/netvsc/hn_rxtx.c        | 16 +++++++--------
 8 files changed, 63 insertions(+), 49 deletions(-)

diff --git a/drivers/bus/vmbus/linux/vmbus_uio.c b/drivers/bus/vmbus/linux/vmbus_uio.c
index 33edc151f6..8edec869ac 100644
--- a/drivers/bus/vmbus/linux/vmbus_uio.c
+++ b/drivers/bus/vmbus/linux/vmbus_uio.c
@@ -27,7 +27,7 @@
 static void *vmbus_map_addr;
 
 /* Control interrupts */
-void vmbus_uio_irq_control(struct rte_vmbus_device *dev, int32_t onoff)
+void vmbus_uio_irq_control(const struct rte_vmbus_device *dev, int32_t onoff)
 {
 	if ((rte_intr_fd_get(dev->intr_handle) < 0) ||
 	    write(rte_intr_fd_get(dev->intr_handle), &onoff,
diff --git a/drivers/bus/vmbus/private.h b/drivers/bus/vmbus/private.h
index abee1b29f0..25b8a27fcf 100644
--- a/drivers/bus/vmbus/private.h
+++ b/drivers/bus/vmbus/private.h
@@ -110,7 +110,7 @@ void vmbus_insert_device(struct rte_vmbus_device *exist_vmbus_dev,
 			 struct rte_vmbus_device *new_vmbus_dev);
 void vmbus_remove_device(struct rte_vmbus_device *vmbus_device);
 
-void vmbus_uio_irq_control(struct rte_vmbus_device *dev, int32_t onoff);
+void vmbus_uio_irq_control(const struct rte_vmbus_device *dev, int32_t onoff);
 int vmbus_uio_irq_read(struct rte_vmbus_device *dev);
 
 int vmbus_uio_map_resource(struct rte_vmbus_device *dev);
diff --git a/drivers/bus/vmbus/rte_bus_vmbus.h b/drivers/bus/vmbus/rte_bus_vmbus.h
index fd18bca73c..2e9898ed7f 100644
--- a/drivers/bus/vmbus/rte_bus_vmbus.h
+++ b/drivers/bus/vmbus/rte_bus_vmbus.h
@@ -176,7 +176,8 @@ bool rte_vmbus_chan_rx_empty(const struct vmbus_channel *channel);
  *
  * Sends data in buffer directly to hyper-v via the vmbus
  */
-int rte_vmbus_chan_send(struct vmbus_channel *channel, uint16_t type,
+int rte_vmbus_chan_send(struct rte_vmbus_device *dev,
+			struct vmbus_channel *channel, uint16_t type,
 			void *data, uint32_t dlen,
 			uint64_t xact, uint32_t flags, bool *need_sig);
 
@@ -189,7 +190,8 @@ int rte_vmbus_chan_send(struct vmbus_channel *channel, uint16_t type,
  * Used when batching multiple sends and only signaling host
  * after the last send.
  */
-void rte_vmbus_chan_signal_tx(const struct vmbus_channel *channel);
+void rte_vmbus_chan_signal_tx(struct rte_vmbus_device *dev,
+			      const struct vmbus_channel *channel);
 
 /* Structure for scatter/gather I/O */
 struct iova_list {
@@ -223,7 +225,8 @@ struct iova_list {
  *
  * Sends data in buffer directly to hyper-v via the vmbus
  */
-int rte_vmbus_chan_send_sglist(struct vmbus_channel *channel,
+int rte_vmbus_chan_send_sglist(struct rte_vmbus_device *dev,
+			       struct vmbus_channel *channel,
 			       struct vmbus_gpa gpa[], uint32_t gpacnt,
 			       void *data, uint32_t dlen,
 			       uint64_t xact, bool *need_sig);
@@ -243,7 +246,8 @@ int rte_vmbus_chan_send_sglist(struct vmbus_channel *channel,
  *   On success, returns 0
  *   On failure, returns negative errno.
  */
-int rte_vmbus_chan_recv(struct vmbus_channel *chan,
+int rte_vmbus_chan_recv(struct rte_vmbus_device *dev,
+			struct vmbus_channel *chan,
 			void *data, uint32_t *len,
 			uint64_t *request_id);
 
@@ -273,7 +277,9 @@ int rte_vmbus_chan_recv_raw(struct vmbus_channel *chan,
  * @param bytes_read
  *	Number of bytes read since last signal
  */
-void rte_vmbus_chan_signal_read(struct vmbus_channel *chan, uint32_t bytes_read);
+void rte_vmbus_chan_signal_read(struct rte_vmbus_device *dev,
+				struct vmbus_channel *chan,
+				uint32_t bytes_read);
 
 /**
  * Determine sub channel index of the given channel
diff --git a/drivers/bus/vmbus/vmbus_channel.c b/drivers/bus/vmbus/vmbus_channel.c
index d4b5ba1979..bccef168d3 100644
--- a/drivers/bus/vmbus/vmbus_channel.c
+++ b/drivers/bus/vmbus/vmbus_channel.c
@@ -39,7 +39,8 @@ vmbus_set_monitor(const struct vmbus_channel *channel, uint32_t monitor_id)
 }
 
 static void
-vmbus_set_event(const struct vmbus_channel *chan)
+vmbus_set_event(struct rte_vmbus_device *dev __rte_unused,
+		const struct vmbus_channel *chan)
 {
 	vmbus_set_monitor(chan, chan->monitor_id);
 }
@@ -80,7 +81,7 @@ rte_vmbus_set_latency(const struct rte_vmbus_device *dev,
  * Can't do a hypercall from userspace.
  */
 void
-rte_vmbus_chan_signal_tx(const struct vmbus_channel *chan)
+rte_vmbus_chan_signal_tx(struct rte_vmbus_device *dev, const struct vmbus_channel *chan)
 {
 	const struct vmbus_br *tbr = &chan->txbr;
 
@@ -91,14 +92,15 @@ rte_vmbus_chan_signal_tx(const struct vmbus_channel *chan)
 	if (tbr->vbr->imask)
 		return;
 
-	vmbus_set_event(chan);
+	vmbus_set_event(dev, chan);
 }
 
 
 /* Do a simple send directly using transmit ring. */
-int rte_vmbus_chan_send(struct vmbus_channel *chan, uint16_t type,
-			void *data, uint32_t dlen,
-			uint64_t xactid, uint32_t flags, bool *need_sig)
+int rte_vmbus_chan_send(struct rte_vmbus_device *dev,
+			struct vmbus_channel *chan, uint16_t type, void *data,
+			uint32_t dlen, uint64_t xactid, uint32_t flags,
+			bool *need_sig)
 {
 	struct vmbus_chanpkt pkt;
 	unsigned int pktlen, pad_pktlen;
@@ -134,12 +136,13 @@ int rte_vmbus_chan_send(struct vmbus_channel *chan, uint16_t type,
 	if (need_sig)
 		*need_sig |= send_evt;
 	else if (error == 0 && send_evt)
-		rte_vmbus_chan_signal_tx(chan);
+		rte_vmbus_chan_signal_tx(dev, chan);
 	return error;
 }
 
 /* Do a scatter/gather send where the descriptor points to data. */
-int rte_vmbus_chan_send_sglist(struct vmbus_channel *chan,
+int rte_vmbus_chan_send_sglist(struct rte_vmbus_device *dev,
+			       struct vmbus_channel *chan,
 			       struct vmbus_gpa sg[], uint32_t sglen,
 			       void *data, uint32_t dlen,
 			       uint64_t xactid, bool *need_sig)
@@ -178,7 +181,7 @@ int rte_vmbus_chan_send_sglist(struct vmbus_channel *chan,
 	if (need_sig)
 		*need_sig |= send_evt;
 	else if (error == 0 && send_evt)
-		rte_vmbus_chan_signal_tx(chan);
+		rte_vmbus_chan_signal_tx(dev, chan);
 	return error;
 }
 
@@ -191,7 +194,9 @@ bool rte_vmbus_chan_rx_empty(const struct vmbus_channel *channel)
 }
 
 /* Signal host after reading N bytes */
-void rte_vmbus_chan_signal_read(struct vmbus_channel *chan, uint32_t bytes_read)
+void rte_vmbus_chan_signal_read(struct rte_vmbus_device *dev,
+				struct vmbus_channel *chan,
+				uint32_t bytes_read)
 {
 	struct vmbus_br *rbr = &chan->rxbr;
 	uint32_t write_sz, pending_sz;
@@ -218,10 +223,11 @@ void rte_vmbus_chan_signal_read(struct vmbus_channel *chan, uint32_t bytes_read)
 	if (write_sz <= pending_sz)
 		return;
 
-	vmbus_set_event(chan);
+	vmbus_set_event(dev, chan);
 }
 
-int rte_vmbus_chan_recv(struct vmbus_channel *chan, void *data, uint32_t *len,
+int rte_vmbus_chan_recv(struct rte_vmbus_device *dev,
+			struct vmbus_channel *chan, void *data, uint32_t *len,
 			uint64_t *request_id)
 {
 	struct vmbus_chanpkt_hdr pkt;
@@ -263,7 +269,7 @@ int rte_vmbus_chan_recv(struct vmbus_channel *chan, void *data, uint32_t *len,
 	if (error)
 		return error;
 
-	rte_vmbus_chan_signal_read(chan, dlen + hlen + sizeof(uint64_t));
+	rte_vmbus_chan_signal_read(dev, chan, dlen + hlen + sizeof(uint64_t));
 	return 0;
 }
 
diff --git a/drivers/net/netvsc/hn_nvs.c b/drivers/net/netvsc/hn_nvs.c
index fd20e3d06d..0b7e6c0264 100644
--- a/drivers/net/netvsc/hn_nvs.c
+++ b/drivers/net/netvsc/hn_nvs.c
@@ -62,7 +62,7 @@ struct rte_vmbus_device *get_vmbus_device(struct hn_data *hv)
 static int hn_nvs_req_send(struct hn_data *hv,
 			   void *req, uint32_t reqlen)
 {
-	return rte_vmbus_chan_send(hn_primary_chan(hv),
+	return rte_vmbus_chan_send(get_vmbus_device(hv), hn_primary_chan(hv),
 				   VMBUS_CHANPKT_TYPE_INBAND,
 				   req, reqlen, 0,
 				   VMBUS_CHANPKT_FLAG_NONE, NULL);
@@ -82,8 +82,8 @@ __hn_nvs_execute(struct hn_data *hv,
 	int ret;
 
 	/* Send request to ring buffer */
-	ret = rte_vmbus_chan_send(chan, VMBUS_CHANPKT_TYPE_INBAND,
-				  req, reqlen, 0,
+	ret = rte_vmbus_chan_send(get_vmbus_device(hv), chan,
+				  VMBUS_CHANPKT_TYPE_INBAND, req, reqlen, 0,
 				  VMBUS_CHANPKT_FLAG_RC, NULL);
 
 	if (ret) {
@@ -93,7 +93,7 @@ __hn_nvs_execute(struct hn_data *hv,
 
  retry:
 	len = sizeof(buffer);
-	ret = rte_vmbus_chan_recv(chan, buffer, &len, &xactid);
+	ret = rte_vmbus_chan_recv(get_vmbus_device(hv), chan, buffer, &len, &xactid);
 	if (ret == -EAGAIN) {
 		rte_delay_us(HN_CHAN_INTERVAL_US);
 		goto retry;
@@ -114,7 +114,7 @@ __hn_nvs_execute(struct hn_data *hv,
 	/* Silently drop received packets while waiting for response */
 	switch (hdr->type) {
 	case NVS_TYPE_RNDIS:
-		hn_nvs_ack_rxbuf(chan, xactid);
+		hn_nvs_ack_rxbuf(hv, chan, xactid);
 		/* fallthrough */
 
 	case NVS_TYPE_TXTBL_NOTE:
@@ -518,7 +518,7 @@ hn_nvs_detach(struct hn_data *hv __rte_unused)
  * so that this RXBUF can be recycled by the hypervisor.
  */
 void
-hn_nvs_ack_rxbuf(struct vmbus_channel *chan, uint64_t tid)
+hn_nvs_ack_rxbuf(struct hn_data *hv, struct vmbus_channel *chan, uint64_t tid)
 {
 	unsigned int retries = 0;
 	struct hn_nvs_rndis_ack ack = {
@@ -530,9 +530,9 @@ hn_nvs_ack_rxbuf(struct vmbus_channel *chan, uint64_t tid)
 	PMD_RX_LOG(DEBUG, "ack RX id %" PRIu64, tid);
 
  again:
-	error = rte_vmbus_chan_send(chan, VMBUS_CHANPKT_TYPE_COMP,
-				    &ack, sizeof(ack), tid,
-				    VMBUS_CHANPKT_FLAG_NONE, NULL);
+	error = rte_vmbus_chan_send(get_vmbus_device(hv), chan,
+				    VMBUS_CHANPKT_TYPE_COMP, &ack, sizeof(ack),
+				    tid, VMBUS_CHANPKT_FLAG_NONE, NULL);
 
 	if (error == 0)
 		return;
diff --git a/drivers/net/netvsc/hn_nvs.h b/drivers/net/netvsc/hn_nvs.h
index 0d8fe27b65..b7691a5dc2 100644
--- a/drivers/net/netvsc/hn_nvs.h
+++ b/drivers/net/netvsc/hn_nvs.h
@@ -214,7 +214,8 @@ struct __rte_packed_begin hn_nvs_rndis_ack {
 
 int	hn_nvs_attach(struct hn_data *hv, unsigned int mtu);
 void	hn_nvs_detach(struct hn_data *hv);
-void	hn_nvs_ack_rxbuf(struct vmbus_channel *chan, uint64_t tid);
+void	hn_nvs_ack_rxbuf(struct hn_data *hv,
+			 struct vmbus_channel *chan, uint64_t tid);
 int	hn_nvs_alloc_subchans(struct hn_data *hv, uint32_t *nsubch);
 int	hn_nvs_set_datapath(struct hn_data *hv, uint32_t path);
 void	hn_nvs_handle_vfassoc(struct rte_eth_dev *dev,
@@ -224,21 +225,21 @@ void	hn_nvs_handle_vfassoc(struct rte_eth_dev *dev,
 struct rte_vmbus_device *get_vmbus_device(struct hn_data *hv);
 
 static inline int
-hn_nvs_send(struct vmbus_channel *chan, uint16_t flags,
-	    void *nvs_msg, int nvs_msglen, uintptr_t sndc,
+hn_nvs_send(struct hn_data *hv, struct vmbus_channel *chan,
+	    uint16_t flags, void *nvs_msg, int nvs_msglen, uintptr_t sndc,
 	    bool *need_sig)
 {
-	return rte_vmbus_chan_send(chan, VMBUS_CHANPKT_TYPE_INBAND,
+	return rte_vmbus_chan_send(get_vmbus_device(hv), chan, VMBUS_CHANPKT_TYPE_INBAND,
 				   nvs_msg, nvs_msglen, (uint64_t)sndc,
 				   flags, need_sig);
 }
 
 static inline int
-hn_nvs_send_sglist(struct vmbus_channel *chan,
+hn_nvs_send_sglist(struct hn_data *hv, struct vmbus_channel *chan,
 		   struct vmbus_gpa sg[], unsigned int sglen,
 		   void *nvs_msg, int nvs_msglen,
 		   uintptr_t sndc, bool *need_sig)
 {
-	return rte_vmbus_chan_send_sglist(chan, sg, sglen, nvs_msg, nvs_msglen,
-					  (uint64_t)sndc, need_sig);
+	return rte_vmbus_chan_send_sglist(get_vmbus_device(hv), chan, sg, sglen, nvs_msg,
+					  nvs_msglen, (uint64_t)sndc, need_sig);
 }
diff --git a/drivers/net/netvsc/hn_rndis.c b/drivers/net/netvsc/hn_rndis.c
index b2dae6474a..12bea33e37 100644
--- a/drivers/net/netvsc/hn_rndis.c
+++ b/drivers/net/netvsc/hn_rndis.c
@@ -246,8 +246,9 @@ void hn_rndis_dump(const void *buf)
 }
 #endif
 
-static int hn_nvs_send_rndis_ctrl(struct vmbus_channel *chan,
-				  const void *req, uint32_t reqlen)
+static int hn_nvs_send_rndis_ctrl(struct hn_data *hv,
+				  struct vmbus_channel *chan, const void *req,
+				  uint32_t reqlen)
 
 {
 	struct hn_nvs_rndis nvs_rndis = {
@@ -282,8 +283,8 @@ static int hn_nvs_send_rndis_ctrl(struct vmbus_channel *chan,
 
 	hn_rndis_dump(req);
 
-	return hn_nvs_send_sglist(chan, &sg, 1,
-				  &nvs_rndis, sizeof(nvs_rndis), 0U, NULL);
+	return hn_nvs_send_sglist(hv, chan, &sg, 1, &nvs_rndis,
+				  sizeof(nvs_rndis), 0U, NULL);
 }
 
 /*
@@ -394,7 +395,7 @@ static int hn_rndis_exec1(struct hn_data *hv,
 		return -EBUSY;
 	}
 
-	error = hn_nvs_send_rndis_ctrl(chan, req, reqlen);
+	error = hn_nvs_send_rndis_ctrl(hv, chan, req, reqlen);
 	if (error) {
 		PMD_DRV_LOG(ERR, "RNDIS ctrl send failed: %d", error);
 		return error;
diff --git a/drivers/net/netvsc/hn_rxtx.c b/drivers/net/netvsc/hn_rxtx.c
index 9d3948e03d..ffa6937ce2 100644
--- a/drivers/net/netvsc/hn_rxtx.c
+++ b/drivers/net/netvsc/hn_rxtx.c
@@ -556,9 +556,10 @@ static void hn_rx_buf_free_cb(void *buf __rte_unused, void *opaque)
 {
 	struct hn_rx_bufinfo *rxb = opaque;
 	struct hn_rx_queue *rxq = rxb->rxq;
+	struct hn_data *hv = rxq->hv;
 
 	rte_atomic32_dec(&rxq->rxbuf_outstanding);
-	hn_nvs_ack_rxbuf(rxb->chan, rxb->xactid);
+	hn_nvs_ack_rxbuf(hv, rxb->chan, rxb->xactid);
 }
 
 static struct hn_rx_bufinfo *hn_rx_buf_init(struct hn_rx_queue *rxq,
@@ -869,7 +870,7 @@ hn_nvs_handle_rxbuf(struct rte_eth_dev *dev,
 
 	/* Send ACK now if external mbuf not used */
 	if (rte_mbuf_ext_refcnt_update(&rxb->shinfo, -1) == 0)
-		hn_nvs_ack_rxbuf(rxb->chan, rxb->xactid);
+		hn_nvs_ack_rxbuf(hv, rxb->chan, rxb->xactid);
 }
 
 /*
@@ -1175,7 +1176,7 @@ uint32_t hn_process_events(struct hn_data *hv, uint16_t queue_id,
 	}
 
 	if (bytes_read > 0)
-		rte_vmbus_chan_signal_read(rxq->chan, bytes_read);
+		rte_vmbus_chan_signal_read(get_vmbus_device(hv), rxq->chan, bytes_read);
 
 	rte_spinlock_unlock(&rxq->ring_lock);
 
@@ -1232,7 +1233,7 @@ static int hn_flush_txagg(struct hn_tx_queue *txq, bool *need_sig)
 	PMD_TX_LOG(DEBUG, "port %u:%u tx %u size %u",
 		   txq->port_id, txq->queue_id, txd->chim_index, txd->chim_size);
 
-	ret = hn_nvs_send(txq->chan, VMBUS_CHANPKT_FLAG_RC,
+	ret = hn_nvs_send(txq->hv, txq->chan, VMBUS_CHANPKT_FLAG_RC,
 			  &rndis, sizeof(rndis), (uintptr_t)txd, need_sig);
 
 	if (likely(ret == 0))
@@ -1511,9 +1512,8 @@ static int hn_xmit_sg(struct hn_tx_queue *txq,
 		   txq->port_id, txq->queue_id, txd->chim_index,
 		   segs, nvs_rndis.chim_sz);
 
-	return hn_nvs_send_sglist(txq->chan, sg, segs,
-				  &nvs_rndis, sizeof(nvs_rndis),
-				  (uintptr_t)txd, need_sig);
+	return hn_nvs_send_sglist(txq->hv, txq->chan, sg, segs, &nvs_rndis,
+				  sizeof(nvs_rndis), (uintptr_t)txd, need_sig);
 }
 
 uint16_t
@@ -1641,7 +1641,7 @@ hn_xmit_pkts(void *ptxq, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 
 fail:
 	if (need_sig)
-		rte_vmbus_chan_signal_tx(txq->chan);
+		rte_vmbus_chan_signal_tx(get_vmbus_device(hv), txq->chan);
 
 	return nb_tx;
 }
-- 
2.34.1

