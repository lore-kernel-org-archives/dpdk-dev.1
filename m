Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C632CD98CC
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 14:22:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C3F84328B;
	Thu, 11 Jun 2026 16:22:29 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 11FE540276;
 Thu, 11 Jun 2026 16:22:27 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BCXVkm2094838; Thu, 11 Jun 2026 07:22:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=G
 zRL1t7k1Mpdrh3u99cV1eWN5/JcsUoEV1bR5z/YaZg=; b=kFh3ibu7o+ksOq2WM
 7WulcWOD+qfKOgFJuvXa5qMKCdofUTKCQVYsspScIJwFXoa1rlaMOQ+glSANXhuZ
 cJd7VsmUQmVSEABRVjxwH08qV+tg64eTMT9ENaQljN6PD6rnCq6VW0KQ0Ng7AouO
 IfxoFXte3uPUynsy4LSACKuWiJySRkjJQq140B5JAfinO4syQu2FgHI9wxpppP+4
 6EFYy4YH/dv/6zimhX0EN/Hr+A37BiNQAFL/aYe/64aXyBNF27IEOjZcLmCcmgea
 x73xi4i+KKbhaUa443nkQL2Sm/1WVS16emb2Gu1sorDDmyaGjg9gtTWj509ECosp
 aUX6A==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4eqe5w373q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jun 2026 07:22:27 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 11 Jun 2026 07:22:25 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 11 Jun 2026 07:22:25 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 943A25B6974;
 Thu, 11 Jun 2026 07:22:22 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Ankur Dwivedi <adwivedi@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Tejasree Kondoj <ktejasree@marvell.com>, Akhil Goyal
 <gakhil@marvell.com>, Archana Muniganti <marchana@marvell.com>
CC: <jerinj@marvell.com>, Aarnav JP <ajp@marvell.com>, <stable@dpdk.org>
Subject: [PATCH v2 21/22] crypto/cnxk: enforce DES/3DES cipher key length
Date: Thu, 11 Jun 2026 19:50:28 +0530
Message-ID: <20260611142029.3351415-21-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611142029.3351415-1-rbhansali@marvell.com>
References: <20260611073311.3129711-1-rbhansali@marvell.com>
 <20260611142029.3351415-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE0NCBTYWx0ZWRfX4+L1Cxfa1Y2o
 NHHfrxVQ9idj88Z3eVpKMSI7JR6BCv0vKSgqR21N+jcgkI0v09toVOyEofK0mCEEMIZE8brzmwm
 KDZGVzNnMFzzjkyK092mw51gdBZ8uzCVSy/UXskE2KucEwWHF3vXskPu8trUzFQ51vpDwqVq+pj
 Fbro1z5mHCiLC/TNjwshyM3qCGi/jzwqc279rXpsA8U759XA8WIyImZCdy1lTarN14KZc46vP7h
 dxFEga87VjEOp82HK/Ji+s+DCxMHvL44VHCof+SYg+z9Dc2eiXCtzXtirpWDqxu6ls2PhdaTWgF
 nOehyU5zCo5p+Vp2Uny79VAp/y/StxZp+lJhneSsOBHbeE1Obia5k8EYzz8If19IUVdfqbkynpL
 +BRQ5UkYHJdQOmvP+f0RlYsRtZm71I9vH7DRvo0WSrTiQw8BOxd8y09vxuwYtEsBq4xv7GtA7B7
 vBoTc1UbMYDuYGwC8sw==
X-Authority-Analysis: v=2.4 cv=fv7sol4f c=1 sm=1 tr=0 ts=6a2ac4a3 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=jwvoJd_qqrhi80_Aq6MA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE0NCBTYWx0ZWRfXzXWHbhxXcUha
 oIGk0fjCJ+ZEwAOw+jqTXeA7cpS6SCSe++LCWVziTfPdRNIEkTwve1VuSw2aK3gz76X2V0vSPPf
 SqIBDwpmS1BI4U3+nUiJbvo/xUqMvCQ=
X-Proofpoint-GUID: jrbhpEd3ih292jbTERXJOz_Dxdz1qYHF
X-Proofpoint-ORIG-GUID: jrbhpEd3ih292jbTERXJOz_Dxdz1qYHF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_02,2026-06-11_01,2025-10-01_01
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

From: Aarnav JP <ajp@marvell.com>

Enforce exact key length match for DES/3DES algorithms
in fill_sess_cipher(), since these have fixed key sizes
(8 or 24 bytes). The existing check only enforced a lower
bound, allowing oversized keys to pass through.

Fixes: eb43e39851b8 ("crypto/cnxk: add cipher operation in session")
Cc: stable@dpdk.org

Signed-off-by: Aarnav JP <ajp@marvell.com>
---
Changes in v2: No change.

 drivers/crypto/cnxk/cnxk_se.h | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/cnxk/cnxk_se.h b/drivers/crypto/cnxk/cnxk_se.h
index 8dbf3e73c7..e2d7e10ec9 100644
--- a/drivers/crypto/cnxk/cnxk_se.h
+++ b/drivers/crypto/cnxk/cnxk_se.h
@@ -2297,9 +2297,14 @@ fill_sess_cipher(struct rte_crypto_sym_xform *xform, struct cnxk_se_sess *sess)
 		return -1;
 	}

-	if (c_form->key.length < cipher_key_len) {
-		plt_dp_err("Invalid cipher params keylen %u",
-			   c_form->key.length);
+	if (enc_type == ROC_SE_DES3_CBC || enc_type == ROC_SE_DES3_ECB ||
+	    enc_type == ROC_SE_DES_DOCSISBPI) {
+		if (c_form->key.length != cipher_key_len) {
+			plt_dp_err("Invalid cipher params keylen %u", c_form->key.length);
+			return -1;
+		}
+	} else if (c_form->key.length < cipher_key_len) {
+		plt_dp_err("Invalid cipher params keylen %u", c_form->key.length);
 		return -1;
 	}

--
2.34.1

