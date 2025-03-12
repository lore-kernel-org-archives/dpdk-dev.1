Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20E5C28B28
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 23:28:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 433A240E5A;
	Thu, 13 Mar 2025 00:28:00 +0100 (CET)
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by mails.dpdk.org (Postfix) with ESMTP id 52D8E40E1D
 for <dev@dpdk.org>; Thu, 13 Mar 2025 00:27:56 +0100 (CET)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2240b4de12bso8873165ad.2
 for <dev@dpdk.org>; Wed, 12 Mar 2025 16:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1741822074;
 x=1742426874; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=50sLQjESSOZnBylllJp3qYKqgN1C3r5E4pGKy0GCMTo=;
 b=T+G+NFpg1IUNiYpkEqPSoqQcf4yfEpwxDqKRYZIe3nYUXAxJhaVrvkPSXgnzIvCZ9K
 XjHDoa6OGQnF2eddt0mEwfJ+AWUI9aKWfaa/tQimeyF3Wp6HYOupiI2/qlokrVjLKftv
 RS7HoD8dzabmCTYLYOLKuziiWQQ+ZY8me8yJoNHPkCSUj4pghNnnvmtkf3rNgt+W5THl
 HyRhc+LyrIkTGfvQcBXS+lOzoPe4HhLZjgZXvdR068OlzDRrNicPQhrp5ih1v+C+vJ8d
 iTGCBlpkjbpu4knTy4Y5QTUsEooluvrG1nuvx9LEeqUJSItoLXUR5WC1hCYCdZQFz44u
 tLaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741822074; x=1742426874;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=50sLQjESSOZnBylllJp3qYKqgN1C3r5E4pGKy0GCMTo=;
 b=uBafBir02EGKMTBDDRRVhAoKEsI+lRbp/VvPNbztWkiibP30g54FdXALwNo+5HvcyH
 eJVmwLvPpjBDOs13qRMUEwi39xwLzh+bePPIGwpVaBl1z1aNui6hdS5HRHDVpnTxXATN
 GfIzgBjlDNOd+DniwxV0FlFaJy/5gvKcyKkzwInTM8nwVoAN9XnYZdSB7SoFCPwuNcjP
 wZgMvvfOQekUPGVWR+QsHom3PoF990/jbMG/aXb3eB79XPpU93AlbCqkAu9euBOSSs9U
 FS6zCoYhy+KVZfVdUu+OvQZ2n9fwHpOX216qUmB9+X53tTtALMXeaC3+Q46jCoqHsdPX
 r1aA==
X-Gm-Message-State: AOJu0YyD2vZK+HcDJEMjkkBsGot0/cwY0ZBlKa5IoF/55aBvCWqQcb4+
 XeckNz7wYmvSUhM6IiwVBhqlNEGUa1/wfYhYbMB/CJMgR/LrPqCG6Bd8JOUtSBpJ0kDNEXPgZOj
 d
X-Gm-Gg: ASbGnctXPF0L5RYFpqNMbrnoSNb7DeRkXn9Zwx+a+TTXqEj1pefc5kIKJZjyO5kfAnF
 mHgKW5I4WQiEMtAwyJJ+dgyu+0/9Ng7ajChCostZ7zudboQoXlApINs0sGKLHM92jShP1oAsam5
 ISiYM6SMX8c+EyEfrIYh1jIlGHhK59SthqArpIoZBDjSvmGD2opuOOgNG/hoPflDSFNknWJVj6m
 3J05Xrv6LLHCLo8xdx0U+7AYRKciJPqYPe+Q+mjZFk17bAO3v3NUPNSdu4TIUPcOD/lqkZEzMTI
 Mv0Vmv740+ysrntqGpuNaY/91XK97xpDXDLo6DRNS/mv01tlizV3V7AB76q1LFcQmoxQeAlBC26
 t85VBPxO1rGLxk8SH66hUpg==
X-Google-Smtp-Source: AGHT+IGMgnuaR8gkYFsfXzYjUqqaHs7PBuprDqwoiLq+NIx6gtSdFBEvZpBkBdX5KQLp6VVtnu74nw==
X-Received: by 2002:a05:6a20:4499:b0:1f5:6b36:f56c with SMTP id
 adf61e73a8af0-1f56b36f8a5mr22996426637.39.1741822074488; 
 Wed, 12 Mar 2025 16:27:54 -0700 (PDT)
Received: from hermes.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-af56ea95651sm111917a12.73.2025.03.12.16.27.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Mar 2025 16:27:54 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Fan Zhang <fanzhang.oss@gmail.com>,
 Ashish Gupta <ashish.gupta@marvell.com>, Chas Williams <chas3@att.com>,
 "Min Hu (Connor)" <humin29@huawei.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [RFC 6/7] test: replace unnecessary comma operators
Date: Wed, 12 Mar 2025 16:27:03 -0700
Message-ID: <20250312232739.228295-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250312232739.228295-1-stephen@networkplumber.org>
References: <20250312232739.228295-1-stephen@networkplumber.org>
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
index 81b8e02006..304adfe94d 100644
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

