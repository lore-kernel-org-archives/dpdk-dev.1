Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1A4C87FCF
	for <dpdk-dev@archiver.kernel.org>; Mon,  4 Aug 2025 11:33:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA5E44025D;
	Mon,  4 Aug 2025 13:33:41 +0200 (CEST)
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by mails.dpdk.org (Postfix) with ESMTP id C7A5F400D5
 for <dev@dpdk.org>; Mon,  4 Aug 2025 13:33:39 +0200 (CEST)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-73c17c770a7so3441588b3a.2
 for <dev@dpdk.org>; Mon, 04 Aug 2025 04:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1754307219;
 x=1754912019; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xYuhzGQnr5SDhA5eZr5G6CXkJMX1AUcNto63jaROxXM=;
 b=fPLXwacwoRQtASFssgfSOpN4R0ytXkzzVMVLLKNHZLrK4MBUZ+F7R5+E1MtE9adW7m
 oZjLJ/bz/9hXpiKKroP+rq6mdtEPhx8ZMZwK91S2I8Uf/z/d3GDoQy1+kVhzNC0bFAGR
 /8/StxsWBBL4lDNP7OH9WMgZ7W7UjNxnLh9g05fT7Zv9kIv4TI28d6tKyyyCZbcAmdLX
 sFFVfmE6qez2F+IX/5YU56yIMLlhIHE0H/ggy4MJ/itEfBP+60nvvHrBb8Ii0I2kjxwr
 dDSkSTutUF/t8ltFD66PQkrpveZW5u+NTHmN2PP2FrLX1HpCjTqFUQtl9R/hnZAO1LJ7
 m/IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754307219; x=1754912019;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xYuhzGQnr5SDhA5eZr5G6CXkJMX1AUcNto63jaROxXM=;
 b=LzYVv4mVvdUOTbIgezSMOKcB+fQG4rVAzUmiYDFSu7VN4wqK0Qv0cgT8o56QiSU/8Q
 BYx9mhEUNTdsD3OyzF2IydDck5UqTsAYgAbI97SbZZQTynb0xnx4iaW24tds2jRAjy6F
 awXPnPhLsBkvcI9zGPtvrd5cEi6/0WeUAiaWQ5OdCaftHX5cDVD/+zBfx8mJ/GJuNfvb
 KyynTcE9cMTBbWuZ8DROZ0GwnHBnSAkMnr0lNWGICXJ2eAse045wDWMBCKwTOR6l7bVx
 brjr8cqBrhn7g9/AhOPcJZ1IBGI4c8wKkz141B381th27ZdZAZUGfxdC2UuyMPStLlEF
 hXeA==
X-Gm-Message-State: AOJu0YyPRI6nolLY1dTZLS2aY51dwkpu4z4fr4j/ZXgVIrTn5EGtybFs
 /ljd+JvP6dwTy5pabiSSCbl9RF9K1fxfxRsyKjyUkxMkYAMkQx4MOO7xkgbIH/PrY4g=
X-Gm-Gg: ASbGncufKWLhDYNO2jJaGhK5lFmZA1nQqX7+Ll1T0ULc0AEnxYpYvamga+ueblwtYh8
 1OzK247EBMuaKqZU/lnqaCVnxFW5MAL5/C7bsNvPddbQbErW+lRWb7Fge1HTCzpYWQ0F97bvNlS
 +ydZtytD+GX0WeP4fd4Wgso8tJhaU3k4fZ13VynQnMDBVEO+h5ZGEYghGaZBYI+P6ZUtJ6hyu+1
 YglRiQizMZD8GbYflAXUN/gXUTUOInE5EI8AbaO3DGIv0m84kXwhMUna3AddqBHw+Po0FlhDezB
 rl9GxlA+5VbfJey/mF11G3Z8VD8hs5LQzGJXq1FZqXISPZ58PUlrJmdB8F+SVYmW1GcpnxRuc0c
 3TsJiZjvUlKUj04VshCRVIDdbrMyoUesyTmMt9+v7Zzs2+8xK
X-Google-Smtp-Source: AGHT+IGAE6myQdY9iKRUvWAVkRF1mdAQuBqA1pfMihpo3bjp8erMQQvx6Dn3AFCqYahj2iULS2Jmqw==
X-Received: by 2002:a05:6a20:3d8f:b0:232:6630:bca4 with SMTP id
 adf61e73a8af0-23df8fcd255mr13766542637.15.1754307218793; 
 Mon, 04 Aug 2025 04:33:38 -0700 (PDT)
Received: from localhost.localdomain ([64.62.143.197])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-76bccfd2046sm10205228b3a.106.2025.08.04.04.33.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 04:33:38 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: stephen@networkplumber.org, thomas@monjalon.net, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru
Cc: dev@dpdk.org, stable@dpdk.org,
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Subject: [PATCH v7] app/testpmd: monitor state of primary process when using
 secondary
Date: Mon,  4 Aug 2025 07:33:22 -0400
Message-ID: <20250804113322.53650-1-14pwcse1224@uetpeshawar.edu.pk>
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
 app/test-pmd/testpmd.c | 47 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+), 1 deletion(-)

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index bb88555328..b7affa6da9 100644
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
@@ -4332,6 +4334,38 @@ signal_handler(int signum __rte_unused)
 	prompt_exit();
 }
 
+#ifndef RTE_EXEC_ENV_WINDOWS
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
+#endif
+
 int
 main(int argc, char** argv)
 {
@@ -4363,6 +4397,12 @@ main(int argc, char** argv)
 		rte_exit(EXIT_FAILURE, "Cannot init EAL: %s\n",
 			 rte_strerror(rte_errno));
 
+#ifndef RTE_EXEC_ENV_WINDOWS
+	if (rte_eal_process_type() == RTE_PROC_SECONDARY &&
+	    enable_primary_monitor() < 0)
+		rte_exit(EXIT_FAILURE, "Cannot setup primary monitor");
+#endif
+
 	/* allocate port structures, and init them */
 	init_port();
 
@@ -4556,6 +4596,11 @@ main(int argc, char** argv)
 		}
 	}
 
+#ifndef RTE_EXEC_ENV_WINDOWS
+	if (rte_eal_process_type() == RTE_PROC_SECONDARY)
+		disable_primary_monitor();
+#endif
+
 	pmd_test_exit();
 
 #ifdef RTE_LIB_PDUMP
-- 
2.43.0

