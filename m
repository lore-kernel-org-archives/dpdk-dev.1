Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A421E606A31D
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 Oct 2026 04:43:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4295740A76;
	Fri, 30 Oct 2026 05:43:32 +0100 (CET)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTPS id 886C04025A
 for <dev@dpdk.org>; Fri, 30 Oct 2026 05:43:24 +0100 (CET)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 32B752000BC;
 Fri, 30 Oct 2026 05:43:24 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9F987200094;
 Fri, 30 Oct 2026 05:43:23 +0100 (CET)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id C5B1F180022C;
 Fri, 30 Oct 2026 12:43:22 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com,
	Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v2 2/4] drivers: add offline (O/H) port device support
Date: Fri, 30 Oct 2026 10:13:16 +0530
Message-Id: <20261030044318.1892998-3-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261030044318.1892998-1-g.singh@nxp.com>
References: <20261028085517.705621-1-g.singh@nxp.com>
 <20261030044318.1892998-1-g.singh@nxp.com>
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

Add support for the DPAA Offline/Host-command (O/H) port, allowing a
single OL port to be used by a DPDK application. The feature is
selected through the 'drv_oldev' bus device argument, and the
associated back-half port is named through the 'drv_bh_port' device
argument.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 doc/api/doxy-api-index.md                |   1 +
 doc/guides/nics/dpaa.rst                 |  31 +
 drivers/bus/dpaa/bus_dpaa_driver.h       |   4 +-
 drivers/bus/dpaa/dpaa_bus.c              |  66 +-
 drivers/bus/dpaa/dpaa_bus_base_symbols.c |   1 +
 drivers/bus/dpaa/include/fman.h          |   1 -
 drivers/bus/dpaa/include/fsl_qman.h      |   1 +
 drivers/net/dpaa/dpaa_ethdev.h           |   3 +
 drivers/net/dpaa/dpaa_flow.c             |   7 +-
 drivers/net/dpaa/dpaa_oldev.c            | 875 +++++++++++++++++++++++
 drivers/net/dpaa/meson.build             |  11 +-
 drivers/net/dpaa/rte_pmd_dpaa_oldev.h    | 188 +++++
 12 files changed, 1172 insertions(+), 17 deletions(-)
 create mode 100644 drivers/net/dpaa/dpaa_oldev.c
 create mode 100644 drivers/net/dpaa/rte_pmd_dpaa_oldev.h

diff --git a/doc/api/doxy-api-index.md b/doc/api/doxy-api-index.md
index 62390f7be3..0bd8e1bbf0 100644
--- a/doc/api/doxy-api-index.md
+++ b/doc/api/doxy-api-index.md
@@ -53,6 +53,7 @@ The public API headers are grouped by topics:
   [cnxk_eventdev](@ref rte_pmd_cnxk_eventdev.h),
   [cnxk_mempool](@ref rte_pmd_cnxk_mempool.h),
   [dpaa](@ref rte_pmd_dpaa.h),
+  [dpaa_oldev](@ref rte_pmd_dpaa_oldev.h),
   [dpaa2](@ref rte_pmd_dpaa2.h),
   [mlx5](@ref rte_pmd_mlx5.h),
   [dpaa2_mempool](@ref rte_dpaa2_mempool.h),
diff --git a/doc/guides/nics/dpaa.rst b/doc/guides/nics/dpaa.rst
index c6aab46828..21f54bcd36 100644
--- a/doc/guides/nics/dpaa.rst
+++ b/doc/guides/nics/dpaa.rst
@@ -276,6 +276,37 @@ Refer to the document :doc:`build_and_test` for details.
   and thus disabling hardware based packet handling at driver level,
   e.g. ``dpaa:fm1-mac3,recv_err_pkts=1``.
 
+``drv_bh_port``
+   Name of the back-half port associated with an offline (O/H) port device.
+   It is passed on the offline port device itself, which is named
+   ``oldev1``, e.g. ``-a dpaa_bus:oldev1,drv_bh_port=fm1-mac5``.
+
+The DPAA offline (O/H) port device is only created, and therefore only
+probed, when it is explicitly named on the EAL ``-a`` command line, e.g.::
+
+   -a dpaa_bus:oldev1,drv_bh_port=fm1-mac5
+
+Passing any ``-a`` argument for the DPAA bus switches the bus to allowlist
+scan mode, so from that point on only the devices named with ``-a`` are
+probed. Using the offline port therefore requires listing the offline port
+itself and every Ethernet port the application needs, for example::
+
+   -a dpaa_bus:oldev1,drv_bh_port=fm1-mac5 \
+   -a dpaa_bus:fm1-mac5 -a dpaa_bus:fm1-mac6
+
+Omitting an ``fmX-macY`` port in that case silently drops that port.
+
+The offline port requires the ``/dev/cdx_ctrl`` kernel control device to be
+present; it is provided by the NXP vendor ``cdx`` kernel driver, which is
+not part of this DPDK driver and must be obtained and loaded separately
+(see the NXP LSDK release matching the DPAA SoC family). The uplink
+classification and local-gateway (LGW) configuration exposed through that
+control device can be programmed by the application via the experimental
+``rte_pmd_dpaa_ol_set_classif_info()``, ``rte_pmd_dpaa_ol_reset_classif_info()``,
+``rte_pmd_dpaa_ol_set_lgw_info()`` and ``rte_pmd_dpaa_ol_reset_lgw_info()``
+APIs declared in ``rte_pmd_dpaa_oldev.h``.
+
+
 FMAN Config
 -----------
 
diff --git a/drivers/bus/dpaa/bus_dpaa_driver.h b/drivers/bus/dpaa/bus_dpaa_driver.h
index 4aed83f84d..323a6a7659 100644
--- a/drivers/bus/dpaa/bus_dpaa_driver.h
+++ b/drivers/bus/dpaa/bus_dpaa_driver.h
@@ -69,11 +69,13 @@ struct rte_dpaa_driver;
 enum rte_dpaa_type {
 	FSL_DPAA_ETH = 1,
 	FSL_DPAA_CRYPTO,
-	FSL_DPAA_QDMA
+	FSL_DPAA_QDMA,
+	FSL_DPAA_OL
 };
 
 struct dpaa_device_id {
 	uint8_t fman_id; /**< Fman interface ID, for ETH type device */
+	uint8_t ol_id;	/**< OH interface ID, for OH type device */
 	uint8_t mac_id; /**< Fman MAC interface ID, for ETH type device */
 	uint16_t dev_id; /**< Device Identifier from DPDK */
 };
diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index 6599958925..80d5507a04 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -34,6 +34,8 @@
 #include <bus_driver.h>
 #include <rte_mbuf_pool_ops.h>
 #include <rte_mbuf_dyn.h>
+#include <rte_kvargs.h>
+#include <rte_devargs.h>
 
 #include <dpaa_of.h>
 #include <bus_dpaa_driver.h>
@@ -68,6 +70,12 @@ struct rte_dpaa_bus_private {
 	RTE_ATOMIC(uint16_t) push_rxq_num;
 };
 
+/* Name of the single offline (O/H) port device. The device is only
+ * created, and thus only probed, if the application explicitly lists it
+ * with "-a dpaa_bus:oldev1" (or an equivalent devargs form).
+ */
+#define DPAA_OLDEV_NAME	"oldev1"
+
 static struct rte_bus rte_dpaa_bus;
 static struct rte_dpaa_bus_private dpaa_bus;
 static struct netcfg_info *dpaa_netcfg;
@@ -207,8 +215,44 @@ dpaa_create_device_list(void)
 	struct fm_eth_port_cfg *cfg;
 	struct fman_if *fman_intf;
 
+	struct rte_devargs *oldev_devargs;
+
 	dpaa_bus.device_count = 0;
 
+	/* The offline port is only created if the application explicitly
+	 * asked for it with "-a dpaa_bus:oldev1" (plus any devargs), e.g.
+	 * when the device is created without a backing devargs entry it
+	 * would never be probed, so avoid creating it at all.
+	 */
+	oldev_devargs = rte_bus_find_devargs(&rte_dpaa_bus, DPAA_OLDEV_NAME);
+
+	if (!dpaa_netcfg && !oldev_devargs)
+		return 0;
+
+	/* Creating OL Device */
+	if (oldev_devargs) {
+		dev = calloc(1, sizeof(struct rte_dpaa_device));
+		if (!dev) {
+			DPAA_BUS_ERR("Failed to allocate OL devices");
+			return -ENOMEM;
+		}
+
+		dev->device_type = FSL_DPAA_OL;
+		dev->id.ol_id = 0;
+		dev->id.dev_id = dpaa_bus.device_count;
+
+		/* Create device name */
+		snprintf(dev->name, RTE_ETH_NAME_MAX_LEN, "oldev%d",
+			 (dev->id.ol_id + 1));
+		DPAA_BUS_INFO("%s oldev added", dev->name);
+		dev->device.name = dev->name;
+		dev->device.devargs = oldev_devargs;
+		DPAA_BUS_INFO("**Devargs matched %s", dev->name);
+
+		dpaa_add_to_device_list(dev);
+		dpaa_bus.device_count++;
+	}
+
 	/* Creating Ethernet Devices */
 	for (i = 0; dpaa_netcfg && (i < dpaa_netcfg->num_ethports); i++) {
 		dev = calloc(1, sizeof(struct rte_dpaa_device));
@@ -298,8 +342,7 @@ dpaa_create_device_list(void)
 		 * crypto PMD, using RTE_ETH_NAME_MAX_LEN as that is the size
 		 * allocated for dev->name/
 		 */
-		memset(dev->name, 0, RTE_ETH_NAME_MAX_LEN);
-		sprintf(dev->name, "dpaa_sec-%d", i+1);
+		snprintf(dev->name, RTE_ETH_NAME_MAX_LEN, "dpaa_sec-%d", i + 1);
 		DPAA_BUS_INFO("%s cryptodev added", dev->name);
 		dev->device.name = dev->name;
 		dev->device.devargs = rte_bus_find_devargs(&rte_dpaa_bus, dev->name);
@@ -324,8 +367,7 @@ dpaa_create_device_list(void)
 		dev->device_type = FSL_DPAA_QDMA;
 		dev->id.dev_id = dpaa_bus.device_count + i;
 
-		memset(dev->name, 0, RTE_ETH_NAME_MAX_LEN);
-		sprintf(dev->name, "dpaa_qdma-%d", i+1);
+		snprintf(dev->name, RTE_ETH_NAME_MAX_LEN, "dpaa_qdma-%d", i + 1);
 		DPAA_BUS_INFO("%s qdma device added", dev->name);
 		dev->device.name = dev->name;
 		dev->device.devargs = rte_bus_find_devargs(&rte_dpaa_bus, dev->name);
@@ -513,7 +555,7 @@ rte_dpaa_bus_parse(const char *name, void *out)
 	}
 
 	/* dev_delta points to the dev name (mac/oh/onic). Not valid for
-	 * dpaa_sec.
+	 * dpaa_sec and oldev.
 	 */
 	dev_delta = delta + sizeof("fm.-") - 1;
 
@@ -527,6 +569,10 @@ rte_dpaa_bus_parse(const char *name, void *out)
 				i < 1 || i > RTE_DPAA_QDMA_DEVICES)
 			return -EINVAL;
 		max_name_len = sizeof("dpaa_qdma-.") - 1;
+	} else if (strncmp("oldev", &name[delta], 5) == 0) {
+		if (sscanf(&name[delta], "oldev%u", &i) != 1 || i != 1)
+			return -EINVAL;
+		max_name_len = sizeof("oldev.") - 1;
 	} else if (strncmp("oh", &name[dev_delta], 2) == 0) {
 		if (sscanf(&name[delta], "fm%u-oh%u", &i, &j) != 2 ||
 				i >= 2 || j >= 16)
@@ -624,7 +670,8 @@ rte_dpaa_bus_dev_build(void)
 
 	/* Get the interface configurations from device-tree */
 	dpaa_netcfg = netcfg_acquire();
-	if (!dpaa_netcfg) {
+	if (!dpaa_netcfg &&
+	    !rte_bus_find_devargs(&rte_dpaa_bus, DPAA_OLDEV_NAME)) {
 		DPAA_BUS_ERR("netcfg failed: /dev/fsl_usdpaa device not available");
 		DPAA_BUS_WARN("Check if you are using USDPAA based device tree");
 		return -EINVAL;
@@ -632,7 +679,7 @@ rte_dpaa_bus_dev_build(void)
 
 	DPAA_BUS_NOTICE("DPAA Bus Detected");
 
-	if (!dpaa_netcfg->num_ethports) {
+	if (dpaa_netcfg && !dpaa_netcfg->num_ethports) {
 		DPAA_BUS_INFO("NO DPDK mapped net interfaces available");
 		/* This is not an error */
 	}
@@ -640,9 +687,10 @@ rte_dpaa_bus_dev_build(void)
 #ifdef RTE_LIBRTE_DPAA_DEBUG_DRIVER
 	dump_netcfg(dpaa_netcfg, stdout);
 #endif
-
-	DPAA_BUS_DEBUG("Number of ethernet devices = %d",
+	if (dpaa_netcfg) {
+		DPAA_BUS_DEBUG("Number of ethernet devices = %d",
 			     dpaa_netcfg->num_ethports);
+	}
 	ret = dpaa_create_device_list();
 	if (ret) {
 		DPAA_BUS_ERR("Unable to create device list. (%d)", ret);
diff --git a/drivers/bus/dpaa/dpaa_bus_base_symbols.c b/drivers/bus/dpaa/dpaa_bus_base_symbols.c
index 0927e5fe2c..aaa9f9bec2 100644
--- a/drivers/bus/dpaa/dpaa_bus_base_symbols.c
+++ b/drivers/bus/dpaa/dpaa_bus_base_symbols.c
@@ -52,6 +52,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(bman_acquire)
 RTE_EXPORT_INTERNAL_SYMBOL(bman_query_free_buffers)
 RTE_EXPORT_INTERNAL_SYMBOL(bman_thread_irq)
 RTE_EXPORT_INTERNAL_SYMBOL(qman_alloc_fqid_range)
+RTE_EXPORT_INTERNAL_SYMBOL(qman_release_fqid_range)
 RTE_EXPORT_INTERNAL_SYMBOL(qman_reserve_fqid_range)
 RTE_EXPORT_INTERNAL_SYMBOL(qman_alloc_pool_range)
 RTE_EXPORT_INTERNAL_SYMBOL(qman_alloc_cgrid_range)
diff --git a/drivers/bus/dpaa/include/fman.h b/drivers/bus/dpaa/include/fman.h
index f499f9ebbf..030c85c284 100644
--- a/drivers/bus/dpaa/include/fman.h
+++ b/drivers/bus/dpaa/include/fman.h
@@ -480,7 +480,6 @@ struct __fman_if {
 	void *qmi_map;
 };
 
-#define MEMMAC_REG_OFFSET(reg) offsetof(struct memac_regs, reg)
 #define BMI_RX_REG_OFFSET(reg) offsetof(struct rx_bmi_regs, reg)
 #define BMI_TX_REG_OFFSET(reg) offsetof(struct tx_bmi_regs, reg)
 
diff --git a/drivers/bus/dpaa/include/fsl_qman.h b/drivers/bus/dpaa/include/fsl_qman.h
index 59b41e17f0..b2674ce5d0 100644
--- a/drivers/bus/dpaa/include/fsl_qman.h
+++ b/drivers/bus/dpaa/include/fsl_qman.h
@@ -1895,6 +1895,7 @@ static inline int qman_alloc_fqid(u32 *result)
  * This function can also be used to seed the allocator with ranges of FQIDs
  * that it can subsequently allocate from.
  */
+__rte_internal
 void qman_release_fqid_range(u32 fqid, unsigned int count);
 static inline void qman_release_fqid(u32 fqid)
 {
diff --git a/drivers/net/dpaa/dpaa_ethdev.h b/drivers/net/dpaa/dpaa_ethdev.h
index 47c8e2b086..7e70bf2ad2 100644
--- a/drivers/net/dpaa/dpaa_ethdev.h
+++ b/drivers/net/dpaa/dpaa_ethdev.h
@@ -114,6 +114,9 @@ enum {
 
 #define DPAA_DEFAULT_RXQ_VSP_ID		1
 
+/* Device argument to name the offline (O/H) port back-half port */
+#define DRIVER_OL_BH_PORT		"drv_bh_port"
+
 #define FMC_FILE "/tmp/fmc.bin"
 
 struct dpaa_if_vsp {
diff --git a/drivers/net/dpaa/dpaa_flow.c b/drivers/net/dpaa/dpaa_flow.c
index f77f9f333b..6c519ec975 100644
--- a/drivers/net/dpaa/dpaa_flow.c
+++ b/drivers/net/dpaa/dpaa_flow.c
@@ -32,9 +32,14 @@ return &scheme_params->param.key_ext_and_hash.extract_array[hdr_idx];
 	SCH_EXT_HDR(scheme_params, hdr_idx).extract_by_hdr_type.full_field
 
 /* FMAN mac indexes mappings (0 is unused, first 8 are for 1G, next for 10G
- * ports).
+ * ports). Indexed by fman_if.mac_idx, which the bus validates against
+ * FMAN_MAX_MAC_IDX_NUM when deriving it from the device tree.
  */
 static const uint8_t mac_idx[] = {-1, 0, 1, 2, 3, 4, 5, 6, 7, 0, 1};
+static_assert(RTE_DIM(mac_idx) == FMAN_MAX_MAC_IDX_NUM,
+	"mac_idx[] out of sync with FMAN_MAX_MAC_IDX_NUM");
+
+
 
 /* FM global info */
 struct dpaa_fm_info {
diff --git a/drivers/net/dpaa/dpaa_oldev.c b/drivers/net/dpaa/dpaa_oldev.c
new file mode 100644
index 0000000000..ceec48daf3
--- /dev/null
+++ b/drivers/net/dpaa/dpaa_oldev.c
@@ -0,0 +1,875 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2020-2026 NXP
+ */
+
+#include <assert.h>
+#include <stdio.h>
+#include <sys/ioctl.h>
+
+#include <rte_dpaa_logs.h>
+#include <rte_kvargs.h>
+#include <rte_stdatomic.h>
+
+#include <rte_string_fns.h>
+#include <bus_dpaa_driver.h>
+#include <dpaa_ethdev.h>
+#include <dpaa_rxtx.h>
+#include <dpaa_mempool.h>
+
+#include <eal_export.h>
+#include <fsl_fman.h>
+
+#include "rte_pmd_dpaa_oldev.h"
+
+/* The ol device is a tx are queue pair, which is provided to the kernel through
+ * ioctl calls. It is exposed as a virtual port to the application.
+ * This ASK Device provides IOCTL calls to driver for communicating fqid's,
+ * buffer pool id's and channel id's with kernel.
+ */
+#define ASK_PATH		"/dev/cdx_ctrl"
+#define CDX_IOC_MAGIC		0xbe
+
+#define MAX_BH_PORT_NAME_LEN	12
+
+/* Private area reserved by driver.
+ * Aligned with "struct annotations_t". Parse results will be written from
+ * the 17th byte by the HW.
+ */
+#define DPAA_OL_PARSERSLT_START_OFFSET 16
+#define DPAA_OL_DATA_ALIGNMENT 64
+/* Change this value to increase the data offset.
+ * final value will be aligned by DPAA_OL_DATA_ALIGNMENT
+ */
+#define DPAA_OL_MAX_EXTRA_SIZE 0
+#define DPAA_OL_PARSE_RESULT_REQUIRED true
+#define DPAA_OL_TIME_STAMP_REQUIRED false
+#define DPAA_OL_HASH_RESULT_REQUIRED false
+#define DPAA_OL_PCD_INFO_REQUIRED false
+
+/* Work queue ID used for the offline port ingress sequence classifier. */
+#define DPA_ISC_WQ_ID 2
+
+/* Control device descriptor, opened on demand. The fast path reads it
+ * without holding fd_init_lock, so all accesses are atomic.
+ */
+static RTE_ATOMIC(int)ask_fd = -1;
+static pthread_mutex_t fd_init_lock = PTHREAD_MUTEX_INITIALIZER;
+
+struct ask_ctrl_offline_channel {
+	uint32_t channel_id;
+	uint32_t ctx_a_hi_val;	/* Setting required flags(B0,A2) while creating
+				 * frame queue.
+				 */
+	uint32_t ctx_a_lo_val;	/* EBD and VSP enable bits */
+	uint32_t ctx_b_val;	/* VSP ID */
+};
+
+struct ask_ctrl_dpdk_fq_info_s {
+	uint32_t tx_fq_id;		/* DPDK transmits GTP packets using FQ
+					 * ID
+					 */
+	uint32_t rx_fq_id;		/* DPDK receives packets from FMAN */
+	uint16_t buff_size;		/* Size of each buffer in DPDPK buffer
+					 * pool
+					 */
+	uint8_t bp_id;			/* DPDK buffer pool id */
+	/* BH port interface name; set from the mandatory drv_bh_port
+	 * devarg (see DRIVER_OL_BH_PORT).
+	 */
+	uint8_t bh_port_name[MAX_BH_PORT_NAME_LEN];
+	/* below fields are taken from structure t_FmBufferPrefixContent, These
+	 * fields are required for VSP creation on DPDK buffer pool ID. These
+	 * fields should be set based on expected parameters from FMAN
+	 */
+	uint16_t privDataSize;		/* Number of bytes to be left at the
+					 * beginning of the external buffer;
+					 * Note that the private-area will start
+					 * from the base of the buffer address.
+					 */
+	bool passPrsResult;		/* TRUE to pass the parse result to/from
+					 * the FM; User may use
+					 * FM_PORT_GetBufferPrsResult() in order
+					 * to get the parser-result from a
+					 * buffer.
+					 */
+	bool passTimeStamp;		/* < TRUE to pass the timeStamp to/from
+					 * the FM User may use
+					 * FM_PORT_GetBufferTimeStamp() in order
+					 * to get the parser-result from a
+					 * buffer.
+					 */
+	bool passHashResult;		/* TRUE to pass the KG hash result
+					 * to/from the FM User may use
+					 * FM_PORT_GetBufferHashResult() in
+					 * order to get the parser-result from a
+					 * buffer.
+					 */
+	bool passAllOtherPCDInfo;	/* Add all other Internal-Context
+					 * information: AD, hash-result, key,
+					 * etc.
+					 */
+	uint16_t dataAlign;		/* 0 to use driver's default alignment
+					 * [DEFAULT_FM_SP_bufferPrefixContent_dataAlign],
+					 * other value for selecting a data
+					 * alignment (must be a power of 2); if
+					 * write optimization is used, must be
+					 * >= 16.
+					 */
+	uint8_t manipExtraSpace;	/* Maximum extra size needed (insertion-
+					 * size minus removal-size); Note that
+					 * this field impacts the size of the
+					 * buffer-prefix (i.e. it pushes the
+					 * data offset); This field is
+					 * irrelevant if DPAA_VERSION==10
+					 */
+};
+
+#define ASK_CTRL_GET_OFFLINE_CHANNEL_INFO \
+	_IOWR(CDX_IOC_MAGIC, 8, struct ask_ctrl_offline_channel)
+#define ASK_CTRL_SET_DPDK_INFO \
+	_IOWR(CDX_IOC_MAGIC, 9, struct ask_ctrl_dpdk_fq_info_s)
+#define ASK_CTRL_SET_CLASSIF_INFO \
+	_IOWR(CDX_IOC_MAGIC, 10, struct rte_pmd_dpaa_uplink_cls_info_s)
+#define ASK_CTRL_RESET_CLASSIF_INFO \
+	_IOWR(CDX_IOC_MAGIC, 11, struct rte_pmd_dpaa_uplink_cls_info_s)
+#define ASK_CTRL_SET_LGW_INFO \
+	_IOWR(CDX_IOC_MAGIC, 12, struct rte_pmd_dpaa_lgw_info_s)
+#define ASK_CTRL_RESET_LGW_INFO \
+	_IOWR(CDX_IOC_MAGIC, 13, struct rte_pmd_dpaa_lgw_info_s)
+
+
+/* Return the control device descriptor, opening it on first use. */
+static int check_fd(void)
+{
+	int cur_fd, ret;
+
+	cur_fd = rte_atomic_load_explicit(&ask_fd, rte_memory_order_acquire);
+	if (cur_fd >= 0)
+		return cur_fd;
+
+	ret = pthread_mutex_lock(&fd_init_lock);
+	assert(!ret);
+	/* check again with the lock held */
+	cur_fd = rte_atomic_load_explicit(&ask_fd, rte_memory_order_relaxed);
+	if (cur_fd < 0) {
+		cur_fd = open(ASK_PATH, O_RDWR | O_CLOEXEC);
+		if (cur_fd >= 0)
+			rte_atomic_store_explicit(&ask_fd, cur_fd,
+						  rte_memory_order_release);
+	}
+	ret = pthread_mutex_unlock(&fd_init_lock);
+	assert(!ret);
+
+	return (cur_fd >= 0) ? cur_fd : -ENODEV;
+}
+
+static int ask_get_channel_info(struct ask_ctrl_offline_channel *ch_info)
+{
+	int ret, fd = check_fd();
+
+	if (fd < 0)
+		return fd;
+
+	ret = ioctl(fd, ASK_CTRL_GET_OFFLINE_CHANNEL_INFO, ch_info);
+	if (ret) {
+		int err = errno;
+
+		/* Save errno first: the log call may overwrite it. */
+		DPAA_PMD_ERR("Get channel info ioctl failed with errno: %s", strerror(err));
+		return -err;
+	}
+
+	DPAA_PMD_DEBUG("Get channel info successful");
+	DPAA_PMD_DEBUG("Channel id: %x", ch_info->channel_id);
+	DPAA_PMD_DEBUG("ctx_a_hi_val: %x", ch_info->ctx_a_hi_val);
+	DPAA_PMD_DEBUG("ctx_a_lo_val: %x", ch_info->ctx_a_lo_val);
+	DPAA_PMD_DEBUG("ctx_b_val: %x", ch_info->ctx_b_val);
+
+	return 0;
+}
+
+static int ask_set_fq_info(struct ask_ctrl_dpdk_fq_info_s *fq_info)
+{
+	int ret, fd = check_fd();
+
+	if (fd < 0)
+		return fd;
+
+	ret = ioctl(fd, ASK_CTRL_SET_DPDK_INFO, fq_info);
+	if (ret) {
+		int err = errno;
+
+		/* Save errno first: the log call may overwrite it. */
+		DPAA_PMD_ERR("Set FQ info ioctl failed with errno: %s", strerror(err));
+		return -err;
+	}
+
+	DPAA_PMD_DEBUG("Set fq info successful");
+	DPAA_PMD_DEBUG("Tx fqid: %x", fq_info->tx_fq_id);
+	DPAA_PMD_DEBUG("Rx fqid: %x", fq_info->rx_fq_id);
+	DPAA_PMD_DEBUG("buff_size: %d", fq_info->buff_size);
+	DPAA_PMD_DEBUG("bp_id: %d", fq_info->bp_id);
+	DPAA_PMD_DEBUG("Backhaul port name: %s", fq_info->bh_port_name);
+
+	return 0;
+}
+
+static int
+dpaa_ol_dev_configure(__rte_unused struct rte_eth_dev *dev)
+{
+	PMD_INIT_FUNC_TRACE();
+
+	return 0;
+}
+
+static int dpaa_ol_dev_info(struct rte_eth_dev *dev,
+			    struct rte_eth_dev_info *dev_info)
+{
+	struct dpaa_if *dpaa_intf = dev->data->dev_private;
+
+	PMD_INIT_FUNC_TRACE();
+
+	dev_info->max_rx_queues = dpaa_intf->nb_rx_queues;
+	dev_info->max_tx_queues = dpaa_intf->nb_tx_queues;
+	dev_info->max_rx_pktlen = DPAA_MAX_RX_PKT_LEN;
+	dev_info->max_mac_addrs = DPAA_MAX_MAC_FILTER;
+	dev_info->max_hash_mac_addrs = 0;
+	dev_info->max_vfs = 0;
+
+	dev_info->speed_capa = RTE_ETH_LINK_SPEED_10M_HD |
+			       RTE_ETH_LINK_SPEED_10M |
+			       RTE_ETH_LINK_SPEED_100M_HD |
+			       RTE_ETH_LINK_SPEED_100M |
+			       RTE_ETH_LINK_SPEED_1G |
+			       RTE_ETH_LINK_SPEED_2_5G |
+			       RTE_ETH_LINK_SPEED_10G;
+
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_dpaa_ol_set_classif_info, 26.11)
+int rte_pmd_dpaa_ol_set_classif_info(struct rte_pmd_dpaa_uplink_cls_info_s *classif_info)
+{
+	int i, ret, fd;
+
+	if (classif_info == NULL) {
+		DPAA_PMD_ERR("No classification data available");
+		return -EINVAL;
+	}
+
+	fd = check_fd();
+	if (fd < 0)
+		return fd;
+
+	ret = ioctl(fd, ASK_CTRL_SET_CLASSIF_INFO, classif_info);
+	if (ret) {
+		int err = errno;
+
+		/* Save errno first: the log call may overwrite it. */
+		DPAA_PMD_ERR("Set classification info ioctl failed with errno: %s",
+			     strerror(err));
+		return -err;
+	}
+
+	DPAA_PMD_DEBUG("Set classification info successful");
+	for (i = 0; i < classif_info->num_ports; i++) {
+		DPAA_PMD_DEBUG("UDP dest port: %d",
+			       classif_info->gtp_udp_port[i]);
+	}
+	DPAA_PMD_DEBUG("Protocol ID: %d", classif_info->gtp_proto_id);
+
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_dpaa_ol_reset_classif_info, 26.11)
+int rte_pmd_dpaa_ol_reset_classif_info(void)
+{
+	struct rte_pmd_dpaa_uplink_cls_info_s classif_info;
+	int ret, fd;
+
+	fd = check_fd();
+	if (fd < 0)
+		return fd;
+
+	memset(&classif_info, 0, sizeof(classif_info));
+
+	ret = ioctl(fd, ASK_CTRL_RESET_CLASSIF_INFO, &classif_info);
+	if (ret) {
+		int err = errno;
+
+		/* Save errno first: the log call may overwrite it. */
+		DPAA_PMD_ERR("Reset classification info ioctl failed with errno: %s",
+			     strerror(err));
+		return -err;
+	}
+
+	DPAA_PMD_DEBUG("Reset classification info successful");
+
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_dpaa_ol_set_lgw_info, 26.11)
+int rte_pmd_dpaa_ol_set_lgw_info(struct rte_pmd_dpaa_lgw_info_s *lgw_info)
+{
+	int ret, fd;
+
+	if (lgw_info == NULL) {
+		DPAA_PMD_ERR("No LGW data available");
+		return -EINVAL;
+	}
+
+	fd = check_fd();
+	if (fd < 0)
+		return fd;
+
+	ret = ioctl(fd, ASK_CTRL_SET_LGW_INFO, lgw_info);
+	if (ret) {
+		int err = errno;
+
+		/* Save errno first: the log call may overwrite it. */
+		DPAA_PMD_ERR("Set LGW info ioctl failed with errno: %s", strerror(err));
+		return -err;
+	}
+
+	DPAA_PMD_DEBUG("Set LGW info successful");
+
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_dpaa_ol_reset_lgw_info, 26.11)
+int rte_pmd_dpaa_ol_reset_lgw_info(void)
+{
+	struct rte_pmd_dpaa_lgw_info_s lgw_info;
+	int ret, fd;
+
+	PMD_INIT_FUNC_TRACE();
+
+	fd = check_fd();
+	if (fd < 0)
+		return fd;
+
+	memset(&lgw_info, 0, sizeof(lgw_info));
+
+	ret = ioctl(fd, ASK_CTRL_RESET_LGW_INFO, &lgw_info);
+	if (ret) {
+		int err = errno;
+
+		/* Save errno first: the log call may overwrite it. */
+		DPAA_PMD_ERR("Reset LGW info ioctl failed with errno: %s", strerror(err));
+		return -err;
+	}
+
+	DPAA_PMD_DEBUG("Reset LGW info successful");
+
+	return 0;
+}
+
+static int dpaa_ol_set_fq_info(struct rte_eth_dev *dev);
+
+static int dpaa_ol_dev_start(struct rte_eth_dev *dev)
+{
+	int ret;
+
+	PMD_INIT_FUNC_TRACE();
+
+	/* Hand the Rx/Tx FQIDs and buffer pool to the kernel here rather than
+	 * from tx_queue_setup(): ethdev does not order Rx and Tx queue setup,
+	 * and testpmd sets Tx up first, so at tx_queue_setup() time the Rx
+	 * side may not be configured yet. By dev_start() both are known.
+	 */
+	ret = dpaa_ol_set_fq_info(dev);
+	if (ret)
+		return ret;
+
+	dev->tx_pkt_burst = dpaa_eth_queue_tx;
+
+	return 0;
+}
+
+static int dpaa_ol_dev_stop(struct rte_eth_dev *dev)
+{
+	PMD_INIT_FUNC_TRACE();
+
+	dev->tx_pkt_burst = dpaa_eth_tx_drop_all;
+
+	return 0;
+}
+
+static void dpaa_oldev_queues_release(struct dpaa_if *dpaa_intf);
+
+static int dpaa_ol_dev_close(struct rte_eth_dev *dev)
+{
+	struct dpaa_if *dpaa_intf;
+	int cur_fd;
+
+	PMD_INIT_FUNC_TRACE();
+
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return 0;
+
+	/* Release the driver private rx/tx_queues here so that an application
+	 * that only calls rte_eth_dev_close() (without removing the device)
+	 * still shuts down the FQs and frees the queue memory.
+	 */
+	dpaa_intf = dev->data->dev_private;
+	if (dpaa_intf)
+		dpaa_oldev_queues_release(dpaa_intf);
+
+	cur_fd = rte_atomic_exchange_explicit(&ask_fd, -1,
+					      rte_memory_order_acq_rel);
+	if (cur_fd >= 0)
+		close(cur_fd);
+
+	return 0;
+}
+
+static inline void
+dpaa_poll_queue_default_config(struct qm_mcc_initfq *opts)
+{
+	memset(opts, 0, sizeof(struct qm_mcc_initfq));
+	opts->we_mask = QM_INITFQ_WE_CONTEXTA;
+	opts->fqd.fq_ctrl = QM_FQCTRL_AVOIDBLOCK | QM_FQCTRL_CTXASTASHING |
+			    QM_FQCTRL_PREFERINCACHE;
+	opts->fqd.context_a.stashing.exclusive = 0;
+	if (dpaa_soc_ver() != SVR_LS1046A_FAMILY)
+		opts->fqd.context_a.stashing.annotation_cl =
+				DPAA_IF_RX_ANNOTATION_STASH;
+	opts->fqd.context_a.stashing.data_cl = DPAA_IF_RX_DATA_STASH;
+	opts->fqd.context_a.stashing.context_cl = DPAA_IF_RX_CONTEXT_STASH;
+}
+
+static
+int dpaa_ol_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
+			    __rte_unused uint16_t nb_desc,
+			    unsigned int socket_id __rte_unused,
+			    __rte_unused const struct rte_eth_rxconf *rx_conf,
+			    struct rte_mempool *mp)
+{
+	struct dpaa_if *dpaa_intf = dev->data->dev_private;
+	struct qman_fq *rxq = &dpaa_intf->rx_queues[queue_idx];
+
+	PMD_INIT_FUNC_TRACE();
+
+	dpaa_intf->bp_info = DPAA_MEMPOOL_TO_POOL_INFO(mp);
+	dpaa_intf->valid = 1;
+
+	if (!rte_dpaa_bpid_info) {
+		DPAA_PMD_ERR("BPID info array not initialized");
+		return -ENOMEM;
+	}
+	rxq->bp_array = rte_dpaa_bpid_info;
+	dev->data->rx_queues[queue_idx] = rxq;
+
+	return 0;
+}
+
+/* Parse devargs, validating keys against the driver's parameter list. */
+static int
+dpaa_ol_get_bh_port_name(struct rte_devargs *devargs, char *val, size_t size)
+{
+	static const char * const valid_keys[] = { DRIVER_OL_BH_PORT, NULL };
+	struct rte_kvargs *kvlist;
+	const char *str;
+	int ret;
+
+	if (!devargs || !devargs->args)
+		return 0;
+
+	kvlist = rte_kvargs_parse(devargs->args, valid_keys);
+	if (!kvlist) {
+		DPAA_PMD_ERR("Invalid devargs for offline port \"%s\"",
+			     devargs->args);
+		return -EINVAL;
+	}
+
+	if (!rte_kvargs_count(kvlist, DRIVER_OL_BH_PORT)) {
+		rte_kvargs_free(kvlist);
+		return 0;
+	}
+
+	str = rte_kvargs_get(kvlist, DRIVER_OL_BH_PORT);
+	if (str == NULL) {
+		rte_kvargs_free(kvlist);
+		return 0;
+	}
+
+	ret = rte_strscpy(val, str, size);
+	rte_kvargs_free(kvlist);
+	if (ret < 0)
+		return ret;
+
+	return 1;
+}
+
+static
+int dpaa_ol_tx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
+			   uint16_t nb_desc __rte_unused,
+			   unsigned int socket_id __rte_unused,
+			   const struct rte_eth_txconf *tx_conf __rte_unused)
+{
+	struct dpaa_if *dpaa_intf = dev->data->dev_private;
+	struct qman_fq *txq = &dpaa_intf->tx_queues[queue_idx];
+
+	PMD_INIT_FUNC_TRACE();
+
+	dev->data->tx_queues[queue_idx] = txq;
+
+	return 0;
+}
+
+/* Program the Rx/Tx FQIDs and the buffer pool into the kernel. Called from
+ * dev_start(), by which point both the Rx and the Tx queue are set up.
+ */
+static int dpaa_ol_set_fq_info(struct rte_eth_dev *dev)
+{
+	struct dpaa_if *dpaa_intf = dev->data->dev_private;
+	struct ask_ctrl_dpdk_fq_info_s fq_info;
+	struct qman_fq *txq, *rxq;
+	struct rte_pktmbuf_pool_private *mbp_priv;
+	int ret;
+
+	if (dpaa_intf->rx_queues == NULL || dpaa_intf->tx_queues == NULL) {
+		DPAA_PMD_ERR("Rx/Tx queues not allocated");
+		return -EINVAL;
+	}
+
+	if (dpaa_intf->bp_info == NULL) {
+		DPAA_PMD_ERR("Rx queue must be set up before starting the port");
+		return -EINVAL;
+	}
+
+	txq = &dpaa_intf->tx_queues[0];
+	rxq = &dpaa_intf->rx_queues[0];
+	memset(&fq_info, 0, sizeof(fq_info));
+	mbp_priv = (struct rte_pktmbuf_pool_private *)rte_mempool_get_priv(dpaa_intf->bp_info->mp);
+	fq_info.tx_fq_id = txq->fqid;
+	fq_info.rx_fq_id = rxq->fqid;
+	fq_info.buff_size = mbp_priv->mbuf_data_room_size;
+	fq_info.bp_id = dpaa_intf->bp_info->bpid;
+
+	fq_info.privDataSize = DPAA_OL_PARSERSLT_START_OFFSET;
+	fq_info.passPrsResult = DPAA_OL_PARSE_RESULT_REQUIRED;
+	fq_info.passTimeStamp = DPAA_OL_TIME_STAMP_REQUIRED;
+	fq_info.passHashResult = DPAA_OL_HASH_RESULT_REQUIRED;
+	fq_info.passAllOtherPCDInfo = DPAA_OL_PCD_INFO_REQUIRED;
+	fq_info.dataAlign = DPAA_OL_DATA_ALIGNMENT;
+	fq_info.manipExtraSpace = DPAA_OL_MAX_EXTRA_SIZE;
+
+	ret = dpaa_ol_get_bh_port_name(dev->device->devargs,
+				       (char *)fq_info.bh_port_name,
+				       MAX_BH_PORT_NAME_LEN);
+	if (ret <= 0) {
+		DPAA_PMD_ERR("Offline port \"%s\" devarg not defined or invalid (ret=%d)",
+			     DRIVER_OL_BH_PORT, ret);
+		return -EINVAL;
+	}
+
+	ret = ask_set_fq_info(&fq_info);
+	if (ret) {
+		DPAA_PMD_ERR("Set FQ info failed with ret: %d", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int dpaa_ol_link_update(struct rte_eth_dev *dev,
+			       __rte_unused int wait_to_complete)
+{
+	struct dpaa_if *dpaa_intf = dev->data->dev_private;
+	struct rte_eth_link *link = &dev->data->dev_link;
+
+	PMD_INIT_FUNC_TRACE();
+
+	link->link_status = dpaa_intf->valid;
+	link->link_speed = RTE_ETH_SPEED_NUM_NONE;
+	link->link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
+	link->link_autoneg = RTE_ETH_LINK_AUTONEG;
+
+	return 0;
+}
+
+static int dpaa_ol_promiscuous_enable(__rte_unused struct rte_eth_dev *dev)
+{
+	PMD_INIT_FUNC_TRACE();
+
+	return 0;
+}
+
+static int dpaa_ol_rx_queue_init(struct qman_fq *fq, uint32_t fqid)
+{
+	int ret;
+	struct qm_mcc_initfq opts = {0};
+	u32 flags = QMAN_FQ_FLAG_DYNAMIC_FQID | QMAN_FQ_FLAG_NO_ENQUEUE;
+
+	if (unlikely(!DPAA_PER_LCORE_PORTAL)) {
+		ret = rte_dpaa_portal_init(NULL);
+		if (ret < 0) {
+			DPAA_PMD_ERR("portal initialization failure");
+			return ret;
+		}
+	}
+
+	ret = qman_create_fq(fqid, flags, fq);
+	if (ret) {
+		DPAA_PMD_ERR("create rx fqid 0x%x failed with ret: %d", fqid,
+			     ret);
+		return ret;
+	}
+	fq->is_static = false;
+
+	dpaa_poll_queue_default_config(&opts);
+
+	ret = qman_init_fq(fq, 0, &opts);
+	if (ret)
+		DPAA_PMD_ERR("init rx fqid 0x%x failed with ret:%d", fqid, ret);
+	return ret;
+}
+
+static int dpaa_ol_tx_queue_init(struct qman_fq *fq, uint32_t fqid)
+{
+	int ret;
+	struct qm_mcc_initfq opts = {0};
+	u32 flags = QMAN_FQ_FLAG_DYNAMIC_FQID | QMAN_FQ_FLAG_TO_DCPORTAL;
+	struct ask_ctrl_offline_channel ch_info;
+
+	memset(&ch_info, 0, sizeof(ch_info));
+
+	ret = ask_get_channel_info(&ch_info);
+	if (ret) {
+		DPAA_PMD_ERR("Get channel info failed with ret: %d", ret);
+		return ret;
+	}
+	ret = qman_create_fq(fqid, flags, fq);
+	if (ret) {
+		DPAA_PMD_ERR("Create tx fq failed with ret: %d", ret);
+		return ret;
+	}
+
+	opts.we_mask = QM_INITFQ_WE_DESTWQ |
+		       QM_INITFQ_WE_CONTEXTB | QM_INITFQ_WE_CONTEXTA;
+
+	opts.fqd.dest.channel = ch_info.channel_id;
+	opts.fqd.dest.wq = DPA_ISC_WQ_ID;
+	opts.fqd.fq_ctrl = QM_FQCTRL_PREFERINCACHE;
+	opts.fqd.context_b = ch_info.ctx_b_val;
+	opts.fqd.context_a.hi = ch_info.ctx_a_hi_val;
+	opts.fqd.context_a.lo = ch_info.ctx_a_lo_val;
+
+	opts.fqid = fq->fqid;
+	fq->ch_id = ch_info.channel_id;
+	opts.count = 1;
+
+	ret = qman_init_fq(fq, QMAN_INITFQ_FLAG_SCHED, &opts);
+	if (ret)
+		DPAA_PMD_ERR("init tx fqid 0x%x failed %d", fq->fqid, ret);
+	return ret;
+}
+
+static const struct eth_dev_ops dpaa_ol_devops = {
+		.dev_configure            = dpaa_ol_dev_configure,
+		.dev_start                = dpaa_ol_dev_start,
+		.dev_stop                 = dpaa_ol_dev_stop,
+		.dev_close                = dpaa_ol_dev_close,
+		.dev_infos_get            = dpaa_ol_dev_info,
+
+		.rx_queue_setup           = dpaa_ol_rx_queue_setup,
+		.tx_queue_setup           = dpaa_ol_tx_queue_setup,
+
+		.link_update              = dpaa_ol_link_update,
+		.promiscuous_enable       = dpaa_ol_promiscuous_enable,
+};
+
+static void dpaa_oldev_queues_release(struct dpaa_if *dpaa_intf)
+{
+	uint16_t i;
+	int ret;
+
+	if (dpaa_intf->tx_queues) {
+		for (i = 0; i < dpaa_intf->nb_tx_queues; i++) {
+			if (!dpaa_intf->tx_queues[i].fqid)
+				continue;
+			ret = qman_shutdown_fq(&dpaa_intf->tx_queues[i]);
+			if (ret) {
+				/* The FQ is still live in QMan, so the FQID
+				 * cannot be handed back: qman_alloc_fqid()
+				 * could give it to another user while the
+				 * hardware still references it. Leaking it
+				 * is the safe choice.
+				 */
+				DPAA_PMD_WARN("Failed(%d) to shutdown txq%d(0x%x), fqid not released",
+					      ret, i, dpaa_intf->tx_queues[i].fqid);
+				continue;
+			}
+			/* The FQ was created with QMAN_FQ_FLAG_DYNAMIC_FQID,
+			 * so qman_create_fq() allocated the FQID. Give it
+			 * back, otherwise every probe/close cycle leaks one.
+			 */
+			qman_release_fqid(dpaa_intf->tx_queues[i].fqid);
+		}
+		rte_free(dpaa_intf->tx_queues);
+		dpaa_intf->tx_queues = NULL;
+		dpaa_intf->nb_tx_queues = 0;
+	}
+
+	if (dpaa_intf->rx_queues) {
+		for (i = 0; i < dpaa_intf->nb_rx_queues; i++) {
+			if (!dpaa_intf->rx_queues[i].fqid)
+				continue;
+			ret = qman_shutdown_fq(&dpaa_intf->rx_queues[i]);
+			if (ret) {
+				/* Same as above: keep the FQID reserved. */
+				DPAA_PMD_WARN("Failed(%d) to shutdown rxq%d(0x%x), fqid not released",
+					      ret, i, dpaa_intf->rx_queues[i].fqid);
+				continue;
+			}
+			/* Same as above for the Rx FQs. */
+			qman_release_fqid(dpaa_intf->rx_queues[i].fqid);
+		}
+		rte_free(dpaa_intf->rx_queues);
+		dpaa_intf->rx_queues = NULL;
+		dpaa_intf->nb_rx_queues = 0;
+	}
+}
+
+static int dpaa_oldev_init(struct rte_eth_dev *eth_dev)
+{
+	int num_fqs, ret;
+	struct dpaa_if *dpaa_intf;
+
+	PMD_INIT_FUNC_TRACE();
+
+	num_fqs = DPAA_DEFAULT_NUM_PCD_QUEUES;
+	dpaa_intf = eth_dev->data->dev_private;
+
+	dpaa_intf->rx_queues = rte_zmalloc(NULL,
+					   sizeof(struct qman_fq) * num_fqs,
+					   MAX_CACHELINE);
+	if (!dpaa_intf->rx_queues) {
+		DPAA_PMD_ERR("Failed to alloc mem for RX queues");
+		return -ENOMEM;
+	}
+	/* Set the count as soon as the array exists so that the release
+	 * helper always walks the whole allocation on the error paths.
+	 */
+	dpaa_intf->nb_rx_queues = num_fqs;
+
+	ret = dpaa_ol_rx_queue_init(&dpaa_intf->rx_queues[0], 0);
+	if (ret)
+		goto free_rx;
+	dpaa_intf->rx_queues[0].dpaa_intf = dpaa_intf;
+
+	dpaa_intf->tx_queues = rte_zmalloc(NULL,
+					   sizeof(struct qman_fq) * num_fqs,
+					   MAX_CACHELINE);
+	if (!dpaa_intf->tx_queues) {
+		DPAA_PMD_ERR("Failed to alloc mem for TX queues");
+		ret = -ENOMEM;
+		goto free_rx;
+	}
+	dpaa_intf->nb_tx_queues = num_fqs;
+
+	ret = dpaa_ol_tx_queue_init(&dpaa_intf->tx_queues[0], 0);
+	if (ret)
+		goto free_rx;
+	dpaa_intf->tx_queues[0].dpaa_intf = dpaa_intf;
+
+	eth_dev->dev_ops = &dpaa_ol_devops;
+	eth_dev->rx_pkt_burst = dpaa_eth_queue_rx;
+	eth_dev->tx_pkt_burst = dpaa_eth_tx_drop_all;
+
+	/* Allocate memory for storing MAC addresses */
+	eth_dev->data->mac_addrs = rte_zmalloc("mac_addr",
+			RTE_ETHER_ADDR_LEN * DPAA_MAX_MAC_FILTER, 0);
+	if (eth_dev->data->mac_addrs == NULL) {
+		DPAA_PMD_ERR("Failed to allocate %d bytes needed to "
+			     "store MAC addresses",
+			     RTE_ETHER_ADDR_LEN * DPAA_MAX_MAC_FILTER);
+		ret = -ENOMEM;
+		goto free_rx;
+	}
+
+	return 0;
+
+free_rx:
+	dpaa_oldev_queues_release(dpaa_intf);
+	return ret;
+}
+
+static int dpaa_ol_probe(__rte_unused struct rte_dpaa_driver *dpaa_drv,
+			 struct rte_dpaa_device *dpaa_dev)
+{
+	int ret;
+	struct rte_eth_dev *eth_dev;
+
+	PMD_INIT_FUNC_TRACE();
+
+	/* The offline port's frame queues are created with dynamic FQIDs and
+	 * programmed into the kernel through the control device, all of which
+	 * is owned by the primary. A secondary has no way to attach to that
+	 * state, so do not advertise the port here rather than run
+	 * dpaa_oldev_init() against resources it does not own.
+	 */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY) {
+		DPAA_PMD_WARN("%s: not supported in secondary process",
+			      dpaa_dev->device.name);
+		return -ENOTSUP;
+	}
+
+	eth_dev = rte_eth_dev_allocate(dpaa_dev->name);
+	if (!eth_dev)
+		return -ENOMEM;
+	eth_dev->data->dev_private = rte_zmalloc("ethdev private structure",
+						 sizeof(struct dpaa_if),
+						 RTE_CACHE_LINE_SIZE);
+	if (!eth_dev->data->dev_private) {
+		DPAA_PMD_ERR("Cannot allocate memzone for port data");
+		rte_eth_dev_release_port(eth_dev);
+		return -ENOMEM;
+	}
+
+	eth_dev->device = &dpaa_dev->device;
+
+	ret = dpaa_oldev_init(eth_dev);
+	if (ret == 0) {
+		rte_eth_dev_probing_finish(eth_dev);
+		return 0;
+	}
+
+	/* dpaa_oldev_init() has already released its own allocations. */
+	rte_eth_dev_release_port(eth_dev);
+	return ret;
+}
+
+static int dpaa_ol_remove(struct rte_dpaa_device *dpaa_dev)
+{
+	struct rte_eth_dev *eth_dev;
+
+	PMD_INIT_FUNC_TRACE();
+
+	/* A secondary never probed this device, see dpaa_ol_probe(). */
+	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
+		return 0;
+
+	eth_dev = rte_eth_dev_allocated(dpaa_dev->device.name);
+	if (eth_dev == NULL)
+		return 0;
+
+	/* Shut down the FQs and free the driver private rx/tx_queues. This is
+	 * idempotent, so it is safe even if the application already called
+	 * rte_eth_dev_close() (which runs the same callback).
+	 */
+	dpaa_ol_dev_close(eth_dev);
+
+	return rte_eth_dev_release_port(eth_dev);
+}
+
+static struct rte_dpaa_driver rte_dpaa_ol_pmd = {
+		.drv_type = FSL_DPAA_OL,
+		.probe = dpaa_ol_probe,
+		.remove = dpaa_ol_remove,
+};
+
+RTE_PMD_REGISTER_DPAA(ol_dpaa, rte_dpaa_ol_pmd);
+RTE_PMD_REGISTER_PARAM_STRING(ol_dpaa,
+		DRIVER_OL_BH_PORT "=<string>");
diff --git a/drivers/net/dpaa/meson.build b/drivers/net/dpaa/meson.build
index 8d4f69c596..3ec1091197 100644
--- a/drivers/net/dpaa/meson.build
+++ b/drivers/net/dpaa/meson.build
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: BSD-3-Clause
-# Copyright 2018-2020 NXP
+# Copyright 2018-2020,2026 NXP
 
 if not is_linux
     build = false
@@ -9,12 +9,13 @@ deps += ['mempool_dpaa']
 
 sources = files(
         'dpaa_ethdev.c',
-        'fmlib/fm_lib.c',
-        'fmlib/fm_vsp.c',
         'dpaa_flow.c',
-        'dpaa_rxtx.c',
         'dpaa_fmc.c',
         'dpaa_ptp.c',
+        'dpaa_oldev.c',
+        'dpaa_rxtx.c',
+        'fmlib/fm_lib.c',
+        'fmlib/fm_vsp.c',
 )
 
 cflags += no_wvla_cflag
@@ -24,4 +25,4 @@ if cc.has_argument('-Wno-pointer-arith')
     cflags += '-Wno-pointer-arith'
 endif
 
-headers = files('rte_pmd_dpaa.h')
+headers = files('rte_pmd_dpaa.h', 'rte_pmd_dpaa_oldev.h')
diff --git a/drivers/net/dpaa/rte_pmd_dpaa_oldev.h b/drivers/net/dpaa/rte_pmd_dpaa_oldev.h
new file mode 100644
index 0000000000..df0fdbc885
--- /dev/null
+++ b/drivers/net/dpaa/rte_pmd_dpaa_oldev.h
@@ -0,0 +1,188 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2020-2026 NXP
+ */
+
+#ifndef _RTE_PMD_DPAA_OLDEV_H
+#define _RTE_PMD_DPAA_OLDEV_H
+
+/**
+ * @file rte_pmd_dpaa_oldev.h
+ *
+ * NXP DPAA offline (O/H) port PMD-specific API.
+ *
+ * @warning
+ * @b EXPERIMENTAL:
+ * All functions in this file may be changed or removed without prior notice.
+ *
+ * These APIs configure the classification, local gateway (LGW) and related
+ * uplink information for the DPAA offline port through the kernel control
+ * device.
+ */
+
+#include <stdint.h>
+#include <rte_common.h>
+#include <rte_compat.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/** IPv4 address type for the inner/static address pair used in uplink
+ * classification.
+ */
+#define RTE_PMD_DPAA_OLDEV_IPV4_ADDR_TYPE  0x04
+/** IPv6 address type for the inner/static address pair used in uplink
+ * classification.
+ */
+#define RTE_PMD_DPAA_OLDEV_IPV6_ADDR_TYPE  0x06
+
+/** Maximum number of GTP UDP ports an application can listen on. */
+#define RTE_PMD_DPAA_OLDEV_MAX_NUM_PORTS 2
+
+/** IPv4 subnet type for an LGW subnet entry. */
+#define RTE_PMD_DPAA_OLDEV_IPV4_SUBNET_TYPE  0x04
+/** IPv6 subnet type for an LGW subnet entry. */
+#define RTE_PMD_DPAA_OLDEV_IPV6_SUBNET_TYPE  0x06
+/** Maximum number of LGW subnets that can be programmed. */
+#define RTE_PMD_DPAA_OLDEV_MAX_NUM_SUBNETS 4
+
+/** Set in struct rte_pmd_dpaa_ip_pair::flags when the address pair carries
+ * a valid inner IP address.
+ */
+#define RTE_PMD_DPAA_OLDEV_CLASSIF_INNER_IP 0x1
+
+/** Set in struct rte_pmd_dpaa_ip_pair::flags when the address pair carries
+ * a static IP address.
+ */
+#define RTE_PMD_DPAA_OLDEV_CLASSIF_STATIC_IP 0x2
+
+/** Set in struct rte_pmd_dpaa_ip_pair::flags to indicate the telecom
+ * application is listening only on the static IP address.
+ */
+#define RTE_PMD_DPAA_OLDEV_TELECOM_LISTEN_ON_ONLY_STATICIP 0x4
+
+/** Set in struct rte_pmd_dpaa_ip_pair::flags to indicate the telecom
+ * application is listening on both the static and the inner IP address.
+ */
+#define RTE_PMD_DPAA_OLDEV_TELECOM_LISTEN_ON_BOTH_STATIC_INNER_IP 0x8
+
+/** Set in struct rte_pmd_dpaa_ip_pair::flags to indicate the telecom
+ * application is listening only on the inner IP address.
+ */
+#define RTE_PMD_DPAA_OLDEV_TELECOM_LISTEN_ON_ONLY_INNERIP 0x10
+
+/**
+ * Holds an IPv4 or IPv6 address.
+ *
+ * For an IPv4 address only ip_addr[0] is used; for an IPv6 address all
+ * four words are used. Which representation applies is determined by
+ * the addr_type field of the enclosing struct rte_pmd_dpaa_ip_pair.
+ */
+struct rte_pmd_dpaa_ip_addr {
+	uint32_t ip_addr[4]; /**< Address words, network byte order. */
+};
+
+/** Static/inner IP address pair used for uplink classification. */
+struct __rte_packed_begin rte_pmd_dpaa_ip_pair {
+	struct rte_pmd_dpaa_ip_addr static_ip; /**< Static IP address. */
+	struct rte_pmd_dpaa_ip_addr inner_ip;  /**< Inner IP address. */
+	uint8_t flags;		/**< Combination of
+				  *  RTE_PMD_DPAA_OLDEV_CLASSIF_* and
+				  *  RTE_PMD_DPAA_OLDEV_TELECOM_* flags.
+				  */
+	uint8_t addr_type;	/**< RTE_PMD_DPAA_OLDEV_IPV4_ADDR_TYPE or
+				  *  RTE_PMD_DPAA_OLDEV_IPV6_ADDR_TYPE.
+				  */
+	uint8_t pad[2];		/**< Reserved, must be zero. */
+} __rte_packed_end;
+
+/** A single local gateway (LGW) subnet entry. */
+struct __rte_packed_begin rte_pmd_dpaa_lgw_subnet {
+	uint32_t subnet[4];	/**< Subnet address, network byte order. */
+	uint8_t mask;		/**< Subnet mask length in bits. */
+	uint8_t subnet_type;	/**< RTE_PMD_DPAA_OLDEV_IPV4_SUBNET_TYPE or
+				  *   RTE_PMD_DPAA_OLDEV_IPV6_SUBNET_TYPE.
+				  */
+	uint8_t pad[2];		/**< Reserved, must be zero. */
+} __rte_packed_end;
+
+/** Uplink classification information for the DPAA offline port. */
+struct rte_pmd_dpaa_uplink_cls_info_s {
+	struct rte_pmd_dpaa_ip_pair addr_pair;	/**< Static/inner IP pair. */
+	/** GTP UDP ports the application listens on. */
+	uint16_t gtp_udp_port[RTE_PMD_DPAA_OLDEV_MAX_NUM_PORTS];
+	uint8_t gtp_proto_id;	/**< UDP protocol ID the application listens
+				  *   on.
+				  */
+	uint8_t num_ports;	/**< Number of valid entries in
+				  *   gtp_udp_port.
+				  */
+	uint8_t sec_enabled;	/**< Non-zero if IPsec is enabled. */
+	uint8_t pad;		/**< Reserved, must be zero. */
+};
+
+/** Local gateway (LGW) information for the DPAA offline port. */
+struct __rte_packed_begin rte_pmd_dpaa_lgw_info_s {
+	/** LGW subnet table. */
+	struct rte_pmd_dpaa_lgw_subnet subnets[RTE_PMD_DPAA_OLDEV_MAX_NUM_SUBNETS];
+	uint8_t num_subnets;	/**< Number of valid entries in subnets. */
+	uint8_t pad[3];		/**< Reserved, must be zero. */
+} __rte_packed_end;
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Program the uplink classification information for the DPAA offline port.
+ *
+ * @param cls_info
+ *   Pointer to the classification information to program. Must not be NULL.
+ * @return
+ *   0 on success, negative value otherwise.
+ */
+__rte_experimental
+int rte_pmd_dpaa_ol_set_classif_info(struct rte_pmd_dpaa_uplink_cls_info_s *cls_info);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Reset the uplink classification information for the DPAA offline port.
+ *
+ * @return
+ *   0 on success, negative value otherwise.
+ */
+__rte_experimental
+int rte_pmd_dpaa_ol_reset_classif_info(void);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Program the local gateway (LGW) information for the DPAA offline port.
+ *
+ * @param lgw_info
+ *   Pointer to the LGW information to program. Must not be NULL.
+ * @return
+ *   0 on success, negative value otherwise.
+ */
+__rte_experimental
+int rte_pmd_dpaa_ol_set_lgw_info(struct rte_pmd_dpaa_lgw_info_s *lgw_info);
+
+/**
+ * @warning
+ * @b EXPERIMENTAL: this API may change without prior notice.
+ *
+ * Reset the local gateway (LGW) information for the DPAA offline port.
+ *
+ * @return
+ *   0 on success, negative value otherwise.
+ */
+__rte_experimental
+int rte_pmd_dpaa_ol_reset_lgw_info(void);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* _RTE_PMD_DPAA_OLDEV_H */
-- 
2.25.1

