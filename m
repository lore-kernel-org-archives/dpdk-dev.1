Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D35BC021B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 16:42:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9EA0940664;
	Thu, 20 Feb 2025 17:42:13 +0100 (CET)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id B2585402D8
 for <dev@dpdk.org>; Thu, 20 Feb 2025 17:42:09 +0100 (CET)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-22100006bc8so21067465ad.0
 for <dev@dpdk.org>; Thu, 20 Feb 2025 08:42:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1740069729;
 x=1740674529; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c8mVx65OZgwlPD3YqCSP4AJR4DoGBjJVIPIjf98KaNw=;
 b=qjf2xsa30+JXAEbaUPpm2ebcGO5J4wj6fEBQb5vNlFEwm6+JRDNzxI0cpPxy2+RRHI
 EfE3WxrGPhHmaI5gz6OQaeAYeMUKhCU9CL9z4nUtJRJtXawnu0d1MfiOD6SOdDasAEqd
 vR5AQC6swr9VhbRm0V6stGDTbC/0+8tNr5m5NVLvxtrowibHDFg/kP6QREupESgNiCGU
 REgXkE7zXcZFY807o+XiUWEiI7HPYZVNJK6HAwdHqQytCiljF6hJCiTQBs+13djEg/DH
 SVF1G1PBLQwQoxHR8vTe6aX3756BqMtdBY8yKXBVpxT1a9ojrHQ7u+yvJPNRCsdB5vkn
 VOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740069729; x=1740674529;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c8mVx65OZgwlPD3YqCSP4AJR4DoGBjJVIPIjf98KaNw=;
 b=tj3TlGk3dXTMsMNJplQptIQsfgehX6cIvRf3HeQVAmoFiF1ENOhSMadztl6wO9O2Du
 tXX7WOHIqwVLXdGiaVxwesa0bSQN1tDzvYTvdN2fpJzyG7nIQEsxXZWyyyYRCv4O8Yn/
 2m4YWWVOfbLGtdPZtYRDfxquPorFG/vyNtUPRifUhs13Vtase+44xyesLMwrqp6LqaQu
 5b0pwxTxyPVD6O8z+hDDhyGy9I6bB6Y98aQu/CVNNljbxl1MkFjyPzIjWBF68nXamQIb
 6ZrX9UPCpYeR1UlOMXxV8s6afci0SN3rzZrFi/kJNMXTtpeSeL5I68VK3/8JFuO+8yUB
 zzlA==
X-Gm-Message-State: AOJu0Ywsj40BUu2DJDp3XrIfjQmis1D8eeIN02BOTdH1sXFRtOoNN1+Q
 kQdjI18Dbd7a0EKiiK8yXWSNLqBxo5HK7AtrhVkxmJ6b3dc0zLsjLSV1koMMsxG51LivCLTl+Fx
 f
X-Gm-Gg: ASbGncudBXjcuvpgZxqV/4uy13jQl1RH6/N2lIVnDMJFh0GWHbmVDhA/9u5JqOm3jjc
 TU4NzgklKr+tauv0zrALWBY6jOLy0tVzzYeuV5jONmArPaABoi2qKXd8my3e7aLnjYVxqizzsRi
 uoP/oedm73BOUB0S8R6HhOfcrH3bKQPTU5S4GqRlUrnPDj2F3KMfF99evnpvy+SwWVdhNi7AypZ
 RcuL3SRmlzlAu5an4RS3onBaMjOFIJQW7fREYqn1qcTPpj/DTppkXuER1szshDTupjMBxhyaQbg
 Twu9ddHENG5HG7t/94yDRq9hIuWNCwBZvS864ggkK0Ye+GX9w+atc/R+CxU1muSaAoVa
X-Google-Smtp-Source: AGHT+IGoWrBs4m+lNx7+BPLHM7lx3WQAj2K/TRxPWta9JbixYHISGlZgjjksFRKYf/MyYiL3KCkhLA==
X-Received: by 2002:a17:903:8c5:b0:21f:6a36:7bf3 with SMTP id
 d9443c01a7336-22104030814mr385535625ad.12.1740069728959; 
 Thu, 20 Feb 2025 08:42:08 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-220d5348e68sm123798305ad.28.2025.02.20.08.42.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 08:42:08 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>, Kai Ji <kai.ji@intel.com>,
 Ciara Power <ciara.power@intel.com>, Fan Zhang <fanzhang.oss@gmail.com>
Subject: [PATCH v9 08/15] crypto/qat: fix size calculation for memset
Date: Thu, 20 Feb 2025 08:27:14 -0800
Message-ID: <20250220164151.9606-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250220164151.9606-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250220164151.9606-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The memset was always doing 0 bytes since size computed later.

Link: https://pvs-studio.com/en/blog/posts/cpp/1179/

Fixes: 3a80d7fb2ecd ("crypto/qat: support SHA3 plain hash")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/crypto/qat/qat_sym_session.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/crypto/qat/qat_sym_session.c b/drivers/crypto/qat/qat_sym_session.c
index 3564a33484..7836c95064 100644
--- a/drivers/crypto/qat/qat_sym_session.c
+++ b/drivers/crypto/qat/qat_sym_session.c
@@ -2347,7 +2347,7 @@ int qat_sym_cd_cipher_set(struct qat_sym_session *cdesc,
 	return 0;
 }
 
-int qat_sym_cd_auth_set(struct qat_sym_session *cdesc,
+static int qat_sym_cd_auth_set(struct qat_sym_session *cdesc,
 		const uint8_t *authkey,
 		uint32_t authkeylen,
 		uint32_t aad_length,
@@ -2620,27 +2620,27 @@ int qat_sym_cd_auth_set(struct qat_sym_session *cdesc,
 		break;
 	case ICP_QAT_HW_AUTH_ALGO_SHA3_224:
 		/* Plain SHA3-224 */
-		memset(cdesc->cd_cur_ptr, 0, state1_size);
 		state1_size = qat_hash_get_state1_size(
 				cdesc->qat_hash_alg);
+		memset(cdesc->cd_cur_ptr, 0, state1_size);
 		break;
 	case ICP_QAT_HW_AUTH_ALGO_SHA3_256:
 		/* Plain SHA3-256 */
-		memset(cdesc->cd_cur_ptr, 0, state1_size);
 		state1_size = qat_hash_get_state1_size(
 				cdesc->qat_hash_alg);
+		memset(cdesc->cd_cur_ptr, 0, state1_size);
 		break;
 	case ICP_QAT_HW_AUTH_ALGO_SHA3_384:
 		/* Plain SHA3-384 */
-		memset(cdesc->cd_cur_ptr, 0, state1_size);
 		state1_size = qat_hash_get_state1_size(
 				cdesc->qat_hash_alg);
+		memset(cdesc->cd_cur_ptr, 0, state1_size);
 		break;
 	case ICP_QAT_HW_AUTH_ALGO_SHA3_512:
 		/* Plain SHA3-512 */
-		memset(cdesc->cd_cur_ptr, 0, state1_size);
 		state1_size = qat_hash_get_state1_size(
 				cdesc->qat_hash_alg);
+		memset(cdesc->cd_cur_ptr, 0, state1_size);
 		break;
 	case ICP_QAT_HW_AUTH_ALGO_AES_XCBC_MAC:
 		state1_size = ICP_QAT_HW_AES_XCBC_MAC_STATE1_SZ;
-- 
2.47.2

