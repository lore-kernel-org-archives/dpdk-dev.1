Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64794606A324
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 09:36:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 55EF540ED3;
	Tue,  3 Nov 2026 10:36:08 +0100 (CET)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTPS id 7028440278;
 Tue,  3 Nov 2026 10:36:06 +0100 (CET)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 2B0701A0023;
 Tue,  3 Nov 2026 10:36:06 +0100 (CET)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E77FF1A001E;
 Tue,  3 Nov 2026 10:36:05 +0100 (CET)
Received: from lsv03457.swis.in-blr01.nxp.com (lsv03457.swis.in-blr01.nxp.com
 [92.120.147.250])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 165C41800226;
 Tue,  3 Nov 2026 17:36:05 +0800 (+08)
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com, stable@dpdk.org, Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v3 1/4] bus/dpaa: fix out-of-bounds read of mac_idx array
Date: Tue,  3 Nov 2026 15:05:58 +0530
Message-Id: <20261103093601.3736486-2-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261103093601.3736486-1-g.singh@nxp.com>
References: <20261030044318.1892998-1-g.singh@nxp.com>
 <20261103093601.3736486-1-g.singh@nxp.com>
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

fman_if_init() and fman_if_init_onic() read the devicetree
'cell-index' property and store it unchecked into
__if->__if.mac_idx. This value is later used as an index into the
fixed-size mac_idx[] lookup table in fman_if_vsp_init(), so a
cell-index value greater than or equal to the number of entries in
that table results in an out-of-bounds read.

Add an explicit upper-bound check (FMAN_MAX_MAC_IDX_NUM) in both
fman_if_init() and fman_if_init_onic() before the mac_idx assignment,
and a static_assert in fman_if_vsp_init() to keep mac_idx[] in sync
with FMAN_MAX_MAC_IDX_NUM if it is ever resized.

Also remove the unused MEMMAC_REG_OFFSET() macro from fman.h, which
had no remaining callers.

Fixes: a0edbb8a8e52 ("bus/dpaa: add OH port mode")
Fixes: 7e5f49ae767d ("bus/dpaa: add ONIC port mode")
Cc: stable@dpdk.org

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/bus/dpaa/base/fman/fman.c | 19 +++++++++++++++++++
 drivers/bus/dpaa/include/fman.h   |  6 +++++-
 drivers/net/dpaa/dpaa_flow.c      |  5 ++++-
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/dpaa/base/fman/fman.c b/drivers/bus/dpaa/base/fman/fman.c
index 67f77265ca..223cd6958d 100644
--- a/drivers/bus/dpaa/base/fman/fman.c
+++ b/drivers/bus/dpaa/base/fman/fman.c
@@ -205,6 +205,9 @@ static void fman_if_vsp_init(struct __fman_if *__if)
 	size_t lenp;
 	const uint8_t mac_idx[] = {-1, 0, 1, 2, 3, 4, 5, 6, 7, 0, 1};
 
+	static_assert(RTE_DIM(mac_idx) == FMAN_MAX_MAC_IDX_NUM,
+		      "mac_idx[] out of sync with FMAN_MAX_MAC_IDX_NUM");
+
 	if (__if->__if.mac_idx <= 8) {
 		for_each_compatible_node(dev, NULL,
 			"fsl,fman-port-1g-rx-extended-args") {
@@ -544,6 +547,14 @@ fman_if_init(const struct device_node *dpa_node, int fd)
 		cell_idx_host = of_read_number(cell_idx,
 					       lenp / sizeof(phandle));
 
+		if (cell_idx_host >= FMAN_MAX_MAC_IDX_NUM) {
+			FMAN_ERR(-EINVAL,
+				 "%s: cell-index(%" PRIu64 ") >= max(%d)",
+				 oh_node->full_name, cell_idx_host,
+				 FMAN_MAX_MAC_IDX_NUM);
+			goto err;
+		}
+
 		__if->__if.mac_idx = cell_idx_host;
 	}
 
@@ -957,6 +968,14 @@ static int fman_if_init_onic(const struct device_node *dpa_node)
 	assert(lenp == sizeof(*cell_idx));
 
 	cell_idx_host = of_read_number(cell_idx, lenp / sizeof(phandle));
+
+	if (cell_idx_host >= FMAN_MAX_MAC_IDX_NUM) {
+		FMAN_ERR(-EINVAL, "%s: cell-index(%" PRIu64 ") >= max(%d)",
+			 tx_oh_node->full_name, cell_idx_host,
+			 FMAN_MAX_MAC_IDX_NUM);
+		goto err;
+	}
+
 	__if->__if.mac_idx = cell_idx_host;
 
 	fman_node = of_get_parent(fman_tx_oh_node);
diff --git a/drivers/bus/dpaa/include/fman.h b/drivers/bus/dpaa/include/fman.h
index f642faf3b3..030c85c284 100644
--- a/drivers/bus/dpaa/include/fman.h
+++ b/drivers/bus/dpaa/include/fman.h
@@ -68,6 +68,11 @@
 #define FMAN_RTC_MAX_NUM_OF_PERIODIC_PULSES	4
 #define FMAN_RTC_MAX_NUM_OF_EXT_TRIGGERS	3
 
+/*
+ * Maximum number of MAC/offline port indexes.
+ */
+#define FMAN_MAX_MAC_IDX_NUM	11
+
 /* Represents the different flavour of network interface */
 enum fman_mac_type {
 	fman_offline_internal = 0,
@@ -475,7 +480,6 @@ struct __fman_if {
 	void *qmi_map;
 };
 
-#define MEMMAC_REG_OFFSET(reg) offsetof(struct memac_regs, reg)
 #define BMI_RX_REG_OFFSET(reg) offsetof(struct rx_bmi_regs, reg)
 #define BMI_TX_REG_OFFSET(reg) offsetof(struct tx_bmi_regs, reg)
 
diff --git a/drivers/net/dpaa/dpaa_flow.c b/drivers/net/dpaa/dpaa_flow.c
index f77f9f333b..403e97ed2d 100644
--- a/drivers/net/dpaa/dpaa_flow.c
+++ b/drivers/net/dpaa/dpaa_flow.c
@@ -32,9 +32,12 @@ return &scheme_params->param.key_ext_and_hash.extract_array[hdr_idx];
 	SCH_EXT_HDR(scheme_params, hdr_idx).extract_by_hdr_type.full_field
 
 /* FMAN mac indexes mappings (0 is unused, first 8 are for 1G, next for 10G
- * ports).
+ * ports). Indexed by fman_if.mac_idx, which the bus validates against
+ * FMAN_MAX_MAC_IDX_NUM when deriving it from the device tree.
  */
 static const uint8_t mac_idx[] = {-1, 0, 1, 2, 3, 4, 5, 6, 7, 0, 1};
+static_assert(RTE_DIM(mac_idx) == FMAN_MAX_MAC_IDX_NUM,
+	"mac_idx[] out of sync with FMAN_MAX_MAC_IDX_NUM");
 
 /* FM global info */
 struct dpaa_fm_info {
-- 
2.25.1

