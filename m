Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0AACFA46B
	for <dpdk-dev@archiver.kernel.org>; Sun, 23 Nov 2025 17:45:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 64D38402E4;
	Sun, 23 Nov 2025 18:45:12 +0100 (CET)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by mails.dpdk.org (Postfix) with ESMTP id 692D6400D7
 for <dev@dpdk.org>; Sun, 23 Nov 2025 18:45:07 +0100 (CET)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-298039e00c2so49620225ad.3
 for <dev@dpdk.org>; Sun, 23 Nov 2025 09:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763919906;
 x=1764524706; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Lp92mt8DEs+4Z3BFcQSxKPGzAOcDpLQADktLILshNQ=;
 b=WijvSh2HP3CVWmaXZUqQ+E6mqIrP3rFRCJARzCW52S1shA98tMKxLRzG32Is7CNvDV
 09uUQ4tAVmoytWSCploXpwVMwIoYZuosqY5DK/20mb01lDTr1HgZst6Q1UcEffghEBdE
 B9dlTZb1daJ6UvTp5Fw9qYd0obrbS4WwnfDIkAfAHia1y2Dj67N9FEug/oXMLdVe4NLG
 Rrh6/u5MnmwBg10Ng0zsKTjj2vd8vIFS9PXJZT9KxvUk92KHeXEtTelIYyk2NEtZo+vt
 0n4Uj/CwqodUi+yc2XtzCwzOBCDMhcyBmKcaTO0xsFpjVSURZ9kRTsMybGm7ajhsYLSU
 jtZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763919906; x=1764524706;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8Lp92mt8DEs+4Z3BFcQSxKPGzAOcDpLQADktLILshNQ=;
 b=R0vkOXr/1Ko3PEI8QLFXTUwnOXaj+waoLAPD3o+m4Gd+M1rLUShgoevJ2iYuSU55+8
 +82qU5xqXe+v2cmGS9OMZ2/x09tTBAS+cRDgGoitCRqGw14HZ9fHSdz4RKd4vOYvJO1F
 7VNolIfNdFy2lrqrGJipQtb44PWmQW2sZPLhL1HOxtBbHLqD838o7RZKvc/p9rEant7h
 J+NdoPX4POiyfvI4RBcosJUFSmdGQ787K1biMq130/uAKcsaLcOO2BAp9KRRUM6fFLe7
 TnDXUpuBqkfYmAs3ihtLyyfO8zeq2llcW/ivpo14KQdqpi2t6R+uuD3MY0b2SUlOWZ2C
 z/Yw==
X-Gm-Message-State: AOJu0YyRk9vlSuY1iD2sxR0XR/eMyoKGxd1Xhh4DSTKtRSdnZyVvyh91
 F+DATKRTwDd81qCvwkyN7E74ebh1/j3Aeh1tVJN/K6FxstKrNkMtvjioDKGTEz7mIQ3T6zhfPWQ
 7MkNF
X-Gm-Gg: ASbGncs6/C1HLerUe4Ddqs7imBZeQ6sfA3smoYTB1Z+pZCGpy3R+ZyH7JZtZ9ybmnz8
 1Dwi9Tmrj1cJFOw9/21wXloz3puizqhMRwKbidkrZn2LZwhKZh6w8TngN6MvHuYl1/kMyAQFoiO
 sCTLXJ69/wP5akt8cpHlm3NXHBCHkTwiNNCNmffdvVcDxePYmlHqe5DozyPiFlM4kq5Vnc1uhHw
 91ixIOLmRUGt34l0/Rus6FdHMjdLO8waviUunSM+FBEeLxROlpD342OCYVfZBGR1IeSTp4b0Aay
 vNeprYJlCm6s0GOR8CHe8krvXBoPz3tHYGLroD5nwa+UekFSnDDiDTC3bzpep4yVnhuE4s5vwcG
 BckNPOnRqoOis4F007kum3OTodQQ6zq176dSYvX3QzCSDu3+4eDpKcuPjym4+F0k9pPstaTf7eU
 i01IRBcA8xfDOsYOLXcYPaP+QStAuT77DjcYIktWZSV0/mzQUyQg==
X-Google-Smtp-Source: AGHT+IEwsaV/bvwvkO73aiXPp25x0Ra8CjTb5W8gjoHtNO2ZtEQzY/b+GMZmH6ewutJOlfqLIUNMCA==
X-Received: by 2002:a17:902:b786:b0:297:dfb5:5b90 with SMTP id
 d9443c01a7336-29b6bf35e90mr80267295ad.28.1763919906388; 
 Sun, 23 Nov 2025 09:45:06 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29b5b13b973sm112585985ad.39.2025.11.23.09.45.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Nov 2025 09:45:06 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v6 1/9] test: increase size of memzone name
Date: Sun, 23 Nov 2025 09:43:24 -0800
Message-ID: <20251123174503.20880-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251123174503.20880-1-stephen@networkplumber.org>
References: <20251110182209.104087-1-stephen@networkplumber.org>
 <20251123174503.20880-1-stephen@networkplumber.org>
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

