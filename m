Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72447CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 11:40:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A589040144;
	Tue, 11 Nov 2025 12:40:35 +0100 (CET)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 2A5C440663
 for <dev@dpdk.org>; Tue, 11 Nov 2025 12:40:32 +0100 (CET)
Received: from pps.filterd (m0170393.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB4C19e013931
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:40:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=A
 P31IwCmlqQourDAmMg45GhqsyeKuGM29ka2YYFNsDM=; b=MzyM3/vwhzVW2esUi
 gOWRmvp4Mn4GfVW+crpTtIJ/9kRF0nCFAwjXI+xe5KfZSI9YOx8FbteapT3lHCGz
 due/WbPpOjgKupyGnxjUH1OmPiYk2mAS6aKFeVR8uik9V+IaAIF9opojEcXc8VTI
 MbQNAGt38AwioPSdvaPJHUm6dOqxQSqNm9BorELL60436SxZgbslCoowv23/jNm9
 FYZLG1DNe+ZjDxrU+DP9BsJ62u88eE2mvY70X1rY2CIRsIu1rQ7EBwKq5qXahtDa
 jGUkEvZqT6sffu1bq6dpM+f6i+6vDUFnUWKDpnjbXwegdTiiWF5BQIvctTsGkGxI
 NwAzQ==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4aa22qc3sy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:40:31 -0500 (EST)
Received: from pps.filterd (m0144103.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB6mbIg006861
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:40:30 -0500
Received: from esapsmtplv05.us.dell.com (esapsmtplv05.us.dell.com
 [143.166.203.153])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4abxg348et-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:40:30 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1762861229; x=1794397229;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AP31IwCmlqQourDAmMg45GhqsyeKuGM29ka2YYFNsDM=;
 b=dC0sw7v9iFQW/ZVldIJD24DQVS7Z52Z5gczicL6qxNUomB50t0FS/qMr
 5RXeqsuZqf60jttdhszAeBpnHdbju55qY9WPi3yzLFoBZ/jQJKO5FEIan
 t+InohmOBrduOHoBO6IsMJn/FA/dIcIUDp/+L/9VQrYQVBBG3Y+ne2oEb
 S1FKpTc8La4elrWA4AVy68bxJTEaIKCWEo4XbQ5bCdOrAbrm5KwzcLG6+
 48wm/PKLoPBj/+X+Z5Z+ArTsl8L3SeUBRpz52HvObdoAvoNYrz07ELwEs
 4i9VFNXfGD1LKLuH9T3PID1mfmtA/01OoYdOtQhlqBaSWYnH+17m6rrt2 Q==;
X-CSE-ConnectionGUID: B9CHyCF5Tk6JACymtwtGog==
X-CSE-MsgGUID: b5I2V+92RXuQDWkgLLU/pw==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtplv05.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2025 11:40:27 +0000
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 11 Nov 2025 05:41:20 -0600
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwer002.delllabs.net (100.64.0.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 11 Nov 2025 05:40:27 -0600
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Tue, 11 Nov 2025 05:40:26 -0600
From: Pravin M Bathija <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <pravin.m.bathija.dev@gmail.com>
Subject: [PATCH v4 3/5] vhost_user: support function defines for back-end
Date: Tue, 11 Nov 2025 11:40:00 +0000
Message-ID: <20251111114002.2902696-4-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251111114002.2902696-1-pravin.bathija@dell.com>
References: <20251111114002.2902696-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-11_02,2025-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 malwarescore=0 bulkscore=0 adultscore=0
 impostorscore=0 clxscore=1015 priorityscore=1501 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511110034
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA2NSBTYWx0ZWRfXzEE5jGKZ8UzL
 7GqEGG7GQfajlzySApmX2qbROSnF/i1yx0bfO7EEGVXW+ZNSan5Iqeqb6pNmeRZH96AWNy9xmN1
 P/s/qwNzZv4u1HIZKmIAnnPvPJvj8rwA2deqgvWaLshuSPxHy05qXdG9m/kEcT+u++qF15Ir1eh
 3fqyVKKQhauvfb0jxdBNTjSgBjTrrb3r0Z+kIFXAR9nLW73jo+/ntZWvxqCeg8V3QnBoydCgwDh
 006xMQKsTijhSgWa4JTuq0xT2K3LurZTXFAofQPEfA+69vhZwlyyCzhRUaN08JqSGdhYb9/51Xn
 SnjLPi2y+yLf1o+AVTKSmHL5jlM6iFNceu7c+DxcL22PTi20knOMVQOc58AOJRfMzPwPNzzZ4Vu
 UGH06Oel07h98ZPyo7cpdP4kD8O9xg==
X-Proofpoint-ORIG-GUID: 9F6N2BLsiY2favN-MgDg0zckbfnLjJmE
X-Proofpoint-GUID: 9F6N2BLsiY2favN-MgDg0zckbfnLjJmE
X-Authority-Analysis: v=2.4 cv=BMO+bVQG c=1 sm=1 tr=0 ts=691320af cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=t4Iba6VQkoKuxR139xjPXA==:17
 a=6UeiqGixMTsA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iLNU1ar6AAAA:8 a=SW-8F9blc6B0F9nJVP4A:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 spamscore=0 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 bulkscore=0
 adultscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080065
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

Here we define support functions which are called from the various
vhost-user back-end message functions like set memory table, get
memory slots, add memory region, remove memory region.  These are
essentially common functions to initialize memory, unmap a set of
memory regions, perform register copy, align memory addresses and
dma map/unmap a single memory region.

Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
---
 lib/vhost/vhost_user.c | 150 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 140 insertions(+), 10 deletions(-)

diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
index 4bfb13fb98..7dc21fe42a 100644
--- a/lib/vhost/vhost_user.c
+++ b/lib/vhost/vhost_user.c
@@ -171,6 +171,80 @@ get_blk_size(int fd)
 	return ret == -1 ? (uint64_t)-1 : (uint64_t)stat.st_blksize;
 }
 
+static void
+async_dma_map_region(struct virtio_net *dev, struct rte_vhost_mem_region *reg, bool do_map)
+{
+	uint32_t i;
+	int ret = 0;
+	int found = 0;
+	struct guest_page *page;
+
+	uint64_t reg_size = reg->size;
+	uint64_t host_user_addr  = reg->host_user_addr;
+
+	for (i = 0; i < dev->nr_guest_pages; i++) {
+		page = &dev->guest_pages[i];
+		if (host_user_addr == page->host_user_addr) {
+			found = 1;
+			break;
+		}
+	}
+
+	if (!found) {
+		VHOST_CONFIG_LOG(dev->ifname, ERR, "DMA engine map: region not found");
+		return;
+	}
+
+	if (do_map) {
+		while (reg_size) {
+			page = &dev->guest_pages[i];
+			ret = rte_vfio_container_dma_map(RTE_VFIO_DEFAULT_CONTAINER_FD,
+					page->host_user_addr,
+					page->host_iova,
+					page->size);
+			if (ret) {
+				if (rte_errno == ENODEV)
+					return;
+
+				/* DMA mapping errors won't stop VHOST_USER_SET_MEM_TABLE. */
+				VHOST_CONFIG_LOG(dev->ifname, ERR, "DMA engine map failed");
+			}
+
+			reg_size -= page->size;
+			++i;
+			if (i >= dev->nr_guest_pages) {
+				/* shouldn't get here */
+				VHOST_CONFIG_LOG(dev->ifname, ERR, "DMA engine map: No more pages");
+				return;
+			}
+		}
+	} else {
+		while (reg_size) {
+			page = &dev->guest_pages[i];
+			ret = rte_vfio_container_dma_unmap(RTE_VFIO_DEFAULT_CONTAINER_FD,
+					page->host_user_addr,
+					page->host_iova,
+					page->size);
+			if (ret) {
+				if (rte_errno == EINVAL)
+					return;
+
+				/* DMA mapping errors won't stop VHOST_USER_SET_MEM_TABLE. */
+				VHOST_CONFIG_LOG(dev->ifname, ERR, "DMA engine unmap failed");
+			}
+
+			reg_size -= page->size;
+			++i;
+			if (i >= dev->nr_guest_pages) {
+				/* shouldn't get here */
+				VHOST_CONFIG_LOG(dev->ifname, ERR, "DMA engine unmap: No more pages");
+				return;
+			}
+		}
+	}
+
+}
+
 static void
 async_dma_map(struct virtio_net *dev, bool do_map)
 {
@@ -225,7 +299,17 @@ async_dma_map(struct virtio_net *dev, bool do_map)
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
@@ -236,12 +320,10 @@ free_mem_region(struct virtio_net *dev)
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
 
@@ -255,7 +337,7 @@ vhost_backend_cleanup(struct virtio_net *dev)
 		vdpa_dev->ops->dev_cleanup(dev->vid);
 
 	if (dev->mem) {
-		free_mem_region(dev);
+		free_all_mem_regions(dev);
 		rte_free(dev->mem);
 		dev->mem = NULL;
 	}
@@ -704,7 +786,7 @@ numa_realloc(struct virtio_net **pdev, struct vhost_virtqueue **pvq)
 	vhost_devices[dev->vid] = dev;
 
 	mem_size = sizeof(struct rte_vhost_memory) +
-		sizeof(struct rte_vhost_mem_region) * dev->mem->nregions;
+		sizeof(struct rte_vhost_mem_region) * VHOST_MEMORY_MAX_NREGIONS;
 	mem = rte_realloc_socket(dev->mem, mem_size, 0, node);
 	if (!mem) {
 		VHOST_CONFIG_LOG(dev->ifname, ERR,
@@ -808,8 +890,10 @@ hua_to_alignment(struct rte_vhost_memory *mem, void *ptr)
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
@@ -1248,8 +1332,12 @@ vhost_user_postcopy_register(struct virtio_net *dev, int main_fd,
 	 */
 	memory = &ctx->msg.payload.memory;
 	for (i = 0; i < memory->nregions; i++) {
+		int reg_msg_index = 0;
 		reg = &dev->mem->regions[i];
-		memory->regions[i].userspace_addr = reg->host_user_addr;
+		if (reg->host_user_addr == 0)
+			continue;
+		memory->regions[reg_msg_index].userspace_addr = reg->host_user_addr;
+		reg_msg_index++;
 	}
 
 	/* Send the addresses back to qemu */
@@ -1278,6 +1366,8 @@ vhost_user_postcopy_register(struct virtio_net *dev, int main_fd,
 	/* Now userfault register and we can use the memory */
 	for (i = 0; i < memory->nregions; i++) {
 		reg = &dev->mem->regions[i];
+		if (reg->host_user_addr == 0)
+			continue;
 		if (vhost_user_postcopy_region_register(dev, reg) < 0)
 			return -1;
 	}
@@ -1382,6 +1472,46 @@ vhost_user_mmap_region(struct virtio_net *dev,
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
+		dev->max_guest_pages = VHOST_MEMORY_MAX_NREGIONS;
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
-- 
2.43.0

