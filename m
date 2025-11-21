Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C67BCFC295
	for <dpdk-dev@archiver.kernel.org>; Fri, 21 Nov 2025 17:09:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 99DE0402E7;
	Fri, 21 Nov 2025 18:09:56 +0100 (CET)
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com
 [209.85.215.182])
 by mails.dpdk.org (Postfix) with ESMTP id CF86640267
 for <dev@dpdk.org>; Fri, 21 Nov 2025 18:09:52 +0100 (CET)
Received: by mail-pg1-f182.google.com with SMTP id
 41be03b00d2f7-bc0d7255434so1260096a12.0
 for <dev@dpdk.org>; Fri, 21 Nov 2025 09:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763744992;
 x=1764349792; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Lp92mt8DEs+4Z3BFcQSxKPGzAOcDpLQADktLILshNQ=;
 b=C/IPLeqFbNeY9SEfMJ06ejJ1TiUupxSQ/DmD9lv36ecL93ewUKVna6qq5o8V6AqZh3
 +ilZT9sI1uIx3HG50utxfeX7anbKCNv5jFlKa9HAn5rnyoI4OgEYkvVt585qpuO79ZQA
 6EyZpL1tTMU+zu08Mgs9QO4wCadfd0e1KJjCyWxcTwYa560QaTC8rA4FMz2UBgEQ8zZb
 Jf3aTGmdZjbKaSE9tJr9RHgvRC7+XaDMIzkjw9RX7fRHmbt7qPtIlkShCSQ7BqbqiD+h
 lvn2DJkiK/6zmUnHXyhCsaOAvcCPqoBGYZBZekp/QXXtIu5XZzQAQuGQeYjRe9eJkh9H
 2B7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763744992; x=1764349792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8Lp92mt8DEs+4Z3BFcQSxKPGzAOcDpLQADktLILshNQ=;
 b=px8tEf9o+VmlV+wkgM7Z/Q7pNLx0rHneW6qDlxg85nRD9z2KcsEZFV11zW5hwUXCLL
 NJdj4PoadDYUzjIKj0J0EHnzHKci0/1wJ647dqxvXuVUcqM8jkp2nb4ixLrSTuNsb6ym
 tS9YsooAKVX6Ro9iqqK/X4+w3QUWRHlNoF2efBWOFkTDLNgfJyNul5JONUYly3/qlqw5
 e2ymIwngDQkOe5YaTUuW3tARgC87CSMHwjLvJw1es+nZKVexNOcwazVUZWBeGUtsTvgy
 bevA+K59nYf94TjOIDw4znNl0I2aSthSa3Qee7aabvESoQ2Hk1NLi/txSC5SGVhYO18t
 zngw==
X-Gm-Message-State: AOJu0Yxn1NSmoIG+Xe/hzMOE5eaigFE32HqGsDi+83fkG4Pdcz9+FPi7
 QwWSPke5Eew95TIv9URU362ROglkx6ng90VCR9N1QjTPINzsYOLKg36gpy5VkuoMm0PThl/E9a3
 cbkas
X-Gm-Gg: ASbGncsa/gaDCBLKzKN+2/UKfEzjkXGVfmy2pmkNOCBVgaXczfQ4RWjsvTjV5AS4XIJ
 k7jnDGTxRj3pwfN/eKSE/OSrf55zPsTfsos2VIr77HgXFSjkikO6HP24XIL1A+CkY1rHDatVsbn
 p7hGfRGuLLuO5qi7XX6XCwq0tUMrMMapj+TlnPX9CcQJWJT4FQ3pQchSDLs/X9sA4WuQ3lneYTa
 4VOKDEuxRzw/8IGJuadYwCcdZqV1Cf2qnh67MhIUYGKFOtLCY4Cue/iF8FmSmVcYG6apiyg47O3
 0YK0LdXLIoukYpqSqLu4zj9DPU42+3pOU0nISsWZoxL7n3Oxp9Wm1UaxYXixYRct0Kr/ingjkjh
 BAIoZ5eIvX6H0XP6532tAMhOHbrkqPJzIUGAnMp6jQQYh3LgBU7zkD72Fthm/GBxc98tx93e52s
 hCGmBkLQbARF3NawCZVns346BBxH2Aol1Wm0GDCszWd72tlvM8Og==
X-Google-Smtp-Source: AGHT+IHatVkMJovjQE352O9bWQvsMcU1+ouFPaZKMFqJ1iNP4xMTS8b5LfRkrVzEinRO1VG2+C8fTA==
X-Received: by 2002:a05:7301:4144:b0:2a4:3593:4668 with SMTP id
 5a478bee46e88-2a7190978acmr1074768eec.4.1763744991654; 
 Fri, 21 Nov 2025 09:09:51 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2a6fc5b122dsm21341544eec.5.2025.11.21.09.09.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 09:09:51 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v5 1/8] test: increase size of memzone name
Date: Fri, 21 Nov 2025 09:08:20 -0800
Message-ID: <20251121170947.134502-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251121170947.134502-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251121170947.134502-1-stephen@networkplumber.org>
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

