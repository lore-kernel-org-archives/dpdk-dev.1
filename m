Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5E9606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 05:21:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED8E040B9F;
	Fri, 30 Oct 2026 06:20:34 +0100 (CET)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTPS id 3B2B040B8C
 for <dev@dpdk.org>; Fri, 30 Oct 2026 06:20:28 +0100 (CET)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 068E81A00B9;
 Fri, 30 Oct 2026 06:20:28 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id CF8B01A00BD;
 Fri, 30 Oct 2026 06:20:27 +0100 (CET)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id C9DC61800068;
 Fri, 30 Oct 2026 13:20:26 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v5-S3 06/14] net/dpaa2: export parser protocol offsets via
 mbuf dynfield
Date: Fri, 30 Oct 2026 10:50:08 +0530
Message-ID: <20261030052016.3301766-7-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261030052016.3301766-1-prashant.gupta_3@nxp.com>
References: <20261023134346.37727-1-prashant.gupta_3@nxp.com>
 <20261030052016.3301766-1-prashant.gupta_3@nxp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jun Yang <jun.yang@nxp.com>

Add a new device argument, drv_parse_protocol_offset, to export
hardware parser protocol offsets through an mbuf dynamic field.

When enabled, the driver registers a dynamic field named
RTE_PMD_DPAA2_RX_POS_DYNFIELD_NAME and stores the parser-reported
L3, L4 and L5 protocol offsets in each received mbuf. Applications
can retrieve the information by looking up the dynamic field and
accessing the associated structure directly.

The feature is disabled by default and introduces no fast-path
overhead unless explicitly enabled through the device argument.

Example:

  fslmc:dpni.1,drv_parse_protocol_offset=1

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 doc/guides/nics/dpaa2.rst         |  5 +++
 drivers/net/dpaa2/dpaa2_ethdev.c  | 30 +++++++++++++-
 drivers/net/dpaa2/dpaa2_ethdev.h  |  5 +++
 drivers/net/dpaa2/dpaa2_rxtx.c    | 67 +++++++++++++++++++++++++++++++
 drivers/net/dpaa2/rte_pmd_dpaa2.h | 23 +++++++++++
 5 files changed, 129 insertions(+), 1 deletion(-)

diff --git a/doc/guides/nics/dpaa2.rst b/doc/guides/nics/dpaa2.rst
index 826eb4340c..745c556c21 100644
--- a/doc/guides/nics/dpaa2.rst
+++ b/doc/guides/nics/dpaa2.rst
@@ -498,6 +498,11 @@ Refer to the document :doc:`build_and_test` for details.
   By default, loose ordering is set for ordered schedule type event.
   e.g. ``fslmc:dpni.1,drv_strict_order=1``
 
+* Use dev arg option ``drv_parse_protocol_offset=1`` to populate an mbuf
+  dynamic field with hardware parser protocol offsets (L3/L4/L5). The
+  offsets can be retrieved through ``rte_mbuf_dynfield_lookup()``.
+  e.g. ``fslmc:dpni.1,drv_parse_protocol_offset=1``
+
 Enabling logs
 -------------
 
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index fb3757aaeb..f551b9731e 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -33,6 +33,33 @@
 #include <fsl_qbman_debug.h>
 #include <dpaax_devarg.h>
 
+static const struct rte_mbuf_dynfield s_dpaa2_rx_protocol_pos_dyn = {
+	.name = RTE_PMD_DPAA2_RX_POS_DYNFIELD_NAME,
+	.size = sizeof(struct dpaa2_dyn_rx_protocol_pos),
+	.align = __alignof__(struct dpaa2_dyn_rx_protocol_pos),
+};
+
+static void
+dpaa2_dev_args_parser_offset_en(void *vdev, const char *key, int val)
+{
+	struct rte_eth_dev *dev = vdev;
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	int ret;
+
+	RTE_SET_USED(key);
+
+	if (!val)
+		return;
+
+	ret = rte_mbuf_dynfield_register(&s_dpaa2_rx_protocol_pos_dyn);
+	if (ret < 0) {
+		DPAA2_PMD_ERR("Failed(%d) to register for protocol pos", ret);
+		return;
+	}
+	DPAA2_PMD_INFO("Register mbuf offset(%d) for protocol pos", ret);
+	priv->psr_dynfield_offset = ret | DPAA2_PSR_DYNFIELD_OFFSET_EN;
+}
+
 static void
 dpaa2_dev_args_set_strict_order(void *vdev, const char *key, int val)
 {
@@ -60,7 +87,8 @@ dpaa2_dev_args_set_strict_order(void *vdev, const char *key, int val)
 	ENTRY("drv_error_queue", NULL, DPAA2_RX_ERROR_QUEUE_FLAG) \
 	ENTRY("drv_no_taildrop", NULL, DPAA2_RX_TAILDROP_OFF) \
 	ENTRY("drv_no_data_stashing", NULL, DPAA2_RX_DATA_STASHING_OFF_FLAG) \
-	ENTRY("drv_strict_order", dpaa2_dev_args_set_strict_order, 0)
+	ENTRY("drv_strict_order", dpaa2_dev_args_set_strict_order, 0) \
+	ENTRY("drv_parse_protocol_offset", dpaa2_dev_args_parser_offset_en, 0)
 
 #define CHECK_INTERVAL         100  /* 100ms */
 #define MAX_REPEAT_TIME        90   /* 9s (90 * 100ms) in total */
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index 0c2a1121ed..b01e08b7b1 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -58,6 +58,10 @@
 
 #define CONG_RETRY_COUNT 18000
 
+#define DPAA2_PSR_DYNFIELD_OFFSET_EN RTE_BIT32(31)
+#define DPAA2_PSR_DYNFIELD_OFFSET_MASK \
+	(DPAA2_PSR_DYNFIELD_OFFSET_EN - 1)
+
 /* RX queue tail drop threshold
  * currently considering 64 KB packets
  */
@@ -436,6 +440,7 @@ struct dpaa2_dev_priv {
 	void *tx_conf_vq[MAX_TX_QUEUES * DPAA2_MAX_CHANNELS];
 	void *rx_err_vq;
 	uint32_t flags; /*dpaa2 config flags */
+	uint32_t psr_dynfield_offset;
 	uint8_t max_mac_filters;
 	uint8_t max_vlan_filters;
 	uint8_t num_rx_tc;
diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index bc9a8a2cd8..e52b05ab96 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -46,6 +46,41 @@ dpaa2_timestamp_dynfield(struct rte_mbuf *mbuf)
 		dpaa2_timestamp_dynfield_offset, rte_mbuf_timestamp_t *);
 }
 
+static inline void
+dpaa2_dev_rx_annot_prefetch(const struct qbman_fd *fd)
+{
+	size_t fd_addr;
+	void *hw_annot_addr;
+
+	fd_addr = (size_t)DPAA2_IOVA_TO_VADDR(DPAA2_GET_FD_ADDR(fd));
+	hw_annot_addr = (void *)(fd_addr + DPAA2_FD_PTA_SIZE);
+	rte_prefetch0(hw_annot_addr);
+}
+
+static inline void
+dpaa2_dev_rx_parse_offset(struct dpaa2_dev_priv *priv,
+	struct rte_mbuf *mbuf, const struct qbman_fd *fd)
+{
+	size_t fd_addr;
+	const struct dpaa2_annot_hdr *annotation;
+	uint64_t word6;
+	struct dpaa2_psr_result_word6 *decoded;
+	struct dpaa2_dyn_rx_protocol_pos *pos;
+
+	fd_addr = (size_t)DPAA2_IOVA_TO_VADDR(DPAA2_GET_FD_ADDR(fd));
+	annotation = (void *)(fd_addr + DPAA2_FD_PTA_SIZE);
+
+	pos = RTE_MBUF_DYNFIELD(mbuf,
+		priv->psr_dynfield_offset & DPAA2_PSR_DYNFIELD_OFFSET_MASK,
+		struct dpaa2_dyn_rx_protocol_pos *);
+
+	word6 = rte_be_to_cpu_64(annotation->word6);
+	decoded = (void *)&word6;
+	pos->l3_offset = decoded->l3_off;
+	pos->l4_offset = decoded->l4_off;
+	pos->l5_offset = decoded->l5_off;
+}
+
 #define DPAA2_MBUF_TO_CONTIG_FD(_mbuf, _fd, _bpid)  do { \
 	DPAA2_SET_FD_ADDR(_fd, DPAA2_MBUF_VADDR_TO_IOVA(_mbuf)); \
 	DPAA2_SET_FD_LEN(_fd, _mbuf->data_len); \
@@ -755,10 +790,14 @@ dpaa2_dev_rx_err_pkts_dump(struct dpaa2_queue *dpaa2_q)
 		hw_annot_addr = (void *)((size_t)v_addr + DPAA2_FD_PTA_SIZE);
 		fas = hw_annot_addr;
 
+		if (priv->psr_dynfield_offset & DPAA2_PSR_DYNFIELD_OFFSET_EN)
+			dpaa2_dev_rx_annot_prefetch(fd);
 		if (DPAA2_FD_GET_FORMAT(fd) == qbman_fd_sg)
 			mbuf = dpaa2_eth_sg_fd_to_mbuf(priv, fd);
 		else
 			mbuf = dpaa2_eth_fd_to_mbuf(priv, fd);
+		if (priv->psr_dynfield_offset & DPAA2_PSR_DYNFIELD_OFFSET_EN)
+			dpaa2_dev_rx_parse_offset(priv, mbuf, fd);
 
 		dpaa2_dev_rx_print_parser_result(priv, fd, mbuf, dpaa2_q);
 
@@ -922,10 +961,14 @@ dpaa2_dev_prefetch_rx_common(void *queue, struct rte_mbuf **bufs,
 
 		fd = qbman_result_DQ_fd(dq_storage);
 
+		if (priv->psr_dynfield_offset & DPAA2_PSR_DYNFIELD_OFFSET_EN)
+			dpaa2_dev_rx_annot_prefetch(fd);
 		if (unlikely(DPAA2_FD_GET_FORMAT(fd) == qbman_fd_sg))
 			bufs[num_rx] = dpaa2_eth_sg_fd_to_mbuf(priv, fd);
 		else
 			bufs[num_rx] = dpaa2_eth_fd_to_mbuf(priv, fd);
+		if (priv->psr_dynfield_offset & DPAA2_PSR_DYNFIELD_OFFSET_EN)
+			dpaa2_dev_rx_parse_offset(priv, bufs[num_rx], fd);
 
 		dpaa2_dev_rx_print_parser_result(priv, fd, bufs[num_rx], dpaa2_q);
 
@@ -985,6 +1028,9 @@ dpaa2_dev_process_parallel_event(struct qbman_swp *swp,
 				 struct dpaa2_queue *rxq,
 				 struct rte_event *ev)
 {
+	struct rte_eth_dev_data *eth_data = rxq->eth_data;
+	struct dpaa2_dev_priv *priv = eth_data->dev_private;
+
 	rte_prefetch0((void *)(size_t)(DPAA2_GET_FD_ADDR(fd) +
 		DPAA2_FD_PTA_SIZE + 16));
 
@@ -996,10 +1042,14 @@ dpaa2_dev_process_parallel_event(struct qbman_swp *swp,
 	ev->queue_id = rxq->ev.queue_id;
 	ev->priority = rxq->ev.priority;
 
+	if (priv->psr_dynfield_offset & DPAA2_PSR_DYNFIELD_OFFSET_EN)
+		dpaa2_dev_rx_annot_prefetch(fd);
 	if (unlikely(DPAA2_FD_GET_FORMAT(fd) == qbman_fd_sg))
 		ev->mbuf = dpaa2_eth_sg_fd_to_mbuf(rxq->eth_data->dev_private, fd);
 	else
 		ev->mbuf = dpaa2_eth_fd_to_mbuf(rxq->eth_data->dev_private, fd);
+	if (priv->psr_dynfield_offset & DPAA2_PSR_DYNFIELD_OFFSET_EN)
+		dpaa2_dev_rx_parse_offset(priv, ev->mbuf, fd);
 
 	qbman_swp_dqrr_consume(swp, dq);
 }
@@ -1011,6 +1061,8 @@ dpaa2_dev_process_atomic_event(struct qbman_swp *swp __rte_unused,
 			       struct dpaa2_queue *rxq,
 			       struct rte_event *ev)
 {
+	struct rte_eth_dev_data *eth_data = rxq->eth_data;
+	struct dpaa2_dev_priv *priv = eth_data->dev_private;
 	uint8_t dqrr_index;
 
 	rte_prefetch0((void *)(size_t)(DPAA2_GET_FD_ADDR(fd) +
@@ -1024,10 +1076,14 @@ dpaa2_dev_process_atomic_event(struct qbman_swp *swp __rte_unused,
 	ev->queue_id = rxq->ev.queue_id;
 	ev->priority = rxq->ev.priority;
 
+	if (priv->psr_dynfield_offset & DPAA2_PSR_DYNFIELD_OFFSET_EN)
+		dpaa2_dev_rx_annot_prefetch(fd);
 	if (unlikely(DPAA2_FD_GET_FORMAT(fd) == qbman_fd_sg))
 		ev->mbuf = dpaa2_eth_sg_fd_to_mbuf(rxq->eth_data->dev_private, fd);
 	else
 		ev->mbuf = dpaa2_eth_fd_to_mbuf(rxq->eth_data->dev_private, fd);
+	if (priv->psr_dynfield_offset & DPAA2_PSR_DYNFIELD_OFFSET_EN)
+		dpaa2_dev_rx_parse_offset(priv, ev->mbuf, fd);
 
 	dqrr_index = qbman_get_dqrr_idx(dq);
 	*dpaa2_seqn(ev->mbuf) = dqrr_index + 1;
@@ -1043,6 +1099,9 @@ dpaa2_dev_process_ordered_event(struct qbman_swp *swp,
 				struct dpaa2_queue *rxq,
 				struct rte_event *ev)
 {
+	struct rte_eth_dev_data *eth_data = rxq->eth_data;
+	struct dpaa2_dev_priv *priv = eth_data->dev_private;
+
 	rte_prefetch0((void *)(size_t)(DPAA2_GET_FD_ADDR(fd) +
 		DPAA2_FD_PTA_SIZE + 16));
 
@@ -1054,10 +1113,14 @@ dpaa2_dev_process_ordered_event(struct qbman_swp *swp,
 	ev->queue_id = rxq->ev.queue_id;
 	ev->priority = rxq->ev.priority;
 
+	if (priv->psr_dynfield_offset & DPAA2_PSR_DYNFIELD_OFFSET_EN)
+		dpaa2_dev_rx_annot_prefetch(fd);
 	if (unlikely(DPAA2_FD_GET_FORMAT(fd) == qbman_fd_sg))
 		ev->mbuf = dpaa2_eth_sg_fd_to_mbuf(rxq->eth_data->dev_private, fd);
 	else
 		ev->mbuf = dpaa2_eth_fd_to_mbuf(rxq->eth_data->dev_private, fd);
+	if (priv->psr_dynfield_offset & DPAA2_PSR_DYNFIELD_OFFSET_EN)
+		dpaa2_dev_rx_parse_offset(priv, ev->mbuf, fd);
 
 	*dpaa2_seqn(ev->mbuf) = DPAA2_ENQUEUE_FLAG_ORP;
 	*dpaa2_seqn(ev->mbuf) |= qbman_result_DQ_odpid(dq) << DPAA2_EQCR_OPRID_SHIFT;
@@ -1168,10 +1231,14 @@ dpaa2_dev_rx_common(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts,
 
 			fd = qbman_result_DQ_fd(dq_storage);
 
+			if (priv->psr_dynfield_offset & DPAA2_PSR_DYNFIELD_OFFSET_EN)
+				dpaa2_dev_rx_annot_prefetch(fd);
 			if (unlikely(DPAA2_FD_GET_FORMAT(fd) == qbman_fd_sg))
 				bufs[num_rx] = dpaa2_eth_sg_fd_to_mbuf(priv, fd);
 			else
 				bufs[num_rx] = dpaa2_eth_fd_to_mbuf(priv, fd);
+			if (priv->psr_dynfield_offset & DPAA2_PSR_DYNFIELD_OFFSET_EN)
+				dpaa2_dev_rx_parse_offset(priv, bufs[num_rx], fd);
 
 #if defined(RTE_LIBRTE_IEEE1588)
 		if (bufs[num_rx]->ol_flags & RTE_MBUF_F_RX_IEEE1588_TMST) {
diff --git a/drivers/net/dpaa2/rte_pmd_dpaa2.h b/drivers/net/dpaa2/rte_pmd_dpaa2.h
index 83bee098bc..cef2e84143 100644
--- a/drivers/net/dpaa2/rte_pmd_dpaa2.h
+++ b/drivers/net/dpaa2/rte_pmd_dpaa2.h
@@ -145,6 +145,29 @@ __rte_experimental
 const char *
 rte_pmd_dpaa2_ep_name(uint32_t eth_id);
 
+#define RTE_PMD_DPAA2_RX_POS_DYNFIELD_NAME "rte_pmd_dpaa2_rx_pos"
+
+struct dpaa2_dyn_rx_protocol_pos {
+	uint8_t l3_offset;
+	uint8_t l4_offset;
+	uint8_t l5_offset;
+	uint8_t rsv;
+};
+/**
+ *	static int offset = -1;
+ *	struct dpaa2_dyn_rx_protocol_pos *pos;
+ *
+ *	if (offset < 0) {
+ *		offset = rte_mbuf_dynfield_lookup(RTE_PMD_DPAA2_RX_POS_DYNFIELD_NAME,
+ *			NULL);
+ *		if (offset < 0)
+ *			return NULL;
+ *	}
+ *
+ *	pos = RTE_MBUF_DYNFIELD(m, offset, struct dpaa2_dyn_rx_protocol_pos);
+ *	return pos;
+ */
+
 #if defined(RTE_LIBRTE_IEEE1588)
 __rte_experimental
 int
-- 
2.43.0

