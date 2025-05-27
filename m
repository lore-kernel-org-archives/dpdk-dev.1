Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB768C54ED1
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 May 2025 13:02:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 382C040395;
	Tue, 27 May 2025 15:01:56 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 7D4E3402A0
 for <dev@dpdk.org>; Tue, 27 May 2025 15:01:54 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QNTsg4001051
 for <dev@dpdk.org>; Tue, 27 May 2025 06:01:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=R
 EU0Va8rrH/1BfOThF4wQvzUqVr7qYMmbzT9cN9tKFE=; b=kyljkn2UlYqLoGxQK
 W93xsnc4oxAA7gbnfogxXtPIYYxOoU/APbBFttGeRm+lfgDrU9Do45zYhoQMiYiw
 sRF0ubqKzfvxr35o4JMepHq6wJvUzWzBiXX8BZJJ+ENePe/Z1nWjAb1q6/ZcmTzh
 sb4d3kKnxVfTEACE9E2v+ezTppBh5aB5k1/acqOlIPKhiIkNKQRYs7BH3BJN5531
 Vkj9ZlmnsbHOVSeVglGv+HoUnOYhHwF3F28MS4S0Ynkrq2RccxOMzU4RU9eb/Uqf
 rVOgfiT/nRWdPj+LPwKmKRcyn+tQVwmLSSYOU0AmavaHqnGiqACKGPUZQcfzx4EK
 muTLQ==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 46w21299pu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Tue, 27 May 2025 06:01:53 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 27 May 2025 06:01:44 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 27 May 2025 06:01:44 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id 0FC983F705D;
 Tue, 27 May 2025 06:01:41 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Nithinsen Kaithakadan <nkaithakadan@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Rupesh Chiluka <rchiluka@marvell.com>, "Vidya Sagar
 Velumuri" <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 2/9] common/cnxk: fix salt handling with aes-ctr
Date: Tue, 27 May 2025 18:31:28 +0530
Message-ID: <20250527130135.2301726-3-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250527130135.2301726-1-ktejasree@marvell.com>
References: <20250527130135.2301726-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=H6zbw/Yi c=1 sm=1 tr=0 ts=6835b7c1 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=ADimZIIzWdH1LguBofUA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: 4TzCKtq3fsC4QuBGR8pE-rW_8WozkexH
X-Proofpoint-ORIG-GUID: 4TzCKtq3fsC4QuBGR8pE-rW_8WozkexH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI3MDEwNiBTYWx0ZWRfXw6KqaBfjBIJm
 3al+PDGZJddzI/SRweSMpuhDDAM+8r9VIr+pGjtgHf2wBodfsuJaZeEA99YbPLe8qj1JYaB0M9d
 6KsXCLnY6ev0W7DvNGmebhDrQj12N+lRBY1YIRDsWIZnp6sHFxt8eJCDaVBjIP3IRSdzNLxgNa7
 pWoI4eQtk1AUGtYlJ+h8wtDVRe0k4/2LBOGjWp49fMK6w+SQmUuGdFTHEqrsv/M7d6r+jvGamEU
 RsPgvMv2k6nw5SEHcqG4yPikGANThsSh45XsU/VTp5dJ3xjot2KcVotfpje1fTDpF5bRQi1cSu5
 t4+kwq6VbqUa/5SriamG/9XIn/bzGaDrqYSKg0fITV0GxctLr+eRm7Mfc8DzQYDv2InZBdAiet6
 MDg1aNxNkKbc/f72KgXKdJA+hOvCD659FTEZJ175MEDPcDJfVTfdcXVVXNi8Gq3V5MoUaUAq
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

Fixes: 78d03027f2cc ("common/cnxk: add IPsec common code")

Signed-off-by: Nithinsen Kaithakadan <nkaithakadan@marvell.com>
---
 drivers/common/cnxk/cnxk_security.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/common/cnxk/cnxk_security.c b/drivers/common/cnxk/cnxk_security.c
index ea3b87e65c..62ae7b9b2e 100644
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
-- 
2.25.1

