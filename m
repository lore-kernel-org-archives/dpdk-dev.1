Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714A6606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:45:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9CD8340E30;
	Fri, 23 Oct 2026 15:44:18 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id A95DC40299
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:10 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 89A2F1A0038;
 Fri, 23 Oct 2026 15:44:10 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 29C001A000A;
 Fri, 23 Oct 2026 15:44:10 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id F314C18000B5;
 Fri, 23 Oct 2026 21:44:08 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Breeson Francis <breeson.francis@nokia.com>,
	Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 17/65] net/dpaa2: rework xstats with page table and MAC
 support
Date: Fri, 23 Oct 2026 19:12:57 +0530
Message-ID: <20261023134346.37727-18-prashant.gupta_3@nxp.com>
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

From: Breeson Francis <breeson.francis@nokia.com>

Reshape DPAA2 xstats so that counter identity is derived from the DPNI
statistics page layout itself instead of a hand-maintained parallel
table, extend coverage to all DPNI pages (0..6, including CEETM and
tx-pending), expose per-MAC counters when the endpoint is a DPMAC on
MC firmware that supports it, and make xstats_get_by_id() actually
cheap when a caller asks for a subset of IDs.

Signed-off-by: Breeson Francis <breeson.francis@nokia.com>
Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 1004 +++++++++++++++++++-----------
 drivers/net/dpaa2/dpaa2_ethdev.h |   11 +-
 drivers/net/dpaa2/mc/fsl_dpni.h  |  116 ++--
 3 files changed, 708 insertions(+), 423 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 0fbc2c77b0..e7ac6b7dad 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -169,116 +169,290 @@ dpaa2_dist_size_is_supported(uint16_t n)
 int dpaa2_valid_dev;
 struct rte_mempool *dpaa2_tx_sg_pool;
 
-struct rte_dpaa2_xstats_name_off {
+struct dpaa2_dpni_xstats_pg_seq {
+	struct dpni_statistics_page_0 pg0;
+	struct dpni_statistics_page_1 pg1;
+	struct dpni_statistics_page_2 pg2;
+	struct dpni_statistics_page_3 pg3;
+	struct dpni_statistics_page_4 pg4;
+	struct dpni_statistics_page_5 pg5[MAX_TCS];
+	struct dpni_statistics_page_6 pg6;
+};
+
+#define DPAA2_DPNI_XSTAT_MAX_NUM \
+	(sizeof(struct dpaa2_dpni_xstats_pg_seq) / sizeof(uint64_t))
+
+struct dpaa2_dpni_xstats_pg {
+	uint64_t page_offset;
+	enum dpni_statistics_page_id page_id;
+	uint16_t param;
+	uint16_t size;
+};
+
+static const struct dpaa2_dpni_xstats_pg s_dpaa2_dpni_xstats_pgs[] = {
+	{
+		offsetof(struct dpaa2_dpni_xstats_pg_seq, pg0),
+		DPNI_INGRESS_STATISTICS_PAGE_ID, 0,
+		sizeof(struct dpni_statistics_page_0)
+	},
+	{
+		offsetof(struct dpaa2_dpni_xstats_pg_seq, pg1),
+		DPNI_EGRESS_STATISTICS_PAGE_ID, 0,
+		sizeof(struct dpni_statistics_page_1)
+	},
+	{
+		offsetof(struct dpaa2_dpni_xstats_pg_seq, pg2),
+		DPNI_ERR_STATISTICS_PAGE_ID, 0,
+		sizeof(struct dpni_statistics_page_2)
+	},
+	{
+		offsetof(struct dpaa2_dpni_xstats_pg_seq, pg3),
+		DPNI_CEETM_STATISTICS_PAGE_ID, 0,
+		sizeof(struct dpni_statistics_page_3)
+	},
+	{
+		offsetof(struct dpaa2_dpni_xstats_pg_seq, pg4),
+		DPNI_CGR_STATISTICS_PAGE_ID, 0,
+		sizeof(struct dpni_statistics_page_4)
+	},
+	{
+		offsetof(struct dpaa2_dpni_xstats_pg_seq, pg5[0]),
+		DPNI_POLICER_STATISTICS_PAGE_ID, 0,
+		sizeof(struct dpni_statistics_page_5)
+	},
+	{
+		offsetof(struct dpaa2_dpni_xstats_pg_seq, pg5[1]),
+		DPNI_POLICER_STATISTICS_PAGE_ID, 1,
+		sizeof(struct dpni_statistics_page_5)
+	},
+	{
+		offsetof(struct dpaa2_dpni_xstats_pg_seq, pg5[2]),
+		DPNI_POLICER_STATISTICS_PAGE_ID, 2,
+		sizeof(struct dpni_statistics_page_5)
+	},
+	{
+		offsetof(struct dpaa2_dpni_xstats_pg_seq, pg5[3]),
+		DPNI_POLICER_STATISTICS_PAGE_ID, 3,
+		sizeof(struct dpni_statistics_page_5)
+	},
+	{
+		offsetof(struct dpaa2_dpni_xstats_pg_seq, pg5[4]),
+		DPNI_POLICER_STATISTICS_PAGE_ID, 4,
+		sizeof(struct dpni_statistics_page_5)
+	},
+	{
+		offsetof(struct dpaa2_dpni_xstats_pg_seq, pg5[5]),
+		DPNI_POLICER_STATISTICS_PAGE_ID, 5,
+		sizeof(struct dpni_statistics_page_5)
+	},
+	{
+		offsetof(struct dpaa2_dpni_xstats_pg_seq, pg5[6]),
+		DPNI_POLICER_STATISTICS_PAGE_ID, 6,
+		sizeof(struct dpni_statistics_page_5)
+	},
+	{
+		offsetof(struct dpaa2_dpni_xstats_pg_seq, pg5[7]),
+		DPNI_POLICER_STATISTICS_PAGE_ID, 7,
+		sizeof(struct dpni_statistics_page_5)
+	},
+	{
+		offsetof(struct dpaa2_dpni_xstats_pg_seq, pg6),
+		DPNI_TX_PENDING_STATISTICS_PAGE_ID, 0,
+		sizeof(struct dpni_statistics_page_6)
+	},
+	{
+		sizeof(struct dpaa2_dpni_xstats_pg_seq),
+		0, 0, 0
+	}
+};
+
+static inline int
+dpaa2_xstats_id_parse(uint32_t id, uint8_t *page,
+	uint8_t *stat_id, uint16_t *param, uint16_t *size)
+{
+	int found = 0;
+	uint8_t _page = 0, _stat_id = 0;
+	uint16_t _param = 0, _size = 0;
+	uint64_t offset = id * sizeof(uint64_t), page_offset = 0, i;
+
+	for (i = 1; i < RTE_DIM(s_dpaa2_dpni_xstats_pgs); i++) {
+		if (offset < s_dpaa2_dpni_xstats_pgs[i].page_offset) {
+			page_offset = s_dpaa2_dpni_xstats_pgs[i - 1].page_offset;
+			_page = s_dpaa2_dpni_xstats_pgs[i - 1].page_id;
+			_stat_id = (offset - page_offset) / sizeof(uint64_t);
+			_param = s_dpaa2_dpni_xstats_pgs[i - 1].param;
+			_size = s_dpaa2_dpni_xstats_pgs[i - 1].size / sizeof(uint64_t);
+			found = 1;
+			break;
+		}
+	}
+
+	if (!found)
+		return -EINVAL;
+
+	if (page)
+		*page = _page;
+	if (stat_id)
+		*stat_id = _stat_id;
+	if (param)
+		*param = _param;
+	if (size)
+		*size = _size;
+
+	return 0;
+}
+
+struct dpaa2_stats_name_off {
 	char name[RTE_ETH_XSTATS_NAME_SIZE];
-	uint8_t page_id; /* dpni statistics page id */
-	uint8_t stats_id; /* stats id in the given page */
+	uint64_t offset;
+};
+
+#define DPAA2_STATS_IPACKETS_STR "ingress_all_frames"
+#define DPAA2_STATS_OPACKETS_STR "egress_all_frames"
+#define DPAA2_STATS_IBYTES_STR "ingress_all_bytes"
+#define DPAA2_STATS_OBYTES_STR "egress_all_bytes"
+#define DPAA2_STATS_IERRORS_STR "ingress_discarded_frames"
+#define DPAA2_STATS_OERRORS_STR "egress_discarded_frames"
+#define DPAA2_STATS_RX_NOMBUF_STR "ingress_nobuffer_discards"
+#define DPAA2_STATS_FILTERED_STR "ingress_filtered_frames"
+
+static const struct dpaa2_stats_name_off dpaa2_stats_strings[] = {
+	{
+		DPAA2_STATS_IPACKETS_STR,
+		offsetof(struct rte_eth_stats, ipackets)
+	},
+	{
+		DPAA2_STATS_OPACKETS_STR,
+		offsetof(struct rte_eth_stats, opackets)
+	},
+	{
+		DPAA2_STATS_IBYTES_STR,
+		offsetof(struct rte_eth_stats, ibytes)
+	},
+	{
+		DPAA2_STATS_OBYTES_STR,
+		offsetof(struct rte_eth_stats, obytes)
+	},
+	{
+		DPAA2_STATS_FILTERED_STR,
+		sizeof(struct rte_eth_stats)
+	},
+	{
+		DPAA2_STATS_IERRORS_STR,
+		offsetof(struct rte_eth_stats, ierrors)
+	},
+	{
+		DPAA2_STATS_OERRORS_STR,
+		offsetof(struct rte_eth_stats, oerrors)
+	},
+	{
+		DPAA2_STATS_RX_NOMBUF_STR,
+		offsetof(struct rte_eth_stats, rx_nombuf)
+	}
 };
 
-static const struct rte_dpaa2_xstats_name_off dpaa2_xstats_strings[] = {
-	{"ingress_multicast_frames", 0, 2},
-	{"ingress_multicast_bytes", 0, 3},
-	{"ingress_broadcast_frames", 0, 4},
-	{"ingress_broadcast_bytes", 0, 5},
-	{"egress_multicast_frames", 1, 2},
-	{"egress_multicast_bytes", 1, 3},
-	{"egress_broadcast_frames", 1, 4},
-	{"egress_broadcast_bytes", 1, 5},
-	{"ingress_filtered_frames", 2, 0},
-	{"ingress_discarded_frames", 2, 1},
-	{"ingress_nobuffer_discards", 2, 2},
-	{"egress_discarded_frames", 2, 3},
-	{"egress_confirmed_frames", 2, 4},
-	{"cgr_reject_frames", 4, 0},
-	{"cgr_reject_bytes", 4, 1},
-	{"TC_0_policer_cnt_red", 5, 0},
-	{"TC_0_policer_cnt_yellow", 5, 1},
-	{"TC_0_policer_cnt_green", 5, 2},
-	{"TC_0_policer_cnt_re_red", 5, 3},
-	{"TC_0_policer_cnt_re_yellow", 5, 4},
-	{"TC_1_policer_cnt_red", 6, 0},
-	{"TC_1_policer_cnt_yellow", 6, 1},
-	{"TC_1_policer_cnt_green", 6, 2},
-	{"TC_1_policer_cnt_re_red", 6, 3},
-	{"TC_1_policer_cnt_re_yellow", 6, 4},
-	{"TC_2_policer_cnt_red", 7, 0},
-	{"TC_2_policer_cnt_yellow", 7, 1},
-	{"TC_2_policer_cnt_green", 7, 2},
-	{"TC_2_policer_cnt_re_red", 7, 3},
-	{"TC_2_policer_cnt_re_yellow", 7, 4},
-	{"TC_3_policer_cnt_red", 8, 0},
-	{"TC_3_policer_cnt_yellow", 8, 1},
-	{"TC_3_policer_cnt_green", 8, 2},
-	{"TC_3_policer_cnt_re_red", 8, 3},
-	{"TC_3_policer_cnt_re_yellow", 8, 4},
-	{"TC_4_policer_cnt_red", 9, 0},
-	{"TC_4_policer_cnt_yellow", 9, 1},
-	{"TC_4_policer_cnt_green", 9, 2},
-	{"TC_4_policer_cnt_re_red", 9, 3},
-	{"TC_4_policer_cnt_re_yellow", 9, 4},
-	{"TC_5_policer_cnt_red", 10, 0},
-	{"TC_5_policer_cnt_yellow", 10, 1},
-	{"TC_5_policer_cnt_green", 10, 2},
-	{"TC_5_policer_cnt_re_red", 10, 3},
-	{"TC_5_policer_cnt_re_yellow", 10, 4},
-	{"TC_6_policer_cnt_red", 11, 0},
-	{"TC_6_policer_cnt_yellow", 11, 1},
-	{"TC_6_policer_cnt_green", 11, 2},
-	{"TC_6_policer_cnt_re_red", 11, 3},
-	{"TC_6_policer_cnt_re_yellow", 11, 4},
-	{"TC_7_policer_cnt_red", 12, 0},
-	{"TC_7_policer_cnt_yellow", 12, 1},
-	{"TC_7_policer_cnt_green", 12, 2},
-	{"TC_7_policer_cnt_re_red", 12, 3},
-	{"TC_7_policer_cnt_re_yellow", 12, 4},
-	{"mac_rx_64 bytes", 0, 0},
-	{"mac_rx_65-127 bytes", 0, 0},
-	{"mac_rx_128-255 bytes", 0, 0},
-	{"mac_rx_256-511 bytes", 0, 0},
-	{"mac_rx_512-1023 bytes", 0, 0},
-	{"mac_rx_1024-1518 bytes", 0, 0},
-	{"mac_rx_1519-max bytes", 0, 0},
-	{"mac_rx_frags", 0, 0},
-	{"mac_rx_jabber", 0, 0},
-	{"mac_rx_frame discards", 0, 0},
-	{"mac_rx_align errors", 0, 0},
-	{"mac_tx_undersized", 0, 0},
-	{"mac_rx_oversized", 0, 0},
-	{"mac_rx_pause", 0, 0},
-	{"mac_tx_b-pause", 0, 0},
-	{"mac_rx_bytes", 0, 0},
-	{"mac_rx_m-cast", 0, 0},
-	{"mac_rx_b-cast", 0, 0},
-	{"mac_rx_all frames", 0, 0},
-	{"mac_rx_u-cast", 0, 0},
-	{"mac_rx_frame errors", 0, 0},
-	{"mac_tx_bytes", 0, 0},
-	{"mac_tx_m-cast", 0, 0},
-	{"mac_tx_b-cast", 0, 0},
-	{"mac_tx_u-cast", 0, 0},
-	{"mac_tx_frame errors", 0, 0},
-	{"mac_rx_frames ok", 0, 0},
-	{"mac_tx_frames ok", 0, 0},
-	{"mac_tx_64 bytes", 0, 0},
-	{"mac_tx_65-127 bytes", 0, 0},
-	{"mac_tx_128-255 bytes", 0, 0},
-	{"mac_tx_256-511 bytes", 0, 0},
-	{"mac_tx_512-1023 bytes", 0, 0},
-	{"mac_tx_1024-1518 bytes", 0, 0},
-	{"mac_tx_1519-max bytes", 0, 0},
-	{"mac_rx_all_bytes", 0, 0},
-	{"mac_rx_fcs_err", 0, 0},
-	{"mac_rx_vlan_frame", 0, 0},
-	{"mac_rx_undersized", 0, 0},
-	{"mac_rx_control_frame", 0, 0},
-	{"mac_rx_frame_discard_not_trunc", 0, 0},
-	{"mac_tx_all_bytes", 0, 0},
-	{"mac_tx_fcs_err", 0, 0},
-	{"mac_tx_vlan_frame", 0, 0},
-	{"mac_tx_all_frame", 0, 0},
-	{"mac_tx_control_frame", 0, 0},
+#define DPAA2_STATS_SET_BY_OFFSET(p_stats, offset, val) \
+	(*((uint64_t *)((uint8_t *)(p_stats) + (offset))) = (val))
+
+#define DPAA2_TC_COLOR(tc) \
+	"TC_"#tc"_policer_cnt_red", \
+	"TC_"#tc"_policer_cnt_yellow", \
+	"TC_"#tc"_policer_cnt_green", \
+	"TC_"#tc"_policer_cnt_re_red", \
+	"TC_"#tc"_policer_cnt_re_yellow" \
+
+static const char * const dpaa2_dpni_xstats_strings[] = {
+	DPAA2_STATS_IPACKETS_STR,
+	DPAA2_STATS_IBYTES_STR,
+	"ingress_multicast_frames",
+	"ingress_multicast_bytes",
+	"ingress_broadcast_frames",
+	"ingress_broadcast_bytes",
+
+	DPAA2_STATS_OPACKETS_STR,
+	DPAA2_STATS_OBYTES_STR,
+	"egress_multicast_frames",
+	"egress_multicast_bytes",
+	"egress_broadcast_frames",
+	"egress_broadcast_bytes",
+
+	DPAA2_STATS_FILTERED_STR,
+	DPAA2_STATS_IERRORS_STR,
+	DPAA2_STATS_RX_NOMBUF_STR,
+	DPAA2_STATS_OERRORS_STR,
+	"egress_confirmed_frames",
+
+	"cgr_reject_frames",
+	"cgr_reject_bytes",
+
+	"ceetm_dequeue_bytes",
+	"ceetm_dequeue_frames",
+	"ceetm_reject_bytes",
+	"ceetm_reject_frames",
+	DPAA2_TC_COLOR(0),
+	DPAA2_TC_COLOR(1),
+	DPAA2_TC_COLOR(2),
+	DPAA2_TC_COLOR(3),
+	DPAA2_TC_COLOR(4),
+	DPAA2_TC_COLOR(5),
+	DPAA2_TC_COLOR(6),
+	DPAA2_TC_COLOR(7),
+
+	"tx_pending_frames_cnt"
 };
 
+static const char * const dpaa2_mac_xstats_strings[] = {
+	"mac_rx_64 bytes",
+	"mac_rx_65-127 bytes",
+	"mac_rx_128-255 bytes",
+	"mac_rx_256-511 bytes",
+	"mac_rx_512-1023 bytes",
+	"mac_rx_1024-1518 bytes",
+	"mac_rx_1519-max bytes",
+	"mac_rx_frags",
+	"mac_rx_jabber",
+	"mac_rx_frame discards",
+	"mac_rx_align errors",
+	"mac_tx_undersized",
+	"mac_rx_oversized",
+	"mac_rx_pause",
+	"mac_tx_b-pause",
+	"mac_rx_bytes",
+	"mac_rx_m-cast",
+	"mac_rx_b-cast",
+	"mac_rx_all frames",
+	"mac_rx_u-cast",
+	"mac_rx_frame errors",
+	"mac_tx_bytes",
+	"mac_tx_m-cast",
+	"mac_tx_b-cast",
+	"mac_tx_u-cast",
+	"mac_tx_frame errors",
+	"mac_rx_frames ok",
+	"mac_tx_frames ok",
+	"mac_tx_64 bytes",
+	"mac_tx_65-127 bytes",
+	"mac_tx_128-255 bytes",
+	"mac_tx_256-511 bytes",
+	"mac_tx_512-1023 bytes",
+	"mac_tx_1024-1518 bytes",
+	"mac_tx_1519-max bytes",
+	"mac_rx_all_bytes",
+	"mac_rx_fcs_err",
+	"mac_rx_vlan_frame",
+	"mac_rx_undersized",
+	"mac_rx_control_frame",
+	"mac_rx_frame_discard_not_trunc",
+	"mac_tx_all_bytes",
+	"mac_tx_fcs_err",
+	"mac_tx_vlan_frame",
+	"mac_tx_all_frame",
+	"mac_tx_control_frame"
+};
+
+#define DPAA2_MAC_XSTATS_START_ID \
+	(sizeof(struct dpaa2_dpni_xstats_pg_seq) / sizeof(uint64_t))
+
 static struct rte_dpaa2_driver rte_dpaa2_pmd;
 static int dpaa2_dev_link_update(struct rte_eth_dev *dev,
 				 int wait_to_complete);
@@ -1958,132 +2132,97 @@ dpaa2_dev_set_mac_addr(struct rte_eth_dev *dev,
 }
 
 static int
-dpaa2_dev_stats_get(struct rte_eth_dev *dev,
-	struct rte_eth_stats *stats, struct eth_queue_stats *qstats)
+dpaa2_dev_xstat_mac_setup_mem(struct rte_eth_dev *dev)
 {
 	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	struct fsl_mc_io *dpni = dev->process_private;
-	int32_t retcode;
-	uint8_t page0 = 0, page1 = 1, page2 = 2;
-	union dpni_statistics value;
-	int i;
-	struct dpaa2_queue *dpaa2_rxq, *dpaa2_txq;
-
-	memset(&value, 0, sizeof(union dpni_statistics));
-
-	PMD_INIT_FUNC_TRACE();
+	uint32_t *cnt_idx, i;
+	int ret = 0;
 
-	if (!dpni) {
-		DPAA2_PMD_ERR("dpni is NULL");
-		return -EINVAL;
-	}
+	if (!priv->cnt_idx_dma_mem) {
+		priv->cnt_idx_dma_mem = rte_zmalloc(NULL,
+			DPAA2_MAC_STATS_INDEX_DMA_SIZE, RTE_CACHE_LINE_SIZE);
+		if (!priv->cnt_idx_dma_mem) {
+			ret = -ENOMEM;
+			DPAA2_PMD_ERR("Failure to allocate memory for mac index");
+			goto out;
+		}
 
-	if (!stats) {
-		DPAA2_PMD_ERR("stats is NULL");
-		return -EINVAL;
+		priv->cnt_idx_iova = rte_mem_virt2iova(priv->cnt_idx_dma_mem);
+		if (priv->cnt_idx_iova == RTE_BAD_IOVA) {
+			ret = -ENOBUFS;
+			DPAA2_PMD_ERR("%s: No IOMMU map for count index dma mem(%p)",
+				__func__, priv->cnt_idx_dma_mem);
+			goto err_dma_map;
+		}
+		cnt_idx = priv->cnt_idx_dma_mem;
+		for (i = 0; i < DPAA2_MAC_NUM_STATS; i++)
+			cnt_idx[i] = rte_cpu_to_le_32(i);
 	}
 
-	/*Get Counters from page_0*/
-	retcode = dpni_get_statistics(dpni, CMD_PRI_LOW, priv->token,
-				      page0, 0, &value);
-	if (retcode)
-		goto err;
-
-	stats->ipackets = value.page_0.ingress_all_frames;
-	stats->ibytes = value.page_0.ingress_all_bytes;
-
-	/*Get Counters from page_1*/
-	retcode = dpni_get_statistics(dpni, CMD_PRI_LOW, priv->token,
-				      page1, 0, &value);
-	if (retcode)
-		goto err;
-
-	stats->opackets = value.page_1.egress_all_frames;
-	stats->obytes = value.page_1.egress_all_bytes;
-
-	/*Get Counters from page_2*/
-	retcode = dpni_get_statistics(dpni, CMD_PRI_LOW, priv->token,
-				      page2, 0, &value);
-	if (retcode)
-		goto err;
-
-	/* Ingress drop frame count due to configured rules */
-	stats->ierrors = value.page_2.ingress_filtered_frames;
-	/* Ingress drop frame count due to error */
-	stats->ierrors += value.page_2.ingress_discarded_frames;
-
-	stats->oerrors = value.page_2.egress_discarded_frames;
-	stats->imissed = value.page_2.ingress_nobuffer_discards;
-
-	/* Fill in per queue stats. Byte counting is not implemented. */
-	if (qstats != NULL) {
-		for (i = 0; i < dev->data->nb_rx_queues; ++i) {
-			dpaa2_rxq = priv->rx_vq[i];
-			if (dpaa2_rxq)
-				qstats[i].q_ipackets = dpaa2_rxq->rx_pkts;
+	if (!priv->cnt_values_dma_mem) {
+		priv->cnt_values_dma_mem = rte_zmalloc(NULL,
+			DPAA2_MAC_STATS_VALUE_DMA_SIZE, RTE_CACHE_LINE_SIZE);
+		if (!priv->cnt_values_dma_mem) {
+			ret = -ENOMEM;
+			DPAA2_PMD_ERR("Failure to allocate memory for mac values");
+			goto err_alloc_values;
 		}
-		for (i = 0; i < dev->data->nb_tx_queues; ++i) {
-			dpaa2_txq = priv->tx_vq[i];
-			if (dpaa2_txq)
-				qstats[i].q_opackets = dpaa2_txq->tx_pkts;
+		priv->cnt_values_iova = rte_mem_virt2iova(priv->cnt_values_dma_mem);
+		if (priv->cnt_values_iova == RTE_BAD_IOVA) {
+			ret = -ENOBUFS;
+			DPAA2_PMD_ERR("%s: No IOMMU map for count values dma mem(%p)",
+				__func__, priv->cnt_values_dma_mem);
+			goto err_dma_map;
 		}
 	}
 
 	return 0;
 
-err:
-	DPAA2_PMD_ERR("Operation not completed:Error Code = %d", retcode);
-	return retcode;
-};
+err_dma_map:
+	rte_free(priv->cnt_values_dma_mem);
+err_alloc_values:
+	rte_free(priv->cnt_idx_dma_mem);
+out:
+	priv->cnt_idx_dma_mem = NULL;
+	priv->cnt_values_dma_mem = NULL;
 
-void
-dpaa2_dev_mac_setup_stats(struct rte_eth_dev *dev)
+	return ret;
+}
+
+static int
+dpaa2_dev_mac_xstats_avail(struct rte_eth_dev *dev)
 {
 	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	uint32_t *cnt_idx;
-	int i;
-
-	priv->cnt_idx_dma_mem = rte_malloc(NULL, DPAA2_MAC_STATS_INDEX_DMA_SIZE,
-					   RTE_CACHE_LINE_SIZE);
-	if (!priv->cnt_idx_dma_mem) {
-		DPAA2_PMD_ERR("Failure to allocate memory for mac index");
-		goto out;
-	}
 
-	priv->cnt_values_dma_mem = rte_malloc(NULL, DPAA2_MAC_STATS_VALUE_DMA_SIZE,
-					      RTE_CACHE_LINE_SIZE);
-	if (!priv->cnt_values_dma_mem) {
-		DPAA2_PMD_ERR("Failure to allocate memory for mac values");
-		goto err_alloc_values;
-	}
+	if (priv->ep_dev_type != DPAA2_MAC)
+		return false;
+	if (priv->mc_rev < DPAA2_MAC_XSTATS_MC_REV)
+		return false;
 
-	cnt_idx = priv->cnt_idx_dma_mem;
-	for (i = 0; i < DPAA2_MAC_NUM_STATS; i++)
-		*cnt_idx++ = rte_cpu_to_le_32((uint32_t)i);
+	return true;
+}
 
-	priv->cnt_idx_iova = rte_mem_virt2iova(priv->cnt_idx_dma_mem);
-	if (priv->cnt_idx_iova == RTE_BAD_IOVA) {
-		DPAA2_PMD_ERR("%s: No IOMMU map for count index dma mem(%p)",
-			__func__, priv->cnt_idx_dma_mem);
-		goto err_dma_map;
-	}
+static int
+dpaa2_dev_dpni_xstats_avail(struct rte_eth_dev *dev,
+	uint8_t page_id, uint16_t param)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	uint8_t tc, i;
 
-	priv->cnt_values_iova = rte_mem_virt2iova(priv->cnt_values_dma_mem);
-	if (priv->cnt_values_iova == RTE_BAD_IOVA) {
-		DPAA2_PMD_ERR("%s: No IOMMU map for count values dma mem(%p)",
-			__func__, priv->cnt_values_dma_mem);
-		goto err_dma_map;
+	if (page_id == DPNI_CGR_STATISTICS_PAGE_ID) {
+		for (i = 0; i < priv->max_cgs; i++) {
+			if (priv->cgid_in_use[i])
+				return true;
+		}
+	} else if (page_id == DPNI_POLICER_STATISTICS_PAGE_ID) {
+		tc = param;
+		if (tc < MAX_TCS)
+			return true;
+	} else {
+		return true;
 	}
 
-	return;
-
-err_dma_map:
-	rte_free(priv->cnt_values_dma_mem);
-err_alloc_values:
-	rte_free(priv->cnt_idx_dma_mem);
-out:
-	priv->cnt_idx_dma_mem = NULL;
-	priv->cnt_values_dma_mem = NULL;
+	return false;
 }
 
 /*
@@ -2093,213 +2232,343 @@ dpaa2_dev_mac_setup_stats(struct rte_eth_dev *dev)
  */
 static int
 dpaa2_dev_xstats_get(struct rte_eth_dev *dev,
-	struct rte_eth_xstat *xstats, unsigned int n)
+	struct rte_eth_xstat *xstats, uint32_t n)
 {
-	struct fsl_mc_io *dpni = (struct fsl_mc_io *)dev->process_private;
-	unsigned int i = 0, j = 0, num = RTE_DIM(dpaa2_xstats_strings);
+	struct fsl_mc_io *dpni = dev->process_private;
+	uint16_t i, j, param, stat_cnt, size;
 	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	union dpni_statistics value[13] = {};
-	struct dpni_rx_tc_policing_cfg cfg;
-	uint8_t page_id, stats_id;
+	union dpni_statistics values;
+	uint8_t page_id, stat_id;
 	uint64_t *cnt_values;
-	int32_t retcode;
-	int16_t tc;
+	int retcode;
+
+	stat_cnt = DPAA2_DPNI_XSTAT_MAX_NUM;
+	if (priv->ep_dev_type == DPAA2_MAC)
+		stat_cnt += DPAA2_MAC_NUM_STATS;
 
-	if (n < num)
-		return num;
+	if (n > stat_cnt) {
+		DPAA2_PMD_ERR("%s: Expected number(%d) > max number(%d)",
+			__func__, n, stat_cnt);
+		return -EINVAL;
+	}
 
 	if (!xstats)
 		return 0;
 
-	/* Get Counters from page_0*/
-	retcode = dpni_get_statistics(dpni, CMD_PRI_LOW, priv->token,
-				      0, 0, &value[0]);
-	if (retcode)
-		goto err;
-
-	/* Get Counters from page_1*/
-	retcode = dpni_get_statistics(dpni, CMD_PRI_LOW, priv->token,
-				      1, 0, &value[1]);
-	if (retcode)
-		goto err;
-
-	/* Get Counters from page_2*/
-	retcode = dpni_get_statistics(dpni, CMD_PRI_LOW, priv->token,
-				      2, 0, &value[2]);
-	if (retcode)
-		goto err;
-
-	for (j = 0; j < priv->max_cgs; j++) {
-		if (!priv->cgid_in_use[j]) {
-			/* Get Counters from page_4*/
-			retcode = dpni_get_statistics(dpni, CMD_PRI_LOW,
-						      priv->token,
-						      4, 0, &value[4]);
-			if (retcode)
-				goto err;
-			break;
+	i = 0;
+	while (i < n) {
+		if (i >= DPAA2_MAC_XSTATS_START_ID) {
+			if (!dpaa2_dev_mac_xstats_avail(dev)) {
+				for (j = i; j < n; j++) {
+					xstats[j].id = j;
+					xstats[j].value = 0;
+				}
+				i = n;
+				break;
+			}
+			goto dpmac_get_xstat;
 		}
-	}
 
-	for (tc = 0; tc < priv->num_rx_tc; tc++) {
-		retcode = dpni_get_rx_tc_policing(dpni, CMD_PRI_LOW,
-						  priv->token, tc,
-						  &cfg);
+		page_id = 0;
+		stat_id = 0;
+		param = 0;
+		retcode = dpaa2_xstats_id_parse(i, &page_id, &stat_id, &param, &size);
+		if (retcode)
+			return retcode;
+		if (!dpaa2_dev_dpni_xstats_avail(dev, page_id, param)) {
+			xstats[i].id = i;
+			xstats[i].value = 0;
+			i++;
+			continue;
+		}
+		retcode = dpni_get_statistics(dpni, CMD_PRI_LOW,
+			priv->token, page_id, param, &values);
 		if (retcode) {
-			DPAA2_PMD_ERR("Error to get the policer rule: %d", retcode);
-			goto err;
+			DPAA2_PMD_ERR("%s: Failed(%d) to get %s's statistcis of page%d!",
+				__func__, retcode, dev->data->name, page_id);
+			return retcode;
 		}
-
-		/* get policer stats if policer is enabled */
-		if (cfg.mode != 0) {
-			/* Get Counters from page_5*/
-			retcode = dpni_get_statistics(dpni, CMD_PRI_LOW,
-						      priv->token, 5, tc,
-						      &value[(tc + 5)]);
-			if (retcode)
-				goto err;
+		cnt_values = (void *)&values;
+		j = stat_id;
+		while (i < n && j < size) {
+			xstats[i].id = i;
+			xstats[i].value = cnt_values[j];
+			i++;
+			j++;
 		}
-	}
+		continue;
 
-	while (i < (num - DPAA2_MAC_NUM_STATS)) {
-		xstats[i].id = i;
-		page_id = dpaa2_xstats_strings[i].page_id;
-		stats_id = dpaa2_xstats_strings[i].stats_id;
-		xstats[i].value = value[page_id].raw.counter[stats_id];
-		i++;
-	}
-
-	if (priv->cnt_idx_dma_mem &&
-	    !dpni_get_mac_statistics(dpni, CMD_PRI_LOW, priv->token,
-				    priv->cnt_idx_iova,
-				    priv->cnt_values_iova,
-				    DPAA2_MAC_NUM_STATS)) {
+dpmac_get_xstat:
+		retcode = dpaa2_dev_xstat_mac_setup_mem(dev);
+		if (retcode) {
+			DPAA2_PMD_ERR("%s: Failed(%d) to setup %s MAC statistics!",
+				__func__, retcode, dev->data->name);
+			return retcode;
+		}
+		retcode = dpni_get_mac_statistics(dpni, CMD_PRI_LOW,
+			priv->token, priv->cnt_idx_iova,
+			priv->cnt_values_iova, DPAA2_MAC_NUM_STATS);
+		if (retcode) {
+			DPAA2_PMD_ERR("%s: Failed(%d) to get %s's MAC statistics!",
+				__func__, retcode, dev->data->name);
+			return retcode;
+		}
 		cnt_values = priv->cnt_values_dma_mem;
-		while (i >= (num - DPAA2_MAC_NUM_STATS) && i < num) {
+
+		j = i - DPAA2_MAC_XSTATS_START_ID;
+		while (i < n && j < DPAA2_MAC_NUM_STATS) {
 			xstats[i].id = i;
-			xstats[i].value = rte_le_to_cpu_64(*cnt_values++);
+			xstats[i].value = cnt_values[j];
 			i++;
+			j++;
 		}
-		return i;
-	}
-
-	while (i >= (num - DPAA2_MAC_NUM_STATS) && i < num) {
-		xstats[i].id = i;
-		xstats[i].value = 0;
-		i++;
 	}
 
 	return i;
-err:
-	DPAA2_PMD_ERR("Error in obtaining extended stats (%d)", retcode);
-	return retcode;
 }
 
 static int
-dpaa2_xstats_get_names(__rte_unused struct rte_eth_dev *dev,
-	struct rte_eth_xstat_name *xstats_names,
-	unsigned int limit)
+dpaa2_dev_xstats_get_names(struct rte_eth_dev *dev,
+	struct rte_eth_xstat_name *xstats_names, uint32_t limit)
 {
-	unsigned int i, stat_cnt = RTE_DIM(dpaa2_xstats_strings);
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	uint16_t i, stat_cnt;
+
+	stat_cnt = DPAA2_DPNI_XSTAT_MAX_NUM;
+	if (priv->ep_dev_type == DPAA2_MAC)
+		stat_cnt += DPAA2_MAC_NUM_STATS;
+
+	if (!limit)
+		return stat_cnt;
 
 	if (limit < stat_cnt)
+		stat_cnt = limit;
+
+	if (!xstats_names)
 		return stat_cnt;
 
-	if (xstats_names != NULL)
-		for (i = 0; i < stat_cnt; i++)
-			strlcpy(xstats_names[i].name,
-				dpaa2_xstats_strings[i].name,
-				sizeof(xstats_names[i].name));
+	for (i = 0; i < stat_cnt; i++) {
+		if (i < DPAA2_DPNI_XSTAT_MAX_NUM) {
+			rte_strscpy(xstats_names[i].name, dpaa2_dpni_xstats_strings[i],
+				RTE_ETH_XSTATS_NAME_SIZE);
+		} else {
+			rte_strscpy(xstats_names[i].name,
+				dpaa2_mac_xstats_strings[i - DPAA2_DPNI_XSTAT_MAX_NUM],
+				RTE_ETH_XSTATS_NAME_SIZE);
+		}
+	}
 
 	return stat_cnt;
 }
 
 static int
-dpaa2_xstats_get_by_id(struct rte_eth_dev *dev, const uint64_t *ids,
-	uint64_t *values, unsigned int n)
+dpaa2_dev_xstats_get_by_id(struct rte_eth_dev *dev, const uint64_t *ids,
+	uint64_t *values, uint32_t n)
 {
-	unsigned int i, stat_cnt = RTE_DIM(dpaa2_xstats_strings);
-	uint64_t values_copy[stat_cnt];
-	uint8_t page_id, stats_id;
-
-	if (!ids) {
-		struct dpaa2_dev_priv *priv = dev->data->dev_private;
-		struct fsl_mc_io *dpni = dev->process_private;
-		int32_t retcode;
-		union dpni_statistics value[5] = {};
+	uint16_t i, id, stat_cnt;
+	uint8_t page_id, stat_id;
+	uint16_t param;
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct fsl_mc_io *dpni = dev->process_private;
+	bool page_fetched[DPNI_MAX_STATISTICS_PAGE_ID][DPNI_STAT_MAX_PARAM];
+	/* Fetch all MAC counters in a single MC command on first MAC xstat. */
+	bool mac_fetched = false;
+	int retcode;
+	uint64_t *cnt_values;
 
-		if (n < stat_cnt)
-			return stat_cnt;
+	stat_cnt = DPAA2_DPNI_XSTAT_MAX_NUM;
+	if (priv->ep_dev_type == DPAA2_MAC)
+		stat_cnt += DPAA2_MAC_NUM_STATS;
 
-		if (!values)
-			return 0;
+	memset(page_fetched, 0, sizeof(page_fetched));
 
-		/* Get Counters from page_0*/
-		retcode = dpni_get_statistics(dpni, CMD_PRI_LOW, priv->token,
-					      0, 0, &value[0]);
+	for (i = 0; i < n; i++) {
+		if (ids && ids[i] >= stat_cnt) {
+			DPAA2_PMD_ERR("xstats id value isn't valid");
+			return -EINVAL;
+		}
+		id = ids ? ids[i] : i;
+		if (id >= DPAA2_MAC_XSTATS_START_ID) {
+			if (!dpaa2_dev_mac_xstats_avail(dev)) {
+				values[i] = 0;
+				continue;
+			}
+			if (mac_fetched) {
+				cnt_values = priv->cnt_values_dma_mem;
+				values[i] = cnt_values[id - DPAA2_MAC_XSTATS_START_ID];
+				continue;
+			}
+			goto dpmac_get_xstat;
+		}
+		page_id = 0;
+		stat_id = 0;
+		param = 0;
+		retcode = dpaa2_xstats_id_parse(id, &page_id, &stat_id, &param, NULL);
 		if (retcode)
-			return 0;
+			return retcode;
+		if (!dpaa2_dev_dpni_xstats_avail(dev, page_id, param)) {
+			values[i] = 0;
+			continue;
+		}
+		if (!page_fetched[page_id][param])
+			goto dpni_get_xstat;
+		values[i] = priv->pg_xstats[page_id][param].raw.counter[stat_id];
+		continue;
+
+dpmac_get_xstat:
+		/* Single MC call fetches all MAC counters at once;
+		 * reuse the result for every subsequent MAC xstat.
+		 */
+		retcode = dpaa2_dev_xstat_mac_setup_mem(dev);
+		if (retcode) {
+			DPAA2_PMD_ERR("%s: Failed(%d) to setup %s's MAC statistics!",
+				__func__, retcode, dev->data->name);
+			return retcode;
+		}
+		retcode = dpni_get_mac_statistics(dpni, CMD_PRI_LOW,
+			priv->token, priv->cnt_idx_iova,
+			priv->cnt_values_iova, DPAA2_MAC_NUM_STATS);
+		if (retcode) {
+			DPAA2_PMD_ERR("%s: Failed(%d) to get %s's MAC statistics!",
+				__func__, retcode, dev->data->name);
+			return retcode;
+		}
+		mac_fetched = true;
+		cnt_values = priv->cnt_values_dma_mem;
+		values[i] = cnt_values[id - DPAA2_MAC_XSTATS_START_ID];
+		continue;
 
-		/* Get Counters from page_1*/
-		retcode = dpni_get_statistics(dpni, CMD_PRI_LOW, priv->token,
-					      1, 0, &value[1]);
-		if (retcode)
-			return 0;
+dpni_get_xstat:
+		/* Cache dpni page results: multiple xstats can share
+		 * the same (page_id, param), so only fetch each pair once.
+		 */
+		retcode = dpni_get_statistics(dpni, CMD_PRI_LOW,
+				priv->token, page_id, param,
+				&priv->pg_xstats[page_id][param]);
+		if (retcode) {
+			DPAA2_PMD_ERR("%s: Failed(%d) to get %s's statistcis of page%d!",
+				__func__, retcode, dev->data->name, page_id);
+			return retcode;
+		}
+		page_fetched[page_id][param] = true;
+		values[i] = priv->pg_xstats[page_id][param].raw.counter[stat_id];
+	}
 
-		/* Get Counters from page_2*/
-		retcode = dpni_get_statistics(dpni, CMD_PRI_LOW, priv->token,
-					      2, 0, &value[2]);
-		if (retcode)
-			return 0;
+	return n;
+}
 
-		/* Get Counters from page_4*/
-		retcode = dpni_get_statistics(dpni, CMD_PRI_LOW, priv->token,
-					      4, 0, &value[4]);
-		if (retcode)
-			return 0;
+static int
+dpaa2_dev_xstats_get_names_by_id(struct rte_eth_dev *dev,
+	const uint64_t *ids, struct rte_eth_xstat_name *xstats_names,
+	uint32_t limit)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	uint16_t i, stat_cnt;
 
-		for (i = 0; i < stat_cnt; i++) {
-			page_id = dpaa2_xstats_strings[i].page_id;
-			stats_id = dpaa2_xstats_strings[i].stats_id;
-			values[i] = value[page_id].raw.counter[stats_id];
-		}
-		return stat_cnt;
-	}
+	stat_cnt = DPAA2_DPNI_XSTAT_MAX_NUM;
+	if (priv->ep_dev_type == DPAA2_MAC)
+		stat_cnt += DPAA2_MAC_NUM_STATS;
 
-	dpaa2_xstats_get_by_id(dev, NULL, values_copy, stat_cnt);
+	if (!ids)
+		return dpaa2_dev_xstats_get_names(dev, xstats_names, limit);
 
-	for (i = 0; i < n; i++) {
+	for (i = 0; i < limit; i++) {
 		if (ids[i] >= stat_cnt) {
-			DPAA2_PMD_ERR("xstats id value isn't valid");
+			DPAA2_PMD_ERR("xstats id[%d] value(%" PRIu64 ") >= max count(%d)",
+				i, ids[i], stat_cnt);
 			return -EINVAL;
 		}
-		values[i] = values_copy[ids[i]];
+		if (ids[i] < DPAA2_DPNI_XSTAT_MAX_NUM) {
+			rte_strscpy(xstats_names[i].name, dpaa2_dpni_xstats_strings[ids[i]],
+				RTE_ETH_XSTATS_NAME_SIZE);
+		} else {
+			rte_strscpy(xstats_names[i].name,
+				dpaa2_mac_xstats_strings[ids[i] - DPAA2_DPNI_XSTAT_MAX_NUM],
+				RTE_ETH_XSTATS_NAME_SIZE);
+		}
 	}
-	return n;
+	return limit;
 }
 
 static int
-dpaa2_xstats_get_names_by_id(struct rte_eth_dev *dev,
-	const uint64_t *ids,
-	struct rte_eth_xstat_name *xstats_names,
-	unsigned int limit)
+dpaa2_dev_stats_get(struct rte_eth_dev *dev,
+	struct rte_eth_stats *stats, struct eth_queue_stats *qstats)
 {
-	unsigned int i, stat_cnt = RTE_DIM(dpaa2_xstats_strings);
-	struct rte_eth_xstat_name xstats_names_copy[stat_cnt];
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	int32_t retcode;
+	uint16_t stats_len = RTE_DIM(dpaa2_stats_strings), i, j, xstats_len;
+	struct dpaa2_queue *dpaa2_q;
+	uint64_t ids[stats_len];
+	uint64_t counts[stats_len];
+	uint64_t ifiltered = 0;
+	const char **dpni_nms = (const char **)&dpaa2_dpni_xstats_strings;
 
-	if (!ids)
-		return dpaa2_xstats_get_names(dev, xstats_names, limit);
+	PMD_INIT_FUNC_TRACE();
 
-	dpaa2_xstats_get_names(dev, xstats_names_copy, limit);
+	xstats_len = DPAA2_DPNI_XSTAT_MAX_NUM;
+	if (priv->ep_dev_type == DPAA2_MAC)
+		xstats_len += DPAA2_MAC_NUM_STATS;
 
-	for (i = 0; i < limit; i++) {
-		if (ids[i] >= stat_cnt) {
-			DPAA2_PMD_ERR("xstats id value isn't valid");
-			return -1;
+	if (!stats) {
+		DPAA2_PMD_ERR("stats is NULL");
+		return -EINVAL;
+	}
+
+	memset(stats, 0, sizeof(struct rte_eth_stats));
+
+	for (i = 0; i < stats_len; i++) {
+		for (j = 0; j < xstats_len; j++) {
+			if (j < DPAA2_DPNI_XSTAT_MAX_NUM) {
+				retcode = strcmp(dpaa2_stats_strings[i].name, dpni_nms[j]);
+			} else {
+				retcode = strcmp(dpaa2_stats_strings[i].name,
+					dpaa2_mac_xstats_strings[j - DPAA2_DPNI_XSTAT_MAX_NUM]);
+			}
+			if (!retcode) {
+				ids[i] = j;
+				break;
+			}
+		}
+		if (j == xstats_len) {
+			DPAA2_PMD_ERR("%s: stat(%s) not found in xstat!",
+				__func__, dpaa2_stats_strings[i].name);
+			return -EINVAL;
 		}
-		strcpy(xstats_names[i].name, xstats_names_copy[ids[i]].name);
 	}
-	return limit;
+
+	retcode = dpaa2_dev_xstats_get_by_id(dev, ids, counts, stats_len);
+	if (retcode != stats_len) {
+		DPAA2_PMD_ERR("%s: Failed to get xstats (%d)counters by %d IDs",
+			__func__, retcode, stats_len);
+		if (retcode >= 0)
+			retcode = -EINVAL;
+		return retcode;
+	}
+
+	for (i = 0; i < stats_len; i++) {
+		if (dpaa2_stats_strings[i].offset < sizeof(struct rte_eth_stats)) {
+			DPAA2_STATS_SET_BY_OFFSET(stats,
+				dpaa2_stats_strings[i].offset, counts[i]);
+		} else {
+			ifiltered = counts[i];
+		}
+	}
+	stats->imissed = stats->ierrors + stats->rx_nombuf + ifiltered;
+
+	if (qstats) {
+		for (i = 0; i < dev->data->nb_rx_queues; i++) {
+			dpaa2_q = priv->rx_vq[i];
+			if (dpaa2_q)
+				qstats[i].q_ipackets = dpaa2_q->rx_pkts;
+		}
+		for (i = 0; i < dev->data->nb_tx_queues; i++) {
+			dpaa2_q = priv->tx_vq[i];
+			if (dpaa2_q)
+				qstats[i].q_opackets = dpaa2_q->tx_pkts;
+		}
+	}
+
+	return 0;
 }
 
 static int
@@ -3326,9 +3595,9 @@ static struct eth_dev_ops dpaa2_ethdev_ops = {
 	.link_update	   = dpaa2_dev_link_update,
 	.stats_get	       = dpaa2_dev_stats_get,
 	.xstats_get	       = dpaa2_dev_xstats_get,
-	.xstats_get_by_id     = dpaa2_xstats_get_by_id,
-	.xstats_get_names_by_id = dpaa2_xstats_get_names_by_id,
-	.xstats_get_names      = dpaa2_xstats_get_names,
+	.xstats_get_by_id     = dpaa2_dev_xstats_get_by_id,
+	.xstats_get_names_by_id = dpaa2_dev_xstats_get_names_by_id,
+	.xstats_get_names      = dpaa2_dev_xstats_get_names,
 	.stats_reset	   = dpaa2_dev_stats_reset,
 	.xstats_reset	      = dpaa2_dev_stats_reset,
 	.fw_version_get	   = dpaa2_fw_version_get,
@@ -3682,17 +3951,6 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 
 	priv->speed_capa = dpaa2_dev_get_speed_capability(eth_dev);
 
-	/* mac_statistics supported on MC version > 10.39.0 */
-	{
-		struct mc_version mc_ver_info = {0};
-
-		if (!mc_get_version(dpni_dev, CMD_PRI_LOW, &mc_ver_info) &&
-		    mc_ver_info.major >= MC_VER_MAJOR &&
-		    mc_ver_info.minor >= MC_VER_MINOR &&
-		    mc_ver_info.revision > 0)
-			dpaa2_dev_mac_setup_stats(eth_dev);
-	}
-
 	return 0;
 init_err:
 	dpaa2_dev_close(eth_dev);
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index cc0292cd9c..00bbc17862 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -206,6 +206,7 @@
 
 #define DPAA2_FLOW_FRM_REPLICATION_ACTION_MC_REV RTE_FSL_MC_REV(10, 39, 106)
 #define DPAA2_QOS_FLOW_TABLE_SET_V3_MC_REV RTE_FSL_MC_REV(10, 39, 109)
+#define DPAA2_MAC_XSTATS_MC_REV RTE_FSL_MC_REV(10, 39, 109)
 
 /* mac counters */
 #define DPAA2_MAC_NUM_STATS            (DPMAC_CNT_EGR_CONTROL_FRAME + 1)
@@ -514,6 +515,12 @@ struct dpaa2_dev_priv {
 	uint64_t cnt_idx_iova, cnt_values_iova;
 	uint64_t mc_rev;
 
+	/* Cache one dpni_statistics result per (page_id, param) pair to avoid
+	 * redundant MC commands when multiple xstats share the same page.
+	 * Put it in heap to avoid allocating multi-KB stack in runtime.
+	 */
+	union dpni_statistics pg_xstats[DPNI_MAX_STATISTICS_PAGE_ID][DPNI_STAT_MAX_PARAM];
+
 	struct dpaa2_dev_flow *curr;
 	LIST_HEAD(, dpaa2_dev_flow) flows;
 	LIST_HEAD(nodes, dpaa2_tm_node) nodes;
@@ -662,8 +669,4 @@ int dpaa2_timesync_read_tx_timestamp(struct rte_eth_dev *dev,
 
 int dpaa2_dev_recycle_config(struct rte_eth_dev *eth_dev);
 int dpaa2_dev_recycle_deconfig(struct rte_eth_dev *eth_dev);
-
-void
-dpaa2_dev_mac_setup_stats(struct rte_eth_dev *dev);
-
 #endif /* _DPAA2_ETHDEV_H */
diff --git a/drivers/net/dpaa2/mc/fsl_dpni.h b/drivers/net/dpaa2/mc/fsl_dpni.h
index f47f383a9b..b63627493a 100644
--- a/drivers/net/dpaa2/mc/fsl_dpni.h
+++ b/drivers/net/dpaa2/mc/fsl_dpni.h
@@ -688,50 +688,77 @@ int dpni_get_tx_data_offset(struct fsl_mc_io *mc_io,
  * @page_6.tx_pending_frames_cnt: total number of frames pending in Tx queues
  * @raw: raw statistics structure, used to index counters
  */
+enum dpni_statistics_page_id {
+	DPNI_INGRESS_STATISTICS_PAGE_ID = 0,
+	DPNI_EGRESS_STATISTICS_PAGE_ID = 1,
+	DPNI_ERR_STATISTICS_PAGE_ID = 2,
+	DPNI_CEETM_STATISTICS_PAGE_ID = 3,
+	DPNI_CGR_STATISTICS_PAGE_ID = 4,
+	DPNI_POLICER_STATISTICS_PAGE_ID = 5,
+	DPNI_TX_PENDING_STATISTICS_PAGE_ID = 6,
+	DPNI_MAX_STATISTICS_PAGE_ID
+};
+
+struct dpni_statistics_page_0 {
+	uint64_t ingress_all_frames;
+	uint64_t ingress_all_bytes;
+	uint64_t ingress_multicast_frames;
+	uint64_t ingress_multicast_bytes;
+	uint64_t ingress_broadcast_frames;
+	uint64_t ingress_broadcast_bytes;
+};
+
+struct dpni_statistics_page_1 {
+	uint64_t egress_all_frames;
+	uint64_t egress_all_bytes;
+	uint64_t egress_multicast_frames;
+	uint64_t egress_multicast_bytes;
+	uint64_t egress_broadcast_frames;
+	uint64_t egress_broadcast_bytes;
+};
+
+struct dpni_statistics_page_2 {
+	uint64_t ingress_filtered_frames;
+	uint64_t ingress_discarded_frames;
+	uint64_t ingress_nobuffer_discards;
+	uint64_t egress_discarded_frames;
+	uint64_t egress_confirmed_frames;
+};
+
+struct dpni_statistics_page_3 {
+	uint64_t ceetm_dequeue_bytes;
+	uint64_t ceetm_dequeue_frames;
+	uint64_t ceetm_reject_bytes;
+	uint64_t ceetm_reject_frames;
+};
+
+struct dpni_statistics_page_4 {
+	uint64_t cgr_reject_frames;
+	uint64_t cgr_reject_bytes;
+};
+
+struct dpni_statistics_page_5 {
+	uint64_t policer_cnt_red;
+	uint64_t policer_cnt_yellow;
+	uint64_t policer_cnt_green;
+	uint64_t policer_cnt_re_red;
+	uint64_t policer_cnt_re_yellow;
+};
+
+struct dpni_statistics_page_6 {
+	uint64_t tx_pending_frames_cnt;
+};
+
+#define DPNI_STAT_MAX_PARAM DPNI_MAX_TC
+
 union dpni_statistics {
-	struct {
-		uint64_t ingress_all_frames;
-		uint64_t ingress_all_bytes;
-		uint64_t ingress_multicast_frames;
-		uint64_t ingress_multicast_bytes;
-		uint64_t ingress_broadcast_frames;
-		uint64_t ingress_broadcast_bytes;
-	} page_0;
-	struct {
-		uint64_t egress_all_frames;
-		uint64_t egress_all_bytes;
-		uint64_t egress_multicast_frames;
-		uint64_t egress_multicast_bytes;
-		uint64_t egress_broadcast_frames;
-		uint64_t egress_broadcast_bytes;
-	} page_1;
-	struct {
-		uint64_t ingress_filtered_frames;
-		uint64_t ingress_discarded_frames;
-		uint64_t ingress_nobuffer_discards;
-		uint64_t egress_discarded_frames;
-		uint64_t egress_confirmed_frames;
-	} page_2;
-	struct {
-		uint64_t ceetm_dequeue_bytes;
-		uint64_t ceetm_dequeue_frames;
-		uint64_t ceetm_reject_bytes;
-		uint64_t ceetm_reject_frames;
-	} page_3;
-	struct {
-		uint64_t cgr_reject_frames;
-		uint64_t cgr_reject_bytes;
-	} page_4;
-	struct {
-		uint64_t policer_cnt_red;
-		uint64_t policer_cnt_yellow;
-		uint64_t policer_cnt_green;
-		uint64_t policer_cnt_re_red;
-		uint64_t policer_cnt_re_yellow;
-	} page_5;
-	struct {
-		uint64_t tx_pending_frames_cnt;
-	} page_6;
+	struct dpni_statistics_page_0 page_0;
+	struct dpni_statistics_page_1 page_1;
+	struct dpni_statistics_page_2 page_2;
+	struct dpni_statistics_page_3 page_3;
+	struct dpni_statistics_page_4 page_4;
+	struct dpni_statistics_page_5 page_5;
+	struct dpni_statistics_page_6 page_6;
 	struct {
 		uint64_t counter[DPNI_STATISTICS_CNT];
 	} raw;
@@ -2134,9 +2161,6 @@ int dpni_sp_enable(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_t token,
 int dpni_get_mac_statistics(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_t token,
 			    uint64_t iova_cnt, uint64_t iova_values, uint32_t num_cnt);
 
-int dpni_get_mac_statistics(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_t token,
-			    uint64_t iova_cnt, uint64_t iova_values, uint32_t num_cnt);
-
 int dpni_get_mac_speed_capability(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_t token,
 				  uint32_t *speed_cap);
 
-- 
2.43.0

