Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D51B4CD4F21
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 May 2026 02:03:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CF9924066C;
	Thu, 14 May 2026 04:02:54 +0200 (CEST)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id E1C4B402E7
 for <dev@dpdk.org>; Thu, 14 May 2026 04:02:51 +0200 (CEST)
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DHDUc31865424 for <dev@dpdk.org>; Wed, 13 May 2026 22:02:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=6
 pFV5AJCyrLLmhrInodRCUvgEia+Y9ZKLZYqabVdys4=; b=kEtFp3mk3zDNKcJMG
 eZvj1A85sTJvxfogDlg3u6RBgDPl+nOsURpEhWnpBGt7wWQNHO9d6Bu0k7pIzdcO
 thALi/kWYWG9JHT9TlASdXuPlanTR7ezHmiHs/abE2JOPbbQmNVBT4MYODKR9p3f
 Y0BPf74twM4IkC0GP3x0sC6uoWgf/p+UaaLXCwPkdYLSkKCkLKbCGueJQZsfP/+q
 vowJ2uCqceJCG+I4VDWePfoIxROlPwRdGVrHu26+oMW9FmwxFS3Kp6ZrLVy2bFrT
 9S90vCKxvPTkGGWMdpXweFYPMGMy+7/1lIpTefDz+wsJ1Rr4OB5duZ3qcHokA8h9
 uRBXA==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4e3nv0ks7r-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 13 May 2026 22:02:51 -0400 (EDT)
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64E1wqW72149129 for <dev@dpdk.org>; Wed, 13 May 2026 22:02:50 -0400
Received: from esapsmtpat04.us.dell.com (esapsmtpat04.us.dell.com
 [143.166.211.147])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4e54ue0845-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Wed, 13 May 2026 22:02:49 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1778724171; x=1810260171;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6pFV5AJCyrLLmhrInodRCUvgEia+Y9ZKLZYqabVdys4=;
 b=hQza1wd90fUe29RUz+xdOiIznKq5wa5CSu2QwcLh+1F6loGrhknMhXop
 ri+ZHOuYu9zPEGwlzeUN4Fxipjx9GqBKsELajc3tzDtvl0vJ1r3z6FvYV
 9O1a+ZUAetFjNopVwVY5uS8G9E3U3HX4VbVIAUxQBqWv2PX9VwF8fdwMG
 MF/t9AOsGgiS0cKatBjZDVM6e/1PqkFVeNPhIrq7S2Fj9DMDLgb5wGKn9
 /j4lLJioWQV+7k4rwLEVTm/S4NhnXn7scpPLPfZfv+gJ4M3pTQ3WV/mzp
 0KM/0SB5OgE7eMT8AcJvRC43BFiqSQUu5P9yaoduBGKWN0SeVKHjlP2lm Q==;
X-CSE-ConnectionGUID: zWvO2HilT22+ArKJ4M8BVw==
X-CSE-MsgGUID: cYLqXxQRSXOxD6uInDGaEw==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtpat04.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 02:02:50 +0000
Received: from ieorr5-ppwem001.delllabs.net (100.64.0.132) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 13 May 2026 21:03:47 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-ppwem001.delllabs.net (100.64.0.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 13 May 2026 21:02:48 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Wed, 13 May 2026 21:02:48 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <fengchengwen@huawei.com>, <stephen@networkplumber.org>,
 <maxime.coquelin@redhat.com>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>
Subject: [PATCH v13 4/5] vhost_user: Function defs for add/rem mem regions
Date: Thu, 14 May 2026 02:01:56 +0000
Message-ID: <20260514020157.1937404-5-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514020157.1937404-1-pravin.bathija@dell.com>
References: <20260514020157.1937404-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_04,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015
 bulkscore=0 lowpriorityscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140018
X-Proofpoint-GUID: SBG0h0RJNE_pHVVqHPYag-yAn0QoyNim
X-Authority-Analysis: v=2.4 cv=f6h4wuyM c=1 sm=1 tr=0 ts=6a052d4b cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=xQoiRHjKKYbJmV+sD1MyuQ==:17
 a=NGcC8JguVDcA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=vUAfKriDyi6VqHAKCLgX:22 a=iLNU1ar6AAAA:8
 a=poxbFOTwdjnKGPq9lLsA:9 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-ORIG-GUID: SBG0h0RJNE_pHVVqHPYag-yAn0QoyNim
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDAxOCBTYWx0ZWRfX1z8i/pHIZGS6
 Z/TiuUcRLLFeAskgYqtDGbDqn1etRXrLcBHxJb0XXp0wJiWZarX0RfGRFXRT3QouWQooU6YUwFQ
 C0P8NmBZtfPyNnrhoPIL7BdU7+S8LNX8zEmkQ9Dlc82CYH/yf4IkGA0eMvZMUbpedkNcD0nL3p+
 nt5T/u9StskM3bo2H9PUpzflpPxR8evdNMrzCy4s8EAPX58I9Ne1Em0cbutEpbpL32DKkbnv2zN
 LsdJ+xL9WQ++qEO/lYk71OtqBYPxxf0IERYj5aenIwuV+rKSL/z3hQRGV526QaG6yd2kM5OR6vM
 OHVEiE6kFaKNi+TlXMUJQhZ5PmSXHsD7KKzEEKkafKX1liaMqGjBsyVrw4TWGNL8OY0DbCoNWRa
 UDGF11wY9v0llmaJ2q7LasaDWk4D0kE/3ag0WyRbJ4bsxOjrsTK06xhlMzvBDJ3gp/38CM+oRUr
 iBAY0LAjttZIR3L6Gkw==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 phishscore=0
 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140018
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

These changes cover the function definition for add/remove memory
region calls which are invoked on receiving vhost user message from
vhost user front-end (e.g. Qemu). In our case, in addition to testing
with qemu front-end, the testing has also been performed with libblkio
front-end and spdk/dpdk back-end. We did I/O using libblkio based device
driver, to spdk based drives.
There are also changes for set_mem_table and new definition for get memory
slots. Our changes optimize the set memory table call to use common support
functions. A new vhost_user_initialize_memory() function is introduced to
factor out the common memory initialization logic from the function
vhost_user_set_mem_table(), which is now called from both the SET_MEM_TABLE
message handler and the ADD_MEM_REG handler (for the first region).
Message get memory slots is how the vhost-user front-end queries the
vhost-user back-end about the number of memory slots available to be
registered by the back-end. In addition support function to invalidate
vring is also defined which is used in add/remove memory region functions.
The helper function remove_guest_pages is also defined here which is called
from vhost_user_add_mem_reg.

Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
---
 lib/vhost/vhost_user.c | 329 ++++++++++++++++++++++++++++++++++++-----
 1 file changed, 296 insertions(+), 33 deletions(-)

diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
index 0ee3fe7a5e..fdcb7e0158 100644
--- a/lib/vhost/vhost_user.c
+++ b/lib/vhost/vhost_user.c
@@ -71,6 +71,9 @@ VHOST_MESSAGE_HANDLER(VHOST_USER_SET_FEATURES, vhost_user_set_features, false, t
 VHOST_MESSAGE_HANDLER(VHOST_USER_SET_OWNER, vhost_user_set_owner, false, true) \
 VHOST_MESSAGE_HANDLER(VHOST_USER_RESET_OWNER, vhost_user_reset_owner, false, false) \
 VHOST_MESSAGE_HANDLER(VHOST_USER_SET_MEM_TABLE, vhost_user_set_mem_table, true, true) \
+VHOST_MESSAGE_HANDLER(VHOST_USER_GET_MAX_MEM_SLOTS, vhost_user_get_max_mem_slots, false, false) \
+VHOST_MESSAGE_HANDLER(VHOST_USER_ADD_MEM_REG, vhost_user_add_mem_reg, true, true) \
+VHOST_MESSAGE_HANDLER(VHOST_USER_REM_MEM_REG, vhost_user_rem_mem_reg, true, true) \
 VHOST_MESSAGE_HANDLER(VHOST_USER_SET_LOG_BASE, vhost_user_set_log_base, true, true) \
 VHOST_MESSAGE_HANDLER(VHOST_USER_SET_LOG_FD, vhost_user_set_log_fd, true, true) \
 VHOST_MESSAGE_HANDLER(VHOST_USER_SET_VRING_NUM, vhost_user_set_vring_num, false, true) \
@@ -1167,6 +1170,24 @@ add_guest_pages(struct virtio_net *dev, struct rte_vhost_mem_region *reg,
 	return 0;
 }
 
+static void
+remove_guest_pages(struct virtio_net *dev, struct rte_vhost_mem_region *reg)
+{
+	uint64_t reg_start = reg->host_user_addr;
+	uint64_t reg_end = reg_start + reg->size;
+	uint32_t i, j = 0;
+
+	for (i = 0; i < dev->nr_guest_pages; i++) {
+		if (dev->guest_pages[i].host_user_addr >= reg_start &&
+		    dev->guest_pages[i].host_user_addr < reg_end)
+			continue;
+		if (j != i)
+			dev->guest_pages[j] = dev->guest_pages[i];
+		j++;
+	}
+	dev->nr_guest_pages = j;
+}
+
 #ifdef RTE_LIBRTE_VHOST_DEBUG
 /* TODO: enable it only in debug mode? */
 static void
@@ -1413,6 +1434,52 @@ vhost_user_mmap_region(struct virtio_net *dev,
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
@@ -1421,7 +1488,6 @@ vhost_user_set_mem_table(struct virtio_net **pdev,
 	struct virtio_net *dev = *pdev;
 	struct VhostUserMemory *memory = &ctx->msg.payload.memory;
 	struct rte_vhost_mem_region *reg;
-	int numa_node = SOCKET_ID_ANY;
 	uint64_t mmap_offset;
 	uint32_t i;
 	bool async_notify = false;
@@ -1466,39 +1532,13 @@ vhost_user_set_mem_table(struct virtio_net **pdev,
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
@@ -1562,11 +1602,9 @@ vhost_user_set_mem_table(struct virtio_net **pdev,
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
@@ -1574,6 +1612,231 @@ vhost_user_set_mem_table(struct virtio_net **pdev,
 	return RTE_VHOST_MSG_RESULT_ERR;
 }
 
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
+
+	return RTE_VHOST_MSG_RESULT_REPLY;
+}
+
+static void
+_dev_invalidate_vrings(struct virtio_net **pdev)
+{
+	struct virtio_net *dev = *pdev;
+	uint32_t i;
+
+	for (i = 0; i < dev->nr_vring; i++) {
+		struct vhost_virtqueue *vq = dev->virtqueue[i];
+
+		if (!vq)
+			continue;
+
+		if (vq->desc || vq->avail || vq->used) {
+			vq_assert_lock(dev, vq);
+
+			/*
+			 * If the memory table got updated, the ring addresses
+			 * need to be translated again as virtual addresses have
+			 * changed.
+			 */
+			vring_invalidate(dev, vq);
+
+			translate_ring_addresses(&dev, &vq);
+		}
+	}
+
+	*pdev = dev;
+}
+
+/*
+ * Macro wrapper that performs the compile-time lock assertion with the
+ * correct message ID at the call site, then calls the implementation.
+ */
+#define dev_invalidate_vrings(pdev, id) do { \
+	static_assert(id ## _LOCK_ALL_QPS, \
+		#id " handler is not declared as locking all queue pairs"); \
+	_dev_invalidate_vrings(pdev); \
+} while (0)
+
+static int
+vhost_user_add_mem_reg(struct virtio_net **pdev,
+			struct vhu_msg_context *ctx,
+			int main_fd __rte_unused)
+{
+	uint32_t i;
+	struct virtio_net *dev = *pdev;
+	struct VhostUserMemoryRegion *region = &ctx->msg.payload.memreg.region;
+
+	/* convert first region add to normal memory table set */
+	if (dev->mem == NULL) {
+		if (vhost_user_initialize_memory(pdev) < 0)
+			goto close_msg_fds;
+	}
+
+	/* make sure new region will fit */
+	if (dev->mem->nregions >= VHOST_MEMORY_MAX_NREGIONS) {
+		VHOST_CONFIG_LOG(dev->ifname, ERR, "too many memory regions already (%u)",
+									dev->mem->nregions);
+		goto close_msg_fds;
+	}
+
+	/* make sure supplied memory fd present */
+	if (ctx->fd_num != 1) {
+		VHOST_CONFIG_LOG(dev->ifname, ERR, "fd count makes no sense (%u)", ctx->fd_num);
+		goto close_msg_fds;
+	}
+
+	/* Make sure no overlap in guest virtual address space */
+	for (i = 0; i < dev->mem->nregions; i++) {
+		struct rte_vhost_mem_region *current_region = &dev->mem->regions[i];
+		uint64_t current_region_guest_start = current_region->guest_user_addr;
+		uint64_t current_region_guest_end = current_region_guest_start
+							+ current_region->size - 1;
+		uint64_t proposed_region_guest_start = region->userspace_addr;
+		uint64_t proposed_region_guest_end = proposed_region_guest_start
+							+ region->memory_size - 1;
+
+		if (!((proposed_region_guest_end < current_region_guest_start) ||
+			(proposed_region_guest_start > current_region_guest_end))) {
+			VHOST_CONFIG_LOG(dev->ifname, ERR,
+				"requested memory region overlaps with another region");
+			VHOST_CONFIG_LOG(dev->ifname, ERR,
+				"\tRequested region address:0x%" PRIx64,
+				region->userspace_addr);
+			VHOST_CONFIG_LOG(dev->ifname, ERR,
+				"\tRequested region size:0x%" PRIx64,
+				region->memory_size);
+			VHOST_CONFIG_LOG(dev->ifname, ERR,
+				"\tOverlapping region address:0x%" PRIx64,
+				current_region->guest_user_addr);
+			VHOST_CONFIG_LOG(dev->ifname, ERR,
+				"\tOverlapping region size:0x%" PRIx64,
+				current_region->size);
+			goto close_msg_fds;
+		}
+	}
+
+	/* New region goes at the end of the contiguous array */
+	struct rte_vhost_mem_region *reg = &dev->mem->regions[dev->mem->nregions];
+
+	reg->guest_phys_addr = region->guest_phys_addr;
+	reg->guest_user_addr = region->userspace_addr;
+	reg->size            = region->memory_size;
+	reg->fd              = ctx->fds[0];
+	ctx->fds[0]          = -1;
+
+	if (vhost_user_mmap_region(dev, reg, region->mmap_offset) < 0) {
+		VHOST_CONFIG_LOG(dev->ifname, ERR, "failed to mmap region");
+		if (reg->mmap_addr) {
+			/* mmap succeeded but a later step (e.g. add_guest_pages)
+			 * failed; undo the mapping and any guest-page entries.
+			 */
+			remove_guest_pages(dev, reg);
+			free_mem_region(reg);
+		} else {
+			close(reg->fd);
+			reg->fd = -1;
+		}
+		goto close_msg_fds;
+	}
+
+	dev->mem->nregions++;
+
+	if (dev->async_copy && rte_vfio_is_enabled("vfio")) {
+		if (async_dma_map_region(dev, reg, true) < 0)
+			goto free_new_region;
+	}
+
+	if (dev->postcopy_listening) {
+		/*
+		 * Cannot use vhost_user_postcopy_register() here because it
+		 * reads ctx->msg.payload.memory (SET_MEM_TABLE layout), but
+		 * ADD_MEM_REG uses the memreg payload.  Register the
+		 * single new region directly instead.
+		 */
+		if (vhost_user_postcopy_region_register(dev, reg) < 0)
+			goto free_new_region;
+	}
+
+	dev_invalidate_vrings(pdev, VHOST_USER_ADD_MEM_REG);
+	dev = *pdev;
+	dump_guest_pages(dev);
+
+	return RTE_VHOST_MSG_RESULT_OK;
+
+free_new_region:
+	if (dev->async_copy && rte_vfio_is_enabled("vfio"))
+		async_dma_map_region(dev, reg, false);
+	remove_guest_pages(dev, reg);
+	free_mem_region(reg);
+	dev->mem->nregions--;
+close_msg_fds:
+	close_msg_fds(ctx);
+	return RTE_VHOST_MSG_RESULT_ERR;
+}
+
+static int
+vhost_user_rem_mem_reg(struct virtio_net **pdev,
+			struct vhu_msg_context *ctx,
+			int main_fd __rte_unused)
+{
+	uint32_t i;
+	struct virtio_net *dev = *pdev;
+	struct VhostUserMemoryRegion *region = &ctx->msg.payload.memreg.region;
+
+	if (dev->mem == NULL || dev->mem->nregions == 0) {
+		VHOST_CONFIG_LOG(dev->ifname, ERR, "no memory regions to remove");
+		close_msg_fds(ctx);
+		return RTE_VHOST_MSG_RESULT_ERR;
+	}
+
+	for (i = 0; i < dev->mem->nregions; i++) {
+		struct rte_vhost_mem_region *current_region = &dev->mem->regions[i];
+
+		/*
+		 * According to the vhost-user specification:
+		 * The memory region to be removed is identified by its GPA,
+		 * user address and size. The mmap offset is ignored.
+		 */
+		if (region->userspace_addr == current_region->guest_user_addr
+			&& region->guest_phys_addr == current_region->guest_phys_addr
+			&& region->memory_size == current_region->size) {
+			if (dev->async_copy && rte_vfio_is_enabled("vfio"))
+				async_dma_map_region(dev, current_region, false);
+			remove_guest_pages(dev, current_region);
+			free_mem_region(current_region);
+
+			/* Compact the regions array to keep it contiguous */
+			if (i < dev->mem->nregions - 1) {
+				memmove(&dev->mem->regions[i],
+					&dev->mem->regions[i + 1],
+					(dev->mem->nregions - 1 - i) *
+					sizeof(struct rte_vhost_mem_region));
+				memset(&dev->mem->regions[dev->mem->nregions - 1],
+					0, sizeof(struct rte_vhost_mem_region));
+			}
+
+			dev->mem->nregions--;
+			dev_invalidate_vrings(pdev, VHOST_USER_REM_MEM_REG);
+			dev = *pdev;
+			close_msg_fds(ctx);
+			return RTE_VHOST_MSG_RESULT_OK;
+		}
+	}
+
+	VHOST_CONFIG_LOG(dev->ifname, ERR, "failed to find region");
+	close_msg_fds(ctx);
+	return RTE_VHOST_MSG_RESULT_ERR;
+}
+
 static bool
 vq_is_ready(struct virtio_net *dev, struct vhost_virtqueue *vq)
 {
-- 
2.43.0

