Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFF5CC9830C
	for <dpdk-dev@archiver.kernel.org>; Sat, 17 Jan 2026 02:38:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F8DF42E86;
	Sat, 17 Jan 2026 03:38:27 +0100 (CET)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48]) by mails.dpdk.org (Postfix) with ESMTP id A2A9B427E9
 for <dev@dpdk.org>; Sat, 17 Jan 2026 03:38:24 +0100 (CET)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-b870732cce2so412576166b.3
 for <dev@dpdk.org>; Fri, 16 Jan 2026 18:38:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768617504;
 x=1769222304; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zKjW/f8lSZG6KF7TsU1zkybC3ZAzYHoz0LLJvS5D7q4=;
 b=DhOFaQ+yxFiaR/Rbi4dhjT17qs/gPKLf41Yug72blCRpBbQEHlEYKzf2CJs9doho3I
 R43PiFgha+wR8PCiUJy8/HbswhJ6sXhhpZbT60uXI4fj94M0TUgknwT8otXVB+e49HDT
 FqaCYVCAjgVO2vO3XDTFEATqmqKFvd9ulEv7QoeIuQ8MJj4Rvf4LpFM1MDSCTUaeLUFw
 A6dJ5YwtE0sM9NZQzxBjtBzODpXSl847t9DRzp3p12KL20UMGL9kHfjkQZCEjFnw5dHk
 CEPCRHNZl39qhhppCKzybgPJyLAe9Nl5svatJAuiKw1N4I+dSrylFHlF49/DfwS4u9Ap
 uazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768617504; x=1769222304;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zKjW/f8lSZG6KF7TsU1zkybC3ZAzYHoz0LLJvS5D7q4=;
 b=iISExcORHH9Y9EJtD5sfrXlAY9u7WKuLQXjdohYiI4fDvfAkrnbwdOPgzVgDo0sGeo
 5uNykLfO4SeoIFUSmMBnyAL6tGPZTHj5x31dljNE973/QsKuFbTyr3Zlsu4vWm/Jn5vH
 79/l47YGr9ldW/KuxYjMHTHEbI2iM/F3xcfDIwSj+3KDRPS19av4vXLuDeYkSiXmuIpu
 A/EsujsAd4yAKeNVPqfi2e2yhdp9hPAmdDTVwqPV1RTtXdg50xWUiGeY3KLLvytX954b
 JVxsYJWBOKv9uwY4zhvCKFo1cfS/lQWzuy51cGkX8JGI6oGJI8VlGeLXChDLVQCdUlGG
 9ECg==
X-Gm-Message-State: AOJu0Yw6wJ23SOr3YwJzjW4EuReMv3AG6AMElRn6xHm93HBFCeN2JYmu
 KEclEu6xOTQb8BWkb9Kl7xMV0T4jGa1CyCYp0roa5c1Iqwes1Qx/lRfPUmJB4Jsirb0Js8SZ4Ja
 xEuAx
X-Gm-Gg: AY/fxX5C5Dq4KEQbrfVGeJ0g6oLLLNShbZBW5T9CBigvW7UxKzaFDZvo7g4GJXNpp6a
 /PBV2Hq7f5e9tAWQlX8aeHMNKPQsxHDlsN5CzTNShXhV/c+W0sIe16rAtOAt/J3ieRdrbOaR6qn
 gHog1qIyQHvdsro1RhCel0wdHhHEHrz1bSiYy5F2nEIE5DDpljmNEw/GZL6+Q73+WvGXjJwy1Ws
 ApaN2zpeDNxZLMOp2EN2Hy/5LdAyxvdhZT4/APFO8xZEvdqOStyzrvSjAT2KtEysX0KgHQ96JNO
 laBIGnUlC9PYDA3TxWFol1lEk1JiTg9EOcF5udkck93m75Yf3F8Zc7uThI52tKb+54RVhwO53+x
 t4rbVXmQzdXpwPq4wBXYyJMXMV+pLLMPZieJRMMAA92qlRgjKVSkmcKL37vHUFHbQIgVxJ7+Gzk
 31NvsZKmTZuJx2ZY0M8sb0olygxtMl6Ry6uO5mANoScI3FutAvwkgpr64iXXZr
X-Received: by 2002:a17:907:3f93:b0:b87:2780:1b29 with SMTP id
 a640c23a62f3a-b8796afd7cfmr398242866b.37.1768617504171; 
 Fri, 16 Jan 2026 18:38:24 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b87959fb980sm439960166b.49.2026.01.16.18.38.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 18:38:23 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v11 1/6] test: increase size of memzone name
Date: Fri, 16 Jan 2026 18:36:56 -0800
Message-ID: <20260117023817.196694-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260117023817.196694-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20260117023817.196694-1-stephen@networkplumber.org>
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

