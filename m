Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B7DCA0FF2
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Sep 2025 15:14:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D51A40E45;
	Wed,  3 Sep 2025 17:14:16 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 7D87640E44
 for <dev@dpdk.org>; Wed,  3 Sep 2025 17:14:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756912454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FwAMZGAViSTYu8nBWhvK2ZSrnn1xOTDP33lP/RvTKSc=;
 b=d8HsP0/k2igxuq1rykD7rSRCoCgv96bQbmWYtbRTEk7srOegchiqdLujSUspkv84/QLS8T
 72epkGaxcQHfifNytCSaAeBE/KZZuRGexmzH02VbOXgqUowombTx7iLqGYNbBDtpx640q9
 SxDAqmVnXG4255QC2xx2xmYE8+36vmY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-490-jWFMPfSOPqCT94f6I0SgeA-1; Wed,
 03 Sep 2025 11:14:12 -0400
X-MC-Unique: jWFMPfSOPqCT94f6I0SgeA-1
X-Mimecast-MFC-AGG-ID: jWFMPfSOPqCT94f6I0SgeA_1756912451
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 76D031956096; Wed,  3 Sep 2025 15:14:11 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.82])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 1FFB119560AB; Wed,  3 Sep 2025 15:14:08 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, maxime.coquelin@redhat.com, anatoly.burakov@intel.com,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [RFC v2 6/9] eal/linux: remove internal VFIO wrappers for old Linux
Date: Wed,  3 Sep 2025 17:13:23 +0200
Message-ID: <20250903151327.1964490-7-david.marchand@redhat.com>
In-Reply-To: <20250903151327.1964490-1-david.marchand@redhat.com>
References: <20250903072826.1727004-1-david.marchand@redhat.com>
 <20250903151327.1964490-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DGm2axMwuPWCKMJ3RJ7603jw91YagMgUzFruT8HGS2o_1756912451
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

