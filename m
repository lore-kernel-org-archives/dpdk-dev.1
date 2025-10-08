Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C131CCD185
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Oct 2025 09:05:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A93BC40677;
	Wed,  8 Oct 2025 11:05:36 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id 92C7A40678
 for <dev@dpdk.org>; Wed,  8 Oct 2025 11:05:34 +0200 (CEST)
Received: from pps.filterd (m0170390.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5981iobI022271
 for <dev@dpdk.org>; Wed, 8 Oct 2025 05:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=p
 0adgYXJzgpI+2/isGOOJvB3QYE+A2cg7jKfXKDYNdY=; b=FDAlggNeg7+mTpODB
 iZeWI9r6vGA/StKOliYPeOiFTd6C2eL2JvHjPnHSNLf51uCS8AqGegmnXwQJuq3o
 Lsjg7ACDP1xmwnwtCUOAbyeQ58cR91KYG7nJ4w5VGwEVm5Ew5UAUPKpX0MrRrUV6
 gBJ4hJIhNo5voicUerFisaQq9PjhVubCc4kyiJcHwgGDHY2rTB/dWaxqIeqXo57u
 ZXVyWpKHNl/2wsKOjAWu2JMVO8GmXcnJ2cH65bSxmtPva9yo/IiplqR7bJYYKkHW
 m+JA6ee2pAzNjavPx7GZ2CLhQ+YwgQFg/OIer7OgwKZvZagg+w8y8fFjM8W2JIx1
 GAcjA==
Received: from mx0a-00154901.pphosted.com (mx0a-00154901.pphosted.com
 [67.231.149.39])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 49jxn3155a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 08 Oct 2025 05:05:33 -0400 (EDT)
Received: from pps.filterd (m0134746.ppops.net [127.0.0.1])
 by mx0a-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5988QcmU022832
 for <dev@dpdk.org>; Wed, 8 Oct 2025 05:05:33 -0400
Received: from esapsmtplv01.us.dell.com (esapsmtplv01.us.dell.com
 [143.166.203.147])
 by mx0a-00154901.pphosted.com (PPS) with ESMTPS id 49nhjjagu2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Wed, 08 Oct 2025 05:05:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1759914334; x=1791450334;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=p0adgYXJzgpI+2/isGOOJvB3QYE+A2cg7jKfXKDYNdY=;
 b=axjvPoA7UUeXduX7qIqeBir07xFj2IN1/ZvlDL+75m5dKdHYeAOoSmZE
 qsWiUoUDQq0/ZHL3ZYB7tS49ZRUAs/vxQT5vN1te486wo+pHPg60kUGeL
 citxYzOVY4s0MhZ31Prz/Rjxjc3VaA/0GkSjqvC883VvJG1BKahT/VpDY
 Q8ytykvnmQrO10mbrC8QU29/5ai2jdQiP6ZwzHd6CrCOldZIdW/+NnMS9
 prGKcXSRYp5ZKeov9hyfGkkdmgKM1V7YpZLY8UAs45Vb4NrMIjYkGAu5F
 DZjPPCJbPOh1elnAhk+vNtoTzZdnPwLrM9Tn8k1z8UgWfT3XxV+HikvJw Q==;
X-CSE-ConnectionGUID: cWRWjHpbS42aSjMcH6sqYw==
X-CSE-MsgGUID: nfIGov7VRuWp54pQfuwQ+Q==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtplv01.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2025 09:05:33 +0000
Received: from ieorr5-ppwem002.delllabs.net (100.64.0.133) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.34; Wed, 8 Oct 2025 04:06:23 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-ppwem002.delllabs.net (100.64.0.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.34; Wed, 8 Oct 2025 04:05:31 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.34 via Frontend
 Transport; Wed, 8 Oct 2025 04:05:31 -0500
From: Pravin M Bathija <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <pravin.m.bathija.dev@gmail.com>
Subject: [PATCH v2 5/6] vhost: support functions for memory region ops
Date: Wed, 8 Oct 2025 09:04:43 +0000
Message-ID: <20251008090444.2689652-6-pravin.bathija@dell.com>
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
 clxscore=1015 bulkscore=0 suspectscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510080031
X-Proofpoint-ORIG-GUID: RdcjzBMGK6L9dBhbGOGxrbsyUsqVFB15
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDA1NiBTYWx0ZWRfX7prRCbsenU8D
 hJN3CWlKbKAxPaFqMKrK63dhCFuZT5/U7su/Dtlm/4d0ZCS9q52+IwrT8fYvHv/G5cjaC+aKsaG
 ZVCjm+o3ODQ8Yt/DC8PwVNPGaJzluuWzbFZSVTbF69ma51KmvasaULNfgfrxw0tWH7XDbbrD4Cw
 A083zqNoMmdr0PJX8ZhOozktO0SzsrIJjhghljkuBFZ3SWSvY9zripQRu1YX4JfTWeoRxQDIS5e
 pdVRdQf59/QOLJI1SkMChgcZ/vtUcqo8RAkT1TlmkXyAiK5MUiY2rqm4690HJkDgzV2ehzFdj2k
 pIByB2cT08zXjnccpOtXS6PMzuF5oUM9oWhj1z6wDqgddx30vfI8xbY6EFvcVZ9hphhtnDtc06A
 w7RWQdtMy/1F9SBpL9ZOu8mUKLtHgw==
X-Proofpoint-GUID: RdcjzBMGK6L9dBhbGOGxrbsyUsqVFB15
X-Authority-Analysis: v=2.4 cv=SJdPlevH c=1 sm=1 tr=0 ts=68e6295d cx=c_pps
 a=j0++y401J6f/BxNAf5EDow==:117 a=L/h6WUVEnF1aJ0/14Ndw0A==:17
 a=x6icFKpwvdMA:10 a=ke5jqHz-1hQA:10 a=iLNU1ar6AAAA:8 a=xzHcH1BZNjzZOcjurbEA:9
 a=gbU3OgOOxF9bX48Letew:22
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040056
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

* define supporting function free_mem_region
* changes to other support functions

Signed-off-By: Pravin M Bathija <pravin.bathija@dell.com>
---
 lib/vhost/vhost_user.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
index ac9d24d067..029dc70292 100644
--- a/lib/vhost/vhost_user.c
+++ b/lib/vhost/vhost_user.c
@@ -228,7 +228,17 @@ async_dma_map(struct virtio_net *dev, bool do_map)
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
@@ -239,12 +249,10 @@ free_mem_region(struct virtio_net *dev)
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
 
@@ -258,7 +266,7 @@ vhost_backend_cleanup(struct virtio_net *dev)
 		vdpa_dev->ops->dev_cleanup(dev->vid);
 
 	if (dev->mem) {
-		free_mem_region(dev);
+		free_all_mem_regions(dev);
 		rte_free(dev->mem);
 		dev->mem = NULL;
 	}
@@ -707,7 +715,7 @@ numa_realloc(struct virtio_net **pdev, struct vhost_virtqueue **pvq)
 	vhost_devices[dev->vid] = dev;
 
 	mem_size = sizeof(struct rte_vhost_memory) +
-		sizeof(struct rte_vhost_mem_region) * dev->mem->nregions;
+		sizeof(struct rte_vhost_mem_region) * VHOST_MEMORY_MAX_NREGIONS;
 	mem = rte_realloc_socket(dev->mem, mem_size, 0, node);
 	if (!mem) {
 		VHOST_CONFIG_LOG(dev->ifname, ERR,
@@ -811,8 +819,10 @@ hua_to_alignment(struct rte_vhost_memory *mem, void *ptr)
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
@@ -1250,9 +1260,13 @@ vhost_user_postcopy_register(struct virtio_net *dev, int main_fd,
 	 * retrieve the region offset when handling userfaults.
 	 */
 	memory = &ctx->msg.payload.memory;
-	for (i = 0; i < memory->nregions; i++) {
+	for (i = 0; i < VHOST_MEMORY_MAX_NREGIONS; i++) {
+		int reg_msg_index = 0;
 		reg = &dev->mem->regions[i];
-		memory->regions[i].userspace_addr = reg->host_user_addr;
+		if (reg->host_user_addr == 0)
+			continue;
+		memory->regions[reg_msg_index].userspace_addr = reg->host_user_addr;
+		reg_msg_index++;
 	}
 
 	/* Send the addresses back to qemu */
@@ -1279,8 +1293,10 @@ vhost_user_postcopy_register(struct virtio_net *dev, int main_fd,
 	}
 
 	/* Now userfault register and we can use the memory */
-	for (i = 0; i < memory->nregions; i++) {
+	for (i = 0; i < VHOST_MEMORY_MAX_NREGIONS; i++) {
 		reg = &dev->mem->regions[i];
+		if (reg->host_user_addr == 0)
+			continue;
 		if (vhost_user_postcopy_region_register(dev, reg) < 0)
 			return -1;
 	}
-- 
2.43.0

