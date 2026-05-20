Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EE0CD4F5B
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 02:20:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 799A240A4B;
	Wed, 20 May 2026 04:20:41 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 7B89C406B8
 for <dev@dpdk.org>; Wed, 20 May 2026 04:20:40 +0200 (CEST)
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64JGvEZG4021299 for <dev@dpdk.org>; Tue, 19 May 2026 22:20:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=b
 /NCsnHc/KJsBUbJTtN82gWGdZGyZhqVNiqBFict88Y=; b=QeGYiUZ+mVtl/AyrI
 5YPUVAUqb2eq++IcEbN2VnJBnscmmHkoNUpZdD1mUMb1qxcHwVRdF/O2JzSJjZv1
 x8j+OjWKzekm7HCEVL6QeQEFuyfDI0bwHQJuzEV9/7ABbQ4wIno3olVzRR+nbeFq
 eWbO0MZ+aHytqd5tRdZjB94ySE4jidlJ9Mj86gC22JijJL+SYVT2/nrC7jAS7Q5M
 bUTSSlMlsaKnjVqxkpy8ODVr9t3mXTA+8bjqr5o8tYkKwTY4C8qglg0y68iJFoyW
 pqCGyijHSxCMbEDxCeBrbIo94uLTWNzSvTduwQ6+nE+pMzvgAR9TKolDlKrmUI8a
 E/i1g==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4e6kqqebrj-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 19 May 2026 22:20:39 -0400 (EDT)
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64JNbbG72927618 for <dev@dpdk.org>; Tue, 19 May 2026 22:20:38 -0400
Received: from esapsmtplv06.us.dell.com (esapsmtplv06.us.dell.com
 [143.166.203.146])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4e8x4dvbh9-3
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Tue, 19 May 2026 22:20:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1779243639; x=1810779639;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=b/NCsnHc/KJsBUbJTtN82gWGdZGyZhqVNiqBFict88Y=;
 b=ikdvGt5dm6IkXdGV2JXrbFEinsR5DMxEtaAcxTQi0tCiYlgfWv4t7WBC
 amZp8haM20KrvkapmBpYKvhhcIyzjPCOL3XsKkcMg5aIw138w25RhnlWP
 k8LWtuE3u7B/XFXwmv1I9WuDBEujJFmap2oe2BrGCJ/+atsTIB3SpRhZd
 qWXKFbjoQRa1Noe/NpwpsycTsK2ntQpMfLhO6uZQ6VxCB58uCkhFSPzgb
 DKkuMNvWe8n2EZYmXYgB9eXVbaQA5Y12f1T2iKxgnRqRonqyXsigvkrbB
 bcnO1XXIImK19iKsg9Myn7RFT8dq4ZO01C+mBwkFTFmPq5On5Z7jTuDJa g==;
X-CSE-ConnectionGUID: W7dSG9/vSLy1aexMhePaQQ==
X-CSE-MsgGUID: IeCO/jv+R72pXSvQHAolyA==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtplv06.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 02:20:38 +0000
Received: from ieorr5-ppwem002.delllabs.net (100.64.0.133) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 19 May 2026 21:21:28 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-ppwem002.delllabs.net (100.64.0.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 19 May 2026 21:20:36 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Tue, 19 May 2026 21:20:36 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <fengchengwen@huawei.com>, <stephen@networkplumber.org>,
 <maxime.coquelin@redhat.com>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>, Stephen Hemminger
 <stephen@networkplumber.com>
Subject: [PATCH v14 4/5] vhost: add mem region add/remove handlers
Date: Wed, 20 May 2026 02:20:11 +0000
Message-ID: <20260520022012.243619-5-pravin.bathija@dell.com>
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
X-Authority-Analysis: v=2.4 cv=V8ZNF+ni c=1 sm=1 tr=0 ts=6a0d1a77 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=in+AvElAwLqdjTPPAWhuvg==:17
 a=NGcC8JguVDcA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=aNt9FJNJ8fZyd9HhltU_:22 a=iLNU1ar6AAAA:8
 a=i0EeH86SAAAA:8 a=CPuvAHPoAAAA:8 a=20KFwNOVAAAA:8 a=y_x-AOxrJxw8cToqVuMA:9
 a=hlJyneSgMmFPbskH-t2w:22 a=r6J0Z2L7KMegjY60bkqS:22
X-Proofpoint-ORIG-GUID: KyfqIl7sWy1_1GjNyL2_JbGZqRE3y1Qp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDAxOSBTYWx0ZWRfX3eCorqZb7MlL
 EcrjzfgRJ+OFtkA6BjYqhEHeO9xIy6QbuwcjHLNx1Vao7G/ZKueExjPZCiui7owzn9kXbfw/L6F
 5C569tJ6HOGBmhoAbdSVLX+FWtGdQKX7fGfRG/lZIb1x2H02fGp1WFmNsN+8RYoWm+QuW8dq4vh
 5g8O6ZOnltpayzupHYPd/QFuHWdVg3CZt6HWanuA98N1oNEO+JXzezQkg9q29FMt7mwYnBkAw96
 ox+iTwPLem7uSOQu+6dnkEUV8JO00lZqjloK8UBPKtvKyupuZAVPoLz70sTOtbnhB4abnVoZaUx
 zJwJz59bdMRLPDFYvbfJO/3s1CekWdZ2TQrth7AjVK7ThKSj9ZFnG8FqrMLc1tgFa0LmEk0KPA5
 KosFH8QRt0PTL8n1rWwT5MlIyUaTfexsktbqmb6+5P/3RqkDuPWdQOZxZuBlDfIVK9+1AGfGHA9
 fSI8wUvcYaXwbkKFTZw==
X-Proofpoint-GUID: KyfqIl7sWy1_1GjNyL2_JbGZqRE3y1Qp
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 bulkscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 malwarescore=0
 adultscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200019
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

Add support for VHOST_USER_ADD_MEM_REG, VHOST_USER_REM_MEM_REG and
VHOST_USER_GET_MAX_MEM_SLOTS. Refactor memory initialization into
common helper and add supporting functions for dynamic memory management.

Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
Acked-by: Fengchengwen <fengchengwen@huawei.com>
Reviewed-by: Stephen Hemminger <stephen@networkplumber.com>
Acked-by: Maxime Coquelin <maxime.coquelin@redhat.com>
---
 lib/vhost/vhost_user.c | 255 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 255 insertions(+)

diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
index 94fca8b589..522ba1db82 100644
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
@@ -1591,6 +1612,240 @@ vhost_user_set_mem_table(struct virtio_net **pdev,
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
+	ctx->msg.payload.u64 = max_mem_slots;
+	ctx->msg.size = sizeof(ctx->msg.payload.u64);
+	ctx->fd_num = 0;
+
+	return RTE_VHOST_MSG_RESULT_REPLY;
+}
+
+/*
+ * Invalidate and re-translate all vring addresses after the memory table
+ * has been modified (add/remove region).
+ *
+ * translate_ring_addresses() may call numa_realloc(), which can reallocate
+ * the device structure.  The updated pointer is written back through *pdev
+ * so callers must refresh their local "dev" afterwards: dev = *pdev.
+ */
+static void
+vhost_user_invalidate_vrings(struct virtio_net **pdev)
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
+	vhost_user_invalidate_vrings(pdev); \
+} while (0)
+
+static int
+vhost_user_add_mem_reg(struct virtio_net **pdev,
+			struct vhu_msg_context *ctx,
+			int main_fd __rte_unused)
+{
+	struct VhostUserMemoryRegion *region = &ctx->msg.payload.memreg.region;
+	struct virtio_net *dev = *pdev;
+	uint32_t i;
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
+		struct rte_vhost_mem_region *cur = &dev->mem->regions[i];
+		uint64_t cur_start = cur->guest_user_addr;
+		uint64_t cur_end = cur_start + cur->size - 1;
+		uint64_t new_start = region->userspace_addr;
+		uint64_t new_end = new_start + region->memory_size - 1;
+
+		if (new_end >= cur_start && new_start <= cur_end) {
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
+				cur->guest_user_addr);
+			VHOST_CONFIG_LOG(dev->ifname, ERR,
+				"\tOverlapping region size:0x%" PRIx64,
+				cur->size);
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
+			goto free_new_region_no_dma;
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
+	/* Reply with the back-end's mapping address per vhost-user spec */
+	ctx->msg.payload.memreg.region.userspace_addr = reg->host_user_addr;
+	ctx->msg.size = sizeof(ctx->msg.payload.memreg);
+	ctx->fd_num = 0;
+
+	return RTE_VHOST_MSG_RESULT_REPLY;
+
+free_new_region:
+	if (dev->async_copy && rte_vfio_is_enabled("vfio"))
+		async_dma_map_region(dev, reg, false);
+free_new_region_no_dma:
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
+	struct VhostUserMemoryRegion *region = &ctx->msg.payload.memreg.region;
+	struct virtio_net *dev = *pdev;
+	uint32_t i;
+
+	if (dev->mem == NULL || dev->mem->nregions == 0) {
+		VHOST_CONFIG_LOG(dev->ifname, ERR, "no memory regions to remove");
+		close_msg_fds(ctx);
+		return RTE_VHOST_MSG_RESULT_ERR;
+	}
+
+	if (validate_msg_fds(dev, ctx, 0) != 0)
+		return RTE_VHOST_MSG_RESULT_ERR;
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

