Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DD9606A31B
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:46:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 82AD240E1C;
	Fri, 23 Oct 2026 15:44:22 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id BF63A40DCF
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:11 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9B2911A0043;
 Fri, 23 Oct 2026 15:44:11 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3D40F1A000A;
 Fri, 23 Oct 2026 15:44:11 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 38930180006C;
 Fri, 23 Oct 2026 21:44:10 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 18/65] net/dpaa2: unify xstats layout and add DPMAC
 counter struct
Date: Fri, 23 Oct 2026 19:12:58 +0530
Message-ID: <20261023134346.37727-19-prashant.gupta_3@nxp.com>
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

The DPNI page counters and the DPMAC counters were described by three
loosely coupled artifacts: a struct dpaa2_dpni_xstats_pg_seq covering
only the DPNI pages, a parallel s_dpaa2_dpni_xstats_pgs[] descriptor
table carrying (page_offset, page_id, param, size), and two separate
name arrays (dpaa2_dpni_xstats_strings[] and
dpaa2_mac_xstats_strings[]). Keeping those three in sync was manual
and error prone, and dpaa2_dev_stats_get() further depended on a
fourth table (dpaa2_stats_strings[]) plus a string-match loop to
translate rte_eth_stats fields into xstat ids.

Collapse all of this to a single source of truth driven by the C
struct layout.

Behavior is unchanged apart from the per-TC policer name format;
the refactor removes ~200 lines of duplicated metadata and makes
adding a new counter a one-line struct change.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 549 +++++++++++++------------------
 drivers/net/dpaa2/dpaa2_ethdev.h |   3 +-
 drivers/net/dpaa2/mc/fsl_dpni.h  | 146 ++++++++
 3 files changed, 378 insertions(+), 320 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index e7ac6b7dad..b30a8e7b3d 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -169,7 +169,7 @@ dpaa2_dist_size_is_supported(uint16_t n)
 int dpaa2_valid_dev;
 struct rte_mempool *dpaa2_tx_sg_pool;
 
-struct dpaa2_dpni_xstats_pg_seq {
+struct dpaa2_xstats_seq {
 	struct dpni_statistics_page_0 pg0;
 	struct dpni_statistics_page_1 pg1;
 	struct dpni_statistics_page_2 pg2;
@@ -177,119 +177,81 @@ struct dpaa2_dpni_xstats_pg_seq {
 	struct dpni_statistics_page_4 pg4;
 	struct dpni_statistics_page_5 pg5[MAX_TCS];
 	struct dpni_statistics_page_6 pg6;
+	struct dpni_dpmac_counters mac_cnt;
 };
 
 #define DPAA2_DPNI_XSTAT_MAX_NUM \
-	(sizeof(struct dpaa2_dpni_xstats_pg_seq) / sizeof(uint64_t))
-
-struct dpaa2_dpni_xstats_pg {
-	uint64_t page_offset;
-	enum dpni_statistics_page_id page_id;
-	uint16_t param;
-	uint16_t size;
-};
-
-static const struct dpaa2_dpni_xstats_pg s_dpaa2_dpni_xstats_pgs[] = {
-	{
-		offsetof(struct dpaa2_dpni_xstats_pg_seq, pg0),
-		DPNI_INGRESS_STATISTICS_PAGE_ID, 0,
-		sizeof(struct dpni_statistics_page_0)
-	},
-	{
-		offsetof(struct dpaa2_dpni_xstats_pg_seq, pg1),
-		DPNI_EGRESS_STATISTICS_PAGE_ID, 0,
-		sizeof(struct dpni_statistics_page_1)
-	},
-	{
-		offsetof(struct dpaa2_dpni_xstats_pg_seq, pg2),
-		DPNI_ERR_STATISTICS_PAGE_ID, 0,
-		sizeof(struct dpni_statistics_page_2)
-	},
-	{
-		offsetof(struct dpaa2_dpni_xstats_pg_seq, pg3),
-		DPNI_CEETM_STATISTICS_PAGE_ID, 0,
-		sizeof(struct dpni_statistics_page_3)
-	},
-	{
-		offsetof(struct dpaa2_dpni_xstats_pg_seq, pg4),
-		DPNI_CGR_STATISTICS_PAGE_ID, 0,
-		sizeof(struct dpni_statistics_page_4)
-	},
-	{
-		offsetof(struct dpaa2_dpni_xstats_pg_seq, pg5[0]),
-		DPNI_POLICER_STATISTICS_PAGE_ID, 0,
-		sizeof(struct dpni_statistics_page_5)
-	},
-	{
-		offsetof(struct dpaa2_dpni_xstats_pg_seq, pg5[1]),
-		DPNI_POLICER_STATISTICS_PAGE_ID, 1,
-		sizeof(struct dpni_statistics_page_5)
-	},
-	{
-		offsetof(struct dpaa2_dpni_xstats_pg_seq, pg5[2]),
-		DPNI_POLICER_STATISTICS_PAGE_ID, 2,
-		sizeof(struct dpni_statistics_page_5)
-	},
-	{
-		offsetof(struct dpaa2_dpni_xstats_pg_seq, pg5[3]),
-		DPNI_POLICER_STATISTICS_PAGE_ID, 3,
-		sizeof(struct dpni_statistics_page_5)
-	},
-	{
-		offsetof(struct dpaa2_dpni_xstats_pg_seq, pg5[4]),
-		DPNI_POLICER_STATISTICS_PAGE_ID, 4,
-		sizeof(struct dpni_statistics_page_5)
-	},
-	{
-		offsetof(struct dpaa2_dpni_xstats_pg_seq, pg5[5]),
-		DPNI_POLICER_STATISTICS_PAGE_ID, 5,
-		sizeof(struct dpni_statistics_page_5)
-	},
-	{
-		offsetof(struct dpaa2_dpni_xstats_pg_seq, pg5[6]),
-		DPNI_POLICER_STATISTICS_PAGE_ID, 6,
-		sizeof(struct dpni_statistics_page_5)
-	},
-	{
-		offsetof(struct dpaa2_dpni_xstats_pg_seq, pg5[7]),
-		DPNI_POLICER_STATISTICS_PAGE_ID, 7,
-		sizeof(struct dpni_statistics_page_5)
-	},
-	{
-		offsetof(struct dpaa2_dpni_xstats_pg_seq, pg6),
-		DPNI_TX_PENDING_STATISTICS_PAGE_ID, 0,
-		sizeof(struct dpni_statistics_page_6)
-	},
-	{
-		sizeof(struct dpaa2_dpni_xstats_pg_seq),
-		0, 0, 0
-	}
-};
+	(offsetof(struct dpaa2_xstats_seq, mac_cnt) / sizeof(uint64_t))
+
+#define DPAA2_DPNI_STAT_SET_PAGE_PARAM(param) \
+({ \
+	int ret = false; \
+	\
+	if ((id) >= this_offset && (id) < (this_offset + pg_size)) { \
+		_stat_id = (id) - this_offset; \
+		_param = param; \
+		_size = pg_size; \
+		ret = true; \
+	} \
+	ret; \
+})
+
+#define DPAA2_DPNI_STAT_PAGE_PARAM(pid) \
+({ \
+	uint64_t this_offset = offsetof(struct dpaa2_xstats_seq, pg##pid) / sizeof(uint64_t); \
+	uint64_t pg_size = sizeof(struct dpni_statistics_page_##pid) / sizeof(uint64_t); \
+	int ret; \
+	\
+	ret = DPAA2_DPNI_STAT_SET_PAGE_PARAM(0); \
+	if (!ret) \
+		_page++; \
+	ret; \
+})
+
+#define DPAA2_DPNI_STAT_POLICER_PAGE_PARAM() \
+({ \
+	int ret = false; \
+	uint8_t tc_id; \
+	uint64_t this_offset; \
+	uint64_t pg_size = sizeof(struct dpni_statistics_page_5) / sizeof(uint64_t); \
+	\
+	for (tc_id = 0; tc_id < MAX_TCS; tc_id++) { \
+		this_offset = offsetof(struct dpaa2_xstats_seq, pg5[tc_id]) / sizeof(uint64_t); \
+		ret = DPAA2_DPNI_STAT_SET_PAGE_PARAM(tc_id); \
+		if (ret) \
+			break; \
+	} \
+	if (!ret) \
+		_page++; \
+	ret; \
+})
 
 static inline int
 dpaa2_xstats_id_parse(uint32_t id, uint8_t *page,
 	uint8_t *stat_id, uint16_t *param, uint16_t *size)
 {
-	int found = 0;
-	uint8_t _page = 0, _stat_id = 0;
+	uint8_t _page = DPNI_INGRESS_STATISTICS_PAGE_ID, _stat_id = 0;
 	uint16_t _param = 0, _size = 0;
-	uint64_t offset = id * sizeof(uint64_t), page_offset = 0, i;
-
-	for (i = 1; i < RTE_DIM(s_dpaa2_dpni_xstats_pgs); i++) {
-		if (offset < s_dpaa2_dpni_xstats_pgs[i].page_offset) {
-			page_offset = s_dpaa2_dpni_xstats_pgs[i - 1].page_offset;
-			_page = s_dpaa2_dpni_xstats_pgs[i - 1].page_id;
-			_stat_id = (offset - page_offset) / sizeof(uint64_t);
-			_param = s_dpaa2_dpni_xstats_pgs[i - 1].param;
-			_size = s_dpaa2_dpni_xstats_pgs[i - 1].size / sizeof(uint64_t);
-			found = 1;
-			break;
-		}
-	}
-
-	if (!found)
-		return -EINVAL;
 
+	if (DPAA2_DPNI_STAT_PAGE_PARAM(0))
+		goto found_id;
+	if (DPAA2_DPNI_STAT_PAGE_PARAM(1))
+		goto found_id;
+	if (DPAA2_DPNI_STAT_PAGE_PARAM(2))
+		goto found_id;
+	if (DPAA2_DPNI_STAT_PAGE_PARAM(3))
+		goto found_id;
+	if (DPAA2_DPNI_STAT_PAGE_PARAM(4))
+		goto found_id;
+	if (DPAA2_DPNI_STAT_POLICER_PAGE_PARAM())
+		goto found_id;
+	if (DPAA2_DPNI_STAT_PAGE_PARAM(6))
+		goto found_id;
+
+	DPAA2_PMD_ERR("ID(%d) was not found in DPNI page statistics", id);
+	return -EINVAL;
+
+found_id:
 	if (page)
 		*page = _page;
 	if (stat_id)
@@ -302,156 +264,155 @@ dpaa2_xstats_id_parse(uint32_t id, uint8_t *page,
 	return 0;
 }
 
-struct dpaa2_stats_name_off {
-	char name[RTE_ETH_XSTATS_NAME_SIZE];
-	uint64_t offset;
+#define DPAA2_XSTAT_STR_SET(pg, field) \
+	.pg.field = (uint64_t)RTE_STR(field)
+
+#define DPAA2_XSTAT_TC_STR_SET(pg, tc, field) \
+	.pg[tc].field = (uint64_t)("TC" RTE_STR(tc)"_" RTE_STR(field))
+
+#define DPAA2_XSTAT_TC_COLOR_STR_SET(pg, tc) \
+	DPAA2_XSTAT_TC_STR_SET(pg, tc, policer_cnt_red), \
+	DPAA2_XSTAT_TC_STR_SET(pg, tc, policer_cnt_yellow), \
+	DPAA2_XSTAT_TC_STR_SET(pg, tc, policer_cnt_green), \
+	DPAA2_XSTAT_TC_STR_SET(pg, tc, policer_cnt_re_red), \
+	DPAA2_XSTAT_TC_STR_SET(pg, tc, policer_cnt_re_yellow)
+
+#define MAC_STR(name) ("mac_" #name)
+#define MAC_STR_ADDR(name) ((size_t)MAC_STR(name))
+
+static const struct dpaa2_xstats_seq dpaa2_xstats_strings = {
+	DPAA2_XSTAT_STR_SET(pg0, ingress_all_frames),
+	DPAA2_XSTAT_STR_SET(pg0, ingress_all_bytes),
+	DPAA2_XSTAT_STR_SET(pg0, ingress_multicast_frames),
+	DPAA2_XSTAT_STR_SET(pg0, ingress_multicast_bytes),
+	DPAA2_XSTAT_STR_SET(pg0, ingress_broadcast_frames),
+	DPAA2_XSTAT_STR_SET(pg0, ingress_broadcast_bytes),
+
+	DPAA2_XSTAT_STR_SET(pg1, egress_all_frames),
+	DPAA2_XSTAT_STR_SET(pg1, egress_all_bytes),
+	DPAA2_XSTAT_STR_SET(pg1, egress_multicast_frames),
+	DPAA2_XSTAT_STR_SET(pg1, egress_multicast_bytes),
+	DPAA2_XSTAT_STR_SET(pg1, egress_broadcast_frames),
+	DPAA2_XSTAT_STR_SET(pg1, egress_broadcast_bytes),
+
+	DPAA2_XSTAT_STR_SET(pg2, ingress_filtered_frames),
+	DPAA2_XSTAT_STR_SET(pg2, ingress_discarded_frames),
+	DPAA2_XSTAT_STR_SET(pg2, ingress_nobuffer_discards),
+	DPAA2_XSTAT_STR_SET(pg2, egress_discarded_frames),
+	DPAA2_XSTAT_STR_SET(pg2, egress_confirmed_frames),
+
+	DPAA2_XSTAT_STR_SET(pg3, ceetm_dequeue_bytes),
+	DPAA2_XSTAT_STR_SET(pg3, ceetm_dequeue_frames),
+	DPAA2_XSTAT_STR_SET(pg3, ceetm_reject_bytes),
+	DPAA2_XSTAT_STR_SET(pg3, ceetm_reject_frames),
+
+	DPAA2_XSTAT_STR_SET(pg4, cgr_reject_frames),
+	DPAA2_XSTAT_STR_SET(pg4, cgr_reject_bytes),
+
+	DPAA2_XSTAT_TC_COLOR_STR_SET(pg5, 0),
+	DPAA2_XSTAT_TC_COLOR_STR_SET(pg5, 1),
+	DPAA2_XSTAT_TC_COLOR_STR_SET(pg5, 2),
+	DPAA2_XSTAT_TC_COLOR_STR_SET(pg5, 3),
+	DPAA2_XSTAT_TC_COLOR_STR_SET(pg5, 4),
+	DPAA2_XSTAT_TC_COLOR_STR_SET(pg5, 5),
+	DPAA2_XSTAT_TC_COLOR_STR_SET(pg5, 6),
+	DPAA2_XSTAT_TC_COLOR_STR_SET(pg5, 7),
+
+	DPAA2_XSTAT_STR_SET(pg6, tx_pending_frames_cnt),
+
+	.mac_cnt.rx_64_bytes		= MAC_STR_ADDR(rx_64_bytes),
+	.mac_cnt.rx_65_127_bytes	= MAC_STR_ADDR(rx_65_127_bytes),
+	.mac_cnt.rx_128_255_bytes	= MAC_STR_ADDR(rx_128_255_bytes),
+	.mac_cnt.rx_256_511_bytes	= MAC_STR_ADDR(rx_256_511_bytes),
+	.mac_cnt.rx_512_1023_bytes	= MAC_STR_ADDR(rx_512_1023_bytes),
+	.mac_cnt.rx_1024_1518_bytes	= MAC_STR_ADDR(rx_1024_1518_bytes),
+	.mac_cnt.rx_1519_max_bytes	= MAC_STR_ADDR(rx_1519_max_bytes),
+
+	.mac_cnt.rx_fragments		= MAC_STR_ADDR(rx_fragments),
+	.mac_cnt.rx_jabber			= MAC_STR_ADDR(rx_jabber),
+	.mac_cnt.rx_drop_fifo		= MAC_STR_ADDR(rx_drop_fifo),
+	.mac_cnt.rx_alignment_error	= MAC_STR_ADDR(rx_alignment_error),
+
+	.mac_cnt.tx_undersize_good	= MAC_STR_ADDR(tx_undersize_good),
+	.mac_cnt.rx_oversize_good	= MAC_STR_ADDR(rx_oversize_good),
+
+	.mac_cnt.rx_pause			= MAC_STR_ADDR(rx_pause),
+	.mac_cnt.tx_pause			= MAC_STR_ADDR(tx_pause),
+
+	.mac_cnt.rx_good_bytes		= MAC_STR_ADDR(rx_good_bytes),
+	.mac_cnt.rx_multicast		= MAC_STR_ADDR(rx_multicast),
+	.mac_cnt.rx_broadcast		= MAC_STR_ADDR(rx_broadcast),
+	.mac_cnt.rx_all_frames		= MAC_STR_ADDR(rx_all_frames),
+	.mac_cnt.rx_unicast			= MAC_STR_ADDR(rx_unicast),
+	.mac_cnt.rx_error			= MAC_STR_ADDR(rx_error),
+
+	.mac_cnt.tx_good_bytes		= MAC_STR_ADDR(tx_good_bytes),
+	.mac_cnt.tx_multicast		= MAC_STR_ADDR(tx_multicast),
+	.mac_cnt.tx_broadcast		= MAC_STR_ADDR(tx_broadcast),
+	.mac_cnt.tx_unicast			= MAC_STR_ADDR(tx_unicast),
+	.mac_cnt.tx_error			= MAC_STR_ADDR(tx_error),
+
+	.mac_cnt.rx_valid_frames	= MAC_STR_ADDR(rx_valid_frames),
+	.mac_cnt.tx_valid_frames	= MAC_STR_ADDR(tx_valid_frames),
+
+	.mac_cnt.tx_64_bytes		= MAC_STR_ADDR(tx_64_bytes),
+	.mac_cnt.tx_65_127_bytes	= MAC_STR_ADDR(tx_65_127_bytes),
+	.mac_cnt.tx_128_255_bytes	= MAC_STR_ADDR(tx_128_255_bytes),
+	.mac_cnt.tx_256_511_bytes	= MAC_STR_ADDR(tx_256_511_bytes),
+	.mac_cnt.tx_512_1023_bytes	= MAC_STR_ADDR(tx_512_1023_bytes),
+	.mac_cnt.tx_1024_1518_bytes	= MAC_STR_ADDR(tx_1024_1518_bytes),
+	.mac_cnt.tx_1519_max_bytes	= MAC_STR_ADDR(tx_1519_max_bytes),
+
+	.mac_cnt.rx_bytes_all		= MAC_STR_ADDR(rx_bytes_all),
+	.mac_cnt.rx_crc_error		= MAC_STR_ADDR(rx_crc_error),
+	.mac_cnt.rx_vlan			= MAC_STR_ADDR(rx_vlan),
+	.mac_cnt.rx_undersize_good	= MAC_STR_ADDR(rx_undersize_good),
+	.mac_cnt.rx_ctrl_non_pause	= MAC_STR_ADDR(rx_ctrl_non_pause),
+	.mac_cnt.rx_drop_full		= MAC_STR_ADDR(rx_drop_full),
+
+	.mac_cnt.tx_bytes_all		= MAC_STR_ADDR(tx_bytes_all),
+	.mac_cnt.tx_crc_error		= MAC_STR_ADDR(tx_crc_error),
+	.mac_cnt.tx_vlan			= MAC_STR_ADDR(tx_vlan),
+	.mac_cnt.tx_all_frames		= MAC_STR_ADDR(tx_all_frames),
+	.mac_cnt.tx_ctrl_non_pause	= MAC_STR_ADDR(tx_ctrl_non_pause),
+
+	.mac_cnt.rx_pfc_class[0]	= MAC_STR_ADDR(rx_pfc_class_0),
+	.mac_cnt.rx_pfc_class[1]	= MAC_STR_ADDR(rx_pfc_class_1),
+	.mac_cnt.rx_pfc_class[2]	= MAC_STR_ADDR(rx_pfc_class_2),
+	.mac_cnt.rx_pfc_class[3]	= MAC_STR_ADDR(rx_pfc_class_3),
+	.mac_cnt.rx_pfc_class[4]	= MAC_STR_ADDR(rx_pfc_class_4),
+	.mac_cnt.rx_pfc_class[5]	= MAC_STR_ADDR(rx_pfc_class_5),
+	.mac_cnt.rx_pfc_class[6]	= MAC_STR_ADDR(rx_pfc_class_6),
+	.mac_cnt.rx_pfc_class[7]	= MAC_STR_ADDR(rx_pfc_class_7),
+
+	.mac_cnt.tx_pfc_class[0]	= MAC_STR_ADDR(tx_pfc_class_0),
+	.mac_cnt.tx_pfc_class[1]	= MAC_STR_ADDR(tx_pfc_class_1),
+	.mac_cnt.tx_pfc_class[2]	= MAC_STR_ADDR(tx_pfc_class_2),
+	.mac_cnt.tx_pfc_class[3]	= MAC_STR_ADDR(tx_pfc_class_3),
+	.mac_cnt.tx_pfc_class[4]	= MAC_STR_ADDR(tx_pfc_class_4),
+	.mac_cnt.tx_pfc_class[5]	= MAC_STR_ADDR(tx_pfc_class_5),
+	.mac_cnt.tx_pfc_class[6]	= MAC_STR_ADDR(tx_pfc_class_6),
+	.mac_cnt.tx_pfc_class[7]	= MAC_STR_ADDR(tx_pfc_class_7)
 };
 
-#define DPAA2_STATS_IPACKETS_STR "ingress_all_frames"
-#define DPAA2_STATS_OPACKETS_STR "egress_all_frames"
-#define DPAA2_STATS_IBYTES_STR "ingress_all_bytes"
-#define DPAA2_STATS_OBYTES_STR "egress_all_bytes"
-#define DPAA2_STATS_IERRORS_STR "ingress_discarded_frames"
-#define DPAA2_STATS_OERRORS_STR "egress_discarded_frames"
-#define DPAA2_STATS_RX_NOMBUF_STR "ingress_nobuffer_discards"
-#define DPAA2_STATS_FILTERED_STR "ingress_filtered_frames"
-
-static const struct dpaa2_stats_name_off dpaa2_stats_strings[] = {
-	{
-		DPAA2_STATS_IPACKETS_STR,
-		offsetof(struct rte_eth_stats, ipackets)
-	},
-	{
-		DPAA2_STATS_OPACKETS_STR,
-		offsetof(struct rte_eth_stats, opackets)
-	},
-	{
-		DPAA2_STATS_IBYTES_STR,
-		offsetof(struct rte_eth_stats, ibytes)
-	},
-	{
-		DPAA2_STATS_OBYTES_STR,
-		offsetof(struct rte_eth_stats, obytes)
-	},
-	{
-		DPAA2_STATS_FILTERED_STR,
-		sizeof(struct rte_eth_stats)
-	},
-	{
-		DPAA2_STATS_IERRORS_STR,
-		offsetof(struct rte_eth_stats, ierrors)
-	},
-	{
-		DPAA2_STATS_OERRORS_STR,
-		offsetof(struct rte_eth_stats, oerrors)
-	},
-	{
-		DPAA2_STATS_RX_NOMBUF_STR,
-		offsetof(struct rte_eth_stats, rx_nombuf)
-	}
+#define DPAA2_DPNI_XSTAT_FIELD_ID(field) \
+	(offsetof(struct dpaa2_xstats_seq, field) / sizeof(uint64_t))
+
+static const struct rte_eth_stats dpaa2_stats_xstat_ids = {
+	.ipackets = DPAA2_DPNI_XSTAT_FIELD_ID(pg0.ingress_all_frames),
+	.opackets = DPAA2_DPNI_XSTAT_FIELD_ID(pg1.egress_all_frames),
+	.ibytes = DPAA2_DPNI_XSTAT_FIELD_ID(pg0.ingress_all_bytes),
+	.obytes = DPAA2_DPNI_XSTAT_FIELD_ID(pg1.egress_all_bytes),
+	.imissed = DPAA2_DPNI_XSTAT_FIELD_ID(pg2.ingress_filtered_frames),
+	.ierrors = DPAA2_DPNI_XSTAT_FIELD_ID(pg2.ingress_discarded_frames),
+	.oerrors = DPAA2_DPNI_XSTAT_FIELD_ID(pg2.egress_discarded_frames),
+	.rx_nombuf = DPAA2_DPNI_XSTAT_FIELD_ID(pg2.ingress_nobuffer_discards)
 };
 
-#define DPAA2_STATS_SET_BY_OFFSET(p_stats, offset, val) \
-	(*((uint64_t *)((uint8_t *)(p_stats) + (offset))) = (val))
-
-#define DPAA2_TC_COLOR(tc) \
-	"TC_"#tc"_policer_cnt_red", \
-	"TC_"#tc"_policer_cnt_yellow", \
-	"TC_"#tc"_policer_cnt_green", \
-	"TC_"#tc"_policer_cnt_re_red", \
-	"TC_"#tc"_policer_cnt_re_yellow" \
-
-static const char * const dpaa2_dpni_xstats_strings[] = {
-	DPAA2_STATS_IPACKETS_STR,
-	DPAA2_STATS_IBYTES_STR,
-	"ingress_multicast_frames",
-	"ingress_multicast_bytes",
-	"ingress_broadcast_frames",
-	"ingress_broadcast_bytes",
-
-	DPAA2_STATS_OPACKETS_STR,
-	DPAA2_STATS_OBYTES_STR,
-	"egress_multicast_frames",
-	"egress_multicast_bytes",
-	"egress_broadcast_frames",
-	"egress_broadcast_bytes",
-
-	DPAA2_STATS_FILTERED_STR,
-	DPAA2_STATS_IERRORS_STR,
-	DPAA2_STATS_RX_NOMBUF_STR,
-	DPAA2_STATS_OERRORS_STR,
-	"egress_confirmed_frames",
-
-	"cgr_reject_frames",
-	"cgr_reject_bytes",
-
-	"ceetm_dequeue_bytes",
-	"ceetm_dequeue_frames",
-	"ceetm_reject_bytes",
-	"ceetm_reject_frames",
-	DPAA2_TC_COLOR(0),
-	DPAA2_TC_COLOR(1),
-	DPAA2_TC_COLOR(2),
-	DPAA2_TC_COLOR(3),
-	DPAA2_TC_COLOR(4),
-	DPAA2_TC_COLOR(5),
-	DPAA2_TC_COLOR(6),
-	DPAA2_TC_COLOR(7),
-
-	"tx_pending_frames_cnt"
-};
+#define DPAA2_STATS_XSTATS_NUM \
+	(sizeof(dpaa2_stats_xstat_ids) / sizeof(uint64_t))
 
-static const char * const dpaa2_mac_xstats_strings[] = {
-	"mac_rx_64 bytes",
-	"mac_rx_65-127 bytes",
-	"mac_rx_128-255 bytes",
-	"mac_rx_256-511 bytes",
-	"mac_rx_512-1023 bytes",
-	"mac_rx_1024-1518 bytes",
-	"mac_rx_1519-max bytes",
-	"mac_rx_frags",
-	"mac_rx_jabber",
-	"mac_rx_frame discards",
-	"mac_rx_align errors",
-	"mac_tx_undersized",
-	"mac_rx_oversized",
-	"mac_rx_pause",
-	"mac_tx_b-pause",
-	"mac_rx_bytes",
-	"mac_rx_m-cast",
-	"mac_rx_b-cast",
-	"mac_rx_all frames",
-	"mac_rx_u-cast",
-	"mac_rx_frame errors",
-	"mac_tx_bytes",
-	"mac_tx_m-cast",
-	"mac_tx_b-cast",
-	"mac_tx_u-cast",
-	"mac_tx_frame errors",
-	"mac_rx_frames ok",
-	"mac_tx_frames ok",
-	"mac_tx_64 bytes",
-	"mac_tx_65-127 bytes",
-	"mac_tx_128-255 bytes",
-	"mac_tx_256-511 bytes",
-	"mac_tx_512-1023 bytes",
-	"mac_tx_1024-1518 bytes",
-	"mac_tx_1519-max bytes",
-	"mac_rx_all_bytes",
-	"mac_rx_fcs_err",
-	"mac_rx_vlan_frame",
-	"mac_rx_undersized",
-	"mac_rx_control_frame",
-	"mac_rx_frame_discard_not_trunc",
-	"mac_tx_all_bytes",
-	"mac_tx_fcs_err",
-	"mac_tx_vlan_frame",
-	"mac_tx_all_frame",
-	"mac_tx_control_frame"
-};
-
-#define DPAA2_MAC_XSTATS_START_ID \
-	(sizeof(struct dpaa2_dpni_xstats_pg_seq) / sizeof(uint64_t))
+#define DPAA2_MAC_XSTATS_START_ID DPAA2_DPNI_XSTAT_MAX_NUM
 
 static struct rte_dpaa2_driver rte_dpaa2_pmd;
 static int dpaa2_dev_link_update(struct rte_eth_dev *dev,
@@ -2333,6 +2294,7 @@ dpaa2_dev_xstats_get_names(struct rte_eth_dev *dev,
 {
 	struct dpaa2_dev_priv *priv = dev->data->dev_private;
 	uint16_t i, stat_cnt;
+	uint64_t xstat_str[sizeof(struct dpaa2_xstats_seq) / sizeof(uint64_t)];
 
 	stat_cnt = DPAA2_DPNI_XSTAT_MAX_NUM;
 	if (priv->ep_dev_type == DPAA2_MAC)
@@ -2347,16 +2309,10 @@ dpaa2_dev_xstats_get_names(struct rte_eth_dev *dev,
 	if (!xstats_names)
 		return stat_cnt;
 
-	for (i = 0; i < stat_cnt; i++) {
-		if (i < DPAA2_DPNI_XSTAT_MAX_NUM) {
-			rte_strscpy(xstats_names[i].name, dpaa2_dpni_xstats_strings[i],
-				RTE_ETH_XSTATS_NAME_SIZE);
-		} else {
-			rte_strscpy(xstats_names[i].name,
-				dpaa2_mac_xstats_strings[i - DPAA2_DPNI_XSTAT_MAX_NUM],
-				RTE_ETH_XSTATS_NAME_SIZE);
-		}
-	}
+	rte_memcpy(xstat_str, &dpaa2_xstats_strings, sizeof(xstat_str));
+
+	for (i = 0; i < stat_cnt; i++)
+		rte_strscpy(xstats_names[i].name, (char *)xstat_str[i], RTE_ETH_XSTATS_NAME_SIZE);
 
 	return stat_cnt;
 }
@@ -2464,6 +2420,7 @@ dpaa2_dev_xstats_get_names_by_id(struct rte_eth_dev *dev,
 {
 	struct dpaa2_dev_priv *priv = dev->data->dev_private;
 	uint16_t i, stat_cnt;
+	uint64_t xstat_str[sizeof(struct dpaa2_xstats_seq) / sizeof(uint64_t)];
 
 	stat_cnt = DPAA2_DPNI_XSTAT_MAX_NUM;
 	if (priv->ep_dev_type == DPAA2_MAC)
@@ -2472,20 +2429,15 @@ dpaa2_dev_xstats_get_names_by_id(struct rte_eth_dev *dev,
 	if (!ids)
 		return dpaa2_dev_xstats_get_names(dev, xstats_names, limit);
 
+	rte_memcpy(xstat_str, &dpaa2_xstats_strings, sizeof(xstat_str));
+
 	for (i = 0; i < limit; i++) {
 		if (ids[i] >= stat_cnt) {
 			DPAA2_PMD_ERR("xstats id[%d] value(%" PRIu64 ") >= max count(%d)",
 				i, ids[i], stat_cnt);
 			return -EINVAL;
 		}
-		if (ids[i] < DPAA2_DPNI_XSTAT_MAX_NUM) {
-			rte_strscpy(xstats_names[i].name, dpaa2_dpni_xstats_strings[ids[i]],
-				RTE_ETH_XSTATS_NAME_SIZE);
-		} else {
-			rte_strscpy(xstats_names[i].name,
-				dpaa2_mac_xstats_strings[ids[i] - DPAA2_DPNI_XSTAT_MAX_NUM],
-				RTE_ETH_XSTATS_NAME_SIZE);
-		}
+		rte_strscpy(xstats_names[i].name, (char *)xstat_str[ids[i]], RTE_ETH_XSTATS_NAME_SIZE);
 	}
 	return limit;
 }
@@ -2496,64 +2448,24 @@ dpaa2_dev_stats_get(struct rte_eth_dev *dev,
 {
 	struct dpaa2_dev_priv *priv = dev->data->dev_private;
 	int32_t retcode;
-	uint16_t stats_len = RTE_DIM(dpaa2_stats_strings), i, j, xstats_len;
+	uint16_t i;
+	uint64_t ids[DPAA2_STATS_XSTATS_NUM], counts[DPAA2_STATS_XSTATS_NUM] = {0};
 	struct dpaa2_queue *dpaa2_q;
-	uint64_t ids[stats_len];
-	uint64_t counts[stats_len];
-	uint64_t ifiltered = 0;
-	const char **dpni_nms = (const char **)&dpaa2_dpni_xstats_strings;
 
 	PMD_INIT_FUNC_TRACE();
 
-	xstats_len = DPAA2_DPNI_XSTAT_MAX_NUM;
-	if (priv->ep_dev_type == DPAA2_MAC)
-		xstats_len += DPAA2_MAC_NUM_STATS;
-
-	if (!stats) {
-		DPAA2_PMD_ERR("stats is NULL");
-		return -EINVAL;
-	}
-
-	memset(stats, 0, sizeof(struct rte_eth_stats));
-
-	for (i = 0; i < stats_len; i++) {
-		for (j = 0; j < xstats_len; j++) {
-			if (j < DPAA2_DPNI_XSTAT_MAX_NUM) {
-				retcode = strcmp(dpaa2_stats_strings[i].name, dpni_nms[j]);
-			} else {
-				retcode = strcmp(dpaa2_stats_strings[i].name,
-					dpaa2_mac_xstats_strings[j - DPAA2_DPNI_XSTAT_MAX_NUM]);
-			}
-			if (!retcode) {
-				ids[i] = j;
-				break;
-			}
-		}
-		if (j == xstats_len) {
-			DPAA2_PMD_ERR("%s: stat(%s) not found in xstat!",
-				__func__, dpaa2_stats_strings[i].name);
-			return -EINVAL;
-		}
-	}
-
-	retcode = dpaa2_dev_xstats_get_by_id(dev, ids, counts, stats_len);
-	if (retcode != stats_len) {
-		DPAA2_PMD_ERR("%s: Failed to get xstats (%d)counters by %d IDs",
-			__func__, retcode, stats_len);
+	rte_memcpy(ids, &dpaa2_stats_xstat_ids, sizeof(dpaa2_stats_xstat_ids));
+	retcode = dpaa2_dev_xstats_get_by_id(dev, ids, counts, DPAA2_STATS_XSTATS_NUM);
+	if (retcode != RTE_DIM(ids)) {
+		DPAA2_PMD_ERR("%s: Failed to get xstats (%d)counters by %ld IDs",
+			__func__, retcode, DPAA2_STATS_XSTATS_NUM);
 		if (retcode >= 0)
 			retcode = -EINVAL;
 		return retcode;
 	}
 
-	for (i = 0; i < stats_len; i++) {
-		if (dpaa2_stats_strings[i].offset < sizeof(struct rte_eth_stats)) {
-			DPAA2_STATS_SET_BY_OFFSET(stats,
-				dpaa2_stats_strings[i].offset, counts[i]);
-		} else {
-			ifiltered = counts[i];
-		}
-	}
-	stats->imissed = stats->ierrors + stats->rx_nombuf + ifiltered;
+	rte_memcpy(stats, counts, sizeof(struct rte_eth_stats));
+	stats->imissed += stats->ierrors + stats->rx_nombuf;
 
 	if (qstats) {
 		for (i = 0; i < dev->data->nb_rx_queues; i++) {
@@ -2576,8 +2488,7 @@ dpaa2_dev_stats_reset(struct rte_eth_dev *dev)
 {
 	struct dpaa2_dev_priv *priv = dev->data->dev_private;
 	struct fsl_mc_io *dpni = dev->process_private;
-	int retcode;
-	int i;
+	int retcode, i;
 	struct dpaa2_queue *dpaa2_q;
 
 	PMD_INIT_FUNC_TRACE();
@@ -2587,7 +2498,7 @@ dpaa2_dev_stats_reset(struct rte_eth_dev *dev)
 		return -EINVAL;
 	}
 
-	retcode =  dpni_reset_statistics(dpni, CMD_PRI_LOW, priv->token);
+	retcode = dpni_reset_statistics(dpni, CMD_PRI_LOW, priv->token);
 	if (retcode)
 		goto error;
 
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index 00bbc17862..e2d9d5de36 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -209,7 +209,8 @@
 #define DPAA2_MAC_XSTATS_MC_REV RTE_FSL_MC_REV(10, 39, 109)
 
 /* mac counters */
-#define DPAA2_MAC_NUM_STATS            (DPMAC_CNT_EGR_CONTROL_FRAME + 1)
+#define DPAA2_MAC_NUM_STATS \
+	(sizeof(struct dpni_dpmac_counters) / sizeof(uint64_t))
 #define DPAA2_MAC_STATS_INDEX_DMA_SIZE (DPAA2_MAC_NUM_STATS * sizeof(uint32_t))
 #define DPAA2_MAC_STATS_VALUE_DMA_SIZE (DPAA2_MAC_NUM_STATS * sizeof(uint64_t))
 
diff --git a/drivers/net/dpaa2/mc/fsl_dpni.h b/drivers/net/dpaa2/mc/fsl_dpni.h
index b63627493a..4bec348545 100644
--- a/drivers/net/dpaa2/mc/fsl_dpni.h
+++ b/drivers/net/dpaa2/mc/fsl_dpni.h
@@ -2158,6 +2158,152 @@ int dpni_set_sp_profile(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_t to
 int dpni_sp_enable(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_t token,
 		uint8_t type, uint8_t en);
 
+struct dpni_dpmac_counters {
+	/** 0x00: Counts received 64-bytes frames, good or bad */
+	uint64_t rx_64_bytes;
+
+	/** 0x01: Counts received 65- to 127-bytes frames, good or bad */
+	uint64_t rx_65_127_bytes;
+
+	/** 0x02: Counts received 128- to 255-bytes frames, good or bad */
+	uint64_t rx_128_255_bytes;
+
+	/** 0x03: Counts received 256- to 511-bytes frames, good or bad */
+	uint64_t rx_256_511_bytes;
+
+	/** 0x04: Counts received 512- to 1023-bytes frames, good or bad */
+	uint64_t rx_512_1023_bytes;
+
+	/** 0x05: Counts received 1024- to 1518-bytes frames, good or bad */
+	uint64_t rx_1024_1518_bytes;
+
+	/** 0x06: Counts received frames >=1519 bytes */
+	uint64_t rx_1519_max_bytes;
+
+	/** 0x07: <64B frames with bad CRC */
+	uint64_t rx_fragments;
+
+	/** 0x08: >max length frames with bad FCS */
+	uint64_t rx_jabber;
+
+	/** 0x09: FIFO overflow drops (including truncated frames) */
+	uint64_t rx_drop_fifo;
+
+	/** 0x0A: Alignment error frames */
+	uint64_t rx_alignment_error;
+
+	/** 0x0B: TX <64B frames with good CRC */
+	uint64_t tx_undersize_good;
+
+	/** 0x0C: >max length frames with good FCS */
+	uint64_t rx_oversize_good;
+
+	/** 0x0D: Received pause frames (including PFC) */
+	uint64_t rx_pause;
+
+	/** 0x0E: Transmitted pause frames (including PFC) */
+	uint64_t tx_pause;
+
+	/** 0x0F: Received bytes (valid frames, exclude preamble) */
+	uint64_t rx_good_bytes;
+
+	/** 0x10: Received multicast frames */
+	uint64_t rx_multicast;
+
+	/** 0x11: Received broadcast frames */
+	uint64_t rx_broadcast;
+
+	/** 0x12: Received frames (good + bad) */
+	uint64_t rx_all_frames;
+
+	/** 0x13: Received unicast frames */
+	uint64_t rx_unicast;
+
+	/** 0x14: Received error frames (excluding fragments) */
+	uint64_t rx_error;
+
+	/** 0x15: Transmitted bytes (valid frames) */
+	uint64_t tx_good_bytes;
+
+	/** 0x16: Transmitted multicast frames */
+	uint64_t tx_multicast;
+
+	/** 0x17: Transmitted broadcast frames */
+	uint64_t tx_broadcast;
+
+	/** 0x18: Transmitted unicast frames */
+	uint64_t tx_unicast;
+
+	/** 0x19: Transmitted error frames */
+	uint64_t tx_error;
+
+	/** 0x1A: Received valid frames (no error) */
+	uint64_t rx_valid_frames;
+
+	/** 0x1B: Transmitted valid frames (no error) */
+	uint64_t tx_valid_frames;
+
+	/** 0x1C: TX 64-byte frames */
+	uint64_t tx_64_bytes;
+
+	/** 0x1D: TX 65-127-byte frames */
+	uint64_t tx_65_127_bytes;
+
+	/** 0x1E: TX 128-255-byte frames */
+	uint64_t tx_128_255_bytes;
+
+	/** 0x1F: TX 256-511-byte frames */
+	uint64_t tx_256_511_bytes;
+
+	/** 0x20: TX 512-1023-byte frames */
+	uint64_t tx_512_1023_bytes;
+
+	/** 0x21: TX 1024-1518-byte frames */
+	uint64_t tx_1024_1518_bytes;
+
+	/** 0x22: TX >=1519-byte frames */
+	uint64_t tx_1519_max_bytes;
+
+	/** 0x23: RX bytes (good + bad frames) */
+	uint64_t rx_bytes_all;
+
+	/** 0x24: RX CRC-32 error frames */
+	uint64_t rx_crc_error;
+
+	/** 0x25: Valid VLAN-tagged RX frames */
+	uint64_t rx_vlan;
+
+	/** 0x26: RX <64B frames with good CRC */
+	uint64_t rx_undersize_good;
+
+	/** 0x27: RX control frames (0x8808, non-pause) */
+	uint64_t rx_ctrl_non_pause;
+
+	/** 0x28: Fully dropped frames due to MAC client FIFO overflow */
+	uint64_t rx_drop_full;
+
+	/** 0x29: TX bytes (good + bad frames) */
+	uint64_t tx_bytes_all;
+
+	/** 0x2A: TX CRC-32 error frames */
+	uint64_t tx_crc_error;
+
+	/** 0x2B: Valid VLAN-tagged TX frames */
+	uint64_t tx_vlan;
+
+	/** 0x2C: All TX frames (good + bad) */
+	uint64_t tx_all_frames;
+
+	/** 0x2D: TX control frames (0x8808, non-pause) */
+	uint64_t tx_ctrl_non_pause;
+
+	/** 0x2E-0x35: RX PFC frames per priority (0-7) */
+	uint64_t rx_pfc_class[DPNI_MAX_TC];
+
+	/** 0x36-0x3D: TX PFC frames per priority (0-7) */
+	uint64_t tx_pfc_class[DPNI_MAX_TC];
+};
+
 int dpni_get_mac_statistics(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_t token,
 			    uint64_t iova_cnt, uint64_t iova_values, uint32_t num_cnt);
 
-- 
2.43.0

