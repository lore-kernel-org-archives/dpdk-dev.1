Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D4CECEACEF
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 17:53:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 08ADF402B2;
	Mon, 17 Nov 2025 18:53:39 +0100 (CET)
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com
 [209.85.215.181])
 by mails.dpdk.org (Postfix) with ESMTP id CBD1F40262
 for <dev@dpdk.org>; Mon, 17 Nov 2025 18:53:37 +0100 (CET)
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-bb2447d11ceso2675061a12.0
 for <dev@dpdk.org>; Mon, 17 Nov 2025 09:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1763402017;
 x=1764006817; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8Lp92mt8DEs+4Z3BFcQSxKPGzAOcDpLQADktLILshNQ=;
 b=HX2jS7zRV8m2JyB2FuQ/pNJs8ChjeI9GDnZC3x3LFXTLhgr/oPRE4tnBHNXgnYx4jN
 eyuXHb6Y3jkwRE2qVAyN2omteqwPHogVnEIua0Zg7GMbMbehzHvutWWYVZbqIKXfVd9Y
 ArnI2blAKP+oF2GuFm/4PevYc8Pr/DMjuNdPqyl2Q1f7Q1OMwKHCwLhfsMOzHU6ytjUo
 fAhK4Uxa8xLFM6uPhpY2nWhgCZcPimQ3KOvrQoywU3wk3lTNX5hJxnEjpSkzMM/mP+Hh
 zag4FfY9vRR7IsUbSYAd9RvTn0xfjZxWRg8kCVfNFnbg+Y5jTdtm8rbFYAwU95DKPExg
 3t2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763402017; x=1764006817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8Lp92mt8DEs+4Z3BFcQSxKPGzAOcDpLQADktLILshNQ=;
 b=vMFHPNYdQups9EiCqoWD7cEZ5VpdkNZ70Jj2m0hKr1BRyG4ipiRH3jfHVpFaVO14a7
 NgIl87V0NH4FcG58W2TkzMx+ssAqjjzGv4au7A/6g6IFlHo+l2T1RfCprVt4fzp65NOB
 CBE1xsmVE64wJnDWboIjaI0FoR5Gw/i0kJdDxH7g5OkRf/0p11Ti5vykjS96R/om0sAv
 UrGp70G5d+fM9bi/fxHF2uPaaOdgAR8FrIoeCfgmDmZB+LBrHUam16HNQzcXjrZXxDcD
 xZ92i5ZaHalzblXv8FDoPXILncJAYUik6VLgL183PGGx8AkORRtvE8BJ7oFY5zl5VXVD
 WwwA==
X-Gm-Message-State: AOJu0Yy23DL4SifKukCpzvTqf8l3+JK5RoMYsVNuLFKdDhZ7KhpetrWC
 E+zzHcjU1Q1T40cQO5OAzCmjhpDyPUlJywFfYA2gaeCOdnBRyAZ62K5LY3BS9iyyOK0lk8IpcTE
 /Pp+c
X-Gm-Gg: ASbGnctwzgGJIWixq1bAro0IpNLE0rn485D92jmeuTTd7jxPUKzrDE7NUmfq0p0fV2r
 MMONLCz4afkIomz0gnP7KBuYEnpjaG7iAYVmLOMsR03kQP+/BKGM8rrre8lzfvMr9d0anHAnGzz
 HnuCpcgw1hAQw4hfP+TcOGhzlBakj0RMESdozyob131nqoLpAsXBPrtYwbx98KQuWr5W3tu5+Qz
 l9avQ8lH8O26wf7vVM7Cx4TpNIcPjpF+CVxT1jqAhb1jrL56ZvKZ8zDxkM+sWZ6IjO7WifgO1DV
 Ct5e0Lt7Vr0fuv8/mywbPSHNY8+JrhvXJtjpXQ1Nu0baH4LxZKASz8xZ7KdWwTdJ5S9I2dpfAv7
 iS6M1ApH9UWLPdwUzccZVwKROY0wgDutBWkDyBqPNnc9ctrlcNfgNv4Evh7YZ9eK41NwqVpsVhk
 xPztHRIIf24Nk1NufflulKwGFp9US4wOW0NI5JNHg+AZI8FTAXOA==
X-Google-Smtp-Source: AGHT+IGkD2ggrN8Y62hP2dGETxovr9DHe/I/KXxkD7Vxb8R6FRVn6gl6yTE7/8ycxsohP/i86bmzOw==
X-Received: by 2002:a05:7300:103:b0:2a4:3592:c5fa with SMTP id
 5a478bee46e88-2a4abaa2890mr3448310eec.11.1763402016551; 
 Mon, 17 Nov 2025 09:53:36 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2a49d9ead79sm63457494eec.1.2025.11.17.09.53.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 09:53:36 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v3 1/6] test: increase size of memzone name
Date: Mon, 17 Nov 2025 09:52:08 -0800
Message-ID: <20251117175332.14014-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251117175332.14014-1-stephen@networkplumber.org>
References: <20251115193409.99740-1-stephen@networkplumber.org>
 <20251117175332.14014-1-stephen@networkplumber.org>
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

