Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D44CD6E4D
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 12:43:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7701840E40;
	Thu, 13 Nov 2025 13:43:02 +0100 (CET)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 29D0140E24
 for <dev@dpdk.org>; Thu, 13 Nov 2025 13:43:00 +0100 (CET)
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD5CIYX020173
 for <dev@dpdk.org>; Thu, 13 Nov 2025 07:42:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=A
 P31IwCmlqQourDAmMg45GhqsyeKuGM29ka2YYFNsDM=; b=OppXFgh2m6jtuCzcp
 4Ft9tLgCLKugLuiQhUCYFZ45XSO0Wsi5oPK7bte+avWQEN61+WmMYqH3wryNT9lI
 9DcuptJylt3ZLrh8JMTsaSpxPUSrX4lpZGBBTkB14FwSpTFekwqG7Dekpza9+S2q
 PzvTKuhrp2radPSIuvh7J1Pyi5RMh6ILe//TFMPe0ZEFhJPTuClqOaQKuz/X5N6i
 eZRe9OOVuUJDIZEAcA/mZZS4+IlCzocT/x5I3F5uNokR30KXvuSZc5XxTKLr4XKu
 0N1P5ddohvdfIwXl3KXs+gI8vIhxt0lsgU9CfAKZ9kAu7ss1G7Gzrtt79WvrKfio
 VmXwQ==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4aa1w1s7e4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 13 Nov 2025 07:42:59 -0500 (EST)
Received: from pps.filterd (m0142693.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD9AWjw005488
 for <dev@dpdk.org>; Thu, 13 Nov 2025 07:42:58 -0500
Received: from esapsmtplv06.us.dell.com (esapsmtplv06.us.dell.com
 [143.166.203.146])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4adbn631hd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Thu, 13 Nov 2025 07:42:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1763037778; x=1794573778;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AP31IwCmlqQourDAmMg45GhqsyeKuGM29ka2YYFNsDM=;
 b=otjoyNDBBbX99dKBoeUYj4Q49Ow+DeC8IAca6jzgtsZhdTS+pT+33Eua
 AfSor/tNl+TQ78hxOUHRi/OL6pAbvdqgy0/wCEZIbwZuxpPfl37alx4EG
 pN03+UHclDjJGhjlxJRUunUQPd6MXvkIET6r8wI9px64zOsXv+yNa4Jfd
 rXS2HOvp/A3ywue2K0t/jG1WEKsXcHuhltUzPWJcgrNxBobuRkz0hTVjQ
 UaYufcV3k4Im5FxAUnNpABvDEiB0ctWmObPo+5wcTKpRjxPuz4yDqO6AH
 /yxKgvvs6PBLB6LCWXqGp3I2+xl+UORcB9qUyXtms+ylk1Ab/kLN2ybqX g==;
X-CSE-ConnectionGUID: lk7TSws8TQK4V+rjebx3Pw==
X-CSE-MsgGUID: W+vaZSCPSLOzMEoCztvVYw==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtplv06.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2025 12:42:58 +0000
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 13 Nov 2025 06:43:51 -0600
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwer002.delllabs.net (100.64.0.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 13 Nov 2025 06:42:56 -0600
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.134) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Thu, 13 Nov 2025 06:42:56 -0600
From: Pravin M Bathija <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <pravin.m.bathija.dev@gmail.com>
Subject: [PATCH v5 3/4] vhost_user: support function defines for back-end
Date: Thu, 13 Nov 2025 12:42:09 +0000
Message-ID: <20251113124210.2913846-4-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251113124210.2913846-1-pravin.bathija@dell.com>
References: <20251113124210.2913846-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_02,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511130058
X-Authority-Analysis: v=2.4 cv=a7g9NESF c=1 sm=1 tr=0 ts=6915d253 cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=in+AvElAwLqdjTPPAWhuvg==:17
 a=6UeiqGixMTsA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iLNU1ar6AAAA:8 a=SW-8F9blc6B0F9nJVP4A:9 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-GUID: JVKU2Yf74GdGlUwU7q6NHRFki7CoEquB
X-Proofpoint-ORIG-GUID: JVKU2Yf74GdGlUwU7q6NHRFki7CoEquB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA2MyBTYWx0ZWRfXyqkN8gOtjGbr
 iRKIPsZa0Go2LE53BxnB60tvmIMUqrsyvGToYKdEZtpq7zFEfp8XZM9Y9nOmt0fdWct3bjWQDuQ
 +zXDhgUcAsLl0vZKftD7M0y9YU8d9aekb5tBnoY7VOMvkTXKrNMTV8dwn4sV6q0VFPMow1ZI4nM
 33BTKNn/cIwM1WoSAM3JHptXOQECl7ZntlKDeStCkAI+df5yYv4dQRuuNe/F9MI1DV4wcr5OQty
 6caJBp9hx6rQvtkTvcsJcXYHFHZxsnYi3sV345f3s9Isp+dquHLQwXTuzpIb4hXxhX1aCRHI8uO
 qOwKj6aEvlyvnxVB46siork0wlTCnbaMUzaeNc2YbnQmfP6xJsUE3eyY99O1o3GPHnWW/kJuKWk
 rrJbNkqAG4UFOehs3tsWzrryXfomZA==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080063
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

