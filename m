Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8ADCA0ED1
	for <dpdk-dev@archiver.kernel.org>; Tue, 12 Aug 2025 02:34:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B27254060F;
	Tue, 12 Aug 2025 04:34:45 +0200 (CEST)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id 56B2440652
 for <dev@dpdk.org>; Tue, 12 Aug 2025 04:34:43 +0200 (CEST)
Received: from pps.filterd (m0170396.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BHsxRW022769
 for <dev@dpdk.org>; Mon, 11 Aug 2025 22:34:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=4
 Kh9wXDX8UA6NGofdOD1wHwwNyQJUkqqeqYjvVwdvHM=; b=jEqez9A/mUtZC/Rut
 lvQE1WkI+uMcI7uhPmTqYcRUqH9FNkcLtjoUiEydK1RshrOANWLHYZZ8ar16i2tq
 kc+jcQgDEvKrf4uIqBkPXjZ2M4in/9GLoPsIaV5kp+cLBfgaOk1ntYGnxkClXvcH
 EgHvVYDrv4SneauC1g+kkTbpC/mM9NUrYIgmz7mrBavz2sJ6f9bDcXxGOLL5/b09
 XPiEQvuzPVk7YIVaofeZivClb0pryMlkTnbzRe9IBp/S23G8xujJSwySX0GSEaFX
 /4nng8WGL+WJDFA62hpyx6z0kk9ZHKg57RL7pEHT5U0ZXbmeIglykcqxJnriq287
 97TEQ==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 48e261tdnp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 11 Aug 2025 22:34:42 -0400 (EDT)
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57C2TeN2015132
 for <dev@dpdk.org>; Mon, 11 Aug 2025 22:34:42 -0400
Received: from esapsmtpat09.us.dell.com (esapsmtpat09.us.dell.com
 [143.166.211.151])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 48fux4rq1s-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Mon, 11 Aug 2025 22:34:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1754966082; x=1786502082;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=4Kh9wXDX8UA6NGofdOD1wHwwNyQJUkqqeqYjvVwdvHM=;
 b=cb1Lwkwu6qfxzwrhrj4wy8YCxVZngEkSHPEs5FAykvnVmH9VPa+GWLjf
 L++Zq3ipYvW5IZnvuvdlVquNrC0BAjsqfHta2/E+AmHaQsKRcEVFzoLdD
 v1/JNThVuTZNBYmN9p9AKb5wClvPEMaGBEtiLJsxtfknAFIZKgfFiwNdo
 jHS7I2nHyp/he8rumOuWL3TmyrNeCByjAmQA2msU4St4piniEbtUw2vcz
 qx7rv7P/ByMm9KoAcNqy9uj0b6lNGOurnWfgeDwZ7trOyV9BUKXWBsBJy
 IF7NXhdxGHr+h4E3l3JISTKkgF/XOPo9YvQ6iYJrg7BKz6sy3xFOTc98M w==;
X-CSE-ConnectionGUID: 3L9bzQSEQ7qSW8g72YtzOw==
X-CSE-MsgGUID: 6YnNcuK1RmWjmV3PzFGM2A==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtpat09.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Aug 2025 02:34:41 +0000
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 11 Aug 2025 21:35:35 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwer001.delllabs.net (100.64.0.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Mon, 11 Aug 2025 21:34:40 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.14 via Frontend
 Transport; Mon, 11 Aug 2025 21:34:40 -0500
From: Pravin M Bathija <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <pravin.m.bathija.dev@gmail.com>
Subject: [PATCH 3/3] vhost_user: support for memory regions
Date: Tue, 12 Aug 2025 02:33:58 +0000
Message-ID: <20250812023358.2400020-4-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250812023358.2400020-1-pravin.bathija@dell.com>
References: <20250812023358.2400020-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 suspectscore=0 bulkscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 mlxlogscore=999 clxscore=1015
 spamscore=0 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508120022
X-Proofpoint-ORIG-GUID: BDXsJ7Oag3yagdZ6aInNiznO33HngPtl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDAyMyBTYWx0ZWRfXw2iEVm9QFsrP
 3Lrim4qYj57uqfzBd83YFG09LPmU6L8pJoDMMyMUiD24BCOtlWc6VJTlGOellBkf7oQbJiN6dgl
 QD4hVKLU3L/uwHYq8ftsSBuW/r2EwyQnAcV5pUZ2t8QP+HhckkpZftZ3zRXdi5rvNvjS2dAVvO1
 gdEFtGGh/IcmcB3TmT1FOXpRZvJU4rShX+HVj/9qUJdJKn2YWvhk5T0ZyZoDsns2mtk00YyNHLg
 Qt693Jy0LiMPmZNLqK4S+2xFv1YSm6fSton3JTTyKCbIDlmsD8NaYWsgHdeG1PFOjb0W3l8UEg7
 6kwk3gZvqTAjAc+aiib0QajOYPVnBf/RBGDYENuAWKfke+jR3Mfw3ozpWs0Ri7ELFv/PW223cTE
 RkAgzuodrs1qecvydeePe0M66d16Ls6Ma6Ozja0WC+WqC5zGoyyO/ZZH/sFrtjDFtKOwaMlp
X-Proofpoint-GUID: BDXsJ7Oag3yagdZ6aInNiznO33HngPtl
X-Authority-Analysis: v=2.4 cv=LYs86ifi c=1 sm=1 tr=0 ts=689aa842 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=Vd41IKOgs+CGE2+bDnhSdQ==:17
 a=2OwXVqhp2XgA:10 a=ke5jqHz-1hQA:10 a=iLNU1ar6AAAA:8 a=f_rmseOU4X3KHqvFkaAA:9
 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 impostorscore=0 spamscore=0
 priorityscore=1501 adultscore=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2507300000
 definitions=main-2508120023
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

- modify data structures and add functions to support
  add and remove memory regions/slots
- define VHOST_MEMORY_MAX_NREGIONS & modify function
  vhost_user_set_mem_table accordingly
- dynamically add new memory slots via vhost_user_add_mem_reg
- remove unused memory slots via vhost_user_rem_mem_reg
- define data structure VhostUserSingleMemReg for single
  memory region
- modify data structures VhostUserRequest & VhostUserMsg

Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
---
 lib/vhost/vhost_user.c | 325 +++++++++++++++++++++++++++++++++++------
 lib/vhost/vhost_user.h |  10 ++
 2 files changed, 291 insertions(+), 44 deletions(-)

diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
index b73dec6a22..6367f54b97 100644
--- a/lib/vhost/vhost_user.c
+++ b/lib/vhost/vhost_user.c
@@ -74,6 +74,9 @@ VHOST_MESSAGE_HANDLER(VHOST_USER_SET_FEATURES, vhost_user_set_features, false, t
 VHOST_MESSAGE_HANDLER(VHOST_USER_SET_OWNER, vhost_user_set_owner, false, true) \
 VHOST_MESSAGE_HANDLER(VHOST_USER_RESET_OWNER, vhost_user_reset_owner, false, false) \
 VHOST_MESSAGE_HANDLER(VHOST_USER_SET_MEM_TABLE, vhost_user_set_mem_table, true, true) \
+VHOST_MESSAGE_HANDLER(VHOST_USER_GET_MAX_MEM_SLOTS, vhost_user_get_max_mem_slots, false, false) \
+VHOST_MESSAGE_HANDLER(VHOST_USER_ADD_MEM_REG, vhost_user_add_mem_reg, true, true) \
+VHOST_MESSAGE_HANDLER(VHOST_USER_REM_MEM_REG, vhost_user_rem_mem_reg, true, true) \
 VHOST_MESSAGE_HANDLER(VHOST_USER_SET_LOG_BASE, vhost_user_set_log_base, true, true) \
 VHOST_MESSAGE_HANDLER(VHOST_USER_SET_LOG_FD, vhost_user_set_log_fd, true, true) \
 VHOST_MESSAGE_HANDLER(VHOST_USER_SET_VRING_NUM, vhost_user_set_vring_num, false, true) \
@@ -228,7 +231,17 @@ async_dma_map(struct virtio_net *dev, bool do_map)
 }
 
 static void
-free_mem_region(struct virtio_net *dev)
+free_mem_region(struct rte_vhost_mem_region *reg)
+{
+	if (reg != NULL && reg->host_user_addr) {
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
@@ -239,12 +252,10 @@ free_mem_region(struct virtio_net *dev)
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
 
@@ -258,7 +269,7 @@ vhost_backend_cleanup(struct virtio_net *dev)
 		vdpa_dev->ops->dev_cleanup(dev->vid);
 
 	if (dev->mem) {
-		free_mem_region(dev);
+		free_all_mem_regions(dev);
 		rte_free(dev->mem);
 		dev->mem = NULL;
 	}
@@ -707,7 +718,7 @@ numa_realloc(struct virtio_net **pdev, struct vhost_virtqueue **pvq)
 	vhost_devices[dev->vid] = dev;
 
 	mem_size = sizeof(struct rte_vhost_memory) +
-		sizeof(struct rte_vhost_mem_region) * dev->mem->nregions;
+		sizeof(struct rte_vhost_mem_region) * VHOST_MEMORY_MAX_NREGIONS;
 	mem = rte_realloc_socket(dev->mem, mem_size, 0, node);
 	if (!mem) {
 		VHOST_CONFIG_LOG(dev->ifname, ERR,
@@ -811,8 +822,10 @@ hua_to_alignment(struct rte_vhost_memory *mem, void *ptr)
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
@@ -1250,9 +1263,13 @@ vhost_user_postcopy_register(struct virtio_net *dev, int main_fd,
 	 * retrieve the region offset when handling userfaults.
 	 */
 	memory = &ctx->msg.payload.memory;
-	for (i = 0; i < memory->nregions; i++) {
+	for (i = 0; i < VHOST_MEMORY_MAX_NREGIONS; i++) {
+		int reg_msg_index = 0;
 		reg = &dev->mem->regions[i];
-		memory->regions[i].userspace_addr = reg->host_user_addr;
+		if (reg->host_user_addr == 0)
+			continue;
+		memory->regions[reg_msg_index].userspace_addr = reg->host_user_addr;
+		reg_msg_index++;
 	}
 
 	/* Send the addresses back to qemu */
@@ -1279,8 +1296,10 @@ vhost_user_postcopy_register(struct virtio_net *dev, int main_fd,
 	}
 
 	/* Now userfault register and we can use the memory */
-	for (i = 0; i < memory->nregions; i++) {
+	for (i = 0; i < VHOST_MEMORY_MAX_NREGIONS; i++) {
 		reg = &dev->mem->regions[i];
+		if (reg->host_user_addr == 0)
+			continue;
 		if (vhost_user_postcopy_region_register(dev, reg) < 0)
 			return -1;
 	}
@@ -1385,6 +1404,46 @@ vhost_user_mmap_region(struct virtio_net *dev,
 	return 0;
 }
 
+static int
+vhost_user_initialize_memory(struct virtio_net **pdev)
+{
+	struct virtio_net *dev = *pdev;
+	int numa_node = SOCKET_ID_ANY;
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
@@ -1393,7 +1452,6 @@ vhost_user_set_mem_table(struct virtio_net **pdev,
 	struct virtio_net *dev = *pdev;
 	struct VhostUserMemory *memory = &ctx->msg.payload.memory;
 	struct rte_vhost_mem_region *reg;
-	int numa_node = SOCKET_ID_ANY;
 	uint64_t mmap_offset;
 	uint32_t i;
 	bool async_notify = false;
@@ -1438,39 +1496,13 @@ vhost_user_set_mem_table(struct virtio_net **pdev,
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
@@ -1534,11 +1566,182 @@ vhost_user_set_mem_table(struct virtio_net **pdev,
 	return RTE_VHOST_MSG_RESULT_OK;
 
 free_mem_table:
-	free_mem_region(dev);
+	free_all_mem_regions(dev);
 	rte_free(dev->mem);
 	dev->mem = NULL;
+	rte_free(dev->guest_pages);
+	dev->guest_pages = NULL;
+close_msg_fds:
+	close_msg_fds(ctx);
+	return RTE_VHOST_MSG_RESULT_ERR;
+}
+
+
+static int
+vhost_user_get_max_mem_slots(struct virtio_net **pdev __rte_unused,
+			struct vhu_msg_context *ctx,
+			int main_fd __rte_unused)
+{
+	uint32_t max_mem_slots = VHOST_MEMORY_MAX_NREGIONS;
+
+	ctx->msg.payload.u64 = (uint64_t)max_mem_slots;
+	ctx->msg.size = sizeof(ctx->msg.payload.u64);
+	ctx->fd_num = 0;
 
-free_guest_pages:
+	return RTE_VHOST_MSG_RESULT_REPLY;
+}
+
+static int
+vhost_user_add_mem_reg(struct virtio_net **pdev,
+			struct vhu_msg_context *ctx,
+			int main_fd __rte_unused)
+{
+	struct virtio_net *dev = *pdev;
+	struct VhostUserMemoryRegion *region = &ctx->msg.payload.memory_single.region;
+	uint32_t i;
+
+	/* make sure new region will fit */
+	if (dev->mem != NULL && dev->mem->nregions >= VHOST_MEMORY_MAX_NREGIONS) {
+		VHOST_CONFIG_LOG(dev->ifname, ERR,
+			"too many memory regions already (%u)",
+			dev->mem->nregions);
+		goto close_msg_fds;
+	}
+
+	/* make sure supplied memory fd present */
+	if (ctx->fd_num != 1) {
+		VHOST_CONFIG_LOG(dev->ifname, ERR,
+			"fd count makes no sense (%u)",
+			ctx->fd_num);
+		goto close_msg_fds;
+	}
+
+	/* Make sure no overlap in guest virtual address space */
+	if (dev->mem != NULL && dev->mem->nregions > 0)	{
+		for (uint32_t i = 0; i < VHOST_MEMORY_MAX_NREGIONS; i++) {
+			struct rte_vhost_mem_region *current_region = &dev->mem->regions[i];
+
+			if (current_region->mmap_size == 0)
+				continue;
+
+			uint64_t current_region_guest_start = current_region->guest_user_addr;
+			uint64_t current_region_guest_end = current_region_guest_start
+								+ current_region->mmap_size - 1;
+			uint64_t proposed_region_guest_start = region->userspace_addr;
+			uint64_t proposed_region_guest_end = proposed_region_guest_start
+								+ region->memory_size - 1;
+			bool overlap = false;
+
+			bool current_region_guest_start_overlap =
+				current_region_guest_start >= proposed_region_guest_start
+				&& current_region_guest_start <= proposed_region_guest_end;
+			bool current_region_guest_end_overlap =
+				current_region_guest_end >= proposed_region_guest_start
+				&& current_region_guest_end <= proposed_region_guest_end;
+			bool proposed_region_guest_start_overlap =
+				proposed_region_guest_start >= current_region_guest_start
+				&& proposed_region_guest_start <= current_region_guest_end;
+			bool proposed_region_guest_end_overlap =
+				proposed_region_guest_end >= current_region_guest_start
+				&& proposed_region_guest_end <= current_region_guest_end;
+
+			overlap = current_region_guest_start_overlap
+				|| current_region_guest_end_overlap
+				|| proposed_region_guest_start_overlap
+				|| proposed_region_guest_end_overlap;
+
+			if (overlap) {
+				VHOST_CONFIG_LOG(dev->ifname, ERR,
+					"requested memory region overlaps with another region");
+				VHOST_CONFIG_LOG(dev->ifname, ERR,
+					"\tRequested region address:0x%" PRIx64,
+					region->userspace_addr);
+				VHOST_CONFIG_LOG(dev->ifname, ERR,
+					"\tRequested region size:0x%" PRIx64,
+					region->memory_size);
+				VHOST_CONFIG_LOG(dev->ifname, ERR,
+					"\tOverlapping region address:0x%" PRIx64,
+					current_region->guest_user_addr);
+				VHOST_CONFIG_LOG(dev->ifname, ERR,
+					"\tOverlapping region size:0x%" PRIx64,
+					current_region->mmap_size);
+				goto close_msg_fds;
+			}
+
+		}
+	}
+
+	/* convert first region add to normal memory table set */
+	if (dev->mem == NULL) {
+		if (vhost_user_initialize_memory(pdev) < 0)
+			goto close_msg_fds;
+	}
+
+	/* find a new region and set it like memory table set does */
+	struct rte_vhost_mem_region *reg = NULL;
+	uint64_t mmap_offset;
+
+	for (uint32_t i = 0; i < VHOST_MEMORY_MAX_NREGIONS; i++) {
+		if (dev->mem->regions[i].guest_user_addr == 0) {
+			reg = &dev->mem->regions[i];
+			break;
+		}
+	}
+	if (reg == NULL) {
+		VHOST_CONFIG_LOG(dev->ifname, ERR, "no free memory region");
+		goto close_msg_fds;
+	}
+
+	reg->guest_phys_addr = region->guest_phys_addr;
+	reg->guest_user_addr = region->userspace_addr;
+	reg->size            = region->memory_size;
+	reg->fd              = ctx->fds[0];
+
+	mmap_offset = region->mmap_offset;
+
+	if (vhost_user_mmap_region(dev, reg, mmap_offset) < 0) {
+		VHOST_CONFIG_LOG(dev->ifname, ERR, "failed to mmap region");
+		goto close_msg_fds;
+	}
+
+	dev->mem->nregions++;
+
+	if (dev->async_copy && rte_vfio_is_enabled("vfio"))
+		async_dma_map(dev, true);
+
+	if (vhost_user_postcopy_register(dev, main_fd, ctx) < 0)
+		goto free_mem_table;
+
+	for (i = 0; i < dev->nr_vring; i++) {
+		struct vhost_virtqueue *vq = dev->virtqueue[i];
+
+		if (!vq)
+			continue;
+
+		if (vq->desc || vq->avail || vq->used) {
+			/* vhost_user_lock_all_queue_pairs locked all qps */
+			VHOST_USER_ASSERT_LOCK(dev, vq, VHOST_USER_SET_MEM_TABLE);
+
+			/*
+			 * If the memory table got updated, the ring addresses
+			 * need to be translated again as virtual addresses have
+			 * changed.
+			 */
+			vring_invalidate(dev, vq);
+
+			translate_ring_addresses(&dev, &vq);
+			*pdev = dev;
+		}
+	}
+
+	dump_guest_pages(dev);
+
+	return RTE_VHOST_MSG_RESULT_OK;
+
+free_mem_table:
+	free_all_mem_regions(dev);
+	rte_free(dev->mem);
+	dev->mem = NULL;
 	rte_free(dev->guest_pages);
 	dev->guest_pages = NULL;
 close_msg_fds:
@@ -1546,6 +1749,40 @@ vhost_user_set_mem_table(struct virtio_net **pdev,
 	return RTE_VHOST_MSG_RESULT_ERR;
 }
 
+static int
+vhost_user_rem_mem_reg(struct virtio_net **pdev __rte_unused,
+			struct vhu_msg_context *ctx __rte_unused,
+			int main_fd __rte_unused)
+{
+	struct virtio_net *dev = *pdev;
+	struct VhostUserMemoryRegion *region = &ctx->msg.payload.memory_single.region;
+
+	if (dev->mem != NULL && dev->mem->nregions > 0) {
+		for (uint32_t i = 0; i < VHOST_MEMORY_MAX_NREGIONS; i++) {
+			struct rte_vhost_mem_region *current_region = &dev->mem->regions[i];
+
+			if (current_region->guest_user_addr == 0)
+				continue;
+
+			/*
+			 * According to the vhost-user specification:
+			 * The memory region to be removed is identified by its guest address,
+			 * user address and size. The mmap offset is ignored.
+			 */
+			if (region->userspace_addr == current_region->guest_user_addr
+				&& region->guest_phys_addr == current_region->guest_phys_addr
+				&& region->memory_size == current_region->size) {
+				free_mem_region(current_region);
+				dev->mem->nregions--;
+				return RTE_VHOST_MSG_RESULT_OK;
+			}
+		}
+	}
+
+	VHOST_CONFIG_LOG(dev->ifname, ERR, "failed to find region");
+	return RTE_VHOST_MSG_RESULT_ERR;
+}
+
 static bool
 vq_is_ready(struct virtio_net *dev, struct vhost_virtqueue *vq)
 {
diff --git a/lib/vhost/vhost_user.h b/lib/vhost/vhost_user.h
index ef486545ba..5a0e747b58 100644
--- a/lib/vhost/vhost_user.h
+++ b/lib/vhost/vhost_user.h
@@ -32,6 +32,7 @@
 					 (1ULL << VHOST_USER_PROTOCOL_F_BACKEND_SEND_FD) | \
 					 (1ULL << VHOST_USER_PROTOCOL_F_HOST_NOTIFIER) | \
 					 (1ULL << VHOST_USER_PROTOCOL_F_PAGEFAULT) | \
+					 (1ULL << VHOST_USER_PROTOCOL_F_CONFIGURE_MEM_SLOTS) | \
 					 (1ULL << VHOST_USER_PROTOCOL_F_STATUS))
 
 typedef enum VhostUserRequest {
@@ -67,6 +68,9 @@ typedef enum VhostUserRequest {
 	VHOST_USER_POSTCOPY_END = 30,
 	VHOST_USER_GET_INFLIGHT_FD = 31,
 	VHOST_USER_SET_INFLIGHT_FD = 32,
+	VHOST_USER_GET_MAX_MEM_SLOTS = 36,
+	VHOST_USER_ADD_MEM_REG = 37,
+	VHOST_USER_REM_MEM_REG = 38,
 	VHOST_USER_SET_STATUS = 39,
 	VHOST_USER_GET_STATUS = 40,
 } VhostUserRequest;
@@ -91,6 +95,11 @@ typedef struct VhostUserMemory {
 	VhostUserMemoryRegion regions[VHOST_MEMORY_MAX_NREGIONS];
 } VhostUserMemory;
 
+typedef struct VhostUserSingleMemReg {
+	uint64_t padding;
+	VhostUserMemoryRegion region;
+} VhostUserSingleMemReg;
+
 typedef struct VhostUserLog {
 	uint64_t mmap_size;
 	uint64_t mmap_offset;
@@ -186,6 +195,7 @@ typedef struct __rte_packed_begin VhostUserMsg {
 		struct vhost_vring_state state;
 		struct vhost_vring_addr addr;
 		VhostUserMemory memory;
+		VhostUserSingleMemReg memory_single;
 		VhostUserLog    log;
 		struct vhost_iotlb_msg iotlb;
 		VhostUserCryptoSessionParam crypto_session;
-- 
2.43.0

