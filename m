Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8B7CD4F3E
	for <dpdk-dev@archiver.kernel.org>; Sun, 16 Nov 2025 19:00:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D35D94270A;
	Sun, 16 Nov 2025 20:00:41 +0100 (CET)
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com
 [209.85.210.174])
 by mails.dpdk.org (Postfix) with ESMTP id 78CB140E2F
 for <dev@dpdk.org>; Sun, 16 Nov 2025 20:00:40 +0100 (CET)
Received: by mail-pf1-f174.google.com with SMTP id
 d2e1a72fcca58-7b8d99ad095so2809594b3a.0
 for <dev@dpdk.org>; Sun, 16 Nov 2025 11:00:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763319639;
 x=1763924439; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Lp92mt8DEs+4Z3BFcQSxKPGzAOcDpLQADktLILshNQ=;
 b=C6gKw1r492foW1VQmUumjiay6ROkRSu0W4FKU1Brey08IWjaR0TFRD0PEA9UDm3ldL
 Pt/wd7vDbwbjBCqegM7zULlrNChyOkKOjUmXgI5tfS1OR6i/uUMJVOBNumDLHL0JM4u9
 RJLXeCwIIfq4A/bvJBYXSvdImNHMOXWbgR/1xAOOweNzb5LOCSmcOGRYLc/nKwAyLfSj
 VYWhBzrMJVjYDI1TwaCy1QIATaad5SbCSUUGGRT4R460mW8/z08BTwtnS2Y/V2oH7hvs
 Oufz96oVLwJXgmtFYL2R9HKiiUcvGIJUpwGkEv3PwGAPoz8PdYO+YVIEpjGpYQeeZcv2
 SwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763319639; x=1763924439;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8Lp92mt8DEs+4Z3BFcQSxKPGzAOcDpLQADktLILshNQ=;
 b=YkLlA9Nzvet+8hnesmyAsxvT/rlcQhaqMQZivcGQ98KBXpnrmGQoUuvF1UD8V5sq3l
 JUqH128cWCNojOBNnk7/JzJzo+o6cZIBlfC/nY/V4KKtd5YeVqBTuCqzIkQ4R6ZqooxY
 FRVPhIZoxCwBNg16HcUxVJUiYMkHb1xO1GTv8RrMGL+DS3OIMJI9VaApCi/bNRxyuGLX
 +y80SwgH9D/oLjA1H++l0ZNXtvozIzkEHRNhgCZFgrmMVZKcDH3Ja5vK3IGFAVBbk+HD
 FnVFSt2NFsjbUKQXXc1jvWooWLsf2R38t12kRa/HYLLLBmPwYVJKEn2vZGUNYcGKSTCJ
 cmSw==
X-Gm-Message-State: AOJu0YyZRvx27bSAwsyOW89rYOCFjBeuhEdrfBMW1p6Fa5q/jgq6g+Vh
 lBQBaWZ3JLu/7poEg9tO3RAWPukAXX0p/YHaPVqzntGFzpb7FjWdDFYVbmKJteYhBaA+VkcVVAs
 tpn8h
X-Gm-Gg: ASbGnctxX5/v6+M1zJBFP1vAoyC7RKs59SxXwYEytSzsgCWXEvHZiVyMb/hKv8ifgt6
 l+E4W9vat1iTXch4xr32Dc7ly2qkGtLPlW+oDR0Ye2TPSATOCDH/EVZnazKD9Sh8a5j9qmuY8v4
 n8xUAA3xOZXxDG1xdS9S4IdmCaayXGYGuIBFCHCNmO/vvbaNFT2RSkKiq6SpNG1E6wUR7QyYxOQ
 ooo7339iDD/9QGHcfJZvc4W+9wlIBcl03aOFW4gOh3LLbLWcd6VK7DPqsmYpdLMV4IPBjZuwi44
 +S4iVt64YV9LQMpedkz7Wn2FC3WWwXEiFSbUHJjA3G1uW2mqQMkjNodtJ6GVVefDebfcSbdGqtA
 pY4AphaHmG67GT6anQ5+gMUZvKrGJw9X2dDoGa79TRTOFvq0sZRcNxvEvImWUSM6zc/JOcUWVc0
 s6vScVesYpT0731VFWYxlhwiGmBoLoLGPHYAVW3rSqGAfN9zZXG/HW6TgMw6wn
X-Google-Smtp-Source: AGHT+IEw+QEkTUzmf8o1+taC8Em0iPET28N3lwo9dIeiRi14K8B6izJEOp8rLZrhJP7lS8PjXC1+Sg==
X-Received: by 2002:a05:7022:150a:b0:11a:2d4e:a8f2 with SMTP id
 a92af1059eb24-11b034f4ce4mr3799913c88.11.1763319639239; 
 Sun, 16 Nov 2025 11:00:39 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2a49dad0aefsm28215946eec.3.2025.11.16.11.00.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Nov 2025 11:00:38 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v2 1/5] test: increase size of memzone name
Date: Sun, 16 Nov 2025 10:59:29 -0800
Message-ID: <20251116190035.76123-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251116190035.76123-1-stephen@networkplumber.org>
References: <20251115193409.99740-1-stephen@networkplumber.org>
 <20251116190035.76123-1-stephen@networkplumber.org>
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

