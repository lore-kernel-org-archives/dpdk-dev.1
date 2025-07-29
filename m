Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FBA5C87FC9
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Jul 2025 06:40:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BB8D940E03;
	Tue, 29 Jul 2025 08:40:04 +0200 (CEST)
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by mails.dpdk.org (Postfix) with ESMTP id C3F8A40668
 for <dev@dpdk.org>; Tue, 29 Jul 2025 08:40:03 +0200 (CEST)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-b321bd36a41so4431966a12.2
 for <dev@dpdk.org>; Mon, 28 Jul 2025 23:40:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=uetpeshawar-edu-pk.20230601.gappssmtp.com; s=20230601; t=1753771203;
 x=1754376003; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=srihcXYhJz2GOLDs1Net4X9VmFNIhWy+k2KGA8Fe/CM=;
 b=xHhS3zrQN6y3MHNEvGP5UK+n1x+W4xD57Lwa9CUIfUJsrgAmUA178tQBfsoLRtDJS/
 C+pjvrXA1P3oq/cGE/hdSRtt+aw6KNhj51NLdNDbwlrISGqJ3JncKoCxGtdQbwH0igLO
 YzYsrSfc6OLSstbC2wom3T4FqmHA+ARsBuN5hDvVkoK3PxUY++CLwZE/iEVwzG/TB/SU
 nQ5NrrWXwHelv+MmMFHf1SGNg4Pj9SrVl7/6RLNJHETIVmyrpEuNSaaEY1QKqwelQ+a5
 8lcAnraAYybaPDRsySkCY7FJyJTLRY7lqMyT/xVlWQz0stA7WOJ9wi36k6czH8CkBRlh
 hdOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753771203; x=1754376003;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=srihcXYhJz2GOLDs1Net4X9VmFNIhWy+k2KGA8Fe/CM=;
 b=fwkF0Kv5UcOwkn+XQwTmw+EYphrOhStgiPqwr2OZW/0V94qJtSj9KxhBtiyMs7QOyP
 A0KlMl1hXRs7Zc8nUAFuBM2jEhHU+uGXUinEN68ROPLPbx4ukPcR1uOKxZz3/a21e/aJ
 DdIE5zNR2jxa7cPNuuiJJ7z4tKqarIOJc98odus3IkLg8OX4t3rVSwBdehoxccV/rj0Z
 lwPSo/iVY0J651WRVdn7gHUGhxVjDVQCLM6IuNFefynBnZU/VgZUFg8fTWYjsf1o5sIm
 /t53rYFAc9mMtoWFPc4rhBBuxgfufQUyDNwt26fReEECy7qQQvzKoZyAesz/X6VAJtIt
 4+PA==
X-Gm-Message-State: AOJu0YxP7W6ObCaYiadFFP/cgEkXt8NAHGUJiad9/REfg0wvu3N5Bn4V
 jram28QN8i64DWpUg8/yVnkxvNarYg3UN3mOyxM3H31nzf3AwyvM0jRa/Eq6e6geYos=
X-Gm-Gg: ASbGnctKPZEQqGoPxcZzzN0yu6v8tUmd61gz7vaWsWpdUqDVpLuo3tnloR32mrt40OD
 YFW2HRf/gVyKbMyx8tD/cIF/Wzkm52U8qdX0z8+1IrHcd78D5d/NOoR3irCnOxYqJkj/ON/fmhX
 ZoHVOW8PxAwTlxqutPTCHpImP3u+b0A+NYCrJvKPY6K5K3e2G8QbpRAEe9BEn+3ql5KjjEGEbDZ
 SkrsWVMX8ZxGWHWmLKLjxA4YARb020Q6WIFX1E3S5kCa+pSWoW67GBoeX+7oz2KuFr7XffwRuzQ
 vFRAn94302dxypbrRtFVGZKPdaNuIVjagtTDm1s3qj1UooPHx2T151R2WS3EOtMeVJmAqcfpgtC
 aNLwGtOToMs1sS6CrhjI9h3AqhGHmoFZMYOczH5yVuCFZ9z3Z
X-Google-Smtp-Source: AGHT+IFiGlDnG00ViszKgy2y13Dvzw893KYaCLUemkkj4Z0Bz1Ead/dOQtF3kuH5/q/tOrDVucxBJQ==
X-Received: by 2002:a05:6a20:9147:b0:234:216b:cf98 with SMTP id
 adf61e73a8af0-23d7021bb59mr25542290637.35.1753771202810; 
 Mon, 28 Jul 2025 23:40:02 -0700 (PDT)
Received: from localhost.localdomain ([64.62.143.197])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7640b8b2868sm6640791b3a.128.2025.07.28.23.40.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Jul 2025 23:40:02 -0700 (PDT)
From: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
To: stephen@networkplumber.org, thomas@monjalon.net, ferruh.yigit@amd.com,
 andrew.rybchenko@oktetlabs.ru
Cc: dev@dpdk.org, stable@dpdk.org,
 Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
Subject: [PATCH] [PATCH v5] app/testpmd: fix segfault in secondary process by
 monitoring primary
Date: Tue, 29 Jul 2025 02:39:19 -0400
Message-ID: <20250729063919.3554143-3-14pwcse1224@uetpeshawar.edu.pk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250729063919.3554143-1-14pwcse1224@uetpeshawar.edu.pk>
References: <20250725125526.2340233-1-14pwcse1224@uetpeshawar.edu.pk>
 <20250729063919.3554143-1-14pwcse1224@uetpeshawar.edu.pk>
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

In secondary processes, directly accessing 'dev->data->dev_private' can
cause a segmentation fault if the primary process has exited or if the
shared memory is no longer accessible. If a secondary process attempts
to query device information (e.g., via testpmd), a NULL dereference
may occur due to missing shared data.

The secondary process not only crashes on device close but also segfaults
when executing commands like "show device info all" after the primary has
exited.

This patch adds a mechanism in testpmd to monitor the primary process from the
secondary using `rte_eal_primary_proc_alive()`, and exits secondary process
when primary has exited.

Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: Khadem Ullah <14pwcse1224@uetpeshawar.edu.pk>
---
 app/test-pmd/testpmd.c  | 49 +++++++++++++++++++++++++++++++++++++----
 lib/ethdev/rte_ethdev.c |  8 ++++++-
 2 files changed, 52 insertions(+), 5 deletions(-)

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index bb88555328..ad780ba754 100644
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
@@ -2281,7 +2283,7 @@ run_pkt_fwd_on_lcore(struct fwd_lcore *fc, packet_fwd_t pkt_fwd)
 			fc->total_cycles += tsc - prev_tsc;
 			prev_tsc = tsc;
 		}
-	} while (! fc->stopped);
+	} while (!fc->stopped && !f_quit);
 }
 
 static int
@@ -4332,6 +4334,43 @@ signal_handler(int signum __rte_unused)
 	prompt_exit();
 }
 
+
+/* Alarm signal handler, used to check that primary process */
+static void
+monitor_primary(void *arg __rte_unused)
+{
+	if (rte_eal_primary_proc_alive(NULL)) {
+		rte_eal_alarm_set(MONITOR_INTERVAL, monitor_primary, NULL);
+	} else {
+		fprintf(stderr,
+			"Primary process is no longer active, exiting...\n");
+		f_quit = 1;
+		prompt_exit();
+	}
+}
+
+/* Setup handler to check when primary exits. */
+static void
+enable_primary_monitor(void)
+{
+	int ret;
+
+	/* Once primary exits, so will pdump. */
+	ret = rte_eal_alarm_set(MONITOR_INTERVAL, monitor_primary, NULL);
+	if (ret < 0)
+		fprintf(stderr, "Fail to enable monitor:%d\n", ret);
+}
+
+static void
+disable_primary_monitor(void)
+{
+	int ret;
+
+	ret = rte_eal_alarm_cancel(monitor_primary, NULL);
+	if (ret < 0)
+		fprintf(stderr, "Fail to disable monitor:%d\n", ret);
+}
+
 int
 main(int argc, char** argv)
 {
@@ -4362,7 +4401,8 @@ main(int argc, char** argv)
 	if (diag < 0)
 		rte_exit(EXIT_FAILURE, "Cannot init EAL: %s\n",
 			 rte_strerror(rte_errno));
-
+	if (rte_eal_process_type() == RTE_PROC_SECONDARY)
+		enable_primary_monitor();
 	/* allocate port structures, and init them */
 	init_port();
 
@@ -4571,7 +4611,8 @@ main(int argc, char** argv)
 	if (ret != 0)
 		rte_exit(EXIT_FAILURE, "Cannot unregister for ethdev events");
 
-
+	if (rte_eal_process_type() == RTE_PROC_SECONDARY)
+		disable_primary_monitor();
 	ret = rte_eal_cleanup();
 	if (ret != 0)
 		rte_exit(EXIT_FAILURE,
diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index dd7c00bc94..5c73397164 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -4079,6 +4079,13 @@ rte_eth_dev_info_get(uint16_t port_id, struct rte_eth_dev_info *dev_info)
 
 	if (dev->dev_ops->dev_infos_get == NULL)
 		return -ENOTSUP;
+	if (rte_eal_process_type() == RTE_PROC_SECONDARY &&
+		unlikely(rte_mem_virt2phy(dev->data->dev_private) == RTE_BAD_PHYS_ADDR)) {
+			RTE_ETHDEV_LOG_LINE(ERR,
+			"Secondary: dev_private not accessible (primary exited?)");
+			rte_errno = ENODEV;
+			return -rte_errno;
+	}
 	diag = dev->dev_ops->dev_infos_get(dev, dev_info);
 	if (diag != 0) {
 		/* Cleanup already filled in device information */
@@ -4307,7 +4314,6 @@ rte_eth_macaddr_get(uint16_t port_id, struct rte_ether_addr *mac_addr)
 			port_id);
 		return -EINVAL;
 	}
-
 	rte_ether_addr_copy(&dev->data->mac_addrs[0], mac_addr);
 
 	rte_eth_trace_macaddr_get(port_id, mac_addr);
-- 
2.43.0

