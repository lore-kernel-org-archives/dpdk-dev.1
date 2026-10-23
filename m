Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FB0606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:43:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2B4164067B;
	Fri, 23 Oct 2026 15:43:55 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id B2F5440647
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:43:53 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6AD121A0021;
 Fri, 23 Oct 2026 15:43:53 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id A85131A003D;
 Fri, 23 Oct 2026 15:43:52 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id C95D718000B6;
 Fri, 23 Oct 2026 21:43:50 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>,
	Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH v4-S3 01/65] net/dpaa2: refactor and optimize Rx parser result
 decode
Date: Fri, 23 Oct 2026 19:12:41 +0530
Message-ID: <20261023134346.37727-2-prashant.gupta_3@nxp.com>
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

The hardware annotation (parse result) decode logic was scattered in
dpaa2_rxtx.c and dpaa2_parse_dump.h, mixing the fast-path parsing with
debug/print helpers and making the code hard to reuse and maintain.

Move the frame annotation and parse-result decode helpers into a new
dedicated header, dpaa2_parser_decode.h, and clean up the surrounding
Rx path:

  - Add dpaa2_parser_decode.h with the annotation/parse-result decode
    helpers, taking the annotation as a const pointer so callers cannot
    mutate the hardware annotation area.
  - Replace the compile-time/static print path with a runtime devarg
    "drv_rx_print_parser_result", so the parser result dump can be
    enabled per device without rebuilding.
  - Pass the soft parser protocol (priv->sp_protocol) into the decode
    helpers so soft parser (SP) and VLAN/checksum handling is correct.
  - Use rte_memcpy / rte_cpu_to_be_64 consistently and tidy up the log
    messages.

Optimize dpaa2_dev_rx_parse_new():

  - Precompute the common "ETH + L3 + L4" packet types as
    DPAA2_FAST_PATH_PTYPE_ETH_IPV4[_UDP/_TCP] / _IPV6[...] macros and use
    them in the switch, instead of OR-ing RTE_PTYPE_* flags at runtime
    for every frame.
  - Reorder the switch cases so the most common traffic (IPv4/IPv6
    UDP/TCP) is matched first, reducing branch cost on the hot path.
  - Keep VLAN frames on the fast path: read the FRC parse summary through
    a union (dpaa2_psr_summary), mask off the VLAN bit, and resolve the
    packet type via the fast-path switch plus dpaa2_dev_rx_parse_vlan().
    Previously a VLAN tag made the frame miss the switch and fall into
    the slow path (dpaa2_dev_rx_parse_slow) for every packet; now the
    slow/FRC path is only used for the uncommon default case.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 doc/guides/nics/dpaa2.rst               |    6 +-
 drivers/net/dpaa2/dpaa2_ethdev.c        |   31 +-
 drivers/net/dpaa2/dpaa2_ethdev.h        |  173 ++--
 drivers/net/dpaa2/dpaa2_parse_dump.h    |  707 +++++++-------
 drivers/net/dpaa2/dpaa2_parser_decode.h | 1139 +++++++++++++++++++++++
 drivers/net/dpaa2/dpaa2_pmd_logs.h      |   17 +-
 drivers/net/dpaa2/dpaa2_rxtx.c          |  326 ++++---
 drivers/net/dpaa2/rte_pmd_dpaa2.h       |   13 +-
 8 files changed, 1826 insertions(+), 586 deletions(-)
 create mode 100644 drivers/net/dpaa2/dpaa2_parser_decode.h

diff --git a/doc/guides/nics/dpaa2.rst b/doc/guides/nics/dpaa2.rst
index 2928575208..60ca695f59 100644
--- a/doc/guides/nics/dpaa2.rst
+++ b/doc/guides/nics/dpaa2.rst
@@ -1,5 +1,5 @@
 ..  SPDX-License-Identifier: BSD-3-Clause
-    Copyright 2016,2020-2021 NXP
+    Copyright 2016,2020-2026 NXP
 
 
 DPAA2 Poll Mode Driver
@@ -484,6 +484,10 @@ Refer to the document :doc:`build_and_test` for details.
   to start dropping the error packets in hardware (parse errors).
   e.g. ``fslmc:dpni.1,drv_rx_parse_drop=1``
 
+* Use dev arg option ``drv_rx_print_parser_result=1`` print detailed hardware
+  parser result of every received packet (debug only, hurts Rx performance).
+  e.g. ``fslmc:dpni.1,drv_rx_print_parser_result=1``
+
 * Use dev arg option  ``drv_error_queue=1`` to enable Packets in Error queue.
   DPAA2 hardware drops the error packet in hardware. This option enables the
   hardware to not drop the error packet and let the driver dump the error
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 6afd641709..e69dc5b9a2 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -1,6 +1,6 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  * Copyright (c) 2016 Freescale Semiconductor, Inc. All rights reserved.
- * Copyright 2016-2025 NXP
+ * Copyright 2016-2026 NXP
  */
 
 #include <time.h>
@@ -36,6 +36,7 @@
 #define DRIVER_NO_PREFETCH_MODE "drv_no_prefetch"
 #define DRIVER_TX_CONF "drv_tx_conf"
 #define DRIVER_RX_PARSE_ERR_DROP "drv_rx_parse_drop"
+#define DRIVER_RX_PRINT_PARSER_RESULT "drv_rx_print_parser_result"
 #define DRIVER_ERROR_QUEUE  "drv_err_queue"
 #define DRIVER_NO_TAILDROP  "drv_no_taildrop"
 #define DRIVER_NO_DATA_STASHING "drv_no_data_stashing"
@@ -68,16 +69,13 @@ static uint64_t dev_tx_offloads_sup =
 		RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE;
 
 /* Tx offloads which cannot be disabled */
-static uint64_t dev_tx_offloads_nodis =
-		RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
+static uint64_t dev_tx_offloads_nodis = RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
 
 /* enable timestamp in mbuf */
 bool dpaa2_enable_ts[RTE_MAX_ETHPORTS];
 uint64_t dpaa2_timestamp_rx_dynflag;
 int dpaa2_timestamp_dynfield_offset = -1;
 
-bool dpaa2_print_parser_result;
-
 /* Rx descriptor limit when DPNI loads PFDRs in PEB */
 #define MAX_NB_RX_DESC_IN_PEB	11264
 static int total_nb_rx_desc;
@@ -3450,10 +3448,10 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 
 	PMD_INIT_FUNC_TRACE();
 
-	dpni_dev = rte_malloc(NULL, sizeof(struct fsl_mc_io), 0);
+	dpni_dev = rte_zmalloc(NULL, sizeof(struct fsl_mc_io), 0);
 	if (!dpni_dev) {
 		DPAA2_PMD_ERR("Memory allocation failed for dpni device");
-		return -1;
+		return -ENOMEM;
 	}
 	dpni_dev->regs = dpaa2_get_mcp_ptr(MC_PORTAL_INDEX);
 	eth_dev->process_private = dpni_dev;
@@ -3502,9 +3500,8 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	hw_id = dpaa2_dev->object_id;
 	ret = dpni_open(dpni_dev, CMD_PRI_LOW, hw_id, &priv->token);
 	if (ret) {
-		DPAA2_PMD_ERR(
-			     "Failure in opening dpni@%d with err code %d",
-			     hw_id, ret);
+		DPAA2_PMD_ERR("Failure in opening dpni@%d with err code %d",
+			hw_id, ret);
 		rte_free(dpni_dev);
 		return ret;
 	}
@@ -3516,20 +3513,19 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	ret = dpni_reset(dpni_dev, CMD_PRI_LOW, priv->token);
 	if (ret) {
 		DPAA2_PMD_ERR("Failure cleaning dpni@%d with err code %d",
-			      hw_id, ret);
+			hw_id, ret);
 		goto init_err;
 	}
 
 	ret = dpni_get_attributes(dpni_dev, CMD_PRI_LOW, priv->token, &attr);
 	if (ret) {
-		DPAA2_PMD_ERR(
-			     "Failure in get dpni@%d attribute, err code %d",
-			     hw_id, ret);
+		DPAA2_PMD_ERR("Failure in get dpni@%d attribute, err code %d",
+			hw_id, ret);
 		goto init_err;
 	}
 
 	ret = dpni_get_api_version(dpni_dev, CMD_PRI_LOW, &priv->dpni_ver_major,
-				   &priv->dpni_ver_minor);
+			&priv->dpni_ver_minor);
 	if (ret) {
 		DPAA2_PMD_ERR("Failure in get dpni@%d API version, err code %d",
 			hw_id, ret);
@@ -3590,8 +3586,8 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 		DPAA2_PMD_INFO("Drop parse error packets in hw");
 	}
 
-	if (getenv("DPAA2_PRINT_RX_PARSER_RESULT"))
-		dpaa2_print_parser_result = 1;
+	if (dpaa2_get_devargs(dev->devargs, DRIVER_RX_PRINT_PARSER_RESULT))
+		priv->flags |= DPAA2_RX_PRINT_PSR_RESULT_FLAG;
 
 	/* Allocate memory for hardware structure for queues */
 	ret = dpaa2_alloc_rx_tx_queues(eth_dev);
@@ -3993,6 +3989,7 @@ RTE_PMD_REGISTER_PARAM_STRING(NET_DPAA2_PMD_DRIVER_NAME,
 		DRIVER_NO_PREFETCH_MODE "=<int>"
 		DRIVER_TX_CONF "=<int>"
 		DRIVER_RX_PARSE_ERR_DROP "=<int>"
+		DRIVER_RX_PRINT_PARSER_RESULT "=<int>"
 		DRIVER_ERROR_QUEUE "=<int>"
 		DRIVER_NO_TAILDROP "=<int>"
 		DRIVER_NO_DATA_STASHING "=<int>");
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index d467e7b695..5b51414000 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
  *   Copyright (c) 2015-2016 Freescale Semiconductor, Inc. All rights reserved.
- *   Copyright 2016-2025 NXP
+ *   Copyright 2016-2026 NXP
  *
  */
 
@@ -21,6 +21,8 @@
 #include <mc/fsl_dpmac.h>
 
 #include "base/dpaa2_hw_dpni_annot.h"
+#include "dpaa2_parser_decode.h"
+#include "dpaa2_parse_dump.h"
 
 #define DPAA2_MIN_RX_BUF_SIZE 512
 #define DPAA2_MAX_RX_PKT_LEN  10240 /*WRIOP support*/
@@ -102,6 +104,8 @@
 
 #define DPAA2_RX_ERROR_QUEUE_FLAG	RTE_BIT32(11)
 
+#define DPAA2_RX_PRINT_PSR_RESULT_FLAG RTE_BIT32(12)
+
 /* DPDMUX index for DPMAC */
 #define DPAA2_DPDMUX_DPMAC_IDX 0
 
@@ -124,43 +128,78 @@
 	RTE_ETH_RSS_PPPOE)
 
 /* LX2 FRC Parsed values (Little Endian) */
-#define DPAA2_PKT_TYPE_ETHER		0x0060
-#define DPAA2_PKT_TYPE_IPV4		0x0000
-#define DPAA2_PKT_TYPE_IPV6		0x0020
+#define DPAA2_PKT_TYPE_ETHER \
+	(DPAA2_PSR_SUMMARY_NONIP << DPAA2_PSR_SUMMARY_NON_IP_L2_BIT_SIZE)
+#define DPAA2_PKT_TYPE_IPV4 \
+	(DPAA2_PSR_SUMMARY_IPV4 << DPAA2_PSR_SUMMARY_L4_BIT_SIZE)
+#define DPAA2_PKT_TYPE_IPV6 \
+	(DPAA2_PSR_SUMMARY_IPV6 << DPAA2_PSR_SUMMARY_L4_BIT_SIZE)
+
+/**Tunnel*/
+#define DPAA2_PKT_TYPE_L3_EXT \
+	(DPAA2_PSR_SUMMARY_L4_EXT << DPAA2_PSR_SUMMARY_L4_EXT_L3_POS)
+#define DPAA2_PKT_TYPE_L3_EXT_IPV4 \
+	(DPAA2_PSR_SUMMARY_IPV4 << DPAA2_PSR_SUMMARY_L4_EXT_BIT_SIZE)
+#define DPAA2_PKT_TYPE_L3_EXT_IPV6 \
+	(DPAA2_PSR_SUMMARY_IPV6 << DPAA2_PSR_SUMMARY_L4_EXT_BIT_SIZE)
+#define DPAA2_PKT_TYPE_IPV4_EXT \
+	(DPAA2_PKT_TYPE_L3_EXT | DPAA2_PKT_TYPE_L3_EXT_IPV4)
+#define DPAA2_PKT_TYPE_IPV6_EXT \
+	(DPAA2_PKT_TYPE_L3_EXT | DPAA2_PKT_TYPE_L3_EXT_IPV6)
+#define DPAA2_PKT_TYPE_IPV4_EXT_GRE_IPV4 \
+	(DPAA2_PKT_TYPE_IPV4_EXT | DPAA2_PSR_SUMMARY_GRE_IPV4)
+#define DPAA2_PKT_TYPE_IPV4_EXT_GRE_IPV4_UDP_TCP \
+	(DPAA2_PKT_TYPE_IPV4_EXT | DPAA2_PSR_SUMMARY_GRE_IPV4_UDP_TCP)
+#define DPAA2_PKT_TYPE_IPV4_EXT_GRE_IPV6 \
+	(DPAA2_PKT_TYPE_IPV4_EXT | DPAA2_PSR_SUMMARY_GRE_IPV6)
+#define DPAA2_PKT_TYPE_IPV4_EXT_GRE_IPV6_UDP_TCP \
+	(DPAA2_PKT_TYPE_IPV4_EXT | DPAA2_PSR_SUMMARY_GRE_IPV6_UDP_TCP)
+#define DPAA2_PKT_TYPE_IPV6_EXT_GRE_IPV4 \
+	(DPAA2_PKT_TYPE_IPV6_EXT | DPAA2_PSR_SUMMARY_GRE_IPV4)
+#define DPAA2_PKT_TYPE_IPV6_EXT_GRE_IPV4_UDP_TCP \
+	(DPAA2_PKT_TYPE_IPV6_EXT | DPAA2_PSR_SUMMARY_GRE_IPV4_UDP_TCP)
+#define DPAA2_PKT_TYPE_IPV6_EXT_GRE_IPV6 \
+	(DPAA2_PKT_TYPE_IPV6_EXT | DPAA2_PSR_SUMMARY_GRE_IPV6)
+#define DPAA2_PKT_TYPE_IPV6_EXT_GRE_IPV6_UDP_TCP \
+	(DPAA2_PKT_TYPE_IPV6_EXT | DPAA2_PSR_SUMMARY_GRE_IPV6_UDP_TCP)
+
 #define DPAA2_PKT_TYPE_IPV4_FRAG \
-			(0x0001 | DPAA2_PKT_TYPE_IPV4)
+	(DPAA2_PSR_SUMMARY_IP_FRAG | DPAA2_PKT_TYPE_IPV4)
 #define DPAA2_PKT_TYPE_IPV6_FRAG \
-			(0x0001 | DPAA2_PKT_TYPE_IPV6)
+	(DPAA2_PSR_SUMMARY_IP_FRAG | DPAA2_PKT_TYPE_IPV6)
 #define DPAA2_PKT_TYPE_IPV4_TCP \
-			(0x000e | DPAA2_PKT_TYPE_IPV4)
+	(DPAA2_PSR_SUMMARY_TCP | DPAA2_PKT_TYPE_IPV4)
 #define DPAA2_PKT_TYPE_IPV6_TCP \
-			(0x000e | DPAA2_PKT_TYPE_IPV6)
+	(DPAA2_PSR_SUMMARY_TCP | DPAA2_PKT_TYPE_IPV6)
 #define DPAA2_PKT_TYPE_IPV4_UDP \
-			(0x0010 | DPAA2_PKT_TYPE_IPV4)
+	(DPAA2_PSR_SUMMARY_UDP | DPAA2_PKT_TYPE_IPV4)
 #define DPAA2_PKT_TYPE_IPV6_UDP \
-			(0x0010 | DPAA2_PKT_TYPE_IPV6)
-#define DPAA2_PKT_TYPE_IPV4_SCTP	\
-			(0x000f | DPAA2_PKT_TYPE_IPV4)
-#define DPAA2_PKT_TYPE_IPV6_SCTP	\
-			(0x000f | DPAA2_PKT_TYPE_IPV6)
+	(DPAA2_PSR_SUMMARY_UDP | DPAA2_PKT_TYPE_IPV6)
+#define DPAA2_PKT_TYPE_IPV4_SCTP \
+	(DPAA2_PSR_SUMMARY_SCTP | DPAA2_PKT_TYPE_IPV4)
+#define DPAA2_PKT_TYPE_IPV6_SCTP \
+	(DPAA2_PSR_SUMMARY_SCTP | DPAA2_PKT_TYPE_IPV6)
 #define DPAA2_PKT_TYPE_IPV4_ICMP \
-			(0x0003 | DPAA2_PKT_TYPE_IPV4_FRAG)
+	(DPAA2_PSR_SUMMARY_ICMP | DPAA2_PKT_TYPE_IPV4)
 #define DPAA2_PKT_TYPE_IPV6_ICMP \
-			(0x0003 | DPAA2_PKT_TYPE_IPV6_FRAG)
+	(DPAA2_PSR_SUMMARY_ICMP | DPAA2_PKT_TYPE_IPV6)
 #define DPAA2_PKT_TYPE_IPV4_ESP \
-			(0x0005 | DPAA2_PKT_TYPE_IPV4)
+	(DPAA2_PSR_SUMMARY_IPSEC_ESP | DPAA2_PKT_TYPE_IPV4)
 #define DPAA2_PKT_TYPE_IPV6_ESP \
-			(0x0005 | DPAA2_PKT_TYPE_IPV6)
+	(DPAA2_PSR_SUMMARY_IPSEC_ESP | DPAA2_PKT_TYPE_IPV6)
 #define DPAA2_PKT_TYPE_IPV4_GTPU \
-			(0x0014 | DPAA2_PKT_TYPE_IPV4)
+	(DPAA2_PSR_SUMMARY_GTPU | DPAA2_PKT_TYPE_IPV4)
 #define DPAA2_PKT_TYPE_IPV6_GTPU \
-			(0x0014 | DPAA2_PKT_TYPE_IPV6)
+	(DPAA2_PSR_SUMMARY_GTPU | DPAA2_PKT_TYPE_IPV6)
 #define DPAA2_PKT_TYPE_IPV4_GTPC \
-			(0x0015 | DPAA2_PKT_TYPE_IPV4)
+	(DPAA2_PSR_SUMMARY_GTPC | DPAA2_PKT_TYPE_IPV4)
 #define DPAA2_PKT_TYPE_IPV6_GTPC \
-			(0x0015 | DPAA2_PKT_TYPE_IPV6)
-#define DPAA2_PKT_TYPE_VLAN_1		0x0160
-#define DPAA2_PKT_TYPE_VLAN_2		0x0260
+	(DPAA2_PSR_SUMMARY_GTPC | DPAA2_PKT_TYPE_IPV6)
+
+#define DPAA2_PKT_TYPE_VLAN_1	0x0100
+#define DPAA2_PKT_TYPE_VLAN_2	0x0200
+#define DPAA2_PKT_TYPE_VLAN \
+	(DPAA2_PKT_TYPE_VLAN_1 | DPAA2_PKT_TYPE_VLAN_2)
 
 /* mac counters */
 #define DPAA2_MAC_NUM_STATS            (DPMAC_CNT_EGR_CONTROL_FRAME + 1)
@@ -195,7 +234,17 @@ extern const struct rte_flow_ops dpaa2_flow_ops;
 
 extern const struct rte_tm_ops dpaa2_tm_ops;
 
-extern bool dpaa2_print_parser_result;
+#define DPAA2_FS_FLC_FS_MARK_OFFSET \
+	(DPAA2_FLC_DATA_STASHING + DPAA2_FLC_STASHING_MAX_BIT_SIZE)
+
+#define DPAA2_FS_FLC_TC_OFFSET \
+	(DPAA2_FS_FLC_FS_MARK_OFFSET + DPAA2_FLC_STASHING_MAX_BIT_SIZE)
+
+#define DPAA2_FS_FLC_TC_BIT_SIZE (sizeof(uint8_t) * 8)
+#define DPAA2_FS_FLC_TC_MASK ((1 << DPAA2_FS_FLC_TC_BIT_SIZE) - 1)
+
+#define DPAA2_FS_FLC_FLOW_OFFSET \
+	(DPAA2_FS_FLC_TC_OFFSET + DPAA2_FS_FLC_TC_BIT_SIZE)
 
 #define DPAA2_FAPR_SIZE \
 	(sizeof(struct dpaa2_annot_hdr) - \
@@ -270,42 +319,6 @@ enum dpaa2_ecpri_fafe_type {
 #define DPAA2_PR_L5_OFF_OFFSET 31
 #define DPAA2_PR_NXTHDR_OFF_OFFSET 34
 
-/* Set by SP for vxlan distribution start*/
-#define DPAA2_VXLAN_IN_TCI_OFFSET 16
-
-#define DPAA2_VXLAN_IN_DADDR0_OFFSET 20
-#define DPAA2_VXLAN_IN_DADDR1_OFFSET 22
-#define DPAA2_VXLAN_IN_DADDR2_OFFSET 24
-#define DPAA2_VXLAN_IN_DADDR3_OFFSET 25
-#define DPAA2_VXLAN_IN_DADDR4_OFFSET 26
-#define DPAA2_VXLAN_IN_DADDR5_OFFSET 28
-
-#define DPAA2_VXLAN_IN_SADDR0_OFFSET 29
-#define DPAA2_VXLAN_IN_SADDR1_OFFSET 32
-#define DPAA2_VXLAN_IN_SADDR2_OFFSET 33
-#define DPAA2_VXLAN_IN_SADDR3_OFFSET 35
-#define DPAA2_VXLAN_IN_SADDR4_OFFSET 41
-#define DPAA2_VXLAN_IN_SADDR5_OFFSET 42
-
-#define DPAA2_VXLAN_VNI_OFFSET 43
-#define DPAA2_VXLAN_IN_TYPE_OFFSET 46
-/* Set by SP for vxlan distribution end*/
-
-/* ECPRI shares SP context with VXLAN*/
-#define DPAA2_ECPRI_MSG_OFFSET DPAA2_VXLAN_VNI_OFFSET
-
-#define DPAA2_FS_FLC_FS_MARK_OFFSET \
-	(DPAA2_FLC_DATA_STASHING + DPAA2_FLC_STASHING_MAX_BIT_SIZE)
-
-#define DPAA2_FS_FLC_TC_OFFSET \
-	(DPAA2_FS_FLC_FS_MARK_OFFSET + DPAA2_FLC_STASHING_MAX_BIT_SIZE)
-
-#define DPAA2_FS_FLC_TC_BIT_SIZE (sizeof(uint8_t) * 8)
-#define DPAA2_FS_FLC_TC_MASK ((1 << DPAA2_FS_FLC_TC_BIT_SIZE) - 1)
-
-#define DPAA2_FS_FLC_FLOW_OFFSET \
-	(DPAA2_FS_FLC_TC_OFFSET + DPAA2_FS_FLC_TC_BIT_SIZE)
-
 #define DPAA2_ECPRI_MAX_EXTRACT_NB 8
 
 struct ipv4_sd_addr_extract_rule {
@@ -459,6 +472,7 @@ struct dpaa2_dev_priv {
 	uint64_t rx_timestamp;
 	/*stores timestamp of last received tx confirmation packet on dev*/
 	uint64_t tx_timestamp;
+
 	/* stores pointer to next tx_conf queue that should be processed,
 	 * it corresponds to last packet transmitted
 	 */
@@ -467,6 +481,7 @@ struct dpaa2_dev_priv {
 	struct rte_eth_dev *eth_dev; /**< Pointer back to holding ethdev */
 	rte_spinlock_t lpbk_qp_lock;
 
+	bool sp_protocol;
 	uint8_t channel_inuse;
 	/* Rx-interrupt mode latched at the first dev_configure */
 	uint8_t intr_mode;
@@ -495,6 +510,42 @@ static inline int dpaa2_dev_cmp_dpni_ver(struct dpaa2_dev_priv *priv,
 	return priv->dpni_ver_major - ver_major;
 }
 
+static inline void
+dpaa2_dev_rx_print_parser_result(struct dpaa2_dev_priv *priv,
+	const struct qbman_fd *fd, const struct rte_mbuf *m)
+{
+	size_t fd_addr;
+	void *hw_annot_addr;
+	uint32_t i, tc, flow;
+	struct dpaa2_queue *rxq;
+
+	if (likely(!(priv->flags & DPAA2_RX_PRINT_PSR_RESULT_FLAG)))
+		return;
+
+	if (dpaa2_svr_family == SVR_LX2160A)
+		dpaa2_print_fd_frc(fd);
+
+	fd_addr = (size_t)DPAA2_IOVA_TO_VADDR(DPAA2_GET_FD_ADDR(fd));
+	hw_annot_addr = (void *)(fd_addr + DPAA2_FD_PTA_SIZE);
+	dpaa2_print_parse_result(hw_annot_addr, priv->sp_protocol);
+	if (m->ol_flags & RTE_MBUF_F_RX_FDIR) {
+		flow = m->hash.fdir.hi & RTE_DPAA2_MBUF_F_RX_FDIR_FLOW_MASK;
+		tc = m->hash.fdir.hi >> RTE_DPAA2_MBUF_F_RX_FDIR_TC_OFFSET;
+		for (i = 0; i < MAX_RX_QUEUES; i++) {
+			rxq = priv->rx_vq[i];
+			if (!rxq)
+				continue;
+			if (rxq->tc_index == tc && rxq->flow_id == flow) {
+				dpaa2_dump_print("Directed to TC%d-flow%d(rxq%d)\r\n",
+					tc, flow, i);
+				break;
+			}
+		}
+	} else if (m->ol_flags & RTE_MBUF_F_RX_RSS_HASH) {
+		dpaa2_dump_print("Balanced with hash(0x%08x)\r\n", m->hash.rss);
+	}
+}
+
 int dpaa2_distset_to_dpkg_profile_cfg(uint64_t req_dist_set,
 				      struct dpkg_profile_cfg *kg_cfg);
 
diff --git a/drivers/net/dpaa2/dpaa2_parse_dump.h b/drivers/net/dpaa2/dpaa2_parse_dump.h
index bcab3bf0cb..3ec9112ec9 100644
--- a/drivers/net/dpaa2/dpaa2_parse_dump.h
+++ b/drivers/net/dpaa2/dpaa2_parse_dump.h
@@ -1,374 +1,407 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
- *   Copyright 2022 NXP
+ *   Copyright 2022-2026 NXP
  *
  */
 
 #ifndef _DPAA2_PARSE_DUMP_H
 #define _DPAA2_PARSE_DUMP_H
 
-#include <rte_event_eth_rx_adapter.h>
-#include <rte_pmd_dpaa2.h>
+#include "dpaa2_parser_decode.h"
+#include "dpaa2_pmd_logs.h"
 
-#include <dpaa2_hw_pvt.h>
-#include "dpaa2_tm.h"
-
-#include <mc/fsl_dpni.h>
-#include <mc/fsl_mc_sys.h>
-
-#include "base/dpaa2_hw_dpni_annot.h"
-
-#define DPAA2_PR_PRINT printf
-
-struct dpaa2_faf_bit_info {
-	const char *name;
-	int position;
-};
+static inline void
+dpaa2_print_rocev2_parse_result(const struct dpaa2_psr_result_parse *psr)
+{
+	int i;
 
-struct dpaa2_fapr_field_info {
-	const char *name;
-	uint16_t value;
-};
+	dpaa2_dump_print("ROCEv2 opcode: 0x%02x\r\n", psr->word8.rocev2.opcode);
+	dpaa2_dump_print("ROCEv2 qp: ");
+	for (i = 0; i < ROCEV2_DEST_QP_SIZE; i++)
+		dpaa2_dump_print("0x%02x ", psr->word8.rocev2.dest_qp[i]);
 
-struct dpaa2_fapr_array {
-	union {
-		uint64_t pr_64[DPAA2_FAPR_SIZE / 8];
-		uint8_t pr[DPAA2_FAPR_SIZE];
-	};
-};
+	dpaa2_dump_print("\r\n");
+}
 
-#define NEXT_HEADER_NAME "Next Header"
-#define ETH_OFF_NAME "ETH OFFSET"
-#define VLAN_TCI_OFF_NAME "VLAN TCI OFFSET"
-#define LAST_ENTRY_OFF_NAME "LAST ETYPE Offset"
-#define L3_OFF_NAME "L3 Offset"
-#define L4_OFF_NAME "L4 Offset"
-#define L5_OFF_NAME "L5 Offset"
-#define NEXT_HEADER_OFF_NAME "Next Header Offset"
+static inline void
+dpaa2_print_geneve_parse_result(const struct dpaa2_psr_result_parse *psr)
+{
+	dpaa2_dump_print("GENEVE protocol: 0x%04x\r\n",
+		rte_be_to_cpu_16(psr->word8.geneve.protocol));
+	dpaa2_dump_print("GENEVE vni: %02x %02x %02x\r\n",
+		psr->word8.geneve.geneve_vni[0],
+		psr->word8.geneve.geneve_vni[1],
+		psr->word8.geneve.geneve_vni[2]);
+}
 
-static const
-struct dpaa2_fapr_field_info support_dump_fields[] = {
-	{
-		.name = NEXT_HEADER_NAME,
-	},
-	{
-		.name = ETH_OFF_NAME,
-	},
-	{
-		.name = VLAN_TCI_OFF_NAME,
-	},
-	{
-		.name = LAST_ENTRY_OFF_NAME,
-	},
-	{
-		.name = L3_OFF_NAME,
-	},
-	{
-		.name = L4_OFF_NAME,
-	},
-	{
-		.name = L5_OFF_NAME,
-	},
-	{
-		.name = NEXT_HEADER_OFF_NAME,
+static inline void
+dpaa2_print_vxlan_parse_result(const struct dpaa2_psr_result_parse *psr)
+{
+	struct rte_ether_hdr vxlan_in_eth;
+	uint16_t vxlan_vlan_tci, i;
+
+	vxlan_in_eth.dst_addr.addr_bytes[0] = psr->word5.vxlan_in_daddr0;
+	vxlan_in_eth.dst_addr.addr_bytes[1] = psr->word5.vxlan_in_daddr1;
+	vxlan_in_eth.dst_addr.addr_bytes[2] = psr->word6.vxlan_in_daddr2;
+	vxlan_in_eth.dst_addr.addr_bytes[3] = psr->word6.vxlan_in_daddr3;
+	vxlan_in_eth.dst_addr.addr_bytes[4] = psr->word6.vxlan_in_daddr4;
+	vxlan_in_eth.dst_addr.addr_bytes[5] = psr->word6.vxlan_in_daddr5;
+
+	vxlan_in_eth.src_addr.addr_bytes[0] = psr->word6.vxlan_in_saddr0;
+	vxlan_in_eth.src_addr.addr_bytes[1] = psr->word7.vxlan_in_saddr1;
+	vxlan_in_eth.src_addr.addr_bytes[2] = psr->word7.vxlan_in_saddr2;
+	vxlan_in_eth.src_addr.addr_bytes[3] = psr->word7.vxlan_in_saddr3;
+	vxlan_in_eth.src_addr.addr_bytes[4] = psr->word8.vxlan_in_saddr4;
+	vxlan_in_eth.src_addr.addr_bytes[5] = psr->word8.vxlan_in_saddr5;
+
+	vxlan_in_eth.ether_type = psr->word8.vxlan_eth_type;
+	vxlan_in_eth.ether_type = rte_be_to_cpu_16(vxlan_in_eth.ether_type);
+
+	dpaa2_dump_print("VXLAN inner eth:\r\n");
+	dpaa2_dump_print("dst addr: ");
+	for (i = 0; i < RTE_ETHER_ADDR_LEN; i++) {
+		if (i != 0)
+			dpaa2_dump_print(":");
+		dpaa2_dump_print("%02x", vxlan_in_eth.dst_addr.addr_bytes[i]);
 	}
-};
+	dpaa2_dump_print("\r\n");
+	dpaa2_dump_print("src addr: ");
+	for (i = 0; i < RTE_ETHER_ADDR_LEN; i++) {
+		if (i != 0)
+			dpaa2_dump_print(":");
+		dpaa2_dump_print("%02x", vxlan_in_eth.src_addr.addr_bytes[i]);
+	}
+	dpaa2_dump_print("\r\n");
+	dpaa2_dump_print("type: 0x%04x\r\n", vxlan_in_eth.ether_type);
+	if (vxlan_in_eth.ether_type == RTE_ETHER_TYPE_VLAN) {
+		rte_memcpy(&vxlan_vlan_tci,
+			&psr->word5.vxlan_vlan_tci, sizeof(uint16_t));
+		vxlan_vlan_tci = rte_be_to_cpu_16(vxlan_vlan_tci);
+		dpaa2_dump_print("vlan tci: 0x%04x\r\n", vxlan_vlan_tci);
+	}
+}
 
 static inline void
-dpaa2_print_ecpri(struct dpaa2_fapr_array *fapr)
+dpaa2_print_ecpri_parse_result(const struct dpaa2_psr_result_parse *psr)
 {
-	uint8_t ecpri_type;
+	uint8_t msg_type;
 	struct rte_ecpri_combined_msg_hdr ecpri_msg;
 
-	ecpri_type = fapr->pr[DPAA2_FAFE_PSR_OFFSET];
-	if ((ecpri_type >> 1) > 7) {
-		DPAA2_PR_PRINT("Invalid ECPRI type(0x%02x)\r\n",
-			ecpri_type);
-	} else {
-		DPAA2_PR_PRINT("ECPRI type %d present\r\n",
-			ecpri_type >> 1);
-		if (ecpri_type == ECPRI_FAFE_TYPE_0 ||
-			ecpri_type == ECPRI_FAFE_TYPE_1) {
-			/* Type 0 is identical to type1*/
-			ecpri_msg.type0.pc_id =
-				fapr->pr[DPAA2_ECPRI_MSG_OFFSET + 1];
-			ecpri_msg.type0.pc_id =
-				ecpri_msg.type0.pc_id << 8;
-			ecpri_msg.type0.pc_id |=
-				fapr->pr[DPAA2_ECPRI_MSG_OFFSET];
-
-			ecpri_msg.type0.seq_id =
-				fapr->pr[DPAA2_ECPRI_MSG_OFFSET + 3];
-			ecpri_msg.type0.seq_id =
-				ecpri_msg.type0.seq_id << 8;
-			ecpri_msg.type0.seq_id |=
-				fapr->pr[DPAA2_ECPRI_MSG_OFFSET + 2];
-
-			DPAA2_PR_PRINT("pc_id(0x%04x) seq_id(0x%04x)\r\n",
-				rte_be_to_cpu_16(ecpri_msg.type0.pc_id),
-				rte_be_to_cpu_16(ecpri_msg.type0.seq_id));
-		} else if (ecpri_type == ECPRI_FAFE_TYPE_2) {
-			ecpri_msg.type2.rtc_id =
-				fapr->pr[DPAA2_ECPRI_MSG_OFFSET + 1];
-			ecpri_msg.type2.rtc_id =
-				ecpri_msg.type2.rtc_id << 8;
-			ecpri_msg.type2.rtc_id |=
-				fapr->pr[DPAA2_ECPRI_MSG_OFFSET];
-
-			ecpri_msg.type2.seq_id =
-				fapr->pr[DPAA2_ECPRI_MSG_OFFSET + 3];
-			ecpri_msg.type2.seq_id =
-				ecpri_msg.type2.seq_id << 8;
-			ecpri_msg.type2.seq_id |=
-				fapr->pr[DPAA2_ECPRI_MSG_OFFSET + 2];
-
-			DPAA2_PR_PRINT("rtc_id(0x%04x) seq_id(0x%04x)\r\n",
-				rte_be_to_cpu_16(ecpri_msg.type2.rtc_id),
-				rte_be_to_cpu_16(ecpri_msg.type2.seq_id));
-		} else if (ecpri_type == ECPRI_FAFE_TYPE_3) {
-			DPAA2_PR_PRINT("ECPRI type3 extract not support\r\n");
-		} else if (ecpri_type == ECPRI_FAFE_TYPE_4) {
-			ecpri_msg.type4.rma_id =
-				fapr->pr[DPAA2_ECPRI_MSG_OFFSET];
-			ecpri_msg.type4.rw =
-				fapr->pr[DPAA2_ECPRI_MSG_OFFSET + 1] >> 4;
-			ecpri_msg.type4.rr =
-				fapr->pr[DPAA2_ECPRI_MSG_OFFSET + 1] & 0xf;
-
-			ecpri_msg.type4.ele_id =
-				fapr->pr[DPAA2_ECPRI_MSG_OFFSET + 3];
-			ecpri_msg.type4.ele_id =
-				ecpri_msg.type4.ele_id << 8;
-			ecpri_msg.type4.ele_id |=
-				fapr->pr[DPAA2_ECPRI_MSG_OFFSET + 2];
-
-			DPAA2_PR_PRINT("rma_id(0x%02x) rw(0x%02x)",
-				ecpri_msg.type4.rma_id, ecpri_msg.type4.rw);
-			DPAA2_PR_PRINT(" rr(0x%02x) ele_id(0x%04x)\r\n",
-				ecpri_msg.type4.rr,
-				rte_be_to_cpu_16(ecpri_msg.type4.ele_id));
-		} else if (ecpri_type == ECPRI_FAFE_TYPE_5) {
-			ecpri_msg.type5.msr_id =
-				fapr->pr[DPAA2_ECPRI_MSG_OFFSET];
-			ecpri_msg.type5.act_type =
-				fapr->pr[DPAA2_ECPRI_MSG_OFFSET + 1];
-
-			DPAA2_PR_PRINT("rma_id(0x%02x) rw(0x%02x)\r\n",
-				ecpri_msg.type5.msr_id,
-				ecpri_msg.type5.act_type);
-		} else if (ecpri_type == ECPRI_FAFE_TYPE_6) {
-			ecpri_msg.type6.rst_id =
-				fapr->pr[DPAA2_ECPRI_MSG_OFFSET + 1];
-			ecpri_msg.type6.rst_id =
-				ecpri_msg.type6.rst_id << 8;
-			ecpri_msg.type6.rst_id |=
-				fapr->pr[DPAA2_ECPRI_MSG_OFFSET];
-
-			ecpri_msg.type6.rst_op =
-				fapr->pr[DPAA2_ECPRI_MSG_OFFSET + 2];
-
-			DPAA2_PR_PRINT("rst_id(0x%04x) rst_op(0x%02x)\r\n",
-				rte_be_to_cpu_16(ecpri_msg.type6.rst_id),
-				ecpri_msg.type6.rst_op);
-		} else if (ecpri_type == ECPRI_FAFE_TYPE_7) {
-			ecpri_msg.type7.evt_id =
-				fapr->pr[DPAA2_ECPRI_MSG_OFFSET];
-			ecpri_msg.type7.evt_type =
-				fapr->pr[DPAA2_ECPRI_MSG_OFFSET + 1];
-			ecpri_msg.type7.seq =
-				fapr->pr[DPAA2_ECPRI_MSG_OFFSET + 2];
-			ecpri_msg.type7.number =
-				fapr->pr[DPAA2_ECPRI_MSG_OFFSET + 3];
+	msg_type = psr->word3.fafe.ecpri.msg_type;
+	if (msg_type > RTE_ECPRI_MSG_TYPE_IWF_DCTRL) {
+		dpaa2_dump_print("Invalid ECPRI message type(0x%02x)\r\n",
+			msg_type);
+		return;
+	}
 
-			DPAA2_PR_PRINT("evt_id(0x%02x) evt_type(0x%02x)",
-				ecpri_msg.type7.evt_id,
-				ecpri_msg.type7.evt_type);
-			DPAA2_PR_PRINT(" seq(0x%02x) number(0x%02x)\r\n",
-				ecpri_msg.type7.seq,
-				ecpri_msg.type7.number);
-		}
+	dpaa2_dump_print("ECPRI type %d present\r\n", msg_type);
+	rte_memcpy(ecpri_msg.dummy, psr->word8.sp_psr_ctx,
+		DPAA2_SP_PSR_CTX_LEN);
+	if (msg_type == RTE_ECPRI_MSG_TYPE_IQ_DATA ||
+		msg_type == RTE_ECPRI_MSG_TYPE_BIT_SEQ) {
+		dpaa2_dump_print("pc_id(0x%04x) seq_id(0x%04x)\r\n",
+			rte_be_to_cpu_16(ecpri_msg.type0.pc_id),
+			rte_be_to_cpu_16(ecpri_msg.type0.seq_id));
+	} else if (msg_type == RTE_ECPRI_MSG_TYPE_RTC_CTRL) {
+		dpaa2_dump_print("rtc_id(0x%04x) seq_id(0x%04x)\r\n",
+			rte_be_to_cpu_16(ecpri_msg.type2.rtc_id),
+			rte_be_to_cpu_16(ecpri_msg.type2.seq_id));
+	} else if (msg_type == RTE_ECPRI_MSG_TYPE_GEN_DATA) {
+		dpaa2_dump_print("ECPRI type3 extract not support\r\n");
+	} else if (msg_type == RTE_ECPRI_MSG_TYPE_RM_ACC) {
+		dpaa2_dump_print("rma_id(0x%02x) rw(0x%02x)",
+			ecpri_msg.type4.rma_id, ecpri_msg.type4.rw);
+		dpaa2_dump_print(" rr(0x%02x) ele_id(0x%04x)\r\n",
+			ecpri_msg.type4.rr,
+			rte_be_to_cpu_16(ecpri_msg.type4.ele_id));
+	} else if (msg_type == RTE_ECPRI_MSG_TYPE_DLY_MSR) {
+		dpaa2_dump_print("rma_id(0x%02x) rw(0x%02x)\r\n",
+			ecpri_msg.type5.msr_id,
+			ecpri_msg.type5.act_type);
+	} else if (msg_type == RTE_ECPRI_MSG_TYPE_RMT_RST) {
+		dpaa2_dump_print("rst_id(0x%04x) rst_op(0x%02x)\r\n",
+			rte_be_to_cpu_16(ecpri_msg.type6.rst_id),
+			ecpri_msg.type6.rst_op);
+	} else if (msg_type == RTE_ECPRI_MSG_TYPE_EVT_IND) {
+		dpaa2_dump_print("evt_id(0x%02x) evt_type(0x%02x)",
+			ecpri_msg.type7.evt_id,
+			ecpri_msg.type7.evt_type);
+		dpaa2_dump_print(" seq(0x%02x) number(0x%02x)\r\n",
+			ecpri_msg.type7.seq,
+			ecpri_msg.type7.number);
 	}
 }
 
 static inline void
-dpaa2_print_faf(struct dpaa2_fapr_array *fapr)
+dpaa2_print_fd_frc(const struct qbman_fd *fd)
 {
-	const int faf_bit_len = DPAA2_FAF_TOTAL_SIZE * 8;
-	struct dpaa2_faf_bit_info faf_bits[faf_bit_len];
-	int i, byte_pos, bit_pos, vxlan = 0, vxlan_vlan = 0;
-	struct rte_ether_hdr vxlan_in_eth;
-	uint16_t vxlan_vlan_tci;
-	int ecpri = 0;
-
-	for (i = 0; i < faf_bit_len; i++) {
-		faf_bits[i].position = i;
-		if (i == FAFE_VXLAN_IN_VLAN_FRAM)
-			faf_bits[i].name = "VXLAN VLAN Present";
-		else if (i == FAFE_VXLAN_IN_IPV4_FRAM)
-			faf_bits[i].name = "VXLAN IPV4 Present";
-		else if (i == FAFE_VXLAN_IN_IPV6_FRAM)
-			faf_bits[i].name = "VXLAN IPV6 Present";
-		else if (i == FAFE_VXLAN_IN_UDP_FRAM)
-			faf_bits[i].name = "VXLAN UDP Present";
-		else if (i == FAFE_VXLAN_IN_TCP_FRAM)
-			faf_bits[i].name = "VXLAN TCP Present";
-		else if (i == FAF_VXLAN_FRAM)
-			faf_bits[i].name = "VXLAN Present";
-		else if (i == FAF_ETH_FRAM)
-			faf_bits[i].name = "Ethernet MAC Present";
-		else if (i == FAF_VLAN_FRAM)
-			faf_bits[i].name = "VLAN 1 Present";
-		else if (i == FAF_IPV4_FRAM)
-			faf_bits[i].name = "IPv4 1 Present";
-		else if (i == FAF_IPV6_FRAM)
-			faf_bits[i].name = "IPv6 1 Present";
-		else if (i == FAF_IP_FRAG_FRAM)
-			faf_bits[i].name = "IP fragment Present";
-		else if (i == FAF_UDP_FRAM)
-			faf_bits[i].name = "UDP Present";
-		else if (i == FAF_TCP_FRAM)
-			faf_bits[i].name = "TCP Present";
-		else if (i == FAFE_ECPRI_FRAM)
-			faf_bits[i].name = "ECPRI Present";
+	const struct dpaa2_ingress_frc *frc;
+	const struct dpaa2_psr_summary *sum;
+	const union dpaa2_psr_summary_l *sum_l;
+	const char *l4_nm;
+
+	frc = (const void *)&fd->simple.frc;
+	dpaa2_dump_print("FRC faicfdv: %d\r\n", frc->faicfdv);
+	dpaa2_dump_print("FRC faswov: %d\r\n", frc->faswov);
+	dpaa2_dump_print("FRC faiadv: %d\r\n", frc->faiadv);
+	dpaa2_dump_print("FRC faprv: %d\r\n", frc->faprv);
+	dpaa2_dump_print("FRC faeadv: %d\r\n", frc->faeadv);
+	dpaa2_dump_print("FRC fasv: %d\r\n", frc->fasv);
+
+	sum = &frc->psr_sum.sum;
+	sum_l = &sum->sum_l;
+	dpaa2_dump_print("FRC Check sum err: %d\r\n", sum->checksum_err);
+	dpaa2_dump_print("FRC vlan: %d\r\n", sum->vlan);
+	if (sum_l->non_ip.non_ip == DPAA2_PSR_SUMMARY_NONIP) {
+		dpaa2_dump_print("FRC NON IP %s detected, l2: %d\r\n",
+			sum_l->non_ip.l2 == DPAA2_PSR_SUMMARY_ARP ?
+			"arp" :
+			sum_l->non_ip.l2 == DPAA2_PSR_SUMMARY_NONIP_PTP ?
+			"ptp" : "",
+			sum_l->non_ip.l2);
+	} else if (sum_l->l4_ext.l3 == DPAA2_PSR_SUMMARY_L4_EXT) {
+		dpaa2_dump_print("FRC L4 ext %s (%d) detected\r\n",
+			sum_l->l4_ext.ip == DPAA2_PSR_SUMMARY_IPV4 ?
+			"ipv4" : "ipv6", sum_l->l4_ext.l4_ext);
+	} else {
+		if (sum_l->l4.l4 == DPAA2_PSR_SUMMARY_IP_FRAG)
+			l4_nm = "fragment";
+		else if (sum_l->l4.l4 == DPAA2_PSR_SUMMARY_ICMP)
+			l4_nm = "icmp";
+		else if (sum_l->l4.l4 == DPAA2_PSR_SUMMARY_IPSEC_ESP)
+			l4_nm = "IPSec ESP";
+		else if (sum_l->l4.l4 == DPAA2_PSR_SUMMARY_TCP)
+			l4_nm = "tcp";
+		else if (sum_l->l4.l4 == DPAA2_PSR_SUMMARY_SCTP)
+			l4_nm = "sctp";
+		else if (sum_l->l4.l4 == DPAA2_PSR_SUMMARY_UDP)
+			l4_nm = "udp";
+		else if (sum_l->l4.l4 == DPAA2_PSR_SUMMARY_PTP)
+			l4_nm = "ptp";
+		else if (sum_l->l4.l4 == DPAA2_PSR_SUMMARY_UDP_ESP_IKE)
+			l4_nm = "udp/esp/ike";
+		else if (sum_l->l4.l4 == DPAA2_PSR_SUMMARY_GTPU)
+			l4_nm = "gtpu";
+		else if (sum_l->l4.l4 == DPAA2_PSR_SUMMARY_GTPC)
+			l4_nm = "gtpc";
+		else if (sum_l->l4.l4 == DPAA2_PSR_SUMMARY_VXLAN)
+			l4_nm = "vxlan";
 		else
-			faf_bits[i].name = "Check RM for this unusual frame";
-	}
-
-	DPAA2_PR_PRINT("Frame Annotation Flags:\r\n");
-	for (i = 0; i < faf_bit_len; i++) {
-		byte_pos = i / 8 + DPAA2_FAFE_PSR_OFFSET;
-		bit_pos = i % 8;
-		if (fapr->pr[byte_pos] & (1 << (7 - bit_pos))) {
-			DPAA2_PR_PRINT("FAF bit %d : %s\r\n",
-				faf_bits[i].position, faf_bits[i].name);
-			if (i == FAF_VXLAN_FRAM)
-				vxlan = 1;
-			else if (i == FAFE_ECPRI_FRAM)
-				ecpri = 1;
-		}
-	}
-
-	if (vxlan) {
-		vxlan_in_eth.dst_addr.addr_bytes[0] =
-			fapr->pr[DPAA2_VXLAN_IN_DADDR0_OFFSET];
-		vxlan_in_eth.dst_addr.addr_bytes[1] =
-			fapr->pr[DPAA2_VXLAN_IN_DADDR1_OFFSET];
-		vxlan_in_eth.dst_addr.addr_bytes[2] =
-			fapr->pr[DPAA2_VXLAN_IN_DADDR2_OFFSET];
-		vxlan_in_eth.dst_addr.addr_bytes[3] =
-			fapr->pr[DPAA2_VXLAN_IN_DADDR3_OFFSET];
-		vxlan_in_eth.dst_addr.addr_bytes[4] =
-			fapr->pr[DPAA2_VXLAN_IN_DADDR4_OFFSET];
-		vxlan_in_eth.dst_addr.addr_bytes[5] =
-			fapr->pr[DPAA2_VXLAN_IN_DADDR5_OFFSET];
-
-		vxlan_in_eth.src_addr.addr_bytes[0] =
-			fapr->pr[DPAA2_VXLAN_IN_SADDR0_OFFSET];
-		vxlan_in_eth.src_addr.addr_bytes[1] =
-			fapr->pr[DPAA2_VXLAN_IN_SADDR1_OFFSET];
-		vxlan_in_eth.src_addr.addr_bytes[2] =
-			fapr->pr[DPAA2_VXLAN_IN_SADDR2_OFFSET];
-		vxlan_in_eth.src_addr.addr_bytes[3] =
-			fapr->pr[DPAA2_VXLAN_IN_SADDR3_OFFSET];
-		vxlan_in_eth.src_addr.addr_bytes[4] =
-			fapr->pr[DPAA2_VXLAN_IN_SADDR4_OFFSET];
-		vxlan_in_eth.src_addr.addr_bytes[5] =
-			fapr->pr[DPAA2_VXLAN_IN_SADDR5_OFFSET];
-
-		vxlan_in_eth.ether_type =
-			fapr->pr[DPAA2_VXLAN_IN_TYPE_OFFSET];
-		vxlan_in_eth.ether_type =
-			vxlan_in_eth.ether_type << 8;
-		vxlan_in_eth.ether_type |=
-			fapr->pr[DPAA2_VXLAN_IN_TYPE_OFFSET + 1];
-
-		if (vxlan_in_eth.ether_type == RTE_ETHER_TYPE_VLAN)
-			vxlan_vlan = 1;
-		DPAA2_PR_PRINT("VXLAN inner eth:\r\n");
-		DPAA2_PR_PRINT("dst addr: ");
-		for (i = 0; i < RTE_ETHER_ADDR_LEN; i++) {
-			if (i != 0)
-				DPAA2_PR_PRINT(":");
-			DPAA2_PR_PRINT("%02x",
-				vxlan_in_eth.dst_addr.addr_bytes[i]);
-		}
-		DPAA2_PR_PRINT("\r\n");
-		DPAA2_PR_PRINT("src addr: ");
-		for (i = 0; i < RTE_ETHER_ADDR_LEN; i++) {
-			if (i != 0)
-				DPAA2_PR_PRINT(":");
-			DPAA2_PR_PRINT("%02x",
-				vxlan_in_eth.src_addr.addr_bytes[i]);
-		}
-		DPAA2_PR_PRINT("\r\n");
-		DPAA2_PR_PRINT("type: 0x%04x\r\n",
-			vxlan_in_eth.ether_type);
-		if (vxlan_vlan) {
-			vxlan_vlan_tci = fapr->pr[DPAA2_VXLAN_IN_TCI_OFFSET];
-			vxlan_vlan_tci = vxlan_vlan_tci << 8;
-			vxlan_vlan_tci |=
-				fapr->pr[DPAA2_VXLAN_IN_TCI_OFFSET + 1];
-
-			DPAA2_PR_PRINT("vlan tci: 0x%04x\r\n",
-				vxlan_vlan_tci);
-		}
+			l4_nm = "";
+		dpaa2_dump_print("FRC %s(%d) %s(%d) detected\r\n",
+			sum_l->l4.l3 == DPAA2_PSR_SUMMARY_IPV4 ?
+			"ipv4" : "ipv6", sum_l->l4.l3,
+			l4_nm, sum_l->l4.l4);
 	}
 
-	if (ecpri)
-		dpaa2_print_ecpri(fapr);
+	dpaa2_dump_print("FRC FAFE bit0~3: %d%d%d%d\r\n",
+		sum->fafe0, sum->fafe1, sum->fafe2, sum_l->l4.fafe3);
 }
 
 static inline void
-dpaa2_print_parse_result(struct dpaa2_annot_hdr *annotation)
+dpaa2_print_parse_result(const struct dpaa2_annot_hdr *annotation,
+	int is_sp)
 {
-	struct dpaa2_fapr_array fapr;
-	struct dpaa2_fapr_field_info
-		fapr_fields[sizeof(support_dump_fields) /
-		sizeof(struct dpaa2_fapr_field_info)];
-	uint64_t len, i;
-
-	memcpy(&fapr, &annotation->word3, DPAA2_FAPR_SIZE);
-	for (i = 0; i < (DPAA2_FAPR_SIZE / 8); i++)
-		fapr.pr_64[i] = rte_cpu_to_be_64(fapr.pr_64[i]);
-
-	memcpy(fapr_fields, support_dump_fields,
-		sizeof(support_dump_fields));
-
-	for (i = 0;
-		i < sizeof(fapr_fields) /
-		sizeof(struct dpaa2_fapr_field_info);
-		i++) {
-		if (!strcmp(fapr_fields[i].name, NEXT_HEADER_NAME)) {
-			fapr_fields[i].value = fapr.pr[DPAA2_PR_NXTHDR_OFFSET];
-			fapr_fields[i].value = fapr_fields[i].value << 8;
-			fapr_fields[i].value |=
-				fapr.pr[DPAA2_PR_NXTHDR_OFFSET + 1];
-		} else if (!strcmp(fapr_fields[i].name, ETH_OFF_NAME)) {
-			fapr_fields[i].value = fapr.pr[DPAA2_PR_ETH_OFF_OFFSET];
-		} else if (!strcmp(fapr_fields[i].name, VLAN_TCI_OFF_NAME)) {
-			fapr_fields[i].value = fapr.pr[DPAA2_PR_TCI_OFF_OFFSET];
-		} else if (!strcmp(fapr_fields[i].name, LAST_ENTRY_OFF_NAME)) {
-			fapr_fields[i].value =
-				fapr.pr[DPAA2_PR_LAST_ETYPE_OFFSET];
-		} else if (!strcmp(fapr_fields[i].name, L3_OFF_NAME)) {
-			fapr_fields[i].value = fapr.pr[DPAA2_PR_L3_OFF_OFFSET];
-		} else if (!strcmp(fapr_fields[i].name, L4_OFF_NAME)) {
-			fapr_fields[i].value = fapr.pr[DPAA2_PR_L4_OFF_OFFSET];
-		} else if (!strcmp(fapr_fields[i].name, L5_OFF_NAME)) {
-			fapr_fields[i].value = fapr.pr[DPAA2_PR_L5_OFF_OFFSET];
-		} else if (!strcmp(fapr_fields[i].name, NEXT_HEADER_OFF_NAME)) {
-			fapr_fields[i].value =
-				fapr.pr[DPAA2_PR_NXTHDR_OFF_OFFSET];
+	struct dpaa2_annot_hdr annot_convert;
+	uint64_t annot_size = sizeof(struct dpaa2_annot_hdr), offset = 0;
+	uint64_t *word;
+	const struct dpaa2_psr_result_parse *psr;
+	const struct dpaa2_fas_parse *fas;
+
+	rte_memcpy(&annot_convert, annotation, sizeof(struct dpaa2_annot_hdr));
+	while (annot_size) {
+		word = (uint64_t *)&annot_convert + offset;
+		*word = rte_cpu_to_be_64(*word);
+		offset++;
+		annot_size -= sizeof(uint64_t);
+	}
+	fas = (const void *)&annotation->word1;
+	psr = (const void *)&annot_convert.word3;
+
+	if (fas->discard)
+		dpaa2_dump_print("FAS discard\r\n");
+	if (fas->macsec)
+		dpaa2_dump_print("FAS MACSEC present\r\n");
+	if (fas->ptp)
+		dpaa2_dump_print("FAS PTP present\r\n");
+	if (fas->multicast)
+		dpaa2_dump_print("FAS Multicast present\r\n");
+	if (fas->broadcast)
+		dpaa2_dump_print("FAS Broadcast present\r\n");
+	if (fas->kse)
+		dpaa2_dump_print("FAS Invalid key or key size error\r\n");
+	if (fas->eofhe)
+		dpaa2_dump_print("FAS extract out of frame header\r\n");
+	if (fas->mnle)
+		dpaa2_dump_print("FAS Max number of chained lookups reached\r\n");
+	if (fas->tide)
+		dpaa2_dump_print("FAS Invalid table ID\r\n");
+	if (fas->piee)
+		dpaa2_dump_print("FAS Policer Initialization Entry Error\r\n");
+	if (fas->fle)
+		dpaa2_dump_print("FAS Frame Length Error\r\n");
+	if (fas->fpe)
+		dpaa2_dump_print("FAS Frame physical Error\r\n");
+	if (fas->pte)
+		dpaa2_dump_print("FAS Parser terminate early\r\n");
+	if (fas->isp)
+		dpaa2_dump_print("FAS Invalid SP instruction is encountered\r\n");
+	if (fas->phe)
+		dpaa2_dump_print("FAS Error during parsing\r\n");
+	if (fas->ble)
+		dpaa2_dump_print("FAS block limit is exceeded\r\n");
+	if (fas->l3cv)
+		dpaa2_dump_print("FAS L3 checksum validation is performed\r\n");
+	if (fas->l3ce)
+		dpaa2_dump_print("FAS L3 checksum error detected\r\n");
+	if (fas->l4cv)
+		dpaa2_dump_print("FAS L4 checksum validation is performed\r\n");
+	if (fas->l4ce)
+		dpaa2_dump_print("FAS L4 checksum error detected\r\n");
+	dpaa2_dump_print("FAS IFPID:%d PPID:%d, status:%02x\r\n",
+		fas->ifpid, fas->ppid, fas->status);
+
+	/** FAF error dump.*/
+	if (psr->word3.faf_l_be.arp_err)
+		dpaa2_dump_print("FAF ARP error detected\r\n");
+	if (psr->word3.faf_l_be.mpls_err)
+		dpaa2_dump_print("FAF MPLS error detected\r\n");
+	if (psr->word3.faf_l_be.pppoe_ppp_err)
+		dpaa2_dump_print("FAF PPPOE/PPP error detected\r\n");
+	if (psr->word3.faf_l_be.vlan_err)
+		dpaa2_dump_print("FAF vLAN error detected\r\n");
+	if (psr->word3.faf_l_be.llc_snap_err)
+		dpaa2_dump_print("FAF LLC/SNAP error detected\r\n");
+	if (psr->word3.faf_l_be.eth_err)
+		dpaa2_dump_print("FAF Ethernet error detected\r\n");
+	if (psr->word3.faf_l_be.psr_err)
+		dpaa2_dump_print("FAF Parser error detected\r\n");
+	if (psr->word3.faf_l_be.spsr_err)
+		dpaa2_dump_print("FAF Soft Parser error detected\r\n");
+	if (psr->word3.faf_l_be.vxlan_err)
+		dpaa2_dump_print("FAF VXLan error detected\r\n");
+	if (psr->word4.faf_h_be.esp_err)
+		dpaa2_dump_print("FAF ESP error detected\r\n");
+	if (psr->word4.faf_h_be.gtp_err)
+		dpaa2_dump_print("FAF GTP error detected\r\n");
+	if (psr->word4.faf_h_be.l4_spsr_err)
+		dpaa2_dump_print("FAF L4 soft Parser error detected\r\n");
+	if (psr->word4.faf_h_be.sctp_err)
+		dpaa2_dump_print("FAF SCTP error detected\r\n");
+	if (psr->word4.faf_h_be.ipsec_err)
+		dpaa2_dump_print("FAF IPSec error detected\r\n");
+	if (psr->word4.faf_h_be.tcp_err)
+		dpaa2_dump_print("FAF TCP error detected\r\n");
+	if (psr->word4.faf_h_be.udp_err)
+		dpaa2_dump_print("FAF UDP error detected\r\n");
+	if (psr->word4.faf_h_be.l3_spsr_err)
+		dpaa2_dump_print("FAF L3 soft Parser error detected\r\n");
+	if (psr->word4.faf_h_be.gre_err)
+		dpaa2_dump_print("FAF GRE error detected\r\n");
+	if (psr->word4.faf_h_be.min_encp_err)
+		dpaa2_dump_print("FAF Min.Encap error detected\r\n");
+	if (psr->word4.faf_h_be.ip_n_err)
+		dpaa2_dump_print("FAF IP.n error detected\r\n");
+	if (psr->word4.faf_h_be.ip_1_err)
+		dpaa2_dump_print("FAF IP.1 error detected\r\n");
+	if (psr->word4.faf_h_be.l2_spsr_err)
+		dpaa2_dump_print("FAF L2 soft parser error detected\r\n");
+
+	dpaa2_dump_print("Next Header: %04x\r\n",
+		rte_be_to_cpu_16(psr->word3.nxthdr));
+
+	if (is_sp) {
+		if (psr->word3.fafe.ecpri.ecpri) {
+			dpaa2_dump_print("FAFE ECPRI present, msg: %d\r\n",
+				psr->word3.fafe.ecpri.msg_type);
+		} else if (psr->word3.fafe.rocev2_tunnel.rocev2) {
+			dpaa2_dump_print("FAFE ROCEV2 present\r\n");
+		} else if (psr->word3.fafe.rocev2_tunnel.geneve) {
+			dpaa2_dump_print("FAFE GENEVE present\r\n");
+		} else {
+			if (psr->word3.fafe.rocev2_tunnel.in_vlan)
+				dpaa2_dump_print("FAFE TUNNEL vLAN present\r\n");
+			if (psr->word3.fafe.rocev2_tunnel.in_ipv4)
+				dpaa2_dump_print("FAFE TUNNEL IPv4 present\r\n");
+			if (psr->word3.fafe.rocev2_tunnel.in_ipv6)
+				dpaa2_dump_print("FAFE TUNNEL IPv6 present\r\n");
+			if (psr->word3.fafe.rocev2_tunnel.in_udp)
+				dpaa2_dump_print("FAFE TUNNEL UDP present\r\n");
+			if (psr->word3.fafe.rocev2_tunnel.in_tcp)
+				dpaa2_dump_print("FAFE TUNNEL TCP present\r\n");
 		}
+	} else {
+		dpaa2_dump_print("FAFE: 0x%02x\r\n", psr->word3.fafe.fafe_8b);
 	}
 
-	len = sizeof(fapr_fields) / sizeof(struct dpaa2_fapr_field_info);
-	DPAA2_PR_PRINT("Parse Result:\r\n");
-	for (i = 0; i < len; i++) {
-		DPAA2_PR_PRINT("%21s : 0x%02x\r\n",
-			fapr_fields[i].name, fapr_fields[i].value);
+	/** FAF popular protocol dump.*/
+	if (psr->word3.faf_l_be.arp)
+		dpaa2_dump_print("FAF ARP Present\r\n");
+	if (psr->word3.faf_l_be.mac)
+		dpaa2_dump_print("FAF Ethernet MAC Present\r\n");
+	if (psr->word3.faf_l_be.vxlan)
+		dpaa2_dump_print("FAF VXLan Present\r\n");
+	if (psr->word3.faf_l_be.ike)
+		dpaa2_dump_print("FAF IKE Present\r\n");
+	if (psr->word3.faf_l_be.ptp)
+		dpaa2_dump_print("FAF PTP Present\r\n");
+	if (psr->word4.faf_h_be.gtp)
+		dpaa2_dump_print("FAF GTP Present\r\n");
+	if (psr->word4.faf_h_be.sctp)
+		dpaa2_dump_print("FAF SCTP Present\r\n");
+	if (psr->word4.faf_h_be.ipsec)
+		dpaa2_dump_print("FAF IPSec Present\r\n");
+	if (psr->word4.faf_h_be.ipsec_esp)
+		dpaa2_dump_print("FAF IPSec ESP Present\r\n");
+	if (psr->word4.faf_h_be.ipsec_ah)
+		dpaa2_dump_print("FAF IPSec AH Present\r\n");
+	if (psr->word4.faf_h_be.gre)
+		dpaa2_dump_print("FAF GRE Present\r\n");
+	if (psr->word4.faf_h_be.icmp)
+		dpaa2_dump_print("FAF ICMP Present\r\n");
+	if (psr->word4.faf_h_be.ipv6_1)
+		dpaa2_dump_print("FAF IPv6 Present\r\n");
+	if (psr->word4.faf_h_be.ipv6_n)
+		dpaa2_dump_print("FAF last IPv6 Present\r\n");
+	if (psr->word4.faf_h_be.ipv4_1)
+		dpaa2_dump_print("FAF IPv4 Present\r\n");
+	if (psr->word4.faf_h_be.ipv4_n)
+		dpaa2_dump_print("FAF last IPv4 Present\r\n");
+	if (psr->word4.faf_h_be.ip_1_opt)
+		dpaa2_dump_print("FAF IP Present\r\n");
+	if (psr->word4.faf_h_be.ip_1_init_frag)
+		dpaa2_dump_print("FAF IP first fragment Present\r\n");
+	if (psr->word4.faf_h_be.ip_1_frag)
+		dpaa2_dump_print("FAF IP fragment Present\r\n");
+	if (psr->word4.faf_h_be.tcp)
+		dpaa2_dump_print("FAF TCP Present\r\n");
+	if (psr->word4.faf_h_be.udp)
+		dpaa2_dump_print("FAF UDP Present\r\n");
+
+	dpaa2_dump_print("Parser result eth header offset: %02x\r\n",
+		psr->word5.eth_off);
+	dpaa2_dump_print("Parser result TCI1 offset: %02x\r\n",
+		psr->word5.vlan_tci_1_off);
+	dpaa2_dump_print("Parser result last eth type offset: %02x\r\n",
+		psr->word5.last_etype_off);
+	dpaa2_dump_print("Parser result l3 header offset: %02x\r\n",
+		psr->word6.l3_off);
+	dpaa2_dump_print("Parser result l4 header offset: %02x\r\n",
+		psr->word6.l4_off);
+	dpaa2_dump_print("Parser result l5 header offset: %02x\r\n",
+		psr->word6.l5_off);
+	dpaa2_dump_print("Parser result next header offset: %02x\r\n",
+		psr->word7.nxthdr_off);
+
+	if (is_sp) {
+		if (psr->word3.faf_l_be.vxlan)
+			dpaa2_print_vxlan_parse_result(psr);
+		if (psr->word3.fafe.ecpri.ecpri)
+			dpaa2_print_ecpri_parse_result(psr);
+		if (psr->word3.fafe.rocev2_tunnel.rocev2)
+			dpaa2_print_rocev2_parse_result(psr);
+		if (psr->word3.fafe.rocev2_tunnel.geneve)
+			dpaa2_print_geneve_parse_result(psr);
 	}
-	dpaa2_print_faf(&fapr);
 }
-
-#endif
+#endif /* _DPAA2_PARSE_DUMP_H */
diff --git a/drivers/net/dpaa2/dpaa2_parser_decode.h b/drivers/net/dpaa2/dpaa2_parser_decode.h
new file mode 100644
index 0000000000..f07a70a826
--- /dev/null
+++ b/drivers/net/dpaa2/dpaa2_parser_decode.h
@@ -0,0 +1,1139 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ *
+ *   Copyright 2022-2026 NXP
+ *
+ */
+
+#ifndef _DPAA2_PARSER_DECODE_H
+#define _DPAA2_PARSER_DECODE_H
+
+#define DPAA2_BIT_SIZE(t) (sizeof(t) * 8)
+#define DPAA2_BIT_OFFSET(t, m) (offsetof(t, m) * 8)
+#define DPAA2_BIT_LAST_OFFSET(t) (DPAA2_BIT_SIZE(t) - 1)
+
+#define ROCEV2_DEST_QP_SIZE	3
+
+enum dpaa2_parser_protocol_id {
+	DPAA2_PARSER_MAC_ID,
+	DPAA2_PARSER_VLAN_ID,
+	DPAA2_PARSER_ICMP_ID,
+	DPAA2_PARSER_IP_ID,
+	DPAA2_PARSER_IPV4_ID,
+	DPAA2_PARSER_IPV6_ID,
+	DPAA2_PARSER_IP_FRAG_ID,
+	DPAA2_PARSER_GRE_ID,
+	DPAA2_PARSER_UDP_ID,
+	DPAA2_PARSER_TCP_ID,
+	DPAA2_PARSER_SCTP_ID,
+	DPAA2_PARSER_GTP_ID,
+	DPAA2_PARSER_IPSEC_AH_ID,
+	DPAA2_PARSER_IPSEC_ESP_ID,
+	DPAA2_PARSER_VXLAN_ID,
+	DPAA2_PARSER_TUNNEL_VLAN_ID,
+	DPAA2_PARSER_TUNNEL_IPV4_ID,
+	DPAA2_PARSER_TUNNEL_IPV6_ID,
+	DPAA2_PARSER_TUNNEL_UDP_ID,
+	DPAA2_PARSER_TUNNEL_TCP_ID,
+	DPAA2_PARSER_ECPRI_ID,
+	DPAA2_PARSER_ROCEV2_ID,
+	DPAA2_PARSER_GENEVE_ID
+};
+
+#define DPAA2_PSR_SUMMARY_NONIP 6
+#define DPAA2_PSR_SUMMARY_ARP 3
+#define DPAA2_PSR_SUMMARY_NONIP_PTP 4
+#define DPAA2_PSR_SUMMARY_MPLS 6
+
+#define DPAA2_PSR_SUMMARY_L4_EXT 2
+#define DPAA2_PSR_SUMMARY_IPV4 0
+#define DPAA2_PSR_SUMMARY_IPV6 1
+
+#define DPAA2_PSR_SUMMARY_GRE_IPV4 0
+#define DPAA2_PSR_SUMMARY_GRE_IPV4_UDP_TCP 1
+#define DPAA2_PSR_SUMMARY_GRE_IPV6 2
+#define DPAA2_PSR_SUMMARY_GRE_IPV6_UDP_TCP 3
+
+#define DPAA2_PSR_SUMMARY_IP_FRAG 1
+#define DPAA2_PSR_SUMMARY_ICMP 3
+#define DPAA2_PSR_SUMMARY_IPSEC_ESP 5
+#define DPAA2_PSR_SUMMARY_TCP 14
+#define DPAA2_PSR_SUMMARY_SCTP 15
+#define DPAA2_PSR_SUMMARY_UDP 16
+#define DPAA2_PSR_SUMMARY_PTP 18
+#define DPAA2_PSR_SUMMARY_UDP_ESP_IKE 19
+#define DPAA2_PSR_SUMMARY_GTPU 20
+#define DPAA2_PSR_SUMMARY_GTPC 21
+#define DPAA2_PSR_SUMMARY_VXLAN 27
+
+#define DPAA2_PSR_SUMMARY_L4_BIT_SIZE 5
+#define DPAA2_PSR_SUMMARY_L3_BIT_SIZE 2
+
+#define DPAA2_PSR_SUMMARY_L4_EXT_BIT_SIZE 4
+#define DPAA2_PSR_SUMMARY_L4_EXT_IP_BIT_SIZE 1
+#define DPAA2_PSR_SUMMARY_L4_EXT_L3_BIT_SIZE 2
+#define DPAA2_PSR_SUMMARY_L4_EXT_L3_POS \
+	(DPAA2_PSR_SUMMARY_L4_EXT_BIT_SIZE + \
+	DPAA2_PSR_SUMMARY_L4_EXT_IP_BIT_SIZE)
+
+#define DPAA2_PSR_SUMMARY_NON_IP_L2_BIT_SIZE 4
+#define DPAA2_PSR_SUMMARY_NON_IP_NON_IP_BIT_SIZE 3
+
+union __rte_packed_begin dpaa2_psr_summary_l {
+	struct {
+		uint8_t l4:DPAA2_PSR_SUMMARY_L4_BIT_SIZE;
+		uint8_t l3:DPAA2_PSR_SUMMARY_L3_BIT_SIZE;
+		uint8_t fafe3:1;
+	} l4;
+	struct {
+		uint8_t l4_ext:DPAA2_PSR_SUMMARY_L4_EXT_BIT_SIZE;
+		uint8_t ip:DPAA2_PSR_SUMMARY_L4_EXT_IP_BIT_SIZE;
+		uint8_t l3:DPAA2_PSR_SUMMARY_L4_EXT_L3_BIT_SIZE;
+		uint8_t fafe3:1;
+	} l4_ext;
+	struct {
+		uint8_t l2:DPAA2_PSR_SUMMARY_NON_IP_L2_BIT_SIZE;
+		uint8_t non_ip:DPAA2_PSR_SUMMARY_NON_IP_NON_IP_BIT_SIZE;
+		uint8_t fafe3:1;
+	} non_ip;
+} __rte_packed_end;
+
+struct __rte_packed_begin dpaa2_psr_summary {
+	union dpaa2_psr_summary_l sum_l;
+	uint8_t vlan:2;
+	uint8_t l2_l2_ext:2;
+	uint8_t fafe2:1;
+	uint8_t fafe1:1;
+	uint8_t fafe0:1;
+	uint8_t checksum_err:1;
+} __rte_packed_end;
+
+union __rte_packed_begin dpaa2_psr_sum_16b {
+	uint16_t sum_16b;
+	struct dpaa2_psr_summary sum;
+} __rte_packed_end;
+
+struct __rte_packed_begin dpaa2_ingress_frc {
+	uint32_t rsv0:10;
+
+	uint32_t faicfdv:1;
+	uint32_t faswov:1;
+	uint32_t faiadv:1;
+	uint32_t faprv:1;
+	uint32_t faeadv:1;
+	uint32_t fasv:1;
+	union dpaa2_psr_sum_16b psr_sum;
+} __rte_packed_end;
+
+/* Frame annotation status */
+struct __rte_packed_begin dpaa2_fas_parse {
+	uint32_t status:8;
+	uint32_t ppid:6;
+	uint32_t rsv4:2;
+	uint32_t ifpid:12;
+	uint32_t rsv3:4;
+	uint32_t l4ce:1;
+	uint32_t l4cv:1;
+	uint32_t l3ce:1;
+	uint32_t l3cv:1;
+	uint32_t ble:1;
+	uint32_t phe:1;
+	uint32_t isp:1;
+	uint32_t pte:1;
+	uint32_t rsv2:4;
+	uint32_t fpe:1;
+	uint32_t fle:1;
+	uint32_t piee:1;
+	uint32_t tide:1;
+	uint32_t mnle:1;
+	uint32_t eofhe:1;
+	uint32_t kse:1;
+	uint32_t rsv1:6;
+	uint32_t broadcast:1;
+	uint32_t multicast:1;
+	uint32_t ptp:1;
+	uint32_t rsv0:2;
+	uint32_t macsec:1;
+	uint32_t discard:1;
+} __rte_packed_end;
+
+union __rte_packed_begin dpaa2_fas_parse_32b {
+	uint32_t fas_32b;
+	struct dpaa2_fas_parse fas;
+} __rte_packed_end;
+
+struct __rte_packed_begin dpaa2_sp_fafe_ecpri {
+	uint8_t msg_type:5;
+	uint8_t non_used:2;
+	uint8_t ecpri:1; /**Always 1, FRC FAFE0*/
+} __rte_packed_end;
+
+struct __rte_packed_begin dpaa2_sp_fafe_rocev2_tunnel {
+	uint8_t in_vlan:1;
+	uint8_t in_udp:1;
+	uint8_t in_tcp:1;
+	uint8_t in_ipv6:1;
+	uint8_t in_ipv4:1; /**FRC FAFE3*/
+	uint8_t geneve:1; /**FRC FAFE2*/
+	uint8_t rocev2:1; /**FRC FAFE1*/
+	uint8_t non_used:1;
+} __rte_packed_end;
+
+union __rte_packed_begin dpaa2_sp_fafe_parse {
+	struct dpaa2_sp_fafe_ecpri ecpri;
+	struct dpaa2_sp_fafe_rocev2_tunnel rocev2_tunnel;
+	uint8_t fafe_8b;
+} __rte_packed_end;
+
+struct __rte_packed_begin dpaa2_faf_l_parse {
+	uint32_t arp_err:1;
+	uint32_t arp:1;
+	uint32_t mpls_err:1;
+	uint32_t mpls_n:1;
+	uint32_t mpls_1:1;
+	uint32_t pppoe_ppp_err:1;
+	uint32_t pppoe_ppp:1;
+	uint32_t vlan_err:1;
+
+	uint32_t gre_eth:1;
+	uint32_t vlan_n:1;
+	uint32_t vlan_1:1;
+	uint32_t llc_snap_err:1;
+	uint32_t unknown_llc_oui:1;
+	uint32_t llc_snap:1;
+	uint32_t eth_err:1;
+	uint32_t fip:1;
+
+	uint32_t fcoe:1;
+	uint32_t bpdu:1;
+	uint32_t broadcast:1;
+	uint32_t multicast:1;
+	uint32_t unicast:1;
+	uint32_t mac:1;
+	uint32_t psr_err:1;
+	uint32_t spsr_err:1;
+
+	uint32_t ike:1;
+	uint32_t eth_slow:1;
+	uint32_t vxlan_err:1;
+	uint32_t vxlan:1;
+	uint32_t ptp:1;
+	uint32_t vlan_prio:1;
+	uint32_t gtp_prim:1;
+	uint32_t i6_r_hdr2:1;
+} __rte_packed_end;
+
+struct __rte_packed_begin dpaa2_faf_l_parse_be {
+	uint32_t ike:1;
+	uint32_t eth_slow:1;
+	uint32_t vxlan_err:1;
+	uint32_t vxlan:1;
+	uint32_t ptp:1;
+	uint32_t vlan_prio:1;
+	uint32_t gtp_prim:1;
+	uint32_t i6_r_hdr2:1;
+
+	uint32_t fcoe:1;
+	uint32_t bpdu:1;
+	uint32_t broadcast:1;
+	uint32_t multicast:1;
+	uint32_t unicast:1;
+	uint32_t mac:1;
+	uint32_t psr_err:1;
+	uint32_t spsr_err:1;
+
+	uint32_t gre_eth:1;
+	uint32_t vlan_n:1;
+	uint32_t vlan_1:1;
+	uint32_t llc_snap_err:1;
+	uint32_t unknown_llc_oui:1;
+	uint32_t llc_snap:1;
+	uint32_t eth_err:1;
+	uint32_t fip:1;
+
+	uint32_t arp_err:1;
+	uint32_t arp:1;
+	uint32_t mpls_err:1;
+	uint32_t mpls_n:1;
+	uint32_t mpls_1:1;
+	uint32_t pppoe_ppp_err:1;
+	uint32_t pppoe_ppp:1;
+	uint32_t vlan_err:1;
+} __rte_packed_end;
+
+struct __rte_packed_begin dpaa2_faf_h_parse {
+	uint32_t i6_r_hdr1:1;
+	uint32_t l5_spsr:1;
+	uint32_t capwap_data:1;
+	uint32_t capwap_ctl:1;
+	uint32_t iscsi:1;
+	uint32_t esp_err:1;
+	uint32_t esp:1;
+	uint32_t gtp_err:1;
+
+	uint32_t gtp:1;
+	uint32_t l4_spsr_err:1;
+	uint32_t l4_unknown:1;
+	uint32_t dccp_err:1;
+	uint32_t dccp:1;
+	uint32_t sctp_err:1;
+	uint32_t sctp:1;
+	uint32_t ipsec_err:1;
+
+	uint32_t ipsec_ah:1;
+	uint32_t ipsec_esp:1;
+	uint32_t ipsec:1;
+	uint32_t tcp_err:1;
+	uint32_t tcp_3_5:1;
+	uint32_t tcp_6_11:1;
+	uint32_t tcp_opt:1;
+	uint32_t tcp:1;
+
+	uint32_t udp_err:1;
+	uint32_t udp:1;
+	uint32_t l3_spsr_err:1;
+	uint32_t l3_unknown:1;
+	uint32_t gre_err:1;
+	uint32_t gre_k:1;
+	uint32_t gre:1;
+	uint32_t min_encp_err:1;
+
+	uint32_t min_encp_s:1;
+	uint32_t min_encp:1;
+	uint32_t ip_n_err:1;
+	uint32_t udp_light:1;
+	uint32_t icmp_v6:1;
+	uint32_t igmp:1;
+	uint32_t icmp:1;
+	uint32_t ip_n_init_frag:1;
+
+	uint32_t ip_n_frag:1;
+	uint32_t ip_n_unknown:1;
+	uint32_t ip_n_opt:1;
+	uint32_t ip_1_err:1;
+	uint32_t ip_1_init_frag:1;
+	uint32_t ip_1_frag:1;
+	uint32_t ip_1_unknown:1;
+	uint32_t ip_1_opt:1;
+
+	uint32_t ipv6_n_multicast:1;
+	uint32_t ipv6_n_unicast:1;
+	uint32_t ipv6_n:1;
+	uint32_t ipv6_1_multicast:1;
+	uint32_t ipv6_1_unicast:1;
+	uint32_t ipv6_1:1;
+	uint32_t ipv4_n_broadcast:1;
+	uint32_t ipv4_n_multicast:1;
+
+	uint32_t ipv4_n_unicast:1;
+	uint32_t ipv4_n:1;
+	uint32_t ipv4_1_broadcast:1;
+	uint32_t ipv4_1_multicast:1;
+	uint32_t ipv4_1_unicast:1;
+	uint32_t ipv4_1:1;
+	uint32_t l2_spsr_err:1;
+	uint32_t l2_unknown:1;
+} __rte_packed_end;
+
+struct __rte_packed_begin dpaa2_faf_h_parse_be {
+	uint32_t ipv4_n_unicast:1;
+	uint32_t ipv4_n:1;
+	uint32_t ipv4_1_broadcast:1;
+	uint32_t ipv4_1_multicast:1;
+	uint32_t ipv4_1_unicast:1;
+	uint32_t ipv4_1:1;
+	uint32_t l2_spsr_err:1;
+	uint32_t l2_unknown:1;
+
+	uint32_t ipv6_n_multicast:1;
+	uint32_t ipv6_n_unicast:1;
+	uint32_t ipv6_n:1;
+	uint32_t ipv6_1_multicast:1;
+	uint32_t ipv6_1_unicast:1;
+	uint32_t ipv6_1:1;
+	uint32_t ipv4_n_broadcast:1;
+	uint32_t ipv4_n_multicast:1;
+
+	uint32_t ip_n_frag:1;
+	uint32_t ip_n_unknown:1;
+	uint32_t ip_n_opt:1;
+	uint32_t ip_1_err:1;
+	uint32_t ip_1_init_frag:1;
+	uint32_t ip_1_frag:1;
+	uint32_t ip_1_unknown:1;
+	uint32_t ip_1_opt:1;
+
+	uint32_t min_encp_s:1;
+	uint32_t min_encp:1;
+	uint32_t ip_n_err:1;
+	uint32_t udp_light:1;
+	uint32_t icmp_v6:1;
+	uint32_t igmp:1;
+	uint32_t icmp:1;
+	uint32_t ip_n_init_frag:1;
+
+	uint32_t udp_err:1;
+	uint32_t udp:1;
+	uint32_t l3_spsr_err:1;
+	uint32_t l3_unknown:1;
+	uint32_t gre_err:1;
+	uint32_t gre_k:1;
+	uint32_t gre:1;
+	uint32_t min_encp_err:1;
+
+	uint32_t ipsec_ah:1;
+	uint32_t ipsec_esp:1;
+	uint32_t ipsec:1;
+	uint32_t tcp_err:1;
+	uint32_t tcp_3_5:1;
+	uint32_t tcp_6_11:1;
+	uint32_t tcp_opt:1;
+	uint32_t tcp:1;
+
+	uint32_t gtp:1;
+	uint32_t l4_spsr_err:1;
+	uint32_t l4_unknown:1;
+	uint32_t dccp_err:1;
+	uint32_t dccp:1;
+	uint32_t sctp_err:1;
+	uint32_t sctp:1;
+	uint32_t ipsec_err:1;
+
+	uint32_t i6_r_hdr1:1;
+	uint32_t l5_spsr:1;
+	uint32_t capwap_data:1;
+	uint32_t capwap_ctl:1;
+	uint32_t iscsi:1;
+	uint32_t esp_err:1;
+	uint32_t esp:1;
+	uint32_t gtp_err:1;
+} __rte_packed_end;
+
+struct __rte_packed_begin dpaa2_annot_word3_parse {
+	struct dpaa2_faf_l_parse faf_l;
+	uint8_t rsv;
+	union dpaa2_sp_fafe_parse fafe;
+	rte_be16_t nxthdr;
+} __rte_packed_end;
+
+struct __rte_packed_begin dpaa2_ecpri_msg_rm_access {
+#if RTE_BYTE_ORDER == RTE_LITTLE_ENDIAN
+	uint32_t ele_id:16;		/**< Element ID */
+	uint32_t rr:4;			/**< Req/Resp */
+	uint32_t rw:4;			/**< Read/Write */
+	uint32_t rma_id:8;		/**< Remote Memory Access ID */
+#elif RTE_BYTE_ORDER == RTE_BIG_ENDIAN
+	uint32_t rma_id:8;		/**< Remote Memory Access ID */
+	uint32_t rw:4;			/**< Read/Write */
+	uint32_t rr:4;			/**< Req/Resp */
+	uint32_t ele_id:16;		/**< Element ID */
+#endif
+} __rte_packed_end;
+
+union __rte_packed_begin dpaa2_sp_ecpri_msg {
+	struct rte_ecpri_msg_iq_data type0;
+	struct rte_ecpri_msg_bit_seq type1;
+	struct rte_ecpri_msg_rtc_ctrl type2;
+	struct rte_ecpri_msg_bit_seq type3;
+	struct dpaa2_ecpri_msg_rm_access type4;
+	struct rte_ecpri_msg_delay_measure type5;
+	struct rte_ecpri_msg_remote_reset type6;
+	struct rte_ecpri_msg_event_ind type7;
+} __rte_packed_end;
+
+#define DPAA2_SP_PSR_CTX_LEN 5
+
+struct __rte_packed_begin dpaa2_sp_rocev2 {
+	uint8_t opcode;
+	uint8_t dest_qp[ROCEV2_DEST_QP_SIZE];
+} __rte_packed_end;
+
+struct __rte_packed_begin dpaa2_sp_geneve {
+	rte_be16_t protocol;
+	uint8_t geneve_vni[3];
+} __rte_packed_end;
+
+struct dpaa2_psr_result_word3 {
+	rte_be16_t nxthdr;
+	union dpaa2_sp_fafe_parse fafe;
+	uint8_t rsv;
+	struct dpaa2_faf_l_parse_be faf_l_be;
+};
+
+struct dpaa2_psr_result_word4 {
+	struct dpaa2_faf_h_parse_be faf_h_be;
+};
+
+struct dpaa2_psr_result_word5 {
+	union {
+		struct {
+			uint8_t shim_off1;
+			uint8_t shim_off2;
+		};
+		rte_be16_t vxlan_vlan_tci;
+	};
+	uint8_t ip_1_pid_off;
+	uint8_t eth_off;
+	union {
+		uint8_t llc_snap_off;
+		uint8_t vxlan_in_daddr0;
+	};
+	uint8_t vlan_tci_1_off;
+	union {
+		uint8_t vlan_tci_n_off;
+		uint8_t vxlan_in_daddr1;
+	};
+	uint8_t last_etype_off;
+};
+
+struct dpaa2_psr_result_word6 {
+	union {
+		uint8_t pppoe_off;
+		uint8_t vxlan_in_daddr2;
+	};
+	union {
+		uint8_t mpls_1_off;
+		uint8_t vxlan_in_daddr3;
+	};
+	union {
+		uint8_t mpls_n_off;
+		uint8_t vxlan_in_daddr4;
+	};
+	uint8_t l3_off;
+	union {
+		uint8_t ip_n_off;
+		uint8_t vxlan_in_daddr5;
+	};
+	union {
+		uint8_t gre_off;
+		uint8_t vxlan_in_saddr0;
+	};
+	uint8_t l4_off;
+	uint8_t l5_off;
+};
+
+struct dpaa2_psr_result_word7 {
+	union {
+		uint8_t route_hdr1_off;
+		uint8_t vxlan_in_saddr1;
+	};
+	union {
+		uint8_t route_hdr2_off;
+		uint8_t vxlan_in_saddr2;
+	};
+	uint8_t nxthdr_off;
+	union {
+		uint8_t ipv6_frag_off;
+		uint8_t vxlan_in_saddr3;
+	};
+	rte_be16_t gross_running_sum;
+	rte_be16_t running_sum;
+};
+
+struct dpaa2_psr_result_word8 {
+	uint8_t psr_err;
+	union {
+		uint8_t nxthdr_frag_off;
+		uint8_t vxlan_in_saddr4;
+	};
+	union {
+		uint8_t ip_n_pid_off;
+		uint8_t vxlan_in_saddr5;
+	};
+	union __rte_packed_begin {
+		uint8_t sp_psr_ctx[DPAA2_SP_PSR_CTX_LEN];
+		struct __rte_packed_begin {
+			uint8_t vxlan_vni[3];
+			rte_be16_t vxlan_eth_type;
+		} __rte_packed_end;
+		union dpaa2_sp_ecpri_msg ecpri_msg;
+		struct dpaa2_sp_rocev2 rocev2;
+		struct dpaa2_sp_geneve geneve;
+	} __rte_packed_end;
+};
+
+struct __rte_packed_begin dpaa2_psr_result_parse {
+	struct dpaa2_psr_result_word3 word3;
+	struct dpaa2_psr_result_word4 word4;
+	struct dpaa2_psr_result_word5 word5;
+	struct dpaa2_psr_result_word6 word6;
+	struct dpaa2_psr_result_word7 word7;
+	struct dpaa2_psr_result_word8 word8;
+} __rte_packed_end;
+
+#define DPAA2_PSR_RESULT_SIZE sizeof(struct dpaa2_psr_result_parse)
+
+#define DPAA2_FAFE_PSR_RESULT_OFFSET \
+	offsetof(struct dpaa2_psr_result_parse, word3.fafe)
+
+union __rte_packed_begin dpaa2_sp_fafe_parse_8b {
+	uint8_t fafe_8b;
+	union dpaa2_sp_fafe_parse fafe;
+} __rte_packed_end;
+
+union __rte_packed_begin dpaa2_faf_l_parse_32b {
+	uint32_t faf_l_32b;
+	struct dpaa2_faf_l_parse faf_l;
+} __rte_packed_end;
+
+union __rte_packed_begin dpaa2_faf_h_parse_64b {
+	uint64_t faf_h_64b;
+	struct dpaa2_faf_h_parse faf_h;
+} __rte_packed_end;
+
+/* Set by SP for vxlan distribution start*/
+#define DPAA2_VXLAN_IN_TCI_OFFSET \
+	offsetof(struct dpaa2_psr_result_parse, word5.vxlan_vlan_tci)
+#define DPAA2_VXLAN_IN_DADDR0_OFFSET \
+	offsetof(struct dpaa2_psr_result_parse, word5.vxlan_in_daddr0)
+#define DPAA2_VXLAN_IN_DADDR1_OFFSET \
+	offsetof(struct dpaa2_psr_result_parse, word5.vxlan_in_daddr1)
+#define DPAA2_VXLAN_IN_DADDR2_OFFSET \
+	offsetof(struct dpaa2_psr_result_parse, word6.vxlan_in_daddr2)
+#define DPAA2_VXLAN_IN_DADDR3_OFFSET \
+	offsetof(struct dpaa2_psr_result_parse, word6.vxlan_in_daddr3)
+#define DPAA2_VXLAN_IN_DADDR4_OFFSET \
+	offsetof(struct dpaa2_psr_result_parse, word6.vxlan_in_daddr4)
+#define DPAA2_VXLAN_IN_DADDR5_OFFSET \
+	offsetof(struct dpaa2_psr_result_parse, word6.vxlan_in_daddr5)
+
+#define DPAA2_VXLAN_IN_SADDR0_OFFSET \
+	offsetof(struct dpaa2_psr_result_parse, word6.vxlan_in_saddr0)
+#define DPAA2_VXLAN_IN_SADDR1_OFFSET \
+	offsetof(struct dpaa2_psr_result_parse, word7.vxlan_in_saddr1)
+#define DPAA2_VXLAN_IN_SADDR2_OFFSET \
+	offsetof(struct dpaa2_psr_result_parse, word7.vxlan_in_saddr2)
+#define DPAA2_VXLAN_IN_SADDR3_OFFSET \
+	offsetof(struct dpaa2_psr_result_parse, word7.vxlan_in_saddr3)
+#define DPAA2_VXLAN_IN_SADDR4_OFFSET \
+	offsetof(struct dpaa2_psr_result_parse, word8.vxlan_in_saddr4)
+#define DPAA2_VXLAN_IN_SADDR5_OFFSET \
+	offsetof(struct dpaa2_psr_result_parse, word8.vxlan_in_saddr5)
+
+#define DPAA2_VXLAN_VNI_OFFSET \
+	offsetof(struct dpaa2_psr_result_parse, word8.vxlan_vni[0])
+#define DPAA2_VXLAN_IN_TYPE_OFFSET \
+	offsetof(struct dpaa2_psr_result_parse, word8.vxlan_eth_type)
+/* Set by SP for vxlan distribution end*/
+
+#define DPAA2_ECPRI_MSG_OFFSET \
+	offsetof(struct dpaa2_psr_result_parse, word8.ecpri_msg)
+
+#define DPAA2_ROCEV2_OPCODE_OFFSET \
+	offsetof(struct dpaa2_psr_result_parse, word8.rocev2.opcode)
+
+#define DPAA2_ROCEV2_DST_QP_OFFSET \
+	offsetof(struct dpaa2_psr_result_parse, word8.rocev2.dest_qp[0])
+
+#define DPAA2_GENEVE_PROTOCOL_OFFSET \
+	offsetof(struct dpaa2_psr_result_parse, word8.geneve.protocol)
+
+#define DPAA2_GENEVE_VNI_OFFSET \
+	offsetof(struct dpaa2_psr_result_parse, word8.geneve.geneve_vni[0])
+
+static inline uint32_t
+dpaa2_spsr_fafe_bit_offset(union dpaa2_sp_fafe_parse fafe)
+{
+	uint32_t idx;
+
+	if (!fafe.fafe_8b)
+		return UINT32_MAX;
+	idx = rte_bsf32(fafe.fafe_8b);
+	return (DPAA2_BIT_LAST_OFFSET(union dpaa2_sp_fafe_parse_8b) - idx) +
+		DPAA2_BIT_OFFSET(struct dpaa2_psr_result_parse, word3.fafe);
+}
+
+static inline uint32_t
+dpaa2_psr_faf_l_bit_offset(struct dpaa2_faf_l_parse *faf_l)
+{
+	union dpaa2_faf_l_parse_32b tmp;
+	uint32_t idx;
+
+	tmp.faf_l = *faf_l;
+	if (!tmp.faf_l_32b)
+		return UINT32_MAX;
+	idx = rte_bsf32(tmp.faf_l_32b);
+	return (DPAA2_BIT_LAST_OFFSET(union dpaa2_faf_l_parse_32b) - idx) +
+		DPAA2_BIT_OFFSET(struct dpaa2_psr_result_parse, word3.faf_l_be);
+}
+
+static inline uint32_t
+dpaa2_psr_faf_h_bit_offset(struct dpaa2_faf_h_parse *faf_h)
+{
+	union dpaa2_faf_h_parse_64b tmp;
+	uint32_t idx;
+
+	tmp.faf_h = *faf_h;
+	if (!tmp.faf_h_64b)
+		return UINT32_MAX;
+	idx = rte_bsf64(tmp.faf_h_64b);
+	return (DPAA2_BIT_LAST_OFFSET(union dpaa2_faf_h_parse_64b) - idx) +
+		DPAA2_BIT_OFFSET(struct dpaa2_psr_result_parse, word4.faf_h_be);
+}
+
+static inline int
+dpaa2_protocol_psr_bit_offset(uint32_t *bit_offset,
+	enum dpaa2_parser_protocol_id protocol)
+{
+	struct dpaa2_faf_l_parse faf_l;
+	struct dpaa2_faf_h_parse faf_h;
+	union dpaa2_sp_fafe_parse fafe;
+
+	memset(&faf_l, 0, sizeof(faf_l));
+	memset(&faf_h, 0, sizeof(faf_h));
+	memset(&fafe, 0, sizeof(fafe));
+
+	if (protocol == DPAA2_PARSER_MAC_ID) {
+		faf_l.mac = 1;
+		*bit_offset = dpaa2_psr_faf_l_bit_offset(&faf_l);
+	} else if (protocol == DPAA2_PARSER_VLAN_ID) {
+		faf_l.vlan_1 = 1;
+		*bit_offset = dpaa2_psr_faf_l_bit_offset(&faf_l);
+	} else if (protocol == DPAA2_PARSER_ICMP_ID) {
+		faf_h.icmp = 1;
+		*bit_offset = dpaa2_psr_faf_h_bit_offset(&faf_h);
+	} else if (protocol == DPAA2_PARSER_IP_ID) {
+		faf_h.ip_1_opt = 1;
+		*bit_offset = dpaa2_psr_faf_h_bit_offset(&faf_h);
+	} else if (protocol == DPAA2_PARSER_IPV4_ID) {
+		faf_h.ipv4_1 = 1;
+		*bit_offset = dpaa2_psr_faf_h_bit_offset(&faf_h);
+	} else if (protocol == DPAA2_PARSER_IP_FRAG_ID) {
+		faf_h.ip_1_frag = 1;
+		*bit_offset = dpaa2_psr_faf_h_bit_offset(&faf_h);
+	} else if (protocol == DPAA2_PARSER_IPV6_ID) {
+		faf_h.ipv6_1 = 1;
+		*bit_offset = dpaa2_psr_faf_h_bit_offset(&faf_h);
+	} else if (protocol == DPAA2_PARSER_GRE_ID) {
+		faf_h.gre = 1;
+		*bit_offset = dpaa2_psr_faf_h_bit_offset(&faf_h);
+	} else if (protocol == DPAA2_PARSER_UDP_ID) {
+		faf_h.udp = 1;
+		*bit_offset = dpaa2_psr_faf_h_bit_offset(&faf_h);
+	} else if (protocol == DPAA2_PARSER_TCP_ID) {
+		faf_h.tcp = 1;
+		*bit_offset = dpaa2_psr_faf_h_bit_offset(&faf_h);
+	} else if (protocol == DPAA2_PARSER_SCTP_ID) {
+		faf_h.sctp = 1;
+		*bit_offset = dpaa2_psr_faf_h_bit_offset(&faf_h);
+	} else if (protocol == DPAA2_PARSER_GTP_ID) {
+		faf_h.gtp = 1;
+		*bit_offset = dpaa2_psr_faf_h_bit_offset(&faf_h);
+	} else if (protocol == DPAA2_PARSER_IPSEC_ESP_ID) {
+		faf_h.ipsec_esp = 1;
+		*bit_offset = dpaa2_psr_faf_h_bit_offset(&faf_h);
+	} else if (protocol == DPAA2_PARSER_IPSEC_AH_ID) {
+		faf_h.ipsec_ah = 1;
+		*bit_offset = dpaa2_psr_faf_h_bit_offset(&faf_h);
+	} else if (protocol == DPAA2_PARSER_VXLAN_ID) {
+		faf_l.vxlan = 1;
+		*bit_offset = dpaa2_psr_faf_l_bit_offset(&faf_l);
+	} else if (protocol == DPAA2_PARSER_TUNNEL_VLAN_ID) {
+		fafe.rocev2_tunnel.in_vlan = 1;
+		*bit_offset = dpaa2_spsr_fafe_bit_offset(fafe);
+	} else if (protocol == DPAA2_PARSER_TUNNEL_IPV4_ID) {
+		fafe.rocev2_tunnel.in_ipv4 = 1;
+		*bit_offset = dpaa2_spsr_fafe_bit_offset(fafe);
+	} else if (protocol == DPAA2_PARSER_TUNNEL_IPV6_ID) {
+		fafe.rocev2_tunnel.in_ipv6 = 1;
+		*bit_offset = dpaa2_spsr_fafe_bit_offset(fafe);
+	} else if (protocol == DPAA2_PARSER_TUNNEL_UDP_ID) {
+		fafe.rocev2_tunnel.in_udp = 1;
+		*bit_offset = dpaa2_spsr_fafe_bit_offset(fafe);
+	} else if (protocol == DPAA2_PARSER_TUNNEL_TCP_ID) {
+		fafe.rocev2_tunnel.in_tcp = 1;
+		*bit_offset = dpaa2_spsr_fafe_bit_offset(fafe);
+	} else if (protocol == DPAA2_PARSER_ECPRI_ID) {
+		fafe.ecpri.ecpri = 1;
+		*bit_offset = dpaa2_spsr_fafe_bit_offset(fafe);
+	} else if (protocol == DPAA2_PARSER_ROCEV2_ID) {
+		fafe.rocev2_tunnel.rocev2 = 1;
+		*bit_offset = dpaa2_spsr_fafe_bit_offset(fafe);
+	} else if (protocol == DPAA2_PARSER_GENEVE_ID) {
+		fafe.rocev2_tunnel.geneve = 1;
+		*bit_offset = dpaa2_spsr_fafe_bit_offset(fafe);
+	} else {
+		return -ENOTSUP;
+	}
+
+	if (*bit_offset == UINT32_MAX)
+		return -EINVAL;
+
+	return 0;
+}
+
+static inline void __rte_hot
+dpaa2_dev_rx_parse_vlan(struct rte_mbuf *m, uint32_t *packet_type,
+	const struct dpaa2_psr_summary *sum,
+	const struct dpaa2_annot_hdr *annotation)
+{
+	union {
+		uint64_t word5;
+		struct dpaa2_psr_result_word5 psr_word5;
+	} word5_u;
+	uint8_t vlan_offset;
+	rte_be16_t *vlan_tci;
+
+	word5_u.word5 = rte_cpu_to_be_64(annotation->word5);
+	*packet_type |= RTE_PTYPE_L2_ETHER_VLAN;
+	m->ol_flags |= RTE_MBUF_F_RX_VLAN;
+	if (sum->vlan > 1) {
+		vlan_offset = word5_u.psr_word5.vlan_tci_n_off;
+		*packet_type |= RTE_PTYPE_L2_ETHER_QINQ;
+		m->ol_flags |= RTE_MBUF_F_RX_QINQ;
+	} else {
+		vlan_offset = word5_u.psr_word5.vlan_tci_1_off;
+	}
+	vlan_tci = rte_pktmbuf_mtod_offset(m, void *, vlan_offset);
+	m->vlan_tci = rte_be_to_cpu_16(*vlan_tci);
+}
+
+#define ECPRI(type) (void)(type)
+#define ROCEv2(type) (void)(type)
+
+static inline uint32_t __rte_hot
+dpaa2_dev_rx_parse_frc(const void *fd_frc, struct rte_mbuf *m,
+	const struct dpaa2_annot_hdr *annotation, bool sp)
+{
+	const struct dpaa2_ingress_frc *frc = fd_frc;
+	const struct dpaa2_psr_summary *sum = &frc->psr_sum.sum;
+	const union dpaa2_psr_summary_l *sum_l = &sum->sum_l;
+	int ip4_6 = 0, vxlan = 0;
+	const struct dpaa2_fas_parse *fas;
+	uint32_t packet_type = RTE_PTYPE_UNKNOWN;
+
+	/**Access annotation only for vlan and checksum error.*/
+
+	if (sum->vlan)
+		dpaa2_dev_rx_parse_vlan(m, &packet_type, sum, annotation);
+
+	if (sum_l->l4.l3 == DPAA2_PSR_SUMMARY_IPV4) {
+		packet_type |= RTE_PTYPE_L3_IPV4;
+		ip4_6 = 1;
+	} else if (sum_l->l4.l3 == DPAA2_PSR_SUMMARY_IPV6) {
+		packet_type |= RTE_PTYPE_L3_IPV6;
+		ip4_6 = 1;
+	}
+
+	/* Non-VLAN IP frames need RTE_PTYPE_L2_ETHER; VLAN frames
+	 * already have L2_ETHER_VLAN set above.
+	 */
+	if (ip4_6 && !sum->vlan)
+		packet_type |= RTE_PTYPE_L2_ETHER;
+
+	if (ip4_6) {
+		if (sum_l->l4.l4 == DPAA2_PSR_SUMMARY_IP_FRAG) {
+			packet_type |= RTE_PTYPE_L4_FRAG;
+		} else if (sum_l->l4.l4 == DPAA2_PSR_SUMMARY_ICMP) {
+			packet_type |= RTE_PTYPE_L4_ICMP;
+		} else if (sum_l->l4.l4 == DPAA2_PSR_SUMMARY_IPSEC_ESP) {
+			packet_type |= RTE_PTYPE_TUNNEL_ESP;
+		} else if (sum_l->l4.l4 == DPAA2_PSR_SUMMARY_TCP) {
+			packet_type |= RTE_PTYPE_L4_TCP;
+		} else if (sum_l->l4.l4 == DPAA2_PSR_SUMMARY_UDP) {
+			packet_type |= RTE_PTYPE_L4_UDP;
+		} else if (sum_l->l4.l4 == DPAA2_PSR_SUMMARY_SCTP) {
+			packet_type |= RTE_PTYPE_L4_SCTP;
+		} else if (sum_l->l4.l4 == DPAA2_PSR_SUMMARY_GTPU) {
+			packet_type |= RTE_PTYPE_L4_UDP | RTE_PTYPE_TUNNEL_GTPU;
+		} else if (sum_l->l4.l4 == DPAA2_PSR_SUMMARY_GTPC) {
+			packet_type |= RTE_PTYPE_L4_UDP | RTE_PTYPE_TUNNEL_GTPC;
+		} else if (sum_l->l4.l4 == DPAA2_PSR_SUMMARY_VXLAN) {
+			packet_type |= RTE_PTYPE_L4_UDP | RTE_PTYPE_TUNNEL_VXLAN;
+			vxlan = 1;
+		} else {
+			packet_type |= RTE_PTYPE_L4_NONFRAG;
+		}
+	} else if (sum_l->l4_ext.l3 == DPAA2_PSR_SUMMARY_L4_EXT) {
+		if (!sum->vlan)
+			packet_type |= RTE_PTYPE_L2_ETHER;
+		if (sum_l->l4_ext.ip == DPAA2_PSR_SUMMARY_IPV4)
+			packet_type |= RTE_PTYPE_L3_IPV4;
+		else if (sum_l->l4_ext.ip == DPAA2_PSR_SUMMARY_IPV6)
+			packet_type |= RTE_PTYPE_L3_IPV6;
+		if (sum_l->l4_ext.l4_ext == DPAA2_PSR_SUMMARY_GRE_IPV4 ||
+			sum_l->l4_ext.l4_ext == DPAA2_PSR_SUMMARY_GRE_IPV6)
+			packet_type |= RTE_PTYPE_TUNNEL_GRE;
+		else if (sum_l->l4_ext.l4_ext == DPAA2_PSR_SUMMARY_GRE_IPV4_UDP_TCP ||
+			sum_l->l4_ext.l4_ext == DPAA2_PSR_SUMMARY_GRE_IPV6_UDP_TCP)
+			packet_type |= RTE_PTYPE_TUNNEL_NVGRE;
+	} else if (sum_l->non_ip.non_ip == DPAA2_PSR_SUMMARY_NONIP) {
+		if (sum_l->non_ip.l2 == DPAA2_PSR_SUMMARY_ARP) {
+			packet_type |= RTE_PTYPE_L2_ETHER_ARP;
+		} else if (sum_l->non_ip.l2 == DPAA2_PSR_SUMMARY_NONIP_PTP) {
+			packet_type |= RTE_PTYPE_L2_ETHER_TIMESYNC;
+			m->ol_flags |= RTE_MBUF_F_RX_IEEE1588_PTP;
+		} else if (sum_l->non_ip.l2 == DPAA2_PSR_SUMMARY_MPLS) {
+			packet_type |= RTE_PTYPE_L2_ETHER_MPLS;
+		}
+	}
+
+	if (unlikely(sum->checksum_err)) {
+		fas = (const void *)&annotation->word1;
+		if (fas->l3ce)
+			m->ol_flags |= RTE_MBUF_F_RX_IP_CKSUM_BAD;
+		if (fas->l4ce)
+			m->ol_flags |= RTE_MBUF_F_RX_L4_CKSUM_BAD;
+	}
+
+	if (!sp)
+		goto final_type;
+
+	/*
+	 * fafe0 (eCPRI) and fafe1 (RoCEv2) are reported by the soft parser but
+	 * have no matching RTE_PTYPE value, so only the VXLAN inner types are
+	 * translated here.
+	 */
+	if (sum->fafe0) {
+		ECPRI(packet_type);
+	} else if (sum->fafe1) {
+		ROCEv2(packet_type);
+	} else if (vxlan) {
+		if (sum->fafe2) {
+			packet_type |= RTE_PTYPE_INNER_L2_ETHER;
+			packet_type |= RTE_PTYPE_INNER_L3_IPV4;
+		} else if (sum_l->l4.fafe3) {
+			packet_type |= RTE_PTYPE_INNER_L2_ETHER;
+			packet_type |= RTE_PTYPE_INNER_L3_IPV6;
+		}
+	} else if (!vxlan && sum->fafe2) {
+		packet_type |= RTE_PTYPE_TUNNEL_GENEVE;
+	}
+
+final_type:
+	return packet_type;
+}
+
+#define DPAA2_PARSER_ECPRI_EXTRACT_SAFE(rule, mask, size, offset, nb, max, \
+	rule_val, mask_val, size_val, offset_val) \
+({ \
+	uint64_t *_rule = (rule); \
+	uint64_t *_mask = (mask); \
+	uint8_t *_size = (size); \
+	uint8_t *_offset = (offset); \
+	int _ecpri_ret = 0; \
+	int _nb = (nb); \
+	\
+	if (_nb >= (max)) { \
+		_ecpri_ret = -ENOSPC; \
+	} else { \
+		_rule[_nb] = (rule_val); \
+		_mask[_nb] = (mask_val); \
+		_size[_nb] = (size_val); \
+		_offset[_nb] = (offset_val); \
+	} \
+	_ecpri_ret; \
+})
+
+static inline int
+dpaa2_parser_ecpri_extract(const struct rte_flow_item_ecpri *spec,
+	const struct rte_flow_item_ecpri *mask,
+	uint64_t rule_data[], uint64_t mask_data[],
+	uint8_t extract_size[], uint8_t extract_off[],
+	union dpaa2_sp_fafe_parse *fafe, uint8_t max_nb)
+{
+	int extract_nb = 0, ret;
+
+	if (mask->hdr.common.type != 0xff) {
+		/** Must mask as 0xff to specify type.*/
+
+		return -EINVAL;
+	}
+
+	if (spec->hdr.common.type > RTE_ECPRI_MSG_TYPE_IWF_DCTRL)
+		return -ENOTSUP;
+
+	/** Extract eCPRI type from FAFE.*/
+	fafe->ecpri.ecpri = 1;
+	fafe->ecpri.msg_type = spec->hdr.common.type;
+	ret = DPAA2_PARSER_ECPRI_EXTRACT_SAFE(rule_data, mask_data, extract_size,
+		extract_off, extract_nb, max_nb, fafe->fafe_8b, 0xff, sizeof(uint8_t),
+		DPAA2_FAFE_PSR_RESULT_OFFSET);
+	if (ret)
+		return ret;
+	extract_nb++;
+
+	if (spec->hdr.common.type == RTE_ECPRI_MSG_TYPE_IQ_DATA) {
+		if (mask->hdr.type0.pc_id) {
+			ret = DPAA2_PARSER_ECPRI_EXTRACT_SAFE(rule_data, mask_data, extract_size,
+				extract_off, extract_nb, max_nb, spec->hdr.type0.pc_id,
+				mask->hdr.type0.pc_id, sizeof(rte_be16_t),
+				DPAA2_ECPRI_MSG_OFFSET +
+				offsetof(struct rte_ecpri_msg_iq_data, pc_id));
+			if (ret)
+				return ret;
+			extract_nb++;
+		}
+		if (mask->hdr.type0.seq_id) {
+			ret = DPAA2_PARSER_ECPRI_EXTRACT_SAFE(rule_data, mask_data, extract_size,
+				extract_off, extract_nb, max_nb, spec->hdr.type0.seq_id,
+				mask->hdr.type0.seq_id, sizeof(rte_be16_t),
+				DPAA2_ECPRI_MSG_OFFSET +
+				offsetof(struct rte_ecpri_msg_iq_data, seq_id));
+			if (ret)
+				return ret;
+			extract_nb++;
+		}
+	} else if (spec->hdr.common.type == RTE_ECPRI_MSG_TYPE_BIT_SEQ) {
+		if (mask->hdr.type1.pc_id) {
+			ret = DPAA2_PARSER_ECPRI_EXTRACT_SAFE(rule_data, mask_data, extract_size,
+				extract_off, extract_nb, max_nb, spec->hdr.type1.pc_id,
+				mask->hdr.type1.pc_id, sizeof(rte_be16_t),
+				DPAA2_ECPRI_MSG_OFFSET +
+				offsetof(struct rte_ecpri_msg_bit_seq, pc_id));
+			if (ret)
+				return ret;
+			extract_nb++;
+		}
+		if (mask->hdr.type1.seq_id) {
+			ret = DPAA2_PARSER_ECPRI_EXTRACT_SAFE(rule_data, mask_data, extract_size,
+				extract_off, extract_nb, max_nb, spec->hdr.type1.seq_id,
+				mask->hdr.type1.seq_id, sizeof(rte_be16_t),
+				DPAA2_ECPRI_MSG_OFFSET +
+				offsetof(struct rte_ecpri_msg_bit_seq, seq_id));
+			if (ret)
+				return ret;
+			extract_nb++;
+		}
+	} else if (spec->hdr.common.type == RTE_ECPRI_MSG_TYPE_RTC_CTRL) {
+		if (mask->hdr.type2.rtc_id) {
+			ret = DPAA2_PARSER_ECPRI_EXTRACT_SAFE(rule_data, mask_data, extract_size,
+				extract_off, extract_nb, max_nb, spec->hdr.type2.rtc_id,
+				mask->hdr.type2.rtc_id, sizeof(rte_be16_t),
+				DPAA2_ECPRI_MSG_OFFSET +
+				offsetof(struct rte_ecpri_msg_rtc_ctrl, rtc_id));
+			if (ret)
+				return ret;
+			extract_nb++;
+		}
+		if (mask->hdr.type2.seq_id) {
+			ret = DPAA2_PARSER_ECPRI_EXTRACT_SAFE(rule_data, mask_data, extract_size,
+				extract_off, extract_nb, max_nb, spec->hdr.type2.seq_id,
+				mask->hdr.type2.seq_id, sizeof(rte_be16_t),
+				DPAA2_ECPRI_MSG_OFFSET +
+				offsetof(struct rte_ecpri_msg_rtc_ctrl, seq_id));
+			if (ret)
+				return ret;
+			extract_nb++;
+		}
+	} else if (spec->hdr.common.type == RTE_ECPRI_MSG_TYPE_GEN_DATA) {
+		if (mask->hdr.type3.pc_id || mask->hdr.type3.seq_id)
+			return -ENOTSUP;
+	} else if (spec->hdr.common.type == RTE_ECPRI_MSG_TYPE_RM_ACC) {
+		if (mask->hdr.type4.rma_id) {
+			ret = DPAA2_PARSER_ECPRI_EXTRACT_SAFE(rule_data, mask_data, extract_size,
+				extract_off, extract_nb, max_nb, spec->hdr.type4.rma_id,
+				mask->hdr.type4.rma_id, sizeof(uint8_t),
+				/** Compiler can't support to take address
+				 * of bit-field
+				 * offsetof(struct rte_ecpri_msg_rm_access,
+				 * rma_id);
+				 */
+				DPAA2_ECPRI_MSG_OFFSET + 0);
+			if (ret)
+				return ret;
+			extract_nb++;
+		}
+		if (mask->hdr.type4.ele_id) {
+			ret = DPAA2_PARSER_ECPRI_EXTRACT_SAFE(rule_data, mask_data, extract_size,
+				extract_off, extract_nb, max_nb, spec->hdr.type4.ele_id,
+				mask->hdr.type4.ele_id, sizeof(rte_be16_t),
+				/** Compiler can't support to take address
+				 * of bit-field
+				 * offsetof(struct rte_ecpri_msg_rm_access,
+				 * rma_id);
+				 */
+				DPAA2_ECPRI_MSG_OFFSET + 2);
+			if (ret)
+				return ret;
+			extract_nb++;
+		}
+	} else if (spec->hdr.common.type == RTE_ECPRI_MSG_TYPE_DLY_MSR) {
+		if (mask->hdr.type5.msr_id) {
+			ret = DPAA2_PARSER_ECPRI_EXTRACT_SAFE(rule_data, mask_data, extract_size,
+				extract_off, extract_nb, max_nb, spec->hdr.type5.msr_id,
+				mask->hdr.type5.msr_id, sizeof(uint8_t),
+				DPAA2_ECPRI_MSG_OFFSET +
+				offsetof(struct rte_ecpri_msg_delay_measure, msr_id));
+			if (ret)
+				return ret;
+			extract_nb++;
+		}
+		if (mask->hdr.type5.act_type) {
+			ret = DPAA2_PARSER_ECPRI_EXTRACT_SAFE(rule_data, mask_data, extract_size,
+				extract_off, extract_nb, max_nb, spec->hdr.type5.act_type,
+				mask->hdr.type5.act_type, sizeof(uint8_t),
+				DPAA2_ECPRI_MSG_OFFSET +
+				offsetof(struct rte_ecpri_msg_delay_measure, act_type));
+			if (ret)
+				return ret;
+			extract_nb++;
+		}
+	} else if (spec->hdr.common.type == RTE_ECPRI_MSG_TYPE_RMT_RST) {
+		if (mask->hdr.type6.rst_id) {
+			ret = DPAA2_PARSER_ECPRI_EXTRACT_SAFE(rule_data, mask_data, extract_size,
+				extract_off, extract_nb, max_nb, spec->hdr.type6.rst_id,
+				mask->hdr.type6.rst_id, sizeof(rte_be16_t),
+				DPAA2_ECPRI_MSG_OFFSET +
+				offsetof(struct rte_ecpri_msg_remote_reset, rst_id));
+			if (ret)
+				return ret;
+			extract_nb++;
+		}
+		if (mask->hdr.type6.rst_op) {
+			ret = DPAA2_PARSER_ECPRI_EXTRACT_SAFE(rule_data, mask_data, extract_size,
+				extract_off, extract_nb, max_nb, spec->hdr.type6.rst_op,
+				mask->hdr.type6.rst_op, sizeof(uint8_t),
+				DPAA2_ECPRI_MSG_OFFSET +
+				offsetof(struct rte_ecpri_msg_remote_reset, rst_op));
+			if (ret)
+				return ret;
+			extract_nb++;
+		}
+	} else if (spec->hdr.common.type == RTE_ECPRI_MSG_TYPE_EVT_IND) {
+		if (mask->hdr.type7.evt_id) {
+			ret = DPAA2_PARSER_ECPRI_EXTRACT_SAFE(rule_data, mask_data, extract_size,
+				extract_off, extract_nb, max_nb, spec->hdr.type7.evt_id,
+				mask->hdr.type7.evt_id, sizeof(uint8_t),
+				DPAA2_ECPRI_MSG_OFFSET +
+				offsetof(struct rte_ecpri_msg_event_ind, evt_id));
+			if (ret)
+				return ret;
+			extract_nb++;
+		}
+		if (mask->hdr.type7.evt_type) {
+			ret = DPAA2_PARSER_ECPRI_EXTRACT_SAFE(rule_data, mask_data, extract_size,
+				extract_off, extract_nb, max_nb, spec->hdr.type7.evt_type,
+				mask->hdr.type7.evt_type, sizeof(uint8_t),
+				DPAA2_ECPRI_MSG_OFFSET +
+				offsetof(struct rte_ecpri_msg_event_ind, evt_type));
+			if (ret)
+				return ret;
+			extract_nb++;
+		}
+		if (mask->hdr.type7.seq) {
+			ret = DPAA2_PARSER_ECPRI_EXTRACT_SAFE(rule_data, mask_data, extract_size,
+				extract_off, extract_nb, max_nb, spec->hdr.type7.seq,
+				mask->hdr.type7.seq, sizeof(uint8_t),
+				DPAA2_ECPRI_MSG_OFFSET +
+				offsetof(struct rte_ecpri_msg_event_ind, seq));
+			if (ret)
+				return ret;
+			extract_nb++;
+		}
+		if (mask->hdr.type7.number) {
+			ret = DPAA2_PARSER_ECPRI_EXTRACT_SAFE(rule_data, mask_data, extract_size,
+				extract_off, extract_nb, max_nb, spec->hdr.type7.number,
+				mask->hdr.type7.number, sizeof(uint8_t),
+				DPAA2_ECPRI_MSG_OFFSET +
+				offsetof(struct rte_ecpri_msg_event_ind, number));
+			if (ret)
+				return ret;
+			extract_nb++;
+		}
+	} else {
+		return -ENOTSUP;
+	}
+
+	return extract_nb;
+}
+#endif /* _DPAA2_PARSER_DECODE_H */
diff --git a/drivers/net/dpaa2/dpaa2_pmd_logs.h b/drivers/net/dpaa2/dpaa2_pmd_logs.h
index 28c9bed1ae..8b699bb5af 100644
--- a/drivers/net/dpaa2/dpaa2_pmd_logs.h
+++ b/drivers/net/dpaa2/dpaa2_pmd_logs.h
@@ -1,10 +1,17 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2017 NXP
+ * Copyright 2017-2026 NXP
  */
 
 #ifndef _DPAA2_PMD_LOGS_H_
 #define _DPAA2_PMD_LOGS_H_
 
+#include <stdarg.h>
+#include <stdio.h>
+#include <string.h>
+
+#include <rte_common.h>
+#include <rte_log.h>
+
 extern int dpaa2_logtype_pmd;
 #define RTE_LOGTYPE_DPAA2_NET dpaa2_logtype_pmd
 
@@ -36,4 +43,12 @@ extern int dpaa2_logtype_pmd;
 #define DPAA2_PMD_DP_WARN(fmt, ...) \
 	DPAA2_PMD_DP_LOG(WARNING, fmt, ## __VA_ARGS__)
 
+static inline __rte_format_printf(1, 2) void
+dpaa2_dump_print(const char *fmt, ...)
+{
+	va_list ap;
+	va_start(ap, fmt);
+	rte_vlog(RTE_LOG_NOTICE, RTE_LOGTYPE_USER1, fmt, ap);
+	va_end(ap);
+}
 #endif /* _DPAA2_PMD_LOGS_H_ */
diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index df3eefc134..d3512d56f9 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
  *   Copyright (c) 2016 Freescale Semiconductor, Inc. All rights reserved.
- *   Copyright 2016-2024 NXP
+ *   Copyright 2016-2026 NXP
  *
  */
 
@@ -26,13 +26,18 @@
 #include "dpaa2_pmd_logs.h"
 #include "dpaa2_ethdev.h"
 #include "base/dpaa2_hw_dpni_annot.h"
-#include "dpaa2_parse_dump.h"
-
-static inline uint32_t __rte_hot
-dpaa2_dev_rx_parse_slow(struct rte_mbuf *mbuf,
-			struct dpaa2_annot_hdr *annotation);
-
-static void enable_tx_tstamp(struct qbman_fd *fd) __rte_unused;
+#include "dpaa2_parser_decode.h"
+
+#define DPAA2_FAST_PATH_PTYPE_ETH_IPV4 (RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV4)
+#define DPAA2_FAST_PATH_PTYPE_ETH_IPV6 (RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV6)
+#define DPAA2_FAST_PATH_PTYPE_ETH_IPV4_UDP \
+	(DPAA2_FAST_PATH_PTYPE_ETH_IPV4 | RTE_PTYPE_L4_UDP)
+#define DPAA2_FAST_PATH_PTYPE_ETH_IPV6_UDP \
+	(DPAA2_FAST_PATH_PTYPE_ETH_IPV6 | RTE_PTYPE_L4_UDP)
+#define DPAA2_FAST_PATH_PTYPE_ETH_IPV4_TCP \
+	(DPAA2_FAST_PATH_PTYPE_ETH_IPV4 | RTE_PTYPE_L4_TCP)
+#define DPAA2_FAST_PATH_PTYPE_ETH_IPV6_TCP \
+	(DPAA2_FAST_PATH_PTYPE_ETH_IPV6 | RTE_PTYPE_L4_TCP)
 
 static inline rte_mbuf_timestamp_t *
 dpaa2_timestamp_dynfield(struct rte_mbuf *mbuf)
@@ -51,128 +56,107 @@ dpaa2_timestamp_dynfield(struct rte_mbuf *mbuf)
 	DPAA2_RESET_FD_FLC(_fd);		\
 } while (0)
 
-static inline void __rte_hot
-dpaa2_dev_rx_parse_new(struct rte_mbuf *m, const struct qbman_fd *fd,
-		       void *hw_annot_addr)
+static inline void
+dpaa2_dev_rx_mbuf_flc_offload(struct rte_mbuf *m,
+	const struct qbman_fd *fd)
 {
-	uint16_t frc = DPAA2_GET_FD_FRC_PARSE_SUM(fd);
-	struct dpaa2_annot_hdr *annotation =
-			(struct dpaa2_annot_hdr *)hw_annot_addr;
 	uint32_t flc_lo, tc, flow;
 
-	if (unlikely(dpaa2_print_parser_result))
-		dpaa2_print_parse_result(annotation);
+	flc_lo = fd->simple.flc_lo;
+	if (flc_lo & (1 << DPAA2_FS_FLC_FS_MARK_OFFSET)) {
+		tc = (flc_lo >> DPAA2_FS_FLC_TC_OFFSET) & DPAA2_FS_FLC_TC_MASK;
+		flow = flc_lo >> DPAA2_FS_FLC_FLOW_OFFSET;
+		m->hash.fdir.hi = (tc << RTE_DPAA2_MBUF_F_RX_FDIR_TC_OFFSET) | flow;
+		m->ol_flags |= RTE_MBUF_F_RX_FDIR;
+		DPAA2_PMD_DP_DEBUG("FS frame received from TC[%d].flow%d", tc, flow);
+	} else {
+		m->hash.rss = fd->simple.flc_hi;
+		m->ol_flags |= RTE_MBUF_F_RX_RSS_HASH;
+		DPAA2_PMD_DP_DEBUG("Hash frame received with RSS(%08x)", m->hash.rss);
+	}
+}
 
+static inline void __rte_hot
+dpaa2_dev_rx_parse_new(struct dpaa2_dev_priv *priv,
+	struct rte_mbuf *m, const struct qbman_fd *fd,
+	void *hw_annot_addr, int is_vlan)
+{
+	union {
+		uint16_t u16;
+		struct dpaa2_psr_summary sum;
+	} frc_u;
+	struct dpaa2_psr_summary *frc_parse = &frc_u.sum;
+	struct dpaa2_annot_hdr *annotation = hw_annot_addr;
+	int default_parsed = false;
+
+	frc_u.u16 = DPAA2_GET_FD_FRC_PARSE_SUM(fd);
 	m->packet_type = RTE_PTYPE_UNKNOWN;
-	switch (frc) {
-	case DPAA2_PKT_TYPE_ETHER:
-		m->packet_type = RTE_PTYPE_L2_ETHER;
-		break;
-	case DPAA2_PKT_TYPE_IPV4:
-		m->packet_type = RTE_PTYPE_L2_ETHER |
-			RTE_PTYPE_L3_IPV4;
-		break;
-	case DPAA2_PKT_TYPE_IPV6:
-		m->packet_type = RTE_PTYPE_L2_ETHER |
-			RTE_PTYPE_L3_IPV6;
+	if (unlikely(is_vlan))
+		frc_u.u16 &= (~DPAA2_PKT_TYPE_VLAN);
+	switch (frc_u.u16) {
+	case DPAA2_PKT_TYPE_IPV4_UDP:
+		m->packet_type = DPAA2_FAST_PATH_PTYPE_ETH_IPV4_UDP;
 		break;
 	case DPAA2_PKT_TYPE_IPV4_TCP:
-		m->packet_type = RTE_PTYPE_L2_ETHER |
-			RTE_PTYPE_L3_IPV4 | RTE_PTYPE_L4_TCP;
+		m->packet_type = DPAA2_FAST_PATH_PTYPE_ETH_IPV4_TCP;
 		break;
-	case DPAA2_PKT_TYPE_IPV6_TCP:
-		m->packet_type = RTE_PTYPE_L2_ETHER |
-			RTE_PTYPE_L3_IPV6 | RTE_PTYPE_L4_TCP;
-		break;
-	case DPAA2_PKT_TYPE_IPV4_UDP:
-		m->packet_type = RTE_PTYPE_L2_ETHER |
-			RTE_PTYPE_L3_IPV4 | RTE_PTYPE_L4_UDP;
+	case DPAA2_PKT_TYPE_IPV4:
+		m->packet_type = DPAA2_FAST_PATH_PTYPE_ETH_IPV4;
 		break;
 	case DPAA2_PKT_TYPE_IPV6_UDP:
-		m->packet_type = RTE_PTYPE_L2_ETHER |
-			RTE_PTYPE_L3_IPV6 | RTE_PTYPE_L4_UDP;
+		m->packet_type = DPAA2_FAST_PATH_PTYPE_ETH_IPV6_UDP;
 		break;
-	case DPAA2_PKT_TYPE_IPV4_SCTP:
-		m->packet_type = RTE_PTYPE_L2_ETHER |
-			RTE_PTYPE_L3_IPV4 | RTE_PTYPE_L4_SCTP;
-		break;
-	case DPAA2_PKT_TYPE_IPV6_SCTP:
-		m->packet_type = RTE_PTYPE_L2_ETHER |
-			RTE_PTYPE_L3_IPV6 | RTE_PTYPE_L4_SCTP;
-		break;
-	case DPAA2_PKT_TYPE_IPV4_ICMP:
-		m->packet_type = RTE_PTYPE_L2_ETHER |
-			RTE_PTYPE_L3_IPV4 | RTE_PTYPE_L4_ICMP;
+	case DPAA2_PKT_TYPE_IPV6_TCP:
+		m->packet_type = DPAA2_FAST_PATH_PTYPE_ETH_IPV6_TCP;
 		break;
-	case DPAA2_PKT_TYPE_IPV6_ICMP:
-		m->packet_type = RTE_PTYPE_L2_ETHER |
-			RTE_PTYPE_L3_IPV6 | RTE_PTYPE_L4_ICMP;
+	case DPAA2_PKT_TYPE_IPV6:
+		m->packet_type = DPAA2_FAST_PATH_PTYPE_ETH_IPV6;
 		break;
 	case DPAA2_PKT_TYPE_IPV4_FRAG:
-		m->packet_type = RTE_PTYPE_L2_ETHER |
-			RTE_PTYPE_L3_IPV4 | RTE_PTYPE_L4_FRAG;
+		m->packet_type = DPAA2_FAST_PATH_PTYPE_ETH_IPV4 | RTE_PTYPE_L4_FRAG;
 		break;
 	case DPAA2_PKT_TYPE_IPV6_FRAG:
-		m->packet_type = RTE_PTYPE_L2_ETHER |
-			RTE_PTYPE_L3_IPV6 | RTE_PTYPE_L4_FRAG;
+		m->packet_type = DPAA2_FAST_PATH_PTYPE_ETH_IPV6 | RTE_PTYPE_L4_FRAG;
 		break;
 	case DPAA2_PKT_TYPE_IPV4_ESP:
-		m->packet_type = RTE_PTYPE_L2_ETHER |
-			RTE_PTYPE_L3_IPV4 | RTE_PTYPE_TUNNEL_ESP;
+		m->packet_type = DPAA2_FAST_PATH_PTYPE_ETH_IPV4 | RTE_PTYPE_TUNNEL_ESP;
 		break;
 	case DPAA2_PKT_TYPE_IPV6_ESP:
-		m->packet_type = RTE_PTYPE_L2_ETHER |
-			RTE_PTYPE_L3_IPV6 | RTE_PTYPE_TUNNEL_ESP;
+		m->packet_type = DPAA2_FAST_PATH_PTYPE_ETH_IPV6 | RTE_PTYPE_TUNNEL_ESP;
 		break;
 	case DPAA2_PKT_TYPE_IPV4_GTPU:
-		m->packet_type = RTE_PTYPE_L2_ETHER |
-			RTE_PTYPE_L3_IPV4 | RTE_PTYPE_L4_UDP |
-			RTE_PTYPE_TUNNEL_GTPU;
+		m->packet_type = DPAA2_FAST_PATH_PTYPE_ETH_IPV4_UDP | RTE_PTYPE_TUNNEL_GTPU;
 		break;
 	case DPAA2_PKT_TYPE_IPV6_GTPU:
-		m->packet_type = RTE_PTYPE_L2_ETHER |
-			RTE_PTYPE_L3_IPV6 | RTE_PTYPE_L4_UDP |
-			RTE_PTYPE_TUNNEL_GTPU;
+		m->packet_type = DPAA2_FAST_PATH_PTYPE_ETH_IPV6_UDP | RTE_PTYPE_TUNNEL_GTPU;
 		break;
 	case DPAA2_PKT_TYPE_IPV4_GTPC:
-		m->packet_type = RTE_PTYPE_L2_ETHER |
-			RTE_PTYPE_L3_IPV4 | RTE_PTYPE_L4_UDP |
-			RTE_PTYPE_TUNNEL_GTPC;
+		m->packet_type = DPAA2_FAST_PATH_PTYPE_ETH_IPV4_UDP | RTE_PTYPE_TUNNEL_GTPC;
 		break;
 	case DPAA2_PKT_TYPE_IPV6_GTPC:
-		m->packet_type = RTE_PTYPE_L2_ETHER |
-			RTE_PTYPE_L3_IPV6 | RTE_PTYPE_L4_UDP |
-			RTE_PTYPE_TUNNEL_GTPC;
+		m->packet_type = DPAA2_FAST_PATH_PTYPE_ETH_IPV6_UDP | RTE_PTYPE_TUNNEL_GTPC;
+		break;
+	case DPAA2_PKT_TYPE_ETHER:
+		m->packet_type = RTE_PTYPE_L2_ETHER;
 		break;
 	default:
-		m->packet_type = dpaa2_dev_rx_parse_slow(m, annotation);
-	}
-	flc_lo = fd->simple.flc_lo;
-	if (flc_lo & (1 << DPAA2_FS_FLC_FS_MARK_OFFSET)) {
-		tc = (flc_lo >> DPAA2_FS_FLC_TC_OFFSET) &
-			DPAA2_FS_FLC_TC_MASK;
-		flow = flc_lo >> DPAA2_FS_FLC_FLOW_OFFSET;
-		m->ol_flags |= RTE_MBUF_F_RX_FDIR;
-		m->hash.fdir.hi = (tc << 16) | flow;
-		DPAA2_PMD_DP_DEBUG("FS frame received from TC[%d]->flow%d",
-			tc, flow);
-	} else {
-		m->hash.rss = fd->simple.flc_hi;
-		m->ol_flags |= RTE_MBUF_F_RX_RSS_HASH;
-		DPAA2_PMD_DP_DEBUG("Hash frame received with RSS(%08x)",
-			m->hash.rss);
+		m->packet_type = dpaa2_dev_rx_parse_frc(&fd->simple.frc, m,
+			annotation, priv->sp_protocol);
+		default_parsed = true;
 	}
 
+	if (unlikely(is_vlan && !default_parsed))
+		dpaa2_dev_rx_parse_vlan(m, &m->packet_type, frc_parse, annotation);
+
 	if (dpaa2_enable_ts[m->port]) {
 		*dpaa2_timestamp_dynfield(m) = annotation->word2;
 		m->ol_flags |= dpaa2_timestamp_rx_dynflag;
-		DPAA2_PMD_DP_DEBUG("pkt timestamp:0x%" PRIx64 "",
+		DPAA2_PMD_DP_DEBUG("pkt timestamp: 0x%" PRIx64 "",
 				*dpaa2_timestamp_dynfield(m));
 	}
 
-	DPAA2_PMD_DP_DEBUG("HW frc = 0x%x\t packet type =0x%x "
-		"ol_flags =0x%" PRIx64 "",
-		frc, m->packet_type, m->ol_flags);
+	DPAA2_PMD_DP_DEBUG("HW frc = 0x%x packet type = 0x%x ol_flags = 0x%lx",
+		frc_u.u16, m->packet_type, m->ol_flags);
 }
 
 static inline uint32_t __rte_hot
@@ -277,13 +261,15 @@ dpaa2_dev_rx_parse_slow(struct rte_mbuf *mbuf,
 }
 
 static inline uint32_t __rte_hot
-dpaa2_dev_rx_parse(struct rte_mbuf *mbuf, void *hw_annot_addr)
+dpaa2_dev_rx_parse(struct dpaa2_dev_priv *priv,
+	struct rte_mbuf *mbuf, void *hw_annot_addr)
 {
-	struct dpaa2_annot_hdr *annotation =
-			(struct dpaa2_annot_hdr *)hw_annot_addr;
+	struct dpaa2_annot_hdr *annotation = hw_annot_addr;
 
 	DPAA2_PMD_DP_DEBUG("(fast parse) Annotation = 0x%" PRIx64 "\t",
-			   annotation->word4);
+		annotation->word4);
+
+	RTE_SET_USED(priv);
 
 	if (BIT_ISSET_AT_POS(annotation->word1, DPAA2_ETH_FAS_L3CE))
 		mbuf->ol_flags |= RTE_MBUF_F_RX_IP_CKSUM_BAD;
@@ -295,9 +281,6 @@ dpaa2_dev_rx_parse(struct rte_mbuf *mbuf, void *hw_annot_addr)
 	else if (BIT_ISSET_AT_POS(annotation->word1, DPAA2_ETH_FAS_L4CV))
 		mbuf->ol_flags |= RTE_MBUF_F_RX_L4_CKSUM_GOOD;
 
-	if (unlikely(dpaa2_print_parser_result))
-		dpaa2_print_parse_result(annotation);
-
 	if (dpaa2_enable_ts[mbuf->port]) {
 		*dpaa2_timestamp_dynfield(mbuf) = annotation->word2;
 		mbuf->ol_flags |= dpaa2_timestamp_rx_dynflag;
@@ -306,27 +289,23 @@ dpaa2_dev_rx_parse(struct rte_mbuf *mbuf, void *hw_annot_addr)
 	}
 
 	/* Check detailed parsing requirement */
-	if (annotation->word3 & 0x7FFFFC3FFFF)
+	if (unlikely(annotation->word3 & 0x7FFFFC3FFFF))
 		return dpaa2_dev_rx_parse_slow(mbuf, annotation);
 
 	/* Return some common types from parse processing */
 	switch (annotation->word4) {
 	case DPAA2_L3_IPv4:
-		return RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV4;
+		return DPAA2_FAST_PATH_PTYPE_ETH_IPV4;
 	case DPAA2_L3_IPv6:
-		return  RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV6;
+		return DPAA2_FAST_PATH_PTYPE_ETH_IPV6;
 	case DPAA2_L3_IPv4_TCP:
-		return  RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV4 |
-				RTE_PTYPE_L4_TCP;
+		return DPAA2_FAST_PATH_PTYPE_ETH_IPV4_TCP;
 	case DPAA2_L3_IPv4_UDP:
-		return  RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV4 |
-				RTE_PTYPE_L4_UDP;
+		return DPAA2_FAST_PATH_PTYPE_ETH_IPV4_UDP;
 	case DPAA2_L3_IPv6_TCP:
-		return  RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV6 |
-				RTE_PTYPE_L4_TCP;
+		return DPAA2_FAST_PATH_PTYPE_ETH_IPV6_TCP;
 	case DPAA2_L3_IPv6_UDP:
-		return  RTE_PTYPE_L2_ETHER | RTE_PTYPE_L3_IPV6 |
-				RTE_PTYPE_L4_UDP;
+		return DPAA2_FAST_PATH_PTYPE_ETH_IPV6_UDP;
 	default:
 		break;
 	}
@@ -335,15 +314,18 @@ dpaa2_dev_rx_parse(struct rte_mbuf *mbuf, void *hw_annot_addr)
 }
 
 static inline struct rte_mbuf *__rte_hot
-eth_sg_fd_to_mbuf(const struct qbman_fd *fd,
-		  int port_id)
+dpaa2_eth_sg_fd_to_mbuf(struct dpaa2_dev_priv *priv, const struct qbman_fd *fd)
 {
 	struct qbman_sge *sgt, *sge;
 	size_t sg_addr, fd_addr;
-	int i = 0;
+	int i = 0, is_vlan = false;
 	void *hw_annot_addr;
 	struct rte_mbuf *first_seg, *next_seg, *cur_seg, *temp;
 
+	if (unlikely(dpaa2_svr_family == SVR_LX2160A &&
+		(DPAA2_GET_FD_FRC_PARSE_SUM(fd) & DPAA2_PKT_TYPE_VLAN)))
+		is_vlan = true;
+
 	fd_addr = (size_t)DPAA2_IOVA_TO_VADDR(DPAA2_GET_FD_ADDR(fd));
 	hw_annot_addr = (void *)(fd_addr + DPAA2_FD_PTA_SIZE);
 
@@ -364,33 +346,32 @@ eth_sg_fd_to_mbuf(const struct qbman_fd *fd,
 	first_seg->pkt_len = DPAA2_GET_FD_LEN(fd);
 	first_seg->nb_segs = 1;
 	first_seg->next = NULL;
-	first_seg->port = port_id;
+	first_seg->port = priv->eth_dev->data->port_id;
 	if (dpaa2_svr_family == SVR_LX2160A)
-		dpaa2_dev_rx_parse_new(first_seg, fd, hw_annot_addr);
+		dpaa2_dev_rx_parse_new(priv, first_seg, fd, hw_annot_addr, is_vlan);
 	else
-		first_seg->packet_type =
-			dpaa2_dev_rx_parse(first_seg, hw_annot_addr);
+		first_seg->packet_type = dpaa2_dev_rx_parse(priv, first_seg, hw_annot_addr);
+	dpaa2_dev_rx_mbuf_flc_offload(first_seg, fd);
 
 	rte_mbuf_refcnt_set(first_seg, 1);
 #ifdef RTE_LIBRTE_MEMPOOL_DEBUG
 	rte_mempool_check_cookies(rte_mempool_from_obj((void *)first_seg),
-			(void **)&first_seg, 1, 1);
+		(void **)&first_seg, 1, 1);
 #endif
 	cur_seg = first_seg;
 	while (!DPAA2_SG_IS_FINAL(sge) && i < DPAA2_MAX_SGS) {
 		sge = &sgt[i++];
-		sg_addr = (size_t)DPAA2_IOVA_TO_VADDR(
-				DPAA2_GET_FLE_ADDR(sge));
+		sg_addr = (size_t)DPAA2_IOVA_TO_VADDR(DPAA2_GET_FLE_ADDR(sge));
 		next_seg = DPAA2_INLINE_MBUF_FROM_BUF(sg_addr,
 			rte_dpaa2_bpid_info[DPAA2_GET_FLE_BPID(sge)].meta_data_size);
-		next_seg->buf_addr  = (uint8_t *)sg_addr;
-		next_seg->data_off  = DPAA2_GET_FLE_OFFSET(sge);
-		next_seg->data_len  = sge->length  & 0x1FFFF;
-		first_seg->nb_segs += 1;
+		next_seg->buf_addr = (uint8_t *)sg_addr;
+		next_seg->data_off = DPAA2_GET_FLE_OFFSET(sge);
+		next_seg->data_len = sge->length  & 0x1FFFF;
+		first_seg->nb_segs++;
 		rte_mbuf_refcnt_set(next_seg, 1);
 #ifdef RTE_LIBRTE_MEMPOOL_DEBUG
 		rte_mempool_check_cookies(rte_mempool_from_obj((void *)next_seg),
-				(void **)&next_seg, 1, 1);
+			(void **)&next_seg, 1, 1);
 #endif
 		cur_seg->next = next_seg;
 		next_seg->next = NULL;
@@ -400,8 +381,8 @@ eth_sg_fd_to_mbuf(const struct qbman_fd *fd,
 		rte_dpaa2_bpid_info[DPAA2_GET_FD_BPID(fd)].meta_data_size);
 	rte_mbuf_refcnt_set(temp, 1);
 #ifdef RTE_LIBRTE_MEMPOOL_DEBUG
-		rte_mempool_check_cookies(rte_mempool_from_obj((void *)temp),
-				(void **)&temp, 1, 1);
+	rte_mempool_check_cookies(rte_mempool_from_obj((void *)temp),
+		(void **)&temp, 1, 1);
 #endif
 	rte_pktmbuf_free_seg(temp);
 
@@ -409,13 +390,20 @@ eth_sg_fd_to_mbuf(const struct qbman_fd *fd,
 }
 
 static inline struct rte_mbuf *__rte_hot
-eth_fd_to_mbuf(const struct qbman_fd *fd,
-	       int port_id)
+dpaa2_eth_fd_to_mbuf(struct dpaa2_dev_priv *priv, const struct qbman_fd *fd)
 {
 	void *v_addr = DPAA2_IOVA_TO_VADDR(DPAA2_GET_FD_ADDR(fd));
 	void *hw_annot_addr = (void *)((size_t)v_addr + DPAA2_FD_PTA_SIZE);
 	struct rte_mbuf *mbuf = DPAA2_INLINE_MBUF_FROM_BUF(v_addr,
-		     rte_dpaa2_bpid_info[DPAA2_GET_FD_BPID(fd)].meta_data_size);
+		rte_dpaa2_bpid_info[DPAA2_GET_FD_BPID(fd)].meta_data_size);
+	int is_vlan = false;
+
+	if (unlikely(dpaa2_svr_family == SVR_LX2160A &&
+		(DPAA2_GET_FD_FRC_PARSE_SUM(fd) & DPAA2_PKT_TYPE_VLAN))) {
+		rte_prefetch0(rte_pktmbuf_mtod(mbuf, void *));
+		rte_prefetch0(hw_annot_addr);
+		is_vlan = true;
+	}
 
 	/* need to repopulated some of the fields,
 	 * as they may have changed in last transmission
@@ -425,13 +413,13 @@ eth_fd_to_mbuf(const struct qbman_fd *fd,
 	mbuf->data_off = DPAA2_GET_FD_OFFSET(fd);
 	mbuf->data_len = DPAA2_GET_FD_LEN(fd);
 	mbuf->pkt_len = mbuf->data_len;
-	mbuf->port = port_id;
+	mbuf->port = priv->eth_dev->data->port_id;
 	mbuf->next = NULL;
 	mbuf->hash.sched.color = DPAA2_GET_FD_DROPP(fd);
 	rte_mbuf_refcnt_set(mbuf, 1);
 #ifdef RTE_LIBRTE_MEMPOOL_DEBUG
 	rte_mempool_check_cookies(rte_mempool_from_obj((void *)mbuf),
-			(void **)&mbuf, 1, 1);
+		(void **)&mbuf, 1, 1);
 #endif
 
 	/* Parse the packet */
@@ -441,9 +429,10 @@ eth_fd_to_mbuf(const struct qbman_fd *fd,
 	 */
 
 	if (dpaa2_svr_family == SVR_LX2160A)
-		dpaa2_dev_rx_parse_new(mbuf, fd, hw_annot_addr);
+		dpaa2_dev_rx_parse_new(priv, mbuf, fd, hw_annot_addr, is_vlan);
 	else
-		mbuf->packet_type = dpaa2_dev_rx_parse(mbuf, hw_annot_addr);
+		mbuf->packet_type = dpaa2_dev_rx_parse(priv, mbuf, hw_annot_addr);
+	dpaa2_dev_rx_mbuf_flc_offload(mbuf, fd);
 
 	DPAA2_PMD_DP_DEBUG("to mbuf - mbuf =%p, mbuf->buf_addr =%p, off = %d,"
 		"fd_off=%d fd =%" PRIx64 ", meta = %d  bpid =%d, len=%d",
@@ -702,6 +691,7 @@ dump_err_pkts(struct dpaa2_queue *dpaa2_q)
 	struct dpaa2_fas *fas;
 	struct rte_mbuf *mbuf;
 	char title[32];
+	struct dpaa2_dev_priv *priv = eth_data->dev_private;
 
 	if (unlikely(!DPAA2_PER_LCORE_DPIO)) {
 		ret = dpaa2_affine_qbman_swp();
@@ -758,14 +748,11 @@ dump_err_pkts(struct dpaa2_queue *dpaa2_q)
 		fas = hw_annot_addr;
 
 		if (DPAA2_FD_GET_FORMAT(fd) == qbman_fd_sg)
-			mbuf = eth_sg_fd_to_mbuf(fd, eth_data->port_id);
+			mbuf = dpaa2_eth_sg_fd_to_mbuf(priv, fd);
 		else
-			mbuf = eth_fd_to_mbuf(fd, eth_data->port_id);
+			mbuf = dpaa2_eth_fd_to_mbuf(priv, fd);
 
-		if (!dpaa2_print_parser_result) {
-			/** Don't print parse result twice.*/
-			dpaa2_print_parse_result(hw_annot_addr);
-		}
+		dpaa2_dev_rx_print_parser_result(priv, fd, mbuf);
 
 		DPAA2_PMD_ERR("Err pkt on port[%d]:", eth_data->port_id);
 		DPAA2_PMD_ERR("FD offset: %d, FD err: %x, FAS status: %x",
@@ -820,18 +807,12 @@ dpaa2_dev_prefetch_rx_common(void *queue, struct rte_mbuf **bufs,
 	struct qbman_pull_desc pulldesc;
 	struct queue_storage_info_t *q_storage;
 	struct rte_eth_dev_data *eth_data = dpaa2_q->eth_data;
+	struct dpaa2_dev_priv *priv = eth_data->dev_private;
 
 	q_storage = dpaa2_q->q_storage[rte_lcore_id()];
 
-	/* the error-queue drain runs on the regular portal (DPAA2_PER_LCORE_PORTAL);
-	 * the channel/interrupt path owns the ethrx portal, so skip it there
-	 */
-	if (!by_channel) {
-		struct dpaa2_dev_priv *priv = eth_data->dev_private;
-
-		if (unlikely(priv->flags & DPAA2_RX_ERROR_QUEUE_FLAG))
-			dump_err_pkts(priv->rx_err_vq);
-	}
+	if (unlikely(priv->flags & DPAA2_RX_ERROR_QUEUE_FLAG))
+		dump_err_pkts(priv->rx_err_vq);
 
 	if (unlikely(!DPAA2_PER_LCORE_ETHRX_DPIO)) {
 		ret = dpaa2_affine_qbman_ethrx_swp();
@@ -937,18 +918,13 @@ dpaa2_dev_prefetch_rx_common(void *queue, struct rte_mbuf **bufs,
 			dpaa2_dev_prefetch_next_psr(dq_storage);
 
 		fd = qbman_result_DQ_fd(dq_storage);
+
 		if (unlikely(DPAA2_FD_GET_FORMAT(fd) == qbman_fd_sg))
-			bufs[num_rx] = eth_sg_fd_to_mbuf(fd, eth_data->port_id);
+			bufs[num_rx] = dpaa2_eth_sg_fd_to_mbuf(priv, fd);
 		else
-			bufs[num_rx] = eth_fd_to_mbuf(fd, eth_data->port_id);
-#if defined(RTE_LIBRTE_IEEE1588)
-		if (bufs[num_rx]->ol_flags & RTE_MBUF_F_RX_IEEE1588_TMST) {
-			struct dpaa2_dev_priv *priv = eth_data->dev_private;
+			bufs[num_rx] = dpaa2_eth_fd_to_mbuf(priv, fd);
 
-			priv->rx_timestamp =
-				*dpaa2_timestamp_dynfield(bufs[num_rx]);
-		}
-#endif
+		dpaa2_dev_rx_print_parser_result(priv, fd, bufs[num_rx]);
 
 		dq_storage++;
 		num_rx++;
@@ -1017,7 +993,10 @@ dpaa2_dev_process_parallel_event(struct qbman_swp *swp,
 	ev->queue_id = rxq->ev.queue_id;
 	ev->priority = rxq->ev.priority;
 
-	ev->mbuf = eth_fd_to_mbuf(fd, rxq->eth_data->port_id);
+	if (unlikely(DPAA2_FD_GET_FORMAT(fd) == qbman_fd_sg))
+		ev->mbuf = dpaa2_eth_sg_fd_to_mbuf(rxq->eth_data->dev_private, fd);
+	else
+		ev->mbuf = dpaa2_eth_fd_to_mbuf(rxq->eth_data->dev_private, fd);
 
 	qbman_swp_dqrr_consume(swp, dq);
 }
@@ -1042,7 +1021,10 @@ dpaa2_dev_process_atomic_event(struct qbman_swp *swp __rte_unused,
 	ev->queue_id = rxq->ev.queue_id;
 	ev->priority = rxq->ev.priority;
 
-	ev->mbuf = eth_fd_to_mbuf(fd, rxq->eth_data->port_id);
+	if (unlikely(DPAA2_FD_GET_FORMAT(fd) == qbman_fd_sg))
+		ev->mbuf = dpaa2_eth_sg_fd_to_mbuf(rxq->eth_data->dev_private, fd);
+	else
+		ev->mbuf = dpaa2_eth_fd_to_mbuf(rxq->eth_data->dev_private, fd);
 
 	dqrr_index = qbman_get_dqrr_idx(dq);
 	*dpaa2_seqn(ev->mbuf) = dqrr_index + 1;
@@ -1069,7 +1051,10 @@ dpaa2_dev_process_ordered_event(struct qbman_swp *swp,
 	ev->queue_id = rxq->ev.queue_id;
 	ev->priority = rxq->ev.priority;
 
-	ev->mbuf = eth_fd_to_mbuf(fd, rxq->eth_data->port_id);
+	if (unlikely(DPAA2_FD_GET_FORMAT(fd) == qbman_fd_sg))
+		ev->mbuf = dpaa2_eth_sg_fd_to_mbuf(rxq->eth_data->dev_private, fd);
+	else
+		ev->mbuf = dpaa2_eth_fd_to_mbuf(rxq->eth_data->dev_private, fd);
 
 	*dpaa2_seqn(ev->mbuf) = DPAA2_ENQUEUE_FLAG_ORP;
 	*dpaa2_seqn(ev->mbuf) |= qbman_result_DQ_odpid(dq) << DPAA2_EQCR_OPRID_SHIFT;
@@ -1179,12 +1164,11 @@ dpaa2_dev_rx_common(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts,
 				dpaa2_dev_prefetch_next_psr(dq_storage);
 
 			fd = qbman_result_DQ_fd(dq_storage);
+
 			if (unlikely(DPAA2_FD_GET_FORMAT(fd) == qbman_fd_sg))
-				bufs[num_rx] = eth_sg_fd_to_mbuf(fd,
-							eth_data->port_id);
+				bufs[num_rx] = dpaa2_eth_sg_fd_to_mbuf(priv, fd);
 			else
-				bufs[num_rx] = eth_fd_to_mbuf(fd,
-							eth_data->port_id);
+				bufs[num_rx] = dpaa2_eth_fd_to_mbuf(priv, fd);
 
 #if defined(RTE_LIBRTE_IEEE1588)
 		if (bufs[num_rx]->ol_flags & RTE_MBUF_F_RX_IEEE1588_TMST) {
@@ -1192,6 +1176,7 @@ dpaa2_dev_rx_common(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts,
 				*dpaa2_timestamp_dynfield(bufs[num_rx]);
 		}
 #endif
+			dpaa2_dev_rx_print_parser_result(priv, fd, bufs[num_rx]);
 
 			dq_storage++;
 			num_rx++;
@@ -1343,6 +1328,7 @@ uint16_t dpaa2_dev_tx_conf(void *queue)
 	return num_tx_conf;
 }
 
+#ifdef RTE_LIBRTE_IEEE1588
 /* Configure the egress frame annotation for timestamp update */
 static void enable_tx_tstamp(struct qbman_fd *fd)
 {
@@ -1364,7 +1350,7 @@ static void enable_tx_tstamp(struct qbman_fd *fd)
 	fd_faead->ctrl = DPAA2_ANNOT_FAEAD_A2V | DPAA2_ANNOT_FAEAD_UPDV |
 				DPAA2_ANNOT_FAEAD_UPD;
 }
-
+#endif
 /*
  * Callback to handle sending packets through WRIOP based interface
  */
@@ -1645,8 +1631,12 @@ dpaa2_dev_free_eqresp_buf(uint16_t eqresp_ci,
 	fd = qbman_result_eqresp_fd(&dpio_dev->eqresp[eqresp_ci]);
 
 	/* Setting port id does not matter as we are to free the mbuf */
-	m = eth_fd_to_mbuf(fd, 0);
-	rte_pktmbuf_free(m);
+	if (unlikely(DPAA2_FD_GET_FORMAT(fd) == qbman_fd_sg))
+		m = dpaa2_eth_sg_fd_to_mbuf(dpaa2_q->eth_data->dev_private, fd);
+	else
+		m = dpaa2_eth_fd_to_mbuf(dpaa2_q->eth_data->dev_private, fd);
+	if (m)
+		rte_pktmbuf_free(m);
 }
 
 static void
diff --git a/drivers/net/dpaa2/rte_pmd_dpaa2.h b/drivers/net/dpaa2/rte_pmd_dpaa2.h
index 237c3cd6e7..83bee098bc 100644
--- a/drivers/net/dpaa2/rte_pmd_dpaa2.h
+++ b/drivers/net/dpaa2/rte_pmd_dpaa2.h
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2018-2024 NXP
+ * Copyright 2018-2026 NXP
  */
 
 #ifndef _RTE_PMD_DPAA2_H
@@ -14,6 +14,17 @@
 #include <rte_compat.h>
 #include <rte_flow.h>
 
+/**
+ * LX series support only.
+ * if (m->ol_flags & RTE_MBUF_F_RX_FDIR) {
+ * tc = (m->hash.fdir.hi >> RTE_DPAA2_MBUF_F_RX_FDIR_TC_OFFSET);
+ * flow = m->hash.fdir.hi & RTE_DPAA2_MBUF_F_RX_FDIR_FLOW_MASK;
+ * }
+ */
+#define RTE_DPAA2_MBUF_F_RX_FDIR_TC_OFFSET 16
+#define RTE_DPAA2_MBUF_F_RX_FDIR_FLOW_MASK \
+	((UINT32_C(1) << RTE_DPAA2_MBUF_F_RX_FDIR_TC_OFFSET) - 1)
+
 /**
  * Create a flow rule to demultiplex ethernet traffic to separate network
  * interfaces.
-- 
2.43.0

