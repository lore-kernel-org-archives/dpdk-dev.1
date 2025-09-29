Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91FDECAC5B5
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 09:45:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 083F840B8F;
	Mon, 29 Sep 2025 11:44:41 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 1D35B40A76;
 Mon, 29 Sep 2025 11:44:38 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58T4LBpf018976;
 Mon, 29 Sep 2025 02:44:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=v
 BamEpcewe7MyN16RskZPrLux+iS0LMDWOZ5Q12fXUc=; b=UumqHOSuZi0HxG30U
 vWPsN11BahYYy5ldtuo+HVmX75WnkGPHuH2N24FU35m8Owy5IneR3groDGQyjRJx
 7pvKZpTIh912i2qlvlM8OWuf/ZJJMFOGDRneshZLcjMIdG8vzsA9VZIbL2Zfnu72
 Hqh3Sc9uI4j7EoX9LvIb9sNKNw+CBs8KW8XUXYAloTqNTSdZaw9MRUl0AaR0mTJl
 q64DwI/nvYomk2l4Lj350XSiCghZ5HppN6PG+XqYtLCJ3Ijxwb+L/ZhuSq826Vd4
 VO3oULTfKHw4LTZ5x9J6PutXKL7kU0O9OwHZFWpxadfIQNdTHx6ViV1GmOIu768b
 w5OGQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49f0p51w3m-8
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Sep 2025 02:44:37 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 29 Sep 2025 02:44:41 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 29 Sep 2025 02:44:41 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 188123F7059;
 Mon, 29 Sep 2025 02:44:29 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Nithinsen Kaithakadan <nkaithakadan@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Aakash Sasidharan <asasidharan@marvell.com>, "Rupesh
 Chiluka" <rchiluka@marvell.com>, Sucharitha Sarananaga
 <ssarananaga@marvell.com>,
 Vidya Sagar Velumuri <vvelumuri@marvell.com>, <dev@dpdk.org>,
 <stable@dpdk.org>
Subject: [PATCH v3 10/10] crypto/cnxk: fix tls mbuf sanity failures
Date: Mon, 29 Sep 2025 15:13:53 +0530
Message-ID: <20250929094353.1027744-11-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250929094353.1027744-1-ktejasree@marvell.com>
References: <20250929094353.1027744-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: IOn-53DiE62IkBbFDgYOm3YxlD1soB8U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI4MDA2OSBTYWx0ZWRfX2JYTDBwUnISY
 0nA8SXnHbjuY5wbOmCA2+bZGi+6n3RfKJFEHO7FzGcQaWtNvYJBuieo+A40UvxRlX3+UA3Og7H6
 buUsbUFyeMlpcRI3sgaHtzWvzR741n8CmD1Rd9X+3IPamLZV7G/6OgJK3J+LdeivbucFl9BUVDM
 XRP9Sgte7jzJw0FGOAlzdNPLKWW8ZuYMEghMVbVONIjSAmv8tVLoxAzosxfZJ7UNTb7pnZPkzvB
 NsjzcIScAle7+AvI3kL8Dfw4RpqHOYLTscZfxwDg+LJEEWMk4iTScaX+pqw4j1DJUA1O+Ioly+y
 6btSE49zFxgiEbft4g4iGhrmLyJFyM/4zlif+Mjc6Ix/jeys8LaAR7IJrzZmbojfMEJPK2Kz5k7
 KtKzNmk1rDJdVywzv9CtJ6P2vqo8Ig==
X-Authority-Analysis: v=2.4 cv=StCdKfO0 c=1 sm=1 tr=0 ts=68da5505 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=yJojWOMRYYMA:10 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8 a=N6WndKuiHDo2SFEvOzYA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: IOn-53DiE62IkBbFDgYOm3YxlD1soB8U
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-29_04,2025-09-29_01,2025-03-28_01
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

From: Nithinsen Kaithakadan <nkaithakadan@marvell.com>

Fix mbuf sanity check failure by zeroing data_len of each
segment from the target len onward and adjusting pkt_len
in the head mbuf. Hence by avoiding call to free mbuf from
intermediate node.

Fixes: 9a126e7cf088 ("crypto/cnxk: support TLS padding verification")
Fixes: c05eb27d55d8 ("crypto/cnxk: add CN20K TLS post-process")
Cc: stable@dpdk.org

Signed-off-by: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
---
 drivers/crypto/cnxk/cn10k_cryptodev_ops.c | 40 ++++++++---------------
 drivers/crypto/cnxk/cn20k_cryptodev_ops.c | 39 +++++++---------------
 drivers/crypto/cnxk/cnxk_cryptodev_ops.h  | 26 +++++++++++++++
 3 files changed, 51 insertions(+), 54 deletions(-)

diff --git a/drivers/crypto/cnxk/cn10k_cryptodev_ops.c b/drivers/crypto/cnxk/cn10k_cryptodev_ops.c
index d6b95a14aa..870e65c049 100644
--- a/drivers/crypto/cnxk/cn10k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn10k_cryptodev_ops.c
@@ -931,13 +931,13 @@ cn10k_cpt_ipsec_post_process(struct rte_crypto_op *cop, struct cpt_cn10k_res_s *
 static inline void
 cn10k_cpt_tls12_trim_mac(struct rte_crypto_op *cop, struct cpt_cn10k_res_s *res, uint8_t mac_len)
 {
-	struct rte_mbuf *mac_prev_seg = NULL, *mac_seg = NULL, *seg;
 	uint32_t pad_len, trim_len, mac_offset, pad_offset;
 	struct rte_mbuf *mbuf = cop->sym->m_src;
-	uint16_t m_len = res->rlen;
-	uint32_t i, nb_segs = 1;
+	uint16_t m_len = res->rlen, len_to_trim;
+	struct rte_mbuf *seg;
 	uint8_t pad_res = 0;
 	uint8_t pad_val;
+	uint32_t i;
 
 	pad_val = ((res->spi >> 16) & 0xff);
 	pad_len = pad_val + 1;
@@ -966,11 +966,8 @@ cn10k_cpt_tls12_trim_mac(struct rte_crypto_op *cop, struct cpt_cn10k_res_s *res,
 	seg = mbuf;
 	while (mac_offset >= seg->data_len) {
 		mac_offset -= seg->data_len;
-		mac_prev_seg = seg;
 		seg = seg->next;
-		nb_segs++;
 	}
-	mac_seg = seg;
 
 	pad_offset = mac_offset + mac_len;
 	while (pad_offset >= seg->data_len) {
@@ -995,17 +992,9 @@ cn10k_cpt_tls12_trim_mac(struct rte_crypto_op *cop, struct cpt_cn10k_res_s *res,
 		cop->aux_flags = res->uc_compcode;
 	}
 
-	mbuf->pkt_len = m_len - trim_len;
-	if (mac_offset) {
-		rte_pktmbuf_free(mac_seg->next);
-		mac_seg->next = NULL;
-		mac_seg->data_len = mac_offset;
-		mbuf->nb_segs = nb_segs;
-	} else {
-		rte_pktmbuf_free(mac_seg);
-		mac_prev_seg->next = NULL;
-		mbuf->nb_segs = nb_segs - 1;
-	}
+	len_to_trim = mbuf->pkt_len - (m_len - trim_len);
+
+	pktmbuf_trim_chain(mbuf, len_to_trim);
 }
 
 /* TLS-1.3:
@@ -1016,11 +1005,11 @@ cn10k_cpt_tls12_trim_mac(struct rte_crypto_op *cop, struct cpt_cn10k_res_s *res,
 static inline void
 cn10k_cpt_tls13_trim_mac(struct rte_crypto_op *cop, struct cpt_cn10k_res_s *res)
 {
+	uint16_t m_len = res->rlen, len_to_trim;
 	struct rte_mbuf *mbuf = cop->sym->m_src;
 	struct rte_mbuf *seg = mbuf;
-	uint16_t m_len = res->rlen;
 	uint8_t *ptr, type = 0x0;
-	int len, i, nb_segs = 1;
+	int len, i;
 
 	while (m_len && !type) {
 		len = m_len;
@@ -1030,7 +1019,6 @@ cn10k_cpt_tls13_trim_mac(struct rte_crypto_op *cop, struct cpt_cn10k_res_s *res)
 		while (len > seg->data_len) {
 			len -= seg->data_len;
 			seg = seg->next;
-			nb_segs++;
 		}
 
 		/* walkthrough from last until a non zero value is found */
@@ -1043,16 +1031,14 @@ cn10k_cpt_tls13_trim_mac(struct rte_crypto_op *cop, struct cpt_cn10k_res_s *res)
 		m_len -= len;
 	}
 
+	len_to_trim = mbuf->pkt_len - i;
+
 	if (type) {
+		pktmbuf_trim_chain(mbuf, len_to_trim);
 		cop->param1.tls_record.content_type = type;
-		mbuf->pkt_len = m_len + i;
-		mbuf->nb_segs = nb_segs;
-		seg->data_len = i;
-		rte_pktmbuf_free(seg->next);
-		seg->next = NULL;
-	} else {
+
+	} else
 		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
-	}
 }
 
 static inline void
diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
index b696c28081..1803e4ba5a 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
@@ -896,13 +896,13 @@ cn20k_cpt_ipsec_post_process(struct rte_crypto_op *cop, struct cpt_cn20k_res_s *
 static inline void
 cn20k_cpt_tls12_trim_mac(struct rte_crypto_op *cop, struct cpt_cn20k_res_s *res, uint8_t mac_len)
 {
-	struct rte_mbuf *mac_prev_seg = NULL, *mac_seg = NULL, *seg;
 	uint32_t pad_len, trim_len, mac_offset, pad_offset;
 	struct rte_mbuf *mbuf = cop->sym->m_src;
-	uint16_t m_len = res->rlen;
-	uint32_t i, nb_segs = 1;
+	uint16_t m_len = res->rlen, len_to_trim;
+	struct rte_mbuf *seg;
 	uint8_t pad_res = 0;
 	uint8_t pad_val;
+	uint32_t i;
 
 	pad_val = ((res->spi >> 16) & 0xff);
 	pad_len = pad_val + 1;
@@ -931,11 +931,8 @@ cn20k_cpt_tls12_trim_mac(struct rte_crypto_op *cop, struct cpt_cn20k_res_s *res,
 	seg = mbuf;
 	while (mac_offset >= seg->data_len) {
 		mac_offset -= seg->data_len;
-		mac_prev_seg = seg;
 		seg = seg->next;
-		nb_segs++;
 	}
-	mac_seg = seg;
 
 	pad_offset = mac_offset + mac_len;
 	while (pad_offset >= seg->data_len) {
@@ -960,17 +957,9 @@ cn20k_cpt_tls12_trim_mac(struct rte_crypto_op *cop, struct cpt_cn20k_res_s *res,
 		cop->aux_flags = res->uc_compcode;
 	}
 
-	mbuf->pkt_len = m_len - trim_len;
-	if (mac_offset) {
-		rte_pktmbuf_free(mac_seg->next);
-		mac_seg->next = NULL;
-		mac_seg->data_len = mac_offset;
-		mbuf->nb_segs = nb_segs;
-	} else {
-		rte_pktmbuf_free(mac_seg);
-		mac_prev_seg->next = NULL;
-		mbuf->nb_segs = nb_segs - 1;
-	}
+	len_to_trim = mbuf->pkt_len - (m_len - trim_len);
+
+	pktmbuf_trim_chain(mbuf, len_to_trim);
 }
 
 /* TLS-1.3:
@@ -981,11 +970,11 @@ cn20k_cpt_tls12_trim_mac(struct rte_crypto_op *cop, struct cpt_cn20k_res_s *res,
 static inline void
 cn20k_cpt_tls13_trim_mac(struct rte_crypto_op *cop, struct cpt_cn20k_res_s *res)
 {
+	uint16_t m_len = res->rlen, len_to_trim;
 	struct rte_mbuf *mbuf = cop->sym->m_src;
 	struct rte_mbuf *seg = mbuf;
-	uint16_t m_len = res->rlen;
 	uint8_t *ptr, type = 0x0;
-	int len, i, nb_segs = 1;
+	int len, i;
 
 	while (m_len && !type) {
 		len = m_len;
@@ -995,7 +984,6 @@ cn20k_cpt_tls13_trim_mac(struct rte_crypto_op *cop, struct cpt_cn20k_res_s *res)
 		while (len > seg->data_len) {
 			len -= seg->data_len;
 			seg = seg->next;
-			nb_segs++;
 		}
 
 		/* walkthrough from last until a non zero value is found */
@@ -1008,16 +996,13 @@ cn20k_cpt_tls13_trim_mac(struct rte_crypto_op *cop, struct cpt_cn20k_res_s *res)
 		m_len -= len;
 	}
 
+	len_to_trim = mbuf->pkt_len - i;
+
 	if (type) {
+		pktmbuf_trim_chain(mbuf, len_to_trim);
 		cop->param1.tls_record.content_type = type;
-		mbuf->pkt_len = m_len + i;
-		mbuf->nb_segs = nb_segs;
-		seg->data_len = i;
-		rte_pktmbuf_free(seg->next);
-		seg->next = NULL;
-	} else {
+	} else
 		cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
-	}
 }
 
 static inline void
diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_ops.h b/drivers/crypto/cnxk/cnxk_cryptodev_ops.h
index 17d39aa34f..02223fbf3a 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_ops.h
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_ops.h
@@ -239,4 +239,30 @@ cnxk_cpt_sec_inst_w7_get(struct roc_cpt *roc_cpt, void *cptr)
 
 	return w7.u64;
 }
+
+static inline void
+pktmbuf_trim_chain(struct rte_mbuf *m, uint16_t len)
+{
+	uint16_t len_so_far = 0, left_over = 0, new_mlen;
+	struct rte_mbuf *cur = m;
+
+	new_mlen = m->pkt_len - len;
+
+	while (len_so_far < new_mlen) {
+		left_over = new_mlen - len_so_far;
+		if (left_over < cur->data_len)
+			break;
+		len_so_far += cur->data_len;
+		cur = cur->next;
+	}
+
+	cur->data_len = left_over;
+	cur = cur->next;
+	while (cur) {
+		cur->data_len = 0;
+		cur = cur->next;
+	}
+
+	m->pkt_len = new_mlen;
+}
 #endif /* _CNXK_CRYPTODEV_OPS_H_ */
-- 
2.25.1

