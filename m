Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 387A5CD98DA
	for <dpdk-dev@archiver.kernel.org>; Mon, 15 Jun 2026 16:27:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D467040B8D;
	Mon, 15 Jun 2026 18:27:27 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 2905B40A67;
 Mon, 15 Jun 2026 18:27:26 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65FFc6OW1125351; Mon, 15 Jun 2026 09:27:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=q
 xdk9oXLVp6BXAIV1w3ZdcmH4696d5KSm5V0bnRJdJE=; b=gwFsfW0xUDZ7aZzQt
 OBP5cByLj336cVC7NuL8jXP5ahtGIOJ6WDNcK33ctQ3Vy/gQ44dYujF5YG2g4oxC
 hkfACD5Yoqa6ydzCbFD4AUYvnYdjA7AtrOzVRJQDEPiXroJ4lnYJV2REYLTBx8ru
 277/rxv+KdaMKr714Xo7uEg0mAMIeISDanb5kXGsxmpeXaLYv7yxVmsqF6ITbkti
 GQqllSCqKsx5oMSqRtUIyVAbexwhPvYZ7a5dfyawlmyLGvLMNJSGz9m5nNiC7cz5
 UyST2SOhnGIjWxJKR5GOWjHoVg7tuICiXk+cenRH84Mz190TOZqOMuYn2jdq5VG2
 i6gxQ==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4es4jk06b2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 15 Jun 2026 09:27:25 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Mon, 15 Jun 2026 09:27:24 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Mon, 15 Jun 2026 09:27:23 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id ECB873F7065;
 Mon, 15 Jun 2026 09:27:19 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, "Archana
 Muniganti" <marchana@marvell.com>, Akhil Goyal <gakhil@marvell.com>, "Vidya
 Sagar Velumuri" <vvelumuri@marvell.com>
CC: <jerinj@marvell.com>, Aarnav JP <ajp@marvell.com>, <stable@dpdk.org>
Subject: [PATCH v3 17/20] common/cnxk: add auth key len check in inbound SA
Date: Mon, 15 Jun 2026 21:54:43 +0530
Message-ID: <20260615162446.578336-17-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260615162446.578336-1-rbhansali@marvell.com>
References: <20260611073311.3129711-1-rbhansali@marvell.com>
 <20260615162446.578336-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: A-wjMPE6w5DHyxUpRRpQTEJNJUux1K_n
X-Authority-Analysis: v=2.4 cv=OaKoyBTY c=1 sm=1 tr=0 ts=6a3027ed cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=EAYMVhzMl8SCOHhVQcBL:22 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=RWGwor0Ld7hqSKGVtXEA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE3NCBTYWx0ZWRfX5gB2Q3pzT2x1
 +9PJlNZV8VywZ2ZqxKaOTk7X/uIamaqNi9NIHN9/Cg4Ajs0hacDKKKLmyJzen8KLXgzTMIr4zgL
 vFzOzTv8xmhn9bUs75Kp5Mp6lRjfzME=
X-Proofpoint-GUID: A-wjMPE6w5DHyxUpRRpQTEJNJUux1K_n
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE3NCBTYWx0ZWRfX0ANw93uu539Q
 79iJTr+KpSLQWZsdmmGiaUyd29ycwGvxBt3D3JOZEV3LozuYRp30ZE4Km9BfHEkaX3zQaS4qhcS
 Dr6dzx7ZWydb7uxMwDEpbBe1MKw2iYMOEtjDT4lHmYDqs9EsxMD4sx26iYJkR3wWRA3ON8bZ4gP
 qRwq8LtQ5UOuX51sHLpDkUPIgofWb5UxvyUbpe7mPj8zrbFNi0V/4x5P5YTyeJquJ1t/QWJtvYy
 5OC7CGRk9U7sWTulNvM/McedGOxYA/7+FjB0MXn258MXVGyyRLQHSaKZ/brhrADpfaKgE02bWmt
 VcauRe/0YaGIBoqUWeH0dxnjE0GrugZSCtszFhbfQzp/kXRUoNiSJDdzFYgcdkpME2zlz2iXczW
 7PLiX7pZ4NinLMoAiYB8UWCpXz+xWF9GJ/T7gN3p4U1C9yceXeQcPXicqJsk4U/HMV3oOma1dmp
 Zm9qDNmq+6W6zc+jPNQ==
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

Add auth key length validation before memcpy in
cnxk_on_ipsec_inb_sa_create() to prevent caller-provided
keys from overflowing fixed-size in-struct buffers and
corrupting adjacent fields.

Fixes: 532963b80707 ("crypto/cnxk: move IPsec SA creation to common")
Cc: stable@dpdk.org

Signed-off-by: Aarnav JP <ajp@marvell.com>
---
Changes in v3: No change.
Changes in v2: No change.

 drivers/common/cnxk/cnxk_security.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/common/cnxk/cnxk_security.c b/drivers/common/cnxk/cnxk_security.c
index 6f46ad3276..228ff2781d 100644
--- a/drivers/common/cnxk/cnxk_security.c
+++ b/drivers/common/cnxk/cnxk_security.c
@@ -1199,22 +1199,33 @@ cnxk_on_ipsec_inb_sa_create(struct rte_security_ipsec_xform *ipsec,
 			break;
 		case RTE_CRYPTO_AUTH_MD5_HMAC:
 		case RTE_CRYPTO_AUTH_SHA1_HMAC:
-			memcpy(in_sa->sha1_or_gcm.hmac_key, auth_key,
-			       auth_key_len);
-			ctx_len = offsetof(struct roc_ie_on_inb_sa,
-					   sha1_or_gcm.selector);
+			if (auth_key_len > (int)sizeof(in_sa->sha1_or_gcm.hmac_key)) {
+				plt_err("Auth key len %d exceeds max %zu for algo %u", auth_key_len,
+					sizeof(in_sa->sha1_or_gcm.hmac_key), auth_xform->auth.algo);
+				return -EINVAL;
+			}
+			memcpy(in_sa->sha1_or_gcm.hmac_key, auth_key, auth_key_len);
+			ctx_len = offsetof(struct roc_ie_on_inb_sa, sha1_or_gcm.selector);
 			break;
 		case RTE_CRYPTO_AUTH_SHA256_HMAC:
 		case RTE_CRYPTO_AUTH_SHA384_HMAC:
 		case RTE_CRYPTO_AUTH_SHA512_HMAC:
+			if (auth_key_len > (int)sizeof(in_sa->sha2.hmac_key)) {
+				plt_err("Auth key len %d exceeds max %zu for algo %u", auth_key_len,
+					sizeof(in_sa->sha2.hmac_key), auth_xform->auth.algo);
+				return -EINVAL;
+			}
 			memcpy(in_sa->sha2.hmac_key, auth_key, auth_key_len);
-			ctx_len = offsetof(struct roc_ie_on_inb_sa,
-					   sha2.selector);
+			ctx_len = offsetof(struct roc_ie_on_inb_sa, sha2.selector);
 			break;
 		case RTE_CRYPTO_AUTH_AES_XCBC_MAC:
+			if (auth_key_len > (int)sizeof(in_sa->aes_xcbc.key)) {
+				plt_err("Auth key len %d exceeds max %zu for algo %u", auth_key_len,
+					sizeof(in_sa->aes_xcbc.key), auth_xform->auth.algo);
+				return -EINVAL;
+			}
 			memcpy(in_sa->aes_xcbc.key, auth_key, auth_key_len);
-			ctx_len = offsetof(struct roc_ie_on_inb_sa,
-					   aes_xcbc.selector);
+			ctx_len = offsetof(struct roc_ie_on_inb_sa, aes_xcbc.selector);
 			break;
 		default:
 			plt_err("Unsupported auth algorithm %u", auth_xform->auth.algo);
--
2.34.1

