Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B80EBCD98CE
	for <dpdk-dev@archiver.kernel.org>; Thu, 11 Jun 2026 14:22:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EECED432B2;
	Thu, 11 Jun 2026 16:22:09 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id EEA17432B2;
 Thu, 11 Jun 2026 16:22:08 +0200 (CEST)
Received: from pps.filterd (m0431383.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65BCXfpS2190687; Thu, 11 Jun 2026 07:22:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=W
 qZyxrai84ZYXpjmD+RnLXflmbNEAnwSKhugE8OWYno=; b=Twn+iXgpHD41Z9OVs
 VRt4j9a3TxXobJE15quCTu4zDAVpOOOSlKym/E87+i5QSbA39I84aEggVYdb+yxj
 46KReWXsoHoExPyVV/z55ecAdzzlZxCwwpM4uwV+yRgI/9mbp1mamtfRm68bHUgK
 LZO91ZB0qOWxNM+xZ7SHvzr3HcIiFmJhfg4lxUqFjYKSo1xYDz14lqcVUnVGStyH
 O9/+cn+kl/QFkLcZy29lAlG1FIMDFqVAjXyeDLrQyIOOSDnfj6Wl6qhyV517SNvQ
 Dt5O4JXLc0cl2VA/PcWmEGKLIy8Jij/coiIzR3XrOEzbRnl0AkBpcAm/qJjX6jtm
 UG+uA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 4eqe5rb820-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 11 Jun 2026 07:22:08 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.25; Thu, 11 Jun 2026 07:22:07 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.25 via Frontend
 Transport; Thu, 11 Jun 2026 07:22:07 -0700
Received: from cavium-RAHUL-BM.. (unknown [10.28.36.48])
 by maili.marvell.com (Postfix) with ESMTP id 507605B6974;
 Thu, 11 Jun 2026 07:22:03 -0700 (PDT)
From: Rahul Bhansali <rbhansali@marvell.com>
To: <dev@dpdk.org>, Nithin Dabilpuram <ndabilpuram@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Sunil Kumar Kori <skori@marvell.com>, Satha Rao
 <skoteshwar@marvell.com>, Harman Kalra <hkalra@marvell.com>, "Archana
 Muniganti" <marchana@marvell.com>, Vidya Sagar Velumuri
 <vvelumuri@marvell.com>, Akhil Goyal <gakhil@marvell.com>
CC: <jerinj@marvell.com>, Aarnav JP <ajp@marvell.com>, <stable@dpdk.org>
Subject: [PATCH v2 17/22] common/cnxk: add auth key len check in inbound SA
Date: Thu, 11 Jun 2026 19:50:24 +0530
Message-ID: <20260611142029.3351415-17-rbhansali@marvell.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260611142029.3351415-1-rbhansali@marvell.com>
References: <20260611073311.3129711-1-rbhansali@marvell.com>
 <20260611142029.3351415-1-rbhansali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=Zqnd7d7G c=1 sm=1 tr=0 ts=6a2ac490 cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=l0iWHRpgs5sLHlkKQ1IR:22
 a=qit2iCtTFQkLgVSMPQTB:22 a=M5GUcnROAAAA:8 a=8rWy6zfcAAAA:8
 a=RWGwor0Ld7hqSKGVtXEA:9 a=OBjm3rFKGHvpk9ecZwUJ:22 a=YjdVzJdQTyZRADMV7wFX:22
X-Proofpoint-GUID: YTkP-dTTS-ruJ5PptNhIkptGXNlqOWhO
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjExMDE0NCBTYWx0ZWRfX/7ISCcFaYAkR
 Y0f2SV5nRXYWxPPGfX6Y8an+IRWb8Y11dQv0sxsB8PabU4KSUqN3KNLq0FKtqadGigB+Ob2zm4S
 HahOIuAro1rrMU90ng3PYckmnED5BCU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjExMDE0NCBTYWx0ZWRfX3j6UAp4JMTX7
 Juc9TbpCvvE/EXE1bROU298GHTJlksVtBXJ/vBAw2ld21BKs2uPbe5Pz/iDkgg1tFZxttq6IN9t
 S1B35g0NwUL/LylYonNvJYD3qCMQ7Ynw52HAuBAZzNHviSRuBoV0ZFdNM0I13q/ERmfdNFsbFf2
 VC8Qq3R+i1sVk9jyzE31cHF+u8FG4G+N1ayUgOFej16ub0JWnSlWC76UbSH6q7VTOyQotNvilBI
 f/I77ZkE9PIrsbr+ylEjohECtfZvHkapTGFIfKUuM+ovzcjgn1MBySJFp6DJtg/Tz4AIne7S28k
 e/CeATE3c1TNM8vH7hjtiFswimjcuetz1DlwC2qTWL8MZgFPEUpELquhmj2NH7o//+mOmzMF5by
 AHmoybpKGMUzcPP17EUu8+BjNree5RLiCaGZcN+ZSL48dG1ovqN1WkDTBDcOIQ7uZ0QZMRPmX7Q
 F+sQVKBObnyoKsZrhIA==
X-Proofpoint-ORIG-GUID: YTkP-dTTS-ruJ5PptNhIkptGXNlqOWhO
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

Add auth key length validation before memcpy in
cnxk_on_ipsec_inb_sa_create() to prevent caller-provided
keys from overflowing fixed-size in-struct buffers and
corrupting adjacent fields.

Fixes: 532963b80707 ("crypto/cnxk: move IPsec SA creation to common")
Cc: stable@dpdk.org

Signed-off-by: Aarnav JP <ajp@marvell.com>
---
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

