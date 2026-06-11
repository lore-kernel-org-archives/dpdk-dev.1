Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7352FCD8CB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 07:35:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8082542EFE;
	Thu, 11 Jun 2026 09:34:49 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id D67FB42EEF;
 Thu, 11 Jun 2026 09:34:47 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65B0QWQp757732; Thu, 11 Jun 2026 00:34:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=d
 yqj8yqpxJKu+aebXuVEIByb/2XmOU6zak3fr9ZiNBc=; b=HRWDPqZREISVvaS5A
 ReXVWKRv5FavFotQs6Mn84QyEcew5NpPmw+wyQ1vUi5MluJE0h25uu5B9qVGZpbV
 vSWalTgvyvhcIm2Cc8wDtpO0Ds/tsu2kvU6KQenQuctwAIqeu9+B8dWiJUgtHHDr
 UXyPa3vtG0ztRbpp/vjCUgJPbdCLvHwvc7eRMcmfxVLBEENdPBZ3cm5twQXwXSk+
 H4Pf/LZwgWwK74x4djv77FkqJbphcWt3IBkQO7QjB11ULZN0ixRPNu0u3PFf56bX
 rrC4tghypeAHAJpIXhZyBAfAUYFwThMmBbvaQxOVBYVjqGh3IJ2mSZS3t2N73m1N
 hb1zA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 4eqe5w1xv6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jun 2026 00:34:46 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 11 Jun 2026 00:34:45 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 11 Jun 2026 00:34:45 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id E59065B6973;
 Thu, 11 Jun 2026 00:34:41 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, "Archana
 Muniganti" <marchana@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, Akhil Goyal <gakhil@marvell.com>
CC: <jerinj@marvell.com>, Aarnav JP <ajp@marvell.com>, <stable@dpdk.org>
Subject: [PATCH 17/17] common/cnxk: add auth key len check in inbound SA
Date: Thu, 11 Jun 2026 13:03:11 +0530
Message-ID: <20260611073311.3129711-17-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611073311.3129711-1-rbhansali@marvell.com>
References: <20260611073311.3129711-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDA3MyBTYWx0ZWRfX2eHfZ2sOvi8U
 W+YrO/7vsiknv8kFI6GgBM58vkRJzLYZYO+Zrwn5X4eu1Ih7fz8fevxNwUvY1MY+qu6JNi2WF+p
 bvp2QlCZZe81++KOVYNE33ZSEQcUb1KSVa889KKZ5zPskmjyvlLMRqrBc6FtZQRW5sTllI0M0ji
 LMsdH+aBJjpJPB8IKUdvMdpxLs7VfO4qeX/RixEqm+YGlhPwzYtqq37Sw8bgPvK8FuGOv+/OyWJ
 xpSYpVsxtWa6se8yQTKzYAGFv6UF1c/4Xrbx8KRX65osENNEiXnTI4GxK/sExP5Vrj5VZe4i/xm
 We9ZI3+muyv8oH5Uwwdi7E8yLygPoj9Sq+TKeMb7fJX6OSk4WcnQMdSEybAhCZGlIZKRj0kBWfp
 F2Xl+nEqYlEgwKugzwLVHhM1EZNno5IvZMS6cNJ3JX8bbgB4pRSar1Ema8miPN+lS0AT1VzeyBz
 UpyV4/AvwQv+/UTW3jQ==
X-Authority-Analysis: v=2.4 cv=fv7sol4f c=1 sm=1 tr=0 ts=6a2a6516 cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=TtqV-g6YmW1Jfm2GSLaY:22 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=RWGwor0Ld7hqSKGVtXEA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDA3MyBTYWx0ZWRfX3/yCf/7jJkgo
 o1WND/iHh7pI0NPcRsY98Nh5d4Kkf0SiMTkyj7Ildi2i0OBXZc5871aXDjQDOtnm1+p5r5GtSh3
 O2CaOC0WfiY+s1yrahw6oXWRZK/PlmA=
X-Proofpoint-GUID: yWq2xcBaiMI3iUvXS3AfPy5XfDdpuKEy
X-Proofpoint-ORIG-GUID: yWq2xcBaiMI3iUvXS3AfPy5XfDdpuKEy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-11_01,2026-06-09_02,2025-10-01_01
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

