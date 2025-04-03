Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AB87C3600C
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Apr 2025 12:26:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BD9B24060C;
	Thu,  3 Apr 2025 14:26:07 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 250964003C
 for <dev@dpdk.org>; Thu,  3 Apr 2025 14:26:07 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 533AHhmi020721;
 Thu, 3 Apr 2025 05:26:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=wM0e84XGEgbEPRT359cOMBC
 LvIJPT8VuRuwLxeekH7M=; b=KWbRzQydan8wPBHWaWtFijOtHLDCDQnADdvo1Of
 pjupaXDpcjFiAOhr1qlR62xhs8o+Rz9Z33AE9z5v5VDxqBX0grSzteLWLoDJ1+3z
 C+rHt65huRTHb6q1tY/+8EK6EV/LE2k8Mi5SDVMOgbs9MwP4AfKgUirpRLqxOLKA
 ZmFmnoUfLMKis+ZlqFce8e8HCZ3sjDb19g6teCpiXhAS0SMu8qlU1yBtaENnJh4P
 dixWufftnB04ASrXDwTSuAyZIRxZ+cVchBuDZrBKVohzgtYZ0ckpeXEUDDouQ4e4
 qAbK2CftqcjXybhU+6wZXcNTvMftArZnxxTVN6TAc4EOAXw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 45srf0g89d-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 03 Apr 2025 05:26:06 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 3 Apr 2025 05:26:05 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 3 Apr 2025 05:26:05 -0700
Received: from Dell640-transport-1.sclab.marvell.com (unknown [10.106.48.36])
 by maili.marvell.com (Postfix) with ESMTP id 32F6B3F7064;
 Thu,  3 Apr 2025 05:26:05 -0700 (PDT)
From: Rajesh Mudimadugula <rmudimadugul@marvell.com>
To: <dev@dpdk.org>
CC: <jianjay.zhou@huawei.com>, Rajesh Mudimadugula <rmudimadugul@marvell.com>
Subject: [PATCH 2/2] crypto/virtio: fix cipher data src length
Date: Thu, 3 Apr 2025 12:26:03 +0000
Message-ID: <20250403122603.3508135-1-rmudimadugul@marvell.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 91YA-JX5tk_w1ZEC7TfCVhKI3Vcl1Vqc
X-Proofpoint-GUID: 91YA-JX5tk_w1ZEC7TfCVhKI3Vcl1Vqc
X-Authority-Analysis: v=2.4 cv=QYRmvtbv c=1 sm=1 tr=0 ts=67ee7e5e cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=XR8D0OoHHMoA:10 a=M5GUcnROAAAA:8 a=oAs47NBT3OAnkiyEnJMA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-03_05,2025-04-02_03,2024-11-22_01
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

In symmetric algorithm chaining, we need to consider both
cipher and auth data length for cipher source.

Fixes: 82adb12a1fce ("crypto/virtio: support burst enqueue/dequeue")

Signed-off-by: Rajesh Mudimadugula <rmudimadugul@marvell.com>
---
 drivers/crypto/virtio/virtio_rxtx.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/crypto/virtio/virtio_rxtx.c b/drivers/crypto/virtio/virtio_rxtx.c
index 0cc904485c..a7f1bd9753 100644
--- a/drivers/crypto/virtio/virtio_rxtx.c
+++ b/drivers/crypto/virtio/virtio_rxtx.c
@@ -243,8 +243,10 @@ virtqueue_crypto_sym_pkt_header_arrange(
 		req_data->u.sym_req.u.chain.para.aad_len = session->aad.length;
 
 		req_data->u.sym_req.u.chain.para.src_data_len =
-			(sym_op->cipher.data.length +
-				sym_op->cipher.data.offset);
+			RTE_MAX((sym_op->cipher.data.length +
+				 sym_op->cipher.data.offset),
+				(sym_op->auth.data.length +
+				 sym_op->auth.data.offset));
 		req_data->u.sym_req.u.chain.para.dst_data_len =
 			req_data->u.sym_req.u.chain.para.src_data_len;
 		req_data->u.sym_req.u.chain.para.cipher_start_src_offset =
@@ -298,6 +300,7 @@ virtqueue_crypto_sym_enqueue_xmit_split(
 	uint32_t hash_result_len = 0;
 	struct virtio_crypto_op_cookie *crypto_op_cookie;
 	struct virtio_crypto_alg_chain_session_para *para;
+	uint32_t src_len;
 
 	if (unlikely(sym_op->m_src->nb_segs != 1))
 		return -EMSGSIZE;
@@ -371,21 +374,22 @@ virtqueue_crypto_sym_enqueue_xmit_split(
 		desc[idx++].flags = VRING_DESC_F_NEXT;
 	}
 
+	src_len = RTE_MAX((sym_op->cipher.data.offset +
+			   sym_op->cipher.data.length),
+			  (sym_op->auth.data.length +
+			   sym_op->auth.data.offset));
 	/* indirect vring: src data */
 	desc[idx].addr = rte_pktmbuf_iova_offset(sym_op->m_src, 0);
-	desc[idx].len = (sym_op->cipher.data.offset
-		+ sym_op->cipher.data.length);
+	desc[idx].len = src_len;
 	desc[idx++].flags = VRING_DESC_F_NEXT;
 
 	/* indirect vring: dst data */
 	if (sym_op->m_dst) {
 		desc[idx].addr = rte_pktmbuf_iova_offset(sym_op->m_dst, 0);
-		desc[idx].len = (sym_op->cipher.data.offset
-			+ sym_op->cipher.data.length);
+		desc[idx].len = src_len;
 	} else {
 		desc[idx].addr = rte_pktmbuf_iova_offset(sym_op->m_src, 0);
-		desc[idx].len = (sym_op->cipher.data.offset
-			+ sym_op->cipher.data.length);
+		desc[idx].len = src_len;
 	}
 	desc[idx++].flags = VRING_DESC_F_WRITE | VRING_DESC_F_NEXT;
 
-- 
2.34.1

