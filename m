Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55225C54F30
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 13:02:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A06540687;
	Tue, 27 May 2025 15:02:03 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 4AEB24067A
 for <dev@dpdk.org>; Tue, 27 May 2025 15:02:02 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QNTsgF001051
 for <dev@dpdk.org>; Tue, 27 May 2025 06:02:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=E
 R/Rdt4uMDMRIcH6i4HvAsNBJcHfVqRIlI19YGsuW0Q=; b=jqT1LjSMNzkygm8FN
 BZI6AyY+vEQhn6DWj9f8Xu8rl5uR2k4oJ2AIoPknjk2v1g2emlP7AI3aLbA7YATa
 vm/D3bcH9C9lc+TNkw+OTyryiAJh24FJ+AaRcao75pZdeCnZI9w9TGAhUku9Fl5c
 pdG1u9JVNyYZm/ArwjMYbFbuQoFuHcFHxsaPhB9HLZ3gem6zZQtpn3h9zObvqKyT
 c4/jf9/0EWPXDX9G8X0URsuRG4DQdTamqHep/BjJI3gBadfQZfu+00J+mtDvliFr
 1e9bUkf0pX+exvfgrf/BiYMMmH69Ttx9FCsZL+J8nJiNA8W5qXzZZGIG0FFMD49w
 nALkA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46w21299pu-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 27 May 2025 06:01:57 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 May 2025 06:01:47 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 May 2025 06:01:47 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id E24153F705D;
 Tue, 27 May 2025 06:01:44 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Nithinsen Kaithakadan <nkaithakadan@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Rupesh Chiluka <rchiluka@marvell.com>, "Vidya Sagar
 Velumuri" <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 3/9] common/cnxk: set correct salt value for ctr algos
Date: Tue, 27 May 2025 18:31:29 +0530
Message-ID: <20250527130135.2301726-4-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250527130135.2301726-1-ktejasree@marvell.com>
References: <20250527130135.2301726-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=H6zbw/Yi c=1 sm=1 tr=0 ts=6835b7c8 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=VlgjLVM6OR-Tcjh_F24A:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: ztElFyZXX0keb8M34GsNZz2G5-hygb-O
X-Proofpoint-ORIG-GUID: ztElFyZXX0keb8M34GsNZz2G5-hygb-O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDEwNiBTYWx0ZWRfXyndMKzvA2A2h
 JeoQoojOyrhd/RCokJpopp6fp3jAGSB8jmFiucZpV1qjHDt6GZQrMYGmyireXc9zUXAaddfyFsj
 +rUZeskVX+RMBy1abUzNVHUQ2/gTFukJooC4t46EDqqF0gZNqxM1Vuiv5ioYuRTv3nZHHYoh3q8
 g0fZ75zTiXuL78SrGjy/AYae/PojV4vllt9861UQCU6nGlqT7k5CPYrnc2DX/eG9yiTW+qFpp9p
 ej+j4e9PUDoCz3DNbOqNG/2tVKeBMAtU1TS0xfj6fVt8kkcYbDF3G1asXbc+yGvp3L7VwV9jUa+
 BuRAPJMw0ABD13YCQuyu0d0UugmCMhYcWjVsv31u7IjGr0DYV6fkSe5O8tybfK5z/UpexmDJG6I
 f5hRvlvmX9+3uY0SxYXmFOYzXkexg1jDuNKppJU0vn9kZffAhg6QO/9efv/4ngXyGsmu6c4j
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-27_06,2025-05-27_01,2025-03-28_01
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

