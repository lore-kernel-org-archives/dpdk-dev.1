Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C43FC79FB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 13:54:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1062642E6A;
	Thu, 10 Sep 2026 15:52:45 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 5564042E46
 for <dev@dpdk.org>; Thu, 10 Sep 2026 15:52:34 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 301461A0452;
 Thu, 10 Sep 2026 15:52:34 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EE6E81A0447;
 Thu, 10 Sep 2026 15:52:33 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id DBFD918000B7;
 Thu, 10 Sep 2026 21:52:32 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v2 27/47] drivers: identify dpaa2 soft parser protocol
Date: Thu, 10 Sep 2026 19:21:38 +0530
Message-ID: <20260910135158.2181141-28-prashant.gupta_3@nxp.com>
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

From: Jun Yang <jun.yang@nxp.com>

Identify if soft parser protocol firmware is loaded by checking
firmware magic number.
Enable flow/parser of ECPRI, GENEVE, ROCEv2 and VXLAN's spec
only with soft parser protocol firmware being loaded.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/fslmc/fslmc_bus.c    |  83 +++++++++++++++++++-
 drivers/net/dpaa2/dpaa2_ethdev.c |   2 +
 drivers/net/dpaa2/dpaa2_flow.c   | 129 ++++++++-----------------------
 drivers/net/dpaa2/dpaa2_rxtx.c   |  10 +++
 4 files changed, 126 insertions(+), 98 deletions(-)

diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index 2427421075..9742b0bfbf 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
- *   Copyright 2016,2018-2021 NXP
+ *   Copyright 2016,2018-2026 NXP
  *
  */
 
@@ -8,6 +8,7 @@
 #include <dirent.h>
 #include <stdalign.h>
 #include <stdbool.h>
+#include <sys/mman.h>
 
 #include <eal_export.h>
 #include <rte_log.h>
@@ -35,6 +36,85 @@ struct rte_fslmc_bus_info fslmc_bus_info;
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_seqn_dynfield_offset)
 int dpaa2_seqn_dynfield_offset = -1;
 
+/** For LX2160A, LS2088A and LS1088A*/
+#define WRIOP_CCSR_BASE 0x8b80000
+#define WRIOP_CCSR_CTLU_OFFSET 0
+#define WRIOP_CCSR_CTLU_PARSER_OFFSET 0
+#define WRIOP_CCSR_CTLU_PARSER_INGRESS_OFFSET 0
+
+#define WRIOP_INGRESS_PARSER_PHY \
+	(WRIOP_CCSR_BASE + WRIOP_CCSR_CTLU_OFFSET + \
+	WRIOP_CCSR_CTLU_PARSER_OFFSET + \
+	WRIOP_CCSR_CTLU_PARSER_INGRESS_OFFSET)
+
+struct __rte_packed_begin dpaa2_parser_ccsr {
+	uint32_t psr_cfg;
+	uint32_t psr_idle;
+	uint32_t psr_pclm;
+	uint8_t psr_ver_min;
+	uint8_t psr_ver_maj;
+	uint8_t psr_id1_l;
+	uint8_t psr_id1_h;
+	uint32_t psr_rev2;
+	uint8_t rsv[0x2c];
+	uint8_t sp_ins[4032];
+} __rte_packed_end;
+
+#define SP_PROTOCOL_MAGIC_DATA 0xabcd
+#define SP_PROTOCOL_MAGIC_OFFSET 0x4
+
+static void
+fslmc_soft_parser_protocol_supported(void)
+{
+	int fd, i;
+	void *map_addr = NULL;
+	const struct dpaa2_parser_ccsr *parser_ccsr = NULL;
+	const uint16_t *magic_num;
+
+	fd = open("/dev/mem", O_RDWR | O_SYNC);
+	if (fd < 0) {
+		DPAA2_BUS_ERR("open \"/dev/mem\" ERROR(%d)", fd);
+		goto exit;
+	}
+
+	map_addr = mmap(NULL, sizeof(struct dpaa2_parser_ccsr),
+		PROT_READ | PROT_WRITE, MAP_SHARED, fd,
+		WRIOP_INGRESS_PARSER_PHY);
+	parser_ccsr = map_addr;
+	if (!parser_ccsr) {
+		DPAA2_BUS_ERR("Map 0x%lx(size=0x%lx) failed",
+			(uint64_t)WRIOP_INGRESS_PARSER_PHY,
+			sizeof(struct dpaa2_parser_ccsr));
+		goto exit;
+	}
+
+	DPAA2_BUS_DEBUG("Soft ParserID:0x%02x%02x, Rev:maj(%02x), min(%02x)",
+		parser_ccsr->psr_id1_h, parser_ccsr->psr_id1_l,
+		parser_ccsr->psr_ver_maj, parser_ccsr->psr_ver_min);
+
+	magic_num = (const void *)&parser_ccsr->sp_ins[SP_PROTOCOL_MAGIC_OFFSET];
+	if (*magic_num == SP_PROTOCOL_MAGIC_DATA) {
+		#define SP_PRINT_LEN 128
+
+		fslmc_bus_info.sp_protocol = true;
+		DPAA2_BUS_INFO("Soft parser protocol support.");
+		fprintf(rte_log_get_stream(), "First %d bytes of sp protocol firmware:\r\n",
+			SP_PRINT_LEN);
+		for (i = 0; i < SP_PRINT_LEN; i++) {
+			fprintf(rte_log_get_stream(), "%02x ", parser_ccsr->sp_ins[i]);
+			if ((i + 1) % 16 == 0)
+				fprintf(rte_log_get_stream(), "\r\n");
+		}
+		fprintf(rte_log_get_stream(), "\r\n");
+	}
+
+exit:
+	if (map_addr)
+		munmap(map_addr, sizeof(struct dpaa2_parser_ccsr));
+	if (fd >= 0)
+		close(fd);
+}
+
 RTE_EXPORT_INTERNAL_SYMBOL(rte_fslmc_get_device_count)
 uint32_t
 rte_fslmc_get_device_count(enum rte_dpaa2_dev_type device_type)
@@ -345,6 +425,7 @@ rte_fslmc_scan(void)
 		DPAA2_BUS_ERR("Unable to open VFIO group directory");
 		goto scan_fail;
 	}
+	fslmc_soft_parser_protocol_supported();
 
 	/* Scan the DPRC container object */
 	ret = scan_one_fslmc_device(group_name);
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index e6ce29b2ea..fb1d01e209 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -3735,6 +3735,8 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	}
 	eth_dev->data->mtu = RTE_ETHER_MTU;
 
+	priv->sp_protocol = dpaa2_dev->bus_info->sp_protocol;
+
 	DPAA2_PMD_INFO("%s: netdev created, connected to %s",
 		eth_dev->data->name, dpaa2_dev->ep_name);
 
diff --git a/drivers/net/dpaa2/dpaa2_flow.c b/drivers/net/dpaa2/dpaa2_flow.c
index 016a1e98b4..06ec1a2660 100644
--- a/drivers/net/dpaa2/dpaa2_flow.c
+++ b/drivers/net/dpaa2/dpaa2_flow.c
@@ -10,7 +10,6 @@
 #include <string.h>
 #include <unistd.h>
 #include <stdarg.h>
-#include <sys/mman.h>
 
 #include <rte_ethdev.h>
 #include <rte_log.h>
@@ -23,9 +22,9 @@
 
 #include <dpaa2_ethdev.h>
 #include <dpaa2_pmd_logs.h>
+#include "dpaa2_parser_decode.h"
 
 static char *dpaa2_flow_control_log;
-static int dpaa2_sp_loaded = -1;
 
 /* Default size of a key */
 #define DPNI_DEFAULT_KEY_SIZE 24
@@ -435,92 +434,6 @@ dpaa2_flow_fs_entry_log(const char *log_info,
 	DPAA2_FLOW_DUMP("\r\n");
 }
 
-/** For LX2160A, LS2088A and LS1088A*/
-#define WRIOP_CCSR_BASE 0x8b80000
-#define WRIOP_CCSR_CTLU_OFFSET 0
-#define WRIOP_CCSR_CTLU_PARSER_OFFSET 0
-#define WRIOP_CCSR_CTLU_PARSER_INGRESS_OFFSET 0
-
-#define WRIOP_INGRESS_PARSER_PHY \
-	(WRIOP_CCSR_BASE + WRIOP_CCSR_CTLU_OFFSET + \
-	WRIOP_CCSR_CTLU_PARSER_OFFSET + \
-	WRIOP_CCSR_CTLU_PARSER_INGRESS_OFFSET)
-
-struct dpaa2_parser_ccsr {
-	uint32_t psr_cfg;
-	uint32_t psr_idle;
-	uint32_t psr_pclm;
-	uint8_t psr_ver_min;
-	uint8_t psr_ver_maj;
-	uint8_t psr_id1_l;
-	uint8_t psr_id1_h;
-	uint32_t psr_rev2;
-	uint8_t rsv[0x2c];
-	uint8_t sp_ins[4032];
-};
-
-int
-dpaa2_soft_parser_loaded(void)
-{
-	int fd, i, ret = 0;
-	struct dpaa2_parser_ccsr *parser_ccsr = NULL;
-
-	dpaa2_flow_control_log = getenv("DPAA2_FLOW_CONTROL_LOG");
-
-	if (dpaa2_sp_loaded >= 0)
-		return dpaa2_sp_loaded;
-
-	fd = open("/dev/mem", O_RDWR | O_SYNC);
-	if (fd < 0) {
-		DPAA2_PMD_ERR("open \"/dev/mem\" ERROR(%d)", fd);
-		ret = fd;
-		goto exit;
-	}
-
-	parser_ccsr = mmap(NULL, sizeof(struct dpaa2_parser_ccsr),
-		PROT_READ | PROT_WRITE, MAP_SHARED, fd,
-		WRIOP_INGRESS_PARSER_PHY);
-	if (!parser_ccsr) {
-		DPAA2_PMD_ERR("Map 0x%" PRIx64 "(size=0x%x) failed",
-			(uint64_t)WRIOP_INGRESS_PARSER_PHY,
-			(uint32_t)sizeof(struct dpaa2_parser_ccsr));
-		ret = -ENOBUFS;
-		goto exit;
-	}
-
-	DPAA2_PMD_INFO("Parser ID:0x%02x%02x, Rev:major(%02x), minor(%02x)",
-		parser_ccsr->psr_id1_h, parser_ccsr->psr_id1_l,
-		parser_ccsr->psr_ver_maj, parser_ccsr->psr_ver_min);
-
-	if (dpaa2_flow_control_log) {
-		for (i = 0; i < 64; i++) {
-			DPAA2_FLOW_DUMP("%02x ",
-				parser_ccsr->sp_ins[i]);
-			if (!((i + 1) % 16))
-				DPAA2_FLOW_DUMP("\r\n");
-		}
-	}
-
-	for (i = 0; i < 16; i++) {
-		if (parser_ccsr->sp_ins[i]) {
-			dpaa2_sp_loaded = 1;
-			break;
-		}
-	}
-	if (dpaa2_sp_loaded < 0)
-		dpaa2_sp_loaded = 0;
-
-	ret = dpaa2_sp_loaded;
-
-exit:
-	if (parser_ccsr)
-		munmap(parser_ccsr, sizeof(struct dpaa2_parser_ccsr));
-	if (fd >= 0)
-		close(fd);
-
-	return ret;
-}
-
 static int
 dpaa2_flow_ip_address_extract(enum net_prot prot,
 	uint32_t field)
@@ -3539,6 +3452,11 @@ dpaa2_configure_flow_gre(struct dpaa2_dev_flow *flow,
 		return 0;
 	}
 
+	if (!priv->sp_protocol) {
+		DPAA2_PMD_ERR("vXLAN flow with spec is not supported without SP.");
+		return -ENOTSUP;
+	}
+
 	ret = dpaa2_flow_extract_support((const uint8_t *)mask,
 		RTE_FLOW_ITEM_TYPE_GRE);
 	if (ret) {
@@ -3584,6 +3502,11 @@ dpaa2_configure_flow_vxlan(struct dpaa2_dev_flow *flow,
 	struct dpaa2_dev_priv *priv = dev->data->dev_private;
 	const struct rte_flow_item *pattern = &dpaa2_pattern->generic_item;
 
+	if (!priv->sp_protocol) {
+		DPAA2_PMD_ERR("eCPRI flow is not supported without SP.");
+		return -ENOTSUP;
+	}
+
 	group = attr->group;
 
 	/* Parse pattern list to get the matching parameters */
@@ -3682,6 +3605,11 @@ dpaa2_configure_flow_ecpri(struct dpaa2_dev_flow *flow,
 	uint8_t extract_size[DPAA2_ECPRI_MAX_EXTRACT_NB];
 	uint8_t extract_off[DPAA2_ECPRI_MAX_EXTRACT_NB];
 
+	if (!priv->sp_protocol) {
+		DPAA2_PMD_ERR("ROCEV2 flow is not supported without SP.");
+		return -ENOTSUP;
+	}
+
 	group = attr->group;
 
 	/* Parse pattern list to get the matching parameters */
@@ -4001,6 +3929,11 @@ dpaa2_configure_flow_gtp(struct dpaa2_dev_flow *flow,
 	const struct rte_flow_item *pattern =
 		&dpaa2_pattern->generic_item;
 
+	if (!priv->sp_protocol) {
+		DPAA2_PMD_ERR("GENEVE flow is not supported without SP.");
+		return -ENOTSUP;
+	}
+
 	group = attr->group;
 
 	/* Parse pattern list to get the matching parameters */
@@ -4726,7 +4659,7 @@ dpaa2_configure_qos_table(struct dpaa2_dev_priv *priv,
 
 static int
 dpaa2_flow_item_convert(const struct rte_flow_item pattern[],
-			struct rte_dpaa2_flow_item **dpaa2_pattern)
+	struct rte_dpaa2_flow_item **dpaa2_pattern, int sp_protocol)
 {
 	struct rte_dpaa2_flow_item *new_pattern;
 	int num = 0, tunnel_start = 0;
@@ -4738,7 +4671,7 @@ dpaa2_flow_item_convert(const struct rte_flow_item pattern[],
 	}
 
 	new_pattern = rte_malloc(NULL, sizeof(struct rte_dpaa2_flow_item) * num,
-				 RTE_CACHE_LINE_SIZE);
+			RTE_CACHE_LINE_SIZE);
 	if (!new_pattern) {
 		DPAA2_PMD_ERR("Failed to alloc %d flow items", num);
 		return -ENOMEM;
@@ -4746,13 +4679,13 @@ dpaa2_flow_item_convert(const struct rte_flow_item pattern[],
 
 	num = 0;
 	while (pattern[num].type != RTE_FLOW_ITEM_TYPE_END) {
-		memcpy(&new_pattern[num].generic_item, &pattern[num],
-		       sizeof(struct rte_flow_item));
+		rte_memcpy(&new_pattern[num].generic_item, &pattern[num],
+			sizeof(struct rte_flow_item));
 		new_pattern[num].in_tunnel = 0;
 
 		if (pattern[num].type == RTE_FLOW_ITEM_TYPE_VXLAN)
 			tunnel_start = 1;
-		else if (tunnel_start)
+		else if (tunnel_start && sp_protocol)
 			new_pattern[num].in_tunnel = 1;
 		num++;
 	}
@@ -4789,7 +4722,8 @@ dpaa2_generic_flow_set(struct dpaa2_dev_flow *flow,
 	if (ret)
 		return ret;
 
-	ret = dpaa2_flow_item_convert(pattern, &dpaa2_pattern);
+	ret = dpaa2_flow_item_convert(pattern, &dpaa2_pattern,
+		priv->sp_protocol);
 	if (ret)
 		return ret;
 
@@ -5130,7 +5064,8 @@ dpaa2_dev_verify_attr(struct dpni_attr *dpni_attr,
 }
 
 static inline int
-dpaa2_dev_verify_patterns(const struct rte_flow_item pattern[])
+dpaa2_dev_verify_patterns(const struct rte_flow_item pattern[],
+	int sp_support)
 {
 	unsigned int i, j, is_found = 0;
 	int ret = 0;
@@ -5154,7 +5089,7 @@ dpaa2_dev_verify_patterns(const struct rte_flow_item pattern[])
 		}
 		if (is_found)
 			continue;
-		if (dpaa2_sp_loaded > 0) {
+		if (sp_support) {
 			for (i = 0; i < sp_supported_num; i++) {
 				if (sp_supported[i] == pattern[j].type) {
 					is_found = 1;
@@ -5233,7 +5168,7 @@ dpaa2_flow_validate(struct rte_eth_dev *dev,
 		goto not_valid_params;
 	}
 	/* Verify input pattern list */
-	ret = dpaa2_dev_verify_patterns(pattern);
+	ret = dpaa2_dev_verify_patterns(pattern, priv->sp_protocol);
 	if (ret < 0) {
 		DPAA2_PMD_ERR("Invalid pattern list is given");
 		rte_flow_error_set(error, EPERM,
diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index f417edf52b..ccb4bbe7dc 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -128,6 +128,16 @@ dpaa2_dev_rx_parse_new(struct dpaa2_dev_priv *priv,
 			ext_packet_type |= RTE_PTYPE_INNER_L3_IPV4;
 		}
 	}
+	if (priv->sp_protocol) {
+		if (frc_parse->fafe2) {
+			frc_parse->fafe2 = 0;
+			ext_packet_type |= RTE_PTYPE_TUNNEL_GENEVE;
+		}
+		if (frc_parse->sum_l.l4.fafe3) {
+			frc_parse->sum_l.l4.fafe3 = 0;
+			ext_packet_type |= RTE_PTYPE_INNER_L3_IPV4;
+		}
+	}
 	switch (frc) {
 	case DPAA2_PKT_TYPE_IPV4_UDP:
 		m->packet_type = RTE_PTYPE_L2_ETHER |
-- 
2.43.0

