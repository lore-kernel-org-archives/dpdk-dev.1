Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2B48C54FB3
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 May 2025 17:02:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 692D340E13;
	Mon, 26 May 2025 19:00:13 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id BBCC440BA2
 for <dev@dpdk.org>; Mon, 26 May 2025 19:00:09 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54QA8Nt2022620
 for <dev@dpdk.org>; Mon, 26 May 2025 10:00:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=R
 EU0Va8rrH/1BfOThF4wQvzUqVr7qYMmbzT9cN9tKFE=; b=cXOfn8KWCIKDXJeCv
 iTyxrKzy/Ayw0lAITbI0iuKJZoygEED2LKBUuGtKAgYZJ/KzFub3t33bSiLFyQ5/
 eXQbYAZQRHpFGt6VzooWvNWP7bu0ih4zeCGVKpr7HUUHGsZffJy0usUThdXw4HjM
 TZd6HLNm5qkpLUNJKtMwpmHsip1DW9K2myLmUO9IQOsYrpIeMryw5UIK3ttc6amW
 sDteL9B8iYaEDbg+P/73t/wluYOo4aEbC6hesilRx4yF1+LWWks20710wg2Xpgb5
 PGCzmpOJpG4QjndtsbxW34cNvElRwfSiyp6Cqfmx5cKJK04i30H4z94ALjGZDSsf
 0IgTg==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46vp9krpeq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 26 May 2025 10:00:08 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 26 May 2025 10:00:07 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 26 May 2025 10:00:07 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id BE2913F7069;
 Mon, 26 May 2025 10:00:04 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Nithinsen Kaithakadan <nkaithakadan@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Aakash Sasidharan <asasidharan@marvell.com>, "Rupesh
 Chiluka" <rchiluka@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH v2 32/40] common/cnxk: fix salt handling with aes-ctr
Date: Mon, 26 May 2025 22:28:11 +0530
Message-ID: <20250526165819.2197892-33-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250526165819.2197892-1-ktejasree@marvell.com>
References: <20250526165819.2197892-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=VYn3PEp9 c=1 sm=1 tr=0 ts=68349e18 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=ADimZIIzWdH1LguBofUA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTI2MDE0NCBTYWx0ZWRfXz2TzXD5IGlI1
 qgG5u8IhPKPm0LGKrY7+FHKH3kfIFyocoAzhQd25Xkk96D61oHkBG0/E3oIWVbPTbe36X/V922G
 WqKF6zisb/td2A5/Uz/hAo97AZZr2Y2vYCTIR/No7xgN5PJdXgMbiInonKZPsjazUEQBmtav8CS
 eT2QJeHYzdUj9Q6Tj4oi7+BptvhK1EZHQc46iHWPbE7xTpLUpF5meQlF1wJUXK+9W5Ah92vPm8L
 ZpeAa9JCTplXRwxFXYTtrH59wXIVrR8SAXJxrIHbM6uwYMyzB2oeTuyDq+hIf1yj5I/YflwQwqq
 Fjka98bJmqyYfLSpWRKe7tnc7z8ZdMWF7b6Wa6mA1VlLc9t6+YTQ2UxxopjYQt2JbBm11A1D80K
 QhW12XtF5s2d4YRmNXH2AlkdeTCk5m+OE5vUmVOCTfEtUu135a0GpLa3TvfGwmkc1WfpiMIo
X-Proofpoint-ORIG-GUID: 0cdCjrlJeTQN63WE3QwHEvMJ1EnMVJp7
X-Proofpoint-GUID: 0cdCjrlJeTQN63WE3QwHEvMJ1EnMVJp7
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

