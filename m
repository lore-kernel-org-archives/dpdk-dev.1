Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4739D6CFA6
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Jan 2026 22:17:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D2FBC40A6B;
	Thu, 22 Jan 2026 23:17:34 +0100 (CET)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46]) by mails.dpdk.org (Postfix) with ESMTP id BE5724060A
 for <dev@dpdk.org>; Thu, 22 Jan 2026 23:17:33 +0100 (CET)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-47fedb7c68dso15732895e9.2
 for <dev@dpdk.org>; Thu, 22 Jan 2026 14:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769120253;
 x=1769725053; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yxphNE+HxoPOsXo4EQLYJ/e7g8axZZtkReyUGcA4Q7A=;
 b=T2UhAi07qlnr6I7dyx3nNwwQGGh+8ScDjV/2g/YaPlSiVOa7ygfoQnHNHjTy3oV9zk
 DDQawcQ98J2sfPvysS47G5QEO1oDVRsGLghMVjpMyiuCPCrd1nvwDPkfWFVkuiALaisv
 0eO0XK7yVl2NANMUsMBJjBOdvv/Ni+Ko4X2a6qZdTAaeydIUZKMWWtZm4OM7vepxg2sL
 y2AXyCyh8oIpRh938Bj5iGLjbPhFqYMrgW3ETV1iWCV+2TCk2GbQ5UvG57nY+mb3AKvv
 tXmU5pVNTVPK4LRwcdQc6WXe2woCc14vhflYU1jQeRHyGAPn7ZN3kEbJw8HdUKMT6LSg
 09Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769120253; x=1769725053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yxphNE+HxoPOsXo4EQLYJ/e7g8axZZtkReyUGcA4Q7A=;
 b=bh50An3j8T82ELBMDBZ2vxn26jgztQSVjxb+0hH4r5XveNEXVq3tY6I5pTnKVwY13m
 CCmm1ObjTj2JCJAgmPafkOHPd9/KXEjIf6sMOffxHlfs/MluERJNwt49O5PCJC7MKqVU
 SinlwFbzMx797Crz6XjwuJ8/gq/AKWPDI0wcgqaczzFvMmwNk4HoWy5hdBiCXYkDRGB6
 aeWA6BLVy6OuLDPSxJyefalBPUbZua1ImOh6MKz/+EeUlCFggVD7rs/YFcLvKjDPmcaE
 gwJp+/UWB2rtcO8GgCY9mkOqGtRgrO0pt5+XVpwC0m2ABThCW5wPhp63nQEO5IZth7A7
 hzkg==
X-Gm-Message-State: AOJu0YyJxsIG+kXH9NZFnaAx2CAJ+gGI8LYlj8HjNTHeTtZZrRCIAlDx
 Bx7gy5JpC8yJD2oYVy6l0uJb9nUy/0DjBXIttfVkGHrjCGEzsQFkCNlb+gi19nb6bPCja8+oKO3
 uWLg8
X-Gm-Gg: AZuq6aIPRPspuzMmI9LgpT+TfpXCzGu3NhNN24CU1S2nK8uL/SmaiM75IzbxO/KSBsS
 J8B8/HHDbkc4shGVqfUDvRLzJ0jI1ytzq6c1Bls46VTWJTnma9DwdeXnKQWw2hfQdYp0Lhxxdhm
 vZNLlpBHtQ5mVTyOZW12EaaRr6+bsu3V257DbaaYRVRaCfAQE9lI5nFWbicYv7ZwXAQPgrFn7Wt
 DOt8AUZDAh1qUQx2a15p8be4RwMptvWgIOmaHqRSjZgTnvlQWpR2V9uLuKNF+So/BnuX10+/2gk
 yqz1+bc/qhj5qoNiihkgb1eLqZSlDVISIsmWmrLKx3q2GXJAfa8aXROVoHp1RS7g1E8Nh+bstYR
 h7kvr5Fh6WzOd3MmRQ1Ek30+TQ8aUd0jBvI8wQIHbBxbsYvzy0c3X60/rpxRTxj+YY/sljeSU1r
 UPF8UI859AGS4iEw/sUFSHCFMcNp1TbnQnM7NZcQdMB/QbVkjcgsWFI7AV2JQD
X-Received: by 2002:a05:600c:4684:b0:47e:e8c2:905f with SMTP id
 5b1f17b1804b1-4804c94f835mr16128475e9.8.1769120253185; 
 Thu, 22 Jan 2026 14:17:33 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804d8bebfasm12088415e9.14.2026.01.22.14.17.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 14:17:32 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] test/bpf: skip the BPF ELF load tests if net null missing
Date: Thu, 22 Jan 2026 14:17:02 -0800
Message-ID: <20260122221728.231962-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260122122354.1820368-2-bruce.richardson@intel.com>
References: <20260122122354.1820368-2-bruce.richardson@intel.com>
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

The BPF filtering tests need NULL PMD vdev to work.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_bpf.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index 0e969f9f13..78998c6194 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -3280,7 +3280,15 @@ test_bpf(void)
 
 REGISTER_FAST_TEST(bpf_autotest, NOHUGE_OK, ASAN_OK, test_bpf);
 
-#ifdef TEST_BPF_ELF_LOAD
+/*
+ * The BPF elf load tests needs the BPF programs to be successfully
+ * compiled into generated file bpf_test.h. This means having
+ * clang with BPF target and xxd command to encode object.
+ *
+ * Test also needs the NULL PMD to be able to have something
+ * to insert filter onto.
+ */
+#if defined(RTE_NET_NULL) && defined(TEST_BPF_ELF_LOAD)
 
 /*
  * Helper function to write BPF object data to temporary file.
@@ -3746,11 +3754,11 @@ test_bpf_elf(void)
 static int
 test_bpf_elf(void)
 {
-	printf("BPF compile not supported, skipping test\n");
+	printf("BPF compile or NULL PMD not supported, skipping test\n");
 	return TEST_SKIPPED;
 }
 
-#endif /* !TEST_BPF_ELF_LOAD */
+#endif /* !(TEST_BPF_ELF_LOAD && RTE_NULL) */
 
 REGISTER_FAST_TEST(bpf_elf_autotest, NOHUGE_OK, ASAN_OK, test_bpf_elf);
 
-- 
2.51.0

