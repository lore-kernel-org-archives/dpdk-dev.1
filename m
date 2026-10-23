Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2043606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:49:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AD37E40E37;
	Fri, 23 Oct 2026 15:45:02 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 1C8CF40DC9
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:52 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EA7A3200031;
 Fri, 23 Oct 2026 15:44:51 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id B680B20002B;
 Fri, 23 Oct 2026 15:44:51 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 6473F1800068;
 Fri, 23 Oct 2026 21:44:50 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 55/65] bus/fslmc: store dequeue dpio in mbuf seq dynfield
Date: Fri, 23 Oct 2026 19:13:35 +0530
Message-ID: <20261023134346.37727-56-prashant.gupta_3@nxp.com>
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

The atomic scheduling context (DQRR index) is saved in the mbuf
seq dynfield at dequeue time and consumed at enqueue time. However,
the enqueue and dequeue may happen on different DPIO
portals, so the context must remember which DPIO produced it.

Change the seqn dynfield from a bare uint32_t to a small struct that
carries both the sequence value and the originating dequeue DPIO
pointer. This is the base type change; additional changes are in the
following patches.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/fslmc/bus_fslmc_driver.h | 28 +++++++++++++++++++++-------
 drivers/bus/fslmc/fslmc_bus.c        |  4 ++--
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/drivers/bus/fslmc/bus_fslmc_driver.h b/drivers/bus/fslmc/bus_fslmc_driver.h
index 40c9ba0699..ddde52d89c 100644
--- a/drivers/bus/fslmc/bus_fslmc_driver.h
+++ b/drivers/bus/fslmc/bus_fslmc_driver.h
@@ -43,21 +43,35 @@ struct vfio_device_info;
 
 #define DPAA2_INVALID_MBUF_SEQN        0
 
-typedef uint32_t dpaa2_seqn_t;
+struct dpaa2_seq_t {
+	uint32_t seqn;
+	void *seq_dpio_dq;
+};
+
 extern int dpaa2_seqn_dynfield_offset;
 
 /**
- * Read dpaa2 sequence number from mbuf.
+ * Read dpaa2 sequence struct from mbuf.
  *
  * @param mbuf Structure to read from.
- * @return pointer to dpaa2 sequence number.
+ * @return pointer to dpaa2 sequence struct.
  */
-__rte_internal
-static inline dpaa2_seqn_t *
+static __rte_always_inline struct dpaa2_seq_t *
+dpaa2_seq(struct rte_mbuf *mbuf)
+{
+	return RTE_MBUF_DYNFIELD(mbuf, dpaa2_seqn_dynfield_offset, struct dpaa2_seq_t *);
+}
+
+static __rte_always_inline uint32_t *
 dpaa2_seqn(struct rte_mbuf *mbuf)
 {
-	return RTE_MBUF_DYNFIELD(mbuf, dpaa2_seqn_dynfield_offset,
-		dpaa2_seqn_t *);
+	return &(dpaa2_seq(mbuf)->seqn);
+}
+
+static __rte_always_inline void **
+dpaa2_seq_dpio_dq(struct rte_mbuf *mbuf)
+{
+	return &(dpaa2_seq(mbuf)->seq_dpio_dq);
 }
 
 /** Device driver supports link state interrupt */
diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index d20103ee36..82b11176e1 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -651,8 +651,8 @@ rte_fslmc_probe(struct rte_bus *bus)
 {
 	static const struct rte_mbuf_dynfield dpaa2_seqn_dynfield_desc = {
 		.name = DPAA2_SEQN_DYNFIELD_NAME,
-		.size = sizeof(dpaa2_seqn_t),
-		.align = alignof(dpaa2_seqn_t),
+		.size = sizeof(struct dpaa2_seq_t),
+		.align = alignof(struct dpaa2_seq_t),
 	};
 	int ret;
 
-- 
2.43.0

