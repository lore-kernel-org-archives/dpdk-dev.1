Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03E91CF9C4C
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Nov 2025 16:57:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9C246402DC;
	Thu, 20 Nov 2025 17:57:19 +0100 (CET)
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com
 [209.85.210.175])
 by mails.dpdk.org (Postfix) with ESMTP id 5A2C940262
 for <dev@dpdk.org>; Thu, 20 Nov 2025 17:57:17 +0100 (CET)
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-7b9c17dd591so1075588b3a.3
 for <dev@dpdk.org>; Thu, 20 Nov 2025 08:57:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763657836;
 x=1764262636; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Lp92mt8DEs+4Z3BFcQSxKPGzAOcDpLQADktLILshNQ=;
 b=kv+iBkR9QSkf9vlWWDl1Qr1dCtpZ90J/wUaYhsxqrTCjAJbJRLcJi9ufXsEuwfn0Y/
 YNUFEMpU+Sz7RlsZGxXWi8BEE2/Ga1A21XnBoe82P8aLSBsYOOz8GnRUDTPSkemC4IEh
 yZ35Q2bt9EXbmkkj6a7ObytKLR4Ea9E1mZzQzTHKi0luGA435Gtae4adnN7lmRFZHNsB
 hDaYZOmKQLXcC3pYMIkwhWSebKLRlUhZmvXXjP66hw8wgDIS4kQqGW3gFeWwzynf3iRC
 ILFEI8wHgNLXkuR/tMMaqAniulbxp+nE2I2pNBQWtBPTdpuWKKOE1OkQzB0HDAuf3pSL
 wuIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763657836; x=1764262636;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8Lp92mt8DEs+4Z3BFcQSxKPGzAOcDpLQADktLILshNQ=;
 b=wj1q4hupGHts3bAsdburAgeMVP7ZH2xSmx05K3DrYs6KMiFdSF31g6wu+O8KNKxFaJ
 +qiagWzYL2cQQXfWdwLeV8SRelUUvcsdjIALhLAErvDLoXCuIiymwsJaYqksv4HYzrWO
 KvotMK1EG9x9b5RGVAfaUiGHhqhd0BPUC6l4MvZkRpKnn0C6LpwWjj9RqDlEsrG5O0dp
 BU/fUfM+a7mVd4H3pg2s3GZZc294LPu/AXZfxXP14T7VEaOyQUrhjwxdAJcxRJEkGihU
 o5JK8EA7w2wu84E3MI0wvtQ6uDPGckAgB7dMLyzodz9SZUc9jHwXx2L1hOWtvVb+6O9L
 gQ7A==
X-Gm-Message-State: AOJu0Yx0fALyEsQnCdl7JWW3Eh2/k7PWr3vZdw9WP6X0UWXiqXg2/CQY
 JIARTNxLv/AF63GdTIcoNdXgeNVRUppAUHHulMi6fGGcxcIRTtTgVzRwbCJ1uJjBgYW7H5IA4PZ
 oXmUu
X-Gm-Gg: ASbGncudqetvbaskTNsooXOaa59yqhwOY9UMPJw5KDDoyYAXcTYoq2WFjldD6Dairjz
 6M9Viy7QORxHN2w57LlSVKyl5uxl3GCkk1Y01bF984S71ojsIXuhkIIqkwzBiElqZ94TjyHi6dT
 4sbZZQDVTY8w00jY2QN2bpFe0te3DGfIWP2/HC04/pZES2CWx7Ub/GfH8cr532lL3eq27/iunRw
 cOfULhI5miUldXPOcRUKF57aeh2rb8d/VOvLe0R/eyIyyFACZLbMXoaYmVFgkIOHNheYKm5WU0W
 eWph2V9+dRY4ygvBe+HK2KTxbwsxH2dH4Ds7IFIPnWQl5RLQ+CRdUwipw3d1I4oUkd3rO7Bsfr4
 T/Q1No65GumWG4sBosfCboe1wUUgwgo+vc2XF5VJ1TEXjdKC9oxqtjIsJ7C4GB7Rv3AEpfMVLub
 4vJfI36Rw0kEPQJ+hpueEPwpnsbM8zuAP6R4mS9LOPcPkLPF2fyA==
X-Google-Smtp-Source: AGHT+IGXav8GX+N1yvqdzBYxZH90qCPQDzhTFEaiLe1g7TZ5D9LmIfwzvbbdoN7Rrw10BjKIdUiXqA==
X-Received: by 2002:a05:7022:48f:b0:11b:c86b:386a with SMTP id
 a92af1059eb24-11c938137c7mr1244287c88.5.1763657836307; 
 Thu, 20 Nov 2025 08:57:16 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-11c93e55af3sm11536747c88.7.2025.11.20.08.57.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Nov 2025 08:57:15 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v4 1/8] test: increase size of memzone name
Date: Thu, 20 Nov 2025 08:55:29 -0800
Message-ID: <20251120165713.120238-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251120165713.120238-1-stephen@networkplumber.org>
References: <0251115193409.99740-1-stephen@networkplumber.org>
 <20251120165713.120238-1-stephen@networkplumber.org>
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

The tests were using a name buffer of 20 characters which could
overflow if number of memory zones got large. The upper limit
is defined as RTE_MEMZONE_NAMESIZE so use that.

In function ‘test_memzone_free’,
    inlined from ‘test_memzone’ at ../app/test/test_memzone.c:1117:6:
../app/test/test_memzone.c:52:35: warning: ‘%u’ directive output may be truncated writing between 1 and 10 bytes into a region of size 4 [-Wformat-truncation=]
   52 | #define TEST_MEMZONE_NAME(suffix) "MZ_TEST_" suffix
      |                                   ^~~~~~~~~~
../app/test/test_memzone.c:931:46: note: in expansion of macro ‘TEST_MEMZONE_NAME’
  931 |                 snprintf(name, sizeof(name), TEST_MEMZONE_NAME("tempzone%u"),
      |                                              ^~~~~~~~~~~~~~~~~
../app/test/test_memzone.c:52:35: note: directive argument in the range [0, 2147483647]
   52 | #define TEST_MEMZONE_NAME(suffix) "MZ_TEST_" suffix
      |                                   ^~~~~~~~~~
../app/test/test_memzone.c:931:46: note: in expansion of macro ‘TEST_MEMZONE_NAME’
  931 |                 snprintf(name, sizeof(name), TEST_MEMZONE_NAME("tempzone%u"),
      |                                              ^~~~~~~~~~~~~~~~~
../app/test/test_memzone.c:931:17: note: ‘snprintf’ output between 18 and 27 bytes into a destination of size 20
  931 |                 snprintf(name, sizeof(name), TEST_MEMZONE_NAME("tempzone%u"),
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  932 |                                 i);
      |

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_memzone.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/app/test/test_memzone.c b/app/test/test_memzone.c
index 506725ea41..6586dad18d 100644
--- a/app/test/test_memzone.c
+++ b/app/test/test_memzone.c
@@ -872,7 +872,7 @@ test_memzone_free(void)
 {
 	const struct rte_memzone **mz;
 	int i;
-	char name[20];
+	char name[RTE_MEMZONE_NAMESIZE];
 	int rc = -1;
 
 	mz = rte_calloc("memzone_test", rte_memzone_max_get() + 1,
-- 
2.51.0

