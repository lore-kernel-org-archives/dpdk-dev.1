Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E46A7CA0EDC
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 21:29:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D09FC402D7;
	Thu, 14 Aug 2025 23:29:22 +0200 (CEST)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id 95886402AA
 for <dev@dpdk.org>; Thu, 14 Aug 2025 23:29:21 +0200 (CEST)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-45a1b065d58so9305985e9.1
 for <dev@dpdk.org>; Thu, 14 Aug 2025 14:29:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755206961;
 x=1755811761; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A7WArKE6dXmrHnhi/DH6I059/jDRKmqu+Ek70/UXOFU=;
 b=F+MlWq8QOmzmVgtXBKpmMHGaQKcgchz34L/7b3evSEgTMt7qzhEZYKrhe2cyCHylTA
 848SU8A7NB8H/OZmpAcWPKXyBZQBH3Jx9UjJh3X3yQNsMS2N2DTUugUQgqAnJqJ6GRlp
 oy56Ik5VMUjnIoKlsexWKp7zyrQvORLipSKTwcU5/8NJWUW9hqYQx8ZypQeWSGB7cwTf
 8jnv4zQyAp+jve0zfPIlTl6fNg/jocm4chU0wdh+hch+HSrtA6OAHV3D6VDnEKj/uXvN
 xzaf7eydG3DwRomlgLl+Gqav20b850HYOoy9PmCToQD9hI9e/7oTIzoeej85myyBf5s+
 KcOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755206961; x=1755811761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=A7WArKE6dXmrHnhi/DH6I059/jDRKmqu+Ek70/UXOFU=;
 b=ln65vPqXoRlI8C40xJj/XYwVgEPf4vs1oBQk4G4DGSOkekr+PTSRquQZ+RQ6xxHPwk
 ngRR37eIatIUsz2FX0fyxrtaA5cJLQ+nhPz31vNetI9uKRWPhjNy5kXGn6r6bRioJUCw
 CItVyD0me/7YsYhvqoFnEhipTZpQRQqzvCquiKXeBxFVYpqI83e5Xy73B6eiK/KJUn+v
 FwBR3bfPrR/b6RMq6ZrQHsz7WAnuXnyilnjxdlEzM+5HSs4tI7KaVkJ1/vSfrKMCjwWH
 ffS2/wGQsg/+cSnyYyv0xxrRpk/Zi2HGbtGI+PsqKCH93ULARoipzenG2PR2JrXYIn41
 9IEg==
X-Gm-Message-State: AOJu0Yzkv075icn47D4Y3edYkH5N8/3kdAVrJkuchoo9+BfGpWfHLchB
 CO+kO8tR2RGL0qN2uThkZKl1ggdCYOOQVlIxygeleehdiGtbDX+eeFB02SOYOyqka+nk/DpJuEc
 d1G1K
X-Gm-Gg: ASbGncv3FdtWOSNF1NDIwgjoshzhsHt9ybCdzozwWIa8UgHYRLUDlt+mDshEXADHnSY
 M6IWbM+/Wmp7sUaSKtQwDDTMQ1MZcDxza1cXhdJBc/5z1Bm928y9kOawpC9KLIeUv3rTN8fMjoH
 qRZpaV44W31pzeX+aD6FIVT3J8j+WZWQ+mat+xn+toyqm5juc/xeUC9UXH+zPKoniD6w6cjYpy9
 bjGWEvcN6VJZV9H7JA5oZ1DUHYgj/iFocPqjyBQOOgc3IibqTzXLKJr00oS7q38Auz1WEQVc4mf
 v5FcyD+vGb2tFdSTjeNij9rCTiFjntYSnOrTFBjjqryIC6q7iiIHtDOxdzRzGiMxeBa/7YtaIwz
 TLCXuec/I6egh82NCDmMYvvHWnEVYQx7GfvjjITpFMo2cc2d4son/bqe2gnkoFYfCa/CVSNss
X-Google-Smtp-Source: AGHT+IG/LcWKYGB8LQ80SG8GcLz6lzouVpJNEySveMyNq+z8lvOIBCDV9EcZBQBAztyTVEjA4gKAwg==
X-Received: by 2002:a05:600c:4f4f:b0:459:d780:3604 with SMTP id
 5b1f17b1804b1-45a20bce1a8mr5472185e9.3.1755206961213; 
 Thu, 14 Aug 2025 14:29:21 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1c78b410sm36404425e9.24.2025.08.14.14.29.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Aug 2025 14:29:20 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Fan Zhang <fanzhang.oss@gmail.com>, Ashish Gupta <ashishg@marvell.com>,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v2 4/6] test: replace unnecessary comma operators
Date: Thu, 14 Aug 2025 14:28:50 -0700
Message-ID: <20250814212901.88863-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250814212901.88863-1-stephen@networkplumber.org>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20250814212901.88863-1-stephen@networkplumber.org>
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

Use of comma as statement separator is discouraged and
reported as warning by clang with -Wcomma

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_compressdev.c          | 4 ++--
 app/test/test_link_bonding_rssconf.c | 2 +-
 app/test/test_thash.c                | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/app/test/test_compressdev.c b/app/test/test_compressdev.c
index c217ad6cda..dcea8e2f30 100644
--- a/app/test/test_compressdev.c
+++ b/app/test/test_compressdev.c
@@ -273,7 +273,7 @@ testsuite_setup(void)
 
 	/* Initializes default values for compress/decompress xforms */
 	ts_params->def_comp_xform->type = RTE_COMP_COMPRESS;
-	ts_params->def_comp_xform->compress.algo = RTE_COMP_ALGO_DEFLATE,
+	ts_params->def_comp_xform->compress.algo = RTE_COMP_ALGO_DEFLATE;
 	ts_params->def_comp_xform->compress.deflate.huffman =
 						RTE_COMP_HUFFMAN_DEFAULT;
 	ts_params->def_comp_xform->compress.level = RTE_COMP_LEVEL_PMD_DEFAULT;
@@ -281,7 +281,7 @@ testsuite_setup(void)
 	ts_params->def_comp_xform->compress.window_size = DEFAULT_WINDOW_SIZE;
 
 	ts_params->def_decomp_xform->type = RTE_COMP_DECOMPRESS;
-	ts_params->def_decomp_xform->decompress.algo = RTE_COMP_ALGO_DEFLATE,
+	ts_params->def_decomp_xform->decompress.algo = RTE_COMP_ALGO_DEFLATE;
 	ts_params->def_decomp_xform->decompress.chksum = RTE_COMP_CHECKSUM_NONE;
 	ts_params->def_decomp_xform->decompress.window_size = DEFAULT_WINDOW_SIZE;
 
diff --git a/app/test/test_link_bonding_rssconf.c b/app/test/test_link_bonding_rssconf.c
index 2cb689b1de..693b0ccd12 100644
--- a/app/test/test_link_bonding_rssconf.c
+++ b/app/test/test_link_bonding_rssconf.c
@@ -384,7 +384,7 @@ test_propagate(void)
 		}
 
 		memset(bond_rss_key, i, sizeof(bond_rss_key));
-		bond_rss_conf.rss_hf = default_rss_hf,
+		bond_rss_conf.rss_hf = default_rss_hf;
 		bond_rss_conf.rss_key = bond_rss_key;
 		bond_rss_conf.rss_key_len = 40;
 
diff --git a/app/test/test_thash.c b/app/test/test_thash.c
index 33b0c6adac..398db71839 100644
--- a/app/test/test_thash.c
+++ b/app/test/test_thash.c
@@ -910,7 +910,7 @@ test_adjust_tuple_mult_reta(void)
 {
 	uint32_t i, j, np, nt;
 
-	nt = 0, np = 0;
+	nt = 0; np = 0;
 	for (i = 0; i < CHAR_BIT; i++) {
 		for (j = 6; j <= RTE_THASH_RETA_SZ_MAX - i; j++) {
 			np += (test_adjust_tuple_mb(j, i) == 0);
-- 
2.47.2

