Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B003BCCD199
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 05:42:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DA66340DD7;
	Fri, 17 Oct 2025 07:42:18 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id E31EC40A89
 for <dev@dpdk.org>; Fri, 17 Oct 2025 07:42:17 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59GNSQ1o024884;
 Thu, 16 Oct 2025 22:42:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=p
 vygJ/10AYQ1hGKggmX5+ljJSp9CxHP8DsvXlATRRos=; b=fI71umqOyhKhX/LCB
 PSrRz/JWW5B8hz0Sx1C+hQsQSi8OBSUE5lTS23vSEEMXF3e5GwW2pc/zOxrdVqWj
 qBydEEsQwhAFXjDJ8AIPjKzr8DQt6etO1Q3DEwvN2X2bwBbeYX9Dg3XY0N5Qy1Cc
 F/JL3GJ6FB9IMUTNxVtDEUyX2n87WSRcrFAbIGx+1213CG5eVKE1FSCtHByAtTda
 B/BKZpUqPrpMFA3KjVao77DbWRmGZbcMzydwGoACBNfljxAPJ/j2pe1WPeHL0Edr
 IVMfFkufyklQ9CGjyXOdj1n7im7QQ/iIcL108KJ7bg+yhImb4UyXhP1mjWi07k0s
 bM2ww==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49uadngq7t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Oct 2025 22:42:17 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 16 Oct 2025 22:42:26 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 16 Oct 2025 22:42:26 -0700
Received: from cavium-VAMSI-BM.. (unknown [10.28.36.156])
 by maili.marvell.com (Postfix) with ESMTP id 2E7163F7077;
 Thu, 16 Oct 2025 22:42:12 -0700 (PDT)
From: Vamsi Krishna <vattunuru@marvell.com>
To: <dev@dpdk.org>, <fengchengwen@huawei.com>
CC: <thomas@monjalon.net>, <bruce.richardson@intel.com>,
 <anatoly.burakov@intel.com>, <kevin.laatz@intel.com>,
 <jerinj@marvell.com>, <vattunuru@marvell.com>, <stephen@networkplumber.org>
Subject: [PATCH v4 1/1] lib/dma: introduce inter-process and inter-OS DMA
Date: Fri, 17 Oct 2025 11:12:10 +0530
Message-ID: <20251017054210.3105218-1-vattunuru@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251013042136.1727540-1-vattunuru@marvell.com>
References: <20251013042136.1727540-1-vattunuru@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Yc2wJgRf c=1 sm=1 tr=0 ts=68f1d739 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=M5GUcnROAAAA:8
 a=UhKti8L56FbLDJ0vU2YA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: rdm9xnV3rdkCJ9Y1qNoqC1C_kIIgS9WR
X-Proofpoint-ORIG-GUID: rdm9xnV3rdkCJ9Y1qNoqC1C_kIIgS9WR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE2MDE3NyBTYWx0ZWRfX4J6Ye0Zlg9qu
 FmBR08RzjSFgZBpsqMh4FP7L2P/feRWjNV2/Bs6sY1C2Zc/a+GW+Md2hszpQgWBIsALf9mXyzkX
 WxTV8iW+LwR2GvFOksvXE9x7jPjb8Ku8y6Zbbs2OGuJ/DwUxL5KY0I+CzFXdz1HsD9qJ4U7zUeR
 /1U4gL7zb7MHmuuXBzJHqcwS+1A3m+rWgVuo8OsNunzceOyQlGIdNiy9SzWMDpTj2sf/J/r4VBm
 3s5cTiE8s3LaXiC/xWFw1M18AeEaDoVpy5iF4pFJmNi5Pcb7F57RU01oFac693tSS2H/DShZRln
 fGWY8l1YG3b+gQm2xrFA9zDOm0NXf7gaWV9fiZ4ioOQFvGbEBiBOMEowv3D2nvi2nEaeSH8C3Yz
 9O2IJFlVzQQWw0rmwD+8yQXGMx74fQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
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
V4 changes:
* Move comments before defination
* Validate reserved fields are zero or not.
* Add more comments to new fields.
* UT for this feature will be added in another commit.
V3 changes:
* Fix v2 review comments
V2 changes:
* Seperate out the control-plane APIs
* Address v0 review comments
* Add validation checks
* Rename the enums

 lib/dmadev/rte_dmadev.c       | 25 +++++++++++++
 lib/dmadev/rte_dmadev.h       | 69 +++++++++++++++++++++++++++++++++++
 lib/dmadev/rte_dmadev_trace.h |  3 ++
 3 files changed, 97 insertions(+)

diff --git a/lib/dmadev/rte_dmadev.c b/lib/dmadev/rte_dmadev.c
index 73d24f8ff3..30c3db3a98 100644
--- a/lib/dmadev/rte_dmadev.c
+++ b/lib/dmadev/rte_dmadev.c
@@ -665,6 +665,27 @@ rte_dma_vchan_setup(int16_t dev_id, uint16_t vchan,
 		RTE_DMA_LOG(ERR, "Device %d vchan out range!", dev_id);
 		return -EINVAL;
 	}
+	if (conf->domain.type != RTE_DMA_INTER_DOMAIN_NONE &&
+	    conf->direction != RTE_DMA_DIR_MEM_TO_MEM) {
+		RTE_DMA_LOG(ERR, "Device %d inter domain only support mem-to-mem transfer", dev_id);
+		return -EINVAL;
+	}
+	if (conf->domain.type == RTE_DMA_INTER_OS_DOMAIN &&
+	    !(dev_info.dev_capa & RTE_DMA_CAPA_INTER_OS_DOMAIN)) {
+		RTE_DMA_LOG(ERR, "Device %d does not support inter os domain", dev_id);
+		return -EINVAL;
+	}
+	if (conf->domain.type == RTE_DMA_INTER_PROCESS_DOMAIN &&
+	    !(dev_info.dev_capa & RTE_DMA_CAPA_INTER_PROCESS_DOMAIN)) {
+		RTE_DMA_LOG(ERR, "Device %d does not support inter process domain", dev_id);
+		return -EINVAL;
+	}
+	if ((conf->domain.type == RTE_DMA_INTER_PROCESS_DOMAIN ||
+	    conf->domain.type == RTE_DMA_INTER_OS_DOMAIN) &&
+	    (conf->domain.reserved[0] != 0 || conf->domain.reserved[1] != 0)) {
+		RTE_DMA_LOG(ERR, "Device %d does not support non-zero reserved fields", dev_id);
+		return -EINVAL;
+	}
 	if (conf->direction != RTE_DMA_DIR_MEM_TO_MEM &&
 	    conf->direction != RTE_DMA_DIR_MEM_TO_DEV &&
 	    conf->direction != RTE_DMA_DIR_DEV_TO_MEM &&
@@ -811,6 +832,8 @@ dma_capability_name(uint64_t capability)
 		{ RTE_DMA_CAPA_HANDLES_ERRORS, "handles_errors" },
 		{ RTE_DMA_CAPA_M2D_AUTO_FREE,  "m2d_auto_free"  },
 		{ RTE_DMA_CAPA_PRI_POLICY_SP,  "pri_policy_sp" },
+		{ RTE_DMA_CAPA_INTER_PROCESS_DOMAIN, "inter_process_domain" },
+		{ RTE_DMA_CAPA_INTER_OS_DOMAIN, "inter_os_domain" },
 		{ RTE_DMA_CAPA_OPS_COPY,    "copy"    },
 		{ RTE_DMA_CAPA_OPS_COPY_SG, "copy_sg" },
 		{ RTE_DMA_CAPA_OPS_FILL,    "fill"    },
@@ -1040,6 +1063,8 @@ dmadev_handle_dev_info(const char *cmd __rte_unused,
 	ADD_CAPA(dma_caps, dev_capa, RTE_DMA_CAPA_HANDLES_ERRORS);
 	ADD_CAPA(dma_caps, dev_capa, RTE_DMA_CAPA_M2D_AUTO_FREE);
 	ADD_CAPA(dma_caps, dev_capa, RTE_DMA_CAPA_PRI_POLICY_SP);
+	ADD_CAPA(dma_caps, dev_capa, RTE_DMA_CAPA_INTER_PROCESS_DOMAIN);
+	ADD_CAPA(dma_caps, dev_capa, RTE_DMA_CAPA_INTER_OS_DOMAIN);
 	ADD_CAPA(dma_caps, dev_capa, RTE_DMA_CAPA_OPS_COPY);
 	ADD_CAPA(dma_caps, dev_capa, RTE_DMA_CAPA_OPS_COPY_SG);
 	ADD_CAPA(dma_caps, dev_capa, RTE_DMA_CAPA_OPS_FILL);
diff --git a/lib/dmadev/rte_dmadev.h b/lib/dmadev/rte_dmadev.h
index 30e168825e..1708311c5b 100644
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
@@ -426,8 +438,13 @@ int rte_dma_close(int16_t dev_id);
  */
 enum rte_dma_direction {
 	/** DMA transfer direction - from memory to memory.
+	 * When the device supports inter-process or inter-OS domain transfers,
+	 * the field `type` in `struct rte_dma_vchan_conf::domain` specifies the
+	 * type of domain. For memory-to-memory transfers within the same domain
+	 * or process, `type` should be set to `RTE_DMA_INTER_DOMAIN_NONE`.
 	 *
 	 * @see struct rte_dma_vchan_conf::direction
+	 * @see struct rte_dma_inter_domain_param::type
 	 */
 	RTE_DMA_DIR_MEM_TO_MEM,
 	/** DMA transfer direction - from memory to device.
@@ -572,6 +589,49 @@ struct rte_dma_auto_free_param {
 	uint64_t reserved[2];
 };
 
+/**
+ * Inter-DMA transfer domain type.
+ *
+ * This enum defines the types of transfer domains applicable to DMA operations.
+ * It helps categorize whether a DMA transfer is occurring within the same domain,
+ * across different processes, or between distinct operating system domains.
+ *
+ * @see struct rte_dma_inter_domain_param:type
+ */
+enum rte_dma_inter_domain_type {
+	/** No inter-domain transfer; standard DMA within same domain. */
+	RTE_DMA_INTER_DOMAIN_NONE,
+	/** Transfer occurs between different user-space processes. */
+	RTE_DMA_INTER_PROCESS_DOMAIN,
+	/** Transfer spans across different operating system domains. */
+	RTE_DMA_INTER_OS_DOMAIN,
+};
+
+/**
+ * Parameters for inter-process or inter-OS DMA transfers.
+ *
+ * This structure defines the parameters required to perform DMA transfers
+ * across different domains, such as between processes or operating systems.
+ * It includes the domain type and handler identifiers for both the source
+ * and destination domains.
+ *
+ * When domain type is RTE_DMA_INTER_DOMAIN_NONE, both source and destination
+ * handlers are invalid, DMA operation is confined within the local process.
+ *
+ * For DMA transfers between the local process or OS domain to another process
+ * or OS domain, valid source and destination handlers must be provided.
+ */
+struct rte_dma_inter_domain_param {
+	/** Type of inter-domain. */
+	enum rte_dma_inter_domain_type type;
+	/** Source domain handler identifier. */
+	uint16_t src_handler;
+	/** Destination domain handler identifier. */
+	uint16_t dst_handler;
+	/** Reserved for future fields. */
+	uint64_t reserved[2];
+};
+
 /**
  * A structure used to configure a virtual DMA channel.
  *
@@ -609,6 +669,15 @@ struct rte_dma_vchan_conf {
 	 * @see struct rte_dma_auto_free_param
 	 */
 	struct rte_dma_auto_free_param auto_free;
+	/** Parameters for inter-process or inter-OS domain DMA transfers. This field
+	 * specifies the source and destination domain handlers required for DMA
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
index 04d9a2741b..f1a178eeb5 100644
--- a/lib/dmadev/rte_dmadev_trace.h
+++ b/lib/dmadev/rte_dmadev_trace.h
@@ -79,6 +79,9 @@ RTE_TRACE_POINT(
 	rte_trace_point_emit_int(conf->dst_port.port_type);
 	rte_trace_point_emit_u64(conf->dst_port.pcie.val);
 	rte_trace_point_emit_ptr(conf->auto_free.m2d.pool);
+	rte_trace_point_emit_int(conf->domain.type);
+	rte_trace_point_emit_u16(conf->domain.src_handler);
+	rte_trace_point_emit_u16(conf->domain.dst_handler);
 	rte_trace_point_emit_int(ret);
 )
 
-- 
2.34.1

