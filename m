Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DC71CAC5AC
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Sep 2025 14:23:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B6FF7402CB;
	Tue, 23 Sep 2025 16:23:02 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id B3368402B3
 for <dev@dpdk.org>; Tue, 23 Sep 2025 16:23:01 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58N5L4sc022952;
 Tue, 23 Sep 2025 07:23:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pfpt0220; bh=W0ZF5rkFZTs7pnLDSK17ExR
 HJYpA6QHIXp68tQWbOgo=; b=LX5ilZdvaffShYfEQIpFx4JdrCkNN/0zz+UrTlr
 Edq7fSeUMYO1bwCx6drVWFIRlnbcUUJ4Buhy6kDeZhoAjXPSQtycAyVeBJ7nqF3E
 eqaX/fiH4Jg1Dz9kvEjzpRBWK7tUggi7hKbQnLpaphtgbgLJgBXQBQOr7iYL+UkH
 vMmRYUyCXQGh6E9Nt4roW9EqIspLTaHLk7taMpTfo6Q2uuEU1ROS4I9LJx6vjBGc
 FYCAld6jpZrObcZQX3eUzb2BagA32HQ/Jlpmxnc5bEhoUhrlaaVGd/GHse3x5JPw
 VI3D5lgIKlkshIfeblmjjCpqxW4QG43CF+lS49uz+RU89iw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 49bnags34a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Sep 2025 07:23:00 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Tue, 23 Sep 2025 07:22:59 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Tue, 23 Sep 2025 07:22:59 -0700
Received: from nkaithakadan-dkr.marvell.com (unknown [10.29.45.70])
 by maili.marvell.com (Postfix) with ESMTP id 877B75B6924;
 Tue, 23 Sep 2025 07:22:56 -0700 (PDT)
From: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
To: <dev@dpdk.org>
CC: <anoobj@marvell.com>, <ktejasree@marvell.com>, <gakhil@marvell.com>,
 <kai.ji@intel.com>, <ciara.power@intel.com>,
 <pablo.de.lara.guarch@intel.com>, <arkadiuszx.kusztal@intel.com>
Subject: [PATCH] test/crypto: fix for mbuf sanity check failure
Date: Tue, 23 Sep 2025 14:22:54 +0000
Message-ID: <20250923142254.1904208-1-nkaithakadan@marvell.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=X6pSKHTe c=1 sm=1 tr=0 ts=68d2ad44 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=yJojWOMRYYMA:10 a=M5GUcnROAAAA:8 a=5FrFcuNKcf7HXzTYalUA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIzMDA0NyBTYWx0ZWRfXxVv9XKx1BNtL
 Vz8sXwIPVvgSk4u/QFAALxF52gct3Js7oEIf+jLl9BSJz0m/DmkHUpg08dwRVlLS7DPJkVUew64
 9h/4zl9LNiyPokdEEjgrMsfkdN5ISUxGRnPfsk3gZPcpqSkMrBzWg9HEtzIqmkT5HvGht1KH1gj
 ckubjagXkRpznPNfzCD4884skOgkhpZ3muyYczN9ihLJoDaDRP42kZOhxQg4trj7MK2C6Hpwmj5
 cVLiUtIMYeHdEH8QcZPGmUypAnT6M0gSVikMP4w0aUK652YQFtWVuEG3Pg1bG8oco+YGYHKC9zH
 BAPzoITJJOrSyBHDeheZsCVGtxywoNrz/+pL3KwOPjodvXiaSwFUO3lnBBuZwLf7WsJEhlWs/6e
 x9iLb7vA
X-Proofpoint-GUID: IUbAsCGMAOJUkm2prgb2u-FngIgje_iX
X-Proofpoint-ORIG-GUID: IUbAsCGMAOJUkm2prgb2u-FngIgje_iX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-23_03,2025-09-22_05,2025-03-28_01
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

This patch resolves the following mbuf sanity check errors.
  - updating nb_segs and pkt_len in the head mbuf after
    freeing intermediate nodes in the chain.
  - fix incorrect usage of rte_pktmbuf_append by ensuring
    the head mbuf is passed instead of an intermediate
    node, allowing proper tail detection and metadata
    update.

Fixes: dc3f6c5347b2 ("test/crypto: fix wireless auth digest segment")
Fixes: 43220096d66a ("test/crypto: add PDCP cases for scatter gather")
Fixes: dcdd01691f39 ("test/crypto: add GMAC SGL")
Fixes: f3dbf94be60c ("app/test: check SGL on QAT")

Signed-off-by: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
---
 app/test/test_cryptodev.c | 59 ++++++++++++++++++++++++++-------------
 1 file changed, 40 insertions(+), 19 deletions(-)

diff --git a/app/test/test_cryptodev.c b/app/test/test_cryptodev.c
index 5229ac2bf6..f092f608a9 100644
--- a/app/test/test_cryptodev.c
+++ b/app/test/test_cryptodev.c
@@ -3488,6 +3488,8 @@ create_wireless_algo_auth_cipher_operation(
 		uint16_t remaining_off = (auth_offset >> 3) + (auth_len >> 3);
 		struct rte_mbuf *sgl_buf = (op_mode == IN_PLACE ?
 				sym_op->m_src : sym_op->m_dst);
+		struct rte_mbuf *sgl_buf_head = sgl_buf;
+
 		while (remaining_off >= rte_pktmbuf_data_len(sgl_buf)) {
 			remaining_off -= rte_pktmbuf_data_len(sgl_buf);
 			sgl_buf = sgl_buf->next;
@@ -3495,11 +3497,18 @@ create_wireless_algo_auth_cipher_operation(
 
 		/* The last segment should be large enough to hold full digest */
 		if (sgl_buf->data_len < auth_tag_len) {
-			rte_pktmbuf_free(sgl_buf->next);
-			sgl_buf->next = NULL;
-			TEST_ASSERT_NOT_NULL(rte_pktmbuf_append(sgl_buf,
-					auth_tag_len - sgl_buf->data_len),
-					"No room to append auth tag");
+			uint16_t next_data_len = 0;
+			if (sgl_buf->next != NULL) {
+				next_data_len = sgl_buf->next->data_len;
+
+				rte_pktmbuf_free(sgl_buf->next);
+				sgl_buf->next = NULL;
+				sgl_buf_head->nb_segs -= 1;
+				sgl_buf_head->pkt_len -= next_data_len;
+			}
+			TEST_ASSERT_NOT_NULL(rte_pktmbuf_append(
+						sgl_buf_head, auth_tag_len - sgl_buf->data_len),
+						"No room to append auth tag");
 		}
 
 		sym_op->auth.digest.data = rte_pktmbuf_mtod_offset(sgl_buf,
@@ -9795,11 +9804,13 @@ test_pdcp_proto_SGL(int i, int oop,
 			buf_oop = buf_oop->next;
 			memset(rte_pktmbuf_mtod(buf_oop, uint8_t *),
 					0, rte_pktmbuf_tailroom(buf_oop));
-			rte_pktmbuf_append(buf_oop, to_trn);
+			TEST_ASSERT_NOT_NULL(ut_params->obuf, "Output buffer not initialized");
+			TEST_ASSERT_NOT_NULL(rte_pktmbuf_append(ut_params->obuf, to_trn), "Failed to append to mbuf");
 		}
 
-		plaintext = (uint8_t *)rte_pktmbuf_append(buf,
+		plaintext = (uint8_t *)rte_pktmbuf_append(ut_params->ibuf,
 				to_trn);
+		TEST_ASSERT_NOT_NULL(plaintext, "Failed to append plaintext");
 
 		memcpy(plaintext, input_vec + trn_data, to_trn);
 		trn_data += to_trn;
@@ -9828,7 +9839,7 @@ test_pdcp_proto_SGL(int i, int oop,
 			buf_oop = buf_oop->next;
 			memset(rte_pktmbuf_mtod(buf_oop, uint8_t *),
 					0, rte_pktmbuf_tailroom(buf_oop));
-			rte_pktmbuf_append(buf_oop, to_trn);
+			TEST_ASSERT_NOT_NULL(rte_pktmbuf_append(ut_params->obuf, to_trn), "Failed to append to mbuf");
 
 			trn_data += to_trn;
 		}
@@ -15916,15 +15927,18 @@ test_AES_GMAC_authentication_SGL(const struct gmac_test_data *tdata,
 		memset(rte_pktmbuf_mtod(buf, uint8_t *), 0,
 				rte_pktmbuf_tailroom(buf));
 
-		plaintext = (uint8_t *)rte_pktmbuf_append(buf,
+		plaintext = (uint8_t *)rte_pktmbuf_append(ut_params->ibuf,
 				to_trn);
+		TEST_ASSERT_NOT_NULL(plaintext, "Failed to append plaintext");
 
 		memcpy(plaintext, tdata->plaintext.data + trn_data,
 				to_trn);
 		trn_data += to_trn;
-		if (trn_data  == tdata->plaintext.len)
-			digest_mem = (uint8_t *)rte_pktmbuf_append(buf,
+		if (trn_data  == tdata->plaintext.len) {
+			digest_mem = (uint8_t *)rte_pktmbuf_append(ut_params->ibuf,
 					tdata->gmac_tag.len);
+			TEST_ASSERT_NOT_NULL(digest_mem, "Failed to append digest data");
+		}
 	}
 	ut_params->ibuf->nb_segs = segs;
 
@@ -17223,23 +17237,28 @@ test_authenticated_encryption_SGL(const struct aead_test_data *tdata,
 			buf_oop = buf_oop->next;
 			memset(rte_pktmbuf_mtod(buf_oop, uint8_t *),
 					0, rte_pktmbuf_tailroom(buf_oop));
-			rte_pktmbuf_append(buf_oop, to_trn);
+			TEST_ASSERT_NOT_NULL(rte_pktmbuf_append(ut_params->obuf, to_trn), "Failed to append to mbuf");
 		}
 
-		plaintext = (uint8_t *)rte_pktmbuf_append(buf,
+		plaintext = (uint8_t *)rte_pktmbuf_append(ut_params->ibuf,
 				to_trn);
+		TEST_ASSERT_NOT_NULL(plaintext, "Failed to append plaintext");
 
 		memcpy(plaintext, tdata->plaintext.data + trn_data,
 				to_trn);
 		trn_data += to_trn;
 		if (trn_data  == tdata->plaintext.len) {
 			if (oop) {
-				if (!fragsz_oop)
-					digest_mem = rte_pktmbuf_append(buf_oop,
+				if (!fragsz_oop) {
+					digest_mem = rte_pktmbuf_append(ut_params->obuf,
 						tdata->auth_tag.len);
-			} else
-				digest_mem = (uint8_t *)rte_pktmbuf_append(buf,
+					TEST_ASSERT_NOT_NULL(digest_mem, "Failed to append auth tag");
+				}
+			} else {
+				digest_mem = (uint8_t *)rte_pktmbuf_append(ut_params->ibuf,
 					tdata->auth_tag.len);
+				TEST_ASSERT_NOT_NULL(digest_mem, "Failed to append auth tag");
+			}
 		}
 	}
 
@@ -17274,16 +17293,18 @@ test_authenticated_encryption_SGL(const struct aead_test_data *tdata,
 
 			buf_last_oop = buf_oop->next =
 					rte_pktmbuf_alloc(ts_params->mbuf_pool);
+			TEST_ASSERT_NOT_NULL(buf_oop->next, "Unexpected end of chain");
 			buf_oop = buf_oop->next;
 			memset(rte_pktmbuf_mtod(buf_oop, uint8_t *),
 					0, rte_pktmbuf_tailroom(buf_oop));
-			rte_pktmbuf_append(buf_oop, to_trn);
+			TEST_ASSERT_NOT_NULL(rte_pktmbuf_append(ut_params->obuf, to_trn), "Failed to append to mbuf");
 
 			trn_data += to_trn;
 
 			if (trn_data  == tdata->plaintext.len) {
-				digest_mem = rte_pktmbuf_append(buf_oop,
+				digest_mem = rte_pktmbuf_append(ut_params->obuf,
 					tdata->auth_tag.len);
+				TEST_ASSERT_NOT_NULL(digest_mem, "Failed to append auth tag");
 			}
 		}
 
-- 
2.48.1

