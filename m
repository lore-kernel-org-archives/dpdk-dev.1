Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273BBC0219E
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Feb 2025 17:38:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA5C840DD6;
	Tue, 11 Feb 2025 18:37:39 +0100 (CET)
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41]) by mails.dpdk.org (Postfix) with ESMTP id DE4F140B8C
 for <dev@dpdk.org>; Tue, 11 Feb 2025 18:37:36 +0100 (CET)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-2fa2c1ab145so7945424a91.3
 for <dev@dpdk.org>; Tue, 11 Feb 2025 09:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1739295456;
 x=1739900256; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Cw8QQxi332bXS0xVHGhoElGIpqGm/zjj9ys6WnoCM3s=;
 b=03lWgt0SRzZ4GSYGxtLYt3HmFqyHN4Xq2QhQQ8z8vuknJ0W0KfSDJ2uCjymrVdfrPh
 6S64CDLs9rNKSHWLBPdFHELmR0lawmBhgXkz0r0nlIaCZcpoKr7F4kQSPn89I6TA1v1X
 SV5v1CmwWec6wJ2ZoRAwfvKTB7wMyLrDynPA2BtDL5OYK8Fcezkpi+0l2IGK4rcYZSLJ
 7v6JArtKU7I+t0ghiJ8kmT1i0gtFYMehB6vUlaj0gZiqXoZleoWuSB1nCurJO+pWXCGV
 rUyE0GkBGEraG0z8i+VzvFPxfVQh+U+eu+Xt10zZrYMdCxkhOD1Zqlln9JsGkFG4JYvq
 Pmag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739295456; x=1739900256;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Cw8QQxi332bXS0xVHGhoElGIpqGm/zjj9ys6WnoCM3s=;
 b=OGR8xs0PQqHu57S3lp4YHNe+Q2P0ANQzIKbBr8xhCCo6EHRm/1wptoG5dNK4KtShuc
 OMRqs5eCxJTjiSXGqTlIi/JLj30NfYScWnYY6Q172HWAiOicK9WslDV6J/FkJpD0pWtB
 jP8jiNZ5wZu0pIGIiZyra8DnAPxeCCBf3acoC1GKFQvlI/VpmHiBsyXNkr9q+QmIDOsJ
 Ab/8ZbKq6z145ZokGlHqPihgTY9LGj8IclaJTHkReS2LYOk5X9qaeW63GeKZqD0BA47E
 XD4tJnXTF9Qs624JYT5ahypjsYpJkwG2U0OZAoRKdCOApiiunjpN+6HxpmtSCrXE8+5L
 4svw==
X-Gm-Message-State: AOJu0YzXms6zWsdRo5SLpZU+gTFMrSRZYMCSu6q/itXrl6Zl12YdRIQ2
 su1UxT7OEsGHDuPCrcV0bhOivsjQqADNuQalfsb5z3u3eFtiGl/Wcd2OSmkEyOMKcCPjrD8/qHQ
 x
X-Gm-Gg: ASbGncs3vuiM5tLTiSy0TLe4VRWJ3wPj2LauDVr8ATjGoGqUEIGg0C0GM391f6P45JS
 cQaZIKBflDLvDIKpU6YrxJgaZ3EjBsHIe0cS8iZKSk9kEeshVONZ+B/g0WlKKuIx5bBvEEvJzz/
 /rP3rselYFurGZNCTfFYof96hI5u2pW7jErfpK23ZYwWXbQhXCmMecao2j56ATkAntkZMyDfxHx
 tHqDaqBIVMvE38kN8DRyiKw6RZo3za8G6rdx5KNsUWq4QNdVrPuIjdqzjP6P0OGoMG3o2eNtAIR
 RirIj3/0HuHfG4/ExwA80UBk/u7+2iDHZn5yU+e6G3C9K9H4aQ8pdwenHJmcmbILZNcU
X-Google-Smtp-Source: AGHT+IEjLFwpK1E/TSDalcxfNi4EsmIBCg1f0v0qbfM/KB80Xx1Vbc7MpjqjGU0ECrwX+5bRd7jE3Q==
X-Received: by 2002:a17:90b:3f0b:b0:2ea:bf1c:1e3a with SMTP id
 98e67ed59e1d1-2fb63d16644mr1164108a91.12.1739295456017; 
 Tue, 11 Feb 2025 09:37:36 -0800 (PST)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fa4656bd27sm7131811a91.42.2025.02.11.09.37.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 09:37:35 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>, Kai Ji <kai.ji@intel.com>,
 Fan Zhang <fanzhang.oss@gmail.com>, Ciara Power <ciara.power@intel.com>
Subject: [PATCH v5 04/11] crypto/qat: fix size calculation for memset
Date: Tue, 11 Feb 2025 09:35:24 -0800
Message-ID: <20250211173720.1188517-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250211173720.1188517-1-stephen@networkplumber.org>
References: <20241114011129.451243-1-stephen@networkplumber.org>
 <20250211173720.1188517-1-stephen@networkplumber.org>
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
index 2fce8fcb16..6f3eacaf43 100644
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

