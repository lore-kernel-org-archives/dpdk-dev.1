Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF41C44500
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 07:49:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F17D402E9;
	Thu, 22 Jan 2026 08:49:00 +0100 (CET)
Received: from mx0b-00154904.pphosted.com (mx0b-00154904.pphosted.com
 [148.163.137.20])
 by mails.dpdk.org (Postfix) with ESMTP id 54309402D7
 for <dev@dpdk.org>; Thu, 22 Jan 2026 08:48:58 +0100 (CET)
Received: from pps.filterd (m0170397.ppops.net [127.0.0.1])
 by mx0b-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60LIX2M6027064
 for <dev@dpdk.org>; Thu, 22 Jan 2026 02:48:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=o
 hv0Yu2nLa0f2+ypK5ZigqM8kzr3cVUn059wnSUbawQ=; b=JtGJzVK4nPEiuGc7u
 BPj+4lPVnLQv7/fAbKU16Myi29AhSzFsjSQkneG2Ox15M6kZdY7wA/8F39zG34VE
 DUWC+GXtCF243u5mBdvwxBdz2Nd1v3XdK4snvGg41r1Xh3NIMGLQwaeJRU4OaGWj
 1ZyX/nTITpcy0RRndFgFDTbGpXIzefj/JW1yFfX9s6Auyz1DY5yQWze+q0rU8/yI
 95PvUGssusB886zCsh2/DUWkFqEZHjkZYcMy1qIpzRUF6Wd2Skfa/DR0NaA6pxDE
 UDQt5hiU+BJh/1iQQ4tdIEYeI883UNbOWDgZ/9f9Np520ymEsHeMMvSySQakEDVm
 i3Vww==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0b-00154904.pphosted.com (PPS) with ESMTPS id 4bsyhp47au-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Thu, 22 Jan 2026 02:48:57 -0500 (EST)
Received: from pps.filterd (m0393468.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60M6RfXc017224
 for <dev@dpdk.org>; Thu, 22 Jan 2026 02:48:57 -0500
Received: from esapsmtplv09.us.dell.com (esapsmtplv09.us.dell.com
 [143.166.203.151])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4budb6sq5e-4
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Thu, 22 Jan 2026 02:48:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1769068137; x=1800604137;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ohv0Yu2nLa0f2+ypK5ZigqM8kzr3cVUn059wnSUbawQ=;
 b=QGfcXavuVNFJgckkmne3lPfJmanIzGIR8D2P9kqX7E+hdST/tor586Qm
 t5EosGEuyy35D/x/34t9zL6VBAqcn1Is0BxTY5koNVRez+6wjJozxL/Kn
 YmAAM7FuACXtR+5irmXJ/XtLbR83R4RzUm1/Qpd98M/7iD6eIGfU+KDPY
 Zi6kFm5k1mjSeLSzoXt4NAOCfuXqmZDv8F2OSlkgFEYzIeCL/5t6BZwB0
 EGRUWaqwT2jBjTJ1DI/9zwUb5HnqTljhyDjLJ0xBEvGeo61jK3tqGvaOg
 ndaEnuC2chZB47z8+VA4XvKGiVNeZIO4/aLlTYRwfP0J6qyyzc/V28frK Q==;
X-CSE-ConnectionGUID: oACJyKKOTreXk3QQd823/w==
X-CSE-MsgGUID: uj9jowIyRZquER+qBwG3Gw==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtplv09.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jan 2026 07:48:56 +0000
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 22 Jan 2026 01:49:59 -0600
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-pvwer002.delllabs.net (100.64.0.135) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Thu, 22 Jan 2026 01:48:55 -0600
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Thu, 22 Jan 2026 01:48:55 -0600
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <maxime.coquelin@redhat.com>,
 <fengchengwen@huawei.com>
Subject: [PATCH v6 3/5] vhost_user: support function defines for back-end
Date: Thu, 22 Jan 2026 07:49:04 +0000
Message-ID: <20260122074906.127942-4-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260122074906.127942-1-pravin.bathija@dell.com>
References: <20260122074906.127942-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_04,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 malwarescore=0 phishscore=0
 impostorscore=0 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601220050
X-Proofpoint-ORIG-GUID: R86la-YEcZIDCJRCMo_eV0vmDUYN5JjQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDA1MCBTYWx0ZWRfX1UZRhTy3NgCH
 +27xt9INe/9LywglbNbsulX9xpatoOKQT5dDPyoUwjU84s1gMnyloO7g2eL/wNr14k6jzNvtja+
 pMRSPmYfuTkk1lTFfImGpDgFi1V/cw5/4jDlfr/3RHb0DJeU76WrpLxQKoSqpXcIN85ebKVOtyv
 goTf46hk81oRJUz7EdbfCXo1OyuFY2zllASikC44OutDVw5VWoDh1orCrbQwI8J8uuO1mN1ZAsP
 nYNHoFJ8yo1cuoMOOSzr/gGb0ACbi7BC0hdJjLRziXIxtHZ+bJkagQ5Z7gt2xL4714y4eveHejJ
 RboDhlwtR1mIyFSJrCui90CbaVdJcoN3ougyyqDZukunpY3bh476sWQ2MZofTEwrOgp/GlAReNv
 BdFoRMzoFvH3I9t8n4TFdPRrxouHT5KVZyXd71zF7H+iIkpsNZs9ivhPXfcxxN4B5Dj7IXkTxNs
 5mQ4LMUcFrkLGfYokDg==
X-Authority-Analysis: v=2.4 cv=YJ+SCBGx c=1 sm=1 tr=0 ts=6971d669 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=1BWgYg405ukQaXe9BCXDPw==:17
 a=vUbySO9Y5rIA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iLNU1ar6AAAA:8 a=SW-8F9blc6B0F9nJVP4A:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-GUID: R86la-YEcZIDCJRCMo_eV0vmDUYN5JjQ
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 phishscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 malwarescore=0 spamscore=0 impostorscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601220050
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
memory regions, perform register copy, align memory addresses and
dma map/unmap a single memory region.

Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
---
 lib/vhost/vhost_user.c | 150 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 140 insertions(+), 10 deletions(-)

diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
index 4bfb13fb98..e2831b7625 100644
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
@@ -1246,10 +1330,14 @@ vhost_user_postcopy_register(struct virtio_net *dev, int main_fd,
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

