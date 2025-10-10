Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B347CCA476
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Oct 2025 14:46:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B1634021E;
	Fri, 10 Oct 2025 16:46:40 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 5DB2E4003C
 for <dev@dpdk.org>; Fri, 10 Oct 2025 16:46:38 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59AAsVSk000866;
 Fri, 10 Oct 2025 07:46:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=C
 VsMjCZxwGfdrBanfr+kquMu1OglTcTvtKV0JYcjQ4I=; b=DyWz1+/aykcg2ywSB
 J2So02RedN/UBLUjLNRfM976TJ8/BdzXAc7rTa/nV2SuCMujJT63lODy1ER6Aged
 lovopKaNfcfmPV30JbuBlEoOFD2VkHwMi8ey3eBFklZfwbFYHNSwio6ptQ0+QU24
 lULergP96lp5UnJHqZUNX13hkIGHmv+HqKjY3SvVu213mMXUugGZ26q3JGDU5zwr
 JIDAZd8LpLNxjHkFG6xE2LlCDMPhAkvvKmIGge3+dN3xClJJ5Swab9S7jVf7mEq8
 x8nJv+tExPwl4aJyEvS8UNjuT7f20M3BoPL3dgCtVK9UgVvlbMdL7VdmXEBEm7E6
 wQMZQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49ppt21b5q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Oct 2025 07:46:37 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 10 Oct 2025 07:46:45 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 10 Oct 2025 07:46:45 -0700
Received: from cavium-VAMSI-BM.. (unknown [10.28.36.156])
 by maili.marvell.com (Postfix) with ESMTP id 96DA75E6865;
 Fri, 10 Oct 2025 07:46:33 -0700 (PDT)
From: Vamsi Krishna <vattunuru@marvell.com>
To: <dev@dpdk.org>, <fengchengwen@huawei.com>
CC: <thomas@monjalon.net>, <bruce.richardson@intel.com>,
 <anatoly.burakov@intel.com>, <kevin.laatz@intel.com>,
 <jerinj@marvell.com>, <vattunuru@marvell.com>
Subject: [PATCH v2 1/1] lib/dma: introduce inter-process and inter-OS DMA
Date: Fri, 10 Oct 2025 20:16:31 +0530
Message-ID: <20251010144631.713063-1-vattunuru@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250901123341.2665186-1-vattunuru@marvell.com>
References: <20250901123341.2665186-1-vattunuru@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA5MDE0MyBTYWx0ZWRfX3DBN5pQKEsCc
 uZenB3IZmCG4fIGLdSbO481X8BNlT1bqTp3Egwek+V6QxT8HTCChSOZwc4P0AymnwcJpnGOviK8
 b0vlRrfh7GIIjJ6xNYSDtgRv4S7V1rIORq4wICQowxLfdFrMiDFtNXh8alogZueybieLzDJFr7V
 kJ2V+wcPs0JnPIzU5LsmgHl3jqxMjYiwfOwk4cUjpmK7YXYskTEmLatSs0PR3Or2zwxM24aZGvM
 ZxqHGSclZ6GyBjWdKtAl8AjSbcK/QZfB0054sHj9owkQieqiScwgHeJ+bZ8mph01Lx/WSb+D8n1
 7R1mY4TdFT1PsT/i9ZynIBNJc4EiiS4ISRPwlPoiiwQRQJChRcJA7mkZ27b4wOdIT5oMYFXjFgC
 xe1bzaW/nSUP2jfcjpSjC2un2T3hRg==
X-Proofpoint-ORIG-GUID: oLOf2jI7nDAQALhVr1qufssqU5zX6uj-
X-Authority-Analysis: v=2.4 cv=d4/4CBjE c=1 sm=1 tr=0 ts=68e91c4d cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=x6icFKpwvdMA:10 a=M5GUcnROAAAA:8 a=84wi6ZIy9pvBVeDFkUwA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: oLOf2jI7nDAQALhVr1qufssqU5zX6uj-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-10_03,2025-10-06_01,2025-03-28_01
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

From: Vamsi Attunuru <vattunuru@marvell.com>

Modern DMA hardware supports data transfers between multiple DMA
devices, facilitating data communication across isolated domains,
containers, or operating systems. These DMA transfers function as
standard memory-to-memory operations, but with source or destination
addresses residing in different process or OS address space. The
exchange of these addresses between processes is handled through
private driver mechanism, which are beyond the scope of this
specification change.

This commit introduces new capability flags to advertise driver support
for inter-process and inter-OS domain DMA transfers. It adds a mechanism
to specify source and destination handlers via the vchan configuration.
Until standardized control-plane APIs are defined for various categories
of DMA devices, these handler details can be exchanged through private
driver mechanisms.

Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
---
V2 changes:
* Seperate out the control-plane APIs
* Address v0 review comments
* Add validation checks
* Rename the enums

 lib/dmadev/rte_dmadev.c       | 19 ++++++++++++
 lib/dmadev/rte_dmadev.h       | 56 +++++++++++++++++++++++++++++++++++
 lib/dmadev/rte_dmadev_trace.h |  3 ++
 3 files changed, 78 insertions(+)

diff --git a/lib/dmadev/rte_dmadev.c b/lib/dmadev/rte_dmadev.c
index 17ee0808a9..23864dcb00 100644
--- a/lib/dmadev/rte_dmadev.c
+++ b/lib/dmadev/rte_dmadev.c
@@ -659,6 +659,21 @@ rte_dma_vchan_setup(int16_t dev_id, uint16_t vchan,
 		RTE_DMA_LOG(ERR, "Device %d vchan out range!", dev_id);
 		return -EINVAL;
 	}
+	if (conf->direction != RTE_DMA_DIR_MEM_TO_MEM &&
+	    conf->domain.domain_type != RTE_DMA_INTER_DOMAIN_NONE) {
+		RTE_DMA_LOG(ERR, "Device %d direction and inter domain are invalid!", dev_id);
+		return -EINVAL;
+	}
+	if (conf->domain.domain_type == RTE_DMA_INTER_OS_DOMAIN &&
+	    !(dev_info.dev_capa & RTE_DMA_CAPA_INTER_OS_DOMAIN)) {
+		RTE_DMA_LOG(ERR, "Device %d does not support inter os domain", dev_id);
+		return -EINVAL;
+	}
+	if (conf->domain.domain_type == RTE_DMA_INTER_PROCESS_DOMAIN &&
+	    !(dev_info.dev_capa & RTE_DMA_CAPA_INTER_PROCESS_DOMAIN)) {
+		RTE_DMA_LOG(ERR, "Device %d does not support inter process domain", dev_id);
+		return -EINVAL;
+	}
 	if (conf->direction != RTE_DMA_DIR_MEM_TO_MEM &&
 	    conf->direction != RTE_DMA_DIR_MEM_TO_DEV &&
 	    conf->direction != RTE_DMA_DIR_DEV_TO_MEM &&
@@ -805,6 +820,8 @@ dma_capability_name(uint64_t capability)
 		{ RTE_DMA_CAPA_HANDLES_ERRORS, "handles_errors" },
 		{ RTE_DMA_CAPA_M2D_AUTO_FREE,  "m2d_auto_free"  },
 		{ RTE_DMA_CAPA_PRI_POLICY_SP,  "pri_policy_sp" },
+		{ RTE_DMA_CAPA_INTER_PROCESS_DOMAIN, "inter_process_domain" },
+		{ RTE_DMA_CAPA_INTER_OS_DOMAIN, "inter_os_domain" },
 		{ RTE_DMA_CAPA_OPS_COPY,    "copy"    },
 		{ RTE_DMA_CAPA_OPS_COPY_SG, "copy_sg" },
 		{ RTE_DMA_CAPA_OPS_FILL,    "fill"    },
@@ -1014,6 +1031,8 @@ dmadev_handle_dev_info(const char *cmd __rte_unused,
 	ADD_CAPA(dma_caps, dev_capa, RTE_DMA_CAPA_HANDLES_ERRORS);
 	ADD_CAPA(dma_caps, dev_capa, RTE_DMA_CAPA_M2D_AUTO_FREE);
 	ADD_CAPA(dma_caps, dev_capa, RTE_DMA_CAPA_PRI_POLICY_SP);
+	ADD_CAPA(dma_caps, dev_capa, RTE_DMA_CAPA_INTER_PROCESS_DOMAIN);
+	ADD_CAPA(dma_caps, dev_capa, RTE_DMA_CAPA_INTER_OS_DOMAIN);
 	ADD_CAPA(dma_caps, dev_capa, RTE_DMA_CAPA_OPS_COPY);
 	ADD_CAPA(dma_caps, dev_capa, RTE_DMA_CAPA_OPS_COPY_SG);
 	ADD_CAPA(dma_caps, dev_capa, RTE_DMA_CAPA_OPS_FILL);
diff --git a/lib/dmadev/rte_dmadev.h b/lib/dmadev/rte_dmadev.h
index 550dbfbf75..12c249ec00 100644
--- a/lib/dmadev/rte_dmadev.h
+++ b/lib/dmadev/rte_dmadev.h
@@ -265,6 +265,18 @@ int16_t rte_dma_next_dev(int16_t start_dev_id);
  * known from 'nb_priorities' field in struct rte_dma_info.
  */
 #define RTE_DMA_CAPA_PRI_POLICY_SP	RTE_BIT64(8)
+/** Support inter-process DMA transfers.
+ *
+ * When this bit is set, the DMA device can perform memory transfers between
+ * different process memory spaces.
+ */
+#define RTE_DMA_CAPA_INTER_PROCESS_DOMAIN	RTE_BIT64(9)
+/** Support inter-OS domain DMA transfers.
+ *
+ * The DMA device can perform memory transfers across different operating
+ * system domains.
+ */
+#define RTE_DMA_CAPA_INTER_OS_DOMAIN		RTE_BIT64(10)
 
 /** Support copy operation.
  * This capability start with index of 32, so that it could leave gap between
@@ -418,8 +430,13 @@ int rte_dma_close(int16_t dev_id);
  */
 enum rte_dma_direction {
 	/** DMA transfer direction - from memory to memory.
+	 * When the device supports inter-process or inter-OS domain transfers,
+	 * the field `domain_type` in `struct rte_dma_vchan_conf::domain` specifies
+	 * the type of domain. For memory-to-memory transfers within the same domain
+	 * or process, `domain_type` should be set to `RTE_DMA_INTER_DOMAIN_NONE`.
 	 *
 	 * @see struct rte_dma_vchan_conf::direction
+	 * @see struct rte_dma_inter_domain_param::domain_type
 	 */
 	RTE_DMA_DIR_MEM_TO_MEM,
 	/** DMA transfer direction - from memory to device.
@@ -564,6 +581,36 @@ struct rte_dma_auto_free_param {
 	uint64_t reserved[2];
 };
 
+/**
+ * Inter-DMA transfer domain type.
+ *
+ * This enum defines the types of transfer domains applicable to DMA operations.
+ * It helps categorize whether a DMA transfer is occurring within the same domain,
+ * across different processes, or between distinct operating system domains.
+ *
+ * @see struct rte_dma_inter_domain_param:domain_type
+ */
+enum rte_dma_inter_domain_type {
+	RTE_DMA_INTER_DOMAIN_NONE, /**< No inter-domain transfer; standard DMA within same domain */
+	RTE_DMA_INTER_PROCESS_DOMAIN, /**< Transfer occurs between different user-space processes */
+	RTE_DMA_INTER_OS_DOMAIN, /**< Transfer spans across different operating system domains. */
+};
+
+/**
+ * Parameters for inter-process or inter-OS DMA transfers.
+ *
+ * This structure defines the parameters required to perform DMA transfers
+ * across different domains, such as between processes or operating systems.
+ * It includes the domain type and handler identifiers for both the source
+ * and destination domains.
+ */
+struct rte_dma_inter_domain_param {
+	enum rte_dma_inter_domain_type domain_type; /**< Type of inter-domain. */
+	uint16_t src_handler; /**< Source domain handler identifier. */
+	uint16_t dst_handler; /**< Destination domain handler identifier. */
+	uint64_t reserved[2]; /**< Reserved for future fields. */
+};
+
 /**
  * A structure used to configure a virtual DMA channel.
  *
@@ -601,6 +648,15 @@ struct rte_dma_vchan_conf {
 	 * @see struct rte_dma_auto_free_param
 	 */
 	struct rte_dma_auto_free_param auto_free;
+	/** Parameters for inter-process or inter-OS domain DMA transfers. This field
+	 * specifies the source and destination domain handlers required  for DMA
+	 * operations that span across different processes or operating system domains.
+	 *
+	 * @see RTE_DMA_CAPA_INTER_PROCESS_DOMAIN
+	 * @see RTE_DMA_CAPA_INTER_OS_DOMAIN
+	 * @see struct rte_dma_inter_domain_param
+	 */
+	struct rte_dma_inter_domain_param domain;
 };
 
 /**
diff --git a/lib/dmadev/rte_dmadev_trace.h b/lib/dmadev/rte_dmadev_trace.h
index 1de92655f2..12ea9d53f6 100644
--- a/lib/dmadev/rte_dmadev_trace.h
+++ b/lib/dmadev/rte_dmadev_trace.h
@@ -79,6 +79,9 @@ RTE_TRACE_POINT(
 	rte_trace_point_emit_int(conf->dst_port.port_type);
 	rte_trace_point_emit_u64(conf->dst_port.pcie.val);
 	rte_trace_point_emit_ptr(conf->auto_free.m2d.pool);
+	rte_trace_point_emit_int(conf->domain.domain_type);
+	rte_trace_point_emit_u16(conf->domain.src_handler);
+	rte_trace_point_emit_u16(conf->domain.dst_handler);
 	rte_trace_point_emit_int(ret);
 )
 
-- 
2.34.1

