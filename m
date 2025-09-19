Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B25CAC5A5
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 08:39:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A7D8A4067A;
	Fri, 19 Sep 2025 10:39:09 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 986944067A
 for <dev@dpdk.org>; Fri, 19 Sep 2025 10:39:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758271147;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2BVdwaylHo1eS6tH2cmOyfFP1244GrHjRxz3DezC4k8=;
 b=EVY7KIVYisK6HuURkXCGGzsBRH4c20w7zA/XZIosNdWB5Uvm27t2vyOWpdOFqSvkMxqCya
 Qren5fL39gt5CC9eQUGypddvKIpdr/xsARqo8DwWmr+w+cDqmncxd1W+NkJZVXfHj5s/Pp
 82cTyWcaYKfbr7oMzy/Ayzx+76E8CzA=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-M3E9854MO4mgg8DCaNbLhw-1; Fri,
 19 Sep 2025 04:39:02 -0400
X-MC-Unique: M3E9854MO4mgg8DCaNbLhw-1
X-Mimecast-MFC-AGG-ID: M3E9854MO4mgg8DCaNbLhw_1758271141
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 160B0180029D; Fri, 19 Sep 2025 08:39:01 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.45.225.72])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 49C09180057C; Fri, 19 Sep 2025 08:38:58 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, maxime.coquelin@redhat.com, anatoly.burakov@intel.com,
 stephen@networkplumber.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v3 07/10] eal/linux: remove internal VFIO wrappers for old
 Linux
Date: Fri, 19 Sep 2025 10:38:04 +0200
Message-ID: <20250919083808.1667491-8-david.marchand@redhat.com>
In-Reply-To: <20250919083808.1667491-1-david.marchand@redhat.com>
References: <20250903072826.1727004-1-david.marchand@redhat.com>
 <20250919083808.1667491-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _Bodr0XJR48svCzorzIwPm68p8gjjCwdIXmKfw-nilg_1758271141
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

DPDK now requires Linux v5.4 at least.

VFIO_SPAPR_TCE_IOMMU is present in Linux since v3.11.
VFIO_SPAPR_TCE_v2_IOMMU is present in Linux since v4.2.

Remove wrappers accordingly.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/bus/fslmc/fslmc_vfio.c |  2 +-
 lib/eal/linux/eal_vfio.c       |  4 +--
 lib/eal/linux/eal_vfio.h       | 60 ----------------------------------
 3 files changed, 3 insertions(+), 63 deletions(-)

diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfio.c
index 4454f66c1d..f0c593507f 100644
--- a/drivers/bus/fslmc/fslmc_vfio.c
+++ b/drivers/bus/fslmc/fslmc_vfio.c
@@ -449,7 +449,7 @@ fslmc_vfio_check_extensions(int vfio_container_fd)
 {
 	int ret;
 	uint32_t idx, n_extensions = 0;
-	static const int type_id[] = {RTE_VFIO_TYPE1, RTE_VFIO_SPAPR,
+	static const int type_id[] = {VFIO_TYPE1_IOMMU, VFIO_SPAPR_TCE_v2_IOMMU,
 		VFIO_NOIOMMU_IOMMU};
 	static const char * const type_id_nm[] = {"Type 1",
 		"sPAPR", "No-IOMMU"};
diff --git a/lib/eal/linux/eal_vfio.c b/lib/eal/linux/eal_vfio.c
index 45f0c57284..ad5de935d7 100644
--- a/lib/eal/linux/eal_vfio.c
+++ b/lib/eal/linux/eal_vfio.c
@@ -69,7 +69,7 @@ static int vfio_dma_mem_map(struct vfio_config *vfio_cfg, uint64_t vaddr,
 static const struct vfio_iommu_type iommu_types[] = {
 	/* x86 IOMMU, otherwise known as type 1 */
 	{
-		.type_id = RTE_VFIO_TYPE1,
+		.type_id = VFIO_TYPE1_IOMMU,
 		.name = "Type 1",
 		.partial_unmap = false,
 		.dma_map_func = &vfio_type1_dma_map,
@@ -77,7 +77,7 @@ static const struct vfio_iommu_type iommu_types[] = {
 	},
 	/* ppc64 IOMMU, otherwise known as spapr */
 	{
-		.type_id = RTE_VFIO_SPAPR,
+		.type_id = VFIO_SPAPR_TCE_v2_IOMMU,
 		.name = "sPAPR",
 		.partial_unmap = true,
 		.dma_map_func = &vfio_spapr_dma_map,
diff --git a/lib/eal/linux/eal_vfio.h b/lib/eal/linux/eal_vfio.h
index 413c8f18df..5c5742b429 100644
--- a/lib/eal/linux/eal_vfio.h
+++ b/lib/eal/linux/eal_vfio.h
@@ -8,66 +8,6 @@
 #include <rte_common.h>
 
 #include <stdint.h>
-#include <linux/vfio.h>
-
-#define RTE_VFIO_TYPE1 VFIO_TYPE1_IOMMU
-
-#ifndef VFIO_SPAPR_TCE_v2_IOMMU
-#define RTE_VFIO_SPAPR 7
-#define VFIO_IOMMU_SPAPR_REGISTER_MEMORY _IO(VFIO_TYPE, VFIO_BASE + 17)
-#define VFIO_IOMMU_SPAPR_UNREGISTER_MEMORY _IO(VFIO_TYPE, VFIO_BASE + 18)
-#define VFIO_IOMMU_SPAPR_TCE_CREATE _IO(VFIO_TYPE, VFIO_BASE + 19)
-#define VFIO_IOMMU_SPAPR_TCE_REMOVE _IO(VFIO_TYPE, VFIO_BASE + 20)
-
-struct vfio_iommu_spapr_register_memory {
-	uint32_t argsz;
-	uint32_t flags;
-	uint64_t vaddr;
-	uint64_t size;
-};
-
-struct vfio_iommu_spapr_tce_create {
-	uint32_t argsz;
-	uint32_t flags;
-	/* in */
-	uint32_t page_shift;
-	uint32_t __resv1;
-	uint64_t window_size;
-	uint32_t levels;
-	uint32_t __resv2;
-	/* out */
-	uint64_t start_addr;
-};
-
-struct vfio_iommu_spapr_tce_remove {
-	uint32_t argsz;
-	uint32_t flags;
-	/* in */
-	uint64_t start_addr;
-};
-
-struct vfio_iommu_spapr_tce_ddw_info {
-	uint64_t pgsizes;
-	uint32_t max_dynamic_windows_supported;
-	uint32_t levels;
-};
-
-/* SPAPR_v2 is not present, but SPAPR might be */
-#ifndef VFIO_SPAPR_TCE_IOMMU
-#define VFIO_IOMMU_SPAPR_TCE_GET_INFO _IO(VFIO_TYPE, VFIO_BASE + 12)
-
-struct vfio_iommu_spapr_tce_info {
-	uint32_t argsz;
-	uint32_t flags;
-	uint32_t dma32_window_start;
-	uint32_t dma32_window_size;
-	struct vfio_iommu_spapr_tce_ddw_info ddw;
-};
-#endif /* VFIO_SPAPR_TCE_IOMMU */
-
-#else /* VFIO_SPAPR_TCE_v2_IOMMU */
-#define RTE_VFIO_SPAPR VFIO_SPAPR_TCE_v2_IOMMU
-#endif
 
 /*
  * we don't need to store device fd's anywhere since they can be obtained from
-- 
2.51.0

