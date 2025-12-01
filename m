Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E813D116F3
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 22:04:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F215C4042F;
	Mon,  1 Dec 2025 23:04:28 +0100 (CET)
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com
 [209.85.222.181])
 by mails.dpdk.org (Postfix) with ESMTP id C3E834013F
 for <dev@dpdk.org>; Mon,  1 Dec 2025 23:04:27 +0100 (CET)
Received: by mail-qk1-f181.google.com with SMTP id
 af79cd13be357-8b1f2fbaed7so429718285a.2
 for <dev@dpdk.org>; Mon, 01 Dec 2025 14:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1764626667;
 x=1765231467; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Lp92mt8DEs+4Z3BFcQSxKPGzAOcDpLQADktLILshNQ=;
 b=R/KQ/oO1zXIPz5WCBcEUVbGHHz00KJbyp6FBL9mjnu1mK6aNGiXwbiIW3OsoPDsBEi
 yGLGvVE+rpLV+hcwXRftwPlpjvrbgpv2zLzfiLvrcf5W2t8g5CGNjynNsLXByOyilVrc
 Mg0v9HCrTftXEwQNdYSxZB6tU2KvNs62e6GoEDn0E8NMJSsTK6SucaoWdix1hKeY00i5
 NOqAvAIK/CZ1LJZq3cwUdIBw+NuZtFJ9/fSmb0adh1SHirs/AlUfDqQw9gPa0xm105HI
 hgyVAJcL8zHMRYfTJGYj761ZMEqKoFCSJDnkLW5pRglILzW6Y9kFf54B5vxB3Fvv2KwD
 tavw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764626667; x=1765231467;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8Lp92mt8DEs+4Z3BFcQSxKPGzAOcDpLQADktLILshNQ=;
 b=CEsM4xaLuhPOJ4jS3JXAkXU3cwq9PwQP1aro6iOIGkHstL1TW/vF7ov4TqlcgmNnHS
 Za0McN6Bhf49hInwL2xLoVCaT5AwqiQhcj4136lvpu2L9TXz/LCEJmbulkyfeZRSbtyM
 Hd0my71BkvWUfkk+WBt/o/e57tNJ3dL1p2RwFd1IE+rOSbPjwWpviqr2Ml/PCsaXNpjV
 y5HgF1fS8ZaUzFbndh3ky4YhqI9J13n2fYCc15+qPXlsZYSSKhPm0ehLb6S+EQN6TQJl
 jHlifCCU183bZU9gQ+T/Wlb+r8Dg05V5iyPKFIv+53Gp5sJuKv+VKfMxWstuYXhg3MOQ
 FUbQ==
X-Gm-Message-State: AOJu0YwmpBRSo3Xuco36haIEAd6iGiKjAoIz58NVn10BjOhulRXzrFJQ
 y7VnQAAr6AXmceBvx+K1Gfz5GovbVDMpEQEdK6bqN5l7V13AzClJu+3XLNUj4v610Wza5KWM19E
 VFNlA
X-Gm-Gg: ASbGncvXU20tbc9yWxe8V/4IqYYA2tyO0bchwZk3Jj3RuL5yk065bi1Ha5HF5eb7l42
 6XDCXEZIb0kN66DGht7zPWYJQf8plLDdmpArzDeROGs1emcGQOCg5gONA0ESqQNcaGTO3rksuik
 C7R4ZxxhiSWWYeIFhu02oaFwpsceHOKlngYeNNBUrWOXAt9Hl+E7Ku5xa96Z1ZqAR7Gjijgy+sl
 fxLpRWrOQ0KxcXP0/KGy/TMbHM1eOhRcgDWMJCi10Bc+TBA4DGWhr7dnxj0kXjLR9q4VifNaEWf
 FF6JaiS6DNysxJ68aMlMTO52muTSmj18HrUTBgYF6YZQOh6EYsT/vWRncrz9ZKuuFg5DjLxbRE3
 RHp8t8FTx+JsoY4woEk9jmNg6SKIih9sXrhc9NgGDSI2ww/P9YFZj3ZSd3NWp7Sj4jYfC7HAtgW
 tvZkCZB/w4gKbv4VodigRDqCldIhetq8rQ7vH4dswN1vcoODKpDQ==
X-Google-Smtp-Source: AGHT+IGF26UHdGOtBRQg/zKifYjon8dvd95Y23dQZlNwFUo3Xt2j5eOrSbRw2Uh5yd0HvCyEFInUmQ==
X-Received: by 2002:a05:620a:400a:b0:8b1:c1d3:8e80 with SMTP id
 af79cd13be357-8b33d4d09dbmr4860845485a.58.1764626666900; 
 Mon, 01 Dec 2025 14:04:26 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b52a1cad4esm934398885a.45.2025.12.01.14.04.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Dec 2025 14:04:26 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v9 1/9] test: increase size of memzone name
Date: Mon,  1 Dec 2025 14:01:59 -0800
Message-ID: <20251201220421.207285-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251201220421.207285-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251201220421.207285-1-stephen@networkplumber.org>
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

