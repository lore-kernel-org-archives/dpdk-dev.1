Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1251CCA5FED
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Oct 2026 15:12:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 54557427CD;
	Tue,  6 Oct 2026 17:10:30 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 7F1CD427A5
 for <dev@dpdk.org>; Tue,  6 Oct 2026 17:10:25 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 5DAE4200021;
 Tue,  6 Oct 2026 17:10:25 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 0AD9D2001C9;
 Tue,  6 Oct 2026 17:10:25 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 06EB8180006C;
 Tue,  6 Oct 2026 23:10:23 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v6-S2 12/13] net/dpaa2: remove unused soft parser driver
Date: Tue,  6 Oct 2026 20:40:08 +0530
Message-ID: <20261006151009.3593348-13-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261006151009.3593348-1-prashant.gupta_3@nxp.com>
References: <20261001073307.1125305-1-prashant.gupta_3@nxp.com>
 <20261006151009.3593348-1-prashant.gupta_3@nxp.com>
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

The DPAA2 soft parser (SP) byte code has to be installed by the boot
firmware before Linux starts; the WRIOP parser cannot be reprogrammed once
the MC is up. Loading an SP image at run time from the PMD therefore never
took effect, so the loader and its DPNI_SS_INGRESS plumbing were dead
code and are removed.

The rte_flow VXLAN and eCPRI pattern items were only ever accepted while
an SP image was believed to be loaded. With the SP gone they are rejected
by dpaa2_dev_verify_patterns() before the configure switch is reached, so
their handlers dpaa2_configure_flow_vxlan() and
dpaa2_configure_flow_ecpri(), the switch cases that call them, the mask
descriptors and the VXLAN_HF_VNI helper are removed as well. Both items are
also dropped from the dpaa2 feature matrix so that the documented
capabilities match the code.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 doc/guides/nics/features/dpaa2.ini     |   2 -
 doc/guides/rel_notes/release_26_11.rst |   9 +
 drivers/net/dpaa2/dpaa2_ethdev.c       |  28 --
 drivers/net/dpaa2/dpaa2_ethdev.h       |   1 -
 drivers/net/dpaa2/dpaa2_flow.c         | 564 +------------------------
 drivers/net/dpaa2/dpaa2_recycle.c      |   1 -
 drivers/net/dpaa2/dpaa2_sparser.c      | 137 ------
 drivers/net/dpaa2/dpaa2_sparser.h      | 202 ---------
 drivers/net/dpaa2/meson.build          |   1 -
 9 files changed, 10 insertions(+), 935 deletions(-)
 delete mode 100644 drivers/net/dpaa2/dpaa2_sparser.c
 delete mode 100644 drivers/net/dpaa2/dpaa2_sparser.h

diff --git a/doc/guides/nics/features/dpaa2.ini b/doc/guides/nics/features/dpaa2.ini
index 49faebcd06..9e24cf3f5b 100644
--- a/doc/guides/nics/features/dpaa2.ini
+++ b/doc/guides/nics/features/dpaa2.ini
@@ -35,7 +35,6 @@ Usage doc            = Y
 
 [rte_flow items]
 ah                   = Y
-ecpri                = Y
 esp                  = Y
 eth                  = P
 gre                  = Y
@@ -50,7 +49,6 @@ sctp                 = Y
 tcp                  = Y
 udp                  = Y
 vlan                 = P
-vxlan                = Y
 
 [rte_flow actions]
 drop                 = Y
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index dc938d4519..959193cc92 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -77,6 +77,15 @@ Removed Items
    Also, make sure to start the actual text at the margin.
    =======================================================
 
+* **Removed soft parser support from the dpaa2 net driver.**
+
+  The DPAA2 soft parser (SP) blob has to be loaded by the boot firmware
+  before Linux starts, so loading it at run time from the PMD never took
+  effect. The unused SP loader has been removed, together with the rte_flow
+  VXLAN and eCPRI pattern items that were only accepted while an SP image
+  was believed to be loaded. Those two items are no longer advertised in
+  the dpaa2 feature matrix.
+
 * Removed deprecated symbols:
 
   * fib: ``RTE_FIB6_IPV6_ADDR_SIZE``, ``RTE_FIB6_MAXDEPTH``
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index ab98fda918..5e6ab5ba7e 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -29,7 +29,6 @@
 #include <mc/fsl_dpmng.h>
 #include <mc/fsl_dpcon.h>
 #include "dpaa2_ethdev.h"
-#include "dpaa2_sparser.h"
 #include <fsl_qbman_debug.h>
 
 #define DRIVER_LOOPBACK_MODE "drv_loopback"
@@ -3723,33 +3722,6 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	}
 	eth_dev->data->mtu = RTE_ETHER_MTU;
 
-	/*TODO To enable soft parser support DPAA2 driver needs to integrate
-	 * with external entity to receive byte code for software sequence
-	 * and same will be offload to the H/W using MC interface.
-	 * Currently it is assumed that DPAA2 driver has byte code by some
-	 * mean and same if offloaded to H/W.
-	 */
-	if (getenv("DPAA2_ENABLE_SOFT_PARSER")) {
-		WRIOP_SS_INITIALIZER(priv);
-		ret = dpaa2_eth_load_wriop_soft_parser(priv, DPNI_SS_INGRESS);
-		if (ret < 0) {
-			DPAA2_PMD_ERR(" Error(%d) in loading softparser",
-				      ret);
-			goto init_err;
-		}
-
-		ret = dpaa2_eth_enable_wriop_soft_parser(priv,
-							 DPNI_SS_INGRESS);
-		if (ret < 0) {
-			DPAA2_PMD_ERR(" Error(%d) in enabling softparser",
-				      ret);
-			goto init_err;
-		}
-	}
-
-	ret = dpaa2_soft_parser_loaded();
-	if (ret > 0)
-		DPAA2_PMD_INFO("soft parser is loaded");
 	DPAA2_PMD_INFO("%s: netdev created, connected to %s",
 		eth_dev->data->name, dpaa2_dev->ep_name);
 
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index b3f7b23e01..865f2bbe16 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -667,7 +667,6 @@ int dpaa2_timesync_read_tx_timestamp(struct rte_eth_dev *dev,
 int dpaa2_dev_recycle_config(struct rte_eth_dev *eth_dev);
 int dpaa2_dev_recycle_deconfig(struct rte_eth_dev *eth_dev);
 int dpaa2_mtr_ops_get(struct rte_eth_dev *dev, void *ops);
-int dpaa2_soft_parser_loaded(void);
 
 void
 dpaa2_dev_mac_setup_stats(struct rte_eth_dev *dev);
diff --git a/drivers/net/dpaa2/dpaa2_flow.c b/drivers/net/dpaa2/dpaa2_flow.c
index f3bb2a858f..f494d038c1 100644
--- a/drivers/net/dpaa2/dpaa2_flow.c
+++ b/drivers/net/dpaa2/dpaa2_flow.c
@@ -24,7 +24,6 @@
 #include <dpaa2_pmd_logs.h>
 
 static char *dpaa2_flow_control_log;
-static int dpaa2_sp_loaded = -1;
 
 /* Default size of a key */
 #define DPNI_DEFAULT_KEY_SIZE 24
@@ -42,7 +41,6 @@ enum dpaa2_flow_dist_type {
 #define DPAA2_FLOW_RAW_OFFSET_FIELD_SHIFT	16
 #define DPAA2_FLOW_MAX_KEY_SIZE			16
 #define DPAA2_PROT_FIELD_STRING_SIZE		16
-#define VXLAN_HF_VNI 0x08
 
 struct dpaa2_dev_flow {
 	LIST_ENTRY(dpaa2_dev_flow) next;
@@ -87,12 +85,6 @@ enum rte_flow_item_type dpaa2_hp_supported_pattern_type[] = {
 	RTE_FLOW_ITEM_TYPE_RAW
 };
 
-static const
-enum rte_flow_item_type dpaa2_sp_supported_pattern_type[] = {
-	RTE_FLOW_ITEM_TYPE_VXLAN,
-	RTE_FLOW_ITEM_TYPE_ECPRI
-};
-
 static const
 enum rte_flow_action_type dpaa2_supported_action_type[] = {
 	RTE_FLOW_ACTION_TYPE_END,
@@ -169,18 +161,6 @@ static const struct rte_flow_item_gre dpaa2_flow_item_gre_mask = {
 	.protocol = RTE_BE16(0xffff),
 };
 
-static const struct rte_flow_item_vxlan dpaa2_flow_item_vxlan_mask = {
-	.flags = 0xff,
-	.vni = { 0xff, 0xff, 0xff },
-};
-
-static const struct rte_flow_item_ecpri dpaa2_flow_item_ecpri_mask = {
-	.hdr.common.type = 0xff,
-	.hdr.dummy[0] = RTE_BE32(0xffffffff),
-	.hdr.dummy[1] = RTE_BE32(0xffffffff),
-	.hdr.dummy[2] = RTE_BE32(0xffffffff),
-};
-
 static const struct rte_flow_item_gtp dpaa2_flow_item_gtp_mask = {
 	.teid = RTE_BE32(0xffffffff),
 };
@@ -434,92 +414,6 @@ dpaa2_flow_fs_entry_log(const char *log_info,
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
@@ -1766,13 +1660,7 @@ dpaa2_flow_extract_support(const uint8_t *mask_src,
 		mask_support = (const char *)&dpaa2_flow_item_gre_mask;
 		size = sizeof(struct rte_flow_item_gre);
 		break;
-	case RTE_FLOW_ITEM_TYPE_VXLAN:
-		mask_support = (const char *)&dpaa2_flow_item_vxlan_mask;
-		size = sizeof(struct rte_flow_item_vxlan);
 		break;
-	case RTE_FLOW_ITEM_TYPE_ECPRI:
-		mask_support = (const char *)&dpaa2_flow_item_ecpri_mask;
-		size = sizeof(struct rte_flow_item_ecpri);
 		break;
 	case RTE_FLOW_ITEM_TYPE_GTP:
 		mask_support = (const char *)&dpaa2_flow_item_gtp_mask;
@@ -3568,422 +3456,6 @@ dpaa2_configure_flow_gre(struct dpaa2_dev_flow *flow,
 	return 0;
 }
 
-static int
-dpaa2_configure_flow_vxlan(struct dpaa2_dev_flow *flow,
-	struct rte_eth_dev *dev,
-	const struct rte_flow_attr *attr,
-	const struct rte_dpaa2_flow_item *dpaa2_pattern,
-	const struct rte_flow_action actions[] __rte_unused,
-	struct rte_flow_error *error __rte_unused,
-	int *device_configured)
-{
-	int ret, local_cfg = 0;
-	uint32_t group;
-	const struct rte_flow_item_vxlan *spec, *mask;
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	const struct rte_flow_item *pattern = &dpaa2_pattern->generic_item;
-
-	group = attr->group;
-
-	/* Parse pattern list to get the matching parameters */
-	spec = pattern->spec;
-	mask = pattern->mask ?
-		pattern->mask : &dpaa2_flow_item_vxlan_mask;
-
-	/* Get traffic class index and flow id to be configured */
-	flow->tc_id = group;
-	flow->tc_index = attr->priority;
-
-	if (dpaa2_pattern->in_tunnel) {
-		DPAA2_PMD_ERR("Tunnel-VXLAN distribution not support");
-		return -ENOTSUP;
-	}
-
-	if (!spec) {
-		ret = dpaa2_flow_identify_by_faf(priv, flow,
-				FAF_VXLAN_FRAM, DPAA2_FLOW_QOS_TYPE,
-				group, &local_cfg);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_identify_by_faf(priv, flow,
-				FAF_VXLAN_FRAM, DPAA2_FLOW_FS_TYPE,
-				group, &local_cfg);
-		if (ret)
-			return ret;
-
-		(*device_configured) |= local_cfg;
-		return 0;
-	}
-
-	ret = dpaa2_flow_extract_support((const uint8_t *)mask,
-		RTE_FLOW_ITEM_TYPE_VXLAN);
-	if (ret) {
-		DPAA2_PMD_WARN("Extract field(s) of VXLAN not support.");
-
-		return ret;
-	}
-
-	if (mask->flags) {
-		if (spec->flags != VXLAN_HF_VNI) {
-			DPAA2_PMD_ERR("vxlan flag(0x%02x) must be 0x%02x.",
-				spec->flags, VXLAN_HF_VNI);
-			return -EINVAL;
-		}
-		if (mask->flags != 0xff) {
-			DPAA2_PMD_ERR("Not support to extract vxlan flag.");
-			return -EINVAL;
-		}
-	}
-
-	if (mask->vni[0] || mask->vni[1] || mask->vni[2]) {
-		ret = dpaa2_flow_add_pr_extract_rule(flow,
-			DPAA2_VXLAN_VNI_OFFSET,
-			sizeof(mask->vni), spec->vni,
-			mask->vni,
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_add_pr_extract_rule(flow,
-			DPAA2_VXLAN_VNI_OFFSET,
-			sizeof(mask->vni), spec->vni,
-			mask->vni,
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
-		if (ret)
-			return ret;
-	}
-
-	(*device_configured) |= local_cfg;
-
-	return 0;
-}
-
-static int
-dpaa2_configure_flow_ecpri(struct dpaa2_dev_flow *flow,
-	struct rte_eth_dev *dev,
-	const struct rte_flow_attr *attr,
-	const struct rte_dpaa2_flow_item *dpaa2_pattern,
-	const struct rte_flow_action actions[] __rte_unused,
-	struct rte_flow_error *error __rte_unused,
-	int *device_configured)
-{
-	int ret, local_cfg = 0;
-	uint32_t group;
-	const struct rte_flow_item_ecpri *spec, *mask;
-	struct rte_flow_item_ecpri local_mask;
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	const struct rte_flow_item *pattern =
-		&dpaa2_pattern->generic_item;
-	uint8_t extract_nb = 0, i;
-	uint64_t rule_data[DPAA2_ECPRI_MAX_EXTRACT_NB];
-	uint64_t mask_data[DPAA2_ECPRI_MAX_EXTRACT_NB];
-	uint8_t extract_size[DPAA2_ECPRI_MAX_EXTRACT_NB];
-	uint8_t extract_off[DPAA2_ECPRI_MAX_EXTRACT_NB];
-
-	group = attr->group;
-
-	/* Parse pattern list to get the matching parameters */
-	spec = pattern->spec;
-	if (pattern->mask) {
-		memcpy(&local_mask, pattern->mask,
-			sizeof(struct rte_flow_item_ecpri));
-		local_mask.hdr.common.u32 =
-			rte_be_to_cpu_32(local_mask.hdr.common.u32);
-		mask = &local_mask;
-	} else {
-		mask = &dpaa2_flow_item_ecpri_mask;
-	}
-
-	/* Get traffic class index and flow id to be configured */
-	flow->tc_id = group;
-	flow->tc_index = attr->priority;
-
-	if (dpaa2_pattern->in_tunnel) {
-		DPAA2_PMD_ERR("Tunnel-ECPRI distribution not support");
-		return -ENOTSUP;
-	}
-
-	if (!spec) {
-		ret = dpaa2_flow_identify_by_faf(priv, flow,
-			FAFE_ECPRI_FRAM, DPAA2_FLOW_QOS_TYPE,
-			group, &local_cfg);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_identify_by_faf(priv, flow,
-			FAFE_ECPRI_FRAM, DPAA2_FLOW_FS_TYPE,
-			group, &local_cfg);
-		if (ret)
-			return ret;
-
-		(*device_configured) |= local_cfg;
-		return 0;
-	}
-
-	ret = dpaa2_flow_extract_support((const uint8_t *)mask,
-		RTE_FLOW_ITEM_TYPE_ECPRI);
-	if (ret) {
-		DPAA2_PMD_WARN("Extract field(s) of ECPRI not support.");
-
-		return ret;
-	}
-
-	if (mask->hdr.common.type != 0xff) {
-		DPAA2_PMD_WARN("ECPRI header type not specified.");
-
-		return -EINVAL;
-	}
-
-	if (spec->hdr.common.type == RTE_ECPRI_MSG_TYPE_IQ_DATA) {
-		rule_data[extract_nb] = ECPRI_FAFE_TYPE_0;
-		mask_data[extract_nb] = 0xff;
-		extract_size[extract_nb] = sizeof(uint8_t);
-		extract_off[extract_nb] = DPAA2_FAFE_PSR_OFFSET;
-		extract_nb++;
-
-		if (mask->hdr.type0.pc_id) {
-			rule_data[extract_nb] = spec->hdr.type0.pc_id;
-			mask_data[extract_nb] = mask->hdr.type0.pc_id;
-			extract_size[extract_nb] = sizeof(rte_be16_t);
-			extract_off[extract_nb] =
-				DPAA2_ECPRI_MSG_OFFSET +
-				offsetof(struct rte_ecpri_msg_iq_data, pc_id);
-			extract_nb++;
-		}
-		if (mask->hdr.type0.seq_id) {
-			rule_data[extract_nb] = spec->hdr.type0.seq_id;
-			mask_data[extract_nb] = mask->hdr.type0.seq_id;
-			extract_size[extract_nb] = sizeof(rte_be16_t);
-			extract_off[extract_nb] =
-				DPAA2_ECPRI_MSG_OFFSET +
-				offsetof(struct rte_ecpri_msg_iq_data, seq_id);
-			extract_nb++;
-		}
-	} else if (spec->hdr.common.type == RTE_ECPRI_MSG_TYPE_BIT_SEQ) {
-		rule_data[extract_nb] = ECPRI_FAFE_TYPE_1;
-		mask_data[extract_nb] = 0xff;
-		extract_size[extract_nb] = sizeof(uint8_t);
-		extract_off[extract_nb] = DPAA2_FAFE_PSR_OFFSET;
-		extract_nb++;
-
-		if (mask->hdr.type1.pc_id) {
-			rule_data[extract_nb] = spec->hdr.type1.pc_id;
-			mask_data[extract_nb] = mask->hdr.type1.pc_id;
-			extract_size[extract_nb] = sizeof(rte_be16_t);
-			extract_off[extract_nb] =
-				DPAA2_ECPRI_MSG_OFFSET +
-				offsetof(struct rte_ecpri_msg_bit_seq, pc_id);
-			extract_nb++;
-		}
-		if (mask->hdr.type1.seq_id) {
-			rule_data[extract_nb] = spec->hdr.type1.seq_id;
-			mask_data[extract_nb] = mask->hdr.type1.seq_id;
-			extract_size[extract_nb] = sizeof(rte_be16_t);
-			extract_off[extract_nb] =
-				DPAA2_ECPRI_MSG_OFFSET +
-				offsetof(struct rte_ecpri_msg_bit_seq, seq_id);
-			extract_nb++;
-		}
-	} else if (spec->hdr.common.type == RTE_ECPRI_MSG_TYPE_RTC_CTRL) {
-		rule_data[extract_nb] = ECPRI_FAFE_TYPE_2;
-		mask_data[extract_nb] = 0xff;
-		extract_size[extract_nb] = sizeof(uint8_t);
-		extract_off[extract_nb] = DPAA2_FAFE_PSR_OFFSET;
-		extract_nb++;
-
-		if (mask->hdr.type2.rtc_id) {
-			rule_data[extract_nb] = spec->hdr.type2.rtc_id;
-			mask_data[extract_nb] = mask->hdr.type2.rtc_id;
-			extract_size[extract_nb] = sizeof(rte_be16_t);
-			extract_off[extract_nb] =
-				DPAA2_ECPRI_MSG_OFFSET +
-				offsetof(struct rte_ecpri_msg_rtc_ctrl, rtc_id);
-			extract_nb++;
-		}
-		if (mask->hdr.type2.seq_id) {
-			rule_data[extract_nb] = spec->hdr.type2.seq_id;
-			mask_data[extract_nb] = mask->hdr.type2.seq_id;
-			extract_size[extract_nb] = sizeof(rte_be16_t);
-			extract_off[extract_nb] =
-				DPAA2_ECPRI_MSG_OFFSET +
-				offsetof(struct rte_ecpri_msg_rtc_ctrl, seq_id);
-			extract_nb++;
-		}
-	} else if (spec->hdr.common.type == RTE_ECPRI_MSG_TYPE_GEN_DATA) {
-		rule_data[extract_nb] = ECPRI_FAFE_TYPE_3;
-		mask_data[extract_nb] = 0xff;
-		extract_size[extract_nb] = sizeof(uint8_t);
-		extract_off[extract_nb] = DPAA2_FAFE_PSR_OFFSET;
-		extract_nb++;
-
-		if (mask->hdr.type3.pc_id || mask->hdr.type3.seq_id)
-			DPAA2_PMD_WARN("Extract type3 msg not support.");
-	} else if (spec->hdr.common.type == RTE_ECPRI_MSG_TYPE_RM_ACC) {
-		rule_data[extract_nb] = ECPRI_FAFE_TYPE_4;
-		mask_data[extract_nb] = 0xff;
-		extract_size[extract_nb] = sizeof(uint8_t);
-		extract_off[extract_nb] = DPAA2_FAFE_PSR_OFFSET;
-		extract_nb++;
-
-		if (mask->hdr.type4.rma_id) {
-			rule_data[extract_nb] = spec->hdr.type4.rma_id;
-			mask_data[extract_nb] = mask->hdr.type4.rma_id;
-			extract_size[extract_nb] = sizeof(uint8_t);
-			extract_off[extract_nb] =
-				DPAA2_ECPRI_MSG_OFFSET + 0;
-				/** Compiler not support to take address
-				 * of bit-field
-				 * offsetof(struct rte_ecpri_msg_rm_access,
-				 * rma_id);
-				 */
-			extract_nb++;
-		}
-		if (mask->hdr.type4.ele_id) {
-			rule_data[extract_nb] = spec->hdr.type4.ele_id;
-			mask_data[extract_nb] = mask->hdr.type4.ele_id;
-			extract_size[extract_nb] = sizeof(rte_be16_t);
-			extract_off[extract_nb] =
-				DPAA2_ECPRI_MSG_OFFSET + 2;
-				/** Compiler not support to take address
-				 * of bit-field
-				 * offsetof(struct rte_ecpri_msg_rm_access,
-				 * ele_id);
-				 */
-			extract_nb++;
-		}
-	} else if (spec->hdr.common.type == RTE_ECPRI_MSG_TYPE_DLY_MSR) {
-		rule_data[extract_nb] = ECPRI_FAFE_TYPE_5;
-		mask_data[extract_nb] = 0xff;
-		extract_size[extract_nb] = sizeof(uint8_t);
-		extract_off[extract_nb] = DPAA2_FAFE_PSR_OFFSET;
-		extract_nb++;
-
-		if (mask->hdr.type5.msr_id) {
-			rule_data[extract_nb] = spec->hdr.type5.msr_id;
-			mask_data[extract_nb] = mask->hdr.type5.msr_id;
-			extract_size[extract_nb] = sizeof(uint8_t);
-			extract_off[extract_nb] =
-				DPAA2_ECPRI_MSG_OFFSET +
-				offsetof(struct rte_ecpri_msg_delay_measure,
-					msr_id);
-			extract_nb++;
-		}
-		if (mask->hdr.type5.act_type) {
-			rule_data[extract_nb] = spec->hdr.type5.act_type;
-			mask_data[extract_nb] = mask->hdr.type5.act_type;
-			extract_size[extract_nb] = sizeof(uint8_t);
-			extract_off[extract_nb] =
-				DPAA2_ECPRI_MSG_OFFSET +
-				offsetof(struct rte_ecpri_msg_delay_measure,
-					act_type);
-			extract_nb++;
-		}
-	} else if (spec->hdr.common.type == RTE_ECPRI_MSG_TYPE_RMT_RST) {
-		rule_data[extract_nb] = ECPRI_FAFE_TYPE_6;
-		mask_data[extract_nb] = 0xff;
-		extract_size[extract_nb] = sizeof(uint8_t);
-		extract_off[extract_nb] = DPAA2_FAFE_PSR_OFFSET;
-		extract_nb++;
-
-		if (mask->hdr.type6.rst_id) {
-			rule_data[extract_nb] = spec->hdr.type6.rst_id;
-			mask_data[extract_nb] = mask->hdr.type6.rst_id;
-			extract_size[extract_nb] = sizeof(rte_be16_t);
-			extract_off[extract_nb] =
-				DPAA2_ECPRI_MSG_OFFSET +
-				offsetof(struct rte_ecpri_msg_remote_reset,
-					rst_id);
-			extract_nb++;
-		}
-		if (mask->hdr.type6.rst_op) {
-			rule_data[extract_nb] = spec->hdr.type6.rst_op;
-			mask_data[extract_nb] = mask->hdr.type6.rst_op;
-			extract_size[extract_nb] = sizeof(uint8_t);
-			extract_off[extract_nb] =
-				DPAA2_ECPRI_MSG_OFFSET +
-				offsetof(struct rte_ecpri_msg_remote_reset,
-					rst_op);
-			extract_nb++;
-		}
-	} else if (spec->hdr.common.type == RTE_ECPRI_MSG_TYPE_EVT_IND) {
-		rule_data[extract_nb] = ECPRI_FAFE_TYPE_7;
-		mask_data[extract_nb] = 0xff;
-		extract_size[extract_nb] = sizeof(uint8_t);
-		extract_off[extract_nb] = DPAA2_FAFE_PSR_OFFSET;
-		extract_nb++;
-
-		if (mask->hdr.type7.evt_id) {
-			rule_data[extract_nb] = spec->hdr.type7.evt_id;
-			mask_data[extract_nb] = mask->hdr.type7.evt_id;
-			extract_size[extract_nb] = sizeof(uint8_t);
-			extract_off[extract_nb] =
-				DPAA2_ECPRI_MSG_OFFSET +
-				offsetof(struct rte_ecpri_msg_event_ind,
-					evt_id);
-			extract_nb++;
-		}
-		if (mask->hdr.type7.evt_type) {
-			rule_data[extract_nb] = spec->hdr.type7.evt_type;
-			mask_data[extract_nb] = mask->hdr.type7.evt_type;
-			extract_size[extract_nb] = sizeof(uint8_t);
-			extract_off[extract_nb] =
-				DPAA2_ECPRI_MSG_OFFSET +
-				offsetof(struct rte_ecpri_msg_event_ind,
-					evt_type);
-			extract_nb++;
-		}
-		if (mask->hdr.type7.seq) {
-			rule_data[extract_nb] = spec->hdr.type7.seq;
-			mask_data[extract_nb] = mask->hdr.type7.seq;
-			extract_size[extract_nb] = sizeof(uint8_t);
-			extract_off[extract_nb] =
-				DPAA2_ECPRI_MSG_OFFSET +
-				offsetof(struct rte_ecpri_msg_event_ind,
-					seq);
-			extract_nb++;
-		}
-		if (mask->hdr.type7.number) {
-			rule_data[extract_nb] = spec->hdr.type7.number;
-			mask_data[extract_nb] = mask->hdr.type7.number;
-			extract_size[extract_nb] = sizeof(uint8_t);
-			extract_off[extract_nb] =
-				DPAA2_ECPRI_MSG_OFFSET +
-				offsetof(struct rte_ecpri_msg_event_ind,
-					number);
-			extract_nb++;
-		}
-	} else {
-		DPAA2_PMD_ERR("Invalid ecpri header type(%d)",
-				spec->hdr.common.type);
-		return -EINVAL;
-	}
-
-	for (i = 0; i < extract_nb; i++) {
-		ret = dpaa2_flow_add_pr_extract_rule(flow,
-			extract_off[i],
-			extract_size[i], &rule_data[i], &mask_data[i],
-			priv, group,
-			device_configured,
-			DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_add_pr_extract_rule(flow,
-			extract_off[i],
-			extract_size[i], &rule_data[i], &mask_data[i],
-			priv, group,
-			device_configured,
-			DPAA2_FLOW_FS_TYPE);
-		if (ret)
-			return ret;
-	}
-
-	(*device_configured) |= local_cfg;
-
-	return 0;
-}
-
 static int
 dpaa2_configure_flow_gtp(struct dpaa2_dev_flow *flow,
 	struct rte_eth_dev *dev,
@@ -4905,26 +4377,6 @@ dpaa2_generic_flow_set(struct dpaa2_dev_flow *flow,
 				goto end_flow_set;
 			}
 			break;
-		case RTE_FLOW_ITEM_TYPE_VXLAN:
-			ret = dpaa2_configure_flow_vxlan(flow, dev, attr,
-					&dpaa2_pattern[i],
-					actions, error,
-					&is_keycfg_configured);
-			if (ret) {
-				DPAA2_PMD_ERR("VXLAN flow config failed!");
-				goto end_flow_set;
-			}
-			break;
-		case RTE_FLOW_ITEM_TYPE_ECPRI:
-			ret = dpaa2_configure_flow_ecpri(flow,
-					dev, attr, &dpaa2_pattern[i],
-					actions, error,
-					&is_keycfg_configured);
-			if (ret) {
-				DPAA2_PMD_ERR("ECPRI flow config failed!");
-				goto end_flow_set;
-			}
-			break;
 		case RTE_FLOW_ITEM_TYPE_GTP:
 			ret = dpaa2_configure_flow_gtp(flow,
 					dev, attr, &dpaa2_pattern[i],
@@ -5134,15 +4586,11 @@ dpaa2_dev_verify_patterns(const struct rte_flow_item pattern[])
 	unsigned int i, j, is_found = 0;
 	int ret = 0;
 	const enum rte_flow_item_type *hp_supported;
-	const enum rte_flow_item_type *sp_supported;
-	uint64_t hp_supported_num, sp_supported_num;
+	uint64_t hp_supported_num;
 
 	hp_supported = dpaa2_hp_supported_pattern_type;
 	hp_supported_num = RTE_DIM(dpaa2_hp_supported_pattern_type);
 
-	sp_supported = dpaa2_sp_supported_pattern_type;
-	sp_supported_num = RTE_DIM(dpaa2_sp_supported_pattern_type);
-
 	for (j = 0; pattern[j].type != RTE_FLOW_ITEM_TYPE_END; j++) {
 		is_found = 0;
 		for (i = 0; i < hp_supported_num; i++) {
@@ -5151,16 +4599,6 @@ dpaa2_dev_verify_patterns(const struct rte_flow_item pattern[])
 				break;
 			}
 		}
-		if (is_found)
-			continue;
-		if (dpaa2_sp_loaded > 0) {
-			for (i = 0; i < sp_supported_num; i++) {
-				if (sp_supported[i] == pattern[j].type) {
-					is_found = 1;
-					break;
-				}
-			}
-		}
 		if (!is_found) {
 			DPAA2_PMD_WARN("Flow type(%d) not supported",
 				pattern[j].type);
diff --git a/drivers/net/dpaa2/dpaa2_recycle.c b/drivers/net/dpaa2/dpaa2_recycle.c
index 9b6ae3f515..1d6f8659be 100644
--- a/drivers/net/dpaa2/dpaa2_recycle.c
+++ b/drivers/net/dpaa2/dpaa2_recycle.c
@@ -23,7 +23,6 @@
 #include <dpaa2_hw_dpio.h>
 #include <mc/fsl_dpmng.h>
 #include "dpaa2_ethdev.h"
-#include "dpaa2_sparser.h"
 #include <fsl_qbman_debug.h>
 
 #include <rte_io.h>
diff --git a/drivers/net/dpaa2/dpaa2_sparser.c b/drivers/net/dpaa2/dpaa2_sparser.c
deleted file mode 100644
index 6c3e6eb573..0000000000
--- a/drivers/net/dpaa2/dpaa2_sparser.c
+++ /dev/null
@@ -1,137 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2018-2023 NXP
- */
-
-#include <rte_mbuf.h>
-#include <rte_ethdev.h>
-#include <rte_malloc.h>
-#include <rte_memcpy.h>
-#include <rte_string_fns.h>
-#include <dev_driver.h>
-
-#include <fslmc_logs.h>
-#include <fslmc_vfio.h>
-#include <dpaa2_hw_pvt.h>
-#include <dpaa2_hw_dpio.h>
-#include <dpaa2_hw_mempool.h>
-#include <dpaa2_pmd_logs.h>
-
-#include "dpaa2_ethdev.h"
-#include "dpaa2_sparser.h"
-#include "base/dpaa2_hw_dpni_annot.h"
-#define __STDC_FORMAT_MACROS
-#include <stdint.h>
-#include <inttypes.h>
-
-static uint8_t wriop_bytecode[] = {
-	0x00, 0x04, 0x29, 0x42, 0x03, 0xe0, 0x12, 0x00, 0x29, 0x02,
-	0x18, 0x00, 0x87, 0x3c, 0x00, 0x02, 0x18, 0x00, 0x00, 0x00
-};
-
-int dpaa2_eth_load_wriop_soft_parser(struct dpaa2_dev_priv *priv,
-				     enum dpni_soft_sequence_dest dest)
-{
-	struct fsl_mc_io *dpni = priv->hw;
-	struct dpni_load_ss_cfg     cfg;
-	struct dpni_drv_sparser_param	sp_param;
-	uint8_t *addr;
-	int ret;
-
-	memset(&sp_param, 0, sizeof(sp_param));
-	sp_param.start_pc = priv->ss_offset;
-	sp_param.byte_code = &wriop_bytecode[0];
-	sp_param.size = sizeof(wriop_bytecode);
-
-	cfg.dest = dest;
-	cfg.ss_offset = sp_param.start_pc;
-	cfg.ss_size = sp_param.size;
-
-	addr = rte_malloc(NULL, sp_param.size, 64);
-	if (!addr) {
-		DPAA2_PMD_ERR("Memory unavailable for soft parser param");
-		return -1;
-	}
-
-	memcpy(addr, sp_param.byte_code, sp_param.size);
-	cfg.ss_iova = DPAA2_VADDR_TO_IOVA_AND_CHECK(addr, sp_param.size);
-	if (cfg.ss_iova == RTE_BAD_IOVA) {
-		DPAA2_PMD_ERR("No IOMMU map for soft sequence(%p), size=%d",
-			addr, sp_param.size);
-		rte_free(addr);
-
-		return -ENOBUFS;
-	}
-
-	ret = dpni_load_sw_sequence(dpni, CMD_PRI_LOW, priv->token, &cfg);
-	if (ret) {
-		DPAA2_PMD_ERR("dpni_load_sw_sequence failed");
-		rte_free(addr);
-		return ret;
-	}
-
-	priv->ss_iova = cfg.ss_iova;
-	priv->ss_offset += sp_param.size;
-	DPAA2_PMD_INFO("Soft parser loaded for dpni@%d", priv->hw_id);
-
-	rte_free(addr);
-	return 0;
-}
-
-int dpaa2_eth_enable_wriop_soft_parser(struct dpaa2_dev_priv *priv,
-				       enum dpni_soft_sequence_dest dest)
-{
-	struct fsl_mc_io *dpni = priv->hw;
-	struct dpni_enable_ss_cfg cfg;
-	uint8_t pa[3];
-	struct dpni_drv_sparser_param sp_param;
-	uint8_t *param_addr = NULL;
-	int ret;
-
-	memset(&sp_param, 0, sizeof(sp_param));
-	pa[0] = 32;	/* Custom Header Length in bytes */
-	sp_param.custom_header_first = 1;
-	sp_param.param_offset = 32;
-	sp_param.param_size = 1;
-	sp_param.start_pc = priv->ss_offset;
-	sp_param.param_array = (uint8_t *)&pa[0];
-
-	cfg.dest = dest;
-	cfg.ss_offset = sp_param.start_pc;
-	cfg.set_start = sp_param.custom_header_first;
-	cfg.hxs = (uint16_t)sp_param.link_to_hard_hxs;
-	cfg.param_offset = sp_param.param_offset;
-	cfg.param_size = sp_param.param_size;
-	if (cfg.param_size) {
-		param_addr = rte_malloc(NULL, cfg.param_size, 64);
-		if (!param_addr) {
-			DPAA2_PMD_ERR("Memory unavailable for soft parser param");
-			return -1;
-		}
-
-		memcpy(param_addr, sp_param.param_array, cfg.param_size);
-		cfg.param_iova = DPAA2_VADDR_TO_IOVA_AND_CHECK(param_addr,
-			cfg.param_size);
-		if (cfg.param_iova == RTE_BAD_IOVA) {
-			DPAA2_PMD_ERR("%s: No IOMMU map for %p, size=%d",
-				__func__, param_addr, cfg.param_size);
-			rte_free(param_addr);
-
-			return -ENOBUFS;
-		}
-		priv->ss_param_iova = cfg.param_iova;
-	} else {
-		cfg.param_iova = 0;
-	}
-
-	ret = dpni_enable_sw_sequence(dpni, CMD_PRI_LOW, priv->token, &cfg);
-	if (ret) {
-		DPAA2_PMD_ERR("Soft parser enabled for dpni@%d failed",
-			priv->hw_id);
-		rte_free(param_addr);
-		return ret;
-	}
-
-	rte_free(param_addr);
-	DPAA2_PMD_INFO("Soft parser enabled for dpni@%d", priv->hw_id);
-	return 0;
-}
diff --git a/drivers/net/dpaa2/dpaa2_sparser.h b/drivers/net/dpaa2/dpaa2_sparser.h
deleted file mode 100644
index 0187cde113..0000000000
--- a/drivers/net/dpaa2/dpaa2_sparser.h
+++ /dev/null
@@ -1,202 +0,0 @@
-/* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2018-2019 NXP
- */
-
-/**
- * @file	dpaa2_sparser.h
- *
- * @brief	Soft parser related macros & functions support for DPAA2 device
- *	framework based applications.
- *
- */
-
-#ifndef _DPAA2_SPARSER_H
-#define _DPAA2_SPARSER_H
-
-#define WRIOP_SS_INITIALIZER(priv)				\
-do {								\
-	/* Base offset of parse profile memory in WRIOP */	\
-	(priv)->ss_offset = 0x20;				\
-	(priv)->ss_iova	= (size_t)NULL;			\
-	(priv)->ss_param_iova = (size_t)NULL;			\
-} while (0)
-
-/**************************************************************************/
-/*
- * @enum   parser_starting_hxs_code
- * @Description PARSER Starting HXS code
- */
-/***************************************************************************/
-enum parser_starting_hxs_code {
-	/** Ethernet Starting HXS coding */
-	PARSER_ETH_STARTING_HXS = 0x0000,
-	/** LLC+SNAP Starting HXS coding */
-	PARSER_LLC_SNAP_STARTING_HXS = 0x0001,
-	/** VLAN Starting HXS coding */
-	PARSER_VLAN_STARTING_HXS = 0x0002,
-	/** PPPoE+PPP Starting HXS coding */
-	PARSER_PPPOE_PPP_STARTING_HXS = 0x0003,
-	/** MPLS Starting HXS coding */
-	PARSER_MPLS_STARTING_HXS = 0x0004,
-	/** ARP Starting HXS coding */
-	PARSER_ARP_STARTING_HXS = 0x0005,
-	/** IP Starting HXS coding */
-	PARSER_IP_STARTING_HXS  = 0x0006,
-	/** IPv4 Starting HXS coding */
-	PARSER_IPV4_STARTING_HXS = 0x0007,
-	/** IPv6 Starting HXS coding */
-	PARSER_IPV6_STARTING_HXS = 0x0008,
-	/** GRE Starting HXS coding */
-	PARSER_GRE_STARTING_HXS = 0x0009,
-	/** MinEncap Starting HXS coding */
-	PARSER_MINENCAP_STARTING_HXS = 0x000A,
-	/** Other L3 Shell Starting HXS coding */
-	PARSER_OTHER_L3_SHELL_STARTING_HXS = 0x000B,
-	/** TCP Starting HXS coding */
-	PARSER_TCP_STARTING_HXS = 0x000C,
-	/** UDP Starting HXS coding */
-	PARSER_UDP_STARTING_HXS = 0x000D,
-	/** IPSec Starting HXS coding */
-	PARSER_IPSEC_STARTING_HXS = 0x000E,
-	/** SCTP Starting HXS coding */
-	PARSER_SCTP_STARTING_HXS = 0x000F,
-	/** DCCP Starting HXS coding */
-	PARSER_DCCP_STARTING_HXS = 0x0010,
-	/** Other L4 Shell Starting HXS coding */
-	PARSER_OTHER_L4_SHELL_STARTING_HXS = 0x0011,
-	/** GTP Starting HXS coding */
-	PARSER_GTP_STARTING_HXS = 0x0012,
-	/** ESP Starting HXS coding */
-	PARSER_ESP_STARTING_HXS = 0x0013,
-	/** VXLAN Starting HXS coding */
-	PARSER_VXLAN_STARTING_HXS = 0x0014,
-	/** L5 (and above) Shell Starting HXS coding */
-	PARSER_L5_SHELL_STARTING_HXS = 0x001E,
-	/** Final Shell Starting HXS coding */
-	PARSER_FINAL_SHELL_STARTING_HXS = 0x001F
-};
-
-/**************************************************************************/
-/*
- * @Description    struct dpni_drv_sparser_param - Structure representing the
- *			information needed to activate(enable) a Soft Parser.
- */
-/***************************************************************************/
-
-struct dpni_drv_sparser_param {
-	/* The "custom_header_first" must be set if the custom header to parse
-	 * is the first header in the packet, otherwise "custom_header_first"
-	 * must be cleared.
-	 */
-	uint8_t             custom_header_first;
-	/* Hard HXS on which a soft parser is activated. This must be
-	 * configured.
-	 * if the header to parse is not the first header in the packet.
-	 */
-	enum parser_starting_hxs_code   link_to_hard_hxs;
-	/* Soft Sequence Start PC */
-	uint16_t            start_pc;
-	/* Soft Sequence byte-code */
-	uint8_t             *byte_code;
-	/* Soft Sequence size */
-	uint16_t            size;
-	/* Pointer to the Parameters Array of the SP */
-	uint8_t             *param_array;
-	/* Parameters offset */
-	uint8_t             param_offset;
-	/* Parameters size */
-	uint8_t             param_size;
-};
-
-struct sp_parse_result {
-	/* Next header */
-	uint16_t    nxt_hdr;
-	/* Frame Attribute Flags Extension */
-	uint16_t    frame_attribute_flags_extension;
-	/* Frame Attribute Flags (part 1) */
-	uint32_t    frame_attribute_flags_1;
-	/* Frame Attribute Flags (part 2) */
-	uint32_t    frame_attribute_flags_2;
-	/* Frame Attribute Flags (part 3) */
-	uint32_t    frame_attribute_flags_3;
-	/* Shim Offset 1 */
-	uint8_t     shim_offset_1;
-	/* Shim Offset 2 */
-	uint8_t     shim_offset_2;
-	/* Outer IP protocol field offset */
-	uint8_t     ip_1_pid_offset;
-	/* Ethernet offset */
-	uint8_t     eth_offset;
-	/* LLC+SNAP offset */
-	uint8_t     llc_snap_offset;
-	/* First VLAN's TCI field offset*/
-	uint8_t     vlan_tci1_offset;
-	/* Last VLAN's TCI field offset*/
-	uint8_t     vlan_tcin_offset;
-	/* Last Ethertype offset*/
-	uint8_t     last_etype_offset;
-	/* PPPoE offset */
-	uint8_t     pppoe_offset;
-	/* First MPLS offset */
-	uint8_t     mpls_offset_1;
-	/* Last MPLS offset */
-	uint8_t     mpls_offset_n;
-	/* Layer 3 (Outer IP, ARP, FCoE or FIP) offset */
-	uint8_t     l3_offset;
-	/* Inner IP or MinEncap offset*/
-	uint8_t     ipn_or_minencap_offset;
-	/* GRE offset */
-	uint8_t     gre_offset;
-	/* Layer 4 offset*/
-	uint8_t     l4_offset;
-	/* Layer 5 offset */
-	uint8_t     l5_offset;
-	/* Routing header offset of 1st IPv6 header */
-	uint8_t     routing_hdr_offset1;
-	/* Routing header offset of 2nd IPv6 header */
-	uint8_t     routing_hdr_offset2;
-	/* Next header offset */
-	uint8_t     nxt_hdr_offset;
-	/* IPv6 fragmentable part offset */
-	uint8_t     ipv6_frag_offset;
-	/* Frame's untouched running sum, input to parser */
-	uint16_t    gross_running_sum;
-	/* Running Sum */
-	uint16_t    running_sum;
-	/* Parse Error code */
-	uint8_t     parse_error_code;
-	/* Offset to the next header field before IPv6 fragment extension */
-	uint8_t     nxt_hdr_before_ipv6_frag_ext;
-	/* Inner IP Protocol field offset */
-	uint8_t     ip_n_pid_offset;
-	/* Reserved for Soft parsing context*/
-	uint8_t     soft_parsing_context[21];
-};
-
-struct frame_attr {
-	const char *fld_name;
-	uint8_t     faf_offset;
-	uint32_t    fld_mask;
-};
-
-struct frame_attr_ext {
-	const char *fld_name;
-	uint8_t     faf_ext_offset;
-	uint16_t    fld_mask;
-};
-
-
-struct parse_err {
-	uint16_t    code;
-	const char *err_name;
-};
-
-/* Macro definitions */
-#define IS_ONE_BIT_FIELD(_mask)                 \
-(!((_mask) & ((_mask) - 1)) || (_mask == 1))
-
-int dpaa2_eth_load_wriop_soft_parser(struct dpaa2_dev_priv *priv,
-		enum dpni_soft_sequence_dest dest);
-int dpaa2_eth_enable_wriop_soft_parser(struct dpaa2_dev_priv *priv,
-		enum dpni_soft_sequence_dest dest);
-#endif /* _DPAA2_SPARSER_H_ */
diff --git a/drivers/net/dpaa2/meson.build b/drivers/net/dpaa2/meson.build
index 808dad8112..4f774f7c82 100644
--- a/drivers/net/dpaa2/meson.build
+++ b/drivers/net/dpaa2/meson.build
@@ -17,7 +17,6 @@ sources = files(
         'dpaa2_flow.c',
         'dpaa2_recycle.c',
         'dpaa2_rxtx.c',
-        'dpaa2_sparser.c',
         'dpaa2_ptp.c',
         'mc/dprtc.c',
         'mc/dpkg.c',
-- 
2.43.0

