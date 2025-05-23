Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E66C54ED0
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 May 2025 13:55:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A22ED40EE7;
	Fri, 23 May 2025 15:53:02 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 0A23240EDD
 for <dev@dpdk.org>; Fri, 23 May 2025 15:53:00 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54NBAf11031533
 for <dev@dpdk.org>; Fri, 23 May 2025 06:53:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=R
 EU0Va8rrH/1BfOThF4wQvzUqVr7qYMmbzT9cN9tKFE=; b=ad8/yAAOysll3B3ZB
 y+5PQjRY3cJ0HAqIIM7QIcRdcswnk439Uk5nlGjc45fzQ/54eqO/I/KZ9p4OmDs+
 FXB8JpEYcqtLfVo2C0WN+VgUGXKM6sugR75DgrOJ1ykW9gt2fG8ayrYeul13Jp87
 j2/FgWzMT0cF63TKoZgD3MWZFPnfiupoQYWGIM/elqn21AKww25BhUQGyG7o1sHG
 eASTXbi46R71fYWBe0R/xbrkYHgqXWhoaFJCRQiVdRorhLnMrskpQyEnjVLe9QgR
 0wg7cPwKokGkQlzae/tZLRpObW9Hf22PyKli0xL2yPWsSXEYVnl5BO4sjX338G0X
 WA07w==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46tqw589jd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Fri, 23 May 2025 06:53:00 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Fri, 23 May 2025 06:52:59 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Fri, 23 May 2025 06:52:59 -0700
Received: from hyd1554.caveonetworks.com (unknown [10.29.56.32])
 by maili.marvell.com (Postfix) with ESMTP id A97833F7041;
 Fri, 23 May 2025 06:52:56 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Nithinsen Kaithakadan <nkaithakadan@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Aakash Sasidharan <asasidharan@marvell.com>, "Rupesh
 Chiluka" <rchiluka@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 32/40] common/cnxk: fix salt handling with aes-ctr
Date: Fri, 23 May 2025 19:21:03 +0530
Message-ID: <20250523135111.2178408-33-ktejasree@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250523135111.2178408-1-ktejasree@marvell.com>
References: <20250523135111.2178408-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=F8xXdrhN c=1 sm=1 tr=0 ts=68307dbc cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=ADimZIIzWdH1LguBofUA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIzMDEyMyBTYWx0ZWRfXyT7L/re+iCK8
 w5l2ktdvp+K/QbZChmQ5lpvAIYBGyV9E6d2JMxuQuz7NYLmwLT67KgzuY+P6CvpioTW054KO6P/
 ee1AuP9KZoXSYe9Vn1+9VGrjA7MOO+zhLDoC748RsVBWQLp7GgmM+CQKt7ITmkHN3mxTju4hOzi
 TCj5lSmQL8aPEsamdjk00Nynauj9Bi62fH+FFW+d7nEvcsLtPjSZuT0aRnaCNRk+tgphFYx9tw2
 58aFf1ReG6G45KX1qGROyY/QD0iqWZd+EyXvjBVHU4iVp7e/J1vbV7OQdN+NeoqE3qjtJLOvdGA
 O9GDWysA+7790bsdPQxkKzdnNQQnVeJ3tCBsYmXhf5BEuONwhfnM4crvgzIM3u3bEj6XxbI3ebh
 X/CSZ7t4Ndos4O3zuqjArT9UHKLmtgkkmUax2n33LlHtN1GAPIAndxBCnI0cAyFxvEcFz8xa
X-Proofpoint-GUID: lYd1kMmN7hyWKihG2PcpuWZ-9D1YCiaM
X-Proofpoint-ORIG-GUID: lYd1kMmN7hyWKihG2PcpuWZ-9D1YCiaM
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

