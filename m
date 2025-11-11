Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA18CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 11:46:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D5B7040A6B;
	Tue, 11 Nov 2025 12:45:51 +0100 (CET)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 4F6A0406B8
 for <dev@dpdk.org>; Tue, 11 Nov 2025 12:45:50 +0100 (CET)
Received: from pps.filterd (m0170389.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB8wCX3021919
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:45:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=M
 c4QCpwMBqVtdiNplPwTH3P2vImvAyXTK1plkJLgDV0=; b=gzCMSa/nPoA++jftV
 KWyIbyaKEUsveJmfQcB5fOq8VzaayW78i0QUxfsqR56Txjp4SOW72NhspQEIpPkB
 AmS2QwhQ1nHc4cXp6qSChml8DEdATRX62n1ffXszIwMiccihPV4FyptW0Qmtmg/D
 y95a21gKYslKW96a+/Iz+/CDXRHqyXNFsJKKrYsaaueMIAtKI87YsRg+Gn0sg5X3
 04qTX6wsFxF7o0UwHqGc8qCTt9yISKCQQquxGK9tGRaWhfEXHFfOkBkZJTt/K5uh
 JfaVzHMj5hOj3Qefh7uW/u0K/Zzq8Yk7IKXKOH7wfSXEyWCxdIIgue9DIgDptSvB
 tCCnQ==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4aa2rpm020-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:45:49 -0500 (EST)
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB8lnMQ026022
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:45:48 -0500
Received: from esapsmtplv09.us.dell.com (esapsmtplv09.us.dell.com
 [143.166.203.151])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4ac1xphwr9-5
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:45:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1762861548; x=1794397548;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Mc4QCpwMBqVtdiNplPwTH3P2vImvAyXTK1plkJLgDV0=;
 b=A41LpXWbdmTxnwP/PT0bPHf1K4dvkmHdrd7kXbzdCjFg0K4kmVQ0mGOP
 00jbLLuUZskSFrhWFkX2wELxplUN9C/jX1i9j9lD1F4ZLT2boMiCrT53R
 +MZ2f/SBE+qR8A3gR/on2tCFsR4FYwTcZcwA/Y4t/3MMkZLlxDCULIoLS
 Xy6ldDiHuW4RCGqre2Jzzc3d7Wg1ERosiP6exhMTBHFRgLV+qdtLJbdyK
 LMum2TkoMbWJ3fyqd8ZTJjdCt45/KHakoE4Q0sdhFeDbhaJT0vql8+kPk
 uZ/Rbynn/c2V7EsY0MPpaTfykcln+/CdXsbgV0mZd2an1/ZjVtdlKozcp A==;
X-CSE-ConnectionGUID: 7d88B2I7Ska7cuQIZbGxcQ==
X-CSE-MsgGUID: FNM0XiA3T9SFtSVG+pwDKw==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtplv09.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2025 11:45:48 +0000
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 11 Nov 2025 05:46:52 -0600
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwer001.delllabs.net (100.64.0.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 11 Nov 2025 05:45:47 -0600
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.134) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Tue, 11 Nov 2025 05:45:47 -0600
From: Pravin M Bathija <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <pravin.m.bathija.dev@gmail.com>
Subject: [PATCH v4 4/5] vhost_user: Function defs for add/rem mem regions
Date: Tue, 11 Nov 2025 11:45:20 +0000
Message-ID: <20251111114521.2902867-5-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251111114521.2902867-1-pravin.bathija@dell.com>
References: <20251111114521.2902867-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511110068
X-Proofpoint-ORIG-GUID: bUbBHRRPYhbdTW8JI21K8R22W1Aj73eW
X-Proofpoint-GUID: bUbBHRRPYhbdTW8JI21K8R22W1Aj73eW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA3MCBTYWx0ZWRfX2+3RR6eApE5K
 ozdcwxt+xnlwUqR0Thhq5yhRVEo7Ja5uccdV/WRbm8L24H6sGaHh2eVNYIm6oy+hvxYQq3iWgI4
 OuazmRJB+q9iSGMB563h5DP4o9/YbZd5zoS73ZxxORTSMl7eCr8aZcteBD2MFIGYvklT8pylgsB
 RdvJ3blyP3dsZPusz86pJ91WJDWZpRGrCVh5XHBDS/meV/TPJadBm2DAqVcqRAcz1099KRlQ/LV
 6RTZnc/6tg5B3L6UDKIIXjNpCxjoxkRdxpD2tfpc6S+NUAp2DNwolOsveLekrDHGPsknejN+TJX
 cUNEAo5ZQA4y55Er1TsGcGbec6DoKlaOaWPLD9+HyvrGQ3aUbHeY70O9Z6c53EKQVzTm+B/1pXH
 LRrNNDb13vHIgQamkWeeY7wDKnsGcA==
X-Authority-Analysis: v=2.4 cv=UqVu9uwB c=1 sm=1 tr=0 ts=691321ed cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=1BWgYg405ukQaXe9BCXDPw==:17
 a=6UeiqGixMTsA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iLNU1ar6AAAA:8 a=ugkO3PKB39lPgV9XgTsA:9 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080070
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

These changes cover the function definition for add/remove memory
region calls which are invoked on receiving vhost user message from
vhost user front-end (e.g. Qemu). In our case, in addition to testing
with qemu front-end, the testing has also been performed with libblkio
front-end and spdk/dpdk back-end. We did I/O using libblkio based device
driver, to spdk based drives. There are also changes for set_mem_table
and new definition for get memory slots. Our changes optimize the set
memory table call to use common support functions. Message get memory
slots is how the vhost-user front-end queries the vhost-user back-end
about the number of memory slots available to be registered by the
back-end. In addition support function to invalidate vring is also
defined which is used in add/remove memory region functions.

Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
---
 lib/vhost/vhost_user.c | 249 +++++++++++++++++++++++++++++++++++------
 1 file changed, 217 insertions(+), 32 deletions(-)

diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
index 7dc21fe42a..d9cf967ba2 100644
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
@@ -1520,7 +1523,6 @@ vhost_user_set_mem_table(struct virtio_net **pdev,
 	struct virtio_net *dev = *pdev;
 	struct VhostUserMemory *memory = &ctx->msg.payload.memory;
 	struct rte_vhost_mem_region *reg;
-	int numa_node = SOCKET_ID_ANY;
 	uint64_t mmap_offset;
 	uint32_t i;
 	bool async_notify = false;
@@ -1565,39 +1567,13 @@ vhost_user_set_mem_table(struct virtio_net **pdev,
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
@@ -1661,11 +1637,182 @@ vhost_user_set_mem_table(struct virtio_net **pdev,
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
 
-free_guest_pages:
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
+dev_invalidate_vrings(struct virtio_net *dev)
+{
+	uint32_t i;
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
+		}
+	}
+}
+
+static int
+vhost_user_add_mem_reg(struct virtio_net **pdev,
+			struct vhu_msg_context *ctx,
+			int main_fd __rte_unused)
+{
+	uint32_t i;
+	struct virtio_net *dev = *pdev;
+	struct VhostUserMemoryRegion *region = &ctx->msg.payload.memory_single.region;
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
+	if (dev->mem != NULL && dev->mem->nregions > 0)	{
+		for (i = 0; i < VHOST_MEMORY_MAX_NREGIONS; i++) {
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
+				current_region_guest_start >= proposed_region_guest_start &&
+				current_region_guest_start <= proposed_region_guest_end;
+			bool curent_region_guest_end_overlap =
+				current_region_guest_end >= proposed_region_guest_start &&
+				current_region_guest_end <= proposed_region_guest_end;
+			bool proposed_region_guest_start_overlap =
+				proposed_region_guest_start >= current_region_guest_start &&
+				proposed_region_guest_start <= current_region_guest_end;
+			bool proposed_region_guest_end_overlap =
+				proposed_region_guest_end >= current_region_guest_start &&
+				proposed_region_guest_end <= current_region_guest_end;
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
+	/* find a new region and set it like memory table set does */
+	struct rte_vhost_mem_region *reg = NULL;
+
+	for (i = 0; i < VHOST_MEMORY_MAX_NREGIONS; i++) {
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
+	if (vhost_user_mmap_region(dev, reg, region->mmap_offset) < 0) {
+		VHOST_CONFIG_LOG(dev->ifname, ERR, "failed to mmap region");
+		goto close_msg_fds;
+	}
+
+	dev->mem->nregions++;
+
+	if (dev->async_copy && rte_vfio_is_enabled("vfio"))
+		async_dma_map_region(dev, reg, true);
+
+	if (vhost_user_postcopy_register(dev, main_fd, ctx) < 0)
+		goto free_mem_table;
+
+	dev_invalidate_vrings(dev);
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
@@ -1673,6 +1820,44 @@ vhost_user_set_mem_table(struct virtio_net **pdev,
 	return RTE_VHOST_MSG_RESULT_ERR;
 }
 
+static int
+vhost_user_rem_mem_reg(struct virtio_net **pdev __rte_unused,
+			struct vhu_msg_context *ctx __rte_unused,
+			int main_fd __rte_unused)
+{
+	uint32_t i;
+	struct virtio_net *dev = *pdev;
+	struct VhostUserMemoryRegion *region = &ctx->msg.payload.memory_single.region;
+
+	if (dev->mem != NULL && dev->mem->nregions > 0) {
+		for (i = 0; i < VHOST_MEMORY_MAX_NREGIONS; i++) {
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
+				if (dev->async_copy && rte_vfio_is_enabled("vfio"))
+					async_dma_map_region(dev, current_region, false);
+				dev_invalidate_vrings(dev);
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

