Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26600CA0ED1
	for <dpdk-dev@archiver.kernel.org>; Fri, 15 Aug 2025 16:27:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6C73D40657;
	Fri, 15 Aug 2025 18:26:47 +0200 (CEST)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50]) by mails.dpdk.org (Postfix) with ESMTP id CC67740612
 for <dev@dpdk.org>; Fri, 15 Aug 2025 18:26:45 +0200 (CEST)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-3b9e4148134so1158336f8f.2
 for <dev@dpdk.org>; Fri, 15 Aug 2025 09:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1755275205;
 x=1755880005; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EqU6gsZ2qGV1/dvLmSKUqp0e9BQZky/Nad4kms33qnk=;
 b=mVHExACrlIp1wMJO6APw1R8GDX8/FpnFle1vwpcfwvxwXS69NApHHw5Au9GRc55/Jt
 L3m1668Ij9LzZojSqJmJWXGgql3INOLKdxpwPOH+14wLHE/fRPvbFohKg/m3FzK/jtNz
 NRBzaweDUfuZZVfUPil7TX7c5xy4KGqfa7sAhlOKLSHvJvCyZaJv/l/OpIb+kU58R30A
 47SS7czvXHMXkwyU0iLEp8k/VUjhRVbnpe2B4M+Mvw2q5GJLnoOUwsvkM4ALu7MGYcGd
 JBfJ6Cigzndo8bM2HYfASGV3c1+aKI2cvOeE0f2r8gNAOoK2HJ8saPoihvvVclvRZwiz
 bx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755275205; x=1755880005;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EqU6gsZ2qGV1/dvLmSKUqp0e9BQZky/Nad4kms33qnk=;
 b=DYM0LQDjn4iRV5Rrgf4KMc6GvOl3ZzWuuQPFNzLGhC3kHTsw0iveEKjvAOTnlCUv2N
 zimbpvHqKTjs+cWOPI+Fcd/+su6aRoHOSjejx6UHr4WRWrMy92+SEIVMmukHnXrqmVCE
 LhebxccV5gbhGbaPYxi16V/4xcObNmjU/MeZbGdozYabe0g2hDLhk6WdbPqpEN+cAa5H
 DejXpgKo9h5ViGBK3rC0aQ464azxfjPlN+1a/20rrAKe2SB19OdW0En8ib4ZdMgFrIvY
 kaGWk6Swr4XYIN0K++ntucpD58d9bNam+csxOrcMkb/BBm1u44pm1zykJ+LHduvzmlAI
 pXdQ==
X-Gm-Message-State: AOJu0YwnuZ7uMp2Ngf4RYfmaovmezB1hogIep9xh2/uVa/3U03KYGxp5
 ivGX+IKi+BHwczWuxYk3rj7cilt9334ZfgUcAHv2nx7IPc0K3VYxFOh/J+a3+E3h5NPPAcz8B4a
 N2RZz
X-Gm-Gg: ASbGncvy3SgXH63ZI12LcbY2usXPKfl45LCWKf0k1sSlXUijtuAHU7r/svoQWdz3FBG
 wVLqc6rsFtXMGjJlw83Lsw+quTk3UEYhPGCNotgKIdSnod4jqrbTrVpgr4mN5vFmgDpN7pB2Pi7
 JPO6gNAySZiJM3BYoyQbaJAHdrPuF+zaQsLvx0Ufiuf5aNSYPqZa7htPtybuNEfpd/s5Ws+5Gly
 YjgmnMKp6xiTXFaxEpwM3DP7feb1EhkyQayIIkCnJm10nAsfFGapImg0jrYo1bWV/FdtcSIrAc6
 QxZe3GfZ8x7hPYAkThVI/t/fz4hhi1bkh2G3k/bzPZivkV/SdCt4OKGgoFdIWAHD3sKtOP8c2u1
 CVOgvrdIcTjClRiYdNdUPsNbCXA5Yq4POsdRPLl5MTYA58HkEdhG0zFLpi/OwjvyE4t7F90ekMz
 3vXPlA9xY=
X-Google-Smtp-Source: AGHT+IGrd8Rm0WO/bPF4MSEXmxp32Hc1Tr3N0HAKz95zEtALc1Sj68Ihfs+moY0g7A+HHYV22m4ILw==
X-Received: by 2002:a05:6000:1789:b0:3b8:f2f2:e417 with SMTP id
 ffacd0b85a97d-3bb692bd317mr2189023f8f.51.1755275205420; 
 Fri, 15 Aug 2025 09:26:45 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3bb676c9431sm2665278f8f.40.2025.08.15.09.26.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Aug 2025 09:26:45 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Fan Zhang <fanzhang.oss@gmail.com>, Ashish Gupta <ashishg@marvell.com>,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>,
 Yipeng Wang <yipeng1.wang@intel.com>,
 Sameh Gobriel <sameh.gobriel@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v3 4/7] test: replace unnecessary comma operators
Date: Fri, 15 Aug 2025 09:26:20 -0700
Message-ID: <20250815162629.161782-5-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250815162629.161782-1-stephen@networkplumber.org>
References: <20250312232739.228295-1-stephen@networkplumber.org>
 <20250815162629.161782-1-stephen@networkplumber.org>
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
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Acked-by: Chengwen Feng <fengchengwen@huawei.com>
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

