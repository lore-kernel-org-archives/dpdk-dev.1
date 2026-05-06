Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE2ACD342F
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 03:38:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD8D840A77;
	Wed,  6 May 2026 05:38:07 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 2194940698
 for <dev@dpdk.org>; Wed,  6 May 2026 05:38:05 +0200 (CEST)
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 645LCrZk3837903 for <dev@dpdk.org>; Tue, 5 May 2026 23:38:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=u
 VcZgybWJbApU9E/UkpUmwigk1vMIsWsV4BPQxkUptc=; b=FeGGQT14SWKFbWn68
 iK+a+TS9eDXqulvbRvIaG2CnSNTEKXBGKGbDqBE/sIc+QKsxu1stcbTmdTxXJJL8
 aDXFXiujxBSA9gsz7og3VdDsl+rDVvgQGLzL7eqOqyXmSiH/3J0t/0jJd+K+sQOk
 DmVPfbxiupQOK6ceVnO8w+Zo0X0HR0KU4SrlYNARpk/JkK0NcOhK8NVLNx8kkH6S
 V4sIM+XM67/AFXpLGtkDYd/w79kLLsJg1JGc9Yy8f++SKARZqGvhjICFKk5cUJYK
 N1Aodf3PZSnI8+v+8fKZb8j4q7nTvocziFVJSzqukterdd/HT5ahAwQOQGxzccEa
 EZLhg==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4dwcdqxcuu-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 05 May 2026 23:38:05 -0400 (EDT)
Received: from pps.filterd (m0142699.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6462hcft3888484 for <dev@dpdk.org>; Tue, 5 May 2026 23:38:04 -0400
Received: from esapsmtpat07.us.dell.com (esapsmtpat07.us.dell.com
 [143.166.211.149])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4dyw3n8h48-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Tue, 05 May 2026 23:38:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1778038685; x=1809574685;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uVcZgybWJbApU9E/UkpUmwigk1vMIsWsV4BPQxkUptc=;
 b=FNH2tsumCnCE3vJhuAzKyzYCYMf28IH+1pKvUUJ7qChNerc90FggeBi3
 OBjtyHnPyjinrpoF/b1YVwHd80nOYcgDLhdHsPX97JV8pxF4o0qZnDja4
 1l3ZwzfxT01eoTbeIqg0eaCZA+u+NoDCljkq1LFbE0quTlw/x4Rrm8gKA
 5M0FnC2tlMVKkR9muEMaO5phlmjLPLXPZCYIz8hkR3JGeKaW2vhrCvoBt
 6fni8bDBFL5M6Iwg0vsdJiEyNeDILuK+0a4wGkPf3SqevPdORGznBvbwc
 QPtIreizrp4u0zjtTiWIqCIAkoqbdJ9dKrCOplkr6fLmEY+o2HHsy18zJ Q==;
X-CSE-ConnectionGUID: YCitzKqgQWWQH4Od0FxEWg==
X-CSE-MsgGUID: ItoWvijASA2by3INO4qqLA==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtpat07.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 May 2026 03:38:04 +0000
Received: from ieorr5-ppwem002.delllabs.net (100.64.0.133) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 5 May 2026 22:39:14 -0500
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-ppwem002.delllabs.net (100.64.0.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Tue, 5 May 2026 22:38:02 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.134) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Tue, 5 May 2026 22:38:02 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <stephen@networkplumber.org>, <maxime.coquelin@redhat.com>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>, <fengchengwen@huawei.com>
Subject: [PATCH v12 3/5] vhost_user: support function defines for back-end
Date: Wed, 6 May 2026 03:37:31 +0000
Message-ID: <20260506033733.972952-4-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506033733.972952-1-pravin.bathija@dell.com>
References: <20260506033733.972952-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 phishscore=0 bulkscore=0 spamscore=0
 adultscore=0 malwarescore=0 lowpriorityscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605060032
X-Proofpoint-ORIG-GUID: 1Uxc9OzR_BwDZP6ZVlNNJIOcffxtqIfJ
X-Authority-Analysis: v=2.4 cv=AsfeGu9P c=1 sm=1 tr=0 ts=69fab79d cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=vdbZnCXtvJht7X5WT7bgSg==:17
 a=NGcC8JguVDcA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=aNt9FJNJ8fZyd9HhltU_:22 a=iLNU1ar6AAAA:8
 a=rtqCUH0kNuOzz8fJ7tYA:9 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDAzMiBTYWx0ZWRfXwjMVcf+k6FmO
 S7HX/HZqpf876XK8+hOdbxdaD8Po3lVg+UbRQTUKnJoHPaQvWMXkjgF8hr3GGnb0dCTvFFQwlTb
 o5p9lSEnm6jTGqR8rcGHmRBTvAR8adSeH4qmz6rRTJMZcwgWq/94fM4NURIpfWipo4cT2frTpf3
 HIHp8nHNAdQ5mZfHCJBJHcF7JDHPP6BMo8E1HY7KucrJj21Of9NaTqfTvD4n53EK/U8nmklz9RE
 ntIZScgN8jLuvP2ExgApmIM3aL3kpNYtBS2MlVhvzDRrNTO2DXLu7OpvSqpTWNlRc7QJeFmR4wE
 E9W9bbzbV49l7ox4/fq04Oj9/cbi3nKZrajBi8ucQyueicUL0dNCr1VlJagpkrWo2SRnRAgZvDF
 l9heE16Urea61JdBUEEktsxSbNxss3dIWeHFlIPOvBWdor8cBCHSdOPl9ASCoOf6rfSAkVCwzsn
 kzdHWMwysXQx//qvANA==
X-Proofpoint-GUID: 1Uxc9OzR_BwDZP6ZVlNNJIOcffxtqIfJ
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2604200000
 definitions=main-2605060032
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
essentially common functions to unmap a set of memory regions,
perform register copy, align memory addresses, dma map/unmap a
single memory region and remove guest pages by removing all
entries belonging to a given memory region.

Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
---
 lib/vhost/vhost_user.c | 107 ++++++++++++++++++++++++++++++-----------
 1 file changed, 78 insertions(+), 29 deletions(-)

diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
index 4bfb13fb98..9f1abb1842 100644
--- a/lib/vhost/vhost_user.c
+++ b/lib/vhost/vhost_user.c
@@ -171,20 +171,27 @@ get_blk_size(int fd)
 	return ret == -1 ? (uint64_t)-1 : (uint64_t)stat.st_blksize;
 }
 
-static void
-async_dma_map(struct virtio_net *dev, bool do_map)
+static int
+async_dma_map_region(struct virtio_net *dev, struct rte_vhost_mem_region *reg, bool do_map)
 {
-	int ret = 0;
 	uint32_t i;
-	struct guest_page *page;
+	int ret;
+	uint64_t reg_start = reg->host_user_addr;
+	uint64_t reg_end = reg_start + reg->size;
 
-	if (do_map) {
-		for (i = 0; i < dev->nr_guest_pages; i++) {
-			page = &dev->guest_pages[i];
+	for (i = 0; i < dev->nr_guest_pages; i++) {
+		struct guest_page *page = &dev->guest_pages[i];
+
+		/* Only process pages belonging to this region */
+		if (page->host_user_addr < reg_start ||
+		    page->host_user_addr >= reg_end)
+			continue;
+
+		if (do_map) {
 			ret = rte_vfio_container_dma_map(RTE_VFIO_DEFAULT_CONTAINER_FD,
-							 page->host_user_addr,
-							 page->host_iova,
-							 page->size);
+					page->host_user_addr,
+					page->host_iova,
+					page->size);
 			if (ret) {
 				/*
 				 * DMA device may bind with kernel driver, in this case,
@@ -199,33 +206,57 @@ async_dma_map(struct virtio_net *dev, bool do_map)
 				 * normal case in async path. This is a workaround.
 				 */
 				if (rte_errno == ENODEV)
-					return;
+					return 0;
 
 				/* DMA mapping errors won't stop VHOST_USER_SET_MEM_TABLE. */
 				VHOST_CONFIG_LOG(dev->ifname, ERR, "DMA engine map failed");
+				return -1;
 			}
-		}
-
-	} else {
-		for (i = 0; i < dev->nr_guest_pages; i++) {
-			page = &dev->guest_pages[i];
+		} else {
 			ret = rte_vfio_container_dma_unmap(RTE_VFIO_DEFAULT_CONTAINER_FD,
-							   page->host_user_addr,
-							   page->host_iova,
-							   page->size);
+					page->host_user_addr,
+					page->host_iova,
+					page->size);
 			if (ret) {
 				/* like DMA map, ignore the kernel driver case when unmap. */
 				if (rte_errno == EINVAL)
-					return;
+					return 0;
 
 				VHOST_CONFIG_LOG(dev->ifname, ERR, "DMA engine unmap failed");
+				return -1;
 			}
 		}
 	}
+
+	return 0;
+}
+
+static void
+async_dma_map(struct virtio_net *dev, bool do_map)
+{
+	uint32_t i;
+	struct rte_vhost_mem_region *reg;
+
+	for (i = 0; i < VHOST_MEMORY_MAX_NREGIONS; i++) {
+		reg = &dev->mem->regions[i];
+		if (reg->host_user_addr == 0)
+			continue;
+		async_dma_map_region(dev, reg, do_map);
+	}
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
@@ -236,12 +267,10 @@ free_mem_region(struct virtio_net *dev)
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
 
@@ -255,7 +284,7 @@ vhost_backend_cleanup(struct virtio_net *dev)
 		vdpa_dev->ops->dev_cleanup(dev->vid);
 
 	if (dev->mem) {
-		free_mem_region(dev);
+		free_all_mem_regions(dev);
 		rte_free(dev->mem);
 		dev->mem = NULL;
 	}
@@ -704,7 +733,7 @@ numa_realloc(struct virtio_net **pdev, struct vhost_virtqueue **pvq)
 	vhost_devices[dev->vid] = dev;
 
 	mem_size = sizeof(struct rte_vhost_memory) +
-		sizeof(struct rte_vhost_mem_region) * dev->mem->nregions;
+		sizeof(struct rte_vhost_mem_region) * VHOST_MEMORY_MAX_NREGIONS;
 	mem = rte_realloc_socket(dev->mem, mem_size, 0, node);
 	if (!mem) {
 		VHOST_CONFIG_LOG(dev->ifname, ERR,
@@ -808,8 +837,10 @@ hua_to_alignment(struct rte_vhost_memory *mem, void *ptr)
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
@@ -1136,6 +1167,24 @@ add_guest_pages(struct virtio_net *dev, struct rte_vhost_mem_region *reg,
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
-- 
2.43.0

