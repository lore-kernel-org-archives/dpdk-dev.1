Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7346CD5BA6
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 02:20:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 42C4C40672;
	Wed, 20 May 2026 04:20:38 +0200 (CEST)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id E969B4066E
 for <dev@dpdk.org>; Wed, 20 May 2026 04:20:36 +0200 (CEST)
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64JGtZ7d1041284 for <dev@dpdk.org>; Tue, 19 May 2026 22:20:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=t
 JJ2dn7x1apwTKUMAE1lJ2hjDHWqPgGuVh7r8zzhqmA=; b=fIcs/MQOvF5vBYZ2Q
 DHIrDWLh7Q3kwOViCCFd5bOv21PRUjNM0xkmGSSTu2wZKy/Ikx2+x/NLNwtg3ZPG
 8PzVczouhLuYXkrOZeOJZ6wWkTxiDDYpidReRFf9Ss68XTyQlhkRvZcuiEoqldCo
 0fZ0t4AjN8nVOG4uaunbRfRkjxaz1MAlY/2muh2Lui9d6O3opKC6fW/kE1Lm5dMO
 35hUMaa4aN3+o6NGT4TF2DcOyTqM/yiD+zbYSiUkCKt46PjeYPVr1Aboo1Gh7hHL
 8/A8YcUkfiy+5qM7mm6NRTukwyNV5ALAsr4z45ki9PWiBpRqgMSEffyUrG/zzeo5
 J1SQA==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4e6hnn1wqs-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 19 May 2026 22:20:36 -0400 (EDT)
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64JNbbG62927618 for <dev@dpdk.org>; Tue, 19 May 2026 22:20:35 -0400
Received: from esapsmtplv06.us.dell.com (esapsmtplv06.us.dell.com
 [143.166.203.146])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4e8x4dvbh9-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Tue, 19 May 2026 22:20:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1779243636; x=1810779636;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=tJJ2dn7x1apwTKUMAE1lJ2hjDHWqPgGuVh7r8zzhqmA=;
 b=GaXhQ/Vricd35aGOCdp1BQWQoSqfrbJIxQ5q6BQ849g4YEAvGz4Dpoot
 z9+qyqmDZVLRm1T9KgHf5E1KG1rXOYFyaJnC0g9TV6LS8i+/y6ZGmYhsV
 IqR55H22xpReNPu2hHIsnbefNKFMxnSmmNvqMHp4ruRmEph0My88abY5/
 WloYaEVwy/yJ5boI40yv+ed2pwRjr2KwfWEuDUJFlZrvSsnM8oT5bTeHO
 fVD22agtPV4Vk4fz8eUV7zVAsXkTdHeIfexl8gVD6y7AqZ43SCyudDGug
 kSoHnFRjp7J+fVX84KUaboOj2jZmsSxCIwpUTkgM0JToePhRKw/XITPZs Q==;
X-CSE-ConnectionGUID: ZieAmatnSeigK/Ws/I3XQg==
X-CSE-MsgGUID: mJvyCWyVRuuV09A0xG4DzA==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtplv06.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 02:20:35 +0000
Received: from ieorr5-ppwem002.delllabs.net (100.64.0.133) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 19 May 2026 21:21:26 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-ppwem002.delllabs.net (100.64.0.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 19 May 2026 21:20:34 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Tue, 19 May 2026 21:20:33 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <fengchengwen@huawei.com>, <stephen@networkplumber.org>,
 <maxime.coquelin@redhat.com>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>, Stephen Hemminger
 <stephen@networkplumber.com>
Subject: [PATCH v14 3/5] vhost: refactor memory helper functions
Date: Wed, 20 May 2026 02:20:10 +0000
Message-ID: <20260520022012.243619-4-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520022012.243619-1-pravin.bathija@dell.com>
References: <20260520022012.243619-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_06,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200019
X-Proofpoint-GUID: I7xgmT_aThSMRBr3OgesrRWWVlQkUcN2
X-Authority-Analysis: v=2.4 cv=VJLtWdPX c=1 sm=1 tr=0 ts=6a0d1a74 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=in+AvElAwLqdjTPPAWhuvg==:17
 a=NGcC8JguVDcA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=U3ti1ie9CgboSd2qXsAw:22 a=iLNU1ar6AAAA:8
 a=i0EeH86SAAAA:8 a=CPuvAHPoAAAA:8 a=20KFwNOVAAAA:8 a=CfOEWKL4czFXYmui9msA:9
 a=hlJyneSgMmFPbskH-t2w:22 a=r6J0Z2L7KMegjY60bkqS:22
X-Proofpoint-ORIG-GUID: I7xgmT_aThSMRBr3OgesrRWWVlQkUcN2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDAyMCBTYWx0ZWRfX83RkZoHECm29
 2YOAeMaw/LmeW/W0bjBlTF3HzHHModRoLRJKWIfbptHdk1l9F+2urTzp2NsDwItAnYVkE9/9Jcf
 fy+0PEFf1auTOvRo0b2VF8vXggtye+SfsQACJLJ0z43sX4j/4/MczmqwJgAYoErP0MSWsIXz9zt
 RHdjdGg8LzNse66qrYQrsQmcc4pLPtPySMOvX6r90+JzICcLIXUQA4HlFSVmm0FlaRrpYnSvs9M
 trwDzMcGg1k8qesXEjGUuJcwcID9DiDkWAlQLK7SMA7jW5TS+8hE0XfzR/CYVKlAeeH8qFqRDD1
 uKPZL0R9GrxYXwAKvkq43M+qvoOMUPuLcmIzW3VKn9AWwkkB4lW7QTZqZgzcV1+3J3KaZy+sKho
 yHraoH/36+7kDsxN59WQt0/r79y2yiT88fRaKdckdqPLz6kMYi2KXQG4eu4GjgScc2E7ignkdVm
 sSQtbh3VDAvXgDB/wdA==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 spamscore=0
 suspectscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200020
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
Acked-by: Fengchengwen <fengchengwen@huawei.com>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.com>
Acked-by: Maxime Coquelin <maxime.coquelin@redhat.com>
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

