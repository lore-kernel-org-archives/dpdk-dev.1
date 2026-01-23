Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64CBD72372
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Jan 2026 10:51:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 33B2A402D7;
	Fri, 23 Jan 2026 11:51:30 +0100 (CET)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 9004F40269;
 Fri, 23 Jan 2026 11:51:28 +0100 (CET)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 60N9CdCL2710653; Fri, 23 Jan 2026 02:51:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=c+84uhkNyF/ILRWJCx4JvUq
 3c+LOf5pbCICr43t7KmE=; b=bFtBJr+qTjgd3xM+UjRcg9o8mzl2MNhdIwAfoEk
 BbcOd6HTQUJPsfArcKvLJdrtK36/jFk/l/VU4Cf8NVvmG2KkIcGmyCJg5QsJVkZ0
 L9/2zTUOiDm94LfOwYI5kcIl9NzhE+5Ly4n2tkm09/7T6z/jLop2GTXX/V6q8us9
 ahlxaE+LObs/LZ/J5QI7yu57VK279AoDBNMSSxCei3vf+sKksuxSSfJpI/CTSQ6i
 DMoI6d0NfHJkAiCt02104LwEB2o+lgoBXr/tjYApPXTyl4e+eALx2UooEdJL7nc7
 8u+iTptAQvRZ5f2T3BcMiplPDKEGOmWpFXuZV10MX+OZ9Fg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4bv3p58ftk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 23 Jan 2026 02:51:27 -0800 (PST)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Fri, 23 Jan 2026 02:51:42 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Fri, 23 Jan 2026 02:51:42 -0800
Received: from nkaithakadan-dkr.marvell.com (unknown [10.29.45.70])
 by maili.marvell.com (Postfix) with ESMTP id 131195B6968;
 Fri, 23 Jan 2026 02:51:24 -0800 (PST)
From: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
To: <dev@dpdk.org>
CC: <anoobj@marvell.com>, <ktejasree@marvell.com>, <gakhil@marvell.com>,
 <fanzhang.oss@gmail.com>, <stable@dpdk.org>
Subject: [PATCH] test/crypto: fix mbuf sanity check failure
Date: Fri, 23 Jan 2026 10:51:23 +0000
Message-ID: <20260123105123.3763725-1-nkaithakadan@marvell.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: bEFjBz9ALVdS3E54OTcBxbggmE-iBfdI
X-Authority-Analysis: v=2.4 cv=ctGWUl4i c=1 sm=1 tr=0 ts=697352af cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=8rWy6zfcAAAA:8 a=M5GUcnROAAAA:8
 a=wBckWAV19WupBdaWaXAA:9 a=YjdVzJdQTyZRADMV7wFX:22 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: bEFjBz9ALVdS3E54OTcBxbggmE-iBfdI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIzMDA4NyBTYWx0ZWRfX9pXbzC98GZGM
 I/vu6GdqvSusuOLlAI0rVWeuAjSPQQfplqZNWBOv0Lr1WrN0dGFAOkxFdekf+OmDihk5dmi3aez
 CTC5YyipHUJjKwbLjFZf7BCbjqZpvBmsMLHis2SPk2T1dV0F/hoMWVlRq3LNaNu5gyvtZJy5Lq2
 YNoFRZtgRpX2sMlb6uVnIOdTaIM7bCn8TGc12APR27zdgqewafKuMaRNMzoT0yvOvYf0QUsH2N7
 R9C6TBy2X5qYgLdbQVuXBasEZUMK39pQ0RylkB/JKSZ+e9FTSdSBJ5P9lCX5nKTHX6AbZk2ESsr
 naKNr1IIIfYhEH+vV/muXgCp68N+Oh6ziJZg25BhUlLMd5PLXemE7mOYPCY5AnBpZw2ogy9IV7M
 agU3/ZhXpDfqZoBIpof9MwQzQk6NhONXL88/6dQRJ4S+iQBUuXbMZ05W3k97Qiu2TraytmLL9q9
 5clHmdQqSyUTDIrcA3g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-23_01,2026-01-22_02,2025-10-01_01
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

Fix mbuf sanity check failures by updating nb_segs
field after mbuf allocation. Without this update, the
append function fails due to incorrect segment count.

Fixes: dcdd01691f39 ("test/crypto: add GMAC SGL")
Fixes: 43220096d66a ("test/crypto: add PDCP cases for scatter gather")
Fixes: f3dbf94be60c ("app/test: check SGL on QAT")
Cc: stable@dpdk.org

Signed-off-by: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
---
 app/test/test_cryptodev.c | 25 +++++++------------------
 1 file changed, 7 insertions(+), 18 deletions(-)

diff --git a/app/test/test_cryptodev.c b/app/test/test_cryptodev.c
index 9bdd357727..b0d09d736c 100644
--- a/app/test/test_cryptodev.c
+++ b/app/test/test_cryptodev.c
@@ -9716,7 +9716,6 @@ test_pdcp_proto_SGL(int i, int oop,
 	int ret = TEST_SUCCESS;
 	int to_trn = 0;
 	int to_trn_tbl[16];
-	int segs = 1;
 	unsigned int trn_data = 0;
 	struct rte_cryptodev_info dev_info;
 	uint64_t feat_flags;
@@ -9785,7 +9784,6 @@ test_pdcp_proto_SGL(int i, int oop,
 	 */
 
 	while (trn_data < input_vec_len) {
-		++segs;
 		to_trn = (input_vec_len - trn_data < fragsz) ?
 				(input_vec_len - trn_data) : fragsz;
 
@@ -9793,6 +9791,7 @@ test_pdcp_proto_SGL(int i, int oop,
 
 		buf->next = rte_pktmbuf_alloc(ts_params->mbuf_pool);
 		buf = buf->next;
+		ut_params->ibuf->nb_segs++;
 
 		memset(rte_pktmbuf_mtod(buf, uint8_t *), 0,
 				rte_pktmbuf_tailroom(buf));
@@ -9802,6 +9801,7 @@ test_pdcp_proto_SGL(int i, int oop,
 			buf_oop->next =
 					rte_pktmbuf_alloc(ts_params->mbuf_pool);
 			buf_oop = buf_oop->next;
+			ut_params->obuf->nb_segs++;
 			memset(rte_pktmbuf_mtod(buf_oop, uint8_t *),
 					0, rte_pktmbuf_tailroom(buf_oop));
 			TEST_ASSERT_NOT_NULL(ut_params->obuf, "Output buffer not initialized");
@@ -9816,16 +9816,12 @@ test_pdcp_proto_SGL(int i, int oop,
 		trn_data += to_trn;
 	}
 
-	ut_params->ibuf->nb_segs = segs;
-
-	segs = 1;
 	if (fragsz_oop && oop) {
 		to_trn = 0;
 		ecx = 0;
 
 		trn_data = frag_size_oop;
 		while (trn_data < output_vec_len) {
-			++segs;
 			to_trn =
 				(output_vec_len - trn_data <
 						frag_size_oop) ?
@@ -9837,13 +9833,13 @@ test_pdcp_proto_SGL(int i, int oop,
 			buf_oop->next =
 				rte_pktmbuf_alloc(ts_params->mbuf_pool);
 			buf_oop = buf_oop->next;
+			ut_params->obuf->nb_segs++;
 			memset(rte_pktmbuf_mtod(buf_oop, uint8_t *),
 					0, rte_pktmbuf_tailroom(buf_oop));
 			TEST_ASSERT_NOT_NULL(rte_pktmbuf_append(ut_params->obuf, to_trn), "Failed to append to mbuf");
 
 			trn_data += to_trn;
 		}
-		ut_params->obuf->nb_segs = segs;
 	}
 
 	/* Setup Cipher Parameters */
@@ -15868,7 +15864,6 @@ test_AES_GMAC_authentication_SGL(const struct gmac_test_data *tdata,
 	uint64_t feature_flags;
 	unsigned int trn_data = 0;
 	void *digest_mem = NULL;
-	uint32_t segs = 1;
 	unsigned int to_trn = 0;
 	struct rte_mbuf *buf = NULL;
 	uint8_t *auth_tag, *plaintext;
@@ -15929,12 +15924,12 @@ test_AES_GMAC_authentication_SGL(const struct gmac_test_data *tdata,
 	 */
 
 	while (trn_data < tdata->plaintext.len) {
-		++segs;
 		to_trn = (tdata->plaintext.len - trn_data < fragsz) ?
 				(tdata->plaintext.len - trn_data) : fragsz;
 
 		buf->next = rte_pktmbuf_alloc(ts_params->mbuf_pool);
 		buf = buf->next;
+		ut_params->ibuf->nb_segs++;
 
 		memset(rte_pktmbuf_mtod(buf, uint8_t *), 0,
 				rte_pktmbuf_tailroom(buf));
@@ -15952,7 +15947,6 @@ test_AES_GMAC_authentication_SGL(const struct gmac_test_data *tdata,
 			TEST_ASSERT_NOT_NULL(digest_mem, "Failed to append digest data");
 		}
 	}
-	ut_params->ibuf->nb_segs = segs;
 
 	/*
 	 * Place digest at the end of the last buffer
@@ -17105,7 +17099,6 @@ test_authenticated_encryption_SGL(const struct aead_test_data *tdata,
 	int retval;
 	int to_trn = 0;
 	int to_trn_tbl[SGL_MAX_NO];
-	int segs = 1;
 	unsigned int trn_data = 0;
 	uint8_t *plaintext, *ciphertext, *auth_tag;
 	struct rte_cryptodev_info dev_info;
@@ -17230,7 +17223,6 @@ test_authenticated_encryption_SGL(const struct aead_test_data *tdata,
 	 */
 
 	while (trn_data < tdata->plaintext.len) {
-		++segs;
 		to_trn = (tdata->plaintext.len - trn_data < fragsz) ?
 				(tdata->plaintext.len - trn_data) : fragsz;
 
@@ -17238,6 +17230,7 @@ test_authenticated_encryption_SGL(const struct aead_test_data *tdata,
 
 		buf->next = rte_pktmbuf_alloc(ts_params->mbuf_pool);
 		buf = buf->next;
+		ut_params->ibuf->nb_segs++;
 
 		memset(rte_pktmbuf_mtod(buf, uint8_t *), 0,
 				rte_pktmbuf_tailroom(buf));
@@ -17247,6 +17240,7 @@ test_authenticated_encryption_SGL(const struct aead_test_data *tdata,
 			buf_last_oop = buf_oop->next =
 					rte_pktmbuf_alloc(ts_params->mbuf_pool);
 			buf_oop = buf_oop->next;
+			ut_params->obuf->nb_segs++;
 			memset(rte_pktmbuf_mtod(buf_oop, uint8_t *),
 					0, rte_pktmbuf_tailroom(buf_oop));
 			TEST_ASSERT_NOT_NULL(rte_pktmbuf_append(ut_params->obuf, to_trn), "Failed to append to mbuf");
@@ -17276,9 +17270,6 @@ test_authenticated_encryption_SGL(const struct aead_test_data *tdata,
 
 	uint64_t digest_phys = 0;
 
-	ut_params->ibuf->nb_segs = segs;
-
-	segs = 1;
 	if (fragsz_oop && oop) {
 		to_trn = 0;
 		ecx = 0;
@@ -17294,7 +17285,6 @@ test_authenticated_encryption_SGL(const struct aead_test_data *tdata,
 
 		trn_data = frag_size_oop;
 		while (trn_data < tdata->plaintext.len) {
-			++segs;
 			to_trn =
 				(tdata->plaintext.len - trn_data <
 						frag_size_oop) ?
@@ -17306,6 +17296,7 @@ test_authenticated_encryption_SGL(const struct aead_test_data *tdata,
 			buf_last_oop = buf_oop->next =
 					rte_pktmbuf_alloc(ts_params->mbuf_pool);
 			TEST_ASSERT_NOT_NULL(buf_oop->next, "Unexpected end of chain");
+			ut_params->obuf->nb_segs++;
 			buf_oop = buf_oop->next;
 			memset(rte_pktmbuf_mtod(buf_oop, uint8_t *),
 					0, rte_pktmbuf_tailroom(buf_oop));
@@ -17319,8 +17310,6 @@ test_authenticated_encryption_SGL(const struct aead_test_data *tdata,
 				TEST_ASSERT_NOT_NULL(digest_mem, "Failed to append auth tag");
 			}
 		}
-
-		ut_params->obuf->nb_segs = segs;
 	}
 
 	/*
-- 
2.48.1

