Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E210CCD199
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 15:03:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D57ED42DCD;
	Fri, 17 Oct 2025 17:02:51 +0200 (CEST)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mails.dpdk.org (Postfix) with ESMTP id 267C842DFA
 for <dev@dpdk.org>; Fri, 17 Oct 2025 17:02:51 +0200 (CEST)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-b62fcddfa21so1322479a12.1
 for <dev@dpdk.org>; Fri, 17 Oct 2025 08:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1760713370;
 x=1761318170; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LpT0U+cf/cVDgvxbw1UufGHR0d07gZAcf6CAZE/m8eE=;
 b=KCtF9v8biy0fn3sWIF35P8ROmawX8Hk2jb9SXbSW+Drz6poAXWJxZkBFEeGQK4sHWm
 aO8ij5SraFjaiAFI/h9uey3oh9OQ26asMuONwlvEMauk/M5yzb+6WTXGfRfKIC07rwPV
 60r5D5xZV5AYekKkT7eeSAaMTGGyGqAHWkJ8ev1yW8WbTNWqlS9u21Q36zGTRyk/hvU+
 GhelU9Huc8HNlfEMKlvpiBHqsc2MwsEl6/CEZkdYMylFnjMwUtd/jAlxak6mwILUEkT/
 dp+Hd+0Pv9oaByMsddQGJuikH11DVvN0eKgTUzNJIPrUwn+NL/yhLHxBKK8PV05culJj
 qgxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760713370; x=1761318170;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LpT0U+cf/cVDgvxbw1UufGHR0d07gZAcf6CAZE/m8eE=;
 b=RmPfRiboWplGT4/ikS9Wqn/Z4TVo58MDy8pfnzncX6yyKXy5vGD8T2lfLS6v/GioxW
 FdKhUyewFvgrIBV2wE4/Ph+KoN2LLxoFFjyXXW0HI+265Nyip3F5/S8poWq0K9Swnoo6
 yWXcEp8SIKOWvHdXrLil0wQttHE5J4gbwcwpTc03G8Mg/7V0O6mv+1E/mToSvDXcxvwT
 7sIKckUXF/PDOxD1WcDgRSeX4ou1HdVsRE8kh0xGMRTLTDMy8MqwtD7tGTpHUYauX2bf
 onNpAZ3772hPJ8wRBnkC7LaJpZKwB3nJFsdYTF2z981Ntl5rUvCwDhRIIZa3EFnM5ibn
 hCRg==
X-Gm-Message-State: AOJu0YzzMVjErMFWPK4l7Jn9vVqdm3tnqccqxpnRldw0bzIphbEEBWXc
 61GHB2swLhkaGMYE7UIHWsslRPTNFVVV3YYmCftkPYlf6Uzub+5bN9n5x2p/iBNEOFCGimDwc3G
 JsLMEZE8=
X-Gm-Gg: ASbGncvHQKtAGUjQ1Pf0FDb6pFcz/skd7hQwxm5NrgZhjRDxZr5RTyfT2466WnbvFxS
 u2YfcDZxnG5rXIekTwAJSdMxjrjupkA5afB/bhJ0GdIciQDlgfc83DtlYF46JwLAlOSDvVLvQCj
 9+n6+B0xDfj6WbFSF5uLFxwwaZVAkOauhuKToxy1UN63WXczBW3vkTeEDNb2sSfUGqR5PwFeI+q
 tl+Mrh2tBiADf3x3nErHWDQwpEyUW2OVJs+2Ck/vY5PoDdhSAxELJwwKhOHGN1XDD/dXxkD/VKR
 UoxO65ZaHpZ7gFPVxbcSoO/Y+X0ECSoEjsacYVuNJVq+ZREd5mOOy2eeR+aKtkJPoxDajhEac2z
 co4C5WOjGketCV0r+ts2EAOjtfyjOTRoWpB0ZNRD8wweAN4u0adRX5Y/a+F41ghddYc8abHOADQ
 oHNcRE0wD9tGduLl/TIrSlHezXWAJsNO+tNjCLKquFvyqGQwF5buwEFHh/fnGc
X-Google-Smtp-Source: AGHT+IGGwbnRidhiDErEKxZOEjdHRbDEx0v1dxxTvPr1sKIQz5x4hYFVSE3nShVrT5ESOEGBdntEtg==
X-Received: by 2002:a17:902:d2c6:b0:290:c0d7:237e with SMTP id
 d9443c01a7336-290caf831cdmr52292525ad.39.1760713369803; 
 Fri, 17 Oct 2025 08:02:49 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2909930a72esm66700475ad.21.2025.10.17.08.02.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Oct 2025 08:02:49 -0700 (PDT)
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
Subject: [PATCH v5 3/8] test: replace unnecessary comma operators
Date: Fri, 17 Oct 2025 08:02:04 -0700
Message-ID: <20251017150241.28511-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251017150241.28511-1-stephen@networkplumber.org>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20251017150241.28511-1-stephen@networkplumber.org>
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
2.47.3

