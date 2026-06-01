Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4936CD6E60
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 10:16:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 35D6240651;
	Mon,  1 Jun 2026 12:16:33 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id E073F4064E
 for <dev@dpdk.org>; Mon,  1 Jun 2026 12:16:31 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64VKsAGD907080 for <dev@dpdk.org>; Mon, 1 Jun 2026 03:16:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=s
 WuSgc9OBLI/MaTKIv/OOHD6QuhB3QqNhjSUJ3KIrl4=; b=M68cdOsa2bUk01cS0
 yiCvlz2Eii8x13yJXy4DlXyEOBnvUmU8vI7JbxBQ9aNRv4/EILBEpY7CciYWtODJ
 jH7Vir18GeOUcBRJhFsMSFATrl4kMkwbVLA8K1OAO5tZiegi1ZpTaZUgzPQfodJD
 KMgzEREbQ3UzatSQmxaiCtLzRVzPxuW6SWnWuyXnei2Vi7oD5+m8ukrwSEx5Jqxi
 nJ6YWTmIamq2OfZdS62OoUH3z/sJYWoVS7E16Ywpziu2op2tA+bHjAuGwE0VyuPA
 OLyH/wAwpaInBb1SrvP3/xmRi+JUBFsZ6zLelT5rzy56R3MbUrkVNDQfMNQXAoFE
 Qgr0w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4efw8hwng0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 01 Jun 2026 03:16:30 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 1 Jun 2026 03:16:29 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 1 Jun 2026 03:16:29 -0700
Received: from localhost.localdomain (unknown [10.28.34.29])
 by maili.marvell.com (Postfix) with ESMTP id BED3E3F7053;
 Mon,  1 Jun 2026 03:16:27 -0700 (PDT)
From: Shijith Thotton <sthotton@marvell.com>
To: Gowrishankar Muthukrishnan <gmuthukrishn@marvell.com>, "Vidya Sagar
 Velumuri" <vvelumuri@marvell.com>
CC: <dev@dpdk.org>, Vamsi Attunuru <vattunuru@marvell.com>, Shijith Thotton
 <sthotton@marvell.com>
Subject: [PATCH v1 1/2] dma/odm: support dev to mem transfers
Date: Mon, 1 Jun 2026 15:45:58 +0530
Message-ID: <20260601101559.1925302-2-sthotton@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260601101559.1925302-1-sthotton@marvell.com>
References: <20260601101559.1925302-1-sthotton@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDEwMyBTYWx0ZWRfX9ZuUvA0h1nrX
 48wFRzJMuI3OUEqBw2/Nr/Xif0XBPdDXlFQ50i7pUXC25SmPjEZgAVMdKFv08ljJQw9ZxgorYF+
 GbuG79r4NkJW1wLyy6x7EjaPhZYsxSSI3jaaA8Rri46LU4KefF/S5Lj+aBTpqUywUbib0Ec74XW
 JUaszwnF7baDXr5i+on7rpcs34W0euQRODmETYq1qYO/qTtojO91zAgIjuZVlIl3NNaJ9yIlKbH
 1AT2C6VGegckxK2h/JAqfJKi8dLQyTgyl5rEtb76UsDERCiIzJ5dYXgrqyeG3iYRNhPKXB4zogY
 WGU0t2oZ7xa/ma5mOjLtI+4G/q62cMfgz4b3q/ljlbwpFF5nSS8QaAT8eJUk0UWL5i7MS8d6z7g
 2gVyJaUI21k0GTpFQEy1CNeAqlbq/+Xg7omb27W89PgBO3/mwSpt4e5GDE6GgD3Q+NmXmMVGkD+
 PRmAzoBdXKebVlx6Nrw==
X-Proofpoint-GUID: c9OEwRR5DIzr_1OMk8ULTZh_igYLc6ix
X-Proofpoint-ORIG-GUID: c9OEwRR5DIzr_1OMk8ULTZh_igYLc6ix
X-Authority-Analysis: v=2.4 cv=F99nsKhN c=1 sm=1 tr=0 ts=6a1d5bfe cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=h8DYODR3TwfFqvYiSY4A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_03,2026-05-28_03,2025-10-01_01
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

From: Vamsi Attunuru <vattunuru@marvell.com>

Adds support for dev to mem and mem to dev
DMA transfers.

Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
Signed-off-by: Shijith Thotton <sthotton@marvell.com>
---
 drivers/dma/odm/odm.c        | 51 ++++++++++++++++++++++++++++++++++--
 drivers/dma/odm/odm.h        | 12 ++++++++-
 drivers/dma/odm/odm_dmadev.c |  9 ++++---
 drivers/dma/odm/odm_priv.h   |  4 ++-
 4 files changed, 69 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/odm/odm.c b/drivers/dma/odm/odm.c
index 270808f4df..0633ce0b4b 100644
--- a/drivers/dma/odm/odm.c
+++ b/drivers/dma/odm/odm.c
@@ -125,13 +125,41 @@ odm_disable(struct odm_dev *odm)
 	return 0;
 }
 
+static int
+odm_get_ext_port_type(const struct rte_dma_vchan_conf *conf, uint8_t *ext_port)
+{
+	uint8_t coreid;
+
+	if (conf->src_port.port_type == RTE_DMA_PORT_PCIE) {
+		coreid = conf->src_port.pcie.coreid;
+	} else if (conf->dst_port.port_type == RTE_DMA_PORT_PCIE) {
+		coreid = conf->dst_port.pcie.coreid;
+	} else {
+		*ext_port = ODM_EXT_PORT_NCB;
+		return 0;
+	}
+
+	switch (coreid) {
+	case 0:
+		*ext_port = ODM_EXT_PORT_PEM0;
+		return 0;
+	case 1:
+		*ext_port = ODM_EXT_PORT_PEM1;
+		return 0;
+	default:
+		ODM_LOG(ERR, "Unsupported PCIe coreid %u (only 0 and 1 are valid)", coreid);
+		return -EINVAL;
+	}
+}
+
 int
-odm_vchan_setup(struct odm_dev *odm, int vchan, int nb_desc)
+odm_vchan_setup(struct odm_dev *odm, int vchan, const struct rte_dma_vchan_conf *conf)
 {
 	struct odm_queue *vq = &odm->vq[vchan];
 	int isize, csize, max_nb_desc, rc = 0;
 	union odm_mbox_msg mbox_msg;
 	const struct rte_memzone *mz;
+	uint8_t ext_port;
 	char name[32];
 
 	if (vq->iring_mz != NULL)
@@ -140,10 +168,29 @@ odm_vchan_setup(struct odm_dev *odm, int vchan, int nb_desc)
 	mbox_msg.u[0] = 0;
 	mbox_msg.u[1] = 0;
 
+	switch (conf->direction) {
+	case RTE_DMA_DIR_DEV_TO_MEM:
+		vq->xtype = ODM_XTYPE_INBOUND;
+		break;
+	case RTE_DMA_DIR_MEM_TO_DEV:
+		vq->xtype = ODM_XTYPE_OUTBOUND;
+		break;
+	case RTE_DMA_DIR_MEM_TO_MEM:
+		vq->xtype = ODM_XTYPE_INTERNAL;
+		break;
+	default:
+		ODM_LOG(ERR, "Unsupported DMA direction %d", conf->direction);
+		return -EINVAL;
+	}
+
 	/* ODM PF driver expects vfid starts from index 0 */
 	mbox_msg.q.vfid = odm->vfid;
 	mbox_msg.q.cmd = ODM_QUEUE_OPEN;
 	mbox_msg.q.qidx = vchan;
+	rc = odm_get_ext_port_type(conf, &ext_port);
+	if (rc < 0)
+		return rc;
+	mbox_msg.q.ext_port = ext_port;
 	rc = send_mbox_to_pf(odm, &mbox_msg, &mbox_msg);
 	if (rc < 0)
 		return rc;
@@ -151,7 +198,7 @@ odm_vchan_setup(struct odm_dev *odm, int vchan, int nb_desc)
 	/* Determine instruction & completion ring sizes. */
 
 	/* Create iring that can support nb_desc. Round up to a multiple of 1024. */
-	isize = RTE_ALIGN_CEIL(nb_desc * ODM_IRING_ENTRY_SIZE_MAX * 8, 1024);
+	isize = RTE_ALIGN_CEIL(conf->nb_desc * ODM_IRING_ENTRY_SIZE_MAX * 8, 1024);
 	isize = RTE_MIN(isize, ODM_IRING_MAX_SIZE);
 	snprintf(name, sizeof(name), "vq%d_iring%d", odm->vfid, vchan);
 	mz = rte_memzone_reserve_aligned(name, isize, SOCKET_ID_ANY, 0, 1024);
diff --git a/drivers/dma/odm/odm.h b/drivers/dma/odm/odm.h
index 6b96439094..a6b06daeb2 100644
--- a/drivers/dma/odm/odm.h
+++ b/drivers/dma/odm/odm.h
@@ -9,6 +9,7 @@
 
 #include <rte_common.h>
 #include <rte_compat.h>
+#include <rte_dmadev.h>
 #include <rte_io.h>
 #include <rte_log.h>
 #include <rte_memzone.h>
@@ -40,10 +41,17 @@
  * ODM Transfer Type Enumeration
  * Enumerates the pointer type in ODM_DMA_INSTR_HDR_S[XTYPE]
  */
+#define ODM_XTYPE_OUTBOUND 0
+#define ODM_XTYPE_INBOUND  1
 #define ODM_XTYPE_INTERNAL 2
 #define ODM_XTYPE_FILL0	   4
 #define ODM_XTYPE_FILL1	   5
 
+/* ODM external port type */
+#define ODM_EXT_PORT_PEM0 0x0
+#define ODM_EXT_PORT_PEM1 0x1
+#define ODM_EXT_PORT_NCB  0x2
+
 /*
  *  ODM Header completion type enumeration
  *  Enumerates the completion type in ODM_DMA_INSTR_HDR_S[CT]
@@ -168,6 +176,8 @@ struct odm_queue {
 	uint16_t iring_max_words;
 	/* Number of words in cring.*/
 	uint16_t cring_max_entry;
+	/* DMA transfer type.*/
+	uint16_t xtype;
 	/* Extra instruction size used per inflight instruction.*/
 	uint8_t *extra_ins_sz;
 	struct vq_stats stats;
@@ -189,6 +199,6 @@ int odm_dev_fini(struct odm_dev *odm);
 int odm_configure(struct odm_dev *odm);
 int odm_enable(struct odm_dev *odm);
 int odm_disable(struct odm_dev *odm);
-int odm_vchan_setup(struct odm_dev *odm, int vchan, int nb_desc);
+int odm_vchan_setup(struct odm_dev *odm, int vchan, const struct rte_dma_vchan_conf *conf);
 
 #endif /* _ODM_H_ */
diff --git a/drivers/dma/odm/odm_dmadev.c b/drivers/dma/odm/odm_dmadev.c
index a2f4ed9a8e..0211133bd4 100644
--- a/drivers/dma/odm/odm_dmadev.c
+++ b/drivers/dma/odm/odm_dmadev.c
@@ -30,7 +30,8 @@ odm_dmadev_info_get(const struct rte_dma_dev *dev, struct rte_dma_info *dev_info
 	dev_info->max_vchans = odm->max_qs;
 	dev_info->nb_vchans = odm->num_qs;
 	dev_info->dev_capa =
-		(RTE_DMA_CAPA_MEM_TO_MEM | RTE_DMA_CAPA_OPS_COPY | RTE_DMA_CAPA_OPS_COPY_SG);
+		(RTE_DMA_CAPA_MEM_TO_MEM | RTE_DMA_CAPA_OPS_COPY | RTE_DMA_CAPA_OPS_COPY_SG |
+		 RTE_DMA_CAPA_MEM_TO_DEV | RTE_DMA_CAPA_DEV_TO_MEM);
 	dev_info->max_desc = ODM_IRING_MAX_ENTRY;
 	dev_info->min_desc = 1;
 	dev_info->max_sges = ODM_MAX_POINTER;
@@ -58,7 +59,7 @@ odm_dmadev_vchan_setup(struct rte_dma_dev *dev, uint16_t vchan,
 	struct odm_dev *odm = dev->fp_obj->dev_private;
 
 	RTE_SET_USED(conf_sz);
-	return odm_vchan_setup(odm, vchan, conf->nb_desc);
+	return odm_vchan_setup(odm, vchan, conf);
 }
 
 static int
@@ -99,7 +100,7 @@ odm_dmadev_copy(void *dev_private, uint16_t vchan, rte_iova_t src, rte_iova_t ds
 	struct odm_queue *vq;
 	uint64_t h;
 
-	const union odm_instr_hdr_s hdr = {
+	union odm_instr_hdr_s hdr = {
 		.s.ct = ODM_HDR_CT_CW_NC,
 		.s.xtype = ODM_XTYPE_INTERNAL,
 		.s.nfst = 1,
@@ -107,6 +108,7 @@ odm_dmadev_copy(void *dev_private, uint16_t vchan, rte_iova_t src, rte_iova_t ds
 	};
 
 	vq = &odm->vq[vchan];
+	hdr.s.xtype = vq->xtype;
 
 	h = length;
 	h |= ((uint64_t)length << 32);
@@ -252,6 +254,7 @@ odm_dmadev_copy_sg(void *dev_private, uint16_t vchan, const struct rte_dma_sge *
 	vq = &odm->vq[vchan];
 	const uint16_t max_iring_words = vq->iring_max_words;
 
+	hdr.s.xtype = vq->xtype;
 	iring_head_ptr = vq->iring_mz->addr;
 	iring_head = vq->iring_head;
 	iring_sz_available = vq->iring_sz_available;
diff --git a/drivers/dma/odm/odm_priv.h b/drivers/dma/odm/odm_priv.h
index 1878f4d9a6..71a46c7122 100644
--- a/drivers/dma/odm/odm_priv.h
+++ b/drivers/dma/odm/odm_priv.h
@@ -34,8 +34,10 @@ struct odm_mbox_queue_msg {
 	uint64_t vfid : 8;
 	/* Queue index in the VF */
 	uint64_t qidx : 8;
+	/* Port type for external DMA access */
+	uint64_t ext_port : 8;
 	/* Reserved */
-	uint64_t rsvd_24_63 : 40;
+	uint64_t rsvd_32_63 : 32;
 };
 
 union odm_mbox_msg {
-- 
2.25.1

