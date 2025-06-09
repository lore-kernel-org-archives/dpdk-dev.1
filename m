Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FAF2C61CE8
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 10:40:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47F8740E3B;
	Mon,  9 Jun 2025 12:40:53 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id E5FF240E36;
 Mon,  9 Jun 2025 12:40:50 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5599GPCf008324;
 Mon, 9 Jun 2025 03:40:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=5
 267HknCj7Bsb/kL78qJIBDrZqYSt+KNkdvq4XL8GIc=; b=ehiqhkbZme7fPRY9P
 pzRxPJTP1Ku5WgCqeHf0GXwV3B1Csn1xyCfvczVD4R1ZcAkeX/bRfVr3hbO5vQKk
 77eDSvCPpI6TOyRv5cSQ7oHDE8Wp7lmeeKMMIGV53hekRLNszdTi2U1gLvnoF/WN
 FjpF+6ovnZWzni9syBEFULzPieVvbEpG8+o1nTzOFEwSRldAhjBeJJ900oDefNjG
 9nMJ5ojh6SqcBKrWolLRF/fWSIqS3acjw5HFrJVmPRY3UCFa7kI6bBFzhjFQP93l
 QXQ14ncMRZqqBgMasLPC/c+mwkyDeaF2tW0Qu2O2He+jHFCktgTPCzz8dcYCvb5I
 ajB/Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 475vq804nv-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 09 Jun 2025 03:40:49 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 9 Jun 2025 03:40:48 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 9 Jun 2025 03:40:48 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id C078F3F707D;
 Mon,  9 Jun 2025 03:40:45 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Nithinsen Kaithakadan <nkaithakadan@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Rupesh Chiluka <rchiluka@marvell.com>, "Vidya Sagar
 Velumuri" <vvelumuri@marvell.com>, <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH v2 2/7] common/cnxk: fix salt handling with aes-ctr
Date: Mon, 9 Jun 2025 16:10:33 +0530
Message-ID: <20250609104038.3102767-3-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250609104038.3102767-1-ktejasree@marvell.com>
References: <20250609104038.3102767-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: jocE13vxQggM2Rjlm4oOCpC2P77DKmPq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDA4MSBTYWx0ZWRfX6Ms1CbCL0MQp
 Z0ugSXmd3Lhj5//5gqa8tGVWRgp96xdQ+zPfB9jIR05LYfxLA3DYy4c4tEPV1DKGjnpqnsNqaLL
 D23FD58D5V4vzgwiZML4qVcdYFVdDYZ5/l4neq7MBrvez5ttZHAvKOjQU6CFEDdekVATR/fgW2Q
 EfQXtjgvNqaoWmGdFTHZCliZqZvR0W1O79Js7BMYyAfbd5grzEbpWgY7iDGkTSbc9hOYqbXelJq
 rZdmyQmslBXXC6XWE8NF/ihZfQ7NazrGUnKO9A+0I051LSJuqjxMgwsng9vV4fjDjbFllC3WFdh
 zVOTKx6v+2sHmXZOYxXYTuFjF7tyfcfxtwrJokcTitLcK+vlw62WABSg1BMj6AqMHh9Kl8nZ4TU
 ghJqry17IJWB8WHR44pPg3UXG1yI7k61OaHb5fTuC7BJpn2OD+9zGQW6Z5JH+MjsCP2Rnz0A
X-Authority-Analysis: v=2.4 cv=Rp3FLDmK c=1 sm=1 tr=0 ts=6846ba31 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8 a=ZB-2vNBBf5iO9LUBV18A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: jocE13vxQggM2Rjlm4oOCpC2P77DKmPq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_04,2025-06-05_01,2025-03-28_01
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

Fixes: 78d03027f2cc ("common/cnxk: add IPsec common code")
Fixes: 532963b8070 ("crypto/cnxk: move IPsec SA creation to common")
Cc: stable@dpdk.org

Signed-off-by: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
Signed-off-by: Tejasree Kondoj <ktejasree@marvell.com>
---
 drivers/common/cnxk/cnxk_security.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/common/cnxk/cnxk_security.c b/drivers/common/cnxk/cnxk_security.c
index ea3b87e65c..0e6777e6ca 100644
--- a/drivers/common/cnxk/cnxk_security.c
+++ b/drivers/common/cnxk/cnxk_security.c
@@ -96,6 +96,9 @@ ot_ipsec_sa_common_param_fill(union roc_ot_ipsec_sa_word2 *w2, uint8_t *cipher_k
 				break;
 			case RTE_CRYPTO_CIPHER_AES_CTR:
 				w2->s.enc_type = ROC_IE_SA_ENC_AES_CTR;
+				memcpy(salt_key, &ipsec_xfrm->salt, 4);
+				tmp_salt = (uint32_t *)salt_key;
+				*tmp_salt = rte_be_to_cpu_32(*tmp_salt);
 				break;
 			case RTE_CRYPTO_CIPHER_3DES_CBC:
 				w2->s.enc_type = ROC_IE_SA_ENC_3DES_CBC;
@@ -962,6 +965,8 @@ on_fill_ipsec_common_sa(struct rte_security_ipsec_xform *ipsec,
 		cipher_key_len = crypto_xform->aead.key.length;
 	} else {
 		if (cipher_xform) {
+			if (cipher_xform->cipher.algo == RTE_CRYPTO_CIPHER_AES_CTR)
+				memcpy(common_sa->iv.gcm.nonce, &ipsec->salt, 4);
 			cipher_key = cipher_xform->cipher.key.data;
 			cipher_key_len = cipher_xform->cipher.key.length;
 		}
@@ -1282,6 +1287,9 @@ ow_ipsec_sa_common_param_fill(union roc_ow_ipsec_sa_word2 *w2, uint8_t *cipher_k
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

