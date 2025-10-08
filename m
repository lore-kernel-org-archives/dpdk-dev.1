Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E747BCCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Oct 2025 09:05:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C12A940659;
	Wed,  8 Oct 2025 11:05:41 +0200 (CEST)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id EF99940651
 for <dev@dpdk.org>; Wed,  8 Oct 2025 11:05:39 +0200 (CEST)
Received: from pps.filterd (m0170391.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5984HgC4013187
 for <dev@dpdk.org>; Wed, 8 Oct 2025 05:05:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=7
 OR0G/4i9XXJ5NmBLpoliKS7vTA+jZJ2sM9DiFOe/Vo=; b=rHdgFZJ4DZrg3vb79
 RYgYg6MJey7+QumfnWuYU+dMiUG/hhf9xWaKHG9tZaHQRdfgULGgzadWjduVLAYK
 YWsw9/Zq/Us/I+Y45XJLOFl+FmcCAO5fc8AN639bISXM2H/fHzICQb8eR0fFqyP8
 uwkWg21ul6qnmUWoGRPptZz5t/XT1bI96xyzXVg3rfgUg9x6PvbPy7HwBuwC2r3X
 2RLHtdoYPJ0YIsDQIQOT7mspdR+iq2m9jmFGWy7zP1FCVCCwoHuROx8tJhiOMik7
 mRAG6aVhfxqUFFO89KRuiVwsKqwTLeZn+dy3hwKJnn2e2624F+XrPsNaxDCFp9a+
 EApBg==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 49jxqv999y-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Wed, 08 Oct 2025 05:05:38 -0400 (EDT)
Received: from pps.filterd (m0144104.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59894qmH029153
 for <dev@dpdk.org>; Wed, 8 Oct 2025 05:05:37 -0400
Received: from esapsmtplv06.us.dell.com (esapsmtplv06.us.dell.com
 [143.166.203.146])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 49nn0v00d5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Wed, 08 Oct 2025 05:05:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1759914338; x=1791450338;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=7OR0G/4i9XXJ5NmBLpoliKS7vTA+jZJ2sM9DiFOe/Vo=;
 b=ap9f3KmnxrRKEy2kNBvLewyOvZVZVjFppuzt+MoWXGQCppqctdxcAfBB
 xQIBFcUVyNGCbOtJSs6TU35CeMtZQ/qpb9Zp1sK4Wqr7/BDWZmTdA9nCf
 lEYCF8odsDIQLjahdmg89fFL6pD8WHZ5FYd4Y+0IKe+qwQIMH2tcK3Q25
 wjNmZ5ji4//MnKzyPJvGNy4eAbJXhM20PnpHSbXZM/2sttfeY6udND7o5
 PdYuk8nk+N19d3jLRoY26y8C5kqjj1F5aD+ySC4R5oNwiEfDoFfHL5RGZ
 Gf/PfbxPn8HPZecC9gsJwJkdVD4cCNFziUmkyE/cAdgcPxyIGFuGCAbRO A==;
X-CSE-ConnectionGUID: 9SNl47+XRimOwbJSYC4aLg==
X-CSE-MsgGUID: A1NrjSmlSnafw4DZQbXRwQ==
X-LoopCount0: from 10.215.64.30
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx1-adc.dell.com (HELO ieorr5-pvwed001.delllabs.net)
 ([10.215.64.30])
 by esapsmtplv06.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2025 09:05:37 +0000
Received: from ieorr5-ppwem002.delllabs.net (100.64.0.133) by
 ieorr5-pvwed001.delllabs.net (10.215.64.30) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.34; Wed, 8 Oct 2025 04:06:37 -0500
Received: from ieorr5-pvwer002.delllabs.net (100.64.0.135) by
 ieorr5-ppwem002.delllabs.net (100.64.0.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.34; Wed, 8 Oct 2025 04:05:35 -0500
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.135) with Microsoft SMTP Server id 15.2.1544.34 via Frontend
 Transport; Wed, 8 Oct 2025 04:05:34 -0500
From: Pravin M Bathija <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <pravin.m.bathija.dev@gmail.com>
Subject: [PATCH v2 6/6] vhost: changes to function set_mem_table
Date: Wed, 8 Oct 2025 09:04:44 +0000
Message-ID: <20251008090444.2689652-7-pravin.bathija@dell.com>
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
 phishscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 clxscore=1015 priorityscore=1501 bulkscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510080061
X-Proofpoint-ORIG-GUID: Z0D5VjAwpTrOFjTrUA6T4bvPDXAY8Yzv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDA1NyBTYWx0ZWRfX5l7X+9YaYghd
 NlYMMK3c7VxhfXB2HCOUXO7GOSG8Dbk86Kr0yWCNKuciiIjXmAthIV1oJa/q9sRMhJqy7FAuHmf
 z5aN5DtkPB4Ztsiyd0yosmUoZomD93qHe194cxsfVhBmYzNznr/DF1yNYLCChMi+1OOfKnMaVT7
 Ms9iEztUm6T9wCfOWhKENe1ov5sW2I/248CbxJD/tS6OIJYG0N8fgEGDGFCFgfC7ORcI05xQxtH
 WE3k0aEob2equYIkS/akSKl6J8nMC9uxxkMfndUaVPWtfUGPBMrzM28MCG933qeGDXBSLlfwfZe
 ptMaI/QjDm2QB8zle3DTOQKJ7kOk61gzSiK5bkJkTKXtY02aUXKQR9ds5lwvyXr4RoC/n3WzTGs
 nZW3xCjgL6eN/ZY1BqfHPiJOih16Ag==
X-Authority-Analysis: v=2.4 cv=NPvYOk6g c=1 sm=1 tr=0 ts=68e62962 cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=in+AvElAwLqdjTPPAWhuvg==:17
 a=x6icFKpwvdMA:10 a=ke5jqHz-1hQA:10 a=iLNU1ar6AAAA:8 a=G7OA7ENaR-eOf03F510A:9
 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-GUID: Z0D5VjAwpTrOFjTrUA6T4bvPDXAY8Yzv
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 malwarescore=0 priorityscore=1501 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040057
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

* define support function for memory initialization
* modify func vhost_user_set_mem_table to use common
  support function

Signed-off-By: Pravin M Bathija <pravin.bathija@dell.com>
---
 lib/vhost/vhost_user.c | 73 +++++++++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 30 deletions(-)

diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
index 029dc70292..9a85f2fc92 100644
--- a/lib/vhost/vhost_user.c
+++ b/lib/vhost/vhost_user.c
@@ -1401,6 +1401,46 @@ vhost_user_mmap_region(struct virtio_net *dev,
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
@@ -1409,7 +1449,6 @@ vhost_user_set_mem_table(struct virtio_net **pdev,
 	struct virtio_net *dev = *pdev;
 	struct VhostUserMemory *memory = &ctx->msg.payload.memory;
 	struct rte_vhost_mem_region *reg;
-	int numa_node = SOCKET_ID_ANY;
 	uint64_t mmap_offset;
 	uint32_t i;
 	bool async_notify = false;
@@ -1454,39 +1493,13 @@ vhost_user_set_mem_table(struct virtio_net **pdev,
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
-- 
2.43.0

