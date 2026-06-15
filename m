Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08A47CD98DA
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Jun 2026 16:27:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F1DF740BA0;
	Mon, 15 Jun 2026 18:27:37 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 298D840B90;
 Mon, 15 Jun 2026 18:27:36 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FFbKpd279797; Mon, 15 Jun 2026 09:27:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=u
 wBScl6JW2NwaHJkUjobWuHwsxNoCr4Z4xY/cWlWuBo=; b=OoQfTTytPPG+/YCdo
 L8ykVrtlHt2KEBFZ/bKuyf9PgTZsJLTVPO92YixDzZgGbUNZ1nEPPbTplqjeB9gm
 J6u0oC3qOx+nL3QmmkW2hFK3+jGhIDgjPcDUMsm7tPCYacbwNuJ5N7wP+kBDRtnN
 o9USe+RWtvHZna31Pxph2eGlP2gXphgLG5u32rUgeiI5ZoAejQ+oDHIG5XwTb7rK
 Zi+CvRTv9d78Y53kCnn4ZbTf+AUvKaOS2faXPs0v+Gdo7t+PnmpW8+fMaxMwoIiY
 6823uKnRtbQMe7lDcVSIT60ppWtQNLWALViKrqW9gxcIWRGTCO8PFzuD5htUTDED
 A9O5Q==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4esuf8vptx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jun 2026 09:27:35 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 15 Jun 2026 09:27:34 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 15 Jun 2026 09:27:34 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 062893F7063;
 Mon, 15 Jun 2026 09:27:30 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Ankur Dwivedi <adwivedi@marvell.com>, Anoob Joseph
 <anoobj@marvell.com>, Tejasree Kondoj <ktejasree@marvell.com>, "Archana
 Muniganti" <marchana@marvell.com>, Akhil Goyal <gakhil@marvell.com>
CC: <jerinj@marvell.com>, Aarnav JP <ajp@marvell.com>, <stable@dpdk.org>
Subject: [PATCH v3 19/20] crypto/cnxk: enforce DES/3DES cipher key length
Date: Mon, 15 Jun 2026 21:54:45 +0530
Message-ID: <20260615162446.578336-19-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260615162446.578336-1-rbhansali@marvell.com>
References: <20260611073311.3129711-1-rbhansali@marvell.com>
 <20260615162446.578336-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE3NCBTYWx0ZWRfXxtT7aB4O2iPc
 ILJ/zVAeZrucI7O1j640W9g7qa98THHoDit8yA3CCf+i52DigyQO0QFLZnbGoBg6Qi7YS2hpJtl
 GIRHrTHMmXsW+ivTpbddq5RIvspCWf1/DffFroa8dU5cDFQm9xFBITmI4x6LNzzM+eEKlc6KiIR
 HeymsVt0vjmgDjCaq2EHxCahR7OOjrhhn/2leOKT063kSrzLOL5nVRlIcGd9q21eSuXGW32YCX+
 xLgbJ2dcoDpHll/G4LV5GiehmOiY0YfT7jH002+SWSXJ0nmDjxXFUT8G3w5/6DZcm3IYRsCGcE0
 UnR7oQf7gw1UxfwimS2NFpBooRgl7LsCy2Nyc4RxIyYK2TEV3dl9PM5pgyDc9ZLVGHFPYdkEviw
 43MUeiyd88v5aEmL8f0bFQCA+IzyWznZKkZ+pMf7WImhF83n0Awto1/3kGqbsYwlvF+4nt4eGda
 H499284Um9tFBlyYGuQ==
X-Proofpoint-ORIG-GUID: W3VdoJQiFf65fP8an3NOelTAf_V-HS7d
X-Proofpoint-GUID: W3VdoJQiFf65fP8an3NOelTAf_V-HS7d
X-Authority-Analysis: v=2.4 cv=KJZqylFo c=1 sm=1 tr=0 ts=6a3027f7 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=jwvoJd_qqrhi80_Aq6MA:9 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19
 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE3NCBTYWx0ZWRfX+ZjY/y/wUTPJ
 RDxx/PuH6eCPnI0aClYK8dH0BLTeVZQQR1gqPJphtA1TepFXWb9B0cZwNE6W5d/Lux3FVRAeetH
 o4BScoxEJoc34y0QPbKyL0i1ZPjI3Ns=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_04,2026-06-15_04,2025-10-01_01
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
Changes in v3: No code change. FEC patches removed from series and patches reordered.
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

