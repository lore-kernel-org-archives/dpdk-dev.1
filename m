Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D59CDCCFA18
	for <dpdk-dev@archiver.kernel.org>; Tue, 11 Nov 2025 22:19:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0319140650;
	Tue, 11 Nov 2025 23:19:11 +0100 (CET)
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com
 [209.85.214.171])
 by mails.dpdk.org (Postfix) with ESMTP id D37CD4065D
 for <dev@dpdk.org>; Tue, 11 Nov 2025 23:19:07 +0100 (CET)
Received: by mail-pl1-f171.google.com with SMTP id
 d9443c01a7336-2958db8ae4fso1594105ad.2
 for <dev@dpdk.org>; Tue, 11 Nov 2025 14:19:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1762899547;
 x=1763504347; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4rEQ4wKkWaKtvZxHf0A2DkaDUDMwHWMDwuh74S3zxYo=;
 b=GBGa6NtWjIIC4vVOxRRwhl1U3aTaz51VBUJJGLOA6jXhQoap3JgQ68CgcVEgZhzs8s
 eBQbaDbdZGW96Wp6OcDqy9vGfCGqQBWJ9KgTRgu3HpUtPQgV8C5waCfQzAm7Ce3AwGQ6
 80QPEx6MzdgTjxykfH2pm2kHLQ3pjl/F3aDx7GKMDtHGokyYlWpKQOZe5xuS3PRfCvDb
 bj2Hc6ZAuWl/4EVUFUZwKViU0OsVx8az57OwrMG/hzQ7ZsSrnr/bMlHjqhKCuRflJmAw
 388CugBRc8DgouEcK6n9jIDH+QsWVE9ykPEiNo1djwV1lL7BpKU6FjASa7oRAV6NH9mQ
 u8mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762899547; x=1763504347;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4rEQ4wKkWaKtvZxHf0A2DkaDUDMwHWMDwuh74S3zxYo=;
 b=Xf2zgE35KMrhTtttAbx8Is1WLnqLvLiLxlmFHcg5gQtkqDlnIN+BtNlLw6WDBt0aAR
 Jqwy8OZ9LamH6Z6HTmTr/yApJRlxDU3srTMDUuf5NDldS0ZbDsVP1RclqpryzpYstr36
 kERyqT/EXN+P3hbkQ9im9pKJ5sU5T0j2i6kGV+cWtl+QYhnUXZhxHKUI60YImdl9qAzN
 VFmx901BrqL0HzZju+/3nTouxdB0BrwcIzT9pqPIfpwY5ZFIAOrWkVFeRulQJoXEBFru
 ndx+OpCvt4jl4J5ny0iy+6rfS0WA+pWBLcdQDiBxsluYt3Zsll4b4Y4sMzTtsFLmwtmD
 Rx4g==
X-Gm-Message-State: AOJu0YwmAoA3n0Y2K8uUavVurvlpZJSuTX9Ta7gHLPeEvF4VWUChS9Px
 JEWksw/r88nbpK1+oj6MIRHc0FajG5CClJPCLC8mdQGVcp3E2cL5ACNB5xJ2Yv0KCYAERHxfcOq
 +LLWD
X-Gm-Gg: ASbGncubC6Q0FadMpHazbEJliX/7QJMkSgyqm/KEOaCjvDRmkVGyonCy0q27Nm+I6Ch
 25/j5FcTQgTyiZAON5adcjXV7TfTXF6KiZcAkEHnad+KaMWPFlNgSUAlLW9EnMBcNS2dh3eQyAu
 I+G/+hlRZnLmHebvQM9I3jqMNT75FriNU4HNpvS2ALZ41s9O1DE69ZVXcYbNySEPb7QV1MLSa5p
 NW24O0szmmZxzyXFlfGSIvx3OWsU56eIg9OmdlZ4kyfO/ZPoCIIxlWcaThan6pUzpk2IzBIFqRj
 P5hOcsnQcA5MmMWDT5bG1mNgIsyN1onQ0NlybOlPJ9VmrI1koWY8kHgjzVSH1Bx+3hr0A0EIlOR
 tKafFdh2EzJIfislTgIzECjMYqyqkKNpCSE+TONTWAb42krQhW+QbpzGzZEA50lFJ1zQa27QpsF
 NnTYhXVn3AeGQiU/I5XpAMg77BOq3XnfExBi9pZyc=
X-Google-Smtp-Source: AGHT+IGcsBJzZyqhREZI7ugFi72XpGZZKWQJN8X7u3d+IfAsmc9MgwkamT4rR7kHLyZj7/eYAGYMCg==
X-Received: by 2002:a17:903:3510:b0:295:96bc:868c with SMTP id
 d9443c01a7336-2984ed2466dmr11216115ad.5.1762899547054; 
 Tue, 11 Nov 2025 14:19:07 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-343e072e5a5sm157001a91.11.2025.11.11.14.19.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Nov 2025 14:19:06 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v2 6/7] test: increase size of memzone name
Date: Tue, 11 Nov 2025 14:17:23 -0800
Message-ID: <20251111221857.443752-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251111221857.443752-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251111221857.443752-1-stephen@networkplumber.org>
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

The tests were using a name buffer of 20 characters which could
overflow if number of memory zones got large. The upper limit
is defined as RTE_MEMZONE_NAMESIZE so use that.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
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

