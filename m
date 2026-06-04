Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE3F0CD6E75
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 23:57:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 071C64065C;
	Fri,  5 Jun 2026 01:57:47 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 41F0140270
 for <dev@dpdk.org>; Fri,  5 Jun 2026 01:57:46 +0200 (CEST)
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654DSE4J2904839 for <dev@dpdk.org>; Thu, 4 Jun 2026 19:57:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=i
 J7Eaqr+lrF/ktu/LYVLj/xxX0/52mYMRYxP2FdD9tI=; b=m3qvcTlESXhkivdon
 3J12vyH7UioBzqVJbiEsFdkQBfC5MQ2Ws+2AyfSp3Q/+Mf5aP77uDCue+MVig6Ot
 zwWh9Bvi0Ha4dDA+Pjej+rMV7jfJD2qgihmXWSdETh9BrKEhjHN7VglUimsxxooo
 HrmExCFc/CPSmbIQgFpL9gyDPpD2+3uOf0g9RHWZe5DJpr4+fa/MRixP+MEN4Ny4
 3B14QbcuR7JzbMaYfGI1CplzujiX7KDDkZm6HABc/+BeTStvjURNA0LJrmmj3swm
 QumQmuVIGEGXs90tcMZhswaQXu/IggF7qD9zUQWu5XYzv2oOMwMeB0oKI+3tACJR
 5VY2Q==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4ej75pjb1b-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 04 Jun 2026 19:57:45 -0400 (EDT)
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654KJrtP2756789 for <dev@dpdk.org>; Thu, 4 Jun 2026 19:57:44 -0400
Received: from esapsmtpat08.us.dell.com (esapsmtpat08.us.dell.com
 [143.166.211.148])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4ekga02fe7-3
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Thu, 04 Jun 2026 19:57:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1780617464; x=1812153464;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=iJ7Eaqr+lrF/ktu/LYVLj/xxX0/52mYMRYxP2FdD9tI=;
 b=e6fDJNiiqBhixgYF2Hm9X+YpcKRjyS/ScYE3QyXpjUt8yrQHCBI6/iSr
 8egqGwaW7Jo5rW8qZzXqI7UfSDHz/OFMkDTB5J/tjssXKZaXYMfkhdVxY
 Q6ecNiSZQjU0ZP7g4RR+dBLowwGBiBaiB9+wHupH2VOCU3LHhFvq0ESpY
 HcrjpJCZVztc/bt7UerGG8PQu8MT4HQgNcSKImgK7PQvupdqky4vv+EhX
 NLDoYt9VPIvoMMovtuhvALA0V/M+nra6Giit05sPt2xj1NLq85QFfKwl4
 k7UzHxJqfYDwHE+VAAvKTyzZRkt/1zvpvX/GeJsBwvvjAoFqyD3nzBkfj Q==;
X-CSE-ConnectionGUID: Uqv3slKQSbuWW2bsuQavfw==
X-CSE-MsgGUID: AsiDws00T+Sdu+j4EL/v0g==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtpat08.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2026 23:57:44 +0000
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 4 Jun 2026 18:58:53 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwer001.delllabs.net (100.64.0.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 4 Jun 2026 18:57:43 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Thu, 4 Jun 2026 18:57:42 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <fengchengwen@huawei.com>, <stephen@networkplumber.org>,
 <maxime.coquelin@redhat.com>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>, Stephen Hemminger
 <stephen@networkplumber.com>
Subject: [PATCH v15 3/5] vhost: refactor memory helper functions
Date: Thu, 4 Jun 2026 23:57:21 +0000
Message-ID: <20260604235723.1046607-4-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260604235723.1046607-1-pravin.bathija@dell.com>
References: <20260604235723.1046607-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_06,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040234
X-Authority-Analysis: v=2.4 cv=P4EKQCAu c=1 sm=1 tr=0 ts=6a2210f9 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=yMHKiRmgHdO7ybaHu+/uXg==:17
 a=FelO9ux0wxsA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=aNt9FJNJ8fZyd9HhltU_:22 a=iLNU1ar6AAAA:8
 a=CPuvAHPoAAAA:8 a=20KFwNOVAAAA:8 a=CfOEWKL4czFXYmui9msA:9
 a=gbU3OgOOxF9bX48Letew:22 a=r6J0Z2L7KMegjY60bkqS:22
X-Proofpoint-GUID: d7l5zzAiQRUNZ1Y8DdAOLuOy3puhzVB_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDIzNSBTYWx0ZWRfX863gcbxe2mLL
 3dt1i2a4sxeufbUleg5zptSjp4mbCKwK6wCu+TXMycYSf25vwC4/UEVuM/MnozrQhR0/O8V/BZx
 H995buVIu3jTde4rsgsKurzL3mJp+WUpTwbi4P2XQKIqZIf4kOengMlvJVoBOUY4kDh0IzdHD6f
 2eCucRD+q1Aj3tx1wce4DEzM3I9sHwMxoUHPEtUCYXazqPsxK0FRGxNKaJ8Ip5y8/QrFea7b9wg
 5TkA4wWQyt7tKirZj3xJ4l5MyCCC/ophcaXALfTPVw5n4MOm5PSxHDUPs/9Zxk3Y/3bSC+l6jBC
 aj+QSgsdHvxbvOUmqiGR6TRsTdo0dRsjMKsDmCzeoEP/HYS6hCoaADP3aWk3sqilA0fbzBjZRPf
 9yRHkjAWjMJM7Tzcv4c+LsccTY3Sp+FFy1QBWRZvvC8gOzNFUrvIUkUUORn9end7NvLxIx9JKTe
 KPyB/koTWxBPFrKq8FA==
X-Proofpoint-ORIG-GUID: d7l5zzAiQRUNZ1Y8DdAOLuOy3puhzVB_
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 spamscore=0 bulkscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 impostorscore=0 adultscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040235
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

From: Pravin M Bathija <pravin.bathija@dell.com>

- Extract reusable helper routines for vhost-user backend memory
operations.
- Split DMA map/unmap into per-region logic.
- Decouple and rework memory region free routines.
- Iterate over VHOST_MEMORY_MAX_NREGIONS uniformly
across related functions to simplify code reuse

Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.com>
Reviewed-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 lib/vhost/vhost_user.c | 172 ++++++++++++++++++++++++++---------------
 1 file changed, 110 insertions(+), 62 deletions(-)

diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
index 4bfb13fb98..94fca8b589 100644
--- a/lib/vhost/vhost_user.c
+++ b/lib/vhost/vhost_user.c
@@ -171,20 +171,27 @@ get_blk_size(int fd)
 	return ret == -1 ? (uint64_t)-1 : (uint64_t)stat.st_blksize;
 }
 
-static void
-async_dma_map(struct virtio_net *dev, bool do_map)
+static int
+async_dma_map_region(struct virtio_net *dev, struct rte_vhost_mem_region *reg, bool do_map)
 {
-	int ret = 0;
 	uint32_t i;
-	struct guest_page *page;
+	int ret;
+	uint64_t reg_start = reg->host_user_addr;
+	uint64_t reg_end = reg_start + reg->size;
 
-	if (do_map) {
-		for (i = 0; i < dev->nr_guest_pages; i++) {
-			page = &dev->guest_pages[i];
+	for (i = 0; i < dev->nr_guest_pages; i++) {
+		struct guest_page *page = &dev->guest_pages[i];
+
+		/* Only process pages belonging to this region */
+		if (page->host_user_addr < reg_start ||
+		    page->host_user_addr >= reg_end)
+			continue;
+
+		if (do_map) {
 			ret = rte_vfio_container_dma_map(RTE_VFIO_DEFAULT_CONTAINER_FD,
-							 page->host_user_addr,
-							 page->host_iova,
-							 page->size);
+					page->host_user_addr,
+					page->host_iova,
+					page->size);
 			if (ret) {
 				/*
 				 * DMA device may bind with kernel driver, in this case,
@@ -199,33 +206,57 @@ async_dma_map(struct virtio_net *dev, bool do_map)
 				 * normal case in async path. This is a workaround.
 				 */
 				if (rte_errno == ENODEV)
-					return;
+					return 0;
 
 				/* DMA mapping errors won't stop VHOST_USER_SET_MEM_TABLE. */
 				VHOST_CONFIG_LOG(dev->ifname, ERR, "DMA engine map failed");
+				return -1;
 			}
-		}
-
-	} else {
-		for (i = 0; i < dev->nr_guest_pages; i++) {
-			page = &dev->guest_pages[i];
+		} else {
 			ret = rte_vfio_container_dma_unmap(RTE_VFIO_DEFAULT_CONTAINER_FD,
-							   page->host_user_addr,
-							   page->host_iova,
-							   page->size);
+					page->host_user_addr,
+					page->host_iova,
+					page->size);
 			if (ret) {
 				/* like DMA map, ignore the kernel driver case when unmap. */
 				if (rte_errno == EINVAL)
-					return;
+					return 0;
 
 				VHOST_CONFIG_LOG(dev->ifname, ERR, "DMA engine unmap failed");
+				return -1;
 			}
 		}
 	}
+
+	return 0;
+}
+
+static void
+async_dma_map(struct virtio_net *dev, bool do_map)
+{
+	uint32_t i;
+	struct rte_vhost_mem_region *reg;
+
+	for (i = 0; i < VHOST_MEMORY_MAX_NREGIONS; i++) {
+		reg = &dev->mem->regions[i];
+		if (reg->host_user_addr == 0)
+			continue;
+		async_dma_map_region(dev, reg, do_map);
+	}
 }
 
 static void
-free_mem_region(struct virtio_net *dev)
+free_mem_region(struct rte_vhost_mem_region *reg)
+{
+	if (reg != NULL && reg->mmap_addr) {
+		munmap(reg->mmap_addr, reg->mmap_size);
+		close(reg->fd);
+		memset(reg, 0, sizeof(struct rte_vhost_mem_region));
+	}
+}
+
+static void
+free_all_mem_regions(struct virtio_net *dev)
 {
 	uint32_t i;
 	struct rte_vhost_mem_region *reg;
@@ -236,12 +267,10 @@ free_mem_region(struct virtio_net *dev)
 	if (dev->async_copy && rte_vfio_is_enabled("vfio"))
 		async_dma_map(dev, false);
 
-	for (i = 0; i < dev->mem->nregions; i++) {
+	for (i = 0; i < VHOST_MEMORY_MAX_NREGIONS; i++) {
 		reg = &dev->mem->regions[i];
-		if (reg->host_user_addr) {
-			munmap(reg->mmap_addr, reg->mmap_size);
-			close(reg->fd);
-		}
+		if (reg->mmap_addr)
+			free_mem_region(reg);
 	}
 }
 
@@ -255,7 +284,7 @@ vhost_backend_cleanup(struct virtio_net *dev)
 		vdpa_dev->ops->dev_cleanup(dev->vid);
 
 	if (dev->mem) {
-		free_mem_region(dev);
+		free_all_mem_regions(dev);
 		rte_free(dev->mem);
 		dev->mem = NULL;
 	}
@@ -704,7 +733,7 @@ numa_realloc(struct virtio_net **pdev, struct vhost_virtqueue **pvq)
 	vhost_devices[dev->vid] = dev;
 
 	mem_size = sizeof(struct rte_vhost_memory) +
-		sizeof(struct rte_vhost_mem_region) * dev->mem->nregions;
+		sizeof(struct rte_vhost_mem_region) * VHOST_MEMORY_MAX_NREGIONS;
 	mem = rte_realloc_socket(dev->mem, mem_size, 0, node);
 	if (!mem) {
 		VHOST_CONFIG_LOG(dev->ifname, ERR,
@@ -808,8 +837,10 @@ hua_to_alignment(struct rte_vhost_memory *mem, void *ptr)
 	uint32_t i;
 	uintptr_t hua = (uintptr_t)ptr;
 
-	for (i = 0; i < mem->nregions; i++) {
+	for (i = 0; i < VHOST_MEMORY_MAX_NREGIONS; i++) {
 		r = &mem->regions[i];
+		if (r->host_user_addr == 0)
+			continue;
 		if (hua >= r->host_user_addr &&
 			hua < r->host_user_addr + r->size) {
 			return get_blk_size(r->fd);
@@ -1382,6 +1413,52 @@ vhost_user_mmap_region(struct virtio_net *dev,
 	return 0;
 }
 
+static int
+vhost_user_initialize_memory(struct virtio_net **pdev)
+{
+	struct virtio_net *dev = *pdev;
+	int numa_node = SOCKET_ID_ANY;
+
+	if (dev->mem != NULL) {
+		VHOST_CONFIG_LOG(dev->ifname, ERR,
+			"memory already initialized, free it first");
+		return -1;
+	}
+
+	/*
+	 * If VQ 0 has already been allocated, try to allocate on the same
+	 * NUMA node. It can be reallocated later in numa_realloc().
+	 */
+	if (dev->nr_vring > 0)
+		numa_node = dev->virtqueue[0]->numa_node;
+
+	dev->nr_guest_pages = 0;
+	if (dev->guest_pages == NULL) {
+		dev->max_guest_pages = 8;
+		dev->guest_pages = rte_zmalloc_socket(NULL,
+					dev->max_guest_pages *
+					sizeof(struct guest_page),
+					RTE_CACHE_LINE_SIZE,
+					numa_node);
+		if (dev->guest_pages == NULL) {
+			VHOST_CONFIG_LOG(dev->ifname, ERR,
+				"failed to allocate memory for dev->guest_pages");
+			return -1;
+		}
+	}
+
+	dev->mem = rte_zmalloc_socket("vhost-mem-table", sizeof(struct rte_vhost_memory) +
+		sizeof(struct rte_vhost_mem_region) * VHOST_MEMORY_MAX_NREGIONS, 0, numa_node);
+	if (dev->mem == NULL) {
+		VHOST_CONFIG_LOG(dev->ifname, ERR, "failed to allocate memory for dev->mem");
+		rte_free(dev->guest_pages);
+		dev->guest_pages = NULL;
+		return -1;
+	}
+
+	return 0;
+}
+
 static int
 vhost_user_set_mem_table(struct virtio_net **pdev,
 			struct vhu_msg_context *ctx,
@@ -1390,7 +1467,6 @@ vhost_user_set_mem_table(struct virtio_net **pdev,
 	struct virtio_net *dev = *pdev;
 	struct VhostUserMemory *memory = &ctx->msg.payload.memory;
 	struct rte_vhost_mem_region *reg;
-	int numa_node = SOCKET_ID_ANY;
 	uint64_t mmap_offset;
 	uint32_t i;
 	bool async_notify = false;
@@ -1435,39 +1511,13 @@ vhost_user_set_mem_table(struct virtio_net **pdev,
 		if (dev->features & (1ULL << VIRTIO_F_IOMMU_PLATFORM))
 			vhost_user_iotlb_flush_all(dev);
 
-		free_mem_region(dev);
+		free_all_mem_regions(dev);
 		rte_free(dev->mem);
 		dev->mem = NULL;
 	}
 
-	/*
-	 * If VQ 0 has already been allocated, try to allocate on the same
-	 * NUMA node. It can be reallocated later in numa_realloc().
-	 */
-	if (dev->nr_vring > 0)
-		numa_node = dev->virtqueue[0]->numa_node;
-
-	dev->nr_guest_pages = 0;
-	if (dev->guest_pages == NULL) {
-		dev->max_guest_pages = 8;
-		dev->guest_pages = rte_zmalloc_socket(NULL,
-					dev->max_guest_pages *
-					sizeof(struct guest_page),
-					RTE_CACHE_LINE_SIZE,
-					numa_node);
-		if (dev->guest_pages == NULL) {
-			VHOST_CONFIG_LOG(dev->ifname, ERR,
-				"failed to allocate memory for dev->guest_pages");
-			goto close_msg_fds;
-		}
-	}
-
-	dev->mem = rte_zmalloc_socket("vhost-mem-table", sizeof(struct rte_vhost_memory) +
-		sizeof(struct rte_vhost_mem_region) * memory->nregions, 0, numa_node);
-	if (dev->mem == NULL) {
-		VHOST_CONFIG_LOG(dev->ifname, ERR, "failed to allocate memory for dev->mem");
-		goto free_guest_pages;
-	}
+	if (vhost_user_initialize_memory(pdev) < 0)
+		goto close_msg_fds;
 
 	for (i = 0; i < memory->nregions; i++) {
 		reg = &dev->mem->regions[i];
@@ -1531,11 +1581,9 @@ vhost_user_set_mem_table(struct virtio_net **pdev,
 	return RTE_VHOST_MSG_RESULT_OK;
 
 free_mem_table:
-	free_mem_region(dev);
+	free_all_mem_regions(dev);
 	rte_free(dev->mem);
 	dev->mem = NULL;
-
-free_guest_pages:
 	rte_free(dev->guest_pages);
 	dev->guest_pages = NULL;
 close_msg_fds:
-- 
2.43.0

