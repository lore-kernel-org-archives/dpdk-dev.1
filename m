Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4EAC87FC9
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Jul 2025 05:57:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 460B240DD5;
	Wed, 30 Jul 2025 07:56:59 +0200 (CEST)
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com
 [209.85.215.171])
 by mails.dpdk.org (Postfix) with ESMTP id F1C2940668
 for <dev@dpdk.org>; Wed, 30 Jul 2025 07:56:57 +0200 (CEST)
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-b390d09e957so6809097a12.1
 for <dev@dpdk.org>; Tue, 29 Jul 2025 22:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1753855017;
 x=1754459817; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YBNj2bNPMJgIgM9w/R4GiFPk1jCz/10zA/Og6gIlmxw=;
 b=gBNu9VorPdBcGoQr2GIGsxgbsCzajP8Ye52nFzYeubw0+iHPBHR/roe1YR6B6q1/It
 Bs078DkcG8yFef7MaW8g7WC1M1NAWfUXhAnLmRywIO+WCjg8AJH4s4zy9dHHi51Ll9JQ
 yrwYEn8MKODkRLhOzvA7vF4PaZ7SvEbqg51lno/YXw1w8xiMdaqAHevRWnJ3cD+Tjgzl
 SzYr8sbVrSNqgXNpAo9o8XEvaqBGT2fSPhOOB3zqokkFCtgO9iL9o5gjAIJ1VdfWSXeg
 p786WHlY75uwQ3HDqF6ubqFcC63Z4EVcTmUXMzykVrwFJMIx1oYFFLuRdqCJ8S4et7rB
 E0ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753855017; x=1754459817;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YBNj2bNPMJgIgM9w/R4GiFPk1jCz/10zA/Og6gIlmxw=;
 b=CoHWoFqdB+NyEqS6y1AUOUeDEKhmzgcj6Lbg12AUgUX8zCXoeTT4KgWTrKhr1fHcCG
 0hds+9OXdC/Wl1pSvR3eiZszjZAGJkcgEtm1q+98jIoYWnSP0Djen80NJ76vX7eTJzHz
 dDTG2jjxg222pOYfFWYfeTfQ3CTGs6peWxcGydCGJGNBd5dovsjmCOjzm6/lIo5l87PM
 z0xkxRVMx0/0KmsZFgCgM6sioVd0SIDSQHSIL4gPjQybDFR9hflTTcLyBrNNijn4FGjM
 WHVUT0WhPCwT3TOuSoPGrFa0Af6pQpNAZ4m/4UeGJYrIkI3zsqC0Ul5NA5eIXEzfdZ8R
 5a/g==
X-Gm-Message-State: AOJu0YxDOnJSeBkR077GZ5ToRwZc1Suxp6kp1lgsXWCWzwWCsctrtDjl
 aUqDBD9aNBnQX5nqPWU9jshPIeblbLDowtiLL0er0zklNaGaqmp+1pJaQSCBALMxy1u1YMwfupU
 5LHaEGlqrug==
X-Gm-Gg: ASbGnctgrNNHWuZLi2h0Mc4sf1SOlgHJ4l0bUrosw9JWFMONrnp9OK21jrDdL/Fjbj8
 u058RIE6nwAy305J9v51TCO2ceFpObc9Ie9Nys1W9yLjBpdmnrC8zmgMsHtxRbqIuT6Hs77nkv7
 UlICCj4gXtXMeLOtAY6XejyPu1qxCZQhxNH3VpbIjlX+pY5W3B2OPBqZ38bhnjRODBo9KPPkJjC
 4W3ywnLbn3NKF/+eov/WmJznS1vEywd/IdzTTC7ssHyXkRZHsDA/OGA3XpxFKvVme8ksSzRZ0dv
 JzXe/17LHuSAj0kDB3T4dbPO4q39hHOvyzEI4Ku+rhRaIdUj8yFQPoF//U6XJnBf+08r91JFhKa
 SMrnoS4gF4QSgri6WZltDbMNoXsK3HYZCxhHkAiVBhAMtsABC
X-Google-Smtp-Source: AGHT+IH1OL7quBAlnQjEDl75e6O/HTULh/gmsFZHQ0nicbjjM8tcmxvU4G3kHhgUKQn7HysBdSONSg==
X-Received: by 2002:a17:90b:5623:b0:31c:23f2:d2ae with SMTP id
 98e67ed59e1d1-31f5de41b29mr3556369a91.15.1753855016852; 
 Tue, 29 Jul 2025 22:56:56 -0700 (PDT)
Received: from localhost.localdomain ([64.62.143.197])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31f63da8208sm929946a91.2.2025.07.29.22.56.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 22:56:56 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: stephen@networkplumber.org, thomas@monjalon.net, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru
Cc: dev@dpdk.org, stable@dpdk.org,
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Subject: [PATCH] app/testpmd: monitor state of primary process when using
 secondary
Date: Wed, 30 Jul 2025 01:56:41 -0400
Message-ID: <20250730055641.138187-1-14pwcse1224@uetpeshawar.edu.pk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250729063919.3554143-3-14pwcse1224@uetpeshawar.edu.pk>
References: <20250729063919.3554143-3-14pwcse1224@uetpeshawar.edu.pk>
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

In secondary processes, accessing device after primary has exited
will cause crash.

This patch adds a mechanism in testpmd to monitor the primary process
from the secondary process.
When primary process exits it forces secondary to exit avoiding
issues from cleanup logic.

Fixes: a550baf24af9 ('app/testpmd: support multi-process')
Cc: stable@dpdk.org

Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-pmd/testpmd.c | 41 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+), 1 deletion(-)

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index bb88555328..7c22046efb 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -101,13 +101,15 @@
 uint16_t verbose_level = 0; /**< Silent by default. */
 int testpmd_logtype; /**< Log type for testpmd logs */
 
+/* Maximum delay for exiting after primary process. */
+#define MONITOR_INTERVAL (500 * 1000)
+
 /* use main core for command line ? */
 uint8_t interactive = 0;
 uint8_t auto_start = 0;
 uint8_t tx_first;
 char cmdline_filename[PATH_MAX] = {0};
 bool echo_cmdline_file;
-
 /*
  * NUMA support configuration.
  * When set, the NUMA support attempts to dispatch the allocation of the
@@ -4332,6 +4334,36 @@ signal_handler(int signum __rte_unused)
 	prompt_exit();
 }
 
+/* Alarm signal handler, used to check that primary process */
+static void
+monitor_primary(void *arg __rte_unused)
+{
+	if (rte_eal_primary_proc_alive(NULL)) {
+		rte_eal_alarm_set(MONITOR_INTERVAL, monitor_primary, NULL);
+	} else {
+		/*
+		 * If primary process exits, then all the device information
+		 * is no longer valid. Calling any cleanup code is going to
+		 * run into use after free.
+		 */
+		fprintf(stderr, "\nPrimary process is no longer active, exiting...\n");
+		exit(EXIT_FAILURE);
+	}
+}
+
+/* Setup handler to check when primary exits. */
+static int
+enable_primary_monitor(void)
+{
+	return rte_eal_alarm_set(MONITOR_INTERVAL, monitor_primary, NULL);
+}
+
+static void
+disable_primary_monitor(void)
+{
+	rte_eal_alarm_cancel(monitor_primary, NULL);
+}
+
 int
 main(int argc, char** argv)
 {
@@ -4363,6 +4395,10 @@ main(int argc, char** argv)
 		rte_exit(EXIT_FAILURE, "Cannot init EAL: %s\n",
 			 rte_strerror(rte_errno));
 
+	if (rte_eal_process_type() == RTE_PROC_SECONDARY &&
+	    enable_primary_monitor() < 0)
+		rte_exit(EXIT_FAILURE, "Cannot setup primary monitor");
+
 	/* allocate port structures, and init them */
 	init_port();
 
@@ -4556,6 +4592,9 @@ main(int argc, char** argv)
 		}
 	}
 
+	if (rte_eal_process_type() == RTE_PROC_SECONDARY)
+		disable_primary_monitor();
+
 	pmd_test_exit();
 
 #ifdef RTE_LIB_PDUMP
-- 
2.43.0

