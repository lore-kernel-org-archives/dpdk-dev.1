Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6AEC79F9F
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 13:55:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B5C6542E96;
	Thu, 10 Sep 2026 15:52:55 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id B1A7D42E5E
 for <dev@dpdk.org>; Thu, 10 Sep 2026 15:52:43 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 917CE200023;
 Thu, 10 Sep 2026 15:52:43 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0979A200408;
 Thu, 10 Sep 2026 15:52:43 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 7EF0E18000B5;
 Thu, 10 Sep 2026 21:52:41 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>,
	Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v2 35/47] net/dpaa2: enhance xstat implementation
Date: Thu, 10 Sep 2026 19:21:46 +0530
Message-ID: <20260910135158.2181141-36-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910135158.2181141-1-prashant.gupta_3@nxp.com>
References: <20260903135353.3358303-1-prashant.gupta_3@nxp.com>
 <20260910135158.2181141-1-prashant.gupta_3@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

From: Gagandeep Singh <g.singh@nxp.com>

1) Adapt RTE xstat API to return proper length.
2) Alloc DMA buffer of mac xstat only once.
3) Get MAC counter via dpni only when this dpni is connected to DPMAC.
4) Get TC policer counter only when meter flow of TC is there.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 913 +++++++++++++++++--------------
 drivers/net/dpaa2/dpaa2_ethdev.h |  12 +-
 drivers/net/dpaa2/mc/fsl_dpni.h  | 259 +++++++--
 3 files changed, 738 insertions(+), 446 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 58b4cedee3..5e2011b911 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -26,6 +26,7 @@
 #include <dpaa2_hw_pvt.h>
 #include <dpaa2_hw_mempool.h>
 #include <dpaa2_hw_dpio.h>
+#include <fsl_dprc.h>
 #include <mc/fsl_dpmng.h>
 #include <mc/fsl_dpcon.h>
 #include "dpaa2_ethdev.h"
@@ -108,116 +109,268 @@ dpaa2_dist_size_is_supported(uint16_t n)
 int dpaa2_valid_dev;
 struct rte_mempool *dpaa2_tx_sg_pool;
 
-struct rte_dpaa2_xstats_name_off {
-	char name[RTE_ETH_XSTATS_NAME_SIZE];
-	uint8_t page_id; /* dpni statistics page id */
-	uint8_t stats_id; /* stats id in the given page */
+struct dpaa2_xstats_seq {
+	struct dpni_statistics_page_0 pg0;
+	struct dpni_statistics_page_1 pg1;
+	struct dpni_statistics_page_2 pg2;
+	struct dpni_statistics_page_3 pg3;
+	struct dpni_statistics_page_4 pg4;
+	struct dpni_statistics_page_5 pg5[MAX_TCS];
+	struct dpni_statistics_page_6 pg6;
+	struct dpni_dpmac_counters mac_cnt;
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
+#define DPAA2_XSTAT_MAX_NUM \
+	(sizeof(struct dpaa2_xstats_seq) / sizeof(uint64_t))
+
+#define DPAA2_DPNI_XSTAT_MAX_NUM \
+	(offsetof(struct dpaa2_xstats_seq, mac_cnt) / sizeof(uint64_t))
+
+#define DPAA2_MAC_XSTAT_MAX_NUM DPAA2_MAC_NUM_STATS
+
+static_assert((DPAA2_DPNI_XSTAT_MAX_NUM + DPAA2_MAC_XSTAT_MAX_NUM) ==
+	DPAA2_XSTAT_MAX_NUM, "DPNI and MAC xstats do not sum to total");
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
+
+static inline int
+dpaa2_xstats_id_parse(uint32_t id, uint8_t *page,
+	uint8_t *stat_id, uint16_t *param, uint16_t *size)
+{
+	uint8_t _page = DPNI_INGRESS_STATISTICS_PAGE_ID, _stat_id = 0;
+	uint16_t _param = 0, _size = 0;
+
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
+#define DPAA2_XSTAT_ID(field) \
+	(offsetof(struct dpaa2_xstats_seq, field) / sizeof(uint64_t))
+
+#define DPAA2_XSTAT_STR_SET(pg, field) \
+	[DPAA2_XSTAT_ID(pg.field)] = RTE_STR(field)
+
+#define DPAA2_XSTAT_TC_STR_SET(pg, tc, field) \
+	[DPAA2_XSTAT_ID(pg[tc].field)] = "TC" RTE_STR(tc)"_" RTE_STR(field)
+
+#define DPAA2_XSTAT_TC_COLOR_STR_SET(pg, tc) \
+	DPAA2_XSTAT_TC_STR_SET(pg, tc, policer_cnt_red), \
+	DPAA2_XSTAT_TC_STR_SET(pg, tc, policer_cnt_yellow), \
+	DPAA2_XSTAT_TC_STR_SET(pg, tc, policer_cnt_green), \
+	DPAA2_XSTAT_TC_STR_SET(pg, tc, policer_cnt_re_red), \
+	DPAA2_XSTAT_TC_STR_SET(pg, tc, policer_cnt_re_yellow)
+
+#define DPAA2_MAC_XSTAT_STR_SET(name) \
+	[DPAA2_XSTAT_ID(mac_cnt.name)] = "mac_" RTE_STR(name)
+
+#define DPAA2_MAC_XSTAT_PFC_STR_SET(dir, tc) \
+	[DPAA2_XSTAT_ID(mac_cnt.dir##_pfc_class[tc])] = \
+		"mac_" RTE_STR(dir) "_pfc_class_" RTE_STR(tc)
+
+static const char * const
+dpaa2_xstats_strings[DPAA2_XSTAT_MAX_NUM] = {
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
+	DPAA2_MAC_XSTAT_STR_SET(rx_64_bytes),
+	DPAA2_MAC_XSTAT_STR_SET(rx_65_127_bytes),
+	DPAA2_MAC_XSTAT_STR_SET(rx_128_255_bytes),
+	DPAA2_MAC_XSTAT_STR_SET(rx_256_511_bytes),
+	DPAA2_MAC_XSTAT_STR_SET(rx_512_1023_bytes),
+	DPAA2_MAC_XSTAT_STR_SET(rx_1024_1518_bytes),
+	DPAA2_MAC_XSTAT_STR_SET(rx_1519_max_bytes),
+
+	DPAA2_MAC_XSTAT_STR_SET(rx_fragments),
+	DPAA2_MAC_XSTAT_STR_SET(rx_jabber),
+	DPAA2_MAC_XSTAT_STR_SET(rx_drop_fifo),
+	DPAA2_MAC_XSTAT_STR_SET(rx_alignment_error),
+
+	DPAA2_MAC_XSTAT_STR_SET(tx_undersize_good),
+	DPAA2_MAC_XSTAT_STR_SET(rx_oversize_good),
+
+	DPAA2_MAC_XSTAT_STR_SET(rx_pause),
+	DPAA2_MAC_XSTAT_STR_SET(tx_pause),
+
+	DPAA2_MAC_XSTAT_STR_SET(rx_good_bytes),
+	DPAA2_MAC_XSTAT_STR_SET(rx_multicast),
+	DPAA2_MAC_XSTAT_STR_SET(rx_broadcast),
+	DPAA2_MAC_XSTAT_STR_SET(rx_all_frames),
+	DPAA2_MAC_XSTAT_STR_SET(rx_unicast),
+	DPAA2_MAC_XSTAT_STR_SET(rx_error),
+
+	DPAA2_MAC_XSTAT_STR_SET(tx_good_bytes),
+	DPAA2_MAC_XSTAT_STR_SET(tx_multicast),
+	DPAA2_MAC_XSTAT_STR_SET(tx_broadcast),
+	DPAA2_MAC_XSTAT_STR_SET(tx_unicast),
+	DPAA2_MAC_XSTAT_STR_SET(tx_error),
+
+	DPAA2_MAC_XSTAT_STR_SET(rx_valid_frames),
+	DPAA2_MAC_XSTAT_STR_SET(tx_valid_frames),
+
+	DPAA2_MAC_XSTAT_STR_SET(tx_64_bytes),
+	DPAA2_MAC_XSTAT_STR_SET(tx_65_127_bytes),
+	DPAA2_MAC_XSTAT_STR_SET(tx_128_255_bytes),
+	DPAA2_MAC_XSTAT_STR_SET(tx_256_511_bytes),
+	DPAA2_MAC_XSTAT_STR_SET(tx_512_1023_bytes),
+	DPAA2_MAC_XSTAT_STR_SET(tx_1024_1518_bytes),
+	DPAA2_MAC_XSTAT_STR_SET(tx_1519_max_bytes),
+
+	DPAA2_MAC_XSTAT_STR_SET(rx_bytes_all),
+	DPAA2_MAC_XSTAT_STR_SET(rx_crc_error),
+	DPAA2_MAC_XSTAT_STR_SET(rx_vlan),
+	DPAA2_MAC_XSTAT_STR_SET(rx_undersize_good),
+	DPAA2_MAC_XSTAT_STR_SET(rx_ctrl_non_pause),
+	DPAA2_MAC_XSTAT_STR_SET(rx_drop_full),
+
+	DPAA2_MAC_XSTAT_STR_SET(tx_bytes_all),
+	DPAA2_MAC_XSTAT_STR_SET(tx_crc_error),
+	DPAA2_MAC_XSTAT_STR_SET(tx_vlan),
+	DPAA2_MAC_XSTAT_STR_SET(tx_all_frames),
+	DPAA2_MAC_XSTAT_STR_SET(tx_ctrl_non_pause),
+
+	DPAA2_MAC_XSTAT_PFC_STR_SET(rx, 0),
+	DPAA2_MAC_XSTAT_PFC_STR_SET(rx, 1),
+	DPAA2_MAC_XSTAT_PFC_STR_SET(rx, 2),
+	DPAA2_MAC_XSTAT_PFC_STR_SET(rx, 3),
+	DPAA2_MAC_XSTAT_PFC_STR_SET(rx, 4),
+	DPAA2_MAC_XSTAT_PFC_STR_SET(rx, 5),
+	DPAA2_MAC_XSTAT_PFC_STR_SET(rx, 6),
+	DPAA2_MAC_XSTAT_PFC_STR_SET(rx, 7),
+
+	DPAA2_MAC_XSTAT_PFC_STR_SET(tx, 0),
+	DPAA2_MAC_XSTAT_PFC_STR_SET(tx, 1),
+	DPAA2_MAC_XSTAT_PFC_STR_SET(tx, 2),
+	DPAA2_MAC_XSTAT_PFC_STR_SET(tx, 3),
+	DPAA2_MAC_XSTAT_PFC_STR_SET(tx, 4),
+	DPAA2_MAC_XSTAT_PFC_STR_SET(tx, 5),
+	DPAA2_MAC_XSTAT_PFC_STR_SET(tx, 6),
+	DPAA2_MAC_XSTAT_PFC_STR_SET(tx, 7)
 };
 
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
+};
+
+#define DPAA2_STATS_XSTATS_NUM \
+	(sizeof(dpaa2_stats_xstat_ids) / sizeof(uint64_t))
+
+#define DPAA2_MAC_XSTATS_START_ID DPAA2_DPNI_XSTAT_MAX_NUM
+
+
 static struct rte_dpaa2_driver rte_dpaa2_pmd;
 static int dpaa2_dev_link_update(struct rte_eth_dev *dev,
 				 int wait_to_complete);
@@ -1892,127 +2045,47 @@ dpaa2_dev_set_mac_addr(struct rte_eth_dev *dev,
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
-
-	if (!dpni) {
-		DPAA2_PMD_ERR("dpni is NULL");
-		return -EINVAL;
-	}
-
-	if (!stats) {
-		DPAA2_PMD_ERR("stats is NULL");
-		return -EINVAL;
-	}
-
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
-	/* Fill in per queue stats */
-	if (qstats != NULL) {
-		for (i = 0; (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) &&
-			(i < priv->nb_rx_queues || i < priv->nb_tx_queues); ++i) {
-			dpaa2_rxq = priv->rx_vq[i];
-			dpaa2_txq = priv->tx_vq[i];
-			if (dpaa2_rxq)
-				qstats->q_ipackets[i] = dpaa2_rxq->rx_pkts;
-			if (dpaa2_txq)
-				qstats->q_opackets[i] = dpaa2_txq->tx_pkts;
+	int ret = 0;
 
-			/* Byte counting is not implemented */
-			qstats->q_ibytes[i]   = 0;
-			qstats->q_obytes[i]   = 0;
+	if (!priv->cnt_idx_dma_mem) {
+		priv->cnt_idx_dma_mem = rte_zmalloc(NULL,
+			DPAA2_MAC_STATS_INDEX_DMA_SIZE, RTE_CACHE_LINE_SIZE);
+		if (!priv->cnt_idx_dma_mem) {
+			ret = -ENOMEM;
+			DPAA2_PMD_ERR("Failure to allocate memory for mac index");
+			goto out;
 		}
-	}
 
-	return 0;
-
-err:
-	DPAA2_PMD_ERR("Operation not completed:Error Code = %d", retcode);
-	return retcode;
-};
-
-void
-dpaa2_dev_mac_setup_stats(struct rte_eth_dev *dev)
-{
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	uint32_t *cnt_idx;
-	int i;
-
-	priv->cnt_idx_dma_mem = rte_malloc(NULL, DPAA2_MAC_STATS_INDEX_DMA_SIZE,
-					   RTE_CACHE_LINE_SIZE);
-	if (!priv->cnt_idx_dma_mem) {
-		DPAA2_PMD_ERR("Failure to allocate memory for mac index");
-		goto out;
+		priv->cnt_idx_iova = rte_mem_virt2iova(priv->cnt_idx_dma_mem);
+		if (priv->cnt_idx_iova == RTE_BAD_IOVA) {
+			ret = -ENOBUFS;
+			DPAA2_PMD_ERR("%s: No IOMMU map for count index dma mem(%p)",
+				__func__, priv->cnt_idx_dma_mem);
+			goto err_dma_map;
+		}
 	}
 
-	priv->cnt_values_dma_mem = rte_malloc(NULL, DPAA2_MAC_STATS_VALUE_DMA_SIZE,
-					      RTE_CACHE_LINE_SIZE);
 	if (!priv->cnt_values_dma_mem) {
-		DPAA2_PMD_ERR("Failure to allocate memory for mac values");
-		goto err_alloc_values;
-	}
-
-	cnt_idx = priv->cnt_idx_dma_mem;
-	for (i = 0; i < DPAA2_MAC_NUM_STATS; i++)
-		*cnt_idx++ = rte_cpu_to_le_32((uint32_t)i);
-
-	priv->cnt_idx_iova = rte_mem_virt2iova(priv->cnt_idx_dma_mem);
-	if (priv->cnt_idx_iova == RTE_BAD_IOVA) {
-		DPAA2_PMD_ERR("%s: No IOMMU map for count index dma mem(%p)",
-			__func__, priv->cnt_idx_dma_mem);
-		goto err_dma_map;
-	}
-
-	priv->cnt_values_iova = rte_mem_virt2iova(priv->cnt_values_dma_mem);
-	if (priv->cnt_values_iova == RTE_BAD_IOVA) {
-		DPAA2_PMD_ERR("%s: No IOMMU map for count values dma mem(%p)",
-			__func__, priv->cnt_values_dma_mem);
-		goto err_dma_map;
+		priv->cnt_values_dma_mem = rte_zmalloc(NULL,
+			DPAA2_MAC_STATS_VALUE_DMA_SIZE, RTE_CACHE_LINE_SIZE);
+		if (!priv->cnt_values_dma_mem) {
+			ret = -ENOMEM;
+			DPAA2_PMD_ERR("Failure to allocate memory for mac values");
+			goto err_alloc_values;
+		}
+		priv->cnt_values_iova = rte_mem_virt2iova(priv->cnt_values_dma_mem);
+		if (priv->cnt_values_iova == RTE_BAD_IOVA) {
+			ret = -ENOBUFS;
+			DPAA2_PMD_ERR("%s: No IOMMU map for count values dma mem(%p)",
+				__func__, priv->cnt_values_dma_mem);
+			goto err_dma_map;
+		}
 	}
 
-	return;
+	return 0;
 
 err_dma_map:
 	rte_free(priv->cnt_values_dma_mem);
@@ -2021,222 +2094,279 @@ dpaa2_dev_mac_setup_stats(struct rte_eth_dev *dev)
 out:
 	priv->cnt_idx_dma_mem = NULL;
 	priv->cnt_values_dma_mem = NULL;
+
+	return ret;
 }
 
-/*
- * dpaa2_dev_xstats_get(): Get counters of dpni and dpmac.
- * MAC (mac_*) counters are supported on MC version > 10.39.0
- * TC_x_policer_* counters are supported only when Policer is enable.
- */
 static int
-dpaa2_dev_xstats_get(struct rte_eth_dev *dev,
-	struct rte_eth_xstat *xstats, unsigned int n)
+dpaa2_dev_mac_xstats_avail(struct rte_eth_dev *dev)
 {
-	struct fsl_mc_io *dpni = (struct fsl_mc_io *)dev->process_private;
-	unsigned int i = 0, j = 0, num = RTE_DIM(dpaa2_xstats_strings);
 	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	union dpni_statistics value[13] = {};
-	struct dpni_rx_tc_policing_cfg cfg;
-	uint8_t page_id, stats_id;
-	uint64_t *cnt_values;
-	int32_t retcode;
-	int16_t tc;
-
-	if (n < num)
-		return num;
-
-	if (!xstats)
-		return 0;
-
-	/* Get Counters from page_0*/
-	retcode = dpni_get_statistics(dpni, CMD_PRI_LOW, priv->token,
-				      0, 0, &value[0]);
-	if (retcode)
-		goto err;
+	uint64_t rev_mac_support;
 
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
-		}
-	}
+	if (priv->ep_dev_type != DPAA2_MAC)
+		return false;
 
-	for (tc = 0; tc < priv->num_rx_tc; tc++) {
-		retcode = dpni_get_rx_tc_policing(dpni, CMD_PRI_LOW,
-						  priv->token, tc,
-						  &cfg);
-		if (retcode) {
-			DPAA2_PMD_ERR("Error to get the policer rule: %d", retcode);
-			goto err;
-		}
+	rev_mac_support = RTE_FSL_MC_REV(MC_VER_MAJOR, MC_VER_MINOR, 0);
+	if (priv->mc_rev >= rev_mac_support)
+		return true;
 
-		/* get policer stats if policer is enabled */
-		if (cfg.mode != 0) {
-			/* Get Counters from page_5*/
-			retcode = dpni_get_statistics(dpni, CMD_PRI_LOW,
-						      priv->token, 5, tc,
-						      &value[(tc + 5)]);
-			if (retcode)
-				goto err;
-		}
-	}
+	return false;
+}
 
-	while (i < (num - DPAA2_MAC_NUM_STATS)) {
-		xstats[i].id = i;
-		page_id = dpaa2_xstats_strings[i].page_id;
-		stats_id = dpaa2_xstats_strings[i].stats_id;
-		xstats[i].value = value[page_id].raw.counter[stats_id];
-		i++;
-	}
+static int
+dpaa2_dev_dpni_xstats_avail(struct rte_eth_dev *dev,
+	uint8_t page_id, uint16_t param)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	uint8_t tc, i;
 
-	if (priv->cnt_idx_dma_mem &&
-	    !dpni_get_mac_statistics(dpni, CMD_PRI_LOW, priv->token,
-				    priv->cnt_idx_iova,
-				    priv->cnt_values_iova,
-				    DPAA2_MAC_NUM_STATS)) {
-		cnt_values = priv->cnt_values_dma_mem;
-		while (i >= (num - DPAA2_MAC_NUM_STATS) && i < num) {
-			xstats[i].id = i;
-			xstats[i].value = rte_le_to_cpu_64(*cnt_values++);
-			i++;
+	if (page_id == DPNI_CGR_STATISTICS_PAGE_ID) {
+		for (i = 0; i < priv->max_cgs; i++) {
+			if (priv->cgid_in_use[i])
+				return true;
 		}
-		return i;
-	}
-
-	while (i >= (num - DPAA2_MAC_NUM_STATS) && i < num) {
-		xstats[i].id = i;
-		xstats[i].value = 0;
-		i++;
+	} else if (page_id == DPNI_POLICER_STATISTICS_PAGE_ID) {
+		tc = param;
+		if (tc < MAX_TCS)
+			return true;
+	} else {
+		return true;
 	}
 
-	return i;
-err:
-	DPAA2_PMD_ERR("Error in obtaining extended stats (%d)", retcode);
-	return retcode;
+	return false;
 }
 
 static int
-dpaa2_xstats_get_names(__rte_unused struct rte_eth_dev *dev,
-	struct rte_eth_xstat_name *xstats_names,
-	unsigned int limit)
+dpaa2_dev_xstats_get_names(struct rte_eth_dev *dev,
+	struct rte_eth_xstat_name *xstats_names, uint32_t limit)
 {
-	unsigned int i, stat_cnt = RTE_DIM(dpaa2_xstats_strings);
+	uint16_t i, stat_cnt;
+
+	stat_cnt = DPAA2_DPNI_XSTAT_MAX_NUM;
+	if (dpaa2_dev_mac_xstats_avail(dev))
+		stat_cnt += DPAA2_MAC_XSTAT_MAX_NUM;
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
+	for (i = 0; i < stat_cnt; i++)
+		rte_strscpy(xstats_names[i].name, dpaa2_xstats_strings[i],
+			RTE_ETH_XSTATS_NAME_SIZE);
 
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
+	uint16_t i, id, stat_cnt, mac_num = 0;
+	uint8_t page_id, stat_id;
+	uint16_t param;
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct fsl_mc_io *dpni = dev->process_private;
+	bool page_fetched[DPNI_MAX_STATISTICS_PAGE_ID][DPNI_STAT_MAX_PARAM];
+	/* Fetch required MAC counters in a single MC command. */
+	int retcode;
+	uint32_t *mac_idx;
+	uint64_t *mac_val[DPAA2_MAC_XSTAT_MAX_NUM];
 
-	if (!ids) {
-		struct dpaa2_dev_priv *priv = dev->data->dev_private;
-		struct fsl_mc_io *dpni = dev->process_private;
-		int32_t retcode;
-		union dpni_statistics value[5] = {};
+	retcode = dpaa2_dev_xstat_mac_setup_mem(dev);
+	if (retcode) {
+		DPAA2_PMD_ERR("%s: Failed(%d) to setup %s's MAC statistics!",
+			__func__, retcode, dev->data->name);
+		return retcode;
+	}
+	mac_idx = priv->cnt_idx_dma_mem;
 
-		if (n < stat_cnt)
-			return stat_cnt;
+	stat_cnt = DPAA2_DPNI_XSTAT_MAX_NUM;
+	if (dpaa2_dev_mac_xstats_avail(dev))
+		stat_cnt += DPAA2_MAC_XSTAT_MAX_NUM;
 
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
+			values[i] = 0;
+			/* ids[] is supplied by the application and may repeat
+			 * the same MAC id, so bound the collection against the
+			 * mac_idx[]/mac_val[] and DMA buffer capacity.
+			 */
+			if (dpaa2_dev_mac_xstats_avail(dev) &&
+				mac_num < DPAA2_MAC_XSTAT_MAX_NUM) {
+				mac_idx[mac_num] = rte_cpu_to_le_32(id - DPAA2_MAC_XSTATS_START_ID);
+				mac_val[mac_num] = &values[i];
+				mac_num++;
+			}
+			continue;
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
+		if (page_fetched[page_id][param]) {
+			values[i] = priv->pg_xstats[page_id][param].raw.counter[stat_id];
+			continue;
+		}
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
 
-		/* Get Counters from page_1*/
-		retcode = dpni_get_statistics(dpni, CMD_PRI_LOW, priv->token,
-					      1, 0, &value[1]);
-		if (retcode)
-			return 0;
+	if (mac_num > 0) {
+		retcode = dpni_get_mac_statistics(dpni, CMD_PRI_LOW,
+			priv->token, priv->cnt_idx_iova,
+			priv->cnt_values_iova, mac_num);
+		if (retcode) {
+			DPAA2_PMD_ERR("%s: Failed(%d) to get %s's %d MAC statistics!",
+				__func__, retcode, dev->data->name, mac_num);
+			return retcode;
+		}
+		for (i = 0; i < mac_num; i++)
+			*mac_val[i] = priv->cnt_values_dma_mem[i];
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
+	uint16_t i, stat_cnt;
 
-		for (i = 0; i < stat_cnt; i++) {
-			page_id = dpaa2_xstats_strings[i].page_id;
-			stats_id = dpaa2_xstats_strings[i].stats_id;
-			values[i] = value[page_id].raw.counter[stats_id];
-		}
-		return stat_cnt;
-	}
+	stat_cnt = DPAA2_DPNI_XSTAT_MAX_NUM;
+	if (dpaa2_dev_mac_xstats_avail(dev))
+		stat_cnt += DPAA2_MAC_XSTAT_MAX_NUM;
 
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
+		rte_strscpy(xstats_names[i].name,
+			dpaa2_xstats_strings[ids[i]],
+			RTE_ETH_XSTATS_NAME_SIZE);
 	}
-	return n;
+	return limit;
 }
 
+/*
+ * dpaa2_dev_xstats_get(): Get counters of dpni and dpmac.
+ * MAC (mac_*) counters are supported on MC version > 10.39.0
+ * TC_x_policer_* counters are supported only when Policer is enable.
+ */
 static int
-dpaa2_xstats_get_names_by_id(struct rte_eth_dev *dev,
-	const uint64_t *ids,
-	struct rte_eth_xstat_name *xstats_names,
-	unsigned int limit)
+dpaa2_dev_xstats_get(struct rte_eth_dev *dev,
+	struct rte_eth_xstat *xstats, uint32_t n)
 {
-	unsigned int i, stat_cnt = RTE_DIM(dpaa2_xstats_strings);
-	struct rte_eth_xstat_name xstats_names_copy[stat_cnt];
+	int retcode;
+	uint32_t i;
+	uint64_t ids[DPAA2_XSTAT_MAX_NUM], vals[DPAA2_XSTAT_MAX_NUM];
 
-	if (!ids)
-		return dpaa2_xstats_get_names(dev, xstats_names, limit);
+	if (!xstats || !n)
+		return 0;
+
+	if (n > DPAA2_XSTAT_MAX_NUM) {
+		DPAA2_PMD_WARN("%s: Expected xstat number(%d) > max(%ld)",
+			__func__, n, DPAA2_XSTAT_MAX_NUM);
+		n = DPAA2_XSTAT_MAX_NUM;
+	}
+	for (i = 0; i < n; i++) {
+		ids[i] = i;
+		xstats[i].id = i;
+		xstats[i].value = 0;
+	}
 
-	dpaa2_xstats_get_names(dev, xstats_names_copy, limit);
+	retcode = dpaa2_dev_xstats_get_by_id(dev, ids, vals, n);
+	if (retcode < 0)
+		return retcode;
 
-	for (i = 0; i < limit; i++) {
-		if (ids[i] >= stat_cnt) {
-			DPAA2_PMD_ERR("xstats id value isn't valid");
-			return -1;
+	for (i = 0; i < (uint32_t)retcode; i++)
+		xstats[i].value = vals[i];
+
+	return retcode;
+}
+
+static int
+dpaa2_dev_stats_get(struct rte_eth_dev *dev,
+	struct rte_eth_stats *stats, struct eth_queue_stats *qstats)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	int32_t retcode;
+	uint16_t i, num;
+	uint64_t ids[DPAA2_STATS_XSTATS_NUM], counts[DPAA2_STATS_XSTATS_NUM] = {0};
+	struct dpaa2_queue *dpaa2_q;
+
+	PMD_INIT_FUNC_TRACE();
+
+	rte_memcpy(ids, &dpaa2_stats_xstat_ids, sizeof(dpaa2_stats_xstat_ids));
+	retcode = dpaa2_dev_xstats_get_by_id(dev, ids, counts, DPAA2_STATS_XSTATS_NUM);
+	if (retcode != RTE_DIM(ids)) {
+		DPAA2_PMD_ERR("%s: Failed to get xstats (%d)counters by %ld IDs",
+			__func__, retcode, DPAA2_STATS_XSTATS_NUM);
+		if (retcode >= 0)
+			retcode = -EINVAL;
+		return retcode;
+	}
+
+	rte_memcpy(stats, counts, sizeof(struct rte_eth_stats));
+	stats->imissed += stats->ierrors + stats->rx_nombuf;
+
+	if (qstats) {
+		/* Fill in per queue stats */
+		num = RTE_MIN(priv->nb_rx_queues, RTE_ETHDEV_QUEUE_STAT_CNTRS);
+		for (i = 0; i < num; i++) {
+			dpaa2_q = priv->rx_vq[i];
+			qstats->q_ipackets[i] = dpaa2_q->rx_pkts;
+
+			/* Byte counting is not implemented */
+			qstats->q_ibytes[i] = 0;
+		}
+		num = RTE_MIN(priv->nb_tx_queues, RTE_ETHDEV_QUEUE_STAT_CNTRS);
+		for (i = 0; i < num; i++) {
+			dpaa2_q = priv->tx_vq[i];
+			qstats->q_opackets[i] = dpaa2_q->tx_pkts;
+
+			/* Byte counting is not implemented */
+			qstats->q_obytes[i] = 0;
 		}
-		strcpy(xstats_names[i].name, xstats_names_copy[ids[i]].name);
 	}
-	return limit;
+
+	return 0;
 }
 
 static int
@@ -2255,7 +2385,7 @@ dpaa2_dev_stats_reset(struct rte_eth_dev *dev)
 		return -EINVAL;
 	}
 
-	retcode =  dpni_reset_statistics(dpni, CMD_PRI_LOW, priv->token);
+	retcode = dpni_reset_statistics(dpni, CMD_PRI_LOW, priv->token);
 	if (retcode)
 		goto error;
 
@@ -3262,9 +3392,9 @@ static struct eth_dev_ops dpaa2_ethdev_ops = {
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
@@ -3719,17 +3849,6 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 
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
index 33195f0584..a76e7f9287 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -205,7 +205,8 @@
 	(DPAA2_PKT_TYPE_VLAN_1 | DPAA2_PKT_TYPE_VLAN_2)
 
 /* mac counters */
-#define DPAA2_MAC_NUM_STATS            (DPMAC_CNT_EGR_CONTROL_FRAME + 1)
+#define DPAA2_MAC_NUM_STATS \
+	(sizeof(struct dpni_dpmac_counters) / sizeof(uint64_t))
 #define DPAA2_MAC_STATS_INDEX_DMA_SIZE (DPAA2_MAC_NUM_STATS * sizeof(uint32_t))
 #define DPAA2_MAC_STATS_VALUE_DMA_SIZE (DPAA2_MAC_NUM_STATS * sizeof(uint64_t))
 
@@ -542,6 +543,12 @@ struct dpaa2_dev_priv {
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
 	LIST_HEAD(, dpaa2_dev_meter_profile) profiles;
@@ -703,7 +710,4 @@ dpaa2_eth_sg_fd_to_mbuf(struct dpaa2_dev_priv *priv, const struct qbman_fd *fd);
 int dpaa2_mtr_ops_get(struct rte_eth_dev *dev, void *ops);
 int dpaa2_soft_parser_loaded(void);
 
-void
-dpaa2_dev_mac_setup_stats(struct rte_eth_dev *dev);
-
 #endif /* _DPAA2_ETHDEV_H */
diff --git a/drivers/net/dpaa2/mc/fsl_dpni.h b/drivers/net/dpaa2/mc/fsl_dpni.h
index f315bb7004..bc895234f1 100644
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
@@ -2147,9 +2174,151 @@ int dpni_set_sp_profile(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_t to
 int dpni_sp_enable(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_t token,
 		uint8_t type, uint8_t en);
 
-int dpni_get_mac_statistics(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_t token,
-			    uint64_t iova_cnt, uint64_t iova_values, uint32_t num_cnt);
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
 int dpni_get_mac_statistics(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_t token,
 			    uint64_t iova_cnt, uint64_t iova_values, uint32_t num_cnt);
 
-- 
2.43.0

