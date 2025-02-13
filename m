Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C542BC021A0
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Feb 2025 22:18:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F151B4066D;
	Thu, 13 Feb 2025 23:18:39 +0100 (CET)
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com
 [209.85.216.54]) by mails.dpdk.org (Postfix) with ESMTP id 4015C4064C
 for <dev@dpdk.org>; Thu, 13 Feb 2025 23:18:36 +0100 (CET)
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-2fbfc9ff0b9so2303949a91.2
 for <dev@dpdk.org>; Thu, 13 Feb 2025 14:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739485115;
 x=1740089915; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c8mVx65OZgwlPD3YqCSP4AJR4DoGBjJVIPIjf98KaNw=;
 b=tc+yaQ42SswzZDOuGdOj6T6TdKjNyQJ5PfL5FElXpzTVGp0feokb1QcJG+jDfLlWxE
 doty9oLGkCkpUwKpEp/0deKVqjmPEMzuE09gj75vir8AAoiwTs1fpVciirVQR/SuAsbd
 mdp25EYcbwieTDtaAc/CvTppmAQNRhX6wg5lLg5wC3acxG1IBmF5KouzR1h5lefNunBa
 w0NQGIbIZY/UKB62Wg4PuYqBUcPrA6TaDRcOgdHbbWuX1foKvBEBecEBvdpmzqqHTKxx
 kUy5hC9VcHb7KQTzYHhMxCUhQXLW4nPKDFDNNhtGe3/f9VCNo9aZetkeyVV3jt7QXcGs
 iuHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739485115; x=1740089915;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c8mVx65OZgwlPD3YqCSP4AJR4DoGBjJVIPIjf98KaNw=;
 b=fOJWlq1T+1rcVvpOyr8ImabM1WzxhiL3N1FOKjYTKe7ti4Zt0Qg9sivpoNbMzyAWML
 a5UrHNXeVyqUlvOgsuWM9NltqkWv16RS9RTnRBmwc0RLop3JjjQnpxtbEAySjHBURilw
 ZBnvm9+VbININPdFVy4P2WFUeIpdrJCvN4diA+1+mLZQIqwIOq5GlexhVRjyw0I2ocPU
 cqFrjZDxnjOHJkRk0x+QRvN7Hqcc8b1Ox/0fyXPMWqsDMhgL20uFIFyxrxvs14hmJpbE
 9hHSkvHK4rSmj6AkibGid9GIiJjw0Cffp/Wt6NXDI7ZuEx57eG16uArN2OfebBix/OLi
 pLbQ==
X-Gm-Message-State: AOJu0Ywe+7tf0OLsWDlrxMky8W9qVyyjj2CEgFZuI38Bsu+aPD3WNcqy
 yLYDsUaj64Hk+7KC/mzKPIuO8nTraeq5IJLhBOzd4pXYVk/cqpS65ypMi9CPrJf+jzn91KUvw9u
 O
X-Gm-Gg: ASbGncvZAlGZDZ37yFbnn3/gXCLyYVeLDWJ/lbbdRro9s9ebRtWLf98d/XiQpt4bDpq
 uVz8x2AmFvUzUcaTJYxpzQxMXiv6b3Y/dGDp7w8g6zlS7Xv5ho1pbTABFrs5s3GOIsRWPWoxZNN
 pxQR/mrgg2UgaKs89aQKh9hNZYG1b8Ur+s1Jh04q9KVSCwBeH1WhFaNN82WiaCCA9Hy5tH7s41X
 abFALdJYkpslHsrxKzieTfhyx6PQfyA74H8IEmngEpqOpnnUNRRqdI4sN7wXDs2u1h7DZsOMZzi
 TsXlQPHBTaAbjl4KfCrer/SpWHVimticLWb6awCIbCx7xfEd9c6FzXYxdfsasucbeex4
X-Google-Smtp-Source: AGHT+IHGmF45iplnwNNiVTX8hw4D7Up7BycBF7+GrYuTOQCD8WNia2AW7CrGdi8d4kogyid+I4NnQA==
X-Received: by 2002:a17:90a:e70d:b0:2ee:4b8f:a5b1 with SMTP id
 98e67ed59e1d1-2fc0f09f09fmr7219647a91.24.1739485115438; 
 Thu, 13 Feb 2025 14:18:35 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fc13ad726bsm1706826a91.28.2025.02.13.14.18.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Feb 2025 14:18:35 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>, Kai Ji <kai.ji@intel.com>,
 Ciara Power <ciara.power@intel.com>, Fan Zhang <fanzhang.oss@gmail.com>
Subject: [PATCH v6 04/11] crypto/qat: fix size calculation for memset
Date: Thu, 13 Feb 2025 14:16:17 -0800
Message-ID: <20250213221819.1856769-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250213221819.1856769-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250213221819.1856769-1-stephen@networkplumber.org>
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

