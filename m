Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C543CCF9E3
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 11:45:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7E224068A;
	Tue, 11 Nov 2025 12:45:49 +0100 (CET)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id B9EA040696
 for <dev@dpdk.org>; Tue, 11 Nov 2025 12:45:47 +0100 (CET)
Received: from pps.filterd (m0170394.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ABBPnGP013516
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:45:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=A
 P31IwCmlqQourDAmMg45GhqsyeKuGM29ka2YYFNsDM=; b=gi+61w0+jWq/HSzlP
 RZWqdycrTc47bAbsp8xliY+VyZ1n2EXXa0krJcUXjOXKa5yByIUuQmlj5jtWumW0
 VvGB0yTMB4gRBTV+2rFyKOiQ6Py6Hbz2NIlHoxIQ6bT8iET5Gy28LFk9kH1kxyPs
 iWPy1HXlasVpOHHQiA13PmsYxUnt2cQpja/+6nf4uBPfbppiehECU35bQQaQh4g7
 6qc+MvN5CDtqF+Pd19j5rrAzy12Y7mbG0ciyfMMeA4PxccNCm0o5iY6r9gg+6Otz
 qrNTABXTUnQOg7Kyo4cQSCoz8eHY3SqVll1nAYi3zIJKkk3GzFQG5Lyx1Xl105V5
 HW38g==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4aa1a9m6w7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:45:46 -0500 (EST)
Received: from pps.filterd (m0090351.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AB8lnMP026022
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:45:46 -0500
Received: from esapsmtplv09.us.dell.com (esapsmtplv09.us.dell.com
 [143.166.203.151])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4ac1xphwr9-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Tue, 11 Nov 2025 06:45:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1762861546; x=1794397546;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=AP31IwCmlqQourDAmMg45GhqsyeKuGM29ka2YYFNsDM=;
 b=JbGsONT2H7ma7i+N91afHRY9GWE1HNmvlS99FY3s4gupbHLpX7LggriC
 o3snvOGFagf7an5A60VNk0X9LS4IZMnA8/gJXRQC/si8fV9Oy8daNUqpN
 IKl7q8L0smLECwqjTVZYhXi4duWKWB4bb17olDpVrkaB4oyen3wjisyap
 UIz1t8JYaUWrBSJBM33x9mvJVsoSlBKLQg8u9g11dZm/B70A7COmE3aC7
 1Rr5E0LxpdA1Gge8939a2DkIwblzAFEmZo6YVE9M/rhLJGmIWOMaxOHAK
 km1wHhw4USAOrNtIMM4P0Z+UBYnezxTiX8TgEtveWFY5XyvENHSDFu4et w==;
X-CSE-ConnectionGUID: vYtU/CaCT5avJHTiN2pqbA==
X-CSE-MsgGUID: wS/ronClSO6nmXlcv9mU7A==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtplv09.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Nov 2025 11:45:45 +0000
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 11 Nov 2025 05:46:49 -0600
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwer001.delllabs.net (100.64.0.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 11 Nov 2025 05:45:44 -0600
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.134) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Tue, 11 Nov 2025 05:45:44 -0600
From: Pravin M Bathija <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <pravin.m.bathija.dev@gmail.com>
Subject: [PATCH v4 3/5] vhost_user: support function defines for back-end
Date: Tue, 11 Nov 2025 11:45:19 +0000
Message-ID: <20251111114521.2902867-4-pravin.bathija@dell.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA4MDA1NyBTYWx0ZWRfX+PeWqTnheL8x
 v9ARtSuV5R1DgkNtd7pC7AZCqH7da0ndFGKftl1fUGEAmVG+aE7hONWMJ1QkKlZIntT96hrET5H
 0KpVEYjw25+U4VmMPjbXs8Bl5WQlJFek+PN+gJCX4a7RqHW/PFXuKHs3N5buWU4nKuPO4NvhNs9
 86WkzLKrn0uL8y9KEBa51TFzLjhEpfA84UkMHHKaNP8InWLjKm9BoFOm5Thm7jEoUUzgDYjDixR
 slcnNv5koIzGwR9/7GhOpBBnK7P/jLYyoyqLDHMD02H/wLF6pH/83EJbkfNd350Qg2/Ti+rb2c0
 u1NCPBiaxkJD54ugOB89Lo/eGEDRhLwsna75uU9B9A+jdlWMXn0dvulNaAIVmDYJ3V2015Efsd3
 2/CR8Ln4pokOeNBzNMb5xu/g0U/New==
X-Proofpoint-ORIG-GUID: aY0-4Co3fSUpAHh2SN9Y-OIzSTDolon1
X-Authority-Analysis: v=2.4 cv=YPaSCBGx c=1 sm=1 tr=0 ts=691321eb cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=1BWgYg405ukQaXe9BCXDPw==:17
 a=6UeiqGixMTsA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iLNU1ar6AAAA:8 a=SW-8F9blc6B0F9nJVP4A:9 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-GUID: aY0-4Co3fSUpAHh2SN9Y-OIzSTDolon1
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 adultscore=0 malwarescore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 suspectscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511080057
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

