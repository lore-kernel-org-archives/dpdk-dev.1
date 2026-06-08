Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54055CD8C9D
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 16:14:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47C4640A6F;
	Mon,  8 Jun 2026 18:14:27 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id C7724406FF
 for <dev@dpdk.org>; Mon,  8 Jun 2026 18:14:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780935266; x=1812471266;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=caLc9YfdiDML/qYXJgssO8alhuPCZFxMTETYmmIGSsg=;
 b=jug0/YEIob9SlY6RJ3WC7JuEiyYmFfZz6lygJ1iQLXuGkCTbUzNMrnpZ
 utCmhJkcq8+wAuDD0hTnXqw+Crx5tKDFtclj2krIM2RKYHVxz/XaoZlMZ
 lgoB1pzuoSyCSazF+9lxPoUAA0evWMpF4fMdReMzmw7nBDzaP4fhpyoxz
 Zlu4ZbwGBzwxD7vKNessBoC3vgNd+L7k5u9thy64FJUzZQS5M2ONFFl37
 D1pM/7k7QPgeH7KQvLUOmGbeD3A5Oz7qt7X0iyxRILE89suBo2J2Gm+wZ
 qwWHdlD/L7usLBWCOsPt7tGdMFOkQmF+OcqALN5xeJUyFXtjy6i92CiK3 w==;
X-CSE-ConnectionGUID: twod2KBOSsqqvUTLWSuwnA==
X-CSE-MsgGUID: OarJJa7FS3WWe1HtRux27g==
X-IronPort-AV: E=McAfee;i="6800,10657,11811"; a="80809599"
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="80809599"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2026 09:14:26 -0700
X-CSE-ConnectionGUID: xZLa3ghWR5OaFbDYk1210Q==
X-CSE-MsgGUID: XTtgdNyQT3mfeBlfoT7qUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,194,1774335600"; d="scan'208";a="245457491"
Received: from unknown (HELO localhost.igk.intel.com) ([10.123.235.20])
 by orviesa008.jf.intel.com with ESMTP; 08 Jun 2026 09:14:23 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, david.marchand@redhat.com,
 vladimir.medvedkin@intel.com, bruce.richardson@intel.com,
 anatoly.burakov@intel.com, reshma.pattan@intel.com,
 stephen@networkplumber.org, Marek Kasiewicz <marek.kasiewicz@intel.com>,
 Dawid Wesierski <dawid.wesierski@intel.com>
Subject: [PATCH 7/7] net/ice: add header split mbuf callback support
Date: Mon,  8 Jun 2026 12:40:59 -0400
Message-ID: <20260608164059.65420-8-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260608164059.65420-1-dawid.wesierski@intel.com>
References: <20260608164059.65420-1-dawid.wesierski@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
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

From: Marek Kasiewicz <marek.kasiewicz@intel.com>

Add an ethdev API rte_eth_hdrs_set_mbuf_callback() that allows
applications to register a callback providing custom payload mbufs
for header split RX mode. When registered, the ICE PMD calls this
callback at mbuf allocation points to obtain user-provided payload
buffers instead of allocating from the mempool.

This enables zero-copy RX for header split: the NIC DMAs the payload
directly into application-managed buffers (e.g., mapped frame buffers
with known IOVA), bypassing an extra memcpy from the mempool mbuf.

The callback is invoked at three allocation points in the ICE driver:
initial queue setup, bulk buffer allocation, and single-packet
receive path.


Signed-off-by: Marek Kasiewicz <marek.kasiewicz@intel.com>
Signed-off-by: Dawid Wesierski <dawid.wesierski@intel.com>
---
 drivers/net/intel/common/rx.h      |  2 +
 drivers/net/intel/ice/ice_ethdev.c |  1 +
 drivers/net/intel/ice/ice_rxtx.c   | 63 ++++++++++++++++++++++++++++++
 drivers/net/intel/ice/ice_rxtx.h   |  2 +
 lib/ethdev/ethdev_driver.h         | 10 +++++
 lib/ethdev/rte_ethdev.c            | 17 ++++++++
 lib/ethdev/rte_ethdev.h            | 46 ++++++++++++++++++++++
 7 files changed, 141 insertions(+)

diff --git a/drivers/net/intel/common/rx.h b/drivers/net/intel/common/rx.h
index e0bf520ebd..8abb2a3ce9 100644
--- a/drivers/net/intel/common/rx.h
+++ b/drivers/net/intel/common/rx.h
@@ -113,6 +113,8 @@ struct ci_rx_queue {
 			uint32_t hw_time_low; /* low 32 bits of timestamp */
 			int ts_offset; /* dynamic mbuf timestamp field offset */
 			uint64_t ts_flag; /* dynamic mbuf timestamp flag */
+			rte_eth_hdrs_mbuf_callback_fn hdrs_mbuf_cb; /* hdr split mbuf cb */
+			void *hdrs_mbuf_cb_priv; /* hdr split mbuf cb priv */
 		};
 		struct { /* iavf specific values */
 			const struct iavf_rxq_ops *ops; /**< queue ops */
diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index b7cea3bfc1..fb15438dbc 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -282,6 +282,7 @@ static const struct eth_dev_ops ice_eth_dev_ops = {
 	.dev_set_link_down            = ice_dev_set_link_down,
 	.dev_led_on                   = ice_dev_led_on,
 	.dev_led_off                  = ice_dev_led_off,
+	.hdrs_mbuf_set_cb             = ice_hdrs_mbuf_set_cb,
 	.rx_queue_start               = ice_rx_queue_start,
 	.rx_queue_stop                = ice_rx_queue_stop,
 	.tx_queue_start               = ice_tx_queue_start,
diff --git a/drivers/net/intel/ice/ice_rxtx.c b/drivers/net/intel/ice/ice_rxtx.c
index 8d709125f7..867f595291 100644
--- a/drivers/net/intel/ice/ice_rxtx.c
+++ b/drivers/net/intel/ice/ice_rxtx.c
@@ -487,6 +487,17 @@ ice_alloc_rx_queue_mbufs(struct ci_rx_queue *rxq)
 				return -ENOMEM;
 			}
 
+			if (rxq->hdrs_mbuf_cb) {
+				struct rte_eth_hdrs_mbuf hdrs_mbuf = {0};
+				int ret = rxq->hdrs_mbuf_cb(rxq->hdrs_mbuf_cb_priv,
+					&hdrs_mbuf);
+
+				if (ret >= 0) {
+					mbuf_pay->buf_addr = hdrs_mbuf.buf_addr;
+					mbuf_pay->buf_iova = hdrs_mbuf.buf_iova;
+				}
+			}
+
 			mbuf_pay->next = NULL;
 			mbuf_pay->data_off = RTE_PKTMBUF_HEADROOM;
 			mbuf_pay->nb_segs = 1;
@@ -2126,6 +2137,16 @@ ice_rx_alloc_bufs(struct ci_rx_queue *rxq)
 			rxdp[i].read.pkt_addr = dma_addr;
 		} else {
 			mb->next = rxq->sw_split_buf[i].mbuf;
+			if (rxq->hdrs_mbuf_cb && mb->next) {
+				struct rte_eth_hdrs_mbuf hdrs_mbuf = {0};
+				int ret = rxq->hdrs_mbuf_cb(rxq->hdrs_mbuf_cb_priv,
+					&hdrs_mbuf);
+
+				if (ret >= 0) {
+					mb->next->buf_addr = hdrs_mbuf.buf_addr;
+					mb->next->buf_iova = hdrs_mbuf.buf_iova;
+				}
+			}
 			pay_addr = rte_cpu_to_le_64(rte_mbuf_data_iova_default(mb->next));
 			rxdp[i].read.hdr_addr = dma_addr;
 			rxdp[i].read.pkt_addr = pay_addr;
@@ -2810,6 +2831,17 @@ ice_recv_pkts(void *rx_queue,
 				break;
 			}
 
+			if (rxq->hdrs_mbuf_cb) {
+				struct rte_eth_hdrs_mbuf hdrs_mbuf = {0};
+				int ret = rxq->hdrs_mbuf_cb(rxq->hdrs_mbuf_cb_priv,
+					&hdrs_mbuf);
+
+				if (ret >= 0) {
+					nmb_pay->buf_addr = hdrs_mbuf.buf_addr;
+					nmb_pay->buf_iova = hdrs_mbuf.buf_iova;
+				}
+			}
+
 			nmb->next = nmb_pay;
 			nmb_pay->next = NULL;
 
@@ -4533,3 +4565,34 @@ ice_fdir_programming(struct ice_pf *pf, struct ice_fltr_desc *fdir_desc)
 
 
 }
+
+int
+ice_hdrs_mbuf_set_cb(struct rte_eth_dev *dev, uint16_t rx_queue_id,
+	void *priv, rte_eth_hdrs_mbuf_callback_fn cb)
+{
+	struct ci_rx_queue *rxq;
+
+	if (rx_queue_id >= dev->data->nb_rx_queues) {
+		PMD_DRV_LOG(ERR, "RX queue %u out of range", rx_queue_id);
+		return -EINVAL;
+	}
+
+	rxq = dev->data->rx_queues[rx_queue_id];
+	if (rxq == NULL) {
+		PMD_DRV_LOG(ERR, "RX queue %u not available or setup", rx_queue_id);
+		return -EINVAL;
+	}
+
+	if (rxq->hdrs_mbuf_cb) {
+		PMD_DRV_LOG(ERR, "RX queue %u has hdrs mbuf cb already",
+			rx_queue_id);
+		return -EEXIST;
+	}
+
+	rxq->hdrs_mbuf_cb_priv = priv;
+	rxq->hdrs_mbuf_cb = cb;
+	PMD_DRV_LOG(NOTICE, "RX queue %u register hdrs mbuf cb at %p",
+		rx_queue_id, cb);
+
+	return 0;
+}
diff --git a/drivers/net/intel/ice/ice_rxtx.h b/drivers/net/intel/ice/ice_rxtx.h
index 999b6b30d6..7ed114ee94 100644
--- a/drivers/net/intel/ice/ice_rxtx.h
+++ b/drivers/net/intel/ice/ice_rxtx.h
@@ -303,6 +303,8 @@ uint16_t ice_xmit_pkts_vec_avx512_offload(void *tx_queue,
 int ice_fdir_programming(struct ice_pf *pf, struct ice_fltr_desc *fdir_desc);
 int ice_tx_done_cleanup(void *txq, uint32_t free_cnt);
 int ice_get_monitor_addr(void *rx_queue, struct rte_power_monitor_cond *pmc);
+int ice_hdrs_mbuf_set_cb(struct rte_eth_dev *dev, uint16_t rx_queue_id,
+		void *priv, rte_eth_hdrs_mbuf_callback_fn cb);
 enum rte_vect_max_simd ice_get_max_simd_bitwidth(void);
 
 #define FDIR_PARSING_ENABLE_PER_QUEUE(ad, on) do { \
diff --git a/lib/ethdev/ethdev_driver.h b/lib/ethdev/ethdev_driver.h
index 0f336f9567..b48681268c 100644
--- a/lib/ethdev/ethdev_driver.h
+++ b/lib/ethdev/ethdev_driver.h
@@ -1292,6 +1292,13 @@ typedef int (*eth_cman_config_set_t)(struct rte_eth_dev *dev,
 typedef int (*eth_cman_config_get_t)(struct rte_eth_dev *dev,
 				struct rte_eth_cman_config *config);
 
+/** @internal
+ * Set header split payload mbuf callback for a receive queue.
+ */
+typedef int (*eth_hdrs_mbuf_set_cb_t)(struct rte_eth_dev *dev,
+	uint16_t rx_queue_id, void *priv,
+	rte_eth_hdrs_mbuf_callback_fn cb);
+
 /**
  * @internal
  * Dump Rx descriptor info to a file.
@@ -1652,6 +1659,9 @@ struct eth_dev_ops {
 	/** Dump Tx descriptor info */
 	eth_tx_descriptor_dump_t eth_tx_descriptor_dump;
 
+	/** Set header split mbuf callback */
+	eth_hdrs_mbuf_set_cb_t hdrs_mbuf_set_cb;
+
 	/** Get congestion management information */
 	eth_cman_info_get_t cman_info_get;
 	/** Initialize congestion management structure with default values */
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index 9efeaf77cb..d5820ccd22 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -7316,6 +7316,23 @@ rte_eth_ip_reassembly_conf_set(uint16_t port_id,
 	return ret;
 }
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_hdrs_set_mbuf_callback, 26.07)
+int
+rte_eth_hdrs_set_mbuf_callback(uint16_t port_id, uint16_t rx_queue_id,
+	void *priv, rte_eth_hdrs_mbuf_callback_fn cb)
+{
+	struct rte_eth_dev *dev;
+
+	RTE_ETH_VALID_PORTID_OR_ERR_RET(port_id, -ENODEV);
+	dev = &rte_eth_devices[port_id];
+
+	if (dev->dev_ops->hdrs_mbuf_set_cb == NULL)
+		return -ENOTSUP;
+
+	return eth_err(port_id,
+		dev->dev_ops->hdrs_mbuf_set_cb(dev, rx_queue_id, priv, cb));
+}
+
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_dev_priv_dump, 22.03)
 int
 rte_eth_dev_priv_dump(uint16_t port_id, FILE *file)
diff --git a/lib/ethdev/rte_ethdev.h b/lib/ethdev/rte_ethdev.h
index ee400b386f..dbf2c23a35 100644
--- a/lib/ethdev/rte_ethdev.h
+++ b/lib/ethdev/rte_ethdev.h
@@ -6985,6 +6985,52 @@ rte_eth_tx_buffer(uint16_t port_id, uint16_t queue_id,
 	return rte_eth_tx_buffer_flush(port_id, queue_id, buffer);
 }
 
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change, or be removed, without prior notice.
+ *
+ * Buffer descriptor for header split payload mbuf callback.
+ */
+struct rte_eth_hdrs_mbuf {
+	void *buf_addr;       /**< Virtual address of payload buffer. */
+	rte_iova_t buf_iova;  /**< IOVA of payload buffer. */
+};
+
+/**
+ * Callback function type for providing custom payload mbufs
+ * in header split mode.
+ *
+ * @param priv
+ *   User-provided private context.
+ * @param mbuf
+ *   Pointer to buffer descriptor to be filled by the callback.
+ * @return
+ *   0 on success, negative errno on failure.
+ */
+typedef int (*rte_eth_hdrs_mbuf_callback_fn)(void *priv,
+	struct rte_eth_hdrs_mbuf *mbuf);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change, or be removed, without prior notice.
+ *
+ * Register a callback to provide custom payload mbufs for header split RX.
+ *
+ * @param port_id
+ *   The port identifier of the Ethernet device.
+ * @param rx_queue_id
+ *   The index of the receive queue.
+ * @param priv
+ *   User-provided private context passed to the callback.
+ * @param cb
+ *   Callback function that provides payload buffer descriptors.
+ * @return
+ *   0 on success, negative errno on failure.
+ */
+__rte_experimental
+int rte_eth_hdrs_set_mbuf_callback(uint16_t port_id, uint16_t rx_queue_id,
+		void *priv, rte_eth_hdrs_mbuf_callback_fn cb);
+
 /**
  * @warning
  * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
-- 
2.47.3

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

