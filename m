Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C2A7C87FC9
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Jul 2025 06:08:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78CDE40668;
	Wed, 30 Jul 2025 08:08:34 +0200 (CEST)
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com
 [209.85.216.42]) by mails.dpdk.org (Postfix) with ESMTP id A22934025E
 for <dev@dpdk.org>; Wed, 30 Jul 2025 08:08:33 +0200 (CEST)
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-313bb9b2f5bso6157934a91.3
 for <dev@dpdk.org>; Tue, 29 Jul 2025 23:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1753855712;
 x=1754460512; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YBNj2bNPMJgIgM9w/R4GiFPk1jCz/10zA/Og6gIlmxw=;
 b=YWJv6+tyGEh5wl+ntitFuSgflK1RhCBJZHy6V9vDqDpexZBG5FxY5lh5GGTvN3lbNl
 ldfiewzjJIBkkuO2Bt6jNhMpcKcBO/Y4tXcKWAzI+3qaeyrwXnjGsePrLtH4EBPCo2kx
 0k9DQxHhtYTL6WPYB23TYXvdqFydwgp7zJjnl3NdakkIFjgXcTyrtWp12jM393mC0cax
 gJbGvvlJJDo6Uav39KvaXZMeV4Xb6Py1XRUFuj8PLBNDTjpJsrs6zAkPg1SqnR2Kc9AE
 CEVtSAzv4Ju/tW2CfANMpNkctXnXlbfeDE9RAEYhb8hoMop2UbwKs3WRvobbrrrt+HB5
 7AYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753855712; x=1754460512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YBNj2bNPMJgIgM9w/R4GiFPk1jCz/10zA/Og6gIlmxw=;
 b=uehIKJl/K96huqs9kstle54AzxK7Vy0qG5ep08kh6ihbcMG6M+/NPx8jGacAfq+27H
 +nEIy8VzO0HLMacqkYSLcIyVYTizE3p4117/bBIVl6sf+HvxRCQolWZHU/7dLcTMxApw
 QezRx3WazAYKVmnzW0KqAOHZCHyZrsawndIXpELOzLr3qaFjuKvJbjRCNyv9MoLEagZO
 DVf8EGRY7GN+gUiMgsqJPexs68S3gep7SFHKgkhQkxwRecDPdQLnWy2uivkV6qvrEqqY
 y11psI4illFOedK/G/KKxUiKrl6pxuPjxsuoR9zUf1yNEdMrO0Wq8kWNl94HEeOe1Wnu
 CTjw==
X-Gm-Message-State: AOJu0YxIvSVfEuizRYUsqGE9gE4IIj2f4oekqMLATa+3Zqio1xRDTkgM
 mxbkFrmyOdVW2NPy3AMrJKUQNnjdAcJLS9FCdN5/RcEG+ras1qn2MmRgB7FV07WVgmI=
X-Gm-Gg: ASbGncsDljFfT0iVmvihkEcm9gpjPG5hpP0TpuZo2oK2N/WsZK95/NDQeT0i0gbOEv9
 xMflSx725ddHbOmopkfWKMNIjtjuVb7RFAhNc6MJgSb4eOmlCOjrp7JaoYZ//7nrh4SIhYzjvUH
 0dykPKpAeZPoEr1EFh15JaOmzEy4JvaSYS8ipzrcI3IQ6hcRq7vV0I07oQZnYq/yz/TccW9RxSM
 1JGe4KFNJyRn/4YRoPYI49vehkSWb0AEhL5XBGjOMevvaI6yBmD9SblBkcj6Z7P4LZXNb5Yc5cl
 unRKsUc2RfFMq49ViIipd8gvxIf4eEsR998BlZx3ISOKH/jxBYFshfiKQSq7hps3apu+c9P20ZI
 SsrMe7xTM6jHEjQloE9bj/FF/opoGZixBvw3V7hRAV4aKJT6x
X-Google-Smtp-Source: AGHT+IGvQte6WYctPSQdOhgCIuYziLVPVnW6T4dqNf1BLvNRBNVtzi+J94BhGzJSIW5WNYxNWNk28Q==
X-Received: by 2002:a17:90b:1e0c:b0:311:abba:53d2 with SMTP id
 98e67ed59e1d1-31f5de42527mr3212244a91.17.1753855712431; 
 Tue, 29 Jul 2025 23:08:32 -0700 (PDT)
Received: from localhost.localdomain ([64.62.143.197])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3f7f568eabsm8537314a12.9.2025.07.29.23.08.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 23:08:32 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: stephen@networkplumber.org, thomas@monjalon.net, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru
Cc: dev@dpdk.org, stable@dpdk.org,
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Subject: [PATCH v6] app/testpmd: monitor state of primary process when using
 secondary
Date: Wed, 30 Jul 2025 02:08:18 -0400
Message-ID: <20250730060818.141022-1-14pwcse1224@uetpeshawar.edu.pk>
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

