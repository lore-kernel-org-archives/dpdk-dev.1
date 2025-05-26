Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAAEC54FB3
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 17:02:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D74DA40E03;
	Mon, 26 May 2025 19:00:14 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 4867040E24
 for <dev@dpdk.org>; Mon, 26 May 2025 19:00:12 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54Q1D5gA028926
 for <dev@dpdk.org>; Mon, 26 May 2025 10:00:11 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=E
 R/Rdt4uMDMRIcH6i4HvAsNBJcHfVqRIlI19YGsuW0Q=; b=X5swa1L+nZYqm1z+O
 3Y8rEjJ61r0FDsI3DXG+8YO26GePRawJfDOLm8d+2vrS5C8ShXfBBoT8XboTQ4ak
 9T5OSBSMNqM4c8sIRpiUIWY4Qt19H4oHVffiG1SJ0YD1c4C+GYDTeOiFVl9WlR1X
 CPdfvPuOkAFgGVyd0jb6BDXSdySca6Nk2PbnT9rVuMZe+70YbwZza4mwUHpTelBh
 4Z+u0YYvf5RvmWqa4BYhdGqHlzkaY21q0hkP9RXCzkyghaA3CbZQ2GfPhof8nfLs
 AG9CEZ2v5lD9CoJ0bCnTPh99NwHYn1PTzyun0okuT2/F75acW8LxQ36Am7irH2Fr
 91Iow==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46veebhjvb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 26 May 2025 10:00:11 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 26 May 2025 10:00:10 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 26 May 2025 10:00:10 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 0EC5E3F7069;
 Mon, 26 May 2025 10:00:07 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Nithinsen Kaithakadan <nkaithakadan@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Aakash Sasidharan <asasidharan@marvell.com>, "Rupesh
 Chiluka" <rchiluka@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 33/40] common/cnxk: set correct salt value for ctr algos
Date: Mon, 26 May 2025 22:28:12 +0530
Message-ID: <20250526165819.2197892-34-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250526165819.2197892-1-ktejasree@marvell.com>
References: <20250526165819.2197892-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: M9BlSGESp9bTM6l6RYagnpkACPc25M6o
X-Authority-Analysis: v=2.4 cv=TJ9FS0la c=1 sm=1 tr=0 ts=68349e1b cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=VlgjLVM6OR-Tcjh_F24A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDE0NCBTYWx0ZWRfX2CjUrBdor6p9
 f6cVrq8+4DnIyUcKMoriC2Z6WmXwxPYGkMyT3ppLZqL1tncHsaFYtb2xV8if/DiCXJniz16kwgo
 HLtSofiTwpewGCV1oYTipYvtGt4mea4iEAokODJW8+hICnHuHHEiVb2Cc5GO7ujQD3hmyQgdTsW
 pS/ZvDnupb7KpCXxu9hw5lsF75rwiEA/HoFUZkx1PN7sPy9hAkCblE05/s6szm2YLMdPlb9Qz9h
 H6evbw0Oc454IsRaLHd0NTdSZikhrCzIevDvFdGUgZP0uANObTaFJjfy1ExOwqjKBdVxiS8PEhn
 8yj8ERYZxi3CcdRp8/yWhWGrk3WUkGlYMKEKrvwQGVwI2vJNs3Q1NQpBr41FaiK0kRbtYq1IGzk
 6U5glVU+HtzVI8fMaIdsatCHmH7OLZg7UUmYM/GD1o4aYsJPW6q0MAA1vsyH5S2D0pxpyOA+
X-Proofpoint-GUID: M9BlSGESp9bTM6l6RYagnpkACPc25M6o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-26_08,2025-05-26_02,2025-03-28_01
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

This patch includes fix for setting correct salt value
for CTR algorithm.

Fixes: 532963b8070 ("crypto/cnxk: move IPsec SA creation to common")

Signed-off-by: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
---
 drivers/common/cnxk/cnxk_security.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/common/cnxk/cnxk_security.c b/drivers/common/cnxk/cnxk_security.c
index 62ae7b9b2e..0e6777e6ca 100644
--- a/drivers/common/cnxk/cnxk_security.c
+++ b/drivers/common/cnxk/cnxk_security.c
@@ -965,6 +965,8 @@ on_fill_ipsec_common_sa(struct rte_security_ipsec_xform *ipsec,
 		cipher_key_len = crypto_xform->aead.key.length;
 	} else {
 		if (cipher_xform) {
+			if (cipher_xform->cipher.algo == RTE_CRYPTO_CIPHER_AES_CTR)
+				memcpy(common_sa->iv.gcm.nonce, &ipsec->salt, 4);
 			cipher_key = cipher_xform->cipher.key.data;
 			cipher_key_len = cipher_xform->cipher.key.length;
 		}
@@ -1285,6 +1287,9 @@ ow_ipsec_sa_common_param_fill(union roc_ow_ipsec_sa_word2 *w2, uint8_t *cipher_k
 				break;
 			case RTE_CRYPTO_CIPHER_AES_CTR:
 				w2->s.enc_type = ROC_IE_SA_ENC_AES_CTR;
+				memcpy(salt_key, &ipsec_xfrm->salt, 4);
+				tmp_salt = (uint32_t *)salt_key;
+				*tmp_salt = rte_be_to_cpu_32(*tmp_salt);
 				break;
 			case RTE_CRYPTO_CIPHER_3DES_CBC:
 				w2->s.enc_type = ROC_IE_SA_ENC_3DES_CBC;
-- 
2.25.1

