Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAAB8C7EE32
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Jun 2025 09:18:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6BA44021F;
	Thu, 26 Jun 2025 11:18:48 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 1E75D400D6
 for <dev@dpdk.org>; Thu, 26 Jun 2025 11:18:46 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55Q6tE3B002218;
 Thu, 26 Jun 2025 02:18:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=/mogMC2FPyH8nEASDrV00u5
 7wr2DR4cNva4Mi5G5fgw=; b=QxRFUfkcvpn1kUPs40/VlTOdlxNx1bFDQvKsw8Y
 I5MNeOREiEVUUEi6cKd9rBa3Ojb0TSRPrp4kDMEIVBAik3WVY10jTyhada6vmctZ
 YEOAvu5hk8qw6N5+jhhjV7BSyuxEUJ4jhCdWO960/xd7kj2UaG5OO3zznlV8KvLM
 KBVhtNraGX18XMKx5MBVgZU2sYEE9/oDkZxZ1Ro/6jdt85cv9pRBq4IPOVipVr0B
 wir9hD3GDP0ysA7djSxFXDdVBE7TS41p+T6aG5aHC7WF5T8IuzC+wQmJ6FFniPN0
 fOk5Grk54LfwUs1iJ19VXWA3cq2JQQn9a2YaJqcWl1UXWEQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47h1c30ajc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 26 Jun 2025 02:18:45 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 26 Jun 2025 02:18:45 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 26 Jun 2025 02:18:45 -0700
Received: from Dell640-transport-1.sclab.marvell.com (unknown [10.106.48.36])
 by maili.marvell.com (Postfix) with ESMTP id 4A79E3F705A;
 Thu, 26 Jun 2025 02:18:45 -0700 (PDT)
From: Rajesh Mudimadugula <rmudimadugul@marvell.com>
To: <dev@dpdk.org>
CC: <jianjay.zhou@huawei.com>, <gakhil@marvell.com>, Rajesh Mudimadugula
 <rmudimadugul@marvell.com>
Subject: [PATCH] crypto/virtio: fix virtio desc flags virtq info
Date: Thu, 26 Jun 2025 09:18:42 +0000
Message-ID: <20250626091842.159016-1-rmudimadugul@marvell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ep-XIbtnFEdcHL_0kYchrAJTH_kSdgXm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI2MDA3NSBTYWx0ZWRfXxcxum45OqMll
 +p2DSJu9aoUowW3dfBmQ6NeqnQfRsgdPnMnPHz35vUHV15HSfHYWIpYi5HJ2u2uJAae+UyB/iXN
 t6iVl/ZRvI9NJv4GsuZeom2bTui8Hl5x4tknDXd0CXr1wterdb4KdwsuhaVgPzNIAINt4hMl+KX
 m7+9sDXHUvYclLXUzdnE/EeGcze6MZ6/5Cr06rCqwEGL1kO7c90C5ur+e+kr/KghSj4EmrXU/6M
 q7ycCCpNwv7wFrM26rL65GJNC2Q8uUSU7hlQ+R9USlMz5rTJf7nDEhxWaAm+mj8uePrqPHd7rwE
 awn/d36PQJFvj+2/QsLsWpo/+RACBrflwyN249MwJsqOQ3nOVOjfTGvu7mSk12oFsJ8+e4s0e9k
 NR6l/RaqDy9gU7Xwe1UBYKevBCDZP/MbmCJYOIuOOuntIt/3+GQoj04rpTVdVUO3Ir+FO5OG
X-Proofpoint-GUID: ep-XIbtnFEdcHL_0kYchrAJTH_kSdgXm
X-Authority-Analysis: v=2.4 cv=cv6bk04i c=1 sm=1 tr=0 ts=685d1076 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=ZimyMXnelmnQTd_0LXQA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-26_04,2025-06-25_01,2025-03-28_01
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

This patch corrects virtio descriptor flags and updates
virtqueue metadata.

Fixes: 796429e72a6d ("crypto/virtio: add packed ring support")

Signed-off-by: Rajesh Mudimadugula <rmudimadugul@marvell.com>
---
 drivers/crypto/virtio/virtio_rxtx.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_rxtx.c b/drivers/crypto/virtio/virtio_rxtx.c
index 00988e18b1..4204e1f77e 100644
--- a/drivers/crypto/virtio/virtio_rxtx.c
+++ b/drivers/crypto/virtio/virtio_rxtx.c
@@ -479,6 +479,7 @@ virtqueue_crypto_sym_enqueue_xmit_packed(
 		struct rte_crypto_op *cop)
 {
 	uint16_t idx = 0;
+	uint16_t num_entry;
 	uint16_t needed = 1;
 	uint16_t head_idx;
 	struct vq_desc_extra *dxp;
@@ -598,13 +599,20 @@ virtqueue_crypto_sym_enqueue_xmit_packed(
 	/* packed vring: last part, status returned */
 	desc[idx].addr = op_data_req_phys_addr + req_data_len;
 	desc[idx].len = sizeof(struct virtio_crypto_inhdr);
-	desc[idx++].flags = flags | VRING_DESC_F_WRITE;
+	desc[idx++].flags = txvq->vq_packed.cached_flags | VRING_DESC_F_WRITE;
+
+	num_entry = idx;
+	txvq->vq_avail_idx += num_entry;
+	if (txvq->vq_avail_idx >= txvq->vq_nentries) {
+		txvq->vq_avail_idx -= txvq->vq_nentries;
+		txvq->vq_packed.cached_flags ^= VRING_PACKED_DESC_F_AVAIL_USED;
+	}
 
 	/* save the infos to use when receiving packets */
 	dxp->crypto_op = (void *)cop;
 	dxp->ndescs = needed;
 
-	txvq->vq_desc_head_idx += idx & (txvq->vq_nentries - 1);
+	txvq->vq_desc_head_idx = (txvq->vq_desc_head_idx + idx) & (txvq->vq_nentries - 1);
 	if (txvq->vq_desc_head_idx == VQ_RING_DESC_CHAIN_END)
 		txvq->vq_desc_tail_idx = idx;
 	txvq->vq_free_cnt = (uint16_t)(txvq->vq_free_cnt - needed);
-- 
2.34.1

