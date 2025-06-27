Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 885A1C7EE2A
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Jun 2025 16:23:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B5CB2402AE;
	Fri, 27 Jun 2025 18:23:11 +0200 (CEST)
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com
 [209.85.222.174])
 by mails.dpdk.org (Postfix) with ESMTP id BF4D7400D5
 for <dev@dpdk.org>; Fri, 27 Jun 2025 18:23:10 +0200 (CEST)
Received: by mail-qk1-f174.google.com with SMTP id
 af79cd13be357-7d3e7503333so267781885a.3
 for <dev@dpdk.org>; Fri, 27 Jun 2025 09:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1751041390;
 x=1751646190; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ucc00jyvXcWWzHAdR63j/37CU3YS41EQdWDWiIqSo1g=;
 b=fRD4KIF1Tf2FR7MLCJlbm2X9Sew0QuP8QOg2NlF2QKgicm76WXwlut0iW5VwVv9T7l
 uErXM/86Caivmwc+LXx/2Hkb6AAHMjfJA5Jzs3NT/OcC8rOJutmpAuUbKn4unoHnDuha
 sSQVdjrk1j9uanQuOITVrsfZs4rPdJvLXqDsiueitA8rIgZSQBeaYeqZipZV7DOVGC1E
 xl6axmRvh9XfX/5TKy3EmCvuaV4bUO4YZVZFvtNSNYOsfgH/zL4ehbZOeoZ/pNb/sZjJ
 698yP1BVMqL8CrXiiw2WLlDQeyFLbzBMO0SsdR3wQFP4/ke2OBtzasfMvz1cvpe2xC6K
 GOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751041390; x=1751646190;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ucc00jyvXcWWzHAdR63j/37CU3YS41EQdWDWiIqSo1g=;
 b=FPqongL28pVp5LY9j1YcPso1dngFXDQl3F8A8+5UObStbjO+XCDo5ZFsa+kzcvDP8j
 XVo4/jRt/RPVUdZx4QbrPxQ/xPjfR7RoyGEDQ+BCJx2bVtXs5/uKRFLQwVlxFZMDH3IV
 yqFHPM8NUlHdNTZGhL3OVwmshJ0GCPjaoz2EjwX2d3N9dCnNpfSdRGE4yGou5znq6NLn
 AX6obx3pNfoHZJR4AUoLJkmTMP4XCninBmUEmmTxXUjfL82EU5lN8QLFUyUslSKFt5Ij
 8nYKJX/WSi4T6Sti+2iQH/LN4kxsL0Kakxt/4ScMGWumfkInt5bXTuklzLpjc3dTQKtT
 EGzA==
X-Gm-Message-State: AOJu0YxlkcB7/KJu3tfRbQw3QXVJ3D3jyWUD/jl71KD/dH6mLE3lyzSa
 uZ24RhigrNt4a3PONmJn4hMpxbkIOSUaSPstTcVL5gFk/XUv9I1KMoXbM8LncsD6UMfEMU2Vbi6
 o53GC
X-Gm-Gg: ASbGncuT4vvzwPyiRLNanH2PGQ2yDxlrtDycKzmEzR4UMSGQsfNRInTZiXCudN56pbe
 im3yxF0cl5AYMbHzhSZq/CD1wssKDUBgmpHtzok9J1d08fNXPbR2MNCM7lIElTWEZu6Xxxfgwqg
 B0K4tJdGKjlaXEBpRDUNILyJI2HECgLVGFHSLSa1qYgviha74hMi9xpqQwu8NN5ETjyH9KwIQd7
 DfHKp7ZDt6BdGaWZ+Is/w+dfsnu2X2nlBbWbYXRxRCFVKtdu56Ml5a8+9LzIDPQjbgQHZ4fGphu
 h1/sGBXlmnrTjG86POi1pQfc01BpaHzrrZk03cy1rsIODsLXRz2T+rt1HBxm6ZuGGgwXxIzqEfh
 rUy1yE8LJaUeaOl6cNgqzjFo8sO5kqWNsx7CTSF6fpL6uEz8=
X-Google-Smtp-Source: AGHT+IH1YUm4ukxSp1EKCbmKShHcPZX96K205m3KWj7CzHB7fyUTUoC93dsE3W0OvnR4WqDv8OgP6w==
X-Received: by 2002:a05:620a:7016:b0:7d2:27b0:370d with SMTP id
 af79cd13be357-7d44398a220mr518697885a.42.1751041389671; 
 Fri, 27 Jun 2025 09:23:09 -0700 (PDT)
Received: from hermes.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7d44316a54fsm157384985a.34.2025.06.27.09.23.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 09:23:09 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	fengchengwen@huawei.com
Subject: [PATCH] test/argparse: fix out of bound memcpy
Date: Fri, 27 Jun 2025 09:22:35 -0700
Message-ID: <20250627162305.340042-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.47.2
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

The rte_argparse API use variable length arrays for the args.
But the test was only putting space on stack for the argparse
part, not the args. This can lead to out of bounds writes.

The bug only gets detected if DPDK is compiled with LTO.
In function ‘test_argparse_copy’,
    inlined from ‘test_argparse_init_obj’ at ../app/test/test_argparse.c:108:2,
    inlined from ‘test_argparse_opt_callback_parse_int_of_no_val’ at ../app/test/test_argparse.c:490:8:
../app/test/test_argparse.c:96:17: warning: ‘memcpy’ writing 56 bytes into a region of size 0 overflows the destination [-Wstringop-overflow=]
   96 |                 memcpy(&dst->args[i], &src->args[i], sizeof(src->args[i]));

Fixes: 6c5c6571601c ("argparse: verify argument config")
Cc: fengchengwen@huawei.com
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_argparse.c | 56 ++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 34 deletions(-)

diff --git a/app/test/test_argparse.c b/app/test/test_argparse.c
index 0a229752fa..f4b33e2726 100644
--- a/app/test/test_argparse.c
+++ b/app/test/test_argparse.c
@@ -70,43 +70,31 @@ test_argparse_callback(uint32_t index, const char *value, void *opaque)
 	return 0;
 }
 
-/* valid templater, must contain at least two args. */
-#define argparse_templater() { \
-	.prog_name = "test_argparse", \
-	.usage = "-a xx -b yy", \
-	.descriptor = NULL, \
-	.epilog = NULL, \
-	.exit_on_error = false, \
-	.callback = test_argparse_callback, \
-	.args = { \
-		{ "--abc", "-a", "abc argument", (void *)1, (void *)1, \
-			RTE_ARGPARSE_VALUE_NONE, RTE_ARGPARSE_VALUE_TYPE_NONE }, \
-		{ "--xyz", "-x", "xyz argument", (void *)1, (void *)2, \
-			RTE_ARGPARSE_VALUE_NONE, RTE_ARGPARSE_VALUE_TYPE_NONE }, \
-		ARGPARSE_ARG_END(), \
-	}, \
-}
-
-static void
-test_argparse_copy(struct rte_argparse *dst, struct rte_argparse *src)
-{
-	uint32_t i;
-	memcpy(dst, src, sizeof(*src));
-	for (i = 0; /* NULL */; i++) {
-		memcpy(&dst->args[i], &src->args[i], sizeof(src->args[i]));
-		if (src->args[i].name_long == NULL)
-			break;
-	}
-}
-
 static struct rte_argparse *
 test_argparse_init_obj(void)
 {
-	static struct rte_argparse backup = argparse_templater();
-	static struct rte_argparse obj = argparse_templater();
-	/* Because obj may be overwritten, do a deep copy. */
-	test_argparse_copy(&obj, &backup);
-	return &obj;
+	static struct {
+		struct rte_argparse cmd;
+		struct rte_argparse_arg args[3];
+	} obj;
+
+	obj.cmd = (struct rte_argparse) {
+		.prog_name = "test_argparse",
+		.usage = "-a xx -b yy",
+		.exit_on_error = false,
+		.callback = test_argparse_callback,
+	};
+	obj.args[0] = (struct rte_argparse_arg)
+		{ "--abc", "-a", "abc argument", (void *)1, (void *)1,
+			RTE_ARGPARSE_VALUE_NONE, RTE_ARGPARSE_VALUE_TYPE_NONE
+		};
+	obj.args[1] = (struct rte_argparse_arg)
+		{ "--xyz", "-x", "xyz argument", (void *)1, (void *)2,
+			RTE_ARGPARSE_VALUE_NONE, RTE_ARGPARSE_VALUE_TYPE_NONE
+		};
+	obj.args[2] = (struct rte_argparse_arg) ARGPARSE_ARG_END();
+
+	return &obj.cmd;
 }
 
 static int
-- 
2.47.2

