Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C02CD4F39
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 May 2026 22:47:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B15DD40661;
	Fri, 15 May 2026 00:46:49 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id DA6AD4064A
 for <dev@dpdk.org>; Fri, 15 May 2026 00:46:47 +0200 (CEST)
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EJ1rVZ3718434 for <dev@dpdk.org>; Thu, 14 May 2026 18:46:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=6
 pFV5AJCyrLLmhrInodRCUvgEia+Y9ZKLZYqabVdys4=; b=VljwIH319v1i4PLpE
 ak8qzPQjeJxhoKj0pOjo5pA67PTk5weSlHW54JAhOnAHChQJrCdEfTD+1v2lDpuc
 ZwVnDwKV5NT7GI7W/DI54nCYRiGOuh16OIEytncc0pwF7gfLBiLeXbU7PswYIJRA
 XM8QLN3neonJwk+0owsV1mkjzfbvPegCDTY8yQBVCNuAYRKuovorNW7Z3QHCqTsg
 Yb8OyV3SXXOwhYjCuGYz/W2g/66GQrpBmId73bxjvJ/sciNCvfUTE9ThYOfqYehR
 hHe816uEl9Ei3jVcy0UlwuXCYUhGNKzStCC822ffmp8NqMU87B1iaSGpiLwJIs8Q
 woDbQ==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4e5m6g8pyq-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 14 May 2026 18:46:46 -0400 (EDT)
Received: from pps.filterd (m0393468.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EMhl3X1523172 for <dev@dpdk.org>; Thu, 14 May 2026 18:46:46 -0400
Received: from esapsmtplv06.us.dell.com (esapsmtplv06.us.dell.com
 [143.166.203.146])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4e5m6paa5d-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Thu, 14 May 2026 18:46:45 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1778798806; x=1810334806;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=6pFV5AJCyrLLmhrInodRCUvgEia+Y9ZKLZYqabVdys4=;
 b=lfDRY97NVuvZxZ/OZlUQM9hjciaZa8u06MiLBTSVN8z6gw31LZroAq7S
 xTzUeaXzzfbo7lmrDNvsGmMEhFqhRpJohlvTbQrYnjaD7R5G9sEjJq2dy
 D2FvWvSGca4X+uujXYH5S2JFSxveV6cI0+NtLig5b2rFFmlstT1A5+gSp
 hn+zX+b915Z79r2BH9g0nXOR0AhYnUldaBmaylaenVprDzVmVPLC6W10m
 c8E+skIDm6nnJE4bFc4WNHVlr1a+uP4dkOrn56RO1hUCSFDQ4Rjalbsor
 4UryjYRiRC3bWY6YPcrKaIZ5ApU8joPCXTPhwtxEzghMKsHZeaJcyIWol Q==;
X-CSE-ConnectionGUID: pe8gLRoeQxOxNHca+mLvQQ==
X-CSE-MsgGUID: jTe6vBd8RLaM6WQ81zOdoQ==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtplv06.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 22:46:45 +0000
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 14 May 2026 17:47:59 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwer001.delllabs.net (100.64.0.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 14 May 2026 17:46:43 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Thu, 14 May 2026 17:46:43 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <fengchengwen@huawei.com>, <stephen@networkplumber.org>,
 <maxime.coquelin@redhat.com>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>
Subject: [PATCH v13 4/5] vhost_user: Function defs for add/rem mem regions
Date: Thu, 14 May 2026 22:46:26 +0000
Message-ID: <20260514224627.2014566-5-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514224627.2014566-1-pravin.bathija@dell.com>
References: <20260514224627.2014566-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_05,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 suspectscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605140223
X-Authority-Analysis: v=2.4 cv=J8OaKgnS c=1 sm=1 tr=0 ts=6a0650d6 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=in+AvElAwLqdjTPPAWhuvg==:17
 a=NGcC8JguVDcA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=aNt9FJNJ8fZyd9HhltU_:22 a=iLNU1ar6AAAA:8
 a=poxbFOTwdjnKGPq9lLsA:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-ORIG-GUID: EEA4QqL-S5IwTDGIZtXZwhZl1l2sMTa1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDIyMyBTYWx0ZWRfXzC6KJerLtEID
 w7icQJTP1wHCg10PI8HlbJ4dqs5e20s3BbQQ0b5wbXgqZ9ZRpn/5XsiXTjIGxL94Jgawqe3kDvZ
 KmNzty1YPY17bov7ypY87RAdZglatRCOHz/yJ2ZdSZ7nrZ/3rkbV99zkAguoeSswClf/UzhSuIp
 EUokGLDUJUETKXqfXYmvK8Op86Mvx9JykeXjc4Om81eRdkQmGmQMxIv4ETlJgdaWbow9ES+HPhh
 Fubi9sK2lGosxYDMLePaD6XnbUnnWziCLNCs8tN7NQIna6kwAr3CgmzMT6BsSibkb/2Q9BW4IKJ
 N6AV4cMtOGEPD4O+9o9RppY58H2Y8zBnVc8zOIin8LUoFszovX4rBGqQ6kKPUQFnGjtbbK8qaCk
 nG70heQ+cGVOEQb8HmsZmkew0oI9Snw+vy7usQT3tgnGgLIi2dOrdmmf0o7eer+Lc/15kh7+Eh0
 qNrvjPYSGuPpg1lXDvg==
X-Proofpoint-GUID: EEA4QqL-S5IwTDGIZtXZwhZl1l2sMTa1
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0
 spamscore=0
 priorityscore=1501 phishscore=0 bulkscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605140223
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

