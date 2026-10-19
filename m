Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD88FCCF2DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 13:08:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A46C40A70;
	Mon, 19 Oct 2026 15:08:28 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 62B3440663
 for <dev@dpdk.org>; Mon, 19 Oct 2026 15:08:26 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8OgGS538854 for <dev@dpdk.org>; Mon, 19 Oct 2026 06:08:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=/
 eAzC/AdYyP+ga5kleLcObzBPFBz/oxFiW9Aj2csE2I=; b=QE4MJKFiOhuGMwWDw
 eOP3QTKoxCAAteK2xLt9tfbFzRijIbyKduGSVN8mJ+BG3oOSR4DzCh358N3p3CVO
 wzgFvnH2ocUaQbg5eCYInHPGt6QlwWwVpAdZqOs4GgnLCCKUGXfBZe9S+YyuSHqU
 KmPVFY/fgvCpksQRvAvFqjGrVjZ2B9EK+40pR4UqkOjuL244zP/3b+iDZKp3l33f
 3TmdDo4pzW+zGX4JbZqFFrVQ5bVzTEHL/0kMAlV1hdkGtTJHzScppi9pq2xUDFvu
 kH06AthvOL48wP3uacq6H5BrsLB+lMrV1nC1u28XuSXs0y4lK7zgB5qy3NebFi2z
 sfp0A==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4hc6cj5gra-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 19 Oct 2026 06:08:25 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 19 Oct 2026 06:08:24 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 19 Oct 2026 06:08:24 -0700
Received: from cavium-System-Product-Name.. (unknown [10.28.38.254])
 by maili.marvell.com (Postfix) with ESMTP id 92A063F704D;
 Mon, 19 Oct 2026 06:08:22 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Rupesh Chiluka <rchiluka@marvell.com>, Anoob Joseph <anoobj@marvell.com>, 
 Vidya Sagar Velumuri <vvelumuri@marvell.com>, Ankur Dwivedi
 <adwivedi@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 08/16] crypto/cnxk: reject oversized SG vectors in raw datapath
Date: Mon, 19 Oct 2026 18:37:49 +0530
Message-ID: <20261019130759.2181566-9-ktejasree@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019130759.2181566-1-ktejasree@marvell.com>
References: <20261019130759.2181566-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: XWB86IZmoBJVrY1p50UiUXbvbr74QusH
X-Authority-Analysis: v=2.4 cv=L7KI0OT8 c=1 sm=1 tr=0 ts=6ad61649 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=cn162PdG369UfFvh1rwA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfX3PaZ3Q4sjmGC
 h1AmNaPFzTzqDQfS/HI7DpNNvf6aUi8e4rKtBmlU6LrG96kXFBbMetFoeWF/sEZa8Th3kzuTgM6
 OT+YvFwS1REppnPOZIj9c6VTRCPh/e2+bgNxZNFzBHXosw2bIDLox+uE0PRZOrq9EVTjdaCTzt/
 xjSFC8tclqyZzL7KpczjTa1Rn193e6yEwUOIbIxryluA0+7+UtKEJ/B2+MEORgYxHf7jv39y9nW
 thYQ5TjZyzjzeWlglHonFXLc49eiEeZGc8DdnkCErMjUT/2t05lAjVRXvblF8GopMjzrk9Nheh9
 DH3DZToVZi5mShWs1MxWEvOUlbEDoD2ElVa5JNN/g9lV4SZyY8WnxvrQo2zTQv2htnOP+SkOBJg
 ZvxS4BlbS6xcfbE/scA0EtfbYdbtVaoRCZvgyCZHpVO4Kwl4Wgqpf3G6MM7tgQ5zfkiJNAklMSi
 /2q6dGaLTse2zqxA0Yg==
X-Proofpoint-GUID: XWB86IZmoBJVrY1p50UiUXbvbr74QusH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfX+TivR8ROGjjd
 d2BzhrRZfDumM1S6ZINNNVaaCmIHOZ8ul+qTjbpUMXHTEFiX4zhyfr34l8mJSkLotK5ISwRsiBP
 bGWdqwEwRHh0GvUElzrbXFxDgablwVA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
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

From: Rupesh Chiluka <rchiluka@marvell.com>

In raw datapath, iov builders copied application-supplied SG entries
into the fixed-size iov->src[]/dst[] stack buffers (max ROC_MAX_SG_CNT
entries) without validating the segment count. A raw-dp crypto vector
with more than ROC_MAX_SG_CNT segments results in a stack overwrite.

Reject vector lists whose src_sgl[].num, dest_sgl[].num, or n_data_vecs
exceed ROC_MAX_SG_CNT before copying.

cnxk_raw_burst_to_iov() and cnxk_raw_to_iov() now return an error,
which is propagated by the cn10k and cn20k raw enqueue paths to fail
the op cleanly.

Signed-off-by: Rupesh Chiluka <rchiluka@marvell.com>
---
 drivers/crypto/cnxk/cn10k_cryptodev_ops.c | 29 ++++++++++++++++++-----
 drivers/crypto/cnxk/cn20k_cryptodev_ops.c | 29 ++++++++++++++++++-----
 drivers/crypto/cnxk/cnxk_se.h             | 23 ++++++++++++++++--
 3 files changed, 67 insertions(+), 14 deletions(-)

diff --git a/drivers/crypto/cnxk/cn10k_cryptodev_ops.c b/drivers/crypto/cnxk/cn10k_cryptodev_ops.c
index 870e65c049..bf273774fd 100644
--- a/drivers/crypto/cnxk/cn10k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn10k_cryptodev_ops.c
@@ -1615,17 +1615,30 @@ cn10k_cpt_raw_enqueue_burst(void *qpair, uint8_t *drv_ctx, struct rte_crypto_sym
 		infl_req = &pend_q->req_queue[head];
 		infl_req->op_flags = 0;
 
-		cnxk_raw_burst_to_iov(vec, &ofs, index, &iov);
+		ret = cnxk_raw_burst_to_iov(vec, &ofs, index, &iov);
+		if (unlikely(ret != 0)) {
+			plt_dp_err("Failed to convert raw to iov: %d", index);
+			if (i == 0 && count == 0) {
+				*enqueue_status = ret;
+				return 0;
+			} else if (i == 0) {
+				goto pend_q_commit;
+			} else {
+				break;
+			}
+		}
 		ret = cn10k_cpt_raw_fill_inst(&iov, qp, dp_ctx, &inst[i], infl_req,
 					      user_data[index], is_sgv2);
 		if (unlikely(ret != 1)) {
 			plt_dp_err("Could not process vec: %d", index);
-			if (i == 0 && count == 0)
-				return -1;
-			else if (i == 0)
+			if (i == 0 && count == 0) {
+				*enqueue_status = -EINVAL;
+				return 0;
+			} else if (i == 0) {
 				goto pend_q_commit;
-			else
+			} else {
 				break;
+			}
 		}
 		pending_queue_advance(&head, pq_mask);
 	}
@@ -1694,7 +1707,11 @@ cn10k_cpt_raw_enqueue(void *qpair, uint8_t *drv_ctx, struct rte_crypto_vec *data
 	if (unlikely(nb_allowed == 0))
 		return -1;
 
-	cnxk_raw_to_iov(data_vec, n_data_vecs, &ofs, iv, digest, aad_or_auth_iv, &iov);
+	ret = cnxk_raw_to_iov(data_vec, n_data_vecs, &ofs, iv, digest, aad_or_auth_iv, &iov);
+	if (unlikely(ret != 0)) {
+		plt_dp_err("Failed to convert raw to iov");
+		return -1;
+	}
 
 	lmt_base = qp->lmtline.lmt_base;
 	io_addr = qp->lmtline.io_addr;
diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
index a63b97654b..7707755775 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
@@ -1189,17 +1189,30 @@ cn20k_cpt_raw_enqueue_burst(void *qpair, uint8_t *drv_ctx, struct rte_crypto_sym
 		infl_req = &pend_q->req_queue[head];
 		infl_req->op_flags = 0;
 
-		cnxk_raw_burst_to_iov(vec, &ofs, index, &iov);
+		ret = cnxk_raw_burst_to_iov(vec, &ofs, index, &iov);
+		if (unlikely(ret != 0)) {
+			plt_dp_err("Failed to convert raw to iov: %d", index);
+			if (i == 0 && count == 0) {
+				*enqueue_status = ret;
+				return 0;
+			} else if (i == 0) {
+				goto pend_q_commit;
+			} else {
+				break;
+			}
+		}
 		ret = cn20k_cpt_raw_fill_inst(&iov, qp, dp_ctx, &inst[i], infl_req,
 					      user_data[index]);
 		if (unlikely(ret != 1)) {
 			plt_dp_err("Could not process vec: %d", index);
-			if (i == 0 && count == 0)
-				return -1;
-			else if (i == 0)
+			if (i == 0 && count == 0) {
+				*enqueue_status = -EINVAL;
+				return 0;
+			} else if (i == 0) {
 				goto pend_q_commit;
-			else
+			} else {
 				break;
+			}
 		}
 		pending_queue_advance(&head, pq_mask);
 	}
@@ -1249,7 +1262,11 @@ cn20k_cpt_raw_enqueue(void *qpair, uint8_t *drv_ctx, struct rte_crypto_vec *data
 	if (unlikely(nb_allowed == 0))
 		return -1;
 
-	cnxk_raw_to_iov(data_vec, n_data_vecs, &ofs, iv, digest, aad_or_auth_iv, &iov);
+	ret = cnxk_raw_to_iov(data_vec, n_data_vecs, &ofs, iv, digest, aad_or_auth_iv, &iov);
+	if (unlikely(ret != 0)) {
+		plt_dp_err("Failed to convert raw to iov");
+		return -1;
+	}
 
 	lmt_base = qp->lmtline.lmt_base;
 	io_addr = qp->lmtline.io_addr;
diff --git a/drivers/crypto/cnxk/cnxk_se.h b/drivers/crypto/cnxk/cnxk_se.h
index 505a5fcd37..b712acdccd 100644
--- a/drivers/crypto/cnxk/cnxk_se.h
+++ b/drivers/crypto/cnxk/cnxk_se.h
@@ -3633,10 +3633,19 @@ prepare_iov_from_raw_vec(struct rte_crypto_vec *vec, struct roc_se_iov_ptr *iove
 	return total_len;
 }
 
-static __rte_always_inline void
+static __rte_always_inline int
 cnxk_raw_burst_to_iov(struct rte_crypto_sym_vec *vec, union rte_crypto_sym_ofs *ofs, int index,
 		      struct cnxk_iov *iov)
 {
+	uint32_t dst_num =
+		(vec->dest_sgl == NULL) ? vec->src_sgl[index].num : vec->dest_sgl[index].num;
+
+	if (unlikely(vec->src_sgl[index].num > ROC_MAX_SG_CNT || dst_num > ROC_MAX_SG_CNT)) {
+		plt_dp_err("Number of segments (src: %u, dst: %u) exceeds max supported (%u)",
+			   vec->src_sgl[index].num, dst_num, ROC_MAX_SG_CNT);
+		return -ENOTSUP;
+	}
+
 	iov->iv_buf = vec->iv[index].va;
 	iov->aad_buf = vec->aad[index].va;
 	iov->mac_buf = vec->digest[index].va;
@@ -3658,13 +3667,21 @@ cnxk_raw_burst_to_iov(struct rte_crypto_sym_vec *vec, union rte_crypto_sym_ofs *
 
 	iov->a_head = ofs->ofs.auth.head;
 	iov->a_tail = ofs->ofs.auth.tail;
+
+	return 0;
 }
 
-static __rte_always_inline void
+static __rte_always_inline int
 cnxk_raw_to_iov(struct rte_crypto_vec *data_vec, uint16_t n_vecs, union rte_crypto_sym_ofs *ofs,
 		struct rte_crypto_va_iova_ptr *iv, struct rte_crypto_va_iova_ptr *digest,
 		struct rte_crypto_va_iova_ptr *aad, struct cnxk_iov *iov)
 {
+	if (unlikely(n_vecs > ROC_MAX_SG_CNT)) {
+		plt_dp_err("Number of segments (%u) exceeds max supported (%u)", n_vecs,
+			   ROC_MAX_SG_CNT);
+		return -ENOTSUP;
+	}
+
 	iov->iv_buf = iv->va;
 	iov->aad_buf = aad->va;
 	iov->mac_buf = digest->va;
@@ -3678,6 +3695,8 @@ cnxk_raw_to_iov(struct rte_crypto_vec *data_vec, uint16_t n_vecs, union rte_cryp
 
 	iov->a_head = ofs->ofs.auth.head;
 	iov->a_tail = ofs->ofs.auth.tail;
+
+	return 0;
 }
 
 static inline void
-- 
2.43.0

