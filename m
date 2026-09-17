Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA77C88E72
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 20:12:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3362343250;
	Thu, 17 Sep 2026 22:11:37 +0200 (CEST)
Received: from mail-pj2-f36.google.com (mail-pj2-f36.google.com
 [74.125.227.164])
 by mails.dpdk.org (Postfix) with ESMTP id A51D542FE9
 for <dev@dpdk.org>; Thu, 17 Sep 2026 22:11:32 +0200 (CEST)
Received: by mail-pj2-f36.google.com with SMTP id
 d9443c01a7336-2d8fdc579daso427825ad.1
 for <dev@dpdk.org>; Thu, 17 Sep 2026 13:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789675892;
 x=1790280692; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KM6r2zVG4yj9TYazaXeRVzV3DSEuDfwSAp9skLXZw38=;
 b=J+GEGqcsPkzRLxqSOtCLYE/52wHzqAprKgrylDdhE1MZfeSaFq31vPvW+kWDYJbYwq
 5nerWXpYnVxIHdBmgEgguqPG3BtpolTHy0BLXrtPM3YkAi0JIKbECq3Nhc81YAebuPL8
 hLj8tm1vabFkQjo2HMPoH+O8n2jcL69pwaS78czaEbPzx8bq0yAOpnPzmSreiEfvL4bm
 TLpoJK2EZIf5vPfuAdcRJc1zC5/nBBlvKHhlFRdMcluJADyaEyMfZWI0Yl6HYxNY+Xka
 UvN85YCTDQCll/qvvcLPWVjG5g4J7FThltfKuM5CSF73HnfQX5DoWeTAnVb1gQJrQPvm
 YupA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789675892; x=1790280692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KM6r2zVG4yj9TYazaXeRVzV3DSEuDfwSAp9skLXZw38=;
 b=NiS5AeXM47dcFDFT0f6P/orAkKMZm6Om4U3D7Nk0udsS67exDoB74V10EOLyO/C7Dt
 VP4/N+bjWE6DHcLeTawnSd8AfmCNPh0hYSiise31TAfZszeL10ELxX0dvlOhvORzn8rs
 a08CSpOEvppB8OVuRE/s+z9OIN7NKla+Jvf0zANHZ4z8H6mRJ7daC3Fwj+Vf0vW9+w+4
 FXNvlRxQ2/qtjofeR51RrG+0M1YffqwB60ggatNS/mRQfrXcy7v30D6AkqXUC8bDpiGd
 hPsrZAK1bvpkXFotzYaBglHnjTTBsOc7joAN/mUSWWuADod6XcCzRDNypAD06IrTE2Dh
 eVLg==
X-Gm-Message-State: AFuF++nMMphTpjoYsXEdg1v7X6AxIJaxvfNTIh7J9AxldNAfSs4Phfts
 DjjcbPfOY1Z0GQBQL9ima0+wb99Ek6+UtGZ/6GTcNcMMrqOmCL4VXQwU6vtt5cCZl8m0Dp6ox+v
 bmt0Y
X-Gm-Gg: AYBFou32VCkrYIMKEUD1glxDKwRAEHUzHWPqQoELLwZcq1XAwlBpFLfCDb27odzHBO3
 uNXdLNXM7BB8AThohCKEQps72nLggt1dsBHuvfI1GO0qsrRsUIHMuDshNc4VC7NDpywNDBq6oaV
 i1I43RUhEMv3TaYxXGkms1H3ral0CaIjC+Xs7m6YeqMqTcoFv81v7GvmqSGmBIPgCjb3/nwWoa+
 oJG9SbbRNZea6Iv23Sl65E6fXBs3QjVgco/QsyNFqjGIYI1ssOue+Hfjps+U0pWKKIMGkT376ZY
 BYAfMD4r8iYbkhg2i0lYR4RTHywUC/vEPI9SSQ8UTLgjh7zrSHGeVHHQ2bnNRcB27c5b91BYsS7
 E9/xV5/R4/kj+3cANNEWqzYso+WYjqGRY3FziKKvkLrI/7G3Lj8Y0waNEyClN0BgeClIRt/B2CS
 O4xikC1Cfa/NIuMbIIDMn1sood+X+Yp7pgOvfJoBlHC7zD1G9GrxNVqNmymz9dBNnjP3a3BnFGV
 W37yWI7XCvb875/qKRl4RMGhBKlSA3031MIXA==
X-Received: by 2002:a17:903:3c4d:b0:2dd:ad74:ac1e with SMTP id
 d9443c01a7336-2ddb1bb28aamr6029105ad.25.1789675891842; 
 Thu, 17 Sep 2026 13:11:31 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd89f0870bsm31368345ad.63.2026.09.17.13.11.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 13:11:31 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v8 10/25] bus/dpaa: remove unused in_use field
Date: Thu, 17 Sep 2026 13:10:14 -0700
Message-ID: <20260917201119.2168234-11-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917201119.2168234-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
 <20260917201119.2168234-1-stephen@networkplumber.org>
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

The in_use field of struct bman_pool is set once in bman_new_pool()
and never read. It has been that way since the driver was added.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Acked-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/bus/dpaa/base/qbman/bman.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/bus/dpaa/base/qbman/bman.c b/drivers/bus/dpaa/base/qbman/bman.c
index ee4232d0a0..944170528a 100644
--- a/drivers/bus/dpaa/base/qbman/bman.c
+++ b/drivers/bus/dpaa/base/qbman/bman.c
@@ -62,9 +62,6 @@ struct bman_pool {
 	/* Used for hash-table admin when using depletion notifications. */
 	struct bman_portal *portal;
 	struct bman_pool *next;
-#ifdef RTE_LIBRTE_DPAA_HWDEBUG
-	atomic_t in_use;
-#endif
 };
 
 static inline
@@ -224,9 +221,7 @@ struct bman_pool *bman_new_pool(const struct bman_pool_params *params)
 	if (!pool)
 		goto err;
 	pool->params = *params;
-#ifdef RTE_LIBRTE_DPAA_HWDEBUG
-	atomic_set(&pool->in_use, 1);
-#endif
+
 	if (params->flags & BMAN_POOL_FLAG_DYNAMIC_BPID)
 		pool->params.bpid = bpid;
 
-- 
2.53.0

