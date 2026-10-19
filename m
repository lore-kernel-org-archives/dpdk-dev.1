Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E08CCF2DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 13:08:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4842C40A73;
	Mon, 19 Oct 2026 15:08:20 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 74FED40A70
 for <dev@dpdk.org>; Mon, 19 Oct 2026 15:08:18 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8OL2O110509 for <dev@dpdk.org>; Mon, 19 Oct 2026 06:08:17 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=v
 wtSqLx2NMrqyhlBxkJOsgt/rkI9/VcZ6RMQ6qen4Gg=; b=BHJ1rVyhjzfx9DMaX
 3u6J37X2slPrcEyKRFGX6wwYAInaU4SWMbU2EWadWDy+8spfymwM67T61+jnQyJw
 wzq9OZ/KuPixSdRH8Q2mVvI7BctHUKGc7N4sKDUVHHDnjEDq34HgTmP9L8UZlktF
 mvXdPfZDbkGI5CSoM9Ybda3J+Z+ci9y/NNsyG5f5Iim4acxmw9j70AGsA0e5Y/vO
 zYR+EgFHTOvh25B3bdeoAprBrQJy3m/FbFrgvn0ALQRIipZO6BiBGF5Gs7EAnY+U
 bjgWj5liQDBrE5PNeA1OT5DyOpTF+GbXWe7Lwia1RsFVOOYOX8utog4Ft3aKBBY2
 v7cBA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4hc8hh4yp6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 19 Oct 2026 06:08:17 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 19 Oct 2026 06:08:16 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 19 Oct 2026 06:08:16 -0700
Received: from cavium-System-Product-Name.. (unknown [10.28.38.254])
 by maili.marvell.com (Postfix) with ESMTP id 525BB3F704D;
 Mon, 19 Oct 2026 06:08:14 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Rupesh Chiluka <rchiluka@marvell.com>, Anoob Joseph <anoobj@marvell.com>, 
 Vidya Sagar Velumuri <vvelumuri@marvell.com>, Ankur Dwivedi
 <adwivedi@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 05/16] crypto/cnxk: reject truncated TLS records in decrypt
Date: Mon, 19 Oct 2026 18:37:46 +0530
Message-ID: <20261019130759.2181566-6-ktejasree@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019130759.2181566-1-ktejasree@marvell.com>
References: <20261019130759.2181566-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: JodECobpQSu4bo9feE8HY0_0JVQkBOon
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfX8aTQdP73fCXp
 cXGwpF1BC81a1/mQ4Ph5rtDfC9OEQ9mEqFVaXISsETx1/7iUhuqgSOIawDkuaFn314Qm9pITqq5
 rIZiQ+dv0bwFOvP6exBrYZtczZdaMa4YJ9yDzndZhovDl1pIlFix21qHb+aerJIaOzZHspPk72v
 IDGa4bGKKnhZD3IgHiI8BNMVWSbIAm/38cj0+3HCXA+DajHdk041chgQ331Ge1PJJPcE32GkHP8
 9Bb50qYLenBmbxJjA9uXjN+BPmCtNWhSEjfkEl+Skbql1Bv5hI0XDjbzsYWZe9FP5/HvfZzTy6F
 qv0TyRT7V1FjxOjDHziVN9wXpiYPi/KuXDbI3sX0hKo7uBlfM1fSlGeBQeBS4rf0GFrPhEGS8Ji
 Eq4rlyRRelD5tOmp++cKJPaagtQTGNGl6uNV00Fgix06zZl5189YAVon+kFmhViUWlSoORx8BR8
 yG9UDZkKKw54HfzrUgg==
X-Proofpoint-GUID: JodECobpQSu4bo9feE8HY0_0JVQkBOon
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfXwFl5Ff61hdDi
 IRYKuNjSWitK6sLZsC8F6iT/pWD7UeaSjLsNfMlaRuOm9Cq16ZOio8AepjPEaWj5JI2iwmPRzf+
 AXwHbjJGc3CKWpVfQfmeoKZulKKcnu8=
X-Authority-Analysis: v=2.4 cv=LfupeTfi c=1 sm=1 tr=0 ts=6ad61641 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=pc6DdpILWTfcFtrmaZEA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
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

The TLS decrypt tail-fetch path for CBC/3DES READ sessions computed the
tail-fetch source offset as (pkt_len - tail_len) without checking that
pkt_len >= tail_len. For an inbound record shorter than tail_len, the
subtraction underflows when passed as the uint32_t offset to
rte_pktmbuf_read(), which then returns NULL because offset + len
exceeds the packet length. The following rte_memcpy(in_buffer, output,
tail_len) dereferences that NULL pointer.

Reject records with pkt_len < tail_len (return -EINVAL) before computing
the tail-fetch offset in the scatter-gather branches of process_tls_read()
for both cn10k (SGv1 and SGv2) and cn20k.

Signed-off-by: Rupesh Chiluka <rchiluka@marvell.com>
---
 drivers/crypto/cnxk/cn10k_tls_ops.h | 12 ++++++++++++
 drivers/crypto/cnxk/cn20k_tls_ops.h |  6 ++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/crypto/cnxk/cn10k_tls_ops.h b/drivers/crypto/cnxk/cn10k_tls_ops.h
index 90600bd850..416207f676 100644
--- a/drivers/crypto/cnxk/cn10k_tls_ops.h
+++ b/drivers/crypto/cnxk/cn10k_tls_ops.h
@@ -260,6 +260,12 @@ process_tls_read(struct rte_crypto_op *cop, struct cn10k_sec_session *sess,
 		uint32_t dlen;
 		int i;
 
+		if (unlikely(pkt_len < tail_len)) {
+			plt_dp_err("Invalid TLS record: pkt_len %d < tail_len %d", pkt_len,
+				   tail_len);
+			return -EINVAL;
+		}
+
 		if (unlikely(m_src->nb_segs > ROC_SG1_MAX_PTRS)) {
 			plt_dp_err("Exceeds max supported components. Reduce segments");
 			return -1;
@@ -320,6 +326,12 @@ process_tls_read(struct rte_crypto_op *cop, struct cn10k_sec_session *sess,
 		uint32_t g_size_bytes;
 		int i;
 
+		if (unlikely(pkt_len < tail_len)) {
+			plt_dp_err("Invalid TLS record: pkt_len %d < tail_len %d", pkt_len,
+				   tail_len);
+			return -EINVAL;
+		}
+
 		if (unlikely(m_src->nb_segs > ROC_SG2_MAX_PTRS)) {
 			plt_dp_err("Exceeds max supported components. Reduce segments");
 			return -1;
diff --git a/drivers/crypto/cnxk/cn20k_tls_ops.h b/drivers/crypto/cnxk/cn20k_tls_ops.h
index e7a8ba34ae..670acbe9ab 100644
--- a/drivers/crypto/cnxk/cn20k_tls_ops.h
+++ b/drivers/crypto/cnxk/cn20k_tls_ops.h
@@ -203,6 +203,12 @@ process_tls_read(struct rte_crypto_op *cop, struct cn20k_sec_session *sess,
 		uint32_t g_size_bytes;
 		int i;
 
+		if (unlikely(pkt_len < tail_len)) {
+			plt_dp_err("Invalid TLS record: pkt_len %d < tail_len %d", pkt_len,
+				   tail_len);
+			return -EINVAL;
+		}
+
 		if (unlikely(m_src->nb_segs > ROC_SG2_MAX_PTRS)) {
 			plt_dp_err("Exceeds max supported components. Reduce segments");
 			return -1;
-- 
2.43.0

