Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CC2DCCF2DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 13:09:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D35840B9E;
	Mon, 19 Oct 2026 15:08:41 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 913B840B90
 for <dev@dpdk.org>; Mon, 19 Oct 2026 15:08:40 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8OeBl289802 for <dev@dpdk.org>; Mon, 19 Oct 2026 06:08:40 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=e
 BUG71qS8euluXEl5qX5tEDY20cLSdON++PyanFxbvM=; b=lNmOAsXBK4VMjDZnO
 8rvZ9leXTqSOKIeeqRiOkgVknokOJbCpqlyREwkaVCmG+hg0uNe/71MgxUAbTH9A
 PkSs/826fRw08mDLcipNSS+CFyET9A+V1FFZG9Jb5KOxwlE6oluInweFxHoCyBw/
 zpE0IJyGWnJyX/xnrnI7eUsFGguXE1CnPkVMa2YQHxO5VvNY+hrwRgBCVVX6G63a
 kDW3AX52K6+u5XHgwEEYll7vjb+F8l1UjTC1aAT+4JD9DatqNqlFbGWB5fpOBJ5C
 gIxSHDOESvw71jxCBryQY6KJ5SwXkrYbULCrigOewQDOqPFKrSbDphn2JaVS+z/P
 QfQig==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4hcss7b54s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 19 Oct 2026 06:08:39 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 19 Oct 2026 06:08:38 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 19 Oct 2026 06:08:38 -0700
Received: from cavium-System-Product-Name.. (unknown [10.28.38.254])
 by maili.marvell.com (Postfix) with ESMTP id 761EF3F704D;
 Mon, 19 Oct 2026 06:08:36 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Rupesh Chiluka <rchiluka@marvell.com>, Anoob Joseph <anoobj@marvell.com>, 
 Vidya Sagar Velumuri <vvelumuri@marvell.com>, Ankur Dwivedi
 <adwivedi@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 13/16] crypto/cnxk: bound SG segment count in packet iov
 builders
Date: Mon, 19 Oct 2026 18:37:54 +0530
Message-ID: <20261019130759.2181566-14-ktejasree@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019130759.2181566-1-ktejasree@marvell.com>
References: <20261019130759.2181566-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=RdAFmFtv c=1 sm=1 tr=0 ts=6ad61657 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=pTH_-71RssmVb_7JIfYA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfX8Vbdh4T+FTc1
 PVdHO0EFa9qA4CEXHP8BLFUx0heNh0syyo6eDey9hjebEBs6XyqU0f818KimBk6rwbEwzhSsLKm
 oul9tmnazCPFvXobH+/hammKNuRc77Y=
X-Proofpoint-ORIG-GUID: Gt32oQ_el3IzL9idvw7DnNRgD1LZi-z9
X-Proofpoint-GUID: Gt32oQ_el3IzL9idvw7DnNRgD1LZi-z9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfXwrdjPbkn+eK7
 1gRoiZ7lxkBZt2OnXVPIrjnfJAn4vju1dXtIIuhfgJt74XRHPAE2QV5culcTnw3mAl7qGREnGTz
 4M0sO/DyA/cwSnt8+8puf9A58i/kf0sckb818j+vhRunlMJsEEIVBqCM/gMwxRWND9iZxBNN9LW
 WiVsROX12in5tc4lFH3FKQNt6yQ7fOwh0ucp+COzwvR6oy2qcFuq/YE5a7llFt2oRGprYX/44Mw
 JhXt180gFHNX1jEl2no0CAKayeZiT0zTXvczcZZ6u5FCfWRftEYvVRE0DEfSFZhCS2LnyGmsUHZ
 EG0o6Rsn+BdjorvlXK/d/RBDV5abpPjKSrUFePDHky7OSebbgdwMuRc6YVDFkBEc9uXTIxLZ9pj
 5uvdlV+SVrTbBxbDPBsHISldI+lOQemM7z4LJkYf14A1JIR6UwUI3jgIk87y+Nvscil4n7b1xAV
 8yTjPsE/1WSdudDNyEA==
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

prepare_iov_from_pkt() and prepare_iov_from_pkt_inplace() wrote one
iovec->bufs[] entry per mbuf segment with no bound check, overflowing
the fixed-size stack buffer (capacity ROC_MAX_SG_CNT) on the lookaside
symmetric path.

Reject segment counts exceeding ROC_MAX_SG_CNT in both builders and
fail the op.

Signed-off-by: Rupesh Chiluka <rchiluka@marvell.com>
---
 drivers/crypto/cnxk/cnxk_se.h | 51 ++++++++++++++++++++++++++++++-----
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/cnxk/cnxk_se.h b/drivers/crypto/cnxk/cnxk_se.h
index b712acdccd..a3c3c3ce86 100644
--- a/drivers/crypto/cnxk/cnxk_se.h
+++ b/drivers/crypto/cnxk/cnxk_se.h
@@ -2670,6 +2670,7 @@ prepare_iov_from_pkt(struct rte_mbuf *pkt, struct roc_se_iov_ptr *iovec, uint32_
 		     const bool is_aead, const bool is_sg_ver2)
 {
 	uint16_t index = 0;
+	uint16_t nb_segs = 0;
 	void *seg_data = NULL;
 	int32_t seg_size = 0;
 
@@ -2678,6 +2679,8 @@ prepare_iov_from_pkt(struct rte_mbuf *pkt, struct roc_se_iov_ptr *iovec, uint32_
 		return 0;
 	}
 
+	nb_segs = pkt->nb_segs;
+
 	if (!start_offset) {
 		seg_data = rte_pktmbuf_mtod(pkt, void *);
 		seg_size = pkt->data_len;
@@ -2685,6 +2688,12 @@ prepare_iov_from_pkt(struct rte_mbuf *pkt, struct roc_se_iov_ptr *iovec, uint32_
 		while (start_offset >= pkt->data_len) {
 			start_offset -= pkt->data_len;
 			pkt = pkt->next;
+			nb_segs--;
+
+			if (unlikely(pkt == NULL)) {
+				plt_dp_err("Start offset beyond end of packet");
+				return 1;
+			}
 		}
 
 		seg_data = rte_pktmbuf_mtod_offset(pkt, void *, start_offset);
@@ -2693,6 +2702,12 @@ prepare_iov_from_pkt(struct rte_mbuf *pkt, struct roc_se_iov_ptr *iovec, uint32_
 			return 1;
 	}
 
+	if (unlikely(nb_segs > ROC_MAX_SG_CNT)) {
+		plt_dp_err("Number of segments (%u) exceeds max supported (%u)", nb_segs,
+			   ROC_MAX_SG_CNT);
+		return 1;
+	}
+
 	/* first seg */
 	iovec->bufs[index].vaddr = seg_data;
 	iovec->bufs[index].size = seg_size;
@@ -2717,7 +2732,7 @@ prepare_iov_from_pkt(struct rte_mbuf *pkt, struct roc_se_iov_ptr *iovec, uint32_
 	return 0;
 }
 
-static __rte_always_inline void
+static __rte_always_inline uint32_t
 prepare_iov_from_pkt_inplace(struct rte_mbuf *pkt,
 			     struct roc_se_fc_params *param, uint32_t *flags)
 {
@@ -2726,6 +2741,12 @@ prepare_iov_from_pkt_inplace(struct rte_mbuf *pkt,
 	uint32_t seg_size = 0;
 	struct roc_se_iov_ptr *iovec;
 
+	if (unlikely(pkt->nb_segs > ROC_MAX_SG_CNT)) {
+		plt_dp_err("Number of segments (%u) exceeds max supported (%u)", pkt->nb_segs,
+			   ROC_MAX_SG_CNT);
+		return 1;
+	}
+
 	seg_data = rte_pktmbuf_mtod(pkt, void *);
 	seg_size = pkt->data_len;
 
@@ -2740,7 +2761,7 @@ prepare_iov_from_pkt_inplace(struct rte_mbuf *pkt,
 
 		param->bufs[0].vaddr = seg_data;
 		param->bufs[0].size = seg_size;
-		return;
+		return 0;
 	}
 	iovec = param->src_iov;
 	iovec->bufs[index].vaddr = seg_data;
@@ -2764,7 +2785,7 @@ prepare_iov_from_pkt_inplace(struct rte_mbuf *pkt,
 	}
 
 	iovec->buf_cnt = index;
-	return;
+	return 0;
 }
 
 static __rte_always_inline int
@@ -2816,7 +2837,11 @@ fill_sm_params(struct rte_crypto_op *cop, struct cnxk_se_sess *sess,
 
 	if (m_dst == NULL) {
 		fc_params.dst_iov = fc_params.src_iov = (void *)src;
-		prepare_iov_from_pkt_inplace(m_src, &fc_params, &flags);
+		if (unlikely(prepare_iov_from_pkt_inplace(m_src, &fc_params, &flags))) {
+			plt_dp_err("Prepare inplace src iov failed");
+			ret = -EINVAL;
+			goto err_exit;
+		}
 	} else {
 		/* Out of place processing */
 		fc_params.src_iov = (void *)src;
@@ -3017,7 +3042,11 @@ fill_fc_params(struct rte_crypto_op *cop, struct cnxk_se_sess *sess,
 		 */
 		fc_params.dst_iov = fc_params.src_iov = (void *)src;
 
-		prepare_iov_from_pkt_inplace(m_src, &fc_params, &flags);
+		if (unlikely(prepare_iov_from_pkt_inplace(m_src, &fc_params, &flags))) {
+			plt_dp_err("Prepare inplace src iov failed");
+			ret = -EINVAL;
+			goto err_exit;
+		}
 
 	} else {
 		/* Out of place processing */
@@ -3165,7 +3194,11 @@ fill_pdcp_params(struct rte_crypto_op *cop, struct cnxk_se_sess *sess,
 
 	if (likely(m_dst == NULL || m_src == m_dst)) {
 		fc_params.dst_iov = fc_params.src_iov = (void *)src;
-		prepare_iov_from_pkt_inplace(m_src, &fc_params, &flags);
+		if (unlikely(prepare_iov_from_pkt_inplace(m_src, &fc_params, &flags))) {
+			plt_dp_err("Prepare inplace src iov failed");
+			ret = -EINVAL;
+			goto err_exit;
+		}
 	} else {
 		/* Out of place processing */
 
@@ -3298,7 +3331,11 @@ fill_pdcp_chain_params(struct rte_crypto_op *cop, struct cnxk_se_sess *sess,
 
 	if (likely((m_dst == NULL || m_dst == m_src)) && inplace) {
 		fc_params.dst_iov = fc_params.src_iov = (void *)src;
-		prepare_iov_from_pkt_inplace(m_src, &fc_params, &flags);
+		if (unlikely(prepare_iov_from_pkt_inplace(m_src, &fc_params, &flags))) {
+			plt_dp_err("Could not prepare inplace src iov");
+			ret = -EINVAL;
+			goto err_exit;
+		}
 	} else {
 		/* Out of place processing */
 		fc_params.src_iov = (void *)src;
-- 
2.43.0

