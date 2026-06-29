Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1057C43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Jun 2026 19:01:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6F1134067A;
	Mon, 29 Jun 2026 21:00:47 +0200 (CEST)
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com
 [74.125.224.41]) by mails.dpdk.org (Postfix) with ESMTP id E8E8240663
 for <dev@dpdk.org>; Mon, 29 Jun 2026 21:00:45 +0200 (CEST)
Received: by mail-yx1-f41.google.com with SMTP id
 956f58d0204a3-664b2c00e12so2799029d50.2
 for <dev@dpdk.org>; Mon, 29 Jun 2026 12:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782759645;
 x=1783364445; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L/NYGAv1/ne+KJJ6SDOnyGBDbCsxpzkW2lIjGUNntVE=;
 b=mHqhwANFPTD1RKyEhlW4XPQjyXOBYSqqSUTiih0dLSMUaX/J0dZJwIi6L2dDe2IBze
 fqIkRBRahJaD2IyRwm1sQ/+LFx2v9Rff47UOvihae/nWivYjpxdGpnEAJfWx0+DH6DfT
 5vqxJuVJSxr5EMSsao6GOSw5AiZ7xG/j6ZAKJP2TPfPNS8cPK/DmV+VnC3ZJtcYCPd2a
 PxTFscckr5IdV64IXuiFxH0ud1cG12qnuln75EhqLjhwsDqnXaIaqRmzJn2OA/XTtlne
 Sv0MZP1NyCjPYT9FZ3ITVkAzugL87aJL5FOQ6zF/+5GN0ZB89CQZ3mnZGFyFw9ZKo7dd
 bhHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782759645; x=1783364445;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=L/NYGAv1/ne+KJJ6SDOnyGBDbCsxpzkW2lIjGUNntVE=;
 b=XanqyVu/4wBEQj0TUS8ZScSlqzUGQ/pouts9Ihvo7Ud/7KAQjHrfPfiN8QjM6j/rPZ
 gYCSC1I0m0aCoqcihN5TfRd+JPYSGNZ9zBnSspVbhg/FQIaYl6FarG6BTuwNZjsCK5dp
 yV0AVPUeRMZdI677hDvM4rgceXYuPYloZhskYgM9/wxm8zW0eScuJW7VW1pATRLF0jiQ
 1xtnPY+iba1ptU+x2XXtpirGccO2rxHVljcAHGuZaDh9CxXnc5dITxZzbIbYMOsBjQcl
 YIfKFsFc0+rOqWrbBMnxk/g5kBWDJyEmYiis2SKlgN2WlCfRAEiA6Q7MmX33IJsiKXgo
 SdVA==
X-Gm-Message-State: AOJu0Yz94t2x4FN3BXAys+hPDZRhSjxvql6fC0vSp6T7uVqJ/2hWbgAl
 fSynud5eRF3Sry+hBsK9RubzLVAC42i4nGw1kcZ/2ohhX8iBSs53yKVTO9obACVUxE3do2a4unz
 xne+y
X-Gm-Gg: AfdE7cnoZgU9rZwT6i5Rb+yTaRrx5n4W2jXAhcm0VBQwzaQu2bYzRtM84+iMmWK59WV
 5/dPiULg48U71TicTWKz5wu9K5J9NDcVZZn0L4ZliGtW3mAZN/hE5/D7KGmE81jWPEisMSyN0Yd
 uHqOUJTBtWJegtWZ020TVVAtODDyDiH/fQAPOe0aEPyYfFMgaH7dptpeMBV4lMgwbiDIIZ5pZ9A
 LfiK2ob33AHPODzA9BcWIEpqBiuvHvqDsxHhZl3HG3w/Ct4rtJSfmCHESEazMwER4psGHE72QGh
 6EBkZJgDDF88SyfNLPW/gCKk3fcq5dTiligmwsqCCCZDKopP4l4NcFXPay0EWYPEi6ejoxWRFn9
 U7UmMFbxYi4C9o+j/+gmAoH7YMTVo33bI8P9BJs64KPD3JtyhCdFScaZAtlz3sbM6JrnZ5hNUQS
 TNRKvyxE/jp2s+xBlZrG/neoGzO6xxEoyaVdg46mgFy6RQNQ0Ds+TkbS2bpI1gXg==
X-Received: by 2002:a05:690c:490d:b0:80a:9ff6:c43 with SMTP id
 00721157ae682-810da80b671mr8380657b3.55.1782759640477; 
 Mon, 29 Jun 2026 12:00:40 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-810e728a009sm1747287b3.5.2026.06.29.12.00.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 12:00:40 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anoob Joseph <anoobj@marvell.com>
Subject: [PATCH v2 6/6] crypto/octeontx: use timing-safe RSA signature
 verification
Date: Mon, 29 Jun 2026 11:59:29 -0700
Message-ID: <20260629190027.2071745-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260629190027.2071745-1-stephen@networkplumber.org>
References: <20260625160200.24170-1-stephen@networkplumber.org>
 <20260629190027.2071745-1-stephen@networkplumber.org>
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

Replace memcmp() with rte_memeq_timingsafe() when verifying
RSA signatures to prevent timing-based side-channel attacks.

The comparison at drivers/crypto/octeontx/otx_cryptodev_ops.c:742
is used to verify RSA signed data against expected message content.
Using regular memcmp() for cryptographic verification can leak
information about the compared data through timing differences.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/crypto/octeontx/otx_cryptodev_ops.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/crypto/octeontx/otx_cryptodev_ops.c b/drivers/crypto/octeontx/otx_cryptodev_ops.c
index d6d1b2cea9..40f565cd78 100644
--- a/drivers/crypto/octeontx/otx_cryptodev_ops.c
+++ b/drivers/crypto/octeontx/otx_cryptodev_ops.c
@@ -12,6 +12,7 @@
 #include <rte_errno.h>
 #include <rte_malloc.h>
 #include <rte_mempool.h>
+#include <rte_memory.h>
 
 #include "otx_cryptodev.h"
 #include "otx_cryptodev_capabilities.h"
@@ -739,7 +740,7 @@ otx_cpt_asym_rsa_op(struct rte_crypto_op *cop, struct cpt_request_info *req,
 		}
 		memcpy(rsa->sign.data, req->rptr, rsa->sign.length);
 
-		if (memcmp(rsa->sign.data, rsa->message.data,
+		if (!rte_memeq_timingsafe(rsa->sign.data, rsa->message.data,
 			   rsa->message.length)) {
 			CPT_LOG_DP_ERR("RSA verification failed");
 			cop->status = RTE_CRYPTO_OP_STATUS_ERROR;
-- 
2.53.0

