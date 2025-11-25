Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9118ACFD37F
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Nov 2025 10:39:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B36BB40A70;
	Tue, 25 Nov 2025 11:39:43 +0100 (CET)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43]) by mails.dpdk.org (Postfix) with ESMTP id D427E402E1
 for <dev@dpdk.org>; Tue, 25 Nov 2025 11:39:42 +0100 (CET)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-42b387483bbso4018774f8f.1
 for <dev@dpdk.org>; Tue, 25 Nov 2025 02:39:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764067182; x=1764671982; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=zwVPdxgNjSXXmrxV8VEC7DH9TbKgdqV+Sf7cSP6bCS8=;
 b=kJAmP83xMGikG/GMVLnl09MwHWSSXpplbv81DZsTar+Zcm+JFHPqrKnkh3mBtefos5
 fELI5lvl3+8ul2kT2+3O4SYnhnpRzRHb88ezG8q4+JFmCVT89oLovAGR92HonFKDLesC
 xn9yHFr09NMFJYqSN9p7OISMIqHzCePwuOLkAp8GbA7Xk9HOOAkf/yhYaiaS5593lHgY
 9bGjScIYgJoAG5tDScy3kqaIx05d07lze56c6zKBky1K9nFioTQFpvurrqdDjDnFmNfp
 yzwvaWAn2NC8AQcxiW1zaH9rgp0gg3F+AQ+F3CnFow/tY6zHCzoEg0pvOxrivKWUK+YL
 x+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764067182; x=1764671982;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zwVPdxgNjSXXmrxV8VEC7DH9TbKgdqV+Sf7cSP6bCS8=;
 b=DJpknjbdQ7OYOfKcXRs7/rkyuRjddu3ykLuaeJaAsSb/GIpPw+BhAD+15zWEzSba3T
 hzMg7Ve9jhlzEUKdnj3vF65UfiGLBn/Zl7V+eb8t90bJJmWc9lTkUiyDauJP8eHq30LY
 EKTBvFY/SRmXWZBFUYhzuToWvbMNvkp+2hj/Bhea/tkvW4TimbiYFeddScPpAoAurN1c
 zgeFsBuvB6C/1r2eyI+YqFWwut1ZG6/9HchhEYtd7FwvFNKdePb0IedlYZfG8HHqdyfO
 WI4HnN5VwkeW5B7tPpCf5qyALy+w6UQa4IYtrd4XdeQpG7d/1LlM85dJdpsON4uQvmQH
 OUHg==
X-Gm-Message-State: AOJu0YyydVExUTaQkBHcBczsCYEA+/j334yuoZL3Oa0a6mUhA/x7yyMN
 /oEjXkpDRDAOixKW4k4MXGdUNVHAork4LncnLHi1XJ8CSWwVtZi4WKL6F537lw==
X-Gm-Gg: ASbGncud1ewuGwUUijGZXFF/nyoI+PBqxKUPuawWsqv2AlTK747/EtgpcDoTyMBdd56
 xnfvYz/tRhF/c+PRWSyyPL+/Zj0aJSk8wIw3Vq8K/N6ScyVEFULMwFN/2CmZCgdxEGZpZQdoiXH
 QYTm6RInvarrKQJyjLFftmfzfFg6t84+hKD5pq569rcdHNCtndxvbfj4GNEAzBAT6jldplTpkqt
 6TMa5eDy5Lj2vMrld8hGsAs6EYE2m1xAY0/KG84IoPrXMNT7XKF0gNzbv9HduLg2wL51FRLeAPO
 eM7Br/8tYukzpiQxkUm6p2/jLF5qKUcpP1PKAvuHawW7eq7ogsS/B8Xn18L2ttTYbrYbq8RG2a8
 S7K10+CqH5eLrtMcMaRF7XiBygQ/CRX7SgXLNyZ/Di0cDA2B5aOLrF57xul7dXkb/guPOyXOTQI
 MzoeZiBgCrYpCWEKej
X-Google-Smtp-Source: AGHT+IHbq+ihd0SYFk1LLuunzUMjIkqP0Jh3s8u7RR/mQp7T/0Xui3q59+FED+QHGdOVgBFMG1fLWA==
X-Received: by 2002:a05:6000:288b:b0:3e9:ee54:af71 with SMTP id
 ffacd0b85a97d-42cc1cd8f75mr14905962f8f.12.1764067181970; 
 Tue, 25 Nov 2025 02:39:41 -0800 (PST)
Received: from localhost ([2a01:4b00:d036:ae00:e128:6b49:7104:a117])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-42cb7f3635bsm33848645f8f.17.2025.11.25.02.39.41
 for <dev@dpdk.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Nov 2025 02:39:41 -0800 (PST)
From: luca.boccassi@gmail.com
To: dev@dpdk.org
Subject: [PATCH] test/debug: fix test failure on ppc64
Date: Tue, 25 Nov 2025 10:39:13 +0000
Message-ID: <20251125103935.1729434-1-luca.boccassi@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Luca Boccassi <bluca@debian.org>

1001s Running binary with argv[]:'/tmp/autopkgtest.LvdXhc/build.6vT/src/build/app/dpdk-test' '--file-prefix=debug' '-l' '0' '--no-huge' '-m' '2048'
<...>
1001s EAL: Cannot use IOVA as 'PA' since physical addresses are not available

This is similar to 6b07762e949036389030cf5a1a9bb8a1e4d6ee2d,
on ppc64 iova-mode=pa is the default, but it doesn't work with --no-huge,
so add --iova-mode=va to the test arguments.

Fixes: 2b403dd8fb37 ("test/debug: fix crash with mlx5 devices")
Cc: stable@dpdk.org

Signed-off-by: Luca Boccassi <bluca@debian.org>
---
 app/test/test_debug.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/app/test/test_debug.c b/app/test/test_debug.c
index fe5dd5b02d..5ff9068e2b 100644
--- a/app/test/test_debug.c
+++ b/app/test/test_debug.c
@@ -46,7 +46,7 @@ test_debug(void)
  * ==========
  */
 
-static const char *test_args[7];
+static const char *test_args[8];
 
 int
 test_panic(void)
@@ -158,10 +158,17 @@ test_debug(void)
 		test_args[4] = "";
 		test_args[5] = "";
 		test_args[6] = "";
+		test_args[7] = "";
 	} else {
 		test_args[4] = "--no-huge";
 		test_args[5] = "-m";
 		test_args[6] = "2048";
+#ifdef RTE_ARCH_PPC_64
+		/* iova=pa is the default, but fails on ppc64 with --no-huge */
+		test_args[7] = "--iova-mode=va";
+#else
+		test_args[7] = "";
+#endif
 	}
 
 	rte_dump_stack();
-- 
2.47.3

