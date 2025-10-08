Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8249CAC5BB
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Oct 2025 09:05:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C11740670;
	Wed,  8 Oct 2025 11:05:34 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 6552F4067A
 for <dev@dpdk.org>; Wed,  8 Oct 2025 11:05:32 +0200 (CEST)
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 597Nmxbh014761
 for <dev@dpdk.org>; Wed, 8 Oct 2025 05:05:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=8
 gd3g7DsSGiw/ra4rKvRTJOLg7wvxAfLEz4GAL/rU1w=; b=DD5B/NCe3nCJWVSMU
 d+KLkcM7xdnv90ARHYhJOLCutWHKDWzXNKlBA62v/3gtJl6zm0e38nX12WG6NQ5E
 TcE1M/XWoSIcQOwUjL/nA7Rq1O9VMAHHz7TcntxcqospjR4uSiG6nlCcBt52qsV8
 UnW8h5hrJE6MAMIN8MRycrIWr1MZXYYYSR6lYil3SXT9kQSBHcJBnK3HBpynwB5Y
 rwf5yxoWoAkyiOdq3GSf2/7M9hIsmW/mGrV7GqkxPxCW1YlOdD8WsqUDe23IAxZq
 O9h8OUr3EDuUgCZ5stu61tP5OO9XLYYt25myWdJkyyKQqNhltHVrteKvgSWcPwx0
 otCPA==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 49jxwhs1d8-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 08 Oct 2025 05:05:31 -0400 (EDT)
Received: from pps.filterd (m0144102.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5988KoEt032498
 for <dev@dpdk.org>; Wed, 8 Oct 2025 05:05:30 -0400
Received: from esapsmtplv06.us.dell.com (esapsmtplv06.us.dell.com
 [143.166.203.146])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 49ndqfvkew-5
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Wed, 08 Oct 2025 05:05:30 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1759914330; x=1791450330;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8gd3g7DsSGiw/ra4rKvRTJOLg7wvxAfLEz4GAL/rU1w=;
 b=aUjjh9L5l4pLUTA3BttkLgoiwC7aot/Bbnuuc1+YfRF1En1Haj/WHjIs
 XDIESsejxcC95mMQkLvWVKBCEH5asBPYybujI2k6LBkipabdbvNMZt9uV
 Rn0ZSXMjZSnLAKHoIEPGsEvFt+g7BTWdpVDQIRnntFOfFIM/3n5n9yzp8
 /1d/uEinFNcllxVK86q+/C2W7efN3duu9hf3GEdAeTKdyOrUQhogFEFbv
 /bRg/e+2NPx2gZ6vdg05i5ENNZlud9TpHAS+rq6639YYs248S8LdgKuOT
 +V4WeIhz1eAfa3tbOQoIAGU0BVa3KDO+1Trk6S/WtdpbfvvtPD1hJNnhu A==;
X-CSE-ConnectionGUID: VJDS6MMeTyKE5lqEOB9d+w==
X-CSE-MsgGUID: 5IXU2CrCSGaulk3/7xgBQQ==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtplv06.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2025 09:05:30 +0000
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.34; Wed, 8 Oct 2025 04:06:30 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwer002.delllabs.net (100.64.0.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.34; Wed, 8 Oct 2025 04:05:28 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.34 via Frontend
 Transport; Wed, 8 Oct 2025 04:05:28 -0500
From: Pravin M Bathija <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <pravin.m.bathija.dev@gmail.com>
Subject: [PATCH v2 4/6] vhost: add/remove memory region function defines
Date: Wed, 8 Oct 2025 09:04:42 +0000
Message-ID: <20251008090444.2689652-5-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251008090444.2689652-1-pravin.bathija@dell.com>
References: <20251008090444.2689652-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-08_02,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 lowpriorityscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 adultscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510080003
X-Proofpoint-GUID: 0e8l8_KkXkWmnvt-qbZpJqPp_OcJa3aa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDA1OCBTYWx0ZWRfX3gOu6K0OYwWp
 dxH4yg8ecsAVrAaEiR67C3n6VHqsFOWIxO40zJ0ghDSYamX3Zo8BXp76gaiP0VbdrirgWAx90qS
 U+8ajzUAWf6pUw2Da13AVOxzK1TptdB/vWWzh6x+a+F62CNpNqE+CSfZqaOkcQTZzscaNBhACXd
 uFhgJ3KyZEGh9fJfs9Ud10mi5EnePFaG1wZQjkZAyErcp4c20AR4FVdHYnq+5hRO43IuPnisQ+D
 MxvD12OmWGry9Njv4ygeqpI5L9Wyl4RwWYhdmMdKzemOcEADQJh8+YEQRN+L0GsKKpQG4ysGUX9
 ll2D6JL5phKz83Z2f9keFspgpy45X9KQhnixDcAo11crB0sCjuCy8d0/1y1FyS1hoHXNCDsSWZF
 HvJtYnkd9Q9qYg7kBs4t7bTIL2RANw==
X-Proofpoint-ORIG-GUID: 0e8l8_KkXkWmnvt-qbZpJqPp_OcJa3aa
X-Authority-Analysis: v=2.4 cv=ccTfb3DM c=1 sm=1 tr=0 ts=68e6295b cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=in+AvElAwLqdjTPPAWhuvg==:17
 a=x6icFKpwvdMA:10 a=ke5jqHz-1hQA:10 a=iLNU1ar6AAAA:8 a=jDfnkBUin0Reo7lbszsA:9
 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 lowpriorityscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040058
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

Adding message API support for add/remove memory regions
for vhost-user protocol. A virtio front-end can connect to
vhost-user back-end and add/remove memory regions that the
latter maps into it's address space. Below are the changes
made:
* add/remove memory region function definitions
* corresponding definitions for vhost user message macros
* Tested with SPDK, libblkio and qemu

Signed-off-By: Pravin M Bathija <pravin.bathija@dell.com>
---
 lib/vhost/vhost_user.c | 220 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 218 insertions(+), 2 deletions(-)

diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
index 4bfb13fb98..ac9d24d067 100644
--- a/lib/vhost/vhost_user.c
+++ b/lib/vhost/vhost_user.c
@@ -71,6 +71,9 @@ VHOST_MESSAGE_HANDLER(VHOST_USER_SET_FEATURES, vhost_user_set_features, false, t
 VHOST_MESSAGE_HANDLER(VHOST_USER_SET_OWNER, vhost_user_set_owner, false, true) \
 VHOST_MESSAGE_HANDLER(VHOST_USER_RESET_OWNER, vhost_user_reset_owner, false, false) \
 VHOST_MESSAGE_HANDLER(VHOST_USER_SET_MEM_TABLE, vhost_user_set_mem_table, true, true) \
+VHOST_MESSAGE_HANDLER(VHOST_USER_GET_MAX_MEM_SLOTS, vhost_user_get_max_mem_slots, false, false) \
+VHOST_MESSAGE_HANDLER(VHOST_USER_ADD_MEM_REG, vhost_user_add_mem_reg, true, true) \
+VHOST_MESSAGE_HANDLER(VHOST_USER_REM_MEM_REG, vhost_user_rem_mem_reg, false, true) \
 VHOST_MESSAGE_HANDLER(VHOST_USER_SET_LOG_BASE, vhost_user_set_log_base, true, true) \
 VHOST_MESSAGE_HANDLER(VHOST_USER_SET_LOG_FD, vhost_user_set_log_fd, true, true) \
 VHOST_MESSAGE_HANDLER(VHOST_USER_SET_VRING_NUM, vhost_user_set_vring_num, false, true) \
@@ -1531,11 +1534,182 @@ vhost_user_set_mem_table(struct virtio_net **pdev,
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
+
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
+			bool curent_region_guest_start_overlap =
+				current_region_guest_start >= proposed_region_guest_start
+				&& current_region_guest_start <= proposed_region_guest_end;
+			bool curent_region_guest_end_overlap =
+				current_region_guest_end >= proposed_region_guest_start
+				&& current_region_guest_end <= proposed_region_guest_end;
+			bool proposed_region_guest_start_overlap =
+				proposed_region_guest_start >= current_region_guest_start
+				&& proposed_region_guest_start <= current_region_guest_end;
+			bool proposed_region_guest_end_overlap =
+				proposed_region_guest_end >= current_region_guest_start
+				&& proposed_region_guest_end <= current_region_guest_end;
+
+			overlap = curent_region_guest_start_overlap
+				|| curent_region_guest_end_overlap
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
 
-free_guest_pages:
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
+			VHOST_USER_ASSERT_LOCK(dev, vq, VHOST_USER_ADD_MEM_REG);
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
@@ -1543,6 +1717,48 @@ vhost_user_set_mem_table(struct virtio_net **pdev,
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
+	if ((dev->mem) && (dev->flags & VIRTIO_DEV_VDPA_CONFIGURED)) {
+		struct rte_vdpa_device *vdpa_dev = dev->vdpa_dev;
+
+		if (vdpa_dev && vdpa_dev->ops->dev_close)
+			vdpa_dev->ops->dev_close(dev->vid);
+		dev->flags &= ~VIRTIO_DEV_VDPA_CONFIGURED;
+	}
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
-- 
2.43.0

