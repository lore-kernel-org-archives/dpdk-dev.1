Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B52CCCFA00
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 04:22:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A2A4340613;
	Tue,  4 Nov 2025 05:22:58 +0100 (CET)
Received: from mx0a-00154904.pphosted.com (mx0a-00154904.pphosted.com
 [148.163.133.20])
 by mails.dpdk.org (Postfix) with ESMTP id C5BC440430
 for <dev@dpdk.org>; Tue,  4 Nov 2025 05:22:56 +0100 (CET)
Received: from pps.filterd (m0170392.ppops.net [127.0.0.1])
 by mx0a-00154904.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A425Rlu019141
 for <dev@dpdk.org>; Mon, 3 Nov 2025 23:22:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dell.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=smtpout1; bh=O
 KLdNQaiT/OsMOU/lCXPcRNoZHN3fbsmuzUTRAZ11qI=; b=DphOp66xCn0XAqvTz
 Iu6QkaPQkuKtedMjgSnTfiar32fXGDoYsi9PB4TT7+DUdA+4G3vSRaE1dMJlw8q2
 lX7N9VZjsYP+LdkA+ddRG5B/LP5S0i10/asrbintW3n9DR5Y1pUjn/YeejsnaQFD
 rBamFpBGfvj1YLQnvIxyP7snYe4W8iQvh+ow/mbFhuwa2kcIK7KthzTtgOBBIFdH
 sdlcuSj34eImcNYcj+Tzqwv0GkBCcC6gTGkILctsVFJNqwei+w8dd1FIiAp1QZHh
 kNeH71VIdPxc4M9x3CuBG6QcMsTAHFYHsJm71SOakcRft9QP4vkgshvKdl5tUKyT
 Hgu6Q==
Received: from mx0b-00154901.pphosted.com (mx0b-00154901.pphosted.com
 [67.231.157.37])
 by mx0a-00154904.pphosted.com (PPS) with ESMTPS id 4a5dc8u84r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 03 Nov 2025 23:22:55 -0500 (EST)
Received: from pps.filterd (m0089483.ppops.net [127.0.0.1])
 by mx0b-00154901.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A42pQGN002808
 for <dev@dpdk.org>; Mon, 3 Nov 2025 23:22:54 -0500
Received: from esapsmtpat09.us.dell.com (esapsmtpat09.us.dell.com
 [143.166.211.151])
 by mx0b-00154901.pphosted.com (PPS) with ESMTPS id 4a78dh9759-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <dev@dpdk.org>; Mon, 03 Nov 2025 23:22:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dell.com; i=@dell.com; q=dns/txt; s=smtpdev1;
 t=1762230174; x=1793766174;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=OKLdNQaiT/OsMOU/lCXPcRNoZHN3fbsmuzUTRAZ11qI=;
 b=GBS7gIHngkz2qW2phu/EXNP/v/lFnh3CZGw1lfUSIkL4jI9S3HLVNOF7
 y9y9FNLMX/KrmYKXpItGyH+QR6BytH0Icw270yVogI2f7XkMsO09NtZxa
 WhtN2oBiQQFiNT87qAdsMvFW4w3M/CPMb1um/a4YmTSBCD6fdB06KkPIg
 os3kGQ0eANii+7Yl33frDVfdgyF+DZS6AJrxlKmJ+5fT4nk/3txDOf808
 cip8I/DtTriIE2pCboKrV9OydNpJSemu6zvCBQx+Br1VYYSBgkPqs2+NG
 jPbwEycsrhyaCSh4tiQBvBQiSNoSDK4Flhidfo3d8IYrJ+rExvjSAERkW w==;
X-CSE-ConnectionGUID: hTgCpHQYTQy062Zg5fyYew==
X-CSE-MsgGUID: xn9w45aTT4a0kss+Eysk0w==
X-LoopCount0: from 10.215.64.31
X-MS-Exchange-CrossPremises-AuthAs: Internal
Received: from mx2-adc.dell.com (HELO ieorr5-pvwed002.delllabs.net)
 ([10.215.64.31])
 by esapsmtpat09.us.dell.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2025 04:22:54 +0000
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwed002.delllabs.net (10.215.64.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 3 Nov 2025 22:23:43 -0600
Received: from ieorr5-pvwer001.delllabs.net (100.64.0.134) by
 ieorr5-pvwer001.delllabs.net (100.64.0.134) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 3 Nov 2025 22:22:53 -0600
Received: from localhost (10.240.17.25) by smtprelay.delllabs.net
 (100.64.0.134) with Microsoft SMTP Server id 15.2.1544.36 via Frontend
 Transport; Mon, 3 Nov 2025 22:22:53 -0600
From: Pravin M Bathija <pravin.bathija@dell.com>
To: <dev@dpdk.org>
CC: <pravin.bathija@dell.com>, <pravin.m.bathija.dev@gmail.com>
Subject: [PATCH v3 4/5] vhost_user: support function defines for back-end
Date: Tue, 4 Nov 2025 04:21:40 +0000
Message-ID: <20251104042142.2787631-5-pravin.bathija@dell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251104042142.2787631-1-pravin.bathija@dell.com>
References: <20251104042142.2787631-1-pravin.bathija@dell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511040016
X-Proofpoint-GUID: aZ7MF_86Wk8mEYgCOrWdEclUSBe7PqlM
X-Proofpoint-ORIG-GUID: aZ7MF_86Wk8mEYgCOrWdEclUSBe7PqlM
X-Authority-Analysis: v=2.4 cv=D+hK6/Rj c=1 sm=1 tr=0 ts=69097f9f cx=c_pps
 a=Z2e5DKjA+8LiMDv5v6mwwA==:117 a=Vd41IKOgs+CGE2+bDnhSdQ==:17
 a=6UeiqGixMTsA:10 a=ke5jqHz-1hQA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iLNU1ar6AAAA:8 a=dC6U_BfcRaM5ZE5AslMA:9 a=hlJyneSgMmFPbskH-t2w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDA1NiBTYWx0ZWRfX7BdXk33NSBB9
 TPS1FupJE1vFEVQKaKF/1BDgeH9ThbrLPwIhd/pL2QwvUzOOBcCKaRoZuW2gyMrvQFV7P7izrsY
 jx/N7XBuc/BfgldLv+MazBCXyTQHH25EpoR3jNIdmdvWcLikHlx76c4yeTnqht94B+yNI+0qyN8
 3LGG8deWkSk4E7V2wZItpcZ2GZmkAnX5wK/s5P6t9xmFVIo8XErpTDP/c9Uzr6WtjUkEKLb7PLk
 qR/Ukg8nAVIa6FK3HcVEW2wssC4loRFxgZTBwNTTVtenUpGgKeS5Xw905JgTACWJAlvWkIStjR9
 pwvwfhqO2ObyZQkfVTuG4+hPklJRoR0dDDV3UoqwOy1NWaB38lgGHB143PXDJnXIr4hIEK1F3xv
 mQx/Wo0TNu9fMiBD3RR1Tn4pBphqvw==
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010056
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
essetially common functions to initialize memory, unmap a set of
memory regions, perform register copy and align memory addresses.

Signed-off-by: Pravin M Bathija <pravin.bathija@dell.com>
---
 lib/vhost/vhost_user.c | 80 +++++++++++++++++++++++++++++++++++-------
 1 file changed, 68 insertions(+), 12 deletions(-)

diff --git a/lib/vhost/vhost_user.c b/lib/vhost/vhost_user.c
index 168432e7d1..9a85f2fc92 100644
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
@@ -1385,6 +1401,46 @@ vhost_user_mmap_region(struct virtio_net *dev,
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
-- 
2.43.0

