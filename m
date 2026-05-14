Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14676CD37AC
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 May 2026 02:03:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DDE1C40661;
	Thu, 14 May 2026 04:02:53 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 643BF4065B
 for <dev@dpdk.org>; Thu, 14 May 2026 04:02:51 +0200 (CEST)
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DFLQuH2613441 for <dev@dpdk.org>; Wed, 13 May 2026 22:02:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=m
 WDwP3z5TqLwgHg7vk5yoV0JMei4Jq72tHkIbZ44ero=; b=PYjHytsLCGDajYh+x
 jEF8vXEmd4f1ORczbdBKRwo5Mzaq+xycAmMG0VzVxuaoZ6NBqL3pV47XsWwDiOC7
 +zvvqlgymqxzs2gR9YnZV4ebOHEswAOOs+l96TF4+yQPMhTts2GFIwyvae+FptGk
 ikaA0O+S58V3HlaNJrcd9GEZQp/0P3yyL4lC142eZji8Wkt2m3cS/wjcFaz6qQzo
 Tfck3CRokw9a6KwErk581Moa6RHmM6RlhmWggzRr9+HzVzv1F2Tuk+ArkpCBwCLn
 3O434e3qmtWaSs0OycgWwE6VyPlYs0EK2pbQFWUfa/PL2n0jQZmmBaGnDUCu0Tik
 bGTmQ==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4e3nv03sww-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 13 May 2026 22:02:49 -0400 (EDT)
Received: from pps.filterd (m0393468.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64E0wojZ1290069 for <dev@dpdk.org>; Wed, 13 May 2026 22:02:49 -0400
Received: from esapsmtplv05.us.dell.com (esapsmtplv05.us.dell.com
 [143.166.203.153])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 4e51aej921-2
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Wed, 13 May 2026 22:02:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1778724169; x=1810260169;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mWDwP3z5TqLwgHg7vk5yoV0JMei4Jq72tHkIbZ44ero=;
 b=ZaJx7h3eCETSyTWInhoZhwIzLrt4Dm9nmkZTZsOx+ZMJtX7S+QbQi9YT
 pV4sivOrV2F1HZgoIX8hNYxR8EJpqI7aJBfClNdb9F2rf56ZEXTDxD1Sj
 IIV04L78TwBcMg75Nt/+piUhfn+P9YboqML4se2yLzEJ/ku1QVq9M5xwu
 D+JwcdASHioeC/9E9OIkTGYJlBJPnIawDCTRAUxgwIMm20o+jjuTyru9Q
 vrabJvxwL+S0w+sMrEvbO6qMRPljUdrfbBQ8HXhUjlqYQzblKpH+i/xp2
 YwnR3tZ8uc7zMbWH7N6SCSDPByRpKpEcAybgPKDmILuLb7Le+a1YgyqVE w==;
X-CSE-ConnectionGUID: Snk1bcu/SAGc1Jw21m6a2Q==
X-CSE-MsgGUID: YGk7JaXqSwaQ6122ZDxwtg==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtplv05.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 May 2026 02:02:48 +0000
Received: from ieorr5-ppwem001.delllabs.net (100.64.0.132) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 13 May 2026 21:04:03 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-ppwem001.delllabs.net (100.64.0.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Wed, 13 May 2026 21:02:47 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Wed, 13 May 2026 21:02:46 -0500
From: <pravin.bathija@dell.com>
To: <dev@dpdk.org>, <fengchengwen@huawei.com>, <stephen@networkplumber.org>,
 <maxime.coquelin@redhat.com>
CC: <pravin.bathija@dell.com>, <thomas@monjalon.net>
Subject: [PATCH v13 3/5] vhost_user: support function defines for back-end
Date: Thu, 14 May 2026 02:01:55 +0000
Message-ID: <20260514020157.1937404-4-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260514020157.1937404-1-pravin.bathija@dell.com>
References: <20260514020157.1937404-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_04,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140018
X-Proofpoint-GUID: K30qzFN60vhilzxoE44GUAhY0sKcBieU
X-Proofpoint-ORIG-GUID: K30qzFN60vhilzxoE44GUAhY0sKcBieU
X-Authority-Analysis: v=2.4 cv=e/A2j6p/ c=1 sm=1 tr=0 ts=6a052d4a cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=t4Iba6VQkoKuxR139xjPXA==:17
 a=NGcC8JguVDcA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=6gNNCFAoQcIphELLPWWu:22 a=aNt9FJNJ8fZyd9HhltU_:22 a=iLNU1ar6AAAA:8
 a=dC6U_BfcRaM5ZE5AslMA:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDAxOCBTYWx0ZWRfX3FqodotW786c
 o5SUQQUOuWQeLeVLc0VGY1zozSG3H+k07edUPzDC/QcYrUZSCq5LlmxTajGwI1VB+cvlzCdWB5n
 J3I81jYONTKQD/SM6R8n/Unq4tbzOE1XcHKAWkuIve30madRjMizFuqB9O2MZoCc8P3osRLGAb5
 nqjYvzLG8IEeK/g8KY1ZItPmtLmEKbUqhD3bi72PiVO4rWV7Ov70n1BiGzz3VxEz1rDgPL5/P+t
 GdT1xkXk0pkAQnHH/UVRL6Iif+591AQf+zLDUosoBMHmnD/2/b3Z4VrtEU8isArqKM/TzNg27Ql
 V+yvmziWTXqLVzEtOvckNwV/5oqBZb7rTNosvDGyAJ9hrA3ZarMYa9HQJ9HUIf/kLCEybbejaQe
 grghjzRj/8bVb2jVO98z9Yuetf9cfCfJOBBLvDRJ71R45rnxmDy+tS830rWfYlSo1k6xQxx7nZv
 cx+aBwSurINbn4QdMeQ==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 clxscore=1015 impostorscore=0 phishscore=0
 priorityscore=1501 spamscore=0
 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605140018
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
perform register copy, align memory addresses and dma map/unmap a
single memory region.

Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
---
 lib/vhost/vhost_user.c | 89 ++++++++++++++++++++++++++++--------------
 1 file changed, 60 insertions(+), 29 deletions(-)

diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
index 4bfb13fb98..0ee3fe7a5e 100644
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
+
+	for (i = 0; i < dev->nr_guest_pages; i++) {
+		struct guest_page *page = &dev->guest_pages[i];
+
+		/* Only process pages belonging to this region */
+		if (page->host_user_addr < reg_start ||
+		    page->host_user_addr >= reg_end)
+			continue;
 
-	if (do_map) {
-		for (i = 0; i < dev->nr_guest_pages; i++) {
-			page = &dev->guest_pages[i];
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
-- 
2.43.0

