Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF577CA0EE9
	for <dpdk-dev@archiver.kernel.org>; Mon, 18 Aug 2025 16:18:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A6A1A4065B;
	Mon, 18 Aug 2025 18:18:34 +0200 (CEST)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id D018740658
 for <dev@dpdk.org>; Mon, 18 Aug 2025 18:18:33 +0200 (CEST)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-3b9d41c1964so2998502f8f.0
 for <dev@dpdk.org>; Mon, 18 Aug 2025 09:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755533913;
 x=1756138713; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kE3Nes+1igzU0Nr8yKbePx/tbrSS4BFFj/3zPs0z+d0=;
 b=X549OFnXe8kesgHPkhrPV2KLMjEURdrDQm4/p9bVljIvikC8udKSCZT7xDdQl6+X3e
 SM+zJ99NNdDqBV0MXuIUAbbLMdZp/ABPL/Z3aIRGNdMN/qd90KpjYOwh0i1YW/g0X6y/
 LvE6FkE9vcm9Fh53vxKOHeL/1251dhhTMeTw1GJOd/d87pqsGQWf6vRSBzfWVFajq3NA
 3nOaXjoTTYI2P7pYAQOZejovbakjyQT5YOIMUk/qbOAWFurSuhrTY4TBO1HBxhMGOamE
 c95SrSExGZBuGhEWiYFg5czMYPMGQa0oyTu+8pYTVptiXkfnJPGh7Lq9VHxBto+47tVI
 GYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755533913; x=1756138713;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kE3Nes+1igzU0Nr8yKbePx/tbrSS4BFFj/3zPs0z+d0=;
 b=ksHAl/IfrSXnB/5YXePqBjzzliKq4WcDjiBw+suIGY4sXAvnIsABbon0QXi9EhFOEv
 qImHDevv0bSRcLkPOqV4sgJJBr2Fo36u+wjECj0nPBIg4/1s//pOlYdUf7EmFpPa5ZPr
 01iMK3acNlmNEkdPbUcNtULGYAR9ezYdVabQXdEZGxEuZYWculrLdgpNCMc4M3x7sKpu
 Acdqh7l0FXzLDuydWqDblfHeuphITsYnC2PHvzLGv6maMNOjn9ip4PTiTM4Efi6g+95T
 kX24xeXTglhuzP8wp98omZ8PGe+HJzhYPaf2DIN062x6qNp5HRtHVWt+rUw60uorowbP
 DLtw==
X-Gm-Message-State: AOJu0YwY9tvHLc0r4V/hLAru4fz8HP0pzP8MwDh9zBVbfXWKf1eU6SqH
 ffwIXbriZPIQKEET7VPmf+TSC8MEP9Qki5b0oVA6S90eKR4O1ca5STaRoHPUDULcPdtIfWSSoR3
 QpauB
X-Gm-Gg: ASbGncs7oCUOk9OMfYtXJWLN9IyxBBX0hkBZqscinu00jJM9LLgP8HGk0vfl30amJ03
 Gn/Uuw0dHsa2isRN5wGf5lCqv2tWYiSRpUPzZ0S/eXJCB9G73F59yZuaMvFXbueFEZeI+OPELp1
 AhymFeaBzIgcGyYX/pDRc9nef4/LYkxfV7Wzju4G103UQrOCzZKDLPiva9YTjIz7TcYQWwnXKdc
 rTOb+DZPCce8dmzbX9SJsEvW+f/LY4RsOuNwxD/j8VZWB1Om+/yPl8DXUUYQwr2KEgkWSdO01+i
 pir9yFwqKDvybhcLPSWjEGQ3wEeSg+13S01JWxPYiNA9/C3xOQlgnH0BckBVfnaeqnV7E7o8DcU
 cGEItvxDUp0pWb+JeS8gukIu0Iqh9T1eGnPmkeU0cbOoFjI6Rnb9/P2AStHcc5W3P2YXrad0d
X-Google-Smtp-Source: AGHT+IEi+hnFzlkJlSsWVjShZEI5stZgv0c1rH9QeBXx9AbxAfB5eTL35AsGbxrrPAnlU8xD8LwicA==
X-Received: by 2002:a05:6000:40ce:b0:3a5:3a03:79c1 with SMTP id
 ffacd0b85a97d-3bb68fdd6d1mr10262954f8f.48.1755533913334; 
 Mon, 18 Aug 2025 09:18:33 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c074879fcbsm147865f8f.9.2025.08.18.09.18.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Aug 2025 09:18:32 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Fan Zhang <fanzhang.oss@gmail.com>, Ashish Gupta <ashishg@marvell.com>,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v4 4/9] test: replace unnecessary comma operators
Date: Mon, 18 Aug 2025 09:18:09 -0700
Message-ID: <20250818161815.23611-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250818161815.23611-1-stephen@networkplumber.org>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20250818161815.23611-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
Acked-by: Morten Brørup <mb@smartsharesystems.com>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_compressdev.c          | 4 ++--
 app/test/test_link_bonding_rssconf.c | 2 +-
 app/test/test_thash.c                | 7 +++----
 3 files changed, 6 insertions(+), 7 deletions(-)

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
index 33b0c6adac..f43a5ddd2b 100644
--- a/app/test/test_thash.c
+++ b/app/test/test_thash.c
@@ -908,11 +908,10 @@ test_adjust_tuple_mb(uint32_t reta_sz, uint32_t bofs)
 static int
 test_adjust_tuple_mult_reta(void)
 {
-	uint32_t i, j, np, nt;
+	uint32_t np = 0, nt = 0;
 
-	nt = 0, np = 0;
-	for (i = 0; i < CHAR_BIT; i++) {
-		for (j = 6; j <= RTE_THASH_RETA_SZ_MAX - i; j++) {
+	for (uint32_t i = 0; i < CHAR_BIT; i++) {
+		for (uint32_t j = 6; j <= RTE_THASH_RETA_SZ_MAX - i; j++) {
 			np += (test_adjust_tuple_mb(j, i) == 0);
 			nt++;
 		}
-- 
2.47.2

