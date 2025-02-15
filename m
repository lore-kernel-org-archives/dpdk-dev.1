Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1F10C021A4
	for <dpdk-dev@archiver.kernel.org>; Sat, 15 Feb 2025 19:06:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7B20340DD3;
	Sat, 15 Feb 2025 20:06:08 +0100 (CET)
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by mails.dpdk.org (Postfix) with ESMTP id 034EF40B9D
 for <dev@dpdk.org>; Sat, 15 Feb 2025 20:06:04 +0100 (CET)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2211acda7f6so3724825ad.3
 for <dev@dpdk.org>; Sat, 15 Feb 2025 11:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739646363;
 x=1740251163; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c8mVx65OZgwlPD3YqCSP4AJR4DoGBjJVIPIjf98KaNw=;
 b=2LHq+mEJ77EQFNvYZkUABZUMNa+PrDqMsZfWBCcflnwq7Mcf7PGVwyr+ujvulSUE6x
 1nkw3Z2T/YXgh19JntLB6ozJZnq6/VNs3LRbfdjMzmzkvLy+ZRmOxcEP2jE2L3IvA91J
 UZR5RKARyozRONFOAOkLPefZ2OF8mfjFrEkeQaKfPKQ5BAqd1Yo+XWirjT9POGG3ZUG+
 9a9E6T68um0fF4U1eNMXty8HTIvUUV3b2SaA6aszKrJ+xL3StYDNLG/At1Jx8rZBgdcn
 xQIAtJYzEA1jXdH8DAUOtj4pAXIXdip5wQEun+rLOJ+bhPfn3eEc8jcm627YYWUlU2uC
 BcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739646363; x=1740251163;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=c8mVx65OZgwlPD3YqCSP4AJR4DoGBjJVIPIjf98KaNw=;
 b=ewDj9svzNuWFH3LOdBjTO7xl5Dib/Vz2GWF+M8LTdsFYhBuxrOGmCJMGswW9dfIVQw
 X8IBLiWxy1S7FK7y9cJK6XH9djttObkBWoJFICJ/TURhAlGxbjPl48deh77/BQRjYugH
 SdmGf2QbNNNgZeQtRLUiuoBCdiAHwqCo+QalC1ON9VdrPTuTlRuIXu4dDKiU7dTJdiao
 X4BJmu5t3286f00EdBO6vlq62nI1LLse5/djmd2OvgFSccGdhFBvsf8279UuUVEPdP22
 Vb71aVka1lsPuvxB5TJGATSL89eWmufqxeL9+5XC+5wYpKmq3mNTBRe8mAocqvO0FS1w
 9ytg==
X-Gm-Message-State: AOJu0Yxc6BxN/+yP9Sqfvic+ngTJ1tucc5PBs910lB5W+fFHNdpyrSsL
 jvRLO3XSC9qh7hBSBxt6d7SuBvzFzXndwPBe3ZrA+/lFy4lZSmGNhj3h88RxJXICd/M7AR2a0Fg
 a
X-Gm-Gg: ASbGncuMYhydRxcemTvvrahcaLtj3En41kzVNeYPUllr4j5j7wxMByQx5iQWhI8TZlE
 pIkfN2lvGXclAlX+tUnKwWhyBDb0alKsYrZdsX9MFg0BDwptN04i9LbzVGvoU23G7hvpWF+rlfY
 BlzFeIimjb23i4VS9lMQe1y7TTIHcaWQYG4KE3yr60UFbkNFOHaQe3W6YuEveTJy4a/bPfHbAIk
 z+s/ZkD2L90udNMIRVBSJyR5RqlFbrt1pZ8XUEtcZwOFawWevWc5kozFSfAONZ0MSRFnctz9ntW
 B2N0aXQnBul1bVDaS/WI8oBmWmc24YEnEddlcG8PNT+42r5Ridm7qZQdzxX8BqcbmXdH
X-Google-Smtp-Source: AGHT+IEuD/rFLyc/EtL6xN3xdI0lLvridrc367QIMzgYhIpviM85PT5vqnawAQFDmG6eBNVfcRikFA==
X-Received: by 2002:a05:6a00:1706:b0:730:75b1:7219 with SMTP id
 d2e1a72fcca58-732617bffabmr6033866b3a.12.1739646363197; 
 Sat, 15 Feb 2025 11:06:03 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7324254685csm5080179b3a.4.2025.02.15.11.06.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 15 Feb 2025 11:06:02 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>, Kai Ji <kai.ji@intel.com>,
 Ciara Power <ciara.power@intel.com>, Fan Zhang <fanzhang.oss@gmail.com>
Subject: [PATCH v7 09/16] crypto/qat: fix size calculation for memset
Date: Sat, 15 Feb 2025 11:04:37 -0800
Message-ID: <20250215190544.988310-10-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250215190544.988310-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250215190544.988310-1-stephen@networkplumber.org>
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

