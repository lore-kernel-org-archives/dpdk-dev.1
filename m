Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66979C79FB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 13:52:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86818427C8;
	Thu, 10 Sep 2026 15:52:07 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 9639040274;
 Thu, 10 Sep 2026 15:52:04 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 6ED521A0447;
 Thu, 10 Sep 2026 15:52:04 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 429E81A0072;
 Thu, 10 Sep 2026 15:52:04 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 15B1A18000B5;
 Thu, 10 Sep 2026 21:52:02 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: stable@dpdk.org,
	Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v2 01/47] crypto/dpaa2_sec: fix buffer overflow in GCM decrypt
Date: Thu, 10 Sep 2026 19:21:12 +0530
Message-ID: <20260910135158.2181141-2-prashant.gupta_3@nxp.com>
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

In build_authenc_gcm_fd, when both AAD (auth_only_len > 0) and decrypt
direction are active, the SGE layout occupies 8 entries plus 16 bytes of
old_icv storage at index 8. The FLE pool buffer was only 256 bytes
(8 x 32), causing old_icv to be written one entry past the end of the
allocated buffer. The resulting virtual address was not mapped by the
IOMMU, so DPAA2_VADDR_TO_IOVA returned 0 and the SEC engine received
iova=0x00000000 as the ICV buffer address, triggering an SMMU
translation fault (FSR=0x402 TF).

Additionally, the upfront bpid/IVP initialization only covered sge+3,
leaving sge+4 (the input data SGE when AAD is present) without a valid
bpid or IVP assignment.

Increase FLE_POOL_BUF_SIZE from 256 to 288 (9 x 32 bytes) to
accommodate the full layout, and extend the bpid/IVP initialization
to cover sge+4 in both branches of build_authenc_gcm_fd.

Fixes: 13273250eec5 ("crypto/dpaa2_sec: support AES-GCM and CTR")
Cc: stable@dpdk.org
Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c | 38 ++++++++++++++++++++-
 drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h   |  2 +-
 drivers/dma/dpaa2/dpaa2_qdma.c              | 12 +++++--
 drivers/net/dpaa2/dpaa2_flow.c              |  1 +
 4 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
index 3d980d096f..96c2e56ff5 100644
--- a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
+++ b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
@@ -8,6 +8,9 @@
 #include <time.h>
 #include <net/if.h>
 #include <unistd.h>
+#include <errno.h>
+#include <limits.h>
+#include <stdlib.h>
 
 #include <eal_export.h>
 #include <rte_ip.h>
@@ -569,6 +572,7 @@ build_authenc_gcm_fd(dpaa2_sec_session *sess,
 		DPAA2_SET_FLE_BPID(sge + 1, bpid);
 		DPAA2_SET_FLE_BPID(sge + 2, bpid);
 		DPAA2_SET_FLE_BPID(sge + 3, bpid);
+		DPAA2_SET_FLE_BPID(sge + 4, bpid);
 	} else {
 		DPAA2_SET_FD_IVP(fd);
 		DPAA2_SET_FLE_IVP(fle);
@@ -577,6 +581,7 @@ build_authenc_gcm_fd(dpaa2_sec_session *sess,
 		DPAA2_SET_FLE_IVP((sge + 1));
 		DPAA2_SET_FLE_IVP((sge + 2));
 		DPAA2_SET_FLE_IVP((sge + 3));
+		DPAA2_SET_FLE_IVP((sge + 4));
 	}
 
 	/* Save the shared descriptor */
@@ -4332,17 +4337,48 @@ dpaa2_sec_uninit(const struct rte_cryptodev *dev)
 	return 0;
 }
 
+/* Parse a base-10 integer. Returns 0 on success and stores the result in
+ * *val, or a negative errno if the string is empty, malformed, or out of
+ * range. Unlike atoi() this detects errors instead of silently yielding 0.
+ */
+static int
+dpaa2_sec_parse_int(const char *str, long *val)
+{
+	char *endptr;
+	long tmp;
+
+	if (str == NULL || *str == '\0')
+		return -EINVAL;
+
+	errno = 0;
+	tmp = strtol(str, &endptr, 10);
+	if (errno != 0)
+		return -errno;
+	if (endptr == str || *endptr != '\0')
+		return -EINVAL;
+
+	*val = tmp;
+
+	return 0;
+}
+
 static int
 check_devargs_handler(const char *key, const char *value,
 		      void *opaque)
 {
 	struct rte_cryptodev *dev = (struct rte_cryptodev *)opaque;
 	struct dpaa2_sec_dev_private *priv = dev->data->dev_private;
+	long val;
 
 	if (!strcmp(key, "drv_strict_order")) {
 		priv->en_loose_ordered = false;
 	} else if (!strcmp(key, "drv_dump_mode")) {
-		dpaa2_sec_dp_dump = atoi(value);
+		if (dpaa2_sec_parse_int(value, &val)) {
+			DPAA2_SEC_WARN("Invalid %s value '%s', ignored",
+				key, value);
+			return -1;
+		}
+		dpaa2_sec_dp_dump = val;
 		if (dpaa2_sec_dp_dump > DPAA2_SEC_DP_FULL_DUMP) {
 			DPAA2_SEC_WARN("WARN: DPAA2_SEC_DP_DUMP_LEVEL is not "
 				      "supported, changing to FULL error"
diff --git a/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h b/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h
index 755c8e9cc3..ff32f3d860 100644
--- a/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h
+++ b/drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h
@@ -17,7 +17,7 @@ extern uint8_t cryptodev_driver_id;
 
 /* FLE_POOL_NUM_BUFS is set as per the ipsec-secgw application */
 #define FLE_POOL_NUM_BUFS	32000
-#define FLE_POOL_BUF_SIZE	256
+#define FLE_POOL_BUF_SIZE	288
 #define FLE_POOL_CACHE_SIZE	512
 #define FLE_SG_MEM_SIZE(num)	(FLE_POOL_BUF_SIZE + ((num) * 32))
 
diff --git a/drivers/dma/dpaa2/dpaa2_qdma.c b/drivers/dma/dpaa2/dpaa2_qdma.c
index f7d94bb799..004dacf677 100644
--- a/drivers/dma/dpaa2/dpaa2_qdma.c
+++ b/drivers/dma/dpaa2/dpaa2_qdma.c
@@ -180,7 +180,7 @@ dpaa2_qdma_multi_eq(struct qdma_virt_queue *qdma_vq)
 	return num_tx;
 }
 
-static void
+static int
 fle_sdd_pre_populate(struct qdma_cntx_fle_sdd *fle_sdd,
 	struct dpaa2_qdma_rbp *rbp, uint64_t src, uint64_t dest,
 	uint32_t fmt)
@@ -256,6 +256,8 @@ fle_sdd_pre_populate(struct qdma_cntx_fle_sdd *fle_sdd,
 
 	/* Final bit: 1, for last frame list */
 	DPAA2_SET_FLE_FIN(&fle[DPAA2_QDMA_DST_FLE]);
+
+	return 0;
 }
 
 static void
@@ -871,9 +873,15 @@ dpaa2_qdma_long_copy(struct qdma_virt_queue *qdma_vq,
 
 	if (qdma_vq->fle_pre_populate) {
 		if (unlikely(!fle[DPAA2_QDMA_SRC_FLE].length)) {
-			fle_sdd_pre_populate(fle_sdd,
+			ret = fle_sdd_pre_populate(fle_sdd,
 				&qdma_vq->rbp,
 				0, 0, QBMAN_FLE_WORD4_FMT_SBF);
+			if (unlikely(ret)) {
+				if (!is_silent)
+					rte_mempool_put(qdma_vq->fle_pool,
+						fle_sdd);
+				return ret;
+			}
 		}
 
 		fle_post_populate(fle, src, dst, length);
diff --git a/drivers/net/dpaa2/dpaa2_flow.c b/drivers/net/dpaa2/dpaa2_flow.c
index 2e44bff766..63c253ab3b 100644
--- a/drivers/net/dpaa2/dpaa2_flow.c
+++ b/drivers/net/dpaa2/dpaa2_flow.c
@@ -3,6 +3,7 @@
  */
 
 #include <sys/queue.h>
+#include <rte_string_fns.h>
 #include <stdio.h>
 #include <errno.h>
 #include <stdint.h>
-- 
2.43.0

