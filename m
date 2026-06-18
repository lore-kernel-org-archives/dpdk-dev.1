Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DC4CD98F2
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 14:18:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AFBD6402B6;
	Thu, 18 Jun 2026 16:17:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id 62EFB40E20
 for <dev@dpdk.org>; Thu, 18 Jun 2026 16:17:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781792269; x=1813328269;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZmJy5XZwEp6JdfJsGm6Wkw43f/xOjzKoXvzT98ZnRyk=;
 b=agxOFCfUcP8WvT9CDshcjgQ5lZEIvjl/mr/HVA+fBy7Y+vjPuMtZmqPD
 6S7UjYi9vxBa7XuOxlnlFCmJD0a+2zTkDZJ46cKjeBvSqtmmv5SmGcIzR
 s97tbFdxVMxHXgyJli2MwFCe6F7tQG5Kh0tr0j55yboEyL+zFpTxo1lwq
 op7yiGY4CZMffvtONy5atGU2aQi031lblbQOR6IlFtUwh+qQ6LrpgBign
 Ap4naNQ0dlAlmGkWdrhAIy2kS4p0FSPPLUW1jOi9wsKEQmCbA5CP/e7tn
 ynQUCdDA+n4FjpAu7zCHsC7itOrkb2B5EeS5CvC17lOWvGvmA2Szl4EAP Q==;
X-CSE-ConnectionGUID: Bi3SOM5iQ6+oemtEFbKKDQ==
X-CSE-MsgGUID: KJ/g8v9xSRafCQytN4Olow==
X-IronPort-AV: E=McAfee;i="6800,10657,11820"; a="81736993"
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; d="scan'208";a="81736993"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2026 07:17:48 -0700
X-CSE-ConnectionGUID: b05tqi6aQmiUZ1NzBqDKqw==
X-CSE-MsgGUID: 4OsN/mAjTWq+MFUwO458Pw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,211,1774335600"; d="scan'208";a="248457643"
Received: from unknown (HELO localhost.igk.intel.com) ([10.123.235.20])
 by orviesa009.jf.intel.com with ESMTP; 18 Jun 2026 07:17:47 -0700
From: Dawid Wesierski <dawid.wesierski@intel.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, david.marchand@redhat.com,
 Marek Kasiewicz <marek.kasiewicz@intel.com>,
 Dawid Wesierski <dawid.wesierski@intel.com>
Subject: [PATCH v2 7/7] net/intel: support header split mbuf callback
Date: Thu, 18 Jun 2026 10:44:42 -0400
Message-ID: <20260618144442.312844-8-dawid.wesierski@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260618144442.312844-1-dawid.wesierski@intel.com>
References: <20260608164059.65420-1-dawid.wesierski@intel.com>
 <20260618144442.312844-1-dawid.wesierski@intel.com>
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

Wire the new ethdev header split mbuf callback API into the ICE PMD.
A new dev_ops hook, hdrs_mbuf_set_cb, lets applications register a
callback (and private context) on a receive queue; the callback returns
a payload buffer (virtual address and IOVA) that overrides the default
mempool-backed payload mbuf for header split RX.

The callback is invoked at three allocation points in the ICE driver:

  - initial queue setup (ice_alloc_rx_queue_mbufs),
  - bulk buffer allocation (ice_rx_alloc_bufs),
  - single-packet receive path (ice_recv_pkts).

This enables zero-copy RX for header split: the NIC DMAs the payload
directly into application-managed buffers (e.g., mapped frame buffers
with known IOVA), bypassing an extra memcpy from the mempool mbuf.

Depends on: "ethdev: add header split mbuf callback API"

Signed-off-by: Marek Kasiewicz <marek.kasiewicz@intel.com>
Signed-off-by: Dawid Wesierski <dawid.wesierski@intel.com>
---
 drivers/net/intel/common/rx.h      |  2 +
 drivers/net/intel/ice/ice_ethdev.c |  1 +
 drivers/net/intel/ice/ice_rxtx.c   | 63 ++++++++++++++++++++++++++++++
 drivers/net/intel/ice/ice_rxtx.h   |  2 +
 4 files changed, 68 insertions(+)

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
index ad9c49b339..353da8f2bd 100644
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
-- 
2.47.3

---------------------------------------------------------------------
Intel Technology Poland sp. z o.o.
ul. Slowackiego 173 | 80-298 Gdansk | Sad Rejonowy Gdansk Polnoc | VII Wydzial Gospodarczy Krajowego Rejestru Sadowego - KRS 101882 | NIP 957-07-52-316 | Kapital zakladowy 200.000 PLN.
Spolka oswiadcza, ze posiada status duzego przedsiebiorcy w rozumieniu ustawy z dnia 8 marca 2013 r. o przeciwdzialaniu nadmiernym opoznieniom w transakcjach handlowych.

Ta wiadomosc wraz z zalacznikami jest przeznaczona dla okreslonego adresata i moze zawierac informacje poufne. W razie przypadkowego otrzymania tej wiadomosci, prosimy o powiadomienie nadawcy oraz trwale jej usuniecie; jakiekolwiek przegladanie lub rozpowszechnianie jest zabronione.
This e-mail and any attachments may contain confidential material for the sole use of the intended recipient(s). If you are not the intended recipient, please contact the sender and delete all copies; any review or distribution by others is strictly prohibited.

