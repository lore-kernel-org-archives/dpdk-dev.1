Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8658CC6B19
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Apr 2026 07:38:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DE8D40E0F;
	Thu,  2 Apr 2026 09:38:11 +0200 (CEST)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id EA7B940DFD
 for <dev@dpdk.org>; Thu,  2 Apr 2026 09:38:09 +0200 (CEST)
Received: from pps.filterd (m0170398.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6323wp5Q992259 for <dev@dpdk.org>; Thu, 2 Apr 2026 03:38:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=b
 v2P5nBfTjC9V46FrXJAvTrwsmKIOIuOJ9eMQJ4iySo=; b=voUAg0zYu+jufEU1U
 k2jiw48LKb32KUiO8aY4B3VFbYwaWouv3gLw0ICLjhD+ngre36JhkenQZq0dwli7
 +/brK8VKBHMfZlkhBwl8cXxfEwEXgIVixSGJ4viR21rdFZmjoXMGSX7ETtwsIV2F
 DO5qADvPLPEniTUiClr+9FTgah+0mpQNuzYjlbJaHziszFTzZKA7z3FlrgliiNKv
 czXkd9COb3BSHlGtuJtSJx2HgAiWKhUrEIXUCNIdk5SYRQHPROqlwoTkNoZs+gHH
 GaEDhgzpqBhjupxPH/PTEgTpdRqO4AkohVLjJj3H7gAPHMaDI2R2ybRxgcfzFyHP
 Tdvqg==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4d6a75qgkc-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 02 Apr 2026 03:38:09 -0400 (EDT)
Received: from pps.filterd (m0393468.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6327ITtD1929896 for <dev@dpdk.org>; Thu, 2 Apr 2026 03:38:08 -0400
Received: from esapsmtplv04.us.dell.com (esapsmtplv04.us.dell.com
 [143.166.203.152])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4d9j689gpr-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Thu, 02 Apr 2026 03:38:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1775115489; x=1806651489;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=bv2P5nBfTjC9V46FrXJAvTrwsmKIOIuOJ9eMQJ4iySo=;
 b=ok3AuNkZ+2CHcB4m2nxI+T3EsJoyyL6Epf4gohcm6RKyjnVRw0OK8swX
 E+tLEExTQYp36KMo6Vvmccu1dIm5FfofC8UrCjQ2JDH4NQzhb5Tq0y+F/
 8rw5AJzF/NDQsAq83j5EWkU5WHId6+x+U5wAvJH0J+tBGffYfkl+OWgES
 hPURCjvnRo3mV3m8OwoLjM0OhV6ZAh3WOQfE4M/mGF1vgkFUrHcSoAOJU
 Yh1gNTarGaeN1HA1K5SPkYFjruZnI6CX2bipvsxnI4Vs9ZLHc+hNDKRb7
 bWnHIFd/jbBdgG+Mer0KUog7TJ20dDOn2JkAfhx9SngfVN0FZfbGdxuu+ w==;
X-CSE-ConnectionGUID: 8k3uK2E1SvWW907af9Ahfg==
X-CSE-MsgGUID: 8YCCAdIPSDesklC+bcwV5Q==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtplv04.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 07:38:08 +0000
Received: from ieorr5-ppwem002.delllabs.net (100.64.0.133) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 2 Apr 2026 02:39:10 -0500
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-ppwem002.delllabs.net (100.64.0.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 2 Apr 2026 02:38:06 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.134) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Thu, 2 Apr 2026 02:38:06 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <stephen@networkplumber.org>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>,
 <maxime.coquelin@redhat.com>, <fengchengwen@huawei.com>
Subject: [PATCH 3/5] vhost_user: support function defines for back-end
Date: Thu, 2 Apr 2026 07:38:01 +0000
Message-ID: <20260402073803.3068147-4-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402073803.3068147-1-pravin.bathija@dell.com>
References: <20260402073803.3068147-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-02_01,2026-04-02_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020066
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAyMDA2NiBTYWx0ZWRfX7KmQs3dHUwu/
 aU+VdLAoAkR111XCCH1EQbiamdqsL50sqBKEtpR76Iz5A8KtzdB2eXNMnGZL2vD4c/J7+uapeCy
 rryt8qt2yioO0QYEwFuHyU0TH1wNc50/Uay0Zr7R+znLSSh53xr4HSQJAWpgldStsjA/rvInQCd
 7i/6fxA3ZG2co7ewEQ6Dz6htTlL45AhZd1aqCErKM58Zjs11Xy/ltmHK3xtVc4OnAbggaSZ8I9R
 9XNFXG5NbWpQyWLMIY5zc0ZVuoG1Xb8+XmcdvqbhBmTZ5hkNVQeqjtMna8WhutDl6I88pi62tRt
 8nBPzZDGEX7Iig+cyXq0Z5iPu8hehQ70rDtpQ03RTO1wcMzGSHoIhhGnAScDMsYvU88+FLTw7Y7
 fC8CLqWqiz2fhjYcIgWZNq2rMResOnAlRKPueaFynp1ass9cHh3sduFYz6VVsmceQTFM7LwfHnJ
 FFP+xbrFV/4X+cmMnDQ==
X-Proofpoint-GUID: QajspPzTb7hAMWtOJdZmSh7XMh2SnEzx
X-Proofpoint-ORIG-GUID: QajspPzTb7hAMWtOJdZmSh7XMh2SnEzx
X-Authority-Analysis: v=2.4 cv=FJEWBuos c=1 sm=1 tr=0 ts=69ce1ce1 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=XtseytAk/c9oG0Kwoj6KRQ==:17
 a=A5OVakUREuEA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=vUAfKriDyi6VqHAKCLgX:22 a=iLNU1ar6AAAA:8
 a=JTeAb9uBdsL_4eQ4YWQA:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 clxscore=1015
 suspectscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604020066
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
index 4bfb13fb98..e2eb1c8f4a 100644
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

