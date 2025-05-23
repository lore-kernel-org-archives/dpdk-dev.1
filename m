Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EB93C54F2E
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 May 2025 13:56:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AC16640BA0;
	Fri, 23 May 2025 15:53:06 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 8FEBC40DDD
 for <dev@dpdk.org>; Fri, 23 May 2025 15:53:04 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54N9rKjG009245
 for <dev@dpdk.org>; Fri, 23 May 2025 06:53:04 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=E
 R/Rdt4uMDMRIcH6i4HvAsNBJcHfVqRIlI19YGsuW0Q=; b=idOMn62eKPe+XhQvk
 Y2ry8eYkexhg+tHsVrL+ivuABKyYRFMNth0IMhywLu1iEq6pKUc70aIUJ/IstJdF
 e7ph9bPhmydQSwwvWdBi/I+wg7dE03h2qaRW14jo3WEGwqfSAqMyBxSKpN47P7ms
 cNRmIFgsWLjziIcNptDTRJkCP99Hocbh/5lvvq3EgjHsCIK9ZheVLZ81knIBg6Gk
 3b6CUl8emDa8S5JbxRwPHj5/kHqNxPQ/pRsW3rOl4Rr5URu/qsHN7Z/6FRlA2my/
 0NeEh4eutMJjiFfVy8CyBCPpWtWKuXlf3VKKRMtpbO/lcDR45qZRKcXUqxGceTX2
 DPV5w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46tdnkshd6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 23 May 2025 06:53:03 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 23 May 2025 06:53:02 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 23 May 2025 06:53:02 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id E2AAE3F7041;
 Fri, 23 May 2025 06:52:59 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Nithinsen Kaithakadan <nkaithakadan@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Aakash Sasidharan <asasidharan@marvell.com>, "Rupesh
 Chiluka" <rchiluka@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 33/40] common/cnxk: set correct salt value for ctr algos
Date: Fri, 23 May 2025 19:21:04 +0530
Message-ID: <20250523135111.2178408-34-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250523135111.2178408-1-ktejasree@marvell.com>
References: <20250523135111.2178408-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDEyMyBTYWx0ZWRfX6dhcO6in7YuN
 1WkFqD2/C3NCKmzQ4nrJnzrRtn5cCcYsWvPJJ/5JxwN7myPKSxyPUU+2ON/c2w1hq8a+0+WoyHM
 PDbj9SljDPk4ndi0DZl0htrS5f55bCQmfaWmdA4I1faQg1Td8S7A6bIj2lIAMwm9J0fZs+53M+d
 8mtpxzDvoBAbpeLnAJyVsqDi3dsqZ9He2pCviaXTzei5QGvlLcft3v2igzcftuP4Iw1O2ZwEjtC
 nOgCjlZzni4LcoVJY1FWQ4AvWmkgD+qEceaV3ePpfnBuYmJOhZcUS1PzQKlc/3YM3YTX8c1uw3g
 xvnTW/PVnDTnJXzSB32/TO5P2qj6d9POQHfmXK4OnK0r+Wfu/1QWZbxBvE5/78xRU9JN6uA0ET2
 AG7m45ceS+2eDfVT6pB69uAio5KbPbuwnyeDWequy9/292tz2ZgL34/iF7EmnasJgxo9XJuX
X-Authority-Analysis: v=2.4 cv=Hst2G1TS c=1 sm=1 tr=0 ts=68307dbf cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=VlgjLVM6OR-Tcjh_F24A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: Ohdrffic0ugUGTTNQXpbuunrpuOTj1Yl
X-Proofpoint-ORIG-GUID: Ohdrffic0ugUGTTNQXpbuunrpuOTj1Yl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-23_04,2025-05-22_01,2025-03-28_01
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

