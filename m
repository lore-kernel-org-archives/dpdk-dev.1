Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22507CD13DA
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 05:53:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 79E5B40668;
	Tue,  5 May 2026 07:53:12 +0200 (CEST)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id 8346B40656
 for <dev@dpdk.org>; Tue,  5 May 2026 07:53:10 +0200 (CEST)
Received: from pps.filterd (m0170395.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 644H1POF1341943 for <dev@dpdk.org>; Tue, 5 May 2026 01:53:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=/
 FeDZflF/4MZk0DTUZeZMahh1Hk3nMJXG+PyfYrDcuk=; b=teyuK9VAxBbjQ0Vkj
 ztabKtb9yfS31l7da0nTZE1d/LEcKSWz26GtNhVpRKosj2XvEtLWdowVA8OmVyPN
 b+cOPUsMzHFCOtpHvYYBfPOg0wA0Bh6rfQ2Nn/VtuO0z+21wGgCQmuZWkeb/JE9V
 DFN1QZhBn1bnLM6xeG8UNOgUVAiH6Z7lgfzrpMp+QJ9vxPYuD34jyG84v2R2TmTq
 nWE0+7RFjzSvvwqkQ/2qRHtuJAXiw1B6i/NinQy+aq3OuNLrybepGTjs4Oc70Ctn
 EwamrhNV4m9VefsnR/GVg4ihwVCzJwW778Vk5efNvxQTBvBna5VBM8AlrlIQpRef
 kot8g==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4dwdxfscaj-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 05 May 2026 01:53:09 -0400 (EDT)
Received: from pps.filterd (m0133268.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6455ev5K2342767 for <dev@dpdk.org>; Tue, 5 May 2026 01:53:08 -0400
Received: from esapsmtplv05.us.dell.com (esapsmtplv05.us.dell.com
 [143.166.203.153])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4dxv9nkfcu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Tue, 05 May 2026 01:53:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1777960388; x=1809496388;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/FeDZflF/4MZk0DTUZeZMahh1Hk3nMJXG+PyfYrDcuk=;
 b=IFHOL8rqUB45rVJ0J5mXNRBfnMNcU0l+d0ZQ5y5ULachIthRoLXTGrIe
 QQ5yFUVIFEY8m9X+M+sQj/fCs5U4I7sF9ZnJ+aM+QDSVM1nXFoWybpMrC
 tnmNdAMEjP8s/EjLuW7bk8wL0/iS8XaZ6nGzXBdch42He+PAfEoQYtzDp
 fYdKgUPR1arAyuay7jlxepy0MrL9Hk26Qx/VnlcIEnS7Evk4u7uQInJJs
 nCLJa0Sn8qZLluDNwC4ELPjiyJJudjki3YAoNXf5XCwDysDQ2zifG3AYX
 wp1Utv3i2VP8JOy+E6yijpHlJiF3k4RfFfE/fZXSatXtcD86x8cCb/sxs Q==;
X-CSE-ConnectionGUID: 2gPE5hlsTo+lNqfoOKt1kQ==
X-CSE-MsgGUID: uzp+7AQ/T4yoC3VNrX9M8w==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtplv05.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 May 2026 05:53:08 +0000
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 5 May 2026 00:54:03 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwer002.delllabs.net (100.64.0.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 5 May 2026 00:53:07 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Tue, 5 May 2026 00:53:06 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <stephen@networkplumber.org>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>,
 <maxime.coquelin@redhat.com>, <fengchengwen@huawei.com>
Subject: [PATCH v11 3/5] vhost_user: support function defines for back-end
Date: Tue, 5 May 2026 05:52:49 +0000
Message-ID: <20260505055251.818594-4-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260505055251.818594-1-pravin.bathija@dell.com>
References: <20260505055251.818594-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_01,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 impostorscore=0 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605050052
X-Proofpoint-ORIG-GUID: pBpHFi1ZSRG5UlNkpOJBFsEAgSlLWsUT
X-Authority-Analysis: v=2.4 cv=JvfBas4C c=1 sm=1 tr=0 ts=69f985c5 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=t4Iba6VQkoKuxR139xjPXA==:17
 a=NGcC8JguVDcA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=Qy6CKLcU0MZ4grw4BCWD:22 a=iLNU1ar6AAAA:8
 a=JTeAb9uBdsL_4eQ4YWQA:9 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-GUID: pBpHFi1ZSRG5UlNkpOJBFsEAgSlLWsUT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDA1MiBTYWx0ZWRfXyTq85KLGR+QT
 yI3SiTVDJrRGSnqhmAcKT441xIWYGyHyU9jGWja+iHNma8A4jrKbqHegrK7PtBG0gkcWMKpE7rr
 kBhL8jQGqSikSoya0uNdLIRSlNGJXBaJfF6Rgv8iuca+S2LamelmwXBUBlig928Y7h6CbTFQ+7D
 xo8+cJxUCBLehXvl+ZxZD0f5W6bpzcNu9VBeEgg8+w2V8MHErNIa1cXjgE7vzTDkyjjZuNr5kgF
 9bdWoW/l1iT3HunxazmpZXBjUJInKycn3PiW0LgW2MnSIUfFEGBjt6cfllp0cpIXOwjwm0gfW17
 NZgWWhvq0WT1XWIzYFiD5gpMNItOAX1sOC+9EenYT+HgfavCM+I0ur20bxoH2J6BsYG3P16xjQ6
 O05RjjVWoft4oZaHV3nJgVPS2a+b8DroUgyRia2nvX6qlW2n3asjuMnUXN75Yk1Z8ZSYM73+M1M
 cRxBazXUAsmDh+ZF7vw==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 clxscore=1015
 impostorscore=0 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605050052
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

Here we define support functions which are called from the various
vhost-user back-end message functions like set memory table, get
memory slots, add memory region, remove memory region.  These are
essentially common functions to initialize memory, unmap a set of
memory regions, perform register copy, align memory addresses,
dma map/unmap a single memory region and remove guest pages by
removing all entries belonging to a given memory region.

Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
---
 lib/vhost/vhost_user.c | 146 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 136 insertions(+), 10 deletions(-)

diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
index 4bfb13fb98..1f96ecf963 100644
--- a/lib/vhost/vhost_user.c
+++ b/lib/vhost/vhost_user.c
@@ -171,6 +171,52 @@ get_blk_size(int fd)
 	return ret == -1 ? (uint64_t)-1 : (uint64_t)stat.st_blksize;
 }
 
+static int
+async_dma_map_region(struct virtio_net *dev, struct rte_vhost_mem_region *reg, bool do_map)
+{
+	uint32_t i;
+	int ret;
+	uint64_t reg_start = reg->host_user_addr;
+	uint64_t reg_end = reg_start + reg->size;
+
+	for (i = 0; i < dev->nr_guest_pages; i++) {
+		struct guest_page *page = &dev->guest_pages[i];
+
+		/* Only process pages belonging to this region */
+		if (page->host_user_addr < reg_start ||
+		    page->host_user_addr >= reg_end)
+			continue;
+
+		if (do_map) {
+			ret = rte_vfio_container_dma_map(RTE_VFIO_DEFAULT_CONTAINER_FD,
+					page->host_user_addr,
+					page->host_iova,
+					page->size);
+			if (ret) {
+				if (rte_errno == ENODEV)
+					return 0;
+
+				VHOST_CONFIG_LOG(dev->ifname, ERR, "DMA engine map failed");
+				return -1;
+			}
+		} else {
+			ret = rte_vfio_container_dma_unmap(RTE_VFIO_DEFAULT_CONTAINER_FD,
+					page->host_user_addr,
+					page->host_iova,
+					page->size);
+			if (ret) {
+				if (rte_errno == EINVAL)
+					return 0;
+
+				VHOST_CONFIG_LOG(dev->ifname, ERR, "DMA engine unmap failed");
+				return -1;
+			}
+		}
+	}
+
+	return 0;
+}
+
 static void
 async_dma_map(struct virtio_net *dev, bool do_map)
 {
@@ -225,7 +271,17 @@ async_dma_map(struct virtio_net *dev, bool do_map)
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
@@ -236,12 +292,10 @@ free_mem_region(struct virtio_net *dev)
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
 
@@ -255,7 +309,7 @@ vhost_backend_cleanup(struct virtio_net *dev)
 		vdpa_dev->ops->dev_cleanup(dev->vid);
 
 	if (dev->mem) {
-		free_mem_region(dev);
+		free_all_mem_regions(dev);
 		rte_free(dev->mem);
 		dev->mem = NULL;
 	}
@@ -704,7 +758,7 @@ numa_realloc(struct virtio_net **pdev, struct vhost_virtqueue **pvq)
 	vhost_devices[dev->vid] = dev;
 
 	mem_size = sizeof(struct rte_vhost_memory) +
-		sizeof(struct rte_vhost_mem_region) * dev->mem->nregions;
+		sizeof(struct rte_vhost_mem_region) * VHOST_MEMORY_MAX_NREGIONS;
 	mem = rte_realloc_socket(dev->mem, mem_size, 0, node);
 	if (!mem) {
 		VHOST_CONFIG_LOG(dev->ifname, ERR,
@@ -808,8 +862,10 @@ hua_to_alignment(struct rte_vhost_memory *mem, void *ptr)
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
@@ -1136,6 +1192,24 @@ add_guest_pages(struct virtio_net *dev, struct rte_vhost_mem_region *reg,
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
@@ -1246,10 +1320,14 @@ vhost_user_postcopy_register(struct virtio_net *dev, int main_fd,
 	 * DPDK's virtual address with Qemu, so that Qemu can
 	 * retrieve the region offset when handling userfaults.
 	 */
+	int reg_msg_index = 0;
 	memory = &ctx->msg.payload.memory;
 	for (i = 0; i < memory->nregions; i++) {
 		reg = &dev->mem->regions[i];
-		memory->regions[i].userspace_addr = reg->host_user_addr;
+		if (reg->host_user_addr == 0)
+			continue;
+		memory->regions[reg_msg_index].userspace_addr = reg->host_user_addr;
+		reg_msg_index++;
 	}
 
 	/* Send the addresses back to qemu */
@@ -1278,6 +1356,8 @@ vhost_user_postcopy_register(struct virtio_net *dev, int main_fd,
 	/* Now userfault register and we can use the memory */
 	for (i = 0; i < memory->nregions; i++) {
 		reg = &dev->mem->regions[i];
+		if (reg->host_user_addr == 0)
+			continue;
 		if (vhost_user_postcopy_region_register(dev, reg) < 0)
 			return -1;
 	}
@@ -1382,6 +1462,52 @@ vhost_user_mmap_region(struct virtio_net *dev,
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
-- 
2.43.0

