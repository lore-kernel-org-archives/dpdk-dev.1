Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A805CA100C
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Sep 2025 07:29:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 26B0840B98;
	Wed,  3 Sep 2025 09:29:12 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3FDF74066A
 for <dev@dpdk.org>; Wed,  3 Sep 2025 09:29:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756884550;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FwAMZGAViSTYu8nBWhvK2ZSrnn1xOTDP33lP/RvTKSc=;
 b=Na5bhDFKTgGni91jm8SCZ1Ljw4ORe354XX2myxfhODI8s4yj7EHncTWgXXxJBE8fgnvkIF
 Tm4/bDquGZcoKHQs95K86JZeTr1XyvojCPJFBdrquWmgEEn5eBx7VK3rgEOv5s+ieiXX7N
 bAeUVrSgxu3081sT5XKh8M48OzN9vjU=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-cNrpCCzMOpaB29Kqds2gng-1; Wed,
 03 Sep 2025 03:29:07 -0400
X-MC-Unique: cNrpCCzMOpaB29Kqds2gng-1
X-Mimecast-MFC-AGG-ID: cNrpCCzMOpaB29Kqds2gng_1756884546
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B2F2F19560A1; Wed,  3 Sep 2025 07:29:06 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.82])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 413FB19560B8; Wed,  3 Sep 2025 07:29:03 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, maxime.coquelin@redhat.com,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [RFC 5/8] eal/linux: remove internal VFIO wrappers for old Linux
Date: Wed,  3 Sep 2025 09:28:22 +0200
Message-ID: <20250903072826.1727004-6-david.marchand@redhat.com>
In-Reply-To: <20250903072826.1727004-1-david.marchand@redhat.com>
References: <20250903072826.1727004-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: xGbjJTp330wzNscLYFEo5fAtZYR-RQ_Rs6UCmiGIYOY_1756884546
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
index cc4311989b..c08c316c94 100644
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
index 1eab90a261..c6aed44946 100644
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

