Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1181606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:44:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0799D40B8C;
	Fri, 23 Oct 2026 15:44:02 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 870F240647
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:43:58 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 64AD51A0040;
 Fri, 23 Oct 2026 15:43:58 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2EFE91A000A;
 Fri, 23 Oct 2026 15:43:58 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id C85C818000B5;
 Fri, 23 Oct 2026 21:43:56 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 06/65] net/dpaa2: expose Rx L3/L4/L5 offsets via mbuf
 dynfield
Date: Fri, 23 Oct 2026 19:12:46 +0530
Message-ID: <20261023134346.37727-7-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023134346.37727-1-prashant.gupta_3@nxp.com>
References: <20260915120208.4185877-1-prashant.gupta_3@nxp.com>
 <20261023134346.37727-1-prashant.gupta_3@nxp.com>
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

The DPAA2 WRIOP parser already writes the L3, L4 and L5 header
offsets of each received frame into the hardware annotation area
(FAS word6). Applications that want to work with inner headers
(IPsec, tunnel decap, L5 inspection, etc.) currently have to
re-parse the packet in software even though the information is a
single load away. Expose it through a per-mbuf dynfield so the
PMD can hand it to the application without touching generic mbuf
fields.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c  | 29 +++++++++-
 drivers/net/dpaa2/dpaa2_ethdev.h  | 12 +++++
 drivers/net/dpaa2/dpaa2_rxtx.c    | 89 +++++++++++++++++++++++++++++++
 drivers/net/dpaa2/rte_pmd_dpaa2.h |  4 ++
 4 files changed, 133 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index cd39c7874e..9a0dacfe4e 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -33,6 +33,32 @@
 #include <fsl_qbman_debug.h>
 #include <dpaax_devarg.h>
 
+static const struct rte_mbuf_dynfield s_dpaa2_rx_protocol_pos_dyn = {
+	.name = "dpaa2_rx_protocol_pos_dyn",
+	.size = sizeof(struct dpaa2_dyn_rx_protocol_pos),
+	.align = __alignof__(struct dpaa2_dyn_rx_protocol_pos),
+};
+
+static void
+dpaa2_dev_args_parser_offset_en(void *vdev,
+	const struct rte_kvargs_pair *pair)
+{
+	struct rte_eth_dev *dev = vdev;
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	int ret, val = atoi(pair->value);
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
 /* Single source of truth for dpaa2 devargs:
  *   ENTRY(key-string, handle, flag-bit)
  * handle is an optional per-arg callback (NULL if the arg only sets a flag).
@@ -48,7 +74,8 @@
 	ENTRY("drv_rx_print_parser_result", NULL, DPAA2_RX_PRINT_PSR_RESULT_FLAG) \
 	ENTRY("drv_err_queue", NULL, DPAA2_RX_ERROR_QUEUE_FLAG) \
 	ENTRY("drv_no_taildrop", NULL, DPAA2_RX_TAILDROP_OFF) \
-	ENTRY("drv_no_data_stashing", NULL, DPAA2_RX_DATA_STASHING_OFF_FLAG)
+	ENTRY("drv_no_data_stashing", NULL, DPAA2_RX_DATA_STASHING_OFF_FLAG) \
+	ENTRY("drv_parse_protocol_offset", dpaa2_dev_args_parser_offset_en, 0)
 
 #define CHECK_INTERVAL         100  /* 100ms */
 #define MAX_REPEAT_TIME        90   /* 9s (90 * 100ms) in total */
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index 5b51414000..98430e3f66 100644
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
@@ -234,6 +238,13 @@ extern const struct rte_flow_ops dpaa2_flow_ops;
 
 extern const struct rte_tm_ops dpaa2_tm_ops;
 
+struct dpaa2_dyn_rx_protocol_pos {
+	uint8_t l3_offset;
+	uint8_t l4_offset;
+	uint8_t l5_offset;
+	uint8_t rsv;
+};
+
 #define DPAA2_FS_FLC_FS_MARK_OFFSET \
 	(DPAA2_FLC_DATA_STASHING + DPAA2_FLC_STASHING_MAX_BIT_SIZE)
 
@@ -436,6 +447,7 @@ struct dpaa2_dev_priv {
 	void *tx_conf_vq[MAX_TX_QUEUES * DPAA2_MAX_CHANNELS];
 	void *rx_err_vq;
 	uint32_t flags; /*dpaa2 config flags */
+	uint32_t psr_dynfield_offset;
 	uint8_t max_mac_filters;
 	uint8_t max_vlan_filters;
 	uint8_t num_rx_tc;
diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index 060f525233..02494686d3 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -46,6 +46,83 @@ dpaa2_timestamp_dynfield(struct rte_mbuf *mbuf)
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
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_dpaa2_rx_get_offset, 26.11)
+int
+rte_pmd_dpaa2_rx_get_offset(uint16_t port_id, struct rte_mbuf *m,
+	uint8_t *l3_off, uint8_t *l4_off, uint8_t *l5_off)
+{
+	struct rte_eth_dev *dev;
+	struct dpaa2_dyn_rx_protocol_pos *pos;
+	struct dpaa2_dev_priv *priv;
+
+	if (port_id >= RTE_MAX_ETHPORTS)
+		port_id = m->port;
+
+	if (unlikely(!rte_pmd_dpaa2_dev_is_dpaa2(port_id)))
+		return -EINVAL;
+
+	dev = &rte_eth_devices[port_id];
+	if (!dev->data)
+		return -EINVAL;
+
+	if (!dev->data->dev_private)
+		return -EINVAL;
+
+	priv = dev->data->dev_private;
+	if (unlikely(!(priv->psr_dynfield_offset & DPAA2_PSR_DYNFIELD_OFFSET_EN))) {
+		DPAA2_PMD_ERR("Not register for RX protocol pos.");
+
+		return -EINVAL;
+	}
+	pos = RTE_MBUF_DYNFIELD(m,
+		priv->psr_dynfield_offset & DPAA2_PSR_DYNFIELD_OFFSET_MASK,
+		struct dpaa2_dyn_rx_protocol_pos *);
+
+	if (l3_off)
+		*l3_off = pos->l3_offset;
+	if (l4_off)
+		*l4_off = pos->l4_offset;
+	if (l5_off)
+		*l5_off = pos->l5_offset;
+
+	return 0;
+}
+
 #define DPAA2_MBUF_TO_CONTIG_FD(_mbuf, _fd, _bpid)  do { \
 	DPAA2_SET_FD_ADDR(_fd, DPAA2_MBUF_VADDR_TO_IOVA(_mbuf)); \
 	DPAA2_SET_FD_LEN(_fd, _mbuf->data_len); \
@@ -745,10 +822,14 @@ dpaa2_dev_rx_err_pkts_dump(struct dpaa2_queue *dpaa2_q)
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
 
 		dpaa2_dev_rx_print_parser_result(priv, fd, mbuf);
 
@@ -912,10 +993,14 @@ dpaa2_dev_prefetch_rx_common(void *queue, struct rte_mbuf **bufs,
 
 		fd = qbman_result_DQ_fd(dq_storage);
 
+		if (priv->psr_dynfield_offset & DPAA2_PSR_DYNFIELD_OFFSET_EN)
+			dpaa2_dev_rx_annot_prefetch(fd);
 		if (unlikely(DPAA2_FD_GET_FORMAT(fd) == qbman_fd_sg))
 			bufs[num_rx] = dpaa2_eth_sg_fd_to_mbuf(priv, fd);
 		else
 			bufs[num_rx] = dpaa2_eth_fd_to_mbuf(priv, fd);
+		if (priv->psr_dynfield_offset & DPAA2_PSR_DYNFIELD_OFFSET_EN)
+			dpaa2_dev_rx_parse_offset(priv, bufs[num_rx], fd);
 
 		dpaa2_dev_rx_print_parser_result(priv, fd, bufs[num_rx]);
 
@@ -1158,10 +1243,14 @@ dpaa2_dev_rx_common(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts,
 
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
index 83bee098bc..128adf3d1d 100644
--- a/drivers/net/dpaa2/rte_pmd_dpaa2.h
+++ b/drivers/net/dpaa2/rte_pmd_dpaa2.h
@@ -144,6 +144,10 @@ rte_pmd_dpaa2_dev_is_dpaa2(uint32_t eth_id);
 __rte_experimental
 const char *
 rte_pmd_dpaa2_ep_name(uint32_t eth_id);
+__rte_experimental
+int
+rte_pmd_dpaa2_rx_get_offset(uint16_t port_id, struct rte_mbuf *m,
+	uint8_t *l3_off, uint8_t *l4_off, uint8_t *l5_off);
 
 #if defined(RTE_LIBRTE_IEEE1588)
 __rte_experimental
-- 
2.43.0

