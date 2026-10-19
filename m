Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA0ACCF2DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 13:08:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5AB40406FF;
	Mon, 19 Oct 2026 15:08:17 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 7697340A67
 for <dev@dpdk.org>; Mon, 19 Oct 2026 15:08:15 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69J8OdNB110851 for <dev@dpdk.org>; Mon, 19 Oct 2026 06:08:14 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=W
 YGKH+d/jf7caz6abv4YvegEBowzZiFzDDc25IqXy48=; b=hoftXjkHAON0Ih5cN
 ImhBfc7mj58R+UprZKAEJE6D+IKpHNfrIXPmrNEjSyVVbqMq+n5wVs5gCkSos9Us
 fn0HRgfPJQh29twasqyVU1BWX1+rR0MC3nU7yZ/XdTbBJZCcQj1VdJIfPAJwRWgL
 44aXi4EV2hG9zFLyiZDytGoMFUb1Xmm+gNDMez7VYC4w5v+dlIK5rhR4tJfJoCQE
 zIXd5R1ZJg9W+hLTJbJLx+imI5w5lBLjNeVusvngNnmATNVm9gpSrj1g5YfowrFQ
 QK+eyFZvoMICJZT7xY0AWx4tbVBbslKQU3bz2AcYKY/3c5acdJKwvIWl7SombzS7
 ETSqw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4hc8hh4ynu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
 for <dev@dpdk.org>; Mon, 19 Oct 2026 06:08:14 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 19 Oct 2026 06:08:13 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 19 Oct 2026 06:08:13 -0700
Received: from cavium-System-Product-Name.. (unknown [10.28.38.254])
 by maili.marvell.com (Postfix) with ESMTP id 8F5DC3F704D;
 Mon, 19 Oct 2026 06:08:11 -0700 (PDT)
From: Tejasree Kondoj <ktejasree@marvell.com>
To: Akhil Goyal <gakhil@marvell.com>
CC: Rupesh Chiluka <rchiluka@marvell.com>, Anoob Joseph <anoobj@marvell.com>, 
 Vidya Sagar Velumuri <vvelumuri@marvell.com>, Ankur Dwivedi
 <adwivedi@marvell.com>,
 Nithin Dabilpuram <ndabilpuram@marvell.com>, <dev@dpdk.org>
Subject: [PATCH 04/16] common/cnxk: validate cipher key length in IPsec SA fill
Date: Mon, 19 Oct 2026 18:37:45 +0530
Message-ID: <20261019130759.2181566-5-ktejasree@marvell.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261019130759.2181566-1-ktejasree@marvell.com>
References: <20261019130759.2181566-1-ktejasree@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: FozqFRMlpwEx9D7UqIP96itScfKCAQS9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfX9eejTqFuv2AA
 pbxQ7gAfG+SLCHpzajiPtgEY6lBxY543NxjFGO6+LatEAiSxkyOBkUeBn6hnN8DoKQ01BdN/GE5
 zoCsx3XLIaIcOLJmI+oLosxqceePfXmhvSk3g4/Auzok6SSBKn9Zmmg7heiiObieDjISwFB84wx
 6vwIe7I+W+Ar/piwGvQPTv7rPbyf4Ar3YgxrpDue0ckuiOm557Wr/6JMzRjQGL6nFoKRQJV9wJh
 uNizwWLFhT6DVxMSwsyMVRdC+FK85F2OKGTt3CZrKrPpoJsg+Jc3zJL4C+VTzYqtCQb6ZK9YSzK
 jHC+bO0WfKFmink33rtRULqFzXAyUJhco2P+/TW3eadM62ahDZO+p5mobgaDiM4zBVnjaQcC2DN
 IC39cm92GaMtEZ2sxRJoh83D3qJM9x3E25vpNNK5nIQ4sFLLUP7kzt/monqmmN7/byKV8oVmi6D
 OtSAyWSdVZ5C7X8C+Xw==
X-Proofpoint-GUID: FozqFRMlpwEx9D7UqIP96itScfKCAQS9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA1MiBTYWx0ZWRfX6VHdy8Py+f/F
 A9ZW9GaOqoYZAHCd3LyEpqe6S313bSIeDwNGK40rH0znk7kEZKB8g++B/ig5607I8swCYdXA/b4
 X/3yiLa2zUy0mNamjIdUfXnzU3h40kU=
X-Authority-Analysis: v=2.4 cv=LfupeTfi c=1 sm=1 tr=0 ts=6ad6163e cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=QXcCYyLzdtTjyudCfB6f:22 a=M5GUcnROAAAA:8 a=_AboNblhVP8p39PiMyoA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_03,2026-10-14_01,2025-10-01_01
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

From: Rupesh Chiluka <rchiluka@marvell.com>

The IPsec SA builders copy the cipher key into the fixed 32-byte
SA context field via memcpy. The per-algorithm length validation
only runs for AES/DES/3DES and AES-GMAC, so a NULL-cipher SA with
a non-zero, oversized key.length skips every check.

Reject any key longer than the SA cipher key field with -EINVAL.

Signed-off-by: Rupesh Chiluka <rchiluka@marvell.com>
---
 drivers/common/cnxk/cnxk_security.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/common/cnxk/cnxk_security.c b/drivers/common/cnxk/cnxk_security.c
index 228ff2781d..9f734c16b1 100644
--- a/drivers/common/cnxk/cnxk_security.c
+++ b/drivers/common/cnxk/cnxk_security.c
@@ -170,6 +170,10 @@ ot_ipsec_sa_common_param_fill(union roc_ot_ipsec_sa_word2 *w2, uint8_t *cipher_k
 	w2->s.spi = ipsec_xfrm->spi;
 
 	if (key != NULL && length != 0) {
+		if (length > ROC_CTX_MAX_CKEY_LEN) {
+			plt_err("Invalid cipher key length");
+			return -EINVAL;
+		}
 		/* Validate key length and set AES key len before copy to avoid overflow */
 		if (w2->s.enc_type == ROC_IE_SA_ENC_AES_CBC ||
 		    w2->s.enc_type == ROC_IE_SA_ENC_AES_CTR ||
@@ -1012,8 +1016,13 @@ on_fill_ipsec_common_sa(struct rte_security_ipsec_xform *ipsec,
 		}
 	}
 
-	if (cipher_key_len != 0)
+	if (cipher_key_len != 0) {
+		if (cipher_key_len > (int)sizeof(common_sa->cipher_key)) {
+			plt_err("Invalid cipher key length");
+			return -EINVAL;
+		}
 		memcpy(common_sa->cipher_key, cipher_key, cipher_key_len);
+	}
 
 	return 0;
 }
@@ -1403,6 +1412,10 @@ ow_ipsec_sa_common_param_fill(union roc_ow_ipsec_sa_word2 *w2, uint8_t *cipher_k
 	w2->s.spi = ipsec_xfrm->spi;
 
 	if (key != NULL && length != 0) {
+		if (length > ROC_CTX_MAX_CKEY_LEN) {
+			plt_err("Invalid cipher key length");
+			return -EINVAL;
+		}
 		/* Validate key length and set AES key len before copy to avoid overflow */
 		if (w2->s.enc_type == ROC_IE_SA_ENC_AES_CBC ||
 		    w2->s.enc_type == ROC_IE_SA_ENC_AES_CTR ||
-- 
2.43.0

