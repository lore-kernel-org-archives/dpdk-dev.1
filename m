Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3D9FC44506
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Jan 2026 21:08:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7646742E7B;
	Wed, 21 Jan 2026 22:08:18 +0100 (CET)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id 8124442E7B
 for <dev@dpdk.org>; Wed, 21 Jan 2026 22:08:17 +0100 (CET)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-47fedb7c68dso2892245e9.2
 for <dev@dpdk.org>; Wed, 21 Jan 2026 13:08:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769029697;
 x=1769634497; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zKjW/f8lSZG6KF7TsU1zkybC3ZAzYHoz0LLJvS5D7q4=;
 b=YVgo89y8dHSRlQNPo2d+sT7N3B+qIW8T5mnZybRs691aJXzRd+Paf12fMoFoUxf9Sy
 grHennGYTCx2xGr7CEcUj2J2eNNFXXxBinEIqfMvXfewk1ogYh2oborNng68Ix4zHhl9
 /iL5Hx51NC9FAA6sUGyPUAGioPjqutLgEU1I8Q3E9/retlK3VM10DhKZaq2xuzTo3dUv
 feYsFi/VYRwlySYPxitZSOUdli4S92KG7+NDshGvsdtita4WWBP/JxRdTv2aqIsSk/65
 WruGomjQaHcFQWVLNZffmGyxNYl/PpQxbt4bqLasJHLFXlCe58FnhxdupGf1RYL++m97
 UyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769029697; x=1769634497;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zKjW/f8lSZG6KF7TsU1zkybC3ZAzYHoz0LLJvS5D7q4=;
 b=pnKU82ISDZKG77HhG6UUQ5YFRovDBfZs2o9aTDggQm6wyYRvIlSNWrO7adYdzKv3Ag
 80qszcTWO4dqqtYKnbi3bQ8M4Hd2JIttYRd/3qalZRyWiKVGRQ0wjLOiTT+XeEnlbmcc
 AIn+GYHb9taoneXd5hLhpoLCIxpBonJaPs1HGnb0Fkawo+9uc8HYKziWywZNzyVj7KDC
 6kMVbwFPXBtRgxNXcxKHWbQRno3v3dEBb/bQn5EeC19nzhylceDsz9umj89iXrgmBOpt
 WsmlSUkXIYamBO7cCtzN66F5XnOKUK4tHfP+kDFScFcDNSWwitsNBSWQGVwuKZuMW0Be
 2Z0w==
X-Gm-Message-State: AOJu0YzuNS4OWbk0QjSxu/h39tqcjaYwEjqYiL1rhcP9kCB5FSTKSknp
 nCVSEbXtbvq0kXd3mIt8P94CcE0l4GiGbsUuOmPw8Yvol8sTr2vFDGIR/RGTpxMcwjE3WoPG0nx
 U3nl/
X-Gm-Gg: AZuq6aJ0Pk+ORmdgJpE/RswfJoViAOdI3FB0nNPZEIdp5J315g9/utdFBXqcusTBgOS
 4yDJgeFifi108RiuDmBpWE/I4o27tqm+ZOELKITOwbsCWvlEbLC0oemnNTO/bwfeh4MxT5Xp7l3
 7l6tKKr+N/vmHZepMBYCgyK0abURLboYbcWIG4ZffzRKhzFfwknfmAJV2gstL7RzMhRtagP0f5L
 1jkHBKIeLhqocVqGjE7HloFgWWpmBTh23dSD26fVnfOMUcF+K7rodWKbBadjb4HKX5oDMsEU/U5
 xgZKYXDhbeMPmG6e8NKBghgQAGijGS1BP/ZvcB/oDnNxurrD6yPm/OyPzc36BI5vXlUuohMSA0s
 BgZzQN2xn/tnnUZ44oBslH3fapPgvsTNFNMYR7sqb8Ugf5XM+enMUVdY2ArMAiTWHnUZ+SXWfJ2
 f9lAaYhDO6TpX2yidyVt7qjsHSzsY4HkUAiWuqMYtyhOF+uLksug==
X-Received: by 2002:a05:600c:4e43:b0:477:73e9:dbe7 with SMTP id
 5b1f17b1804b1-4801e358875mr260775015e9.35.1769029697043; 
 Wed, 21 Jan 2026 13:08:17 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48047028928sm27539845e9.2.2026.01.21.13.08.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 13:08:16 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v12 1/8] test: increase size of memzone name
Date: Wed, 21 Jan 2026 13:06:21 -0800
Message-ID: <20260121210810.1044276-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260121210810.1044276-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20260121210810.1044276-1-stephen@networkplumber.org>
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
index 5094d15159..8712690561 100644
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

